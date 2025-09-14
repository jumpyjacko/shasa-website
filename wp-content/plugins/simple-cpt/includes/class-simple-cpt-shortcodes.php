<?php
class Simple_Cpt_Shortcodes {

    public function __construct() {
        add_shortcode('album_filter', [$this, 'album_filter_shortcode']);
    }

    public function album_filter_shortcode($atts) {
        $atts = shortcode_atts([
            'category' => '',
        ], $atts, 'album_filter');

        $args = [
            'post_type'      => 'album',
            'posts_per_page' => -1,
        ];

        if (!empty($_GET['album_cat'])) {
            $args['tax_query'] = [
                [
                    'taxonomy' => 'category',
                    'field'    => 'slug',
                    'terms'    => sanitize_text_field($_GET['album_cat']),
                ],
            ];
        }

        $query = new WP_Query($args);

        ob_start();

        // Dropdown filter
        $categories = get_terms(['taxonomy' => 'category', 'hide_empty' => true]);
        if ($categories) {
            echo '<form method="get">';
            echo '<select name="album_cat" onchange="this.form.submit()">';
            echo '<option value="">All Albums</option>';
            foreach ($categories as $cat) {
                $selected = (isset($_GET['album_cat']) && $_GET['album_cat'] === $cat->slug) ? 'selected' : '';
                echo '<option value="' . esc_attr($cat->slug) . '" ' . $selected . '>' . esc_html($cat->name) . '</option>';
            }
            echo '</select>';
            echo '</form>';
        }

        // Album loop
        if ($query->have_posts()) {
            echo '<div class="album-grid">';
            while ($query->have_posts()) {
                $query->the_post();
                echo '<div class="album-card">';
                if (has_post_thumbnail()) {
                    echo '<a href="' . get_permalink() . '">';
                    the_post_thumbnail('medium');
                    echo '</a>';
                }
                echo '<h3><a href="' . get_permalink() . '">' . get_the_title() . '</a></h3>';
                echo '<p>' . get_the_excerpt() . '</p>';
                echo '</div>';
            }
            echo '</div>';
        } else {
            echo '<p>No albums found.</p>';
        }

        wp_reset_postdata();
        return ob_get_clean();
    }
}
