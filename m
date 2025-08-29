Return-Path: <linux-kselftest+bounces-40321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E3AB3C133
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3431CC4221
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50633471C;
	Fri, 29 Aug 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KU0o8w6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2647334728;
	Fri, 29 Aug 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486361; cv=none; b=uwsv9AaAhbz3yBAQTNjdYD4+/EFCUwKDW1OoQv8Vy5sMfsrOsoTcMUhDm4F3plxL3tnap8j4FMIj1pmrZgXinN5CzAzgEr8NzBvVB2ez+I0G+TmuV3iPSGmC6ErnE6RX25edDyeZMSGd7npEb7SEuJeQg+ugp0a2ylGQoG4LXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486361; c=relaxed/simple;
	bh=x+xH53YQb9EakbZ3AVhMHHkz3gMkQ3tO/HVCyl3Zzgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbMg3Po5ifr5cMCqEoogJVgPS2XI8AMvhkhYbwi36+qQDlhA36lYpZMEHhaED8MrOiBVhmt8qmCkiy5N5O8Orkb68St+FkT84gm7QNwXI3WUNCEuepxt9B0rBaH8Ok2n4tnZ+831+OPrYhDUwa7nCm1S7dDMdkDSbwyxnodNDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KU0o8w6j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8HQvx006069;
	Fri, 29 Aug 2025 16:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c8SHqim3/SaVNQk5asDCwT4jClyRt7JLZlbeSe5TI
	H0=; b=KU0o8w6jDR1olDqX3bHen+kp+23kMNPJk+teCJK4LxHEZj2wVIrTJRddi
	0xtHvJXrtpWA38o6vXYxi51L7Q4vLdp68XopBSp8XddsZ9Nyggzg2kVHy69Nr7iB
	JCBW0zxOtuv39pMKDa/x4UxgXP7zMPZh3nJFw+M4k+ysFf63qD3R6yjw5NuK2NpN
	PmYuHJ5a84YAhyU4nqB8dWHTzE+awlBaa082PxpeBspZxGDZ3vYxkoeM5GdG2st+
	xTKcuReGQFiOKfeJtxZZ420YTXRzmHZtp1JLA3vU/LlGwR44j7WticrGxjRxRrcF
	5MBQgNOkX/14HJGjomuq1q/IVkUHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5d7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TGe2Hg005069;
	Fri, 29 Aug 2025 16:52:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5d7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:52:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGJsUW002612;
	Fri, 29 Aug 2025 16:51:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mtgcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:51:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TGptIu40173934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 16:51:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504992004B;
	Fri, 29 Aug 2025 16:51:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E772004D;
	Fri, 29 Aug 2025 16:51:42 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.115.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 16:51:42 +0000 (GMT)
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
Subject: [bpf-next v2 0/5] powerpc64/bpf: Add support for bpf arena and arena atomics
Date: Fri, 29 Aug 2025 22:21:30 +0530
Message-ID: <20250829165135.1273071-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eIvg7BVF2e0ZLGaTL43BuaQXJGTQZtVm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDE0MCBTYWx0ZWRfX8J72g+sxb4tK
 8tRmeIRLhgCzybAVwkfu0iJL0FB67/NKwDhiuPZFOYH6XAaAY0mGffn5AvZrM/lgo7ebzyTP5bH
 oO1Y8FSEDNLVW4H7OfWfuxFlfI15wHMzSwbsw4yhfa29F8NcOFN7ImOOKg2saLPYEP5U1ieCEKq
 zGQCUqCoaBmYTuXf0Rugp8Pl1gE9MbYfFCa6WdIaWvYn5QcjWrCnltnQ8rVJ5dGAtLwu8UpmlSe
 SSdg7bb/0KOuGn8g4Aep+saxYOchXelEyqOYFZqnn6HNff9IuI4NFTms+9SnaXKJGjy9agmT1rJ
 Ppi4EOHXUhzWUO2ht0dpdap/GX26ol1X7q/C7iJ8vTtyXaEfpi/+lt2GUIV+WvKUKSmOVIfnaQo
 S4iQs8BE
X-Authority-Analysis: v=2.4 cv=YfW95xRf c=1 sm=1 tr=0 ts=68b1dab0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=NlV2FhzisVifXC3_P1sA:9
X-Proofpoint-ORIG-GUID: gu0QOT9AvOPte3FWcTY5ebvVom2qsnhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280140

This patch series introduces support for the PROBE_MEM32,
bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF JIT,
facilitating the implementation of BPF arena and arena atomics.

The last patch in the series has fix for arena spinlock selftest
failure.

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

Changes since v1:

Addressed comments from Chris:
* Squashed introduction of bpf_jit_emit_probe_mem_store() and its usage in
  one patch.
* Defined and used PPC_RAW_RLDICL_DOT to avoid the CMPDI.
* Removed conditional statement for fixup[0] = PPC_RAW_LI(dst_reg, 0);
* Indicated this change is limited to powerpc64 in subject.

Addressed comments from Alexei:
* Removed skel->rodata->nr_cpus = get_nprocs() and its usage to get
  currently online cpus(as it needs to be updated from userspace).

Saket Kumar Bhaskar (5):
  powerpc64/bpf: Implement PROBE_MEM32 pseudo instructions
  powerpc64/bpf: Implement bpf_addr_space_cast instruction
  powerpc64/bpf: Introduce bpf_jit_emit_atomic_ops() to emit atomic
    instructions
  powerpc64/bpf: Implement PROBE_ATOMIC instructions
  selftests/bpf: Fix arena_spin_lock selftest failure

 arch/powerpc/include/asm/ppc-opcode.h         |   1 +
 arch/powerpc/net/bpf_jit.h                    |   6 +-
 arch/powerpc/net/bpf_jit_comp.c               |  32 +-
 arch/powerpc/net/bpf_jit_comp32.c             |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c             | 401 +++++++++++++-----
 .../bpf/prog_tests/arena_spin_lock.c          |  13 +
 .../selftests/bpf/progs/arena_spin_lock.c     |   5 +-
 7 files changed, 347 insertions(+), 113 deletions(-)

-- 
2.43.5


