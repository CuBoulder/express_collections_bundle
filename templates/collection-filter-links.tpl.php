<div class="collection-filter-links-wrapper collection-filter-links-multiple">
  <h3 class="collection-filter-label" aria-controls="collection-<?php print $collection_id; ?>-filter-links" aria-expanded="false"><span><i class="fa fa-plus" aria-hidden="true"></i> <?php print $label; ?></span></h3>
  <div class="collection-filter-links" id="collection-<?php print $collection_id; ?>-filter-links">
    <button data-collection="collection-<?php print $collection_id; ?>" class="collection-filter-clear">All</button>
    <?php foreach ($collection_filter_terms as $term): ?>
      <button data-collection="collection-<?php print $collection_id; ?>" data-collection-category="<?php print _express_collections_bundle_clean_string($term->name); ?>"><?php print $term->name; ?></button>
    <?php endforeach; ?>
  </div>
</div>
