Return-Path: <linux-kselftest+bounces-37495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A03B0891E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C300816230F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A0288526;
	Thu, 17 Jul 2025 09:19:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD873286D79
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743981; cv=none; b=fxp4OZrq0NnKjcZU+XCf4F9IeJITV41ndFS/HwE1NzRy/2q04hvZPqWVjs/agE5e52WvzpB0PS8MLs5r/JV+hY2h9jacR3dF/ffI/GPpZ8VuBskPXsvjeKM42kkx87CKp3pakLkbFskrff9dhSx0NDcQjC5zAe3kMlnQOCJHvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743981; c=relaxed/simple;
	bh=feRLhAz6yHFNQv6pOMS3bpp408aUpG91j9XZ8RDuEBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgJwDNJP5XJ9nkbqXRc/A50TRS7ffy8KVYMCSx605qxhH1WJcnwN7rzWuX7BKT814vEliA/NuCZwIOCZmUdNosj5UrsenwxHkbbvaVPpsc7Of892NqqnB1wjpgxKiSSGxYRbVlD+5jTDaoqogWhOHYUGzF8TTOn4tHYjQ9qLMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2466df3862ef11f0b29709d653e92f7d-20250717
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d1cc04a4-92c2-4a47-9981-69cf60e6f942,IP:10,
	URL:0,TC:0,Content:31,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:26
X-CID-INFO: VERSION:1.1.45,REQID:d1cc04a4-92c2-4a47-9981-69cf60e6f942,IP:10,UR
	L:0,TC:0,Content:31,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:26
X-CID-META: VersionHash:6493067,CLOUDID:ad2b09e67e01a10f9c39128f94cd93f4,BulkI
	D:2507171717256IUM6FKL,BulkQuantity:1,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:4|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2466df3862ef11f0b29709d653e92f7d-20250717
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 334625521; Thu, 17 Jul 2025 17:19:29 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] selftests/damon: introduce _common.sh to host shared function
Date: Thu, 17 Jul 2025 17:19:02 +0800
Message-ID: <20250717091902.104466-1-lienze@kylinos.cn>
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
 tools/testing/selftests/damon/_common.sh           | 14 ++++++++++++++
 tools/testing/selftests/damon/lru_sort.sh          |  9 ++-------
 tools/testing/selftests/damon/reclaim.sh           |  9 ++-------
 tools/testing/selftests/damon/sysfs.sh             | 12 +-----------
 .../damon/sysfs_update_removed_scheme_dir.sh       |  9 ++-------
 5 files changed, 21 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/damon/_common.sh

diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
new file mode 100644
index 000000000000..3920b619c30f
--- /dev/null
+++ b/tools/testing/selftests/damon/_common.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest frmework requirement - SKIP code is 4.
+ksft_skip=4
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
index 61b80197c896..0d128d809fd3 100755
--- a/tools/testing/selftests/damon/lru_sort.sh
+++ b/tools/testing/selftests/damon/lru_sort.sh
@@ -1,14 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source _common.sh
 
-if [ $EUID -ne 0 ]
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
+check_dependencies
 
 damon_lru_sort_enabled="/sys/module/damon_lru_sort/parameters/enabled"
 if [ ! -f "$damon_lru_sort_enabled" ]
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
index 78dbc2334cbe..41e450a696ae 100755
--- a/tools/testing/selftests/damon/reclaim.sh
+++ b/tools/testing/selftests/damon/reclaim.sh
@@ -1,14 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source _common.sh
 
-if [ $EUID -ne 0 ]
-then
-	echo "Run as root"
-	exit $ksft_skip
-fi
+check_dependencies
 
 damon_reclaim_enabled="/sys/module/damon_reclaim/parameters/enabled"
 if [ ! -f "$damon_reclaim_enabled" ]
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index e9a976d296e2..0326b9ad55ca 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -1,8 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Kselftest frmework requirement - SKIP code is 4.
-ksft_skip=4
+source _common.sh
 
 ensure_write_succ()
 {
@@ -364,14 +363,5 @@ test_damon_sysfs()
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
index ade35576e748..730165bd7f03 100755
--- a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
+++ b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
@@ -1,14 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source _common.sh
 
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


