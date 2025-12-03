Return-Path: <linux-kselftest+bounces-46937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA2C9EEAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 12:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE71A3A7317
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180972F6170;
	Wed,  3 Dec 2025 11:57:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441A2F60DA;
	Wed,  3 Dec 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763066; cv=none; b=Of7TwasR7XK3wf/s2fBvUHqjpmHvWP35ezaHcTVwZ6pg+R8VqRa0lh+PFGuSQ2R9KixQLI3Zy1qVFbqsnzB67KM2KKl0hyMy30iCIjbGLJ+n7hdtsQSZ61aPZdGRKZMwpx34GtA1sFFWN46h9RQGu1Lkic56kC+8Ta25w4gMpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763066; c=relaxed/simple;
	bh=qOJyWomEAXfhS4WEH9dTHOe7/h5/+HVAkhLKPhwzxhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0KPGf4azJ0y7CY9BVwR+w5nJfp5VabdhZ81844pRGPkFuXiSO6DLWLAiw3VF9FhmsoI2UmZTszmnQRYcGhRK65r2zwqYZbwESRhb+hdMaaAQ7t/x0E1puhr3u9UHLuLU7i9DJw4l6yDmmNvI8+wFC+cgvVjta+55VxcmLh/spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3e8aed92d03f11f0a38c85956e01ac42-20251203
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3afd6943-73bc-45e8-83fd-e7479fdc0fa9,IP:10,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.6,REQID:3afd6943-73bc-45e8-83fd-e7479fdc0fa9,IP:10,URL
	:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-15
X-CID-META: VersionHash:a9d874c,CLOUDID:62c5311b8a953f6b247a7649f052c076,BulkI
	D:251203195739X3CS36VH,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3e8aed92d03f11f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 656484029; Wed, 03 Dec 2025 19:57:29 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	roman.gushchin@linux.dev,
	lance.yang@linux.dev,
	shakeel.butt@linux.dev
Cc: muchun.song@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v5 3/3] selftests: cgroup: Replace sleep with cg_read_key_long_poll() for waiting on nr_dying_descendants
Date: Wed,  3 Dec 2025 19:56:31 +0800
Message-Id: <20251203115631.947908-4-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual sleep-and-retry logic in test_kmem_dead_cgroups()
with the new helper `cg_read_key_long_poll()`. This change improves
the robustness of the test by polling the "nr_dying_descendants"
counter in `cgroup.stat` until it reaches 0 or the timeout is exceeded.

Additionally, increase the retry timeout to 8 seconds (from 5 seconds)
based on testing results:
  - With 5-second timeout: 4/20 runs passed.
  - With 8-second timeout: 20/20 runs passed.

The 8 second timeout is based on stress testing of test_kmem_dead_cgroups()
under load: 5 seconds was occasionally not enough for reclaim of dying
descendants to complete, whereas 8 seconds consistently covered the observed
latencies. This value is intended as a generous upper bound for the
asynchronous reclaim and is not tied to any specific kernel constant, so it
can be adjusted in the future if reclaim behavior changes.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 tools/testing/selftests/cgroup/test_kmem.c | 33 ++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index ca38525484e3..eeabd34bf083 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -26,6 +26,7 @@
  */
 #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
 
+#define KMEM_DEAD_WAIT_RETRIES        80
 
 static int alloc_dcache(const char *cgroup, void *arg)
 {
@@ -306,9 +307,7 @@ static int test_kmem_dead_cgroups(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *parent;
-	long dead;
-	int i;
-	int max_time = 20;
+	long dead = -1;
 
 	parent = cg_name(root, "kmem_dead_cgroups_test");
 	if (!parent)
@@ -323,21 +322,19 @@ static int test_kmem_dead_cgroups(const char *root)
 	if (cg_run_in_subcgroups(parent, alloc_dcache, (void *)100, 30))
 		goto cleanup;
 
-	for (i = 0; i < max_time; i++) {
-		dead = cg_read_key_long(parent, "cgroup.stat",
-					"nr_dying_descendants ");
-		if (dead == 0) {
-			ret = KSFT_PASS;
-			break;
-		}
-		/*
-		 * Reclaiming cgroups might take some time,
-		 * let's wait a bit and repeat.
-		 */
-		sleep(1);
-		if (i > 5)
-			printf("Waiting time longer than 5s; wait: %ds (dead: %ld)\n", i, dead);
-	}
+	/*
+	 * Allow up to ~8s for reclaim of dying descendants to complete.
+	 * This is a generous upper bound derived from stress testing, not
+	 * from a specific kernel constant, and can be adjusted if reclaim
+	 * behavior changes in the future.
+	 */
+	dead = cg_read_key_long_poll(parent, "cgroup.stat",
+					"nr_dying_descendants ", 0, KMEM_DEAD_WAIT_RETRIES,
+					DEFAULT_WAIT_INTERVAL_US);
+	if (dead)
+		goto cleanup;
+
+	ret = KSFT_PASS;
 
 cleanup:
 	cg_destroy(parent);
-- 
2.25.1


