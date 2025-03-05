Return-Path: <linux-kselftest+bounces-28325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012FA5062C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2B170BBC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09AE2512ED;
	Wed,  5 Mar 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p7fH49ia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FEA2512C7;
	Wed,  5 Mar 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194882; cv=none; b=ln5MUeTMgOk71ZEWO6x89asjU4UDPzAMpPCPoCqoFmHknA8ug7V6aLmMlCxDlv8C7Za5RQeEpwBfuFMrVg0MYTehD+ADVHtPrV47wOryrz3thRbLLqxOqtpkpRdpDq+rOpe5XAWyErr/uW1EEvCetr9o7R8oafQ4N9XZBbxEVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194882; c=relaxed/simple;
	bh=/owa1mj63bt9Tsa4VdjZAI7iiCHbetUYcndtq7TYXII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seRNXZLNuMEeLX270oXG5T6NNtwP0AWpQiZvKE1p+VKB9k7Z7EiwEFTXt0u2Uf0DyCh/YmGPuvNQvsBzjkB+tltlSgEMn6KhwUBfzukcC7whCkSJizenkm6bMHRXnNYs7kZNzlJKMN7V0hQGcjOpHo8n4ZR3a7Uq6ZaqpsXxhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p7fH49ia; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525GuaFh008325;
	Wed, 5 Mar 2025 17:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FQMHXETcR4THyQ4zh
	Vw4sOGljDMuD9z+itKTuBTW+Jk=; b=p7fH49ialH7gjMfORriC2UqHiV4D+aBds
	/MyqE8V8ThMFMjhtVoBscBQiAwDelyDmrIo0+rBUOsS20WWgUQesYqEE65jD4Fvg
	6ipdIzlNCZ84CmalYun4YfuXmMfVpfcdqoyOwMqkvvtW+NxqZg4IoFxNT0bSH9zv
	yVk/MEpYvDIGNo90bIycZLcv02qGZgRI2wDBlXw31D4+DZwfQQe455e7Vm+penUR
	+j4WBqUH7XlkKnYx1RtEMMircC9pDAnOyjYQXQtWINA2BHHIF+BQAKSkZgdey/ef
	UOXTThuHWQ9uPBoQ8MjkqFw2bG7JCPJicPZxfVSl+UOKR4Mol2J9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppcxsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525H9les014841;
	Wed, 5 Mar 2025 17:14:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppcxsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525FQ6Cq013776;
	Wed, 5 Mar 2025 17:14:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kutgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525HED3r37093666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 17:14:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A57220040;
	Wed,  5 Mar 2025 17:14:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F8320043;
	Wed,  5 Mar 2025 17:14:09 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.4.86])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 17:14:08 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        aleksander.lobakin@intel.com, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH v2 2/2] selftests/bpf: Refactor xdp_adjust_tail selftest with dynamic sizing
Date: Wed,  5 Mar 2025 22:43:56 +0530
Message-ID: <1aeebae060d2345331735636db5d8b2298ee5559.1741188826.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1741188826.git.skb99@linux.ibm.com>
References: <cover.1741188826.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HjEerogu2n5FtrjlqD5uH_9sYoDb7k2g
X-Proofpoint-ORIG-GUID: jiLQ7Og3g4qFFSLyBVyABDlXGXZPLtqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050127

The xdp_adjust_tail/xdp_adjust_frags_tail_grow selftest fails on
powerpc architecture platforms with a default page size greater than
4096 because the page size, tailroom and buffer size are hardcoded.

To resolve this issue, these parameters are now collected dynamically
in the test driver code and communicated to the BPF program using a
map:

1. Page size and cache line size are obtained using sysconf.
2. The size of struct skb_shared_info is determined using BTF.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 .../bpf/prog_tests/xdp_adjust_tail.c          | 160 +++++++++++++-----
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  41 +++--
 2 files changed, 149 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index b2b2d85dbb1b..2d1fafa9738e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include <network_helpers.h>
 
 static void test_xdp_adjust_tail_shrink(void)
@@ -41,21 +42,47 @@ static void test_xdp_adjust_tail_grow(void)
 {
 	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
 	struct bpf_object *obj;
-	char buf[4096]; /* avoid segfault: large buf to hold grow results */
+	struct btf *btf;
+	__u8 *buf;
 	__u32 expect_sz;
-	int err, prog_fd;
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = &pkt_v4,
-		.data_size_in = sizeof(pkt_v4),
-		.data_out = buf,
-		.data_size_out = sizeof(buf),
-		.repeat = 1,
-	);
+	int err, prog_fd, id, shinfo_size, map_fd;
+	int key = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int cache_linesize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (!ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
 
+	btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(btf))
+		return;
+
+	id = btf__find_by_name(btf, "skb_shared_info");
+	if (id < 0)
+		goto out;
+
+	shinfo_size = btf__resolve_size(btf, id);
+
+	map_fd = bpf_find_map(__func__, obj, "size");
+	if (map_fd < 0)
+		goto out;
+
+	bpf_map_update_elem(map_fd, &key, &shinfo_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &page_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &cache_linesize, BPF_ANY);
+
+	buf = malloc(page_size);
+
+	topts.data_in = &pkt_v4;
+	topts.data_size_in = sizeof(pkt_v4);
+	topts.data_out = buf;
+	topts.data_size_out = page_size;
+	topts.repeat = 1;
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv4");
 	ASSERT_EQ(topts.retval, XDP_DROP, "ipv4 retval");
