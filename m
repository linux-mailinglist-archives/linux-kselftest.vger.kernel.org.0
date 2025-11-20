Return-Path: <linux-kselftest+bounces-46064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A689C724B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00FC54E0561
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB43205E02;
	Thu, 20 Nov 2025 06:04:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C70189BB0;
	Thu, 20 Nov 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618669; cv=none; b=g0ma7xUWq6Quhnatk2aDp+kd9uD+mvSz63uBXKwD0W5FyVJWMykKLLlI+VMjAUrpYtQr84j4o0xG7kUKHJAsj8Ja5fyDarDsm7wOcmzUY5OQR9v58fZd14WngjXEwJxdtyMMN+cHmT+gvQZXwHtpSSEfDXKBGYZ5SvJtO4s/vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618669; c=relaxed/simple;
	bh=7VEyOGSjY1o9w6SMwe/n+8DEzf6I8ak5ypFJqYv95zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rD+gSeqanssVLHHLc7CvwhzUk1RlSKdVdv5lm5CNAX9O8Q5e32PtUtr07hwCZiVv2djHo5i+zW0RIA8ddSlZfWmWrhKuFPDU0gJ/7Kk8hd21JVVPIwul2Ve6nsSmOkXIEHDhk/P949B6aKo9ZilzkGlPsapjuZtbsCAAx6X9Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c009bedec5d611f0a38c85956e01ac42-20251120
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
X-CID-O-INFO: VERSION:1.3.6,REQID:d3379ca8-9df7-4f91-8869-027173cb9c99,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:d3379ca8-9df7-4f91-8869-027173cb9c99,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:05355a0d6bcb5969b9999be7041cecf5,BulkI
	D:251120140421GDWNOKMT,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|850,
	TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c009bedec5d611f0a38c85956e01ac42-20251120
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2026961757; Thu, 20 Nov 2025 14:04:18 +0800
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
Subject: [PATCH v3] selftests: cgroup: make test_memcg_sock robust against delayed sock stats
Date: Thu, 20 Nov 2025 14:04:06 +0800
Message-Id: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_memcg_sock() currently requires that memory.stat's "sock " counter
is exactly zero immediately after the TCP server exits. On a busy system
this assumption is too strict:

  - Socket memory may be freed with a small delay (e.g. RCU callbacks).
  - memcg statistics are updated asynchronously via the rstat flushing
    worker, so the "sock " value in memory.stat can stay non-zero for a
    short period of time even after all socket memory has been uncharged.

As a result, test_memcg_sock() can intermittently fail even though socket
memory accounting is working correctly.

Make the test more robust by polling memory.stat for the "sock "
counter and allowing it some time to drop to zero instead of checking
it only once. The timeout is set to 3 seconds to cover the periodic
rstat flush interval (FLUSH_TIME = 2*HZ by default) plus some
scheduling slack. If the counter does not become zero within the
timeout, the test still fails as before.

On my test system, running test_memcontrol 50 times produced:

  - Before this patch:  6/50 runs passed.
  - After this patch:  50/50 runs passed.

Suggested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
v3:
 - Move MEMCG_SOCKSTAT_WAIT_* defines after the #include block as
   suggested.
v2:
 - Mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in
   the comment and clarify the rationale for the 3s timeout.
 - Replace the hard-coded retry count and wait interval with macros
   to avoid magic numbers and make the 3s timeout calculation explicit.
---
 .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4e1647568c5b..8ff7286fc80b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -21,6 +21,9 @@
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
+#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */
+
 static bool has_localevents;
 static bool has_recursiveprot;
 
@@ -1384,6 +1387,8 @@ static int test_memcg_sock(const char *root)
 	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
 	unsigned short port;
 	char *memcg;
+	long sock_post = -1;
+	int i;
 
 	memcg = cg_name(root, "memcg_test");
 	if (!memcg)
@@ -1432,7 +1437,30 @@ static int test_memcg_sock(const char *root)
 	if (cg_read_long(memcg, "memory.current") < 0)
 		goto cleanup;
 
-	if (cg_read_key_long(memcg, "memory.stat", "sock "))
+	/*
+	 * memory.stat is updated asynchronously via the memcg rstat
+	 * flushing worker, which runs periodically (every 2 seconds,
+	 * see FLUSH_TIME). On a busy system, the "sock " counter may
+	 * stay non-zero for a short period of time after the TCP
+	 * connection is closed and all socket memory has been
+	 * uncharged.
+	 *
+	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
+	 * scheduling slack) and require that the "sock " counter
+	 * eventually drops to zero.
+	 */
+	for (i = 0; i < MEMCG_SOCKSTAT_WAIT_RETRIES; i++) {
+		sock_post = cg_read_key_long(memcg, "memory.stat", "sock ");
+		if (sock_post < 0)
+			goto cleanup;
+
+		if (!sock_post)
+			break;
+
+		usleep(MEMCG_SOCKSTAT_WAIT_INTERVAL_US);
+	}
+
+	if (sock_post)
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.25.1


