Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80C82986F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421426AbgJZGlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12977 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421151AbgJZGlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f810002>; Sun, 25 Oct 2020 23:41:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:00 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:00 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/9] selftests/vm: gup_test, hmm-tests, assorted improvements
Date:   Sun, 25 Oct 2020 23:40:12 -0700
Message-ID: <20201026064021.3545418-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694465; bh=wy+u6eWlnPqaZrXFtjUMxt7dKRN/EsxldMhzEijG+Ew=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type:X-NVConfidentiality:Content-Transfer-Encoding;
        b=m6bvQJoqdhgniEF2ca95KKMgLsoBc/x4MzP+eeMtoRY+XoXK2tJSuk6Ux8ktv3m8Y
         ngQfCucT7Wqm+/lfJ70uFqHrLRZBW2dtkj4TqTg60I8/KszBiCpF4bgZJd6aC4gLiw
         DsyCXr/VSRem8JiU/wiwd2TEgQszsSotQskubjZMyaDatLQ/5NOtgvs4c395XrFtqd
         lc+td5QeuoauzpyzJCUReju2qKdaXZPMmG8jvUim5EP2wDTC8uYAJukPwH7OVY6fiq
         JVnP6tDPVlo4/RJQ6LRfblUEfN5MZ37kqiuIujK3Y+oWnM8heNbgjVOvIqDaxfdKKI
         R81qiVi62kp2A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Reposting for -rc1, with some fixes, and an additional path at the end,
too. I've swept through and looked for problems, as well.

Changes since v2 [1]:

* Rebased onto 5.10-rc1

* Fixed an improper ".." include path, indentified by Linus [2].

* Added an "if (cmd =3D=3D DUMP_USER_PAGES_TEST)" guard to invoking
dump_pages_test(). Before, it worked, but it's too subtle to depend
merely on struct gup_test.which_pages[] being zeroed out, in order to
avoid dumping pages that are not requested to be dumped.

* Added a patch to the end: 2x speedup for run_vmtests.sh

* Tweaked some commit logs and comments slightly

Original cover letter, edited slightly:

Summary: This series provides two main things, and a number of smaller
supporting goodies. The two main points are:

1) Add a new sub-test to gup_test, which in turn is a renamed version of
gup_benchmark. This sub-test allows nicer testing of dump_pages(), at
least on user-space pages.

For quite a while, I was doing a quick hack to gup_test.c whenever I
wanted to try out changes to dump_page(). Then Matthew Wilcox asked me
what I meant when I said "I used my dump_page() unit test", and I
realized that it might be nice to check in a polished up version of
that.

Details about how it works and how to use it are in the commit
description for patch #6 ("selftests/vm: gup_test: introduce the
dump_pages() sub-test").

2) Fixes a limitation of hmm-tests: these tests are incredibly useful,
but only if people actually build and run them. And it turns out that
libhugetlbfs is a little too effective at throwing a wrench in the
works, there. So I've added a little configuration check that removes
just two of the 21 hmm-tests, if libhugetlbfs is not available.

Further details in the commit description of patch #8 ("selftests/vm:
hmm-tests: remove the libhugetlbfs dependency").

Other smaller things that this series does:

a) Remove code duplication by creating gup_test.h.

b) Clear up the sub-test organization, and their invocation within
run_vmtests.sh.

c) Other minor assorted improvements.

[1] v2 is here:
https://lore.kernel.org/linux-doc/20200929212747.251804-1-jhubbard@nvidia.c=
om/

[2] https://lore.kernel.org/r/CAHk-=3Dwgh-TMPHLY3jueHX7Y2fWh3D+nMBqVS__AZm6=
-oorquWA@mail.gmail.com


John Hubbard (9):
  mm/gup_benchmark: rename to mm/gup_test
  selftests/vm: use a common gup_test.h
  selftests/vm: rename run_vmtests --> run_vmtests.sh
  selftests/vm: minor cleanup: Makefile and gup_test.c
  selftests/vm: only some gup_test items are really benchmarks
  selftests/vm: gup_test: introduce the dump_pages() sub-test
  selftests/vm: run_vmtests.sh: update and clean up gup_test invocation
  selftests/vm: hmm-tests: remove the libhugetlbfs dependency
  selftests/vm: 2x speedup for run_vmtests.sh

 Documentation/core-api/pin_user_pages.rst     |   6 +-
 arch/s390/configs/debug_defconfig             |   2 +-
 arch/s390/configs/defconfig                   |   2 +-
 mm/Kconfig                                    |  21 +-
 mm/Makefile                                   |   2 +-
 mm/{gup_benchmark.c =3D> gup_test.c}            | 111 ++++++----
 mm/gup_test.h                                 |  32 +++
 tools/testing/selftests/vm/.gitignore         |   3 +-
 tools/testing/selftests/vm/Makefile           |  38 +++-
 tools/testing/selftests/vm/check_config.sh    |  31 +++
 tools/testing/selftests/vm/config             |   2 +-
 tools/testing/selftests/vm/gup_benchmark.c    | 143 -------------
 tools/testing/selftests/vm/gup_test.c         | 194 ++++++++++++++++++
 tools/testing/selftests/vm/hmm-tests.c        |  10 +-
 .../vm/{run_vmtests =3D> run_vmtests.sh}        |  32 ++-
 15 files changed, 416 insertions(+), 213 deletions(-)
 rename mm/{gup_benchmark.c =3D> gup_test.c} (60%)
 create mode 100644 mm/gup_test.h
 create mode 100644 tools/testing/selftests/vm/check_config.sh
 delete mode 100644 tools/testing/selftests/vm/gup_benchmark.c
 create mode 100644 tools/testing/selftests/vm/gup_test.c
 rename tools/testing/selftests/vm/{run_vmtests =3D> run_vmtests.sh} (88%)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
--=20
2.29.0

