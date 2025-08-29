Return-Path: <linux-kselftest+bounces-40326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C3B3C14C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8DAA23EAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5195340D8A;
	Fri, 29 Aug 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bV8oV+uj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B1340D86;
	Fri, 29 Aug 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486411; cv=none; b=H62oTxJVroXiJ9U5emVNi9WDFsd1NLw2VNeF8JURLM7DnUe0vMJf0lfAzFLr0JWv091/MoJ3juIp7sf6JJ9uIYCoPBHbMV/sjFCkCUj3OYT3YAqvMToqaiPK9OhoEij7HC86f/1WOh+Ltul8cvztbo+XQm6etDaniiEjbhcy0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486411; c=relaxed/simple;
	bh=ulRFzuagZFEOnjiOpDqhKWXsZK1C/pxXB+6+UfqLhE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR7ziTAsXqMyD93oWJLZZBcGKVbCIYXmO/lPFxN65JLz24wGhbOhVjvfV/xgEkyWvFoRNnzs4A7jN33Gb/S3+yIA8ficVMNk/e75Jl6kk7cVZbpAZyHXoTLdq9yuK0qcCLjDEGGwR6BJpvFuQyuWa/Wz+ZBmpIvTNB9+ChFgKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bV8oV+uj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8HQTC006066;
	Fri, 29 Aug 2025 16:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wlQ/7c3rr2aJ6RJOQ
	VKI6Viuq+AoqlPLvHQiVunbhEM=; b=bV8oV+ujkRy7ajVWehnsSa6bmca92t1lh
	D7aUk8lXfP6+ZvMQydOu5RCGFNT+VpciYnbQIQvtMLbhwvlJlqz3LObzzPLnvqV6
	yM67jDWVPePVww3dyKrmrB1F9KIztHWIq1jINMmLb58Rkvqd/TubvTO/NZRfkvqb
	E90kltUNQkoVT8bqDON33bBDX98yvZ9qvuyzH/gmroHrJ8+3+x/QG5nMn+06bwCZ
	00cuAKy1jiYMRmBGGcEaZ/LiBy4dK6/bEUmGN9PSnFo4Z0QANAzd5JdPNtgYW0Gx
	VmnHQGW0ifZkDL/97YuiU5/NNYnGIX4t0VlyeUTpcnq4jnTY95bJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5dfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:53:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TGfafe007210;
	Fri, 29 Aug 2025 16:53:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5df5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:53:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57TD5eBL017963;
	Fri, 29 Aug 2025 16:53:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3tbxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:53:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TGqwYl50463098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 16:52:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78CE32004F;
	Fri, 29 Aug 2025 16:52:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD5CB20043;
	Fri, 29 Aug 2025 16:52:46 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.115.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 16:52:46 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Fix arena_spin_lock selftest failure
Date: Fri, 29 Aug 2025 22:21:35 +0530
Message-ID: <20250829165135.1273071-6-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250829165135.1273071-1-skb99@linux.ibm.com>
References: <20250829165135.1273071-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lJPbpMxxCuoUV2wEYR8WIRlW-ihiAIKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDE0MCBTYWx0ZWRfX3iokaRGCKrjx
 v+MT8ILcp1yH1C7IUl0vluo9d9b6WyKiSU2mhtAXLlSr6PmppMNLhUCLceO+gjz2pvw7t2i1b0j
 7KUz3ZI2HiXJbek1VP2tyc3ZeAIzqJjmk367RuXavsN/JqzpY1H3HPT+6Sr4d5o1k2h4Ix3T9yl
 fnDc+chQ2/AC4LfYBow6zqeFvTHW+ZYXpyFAg7Up99+Bn8GHs7Czm36UVZbWA59eDVHjUKG3OL9
 iOdPK0GjKAmKsnTIKKhsNckqov82hD/sydcqtTYxXe2GZcr2GfuKL1TuscrHBKJ/YYiqvIjkj20
 sJnBzXXu8zZ/B4A0+oK4vJ69GpPnLW7+w3WR1fdEEuCTSyLvgW+mCrfikm53pTgyoxODucKC58u
 d/Ou1h5N
X-Authority-Analysis: v=2.4 cv=YfW95xRf c=1 sm=1 tr=0 ts=68b1daf0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=dOPeAGjUFLo6ntbE7XwA:9
X-Proofpoint-ORIG-GUID: ljkqhl2cCsTRUbADYNfMguYbVHlJ4kQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280140

For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.

The selftest is skipped incase bpf program returns EOPNOTSUPP,
with a descriptive message logged.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/arena_spin_lock.c      | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/arena_spin_lock.c |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 0223fce4db2b..1ec1ca987893 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -40,8 +40,13 @@ static void *spin_lock_thread(void *arg)
 
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run err");
+
+	if (topts.retval == -EOPNOTSUPP)
+		goto end;
+
 	ASSERT_EQ((int)topts.retval, 0, "test_run retval");
 
+end:
 	pthread_exit(arg);
 }
 
@@ -63,6 +68,7 @@ static void test_arena_spin_lock_size(int size)
 	skel = arena_spin_lock__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
 		return;
+
 	if (skel->data->test_skip == 2) {
 		test__skip();
 		goto end;
@@ -86,6 +92,13 @@ static void test_arena_spin_lock_size(int size)
 			goto end_barrier;
 	}
 
+	if (skel->data->test_skip == 2) {
+		printf("%s:SKIP: %d CPUs exceed the maximum supported by arena spinlock\n",
+		       __func__, get_nprocs());
+		test__skip();
+		goto end_barrier;
+	}
+
 	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
 
 end_barrier:
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index c4500c37f85e..a475b974438e 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -37,8 +37,11 @@ int prog(void *ctx)
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	unsigned long flags;
 
-	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
+	if ((ret = arena_spin_lock_irqsave(&lock, flags))) {
+		if (ret == -EOPNOTSUPP)
+			test_skip = 2;
 		return ret;
+	}
 	if (counter != limit)
 		counter++;
 	bpf_repeat(cs_count);
-- 
2.43.5


