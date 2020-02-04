Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476C0152349
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBDXmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 18:42:14 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8773 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgBDXlV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 18:41:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3a01070000>; Tue, 04 Feb 2020 15:40:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 15:41:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 15:41:19 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 23:41:18 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 23:41:18 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3a011e0000>; Tue, 04 Feb 2020 15:41:18 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 00/12] mm/gup: track FOLL_PIN pages
Date:   Tue, 4 Feb 2020 15:41:05 -0800
Message-ID: <20200204234117.2974687-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580859655; bh=SerRmArPZCX0Ib3dFIlBTJEtpu68p9opHJ6UlhBBIjA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=lV5VFbmYCWujBf0UXRtyEk8TnmsXoFkF0F1UiBuyQ9nMSCTY1Xrywj+bjfJNDgf/Q
         qvsYeCkopv9SIrOxW5mnNm/WnvICACvZ3mjzfQ1VuxxWOMKcFOPtJu4/wfYQGyczS+
         It1/quzbGLH7S3IddoDnt2SJURKwSN4IcCDPaqPbJ4rMh/G6lFsjB++bsa0CHRNofy
         suc8PGodR9XVMjVGnt7eEdMK3ugMaaeerRWddHSBX0aFNCghSf3yzx87BgFST4O6hH
         Tep/brUZbtKTvUwngCEeX8HEavrISVnF3qnawWsI4SPAa01hZeY4I4IJ+shoz5jeYe
         w2GxbvujPI4Jw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here's an update after the latest round of reviews from Kirill and Jan.

There is a git repo and branch, for convenience in reviewing:

    git@github.com:johnhubbard/linux.git  track_user_pages_v4

I'm particularly pleased that the /proc/vmstat items are now available
in all configurations, seeing as how I was looking (in vain) for that
information during a recent investigation of a remotely reported
problem.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v3:

* Rebased onto latest linux.git

* Added ACKs and reviewed-by's from Kirill Shutemov and Jan Kara.

* /proc/vmstat:
    * Renamed items, after realizing that I hate the previous names:
         nr_foll_pin_requested --> nr_foll_pin_acquired
         nr_foll_pin_returned  --> nr_foll_pin_released

    * Removed the CONFIG_DEBUG_VM guard, and collapsed away a wrapper
      routine: now just calls mod_node_page_state() directly.

* Tweaked the WARN_ON_ONCE() statements in mm/hugetlb.c to be more
  informative, and added comments above them as well.

* Fixed gup_benchmark: signed int --> unsigned long.

* One or two minor formatting changes.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v2:

* Rebased onto linux.git, because the akpm tree for 5.6 has been merged.

* Split the tracking patch into even more patches, as requested.

* Merged Matthew Wilcox's dump_page() changes into mine, as part of the
  first patch.

* Renamed: page_dma_pinned() --> page_maybe_dma_pinned(), in response to
  Kirill Shutemov's review.

* Moved a WARN to the top of a routine, and fixed a typo in the commit
  description of patch #7, also as suggested by Kirill.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v1:

* Split the tracking patch into 6 smaller patches

* Rebased onto today's linux-next/akpm (there weren't any conflicts).

* Fixed an "unsigned int" vs. "int" problem in gup_benchmark, reported
  by Nathan Chancellor. (I don't see it in my local builds, probably
  because they use gcc, but an LLVM test found the mismatch.)

* Fixed a huge page pincount problem (add/subtract vs.
  increment/decrement), spotted by Jan Kara.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is a reasonable case to be made for merging two of the patches
(patches 7 and 8), given that patch 7 provides tracking that has upper
limits on the number of pins that can be done with huge pages. Let me
know if anyone wants those merged, but unless there is some weird chance
of someone grabbing patch 7 and not patch 8, I don't really see the
need. Meanwhile, it's easier to review in this form.

Also, patch 3 has been revived. Earlier reviewers asked for it to be
merged into the tracking patch (one cannot please everyone, heh), but
now it's back out on it's own.

