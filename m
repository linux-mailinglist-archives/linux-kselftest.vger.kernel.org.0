Return-Path: <linux-kselftest+bounces-25464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091AA239B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B11889A7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F4154C0F;
	Fri, 31 Jan 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LxbovKcB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981A24B28;
	Fri, 31 Jan 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307175; cv=none; b=M+AB5lk+9Zw5JR2rRhAH5ZmAgWl3I1zxrVo99d/AqiqjVG9k22ZaFRekew0g9PN9KvcfwBzSejfS2pzaERuSmY2Qhk+wqpypENP+/Tay0F7BFiQ6ukXUH0eT6G7jQZReZJemf9zznVx23R5iEwXRIMaGrh9KpyslRhyl441qLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307175; c=relaxed/simple;
	bh=pshiCbXz/83jLl1+ncCvT6mqu+aUjrCfWsAw6O35ras=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIY0Oth3tYPM0kxRn6okKgCokyIOVieFtJCV7XQpcg1FT/WiuYJvqzTkm4FNDUEActqWboW3paWV7q527fMhYa4mBHdeJKNXgO0GP6pWET2gjAdYn4qO0WU+KmJCcj1orPDUDH9LCvs2HMOdqnSCLLTudOukNROVS6uIunR+oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LxbovKcB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OJKw016476;
	Fri, 31 Jan 2025 07:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Yn1XnPAMm6dT2it8c
	07zbhvGMPiEa/1oZcrNgYlfs7M=; b=LxbovKcB593YRDz0tW+HE89F9PFACij99
	it0TOD6WBv3rzjyderu/++sbbyBNThOypoCxDZBXrIAk9xUEkvC5p1eQQNA/zeac
	v7SItB3HmPsOyinQ3B4Uowk+WfPch0+p6T1LABcKHUMcXo9xUswE+qGyA6suuWKV
	dpeyunCMK/moQJuTo1fOYuCndBpEYi3KgzG/6yNwWkopvN0iS1qNzURpCpl9qxf0
	n4/QPgynAWGapWroqvGy8Q1NYerG4Eu+5f9vlV/kf4LRTYK5MwynfeHmZ1xTjuSQ
	KNWVa2qxOguzBh1apQVDuqZTZl2VLgKSN9vMV1zifwHnEo5aXNDWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk913eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50V6oOer014943;
	Fri, 31 Jan 2025 07:05:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk913en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V3jhbO010192;
	Fri, 31 Jan 2025 07:05:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfa0jckr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50V75mhn34603388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 07:05:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10EA200C1;
	Fri, 31 Jan 2025 07:05:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2BBC200C4;
	Fri, 31 Jan 2025 07:05:39 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.60.42])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 07:05:39 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Subject: [PATCH v2 2/2] selftests/bpf: Select NUMA_NO_NODE to create map
Date: Fri, 31 Jan 2025 12:35:22 +0530
Message-ID: <cf1f61468b47425ecf3728689bc9636ddd1d910e.1738302337.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
References: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pB-ewzW6wOU7c5psg7Wusc6bxHsVKTuF
X-Proofpoint-ORIG-GUID: rgYwxIUUWr2sqUQa7zk2XW_vjWX1M9DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_02,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=825
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310051

On powerpc, a CPU does not necessarily originate from NUMA node 0.
This contrasts with architectures like x86, where CPU 0 is not
hot-pluggable, making NUMA node 0 a consistently valid node.
This discrepancy can lead to failures when creating a map on NUMA
node 0, which is initialized by default, if no CPUs are allocated
from NUMA node 0.

This patch fixes the issue by setting NUMA_NO_NODE (-1) for map
creation for this selftest.

Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index cc184e442..67557cda2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -6,6 +6,10 @@
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
+#ifndef NUMA_NO_NODE
+#define NUMA_NO_NODE	(-1)
+#endif
+
 static void test_fail_cases(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
@@ -69,6 +73,7 @@ static void test_success_cases(void)
 
 	/* Create a map */
 	opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
+	opts.numa_node = NUMA_NO_NODE;
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
 	if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter success case"))
 		return;
-- 
2.43.5


