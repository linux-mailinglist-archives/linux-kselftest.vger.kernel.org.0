Return-Path: <linux-kselftest+bounces-21357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219D9BABF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 06:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DCE1C20C13
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7818B491;
	Mon,  4 Nov 2024 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RtNDSqr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C9176FD2;
	Mon,  4 Nov 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696477; cv=none; b=VKAFuCV8Nl0HldSZrw/P4q3lg6MJ5e66FBUlbngrQoyWClTfqp2e6eYtioo00EheU7/iOAmlY8IRLDr3Ug9fEcek78ghgSUfw9QmvOzRyOPe6PZN/PaG50JWnlHio3aRl3I0YU+gLZTbLnVemDnIsav2kZEeU5FlQMHcs+TtKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696477; c=relaxed/simple;
	bh=eNk1qrWiIpqyQruMIXPEsp0Zl9FdbV4nynjf+0NTCLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrKgtHGpcOS/mYMnyGT9o9wKSIQbu932EPztMxZZQ6mURacOWqtMwkk3DR/v7dV5bc/1u73NFuQORCuqp4eAOpF/hcl7yMsroIxmkAdqEyiJQEb845NB5sFV/2GLV1Bvv7+oZrrrsYgoTglvWiP1EYms9CKiGAdEO4ykoQW4YhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RtNDSqr/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A44CB5N010647;
	Mon, 4 Nov 2024 05:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D8Pdin9KD/HZgOJgF
	RoUxc38HRKm5PW4gSCHApqk8To=; b=RtNDSqr/1+scKOCjmmF7aSgzW3w8+6y4Y
	nO1GX9O0H5lbk7vcjXpKUY2ZBvVejbNV8Z7ifjCI95BgsqeBPVmk0cYWZKl+Rep9
	RWZ3Y+/qSQmQOTpfojZPh1wNXdSQQp1rAa2zYiCDeIlnpdWwLtAgnre46mwER+tt
	4Ic+BiZSuyqKNLUdLDWDz7Xiqv3822NZn/2R0i27tJAldOlRLsYjcC2qjW6e4RKW
	IpzfrEK11LpjKZImYF3Zuvp9Kv6W3ki8GvTLKW37FDIhtphmKXLxSlRSJl8UVdXO
	MqeNSxBjF+2DcjVucVr6V9rmLvx1KNUprwMycEREvTuBmE7ssIYTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pq1802rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A44vPut026739;
	Mon, 4 Nov 2024 05:00:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pq1802rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3HaJWw031980;
	Mon, 4 Nov 2024 05:00:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmhfwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A450mx444171656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 05:00:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C4E20049;
	Mon,  4 Nov 2024 05:00:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8A3C20040;
	Mon,  4 Nov 2024 05:00:40 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.56.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 05:00:40 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: [PATCH 3/3] selftests/bpf: Define SYS_PREFIX for powerpc
Date: Mon,  4 Nov 2024 10:30:07 +0530
Message-ID: <20241104050007.13812-4-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104050007.13812-1-skb99@linux.ibm.com>
References: <20241104050007.13812-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1GqNEolRUvHbgFwfZATml1biJkH79Wx5
X-Proofpoint-ORIG-GUID: K3AwoyN1KAqLUxWn-02SYeT0C1tgoaV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=641 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040039

SYS_PREFIX was missing for a powerpc, which made a kprobe test to
sys_prctl fail.

Add missing SYS_PREFIX for powerpc.

Fixes: 7e92e01b7245 ("powerpc: Provide syscall wrapper")
Fixes: 94746890202c ("powerpc: Don't add __powerpc_ prefix to syscall entry points")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index eccaf955e394..ae6beb2fb480 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -160,6 +160,9 @@
 #elif defined(__TARGET_ARCH_riscv)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__riscv_"
+#elif defined(__TARGET_ARCH_powerpc)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX ""
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.43.5


