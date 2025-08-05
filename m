Return-Path: <linux-kselftest+bounces-38274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECBB1AE3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A8189062D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68121ABD4;
	Tue,  5 Aug 2025 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phMkDhma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8921401B;
	Tue,  5 Aug 2025 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375326; cv=none; b=JYu9u6seqbl76u/t4iLqju7QiFNEzeOAq8CUny2E8dAZBgj0HhKpSims+10gTTSrCqqoPy6XTBZ7/Gt7eaMi5jian5MHdMMdPqSH8tnGj2Zd1tBSe7KzusegdrmO9Sz58BE/vZJ664DJOZckUmzXF156l1MSc0vFavvnC2FAmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375326; c=relaxed/simple;
	bh=1dFmJ/aPHCJKe9xTs6NAdOgXOJO+ndjlsJcByNIvA+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSorwaCMbNAua7HsMJ5/7YFwRi/xxO3+gsb82bj0GB7M8ha82zZAuHOKSP63Sorh2zkW2vCqNVeyJ1mTKWnV1whFGWRR24KdF7lIlFRxaE46vIHCm6ZJHdErxEdaAO41kixmacV6BPyq40vhPwEhuugfWBTF+WmqBFRA78NByTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phMkDhma; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754uWpT001514;
	Tue, 5 Aug 2025 06:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8uIJuR9UrU7MGTqSwYlkqz64897zNUcWple/qkX3k
	/M=; b=phMkDhma8rvwYT8kX9eTP3VOJItnH0i8AZbql1uBSlxFEcoEdAZoNRobn
	IQFw7UZIwbIoikKM6Rvh61Lh6gknFxzXJJhgYDIdgP9qRai4sNR1yfMqmM1jhdft
	vinleBCbRRoRmGw91zjbqQx7HDKRneswYYtUIP1W4HOrKZhHir8sDoSFpmunX4uk
	0UdMRUFPtPh6cG60duERG+UPUfatyjxLAkBUjd41ywWCAXTxiF0Aop93GV0RCOCo
	yM493kd+jaoO4iAZMfLpekcgSF85d6434dre3fHu5EaELozt2O9b3ohknwPJOQXn
	Nzod7oG3v1O+sxfVXnVMpncLfvRgA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq09s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5756NCbR006902;
	Tue, 5 Aug 2025 06:28:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq09s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5754fB3P006873;
	Tue, 5 Aug 2025 06:28:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmh3u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5756S2pb42271158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 06:28:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4299C2004D;
	Tue,  5 Aug 2025 06:28:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70CE020043;
	Tue,  5 Aug 2025 06:27:55 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.39.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 06:27:55 +0000 (GMT)
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
Subject: [bpf-next 0/6] bpf,powerpc: Add support for bpf arena and arena atomics
Date: Tue,  5 Aug 2025 11:57:41 +0530
Message-ID: <20250805062747.3479221-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UMmdy6bvE1EWRZnnAASiwlqph1l7sE6d
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891a477 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=XcCzD8yPhtL1pJmi5pkA:9
X-Proofpoint-ORIG-GUID: 0uFU9b9z2tVP7R2TCtIrI-HJLKmEzpe3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NSBTYWx0ZWRfX0nqFUJvFAVfW
 cwwDfeCJGT5nBPuvxbgMUop1ZXXgqblArZk0C/tE7aOh46rQ0TLP/Brk+NsngH6oPe97utZs5wX
 Gxy/3QaCuzUzrTe0OJmbvLSQZeqOgDCO8SFRkTacG5UVLrjYDTr3Q9AC99XeipE1y7XJ1atHn5d
 SbTCtXxh861mYmCkQIELqPPI0DasAeC+xUvUSmualO1mhFHcJaPi4EWEaj5A7G4am+Lg3nJZMgF
 XMKUBJTdYaGubDEGSlHEbGNwW5RN/E+fAQatrSe1MoBMtm+pg9cjibEOuuJa+y2U4cCR+t4Qg5M
 VmcTd7S/uFp7pXyL2at9tv6thbkq34/crQ5lccc5F1tubFcUlfwomj0NKvsr4mOR1SrIpvk6BHN
 S6/dguMR0eHjijnsXbGtnHHmSB70qYJRzK/wvEcGJ4+Ny0FGdehy4ATFpyarIlWiu1lcJE0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=612 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050045

