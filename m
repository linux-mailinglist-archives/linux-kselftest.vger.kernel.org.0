Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC427A775
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgI1GWU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 02:22:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4311 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgI1GWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 02:22:03 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7180a70001>; Sun, 27 Sep 2020 23:20:23 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 06:22:03 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 28 Sep 2020 06:22:02 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 7/8] selftests/vm: run_vmtest.sh: update and clean up gup_test invocation
Date:   Sun, 27 Sep 2020 23:21:58 -0700
Message-ID: <20200928062159.923212-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928062159.923212-1-jhubbard@nvidia.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601274024; bh=EnpswkC06SgXdnmXzkGSyHyTa8dHGmVHmbkot3R5EyQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=iOZrGpE1V2vx/x1jHPAChPfkhgqmXz/fXJl5Q1lP6yZ7zDrdUv0fG/qVzSBG0oA+2
         wBIw8kgoW4xBNmDZUTifk2W+NueIbu1XJ7AIDZvwRlJsMO487kk9J6abBqSdzyyWrK
         WCwUlLwIUWu4Bv2gOI6ChgxrrnGFMFB7qN4671uNwyG9pOrvUXBN+NW55I57vgyu5d
         6xofNDV2xF5FjOpTBFisM22oYhtrxFDqqsapErM9VOHmymO0qBxOJ6Md2Pqt0Uo2Wb
         SpMPtW54tXRoOLKtg5B2fHgGRU8fwzC55VhUF5fEIxkHQMulsG480LkvyAmwfAFqoW
         njSkjDJ+eQJDw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run benchmarks on the _fast variants of gup and pup, as originally
intended.

Run the new gup_test sub-test: dump pages. In addition to exercising the
dump_page() call, it also demonstrates the various options you can use
to specify which pages to dump, and how.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/run_vmtest.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtest.sh b/tools/testing/selft=
ests/vm/run_vmtest.sh
index d1843d5f3c30..e3a8b14d9df6 100755
--- a/tools/testing/selftests/vm/run_vmtest.sh
+++ b/tools/testing/selftests/vm/run_vmtest.sh
@@ -124,9 +124,9 @@ else
 fi
=20
 echo "--------------------------------------------"
-echo "running 'gup_test -U' (normal/slow gup)"
+echo "running 'gup_test -u' (fast gup benchmark)"
 echo "--------------------------------------------"
-./gup_test -U
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
+echo "---------------------------------------------------"
+echo "running gup_test -a (pin_user_pages_fast benchmark)"
+echo "---------------------------------------------------"
+./gup_test -a
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=3D1
+else
+	echo "[PASS]"
+fi
+
+echo "--------------------------------------------------------------"
+echo "running gup_test -ct -F 0x1 0 19 0x1000"
+echo "   Dumps pages 0, 19, and 4096, using pin_user_pages (-F 0x1)"
+echo "--------------------------------------------------------------"
+./gup_test -ct -F 0x1 0 19 0x1000
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
--=20
2.28.0

