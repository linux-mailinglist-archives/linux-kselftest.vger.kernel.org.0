Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626927D9FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 23:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgI2V1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 17:27:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1418 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2V1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 17:27:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a6a30000>; Tue, 29 Sep 2020 14:26:59 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:27:49 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 29 Sep 2020 21:27:49 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/8] selftests/vm: gup_test, hmm-tests, assorted improvements
Date:   Tue, 29 Sep 2020 14:27:39 -0700
Message-ID: <20200929212747.251804-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601414819; bh=/l55YVIR3fkE3PZPlEjt0CYapKtFEJLwUJsGE013vto=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=RU/PXkjuWn/si5ipW7kToDDoAWVz3SWhgMkGRcvK6CYj0+Q12iG3mpq42k21n7319
         TxaR8Ug/il5JP1RXORhiuWRMxg4vKY0ECaTVpnw0E+7fCkJv+F3fG3uE8bryzAzYdi
         ClAJrq2do5e4LarQN8OvqDypPVgACA1o8CH6kEQlbdOPQzB2kgl36nhPcwd3MGzGPp
         tY1kXS0jcCo6fWsJ7WhS5yuMqJIkpJujtx1WAHNepeh1Vg/b+yRB+3PRIo4LKsKKpb
         rwaTs62LouCSUJQw5fVXjLOFyvvs4JTzMfiUutXauF60GOXqjew7ANbiUoDyabk/Ja
         bjsiCZXrKp1Sg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since v1:

* check_config.sh now invokes the compiler via the Makefile's ($CC),
thanks to Jason Gunthorpe for calling that out.

* Removed a misleading sentence from patch #6, as identified by Ira
Weiny.

* Removed a forward-looking sentence, about using -lpthread in
gup_test.c soon, from the commit message in patch #4, since I'm not yet
sure if my local pthread-based stress tests are actually worthwhile or
not.

Original cover letter, still accurate at this point:

This is based on the latest mmotm.

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
description for patch #6.

2) Fixes a limitation of hmm-tests: these tests are incredibly useful,
but only if people actually build and run them. And it turns out that
libhugetlbfs is a little too effective at throwing a wrench in the
works, there. So I've added a little configuration check that removes
just two of the 21 hmm-tests, if libhugetlbfs is not available.

Further details in the commit description of patch #8.

Other smaller things that this series does:

a) Remove code duplication by creating gup_test.h.

b) Clear up the sub-test organization, and their invocation within
run_vmtests.sh.

c) Other minor assorted improvements.


John Hubbard (8):
  mm/gup_benchmark: rename to mm/gup_test
  selftests/vm: use a common gup_test.h
  selftests/vm: rename run_vmtests --> run_vmtests.sh
  selftests/vm: minor cleanup: Makefile and gup_test.c
  selftests/vm: only some gup_test items are really benchmarks
  selftests/vm: gup_test: introduce the dump_pages() sub-test
  selftests/vm: run_vmtest.sh: update and clean up gup_test invocation
  selftests/vm: hmm-tests: remove the libhugetlbfs dependency

 Documentation/core-api/pin_user_pages.rst     |   6 +-
 arch/s390/configs/debug_defconfig             |   2 +-
 arch/s390/configs/defconfig                   |   2 +-
 mm/Kconfig                                    |  21 +-
 mm/Makefile                                   |   2 +-
 mm/{gup_benchmark.c =3D> gup_test.c}            | 109 ++++++----
 mm/gup_test.h                                 |  32 +++
 tools/testing/selftests/vm/.gitignore         |   3 +-
 tools/testing/selftests/vm/Makefile           |  38 +++-
 tools/testing/selftests/vm/check_config.sh    |  31 +++
 tools/testing/selftests/vm/config             |   2 +-
 tools/testing/selftests/vm/gup_benchmark.c    | 137 -------------
 tools/testing/selftests/vm/gup_test.c         | 188 ++++++++++++++++++
 tools/testing/selftests/vm/hmm-tests.c        |  10 +-
 .../vm/{run_vmtests =3D> run_vmtest.sh}         |  24 ++-
 15 files changed, 404 insertions(+), 203 deletions(-)
 rename mm/{gup_benchmark.c =3D> gup_test.c} (59%)
 create mode 100644 mm/gup_test.h
 create mode 100755 tools/testing/selftests/vm/check_config.sh
 delete mode 100644 tools/testing/selftests/vm/gup_benchmark.c
 create mode 100644 tools/testing/selftests/vm/gup_test.c
 rename tools/testing/selftests/vm/{run_vmtests =3D> run_vmtest.sh} (91%)

--=20
2.28.0

