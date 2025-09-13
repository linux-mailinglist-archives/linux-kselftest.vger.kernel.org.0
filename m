Return-Path: <linux-kselftest+bounces-41439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB9B55FC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 11:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393651B27DDC
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0B2EA473;
	Sat, 13 Sep 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FWHFl+il"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C874230BDF;
	Sat, 13 Sep 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754865; cv=none; b=HbR6ZFsF16fm5+YEwx5IA8tz4+3vVH9kR/MHl4QYyA7WnqtQp61erCcopvvmuJPII5Ntz/xLqn6Na+rZxr0+nItDiahqQS/y8TuH5Sb3SCTglTMlSfaBYY+IgG7fFQDKmN8YU8JwH28qhhyDEVdvq4u7IC8P38LGqQ9eKiwBl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754865; c=relaxed/simple;
	bh=+qnsQee1LyeezvoNoW0nM0bf6EfuWq5Ish2LHgXEN7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gy9emYCJMHyiC/mTCZI+9wMC14XjzYnIwsQJujFfh+8TeRcBpfGxSz1VeLbqNBsVCUKJaHXPueechr+LkIFdXtR3Nkz1OQ3rRMD+dg17CJqi+b4vQnCtYh9BJx2EL2xI8j1xIRSaZJBqS5rZ1giQq+5OGnwegRop6NVY4US2FJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FWHFl+il; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58D7afXo023364;
	Sat, 13 Sep 2025 09:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FoiVZdP+olli/54KUOjFx7GwmsNZliJqSYCn3idr9
	MQ=; b=FWHFl+iljlhYxHEcrTFKQHDYUZ0OLX7b6P6PWWfccwy+jcgwHhoxcDC85
	KuwzHXvGyX/oXcdzOM6W5IRjsLObM8NQKCnnlxe2NHzE4M07rCgcu+QodSOdTGQG
	udCf6aeJv6gWYB9G0nZnn4oPvmHSfuHufNuuwXUcX/T0uaeos2JQYjysApEdgy0B
	Hie6lM+/9a6tf9c/mn8rTNo6f2dG+5AsBIG7bEELi82R9Iki3mmTtN3y6zuScULT
	iUYVk+kueS/OiQPeXzGw8w/Add81WsStBCH9lF/yurS0jok+Ruz2OB66ppiHnHh/
	WGpMkkxD8FPKNxFkCKP6VUHQBb3Bg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509xrvnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 09:14:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58D9DxbU004683;
	Sat, 13 Sep 2025 09:13:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509xrvng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 09:13:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58D4emjC001198;
	Sat, 13 Sep 2025 09:13:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203xpb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 09:13:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58D9Ds2A47382940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 09:13:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7946020043;
	Sat, 13 Sep 2025 09:13:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D0520040;
	Sat, 13 Sep 2025 09:13:44 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.33.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Sep 2025 09:13:44 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        iii@linux.ibm.com, shuah@kernel.org
Subject: [PATCH v3 bpf-next] selftests/bpf: Fix arena_spin_lock selftest failure
Date: Sat, 13 Sep 2025 14:43:37 +0530
Message-ID: <20250913091337.1841916-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX1C1+IaIOaBM7
 A/zHZH/02LNF5rHF+6fw4W+aOT0mqcomI+iMlkXEie8zluqc2k8PzN3kbyn8bT8TqrcfZHv4RNm
 aFKjhRxhbNsunQMW7pFJjmsEV7hUWQAlll3qyVhrrCqqAN4CZ9p1Y4VcwC/F8n7icSCp/FKut+p
 W4b2if0kKK2Gpy1berG2oOIptvwD3a4AKdIUqw5WcBkvNgW46Tm1Otv5WRdbaiEeVsNIX0WABsa
 eZNqtea+PfDtr/DZq5kka1zKoLmP5bh6RWWZtx8HKp+p5l6/OJt165BmjdlBqC0Ptd/6fH+MU6k
 9WFupfkojN/j60Yk3tKdSwxXH5T6n1W5z3LfkbtQChRnTgTGlX+rnvtP3aM/Xsk3+oi1KBAhm0C
 nWM14lK0
X-Authority-Analysis: v=2.4 cv=OPYn3TaB c=1 sm=1 tr=0 ts=68c535d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VDBL6iswcQKEKxwn1pUA:9
X-Proofpoint-GUID: NAWLiaGerAFNkwaix02iGaKY4vjUsgs3
X-Proofpoint-ORIG-GUID: XwJnrVJ3HluXiykCE2VXzpV5TVpklbYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020

For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.
(eg - incase of powerpc default value for CONFIG_NR_CPUS is 8192)

The selftest is skipped incase bpf program returns EOPNOTSUPP,
with a descriptive message logged.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---

Changes since v2:
* Separated arena_spin_lock selftest fix patch from the arena
  patchset as it has to go via bpf-next tree.
* For EOPNOTSUPP set test_skip to 3, to differentiate it from
  scenarios when run conditions are not met as suggested by Hari.
* Tweaked message displayed on SKIP to remove display of online
  cpus.

v2:https://lore.kernel.org/all/20250829165135.1273071-1-skb99@linux.ibm.com/

Changes since v1:
Addressed comments from Alexei:
* Removed skel->rodata->nr_cpus = get_nprocs() and its usage to get
  currently online cpus(as it needs to be updated from userspace).

v1:https://lore.kernel.org/all/20250805062747.3479221-1-skb99@linux.ibm.com/

---
 .../selftests/bpf/prog_tests/arena_spin_lock.c      | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/arena_spin_lock.c |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 0223fce4db2b..693fd86fbde6 100644
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
 
+	if (skel->data->test_skip == 3) {
+		printf("%s:SKIP: CONFIG_NR_CPUS exceed the maximum supported by arena spinlock\n",
+		       __func__);
+		test__skip();
+		goto end_barrier;
+	}
+
 	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
 
 end_barrier:
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index c4500c37f85e..086b57a426cf 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -37,8 +37,11 @@ int prog(void *ctx)
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	unsigned long flags;
 
-	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
+	if ((ret = arena_spin_lock_irqsave(&lock, flags))) {
+		if (ret == -EOPNOTSUPP)
+			test_skip = 3;
 		return ret;
+	}
 	if (counter != limit)
 		counter++;
 	bpf_repeat(cs_count);
-- 
2.43.5


