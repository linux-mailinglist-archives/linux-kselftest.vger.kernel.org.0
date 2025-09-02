Return-Path: <linux-kselftest+bounces-40614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E7B40900
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309A73A3433
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93C31E0FB;
	Tue,  2 Sep 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kgqXbrBz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102818EB0;
	Tue,  2 Sep 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827298; cv=none; b=lsEA/ql7ZgeN3Mp6/QgKGnKdjO/yWayQDRqbKBjXBoP4K8MnbB0lQ54Nd+VJi5lbJwAZMEAH7Qf5VTvHld9ow3vrCNcHR4K/ZUuBgHRWXiH212izBzxlfi9zQNWWUN5m9GOzOPbgT8ySreKV7DCWRaZEu+rhVMM/aezvbgo/EWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827298; c=relaxed/simple;
	bh=Roq28Sqdr6qWqxoxgghG8s26s8sINSRwVKQCnlLgHnA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aJRQj3i9UgV+cNI+hyRhGeyV/AOB9piijWOKhGHZjW2f6pRHxFQyUfr2zrLlQc6sVsED8ZeZQmw5OeNXrSLu2+O3KeB49dP7TUHkVzGEhMritonLzMbxYYgc0hkCoZ5fQYUQVpyUJlAIqe+KbNbnF9nAZbNNRuNeajgLz7scXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kgqXbrBz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DM0JE023002;
	Tue, 2 Sep 2025 15:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EYUwda
	Rxv5SqK/QJCgD88t3BD5f+bMRzZJ4qcmjolpY=; b=kgqXbrBz6tAQzM8rRqy2hQ
	P9a1FARO9e74SLksndQJjsjuot7LWVyrO3XRTmzd4AfR0/WyMGT30+65fawVHvAR
	hEROT7QJ9bdfJYPOb3py6DPbogTGEqD0450smmyy2D7JMnNAYdHBZpyk42HvAPK6
	PNMkIMMI+Nvx3QEGKd7PkOy/XvMdkirUqCfDFWpX/dWt4TF2i/+/s45SKdNiZXbs
	o1ZlNt8UaOPFUjPRtejMjLBgzmI0RLBSxkDNKXa/SDyOgqa4MMp+xR98Dkx6+z2W
	hY1h5Zjxzg48KF0bv82uGzM1KKDEyzpb+jB8gEHrrxkf0sZHTj1WlzrB4CmJ6VHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd78ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 15:34:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 582FLP2D014421;
	Tue, 2 Sep 2025 15:34:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd78k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 15:34:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582D069p021184;
	Tue, 2 Sep 2025 15:34:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpk8dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 15:34:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582FY4Yv32965092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 15:34:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E71CD58062;
	Tue,  2 Sep 2025 15:34:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85B355805C;
	Tue,  2 Sep 2025 15:33:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.29])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Sep 2025 15:33:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [bpf-next v2 0/5] powerpc64/bpf: Add support for bpf arena and
 arena atomics
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250829165135.1273071-1-skb99@linux.ibm.com>
Date: Tue, 2 Sep 2025 21:03:36 +0530
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, Jiri Olsa <jolsa@kernel.org>,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DC6CA27-C35F-4220-856A-48AC8BF45896@linux.ibm.com>
References: <20250829165135.1273071-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b70e6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=odCaGXuriu-t99JO8RQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX+ClQegpUb5Ao
 6YsY3/NxHnIZHtKNl+XPND9lNhVTgc1XyzfI4YUYzDPzhp5cWOLP17MLhDS+DSD3Cul7RnXL+ZJ
 bFMbiXOkODVEcQCvTDbpBcpMuQLLx0nLX7C01fuzRJ473c2Pd0hcgMRXl8M6yyIFSHyqNspluNz
 k9TtrEJ6XFgjB8zQcMCYDRG5UEpYI/jjpADKPMJKWXyzubf1ZJ00zzApYsnkbXWr4+gO6n3DC/U
 8NPg898BdhfefccVw6AJlzhAjF0Qz5s4FkAsS4/iq6fzokisNwYnIXMiST4XK4mD8UutoK+rGQ9
 YErNaT0Hz/ajnJftxo4LuilGgtFDF+RNqUboF/j+iM3OgIOGVZAD5Bk7yIhXi3/Qw+Jr1a1mWBG
 B1JgciKf
X-Proofpoint-GUID: k68A7P1PeBruVwtl1_8P86pZypwcZgwk
X-Proofpoint-ORIG-GUID: 0ig10undA1vhyCbAICB2CAVggi9lugps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034