This patch series introduces support for the PROBE_MEM32,
bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF JIT,
facilitating the implementation of BPF arena and arena atomics.

The last patch in the series has fix for arena spinlock selftest
failure.

This series is rebased on top of:
https://lore.kernel.org/bpf/20250717202935.29018-2-puranjay@kernel.org/

All selftests related to bpf_arena, bpf_arena_atomic(except
load_acquire/store_release) enablement are passing:

# ./test_progs -t arena_list
#5/1     arena_list/arena_list_1:OK
#5/2     arena_list/arena_list_1000:OK
#5       arena_list:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t arena_htab
#4/1     arena_htab/arena_htab_llvm:OK
#4/2     arena_htab/arena_htab_asm:OK
#4       arena_htab:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t verifier_arena
#464/1   verifier_arena/basic_alloc1:OK
#464/2   verifier_arena/basic_alloc2:OK
#464/3   verifier_arena/basic_alloc3:OK
#464/4   verifier_arena/iter_maps1:OK
#464/5   verifier_arena/iter_maps2:OK
#464/6   verifier_arena/iter_maps3:OK
#464     verifier_arena:OK
#465/1   verifier_arena_large/big_alloc1:OK
#465/2   verifier_arena_large/big_alloc2:OK
#465     verifier_arena_large:OK
Summary: 2/8 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t arena_atomics
#3/1     arena_atomics/add:OK
#3/2     arena_atomics/sub:OK
#3/3     arena_atomics/and:OK
#3/4     arena_atomics/or:OK
#3/5     arena_atomics/xor:OK
#3/6     arena_atomics/cmpxchg:OK
#3/7     arena_atomics/xchg:OK
#3/8     arena_atomics/uaf:OK
#3/9     arena_atomics/load_acquire:SKIP
#3/10    arena_atomics/store_release:SKIP
#3       arena_atomics:OK (SKIP: 2/10)
Summary: 1/8 PASSED, 2 SKIPPED, 0 FAILED

All selftests related to arena_spin_lock are passing:

# ./test_progs -t arena_spin_lock
#6/1     arena_spin_lock/arena_spin_lock_1:OK
#6/2     arena_spin_lock/arena_spin_lock_1000:OK
#6/3     arena_spin_lock/arena_spin_lock_50000:OK
#6       arena_spin_lock:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Saket Kumar Bhaskar (6):
  bpf,powerpc: Introduce bpf_jit_emit_probe_mem_store() to emit store
    instructions
  bpf,powerpc: Implement PROBE_MEM32 pseudo instructions
  bpf,powerpc: Implement bpf_addr_space_cast instruction
  bpf,powerpc: Introduce bpf_jit_emit_atomic_ops() to emit atomic
    instructions
  bpf,powerpc: Implement PROBE_ATOMIC instructions
  selftests/bpf: Fix arena_spin_lock selftest failure

 arch/powerpc/net/bpf_jit.h                    |   6 +-
 arch/powerpc/net/bpf_jit_comp.c               |  32 +-
 arch/powerpc/net/bpf_jit_comp32.c             |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c             | 378 +++++++++++++-----
 .../bpf/prog_tests/arena_spin_lock.c          |  23 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |   8 +-
 .../selftests/bpf/progs/bpf_arena_spin_lock.h |   4 +-
 7 files changed, 348 insertions(+), 105 deletions(-)

base-commit: ea2aecdf7a954a8c0015e185cc870c4191d1d93f
-- 
2.43.5


