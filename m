Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9919C2986FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770576AbgJZGlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11580 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770543AbgJZGlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f850004>; Sun, 25 Oct 2020 23:41:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:01 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:01 +0000
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
Subject: [PATCH v3 7/9] selftests/vm: run_vmtests.sh: update and clean up gup_test invocation
Date:   Sun, 25 Oct 2020 23:40:19 -0700
Message-ID: <20201026064021.3545418-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026064021.3545418-1-jhubbard@nvidia.com>
References: <20201026064021.3545418-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694469; bh=kXhIomNPDXSJUAeDw7QMEoffInptLRlozO6MNqQpgtY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type:X-NVConfidentiality:
         Content-Transfer-Encoding;
        b=nQ/vYKgns44XaoejV8YzR6nOeGow4IlDX6kRCsL2ezmIdjzrU11SSIovmPelmHRah
         veQovypKnBpgNbg2Vly9kj4sBYvwdkbNlcj/WOfu6JADkmKkS+dH8760c+c/jdlxf+
         +qPoq77990uLl1APXVGwuCRuY0PpIDEoytYUK+vN5565I9+tAOBVFojT9M+pZyxDO3
         msYnob0qCH8h3fZZt/1Va/JT30DdHULC5gexH/gS71Qjx5/H+Wo+p9oAkwwMt4aN7U
         AlL1Gldw2PKjRKdYP0LdRazq945xUJupTKytzKKaWTZwvMjfa8jkanXzNsoQ+66S/W
         PcBE9c/0GdWnw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run benchmarks on the _fast variants of gup and pup, as originally
intended.

Run the new gup_test sub-test: dump pages.  In addition to exercising the
dump_page() call, it also demonstrates the various options you can use to
specify which pages to dump, and how.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/run_vmtests.sh | 28 ++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/self=
tests/vm/run_vmtests.sh
index d1843d5f3c30..4ac84b350d9f 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -123,10 +123,10 @@ else
 	echo "[PASS]"
 fi
=20
-echo "--------------------------------------------"
-echo "running 'gup_test -U' (normal/slow gup)"
-echo "--------------------------------------------"
-./gup_test -U
+echo "------------------------------------------------------"
+echo "running: gup_test -u # get_user_pages_fast() benchmark"
+echo "------------------------------------------------------"
+./gup_test -u
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
@@ -134,10 +134,22 @@ else
 	echo "[PASS]"
 fi
=20
-echo "------------------------------------------"
-echo "running gup_test -b (pin_user_pages)"
-echo "------------------------------------------"
-./gup_test -b
+echo "------------------------------------------------------"
+echo "running: gup_test -a # pin_user_pages_fast() benchmark"
+echo "------------------------------------------------------"
+./gup_test -a
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=3D1
+else
+	echo "[PASS]"
+fi
+
+echo "------------------------------------------------------------"
+echo "# Dump pages 0, 19, and 4096, using pin_user_pages:"
+echo "running: gup_test -ct -F 0x1 0 19 0x1000 # dump_page() test"
+echo "------------------------------------------------------------"
+./gup_test -ct -F 0x1 0 19 0x1000
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
--=20
2.29.0

