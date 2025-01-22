Return-Path: <linux-kselftest+bounces-24956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6988A19893
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4903A2253
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664721576A;
	Wed, 22 Jan 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JhRisKd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840420FA9C;
	Wed, 22 Jan 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571092; cv=none; b=Q0yJJDnLqgz2OPIerQFOIgJckmuvNKror8MDIc92w7V02lg7k40jOxeTe+PCAHuteLrcp67mCfWSQIjpd+6yohgCjvv+2A/SYwVWqIx1Fn4BUvc7h99e9X/uUcQpWEQU/wlqWPpT/Bu9Q+ZsiR9gRx7uWA49iO6tIQsDplY8GCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571092; c=relaxed/simple;
	bh=UsW6dFnKhaemqjbzDn4FQ1Ys8eg1VzUhk4uRja24jJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdGrUl8QKpyRsJ4qT8OjqtPbWfXmTeYXVQpMF44beCP25/aPpDuSEu0cuDR856GHmMzSi02WJFge1MrwNtujBkGZVV058r6zjvFS8aedlMVKfakO8/eYgs+beDDpgH11BeP1Wockq0Pr2TxkZdC3YshdoQk5I0G0pjj8tdSJG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JhRisKd8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDFMEv002717;
	Wed, 22 Jan 2025 18:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6YaKnAKHb9JWYzTRJt/INcyPojCHVKwdCnG7gWV3k
	NI=; b=JhRisKd8Kp/C82YnwaUZBUn1U1mQapPHZ0ScSMMlkl+7e2r1tgfSpCdjo
	nMMLkvszt+9csYFReFm8AKpFC05rH957YOfeTvt7JaHVCwtESRhJOR+T4gBDDqE3
	BlOnMqpkhacC9u3qR/TgdinIm7vvtDQusatLaesmEL9IOzoue88aVMIk4rtvRxLc
	Pwovn3yDeWcw6QsH7MqgT4/0EZPA0VsmsMtPSpNkfh04NPgV0qhiA40g9Wv6EaIR
	aHlw+KGK7n3VTk5vnKkftsq9GNx2NFdAfN7fA2fWyfXF2NAGVHBVUHdnqorGoriO
	en7Uw5vVb6Es5WjP9YdFv6DPPgp/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgym79t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 18:37:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MIZh0S010420;
	Wed, 22 Jan 2025 18:37:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgym79n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 18:37:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGrJbm019287;
	Wed, 22 Jan 2025 18:37:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmshyqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 18:37:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MIbSE255509436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 18:37:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FE932004E;
	Wed, 22 Jan 2025 18:37:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC022004D;
	Wed, 22 Jan 2025 18:37:23 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.24.222])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 18:37:23 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org
Subject: [PATCH] bpf: Fix mix-up of 4096 and page size.
Date: Thu, 23 Jan 2025 00:07:20 +0530
Message-ID: <20250122183720.1411176-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eNmxWv_rYL7kuZ1_SjbPNZr0lpltiFQW
X-Proofpoint-ORIG-GUID: _iPiVWzVRZgy4W6mo6hAClJGjHx6zskT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220132

For platforms on powerpc architecture with a default page size greater
than 4096, there was an inconsistency in fragment size calculation.
This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
to fail on powerpc.

The issue occurred because the fragment buffer size in
bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
the fragment within the shared skb was checked against PAGE_SIZE
(65536 on powerpc) in min_t, causing it to exceed 4096 and be set
accordingly. This discrepancy led to an overflow when
bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
could be greater than rxq->frag_size (when PAGE_SIZE > 4096).

This commit updates the page size references to 4096 to ensure consistency
and prevent overflow issues in fragment size calculations.

Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 net/bpf/test_run.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249..eb5476184 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -124,7 +124,7 @@ struct xdp_test_data {
  * must be updated accordingly this gets changed, otherwise BPF selftests
  * will fail.
  */
-#define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head))
+#define TEST_XDP_FRAME_SIZE (4096 - sizeof(struct xdp_page_head))
 #define TEST_XDP_MAX_BATCH 256
 
 static void xdp_test_run_init_page(netmem_ref netmem, void *arg)
@@ -660,7 +660,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
+	if (size < ETH_HLEN || size > 4096 - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
 	if (user_size > size)
@@ -1297,7 +1297,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			frag = &sinfo->frags[sinfo->nr_frags++];
 
 			data_len = min_t(u32, kattr->test.data_size_in - size,
-					 PAGE_SIZE);
+					 4096);
 			skb_frag_fill_page_desc(frag, page, 0, data_len);
 
 			if (copy_from_user(page_address(page), data_in + size,
-- 
2.43.5


