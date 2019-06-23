paginationTemplate = "
<div style='margin: 0px;'>
  <ul class='pagination'>
    <li class='page-item' ng-class='{disabled: getCurrentPage() <= 0}'>
      <a href='' class='page-link' ng-click='stepPage(-numberOfPages)'>{{getPaginatorLabels().first}}</a>
    </li>

    <li class='page-item' ng-show='showSectioning()' ng-class='{disabled: getCurrentPage() <= 0}'>
      <a href='' class='page-link' ng-click='jumpBack()'>{{getPaginatorLabels().jumpBack}}</a>
    </li>

    <li class='page-item' ng-class='{disabled: getCurrentPage() <= 0}'>
      <a href='' class='page-link' ng-click='stepPage(-1)'>{{getPaginatorLabels().stepBack}}</a>
    </li>

    <li class='page-item' ng-class='{active: getCurrentPage() == page}' ng-repeat='page in pageSequence.data'>
      <a href='' class='page-link' ng-click='goToPage(page)' ng-bind='page + 1'></a>
    </li>

    <li class='page-item' ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'>
      <a href='' class='page-link' ng-click='stepPage(1)'>{{getPaginatorLabels().stepAhead}}</a>
    </li>

    <li class='page-item' ng-show='showSectioning()' ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'>
      <a href='' class='page-link' ng-click='jumpAhead()'>{{getPaginatorLabels().jumpAhead}}</a>
    </li>

    <li class='page-item' ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'>
      <a href='' class='page-link' ng-click='stepPage(numberOfPages)'>{{getPaginatorLabels().last}}</a>
    </li>
  </ul>
</div>"