> On 29 Aug 2025, at 10:21=E2=80=AFPM, Saket Kumar Bhaskar =
<skb99@linux.ibm.com> wrote:
>=20
> This patch series introduces support for the PROBE_MEM32,
> bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF =
JIT,
> facilitating the implementation of BPF arena and arena atomics.
>=20
> The last patch in the series has fix for arena spinlock selftest
> failure.
>=20
> All selftests related to bpf_arena, bpf_arena_atomic(except
> load_acquire/store_release) enablement are passing:
>=20
> # ./test_progs -t arena_list
> #5/1     arena_list/arena_list_1:OK
> #5/2     arena_list/arena_list_1000:OK
> #5       arena_list:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>=20
> # ./test_progs -t arena_htab
> #4/1     arena_htab/arena_htab_llvm:OK
> #4/2     arena_htab/arena_htab_asm:OK
> #4       arena_htab:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>=20
> # ./test_progs -t verifier_arena
> #464/1   verifier_arena/basic_alloc1:OK
> #464/2   verifier_arena/basic_alloc2:OK
> #464/3   verifier_arena/basic_alloc3:OK
> #464/4   verifier_arena/iter_maps1:OK
> #464/5   verifier_arena/iter_maps2:OK
> #464/6   verifier_arena/iter_maps3:OK
> #464     verifier_arena:OK
> #465/1   verifier_arena_large/big_alloc1:OK
> #465/2   verifier_arena_large/big_alloc2:OK
> #465     verifier_arena_large:OK
> Summary: 2/8 PASSED, 0 SKIPPED, 0 FAILED
>=20
> # ./test_progs -t arena_atomics
> #3/1     arena_atomics/add:OK
> #3/2     arena_atomics/sub:OK
> #3/3     arena_atomics/and:OK
> #3/4     arena_atomics/or:OK
> #3/5     arena_atomics/xor:OK
> #3/6     arena_atomics/cmpxchg:OK
> #3/7     arena_atomics/xchg:OK
> #3/8     arena_atomics/uaf:OK
> #3/9     arena_atomics/load_acquire:SKIP
> #3/10    arena_atomics/store_release:SKIP
> #3       arena_atomics:OK (SKIP: 2/10)
> Summary: 1/8 PASSED, 2 SKIPPED, 0 FAILED
>=20
> All selftests related to arena_spin_lock are passing:
>=20
> # ./test_progs -t arena_spin_lock
> #6/1     arena_spin_lock/arena_spin_lock_1:OK
> #6/2     arena_spin_lock/arena_spin_lock_1000:OK
> #6/3     arena_spin_lock/arena_spin_lock_50000:OK
> #6       arena_spin_lock:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Changes since v1:
>=20
> Addressed comments from Chris:
> * Squashed introduction of bpf_jit_emit_probe_mem_store() and its =
usage in
>  one patch.
> * Defined and used PPC_RAW_RLDICL_DOT to avoid the CMPDI.
> * Removed conditional statement for fixup[0] =3D PPC_RAW_LI(dst_reg, =
0);
> * Indicated this change is limited to powerpc64 in subject.
>=20
> Addressed comments from Alexei:
> * Removed skel->rodata->nr_cpus =3D get_nprocs() and its usage to get
>  currently online cpus(as it needs to be updated from userspace).
>=20
> Saket Kumar Bhaskar (5):
>  powerpc64/bpf: Implement PROBE_MEM32 pseudo instructions
>  powerpc64/bpf: Implement bpf_addr_space_cast instruction
>  powerpc64/bpf: Introduce bpf_jit_emit_atomic_ops() to emit atomic
>    instructions
>  powerpc64/bpf: Implement PROBE_ATOMIC instructions
>  selftests/bpf: Fix arena_spin_lock selftest failure
>=20
> arch/powerpc/include/asm/ppc-opcode.h         |   1 +
> arch/powerpc/net/bpf_jit.h                    |   6 +-
> arch/powerpc/net/bpf_jit_comp.c               |  32 +-
> arch/powerpc/net/bpf_jit_comp32.c             |   2 +-
> arch/powerpc/net/bpf_jit_comp64.c             | 401 +++++++++++++-----
> .../bpf/prog_tests/arena_spin_lock.c          |  13 +
> .../selftests/bpf/progs/arena_spin_lock.c     |   5 +-
> 7 files changed, 347 insertions(+), 113 deletions(-)
>=20
> --=20
> 2.43.5
>=20

Tested this patch set by applying on top of bpd-next repo and it works =
as expected. Hence, please add below tag for the series.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.


