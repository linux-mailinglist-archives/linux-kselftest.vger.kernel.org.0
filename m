Return-Path: <linux-kselftest+bounces-37544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3698B09B9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 08:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF875171539
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B011FDE22;
	Fri, 18 Jul 2025 06:42:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659E1EDA03
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820959; cv=none; b=nemFA6lcOG4haRcQCTvslPsbiRh1/b1IhFbcIlAk4LbAdLHwfagZegPzZT4fuz9cWo+UbsCvw/j3arwGyjt8n2zQDn0ohuYPaePRhNlo+y3sbgFQflsWAGen6k/RwypaB2Xjh37Du1C5/IRtg4GSAZ28HF5NnG8NcORnjWZUN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820959; c=relaxed/simple;
	bh=wYnNbYmuE98tA4XbaqPH0vUgDBttjCosJ7NCH/fkqkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJcPeSjmNVKxNHV4hZriiOE/RAyPJ3zuIw5M3Ri8PeEAKj6sMExqyEmNgAARic3D82mwqF/9zpGwnjCcy+raW3+MdiNUgZpjmYsHoLLK3aExNrpa1wxhIEVTL9ujb6isAbHX+AvhVxZUtbbpx8dQVlw4osu8qoFGAx6+cAn3WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6067299463a211f0b29709d653e92f7d-20250718
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0b93e3ed-f1d2-4165-b08a-b2fe95025b82,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:0b93e3ed-f1d2-4165-b08a-b2fe95025b82,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:f183cdfe0d039c935fec25ffa11447a3,BulkI
	D:250718144232YJLJ6S73,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6067299463a211f0b29709d653e92f7d-20250718
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1014749217; Fri, 18 Jul 2025 14:42:30 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH v2] selftests/damon: introduce _common.sh to host shared function
Date: Fri, 18 Jul 2025 14:42:17 +0800
Message-ID: <20250718064217.299300-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current test scripts contain duplicated root permission checks
in multiple locations.  This patch consolidates these checks into
_common.sh to eliminate code redundancy.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 tools/testing/selftests/damon/_common.sh              | 11 +++++++++++
 tools/testing/selftests/damon/lru_sort.sh             |  8 +++-----
 tools/testing/selftests/damon/reclaim.sh              |  8 +++-----
 tools/testing/selftests/damon/sysfs.sh                | 11 ++---------
 .../damon/sysfs_update_removed_scheme_dir.sh          |  8 +++-----
 5 files changed, 22 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/damon/_common.sh

diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
new file mode 100644
index 000000000000..0279698f733e
--- /dev/null
+++ b/tools/testing/selftests/damon/_common.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+check_dependencies()
+{
+	if [ $EUID -ne 0 ]
+	then
+		echo "Run as root"
+		exit $ksft_skip
+	fi
+}
diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
index 61b80197c896..1e4849db78a9 100755
--- a/tools/testing/selftests/damon/lru_sort.sh
+++ b/tools/testing/selftests/damon/lru_sort.sh
@@ -1,14 +1,12 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source _common.sh
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-if [ $EUID -ne 0 ]
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
+check_dependencies
 
 damon_lru_sort_enabled="/sys/module/damon_lru_sort/parameters/enabled"
 if [ ! -f "$damon_lru_sort_enabled" ]
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
index 78dbc2334cbe..e56ceb035129 100755
--- a/tools/testing/selftests/damon/reclaim.sh
+++ b/tools/testing/selftests/damon/reclaim.sh
@@ -1,14 +1,12 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source _common.sh
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-if [ $EUID -ne 0 ]
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
+check_dependencies
 
 damon_reclaim_enabled="/sys/module/damon_reclaim/parameters/enabled"
 if [ ! -f "$damon_reclaim_enabled" ]
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index e9a976d296e2..83e3b7f63d81 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source _common.sh
+
 # Kselftest frmework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -364,14 +366,5 @@ test_damon_sysfs()
 	test_kdamonds "$damon_sysfs/kdamonds"
 }
 
-check_dependencies()
-{
-	if [ $EUID -ne 0 ]
-	then
-		echo "Run as root"
-		exit $ksft_skip
-	fi
-}
-
 check_dependencies
 test_damon_sysfs "/sys/kernel/mm/damon/admin"
diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
index ade35576e748..35fc32beeaf7 100755
--- a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
+++ b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
@@ -1,14 +1,12 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source _common.sh
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-if [ $EUID -ne 0 ]
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
+check_dependencies
 
 damon_sysfs="/sys/kernel/mm/damon/admin"
 if [ ! -d "$damon_sysfs" ]

base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
-- 
2.43.0