@@ -63,45 +90,65 @@ static void test_xdp_adjust_tail_grow(void)
 	expect_sz = sizeof(pkt_v6) + 40; /* Test grow with 40 bytes */
 	topts.data_in = &pkt_v6;
 	topts.data_size_in = sizeof(pkt_v6);
-	topts.data_size_out = sizeof(buf);
+	topts.data_size_out = page_size;
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv6");
 	ASSERT_EQ(topts.retval, XDP_TX, "ipv6 retval");
 	ASSERT_EQ(topts.data_size_out, expect_sz, "ipv6 size");
 
+out:
 	bpf_object__close(obj);
+	btf__free(btf);
 }
 
 static void test_xdp_adjust_tail_grow2(void)
 {
 	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
-	char buf[4096]; /* avoid segfault: large buf to hold grow results */
+	__u8 *buf;
 	struct bpf_object *obj;
+	struct btf *btf;
 	int err, cnt, i;
-	int max_grow, prog_fd;
-	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
-#if defined(__s390x__)
-	int tailroom = 512;
-#elif defined(__powerpc__)
-	int tailroom = 384;
-#else
-	int tailroom = 320;
-#endif
-
-	LIBBPF_OPTS(bpf_test_run_opts, tattr,
-		.repeat		= 1,
-		.data_in	= &buf,
-		.data_out	= &buf,
-		.data_size_in	= 0, /* Per test */
-		.data_size_out	= 0, /* Per test */
-	);
+	int max_grow, prog_fd, id, shinfo_size, map_fd, tailroom;
+	int key = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int cache_linesize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (!ASSERT_OK(err, "test_xdp_adjust_tail_grow"))
 		return;
 
+	btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(btf))
+		return;
+
+	id = btf__find_by_name(btf, "skb_shared_info");
+	if (id < 0)
+		goto out;
+
+	shinfo_size = btf__resolve_size(btf, id);
+
+	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
+	tailroom = __ALIGN_KERNEL(shinfo_size, cache_linesize);
+
+	map_fd = bpf_find_map(__func__, obj, "size");
+	if (map_fd < 0)
+		goto out;
+
+	bpf_map_update_elem(map_fd, &key, &shinfo_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &page_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &cache_linesize, BPF_ANY);
+
+	buf = malloc(page_size);
+
 	/* Test case-64 */
-	memset(buf, 1, sizeof(buf));
+	memset(buf, 1, page_size);
+	tattr.repeat = 1;
+	tattr.data_in = buf;
+	tattr.data_out = buf;
 	tattr.data_size_in  =  64; /* Determine test case via pkt size */
 	tattr.data_size_out = 128; /* Limit copy_size */
 	/* Kernel side alloc packet memory area that is zero init */
@@ -120,25 +167,30 @@ static void test_xdp_adjust_tail_grow2(void)
 	ASSERT_EQ(buf[191], 1, "case-64-data buf[191]");
 
 	/* Test case-128 */
-	memset(buf, 2, sizeof(buf));
+	memset(buf, 2, page_size);
+	tattr.repeat = 1;
+	tattr.data_in = buf;
+	tattr.data_out = buf;
 	tattr.data_size_in  = 128; /* Determine test case via pkt size */
-	tattr.data_size_out = sizeof(buf);   /* Copy everything */
+	tattr.data_size_out = page_size;   /* Copy everything */
 	err = bpf_prog_test_run_opts(prog_fd, &tattr);
 
-	max_grow = 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
+	max_grow = page_size - XDP_PACKET_HEADROOM - tailroom; /* 3520 */
 	ASSERT_OK(err, "case-128");
 	ASSERT_EQ(tattr.retval, XDP_TX, "case-128 retval");
 	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128 data_size_out"); /* Expect max grow */
 
 	/* Extra checks for data content: Count grow size, will contain zeros */
-	for (i = 0, cnt = 0; i < sizeof(buf); i++) {
+	for (i = 0, cnt = 0; i < page_size; i++) {
 		if (buf[i] == 0)
 			cnt++;
 	}
 	ASSERT_EQ(cnt, max_grow - tattr.data_size_in, "case-128-data cnt"); /* Grow increase */
 	ASSERT_EQ(tattr.data_size_out, max_grow, "case-128-data data_size_out"); /* Total grow */
 
+out:
 	bpf_object__close(obj);
+	btf__free(btf);
 }
 
 static void test_xdp_adjust_frags_tail_shrink(void)
