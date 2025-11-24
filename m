Return-Path: <linux-kselftest+bounces-46386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB0C80814
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288A53A72F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395473002DE;
	Mon, 24 Nov 2025 12:39:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D663009F1;
	Mon, 24 Nov 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987995; cv=none; b=h3cMQK+ZplNz1AZhazpOPI0pATbSNqZZ+HfRvdku9gbn0Mmko96U7nn4DV4hPpQKloOjPDfJhenc89wKEnXJQBXLbwKlU5bX5OS/glLb28lWsQRD/wgEBTu0+o/u2HZQMyAHOch3zsN9gLJNiGtysG8jSY461X0UsyUDvGBC7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987995; c=relaxed/simple;
	bh=WU8EgO4i0IwfUThmZUL2X1Vq68BQe2GAA3uAiWmIpT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBscEhWkcDvZVhljwRCjP2aE9RpCdSdcXgLK/nWnSie840WmvZKpjV/7n9d6y1aOM9Cx5Wl3rcD+7fvFXdoaFLMrlr7uri6lWbT+JNCvogIDt/JpyXz0wuQKjASnaP/iNQew+xJIGqqz7dkqHZ31PSqc8BMFNWmW2p1lIwgKm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a821297ec93211f0a38c85956e01ac42-20251124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:180b0333-6da6-477e-b0ee-baf49c0e91e9,IP:10,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.6,REQID:180b0333-6da6-477e-b0ee-baf49c0e91e9,IP:10,URL
	:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-15
X-CID-META: VersionHash:a9d874c,CLOUDID:f01b25cd1b7c132f57144eb32d385955,BulkI
	D:251124203948IQSFPUOC,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a821297ec93211f0a38c85956e01ac42-20251124
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 391219460; Mon, 24 Nov 2025 20:39:45 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	muchun.song@linux.dev
Cc: lance.yang@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v4 3/3] selftests: cgroup: Replace sleep with cg_read_key_long_poll() for waiting on nr_dying_descendants
Date: Mon, 24 Nov 2025 20:38:16 +0800
Message-Id: <20251124123816.486164-4-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the manual sleep and retry logic in test_kmem_dead_cgroups() with the new
helper `cg_read_key_long_poll()`.  This change improves the robustness of the test by
polling the "nr_dying_descendants" counter in `cgroup.stat` until it reaches 0 or the timeout is exceeded.

Additionally, increased the retry timeout to 8 seconds (from 5 seconds) based on testing results:
  - With 5-second timeout: 4/20 runs passed.
  - With 8-second timeout: 20/20 runs passed.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 tools/testing/selftests/cgroup/test_kmem.c | 31 +++++++++-------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index ca38525484e3..299d8e332e42 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -26,6 +26,7 @@
  */
 #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
 
+#define KMEM_DEAD_WAIT_RETRIES        80              /* 8s total */
 
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
@@ -323,21 +322,17 @@ static int test_kmem_dead_cgroups(const char *root)
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
+	 * Reclaiming cgroups may take some time,
+	 * so let's wait a bit and retry.
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