This activates tracking of FOLL_PIN pages. This is in support of fixing
the get_user_pages()+DMA problem described in [1]-[4].

FOLL_PIN support is now in the main linux tree. However, the
patch to use FOLL_PIN to track pages was *not* submitted, because Leon
saw an RDMA test suite failure that involved (I think) page refcount
overflows when huge pages were used.

This patch definitively solves that kind of overflow problem, by adding
an exact pincount, for compound pages (of order > 1), in the 3rd struct
page of a compound page. If available, that form of pincounting is used,
instead of the GUP_PIN_COUNTING_BIAS approach. Thanks again to Jan Kara
for that idea.

Other interesting changes:

* dump_page(): added one, or two new things to report for compound
  pages: head refcount (for all compound pages), and map_pincount (for
  compound pages of order > 1).

* Documentation/core-api/pin_user_pages.rst: removed the "TODO" for the
  huge page refcount upper limit problems, and added notes about how it
  works now. Also added a note about the dump_page() enhancements.

* Added some comments in gup.c and mm.h, to explain that there are two
  ways to count pinned pages: exact (for compound pages of order > 1)
  and fuzzy (GUP_PIN_COUNTING_BIAS: for all other pages).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General notes about the tracking patch:

This is a prerequisite to solving the problem of proper interactions
between file-backed pages, and [R]DMA activities, as discussed in [1],
[2], [3], [4] and in a remarkable number of email threads since about
2017. :)

In contrast to earlier approaches, the page tracking can be
incrementally applied to the kernel call sites that, until now, have
been simply calling get_user_pages() ("gup"). In other words, opt-in by
changing from this:

    get_user_pages() (sets FOLL_GET)
    put_page()

to this:
    pin_user_pages() (sets FOLL_PIN)
    unpin_user_page()

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Next steps:

* Convert more subsystems from get_user_pages() to pin_user_pages().
* Work with Ira and others to connect this all up with file system
  leases.

[1] Some slow progress on get_user_pages() (Apr 2, 2019):
    https://lwn.net/Articles/784574/

[2] DMA and get_user_pages() (LPC: Dec 12, 2018):
    https://lwn.net/Articles/774411/

[3] The trouble with get_user_pages() (Apr 30, 2018):
    https://lwn.net/Articles/753027/

[4] LWN kernel index: get_user_pages()
    https://lwn.net/Kernel/Index/#Memory_management-get_user_pages

John Hubbard (12):
  mm: dump_page(): better diagnostics for compound pages
  mm/gup: split get_user_pages_remote() into two routines
  mm/gup: pass a flags arg to __gup_device_* functions
  mm: introduce page_ref_sub_return()
  mm/gup: pass gup flags to two more routines
  mm/gup: require FOLL_GET for get_user_pages_fast()
  mm/gup: track FOLL_PIN pages
  mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages
  mm: dump_page(): better diagnostics for huge pinned pages
  mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting
  mm/gup_benchmark: support pin_user_pages() and related calls
  selftests/vm: run_vmtests: invoke gup_benchmark with basic FOLL_PIN
    coverage

 Documentation/core-api/pin_user_pages.rst  |  59 ++-
 include/linux/mm.h                         | 108 ++++-
 include/linux/mm_types.h                   |   7 +-
 include/linux/mmzone.h                     |   2 +
 include/linux/page_ref.h                   |   9 +
 mm/debug.c                                 |  61 ++-
 mm/gup.c                                   | 448 ++++++++++++++++-----
 mm/gup_benchmark.c                         |  71 +++-
 mm/huge_memory.c                           |  29 +-
 mm/hugetlb.c                               |  60 ++-
 mm/page_alloc.c                            |   2 +
 mm/rmap.c                                  |   6 +
 mm/vmstat.c                                |   2 +
 tools/testing/selftests/vm/gup_benchmark.c |  15 +-
 tools/testing/selftests/vm/run_vmtests     |  22 +
 15 files changed, 721 insertions(+), 180 deletions(-)

--=20
2.25.0

