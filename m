Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA527A761
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 08:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI1GWB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 02:22:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2535 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgI1GWB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 02:22:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7180d70000>; Sun, 27 Sep 2020 23:21:11 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 06:22:00 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 28 Sep 2020 06:22:00 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/8] selftests/vm: gup_test, hmm-tests, assorted improvements
Date:   Sun, 27 Sep 2020 23:21:51 -0700
Message-ID: <20200928062159.923212-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601274071; bh=aje0xlQbgGTe8PDh3PLtbmYUZlvyK6r4rrB1MLJQctg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=IU1bhmM/2JHR6pBNGilbB3FShB1LLkAywl19QB5Dq9eoSE/k7+ELxevvqYtXqAq8W
         lpwYUDgpCvEYd5KvlYtILKhCPIFgwVjy8alY2Ae/TziZ/b01cpdjtTA1kTbaDkSUSg
         P0uftuJ3Rvi2tvE3gxeI+W/9o2/NLo03F5o7nNcecoVHGpWQGrpWJTVLrGk2a5kVpY
         i7lJun/WUkKTaqQcN8XpIdXlqbkKDdfuXWppC9oPH0nlRncS8C9Qo24u1u0xyYQ2Su
         i4+wGtF0hsKTLsuwwYbklNgRZsq8LugtCEDfcjWbBN0EMBc66t2fhCcRnfuu8hlnTM
         L3QbLSspGyNig==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
 tools/testing/selftests/vm/check_config.sh    |  30 +++
 tools/testing/selftests/vm/config             |   2 +-
 tools/testing/selftests/vm/gup_benchmark.c    | 137 -------------
 tools/testing/selftests/vm/gup_test.c         | 188 ++++++++++++++++++
 tools/testing/selftests/vm/hmm-tests.c        |  10 +-
 .../vm/{run_vmtests =3D> run_vmtest.sh}         |  24 ++-
 15 files changed, 403 insertions(+), 203 deletions(-)
 rename mm/{gup_benchmark.c =3D> gup_test.c} (59%)
 create mode 100644 mm/gup_test.h
 create mode 100755 tools/testing/selftests/vm/check_config.sh
 delete mode 100644 tools/testing/selftests/vm/gup_benchmark.c
 create mode 100644 tools/testing/selftests/vm/gup_test.c
 rename tools/testing/selftests/vm/{run_vmtests =3D> run_vmtest.sh} (91%)

--=20
2.28.0