@@ -149,6 +201,7 @@ static void test_xdp_adjust_frags_tail_shrink(void)
 	struct bpf_object *obj;
 	int err, prog_fd;
 	__u8 *buf;
+
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	/* For the individual test cases, the first byte in the packet
@@ -214,26 +267,50 @@ static void test_xdp_adjust_frags_tail_grow(void)
 	__u32 exp_size;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	int err, i, prog_fd;
+	struct btf *btf;
+	int err, i, prog_fd, id, shinfo_size, map_fd;
+	int key = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int cache_linesize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
 	__u8 *buf;
+
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	obj = bpf_object__open(file);
 	if (libbpf_get_error(obj))
 		return;
 
+	btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(btf))
+		return;
+
 	prog = bpf_object__next_program(obj, NULL);
 	if (bpf_object__load(obj))
 		goto out;
 
 	prog_fd = bpf_program__fd(prog);
 
-	buf = malloc(16384);
-	if (!ASSERT_OK_PTR(buf, "alloc buf 16Kb"))
+	id = btf__find_by_name(btf, "skb_shared_info");
+	if (id < 0)
+		goto out;
+
+	shinfo_size = btf__resolve_size(btf, id);
+	map_fd = bpf_find_map(__func__, obj, "size");
+	if (map_fd < 0)
+		goto out;
+
+	bpf_map_update_elem(map_fd, &key, &shinfo_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &page_size, BPF_ANY);
+	key++;
+	bpf_map_update_elem(map_fd, &key, &cache_linesize, BPF_ANY);
+
+	buf = malloc(4 * page_size);
+	if (!ASSERT_OK_PTR(buf, "alloc buf (4 x page size)Kb"))
 		goto out;
 
 	/* Test case add 10 bytes to last frag */
-	memset(buf, 1, 16384);
+	memset(buf, 1, 4 * page_size);
 	exp_size = 9000 + 10;
 
 	topts.data_in = buf;
@@ -256,12 +333,12 @@ static void test_xdp_adjust_frags_tail_grow(void)
 		ASSERT_EQ(buf[i], 1, "9Kb+10b-untouched");
 
 	/* Test a too large grow */
-	memset(buf, 1, 16384);
-	exp_size = 9001;
+	memset(buf, 1, 4 * page_size);
+	exp_size = 2 * page_size + 1;
 
 	topts.data_in = topts.data_out = buf;
-	topts.data_size_in = 9001;
-	topts.data_size_out = 16384;
+	topts.data_size_in = 2 * page_size + 1;
+	topts.data_size_out = 4 * page_size;
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 
 	ASSERT_OK(err, "9Kb+10b");
@@ -271,6 +348,7 @@ static void test_xdp_adjust_frags_tail_grow(void)
 	free(buf);
 out:
 	bpf_object__close(obj);
+	btf__free(btf);
 }
 
 void test_xdp_adjust_tail(void)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index dc74d8cf9e3f..f19e5322711b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -1,36 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
+#include <linux/const.h>
 #include <bpf/bpf_helpers.h>
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, int);
+} size SEC(".maps");
+
 SEC("xdp")
 int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 {
 	int data_len = bpf_xdp_get_buff_len(xdp);
 	int offset = 0;
+	int *page_size, *shinfo_size, *cache_linesize;
+	int tailroom, key = 0;
+
+	shinfo_size = bpf_map_lookup_elem(&size, &key);
+	if (!shinfo_size)
+		return XDP_ABORTED;
+	key++;
+
+	page_size = bpf_map_lookup_elem(&size, &key);
+	if (!page_size)
+		return XDP_ABORTED;
+	key++;
+
+	cache_linesize = bpf_map_lookup_elem(&size, &key);
+	if (!cache_linesize)
+		return XDP_ABORTED;
+
 	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
-#if defined(__TARGET_ARCH_s390)
-	int tailroom = 512;
-#elif defined(__TARGET_ARCH_powerpc)
-	int tailroom = 384;
-#else
-	int tailroom = 320;
-#endif
+	tailroom = __ALIGN_KERNEL(*shinfo_size, *cache_linesize);
 
 	/* Data length determine test case */
 
 	if (data_len == 54) { /* sizeof(pkt_v4) */
-		offset = 4096; /* test too large offset */
+		offset = *page_size; /* test too large offset */
 	} else if (data_len == 74) { /* sizeof(pkt_v6) */
 		offset = 40;
 	} else if (data_len == 64) {
 		offset = 128;
 	} else if (data_len == 128) {
 		/* Max tail grow 3520 */
-		offset = 4096 - 256 - tailroom - data_len;
+		offset = *page_size - 256 - tailroom - data_len;
 	} else if (data_len == 9000) {
 		offset = 10;
-	} else if (data_len == 9001) {
-		offset = 4096;
+	} else if (data_len == 2 * (*page_size) + 1) {
+		offset = *page_size;
 	} else {
 		return XDP_ABORTED; /* No matching test */
 	}
-- 
2.43.5


