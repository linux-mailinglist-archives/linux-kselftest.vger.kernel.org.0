Return-Path: <linux-kselftest+bounces-38456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA69B1D5CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209CB7AF417
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18D260592;
	Thu,  7 Aug 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWacN0CX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF22566FC;
	Thu,  7 Aug 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562443; cv=none; b=maXQ7WWPT2U049GkU/n4r4MbWARfAsuU12hkSBdgc7FFTYV5+qCEMFCaT6VKqC35eWN83V8l0aXbraoCi62IpWia1GJmeSjp+AHsO4qY3Csdb7lcpDnhpuwe5MsQd06X6OJgLvAx5taE11Dhq47HzU/49Z+oZ40e5N92fQKpf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562443; c=relaxed/simple;
	bh=+wfTZqfen+JQWsEHglzCuLnwISzNYryf+2oaH5DlnBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfR+q1YlHgTDr+k7SFKq8oFAYB6bTqEdeUprwxF3TGBNk2fUd5YXlWd25elMIoHgApUcAVIjBMyVR5WapwXAOHMJBKPS+mZmuyjusjZc09mz7dsw/xmVsyqyuLJBNEVW6AAaFuvlMtZ15HYl37koBLhzAp6smd8eG7HXk2BVecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWacN0CX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779AwrV018010;
	Thu, 7 Aug 2025 10:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MvYuJI
	BaTbglptud8BUxVWG/aFzgyTUty/UijXRHP0A=; b=XWacN0CXRj93+b4OQRBX76
	tFfQfKjrKE3x9NVim1yHBVohPTOLDLI7ORbJAiBxvtifEDNTx3pngHW3BgJ+VCYW
	4LHjfaYfz3+JKnvF8sveskfHwCrj2Lybc587XR/2GTJogHvFRYcwLHZvPhMf2aLr
	cCexhL4/cN+ST8t1HB4WVJjSq5za2fNBIvHxtjJjiBOR8qEhxNfRPF+SBPyUQ2RF
	6ZJZ462P3bIXs4w+ac1AI++NLCG+ZXhm9IiNYjGGp6V7rQWnkX0ZkPWyyPyzQWkD
	pGxFvbL33Al1oSNy/IlfTNODqWO/de+gzAJ4m2E5JhX5njZGDG2jDtSROH+OghFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq639cr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:26:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577AHZMU012539;
	Thu, 7 Aug 2025 10:26:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq639cr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:26:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779eOPv020592;
	Thu, 7 Aug 2025 10:26:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn03rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:26:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577AQgYd53608722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 10:26:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BBD12004B;
	Thu,  7 Aug 2025 10:26:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C0520043;
	Thu,  7 Aug 2025 10:26:37 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 10:26:37 +0000 (GMT)
Date: Thu, 7 Aug 2025 15:56:35 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
        shuah@kernel.org
Subject: Re: [bpf-next 0/6] bpf,powerpc: Add support for bpf arena and arena
 atomics
Message-ID: <aJR/W7w/csyL7Ov4@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <5af0d7d9-71cb-4977-b496-6046c2c64d52@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5af0d7d9-71cb-4977-b496-6046c2c64d52@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA4MiBTYWx0ZWRfXyAn5EK3DnGtN
 MJBX/qUB/39erTlaqBtSQ/Z+nfTyh/YMv7VUJuKpzAowq2y1K08lC0zQv1AJ/8x/NCDFtEMOLWU
 EpNYpDm1h0GPofCCd6Io9sDK0vnb1NaKUPW5gOnyxDwNRuktLne4Oh6dOIHQeOC7yzFC8XJh2NO
 nGvcK6QhjSIyfXkKZ4O6nGOwGIHuKyPA5kxBgaHmHT9/Flfa9mOi41zaAvAJ0lSzTcZxxtqU1Os
 ySHFD4zSk7EI7DMgLpgFzti6zvfCWpOgeoTAIEBYmWZtDgvGBWUQlQZsD09TyCQ/u4a+DT5np06
 ZGoP131WpVr699aRiAwf3HIRzXvvg6McV3rCiVH2D94/9vr2xB9Ic6wdOqgNFZuzLJJTGpEi2y4
 FtBZZhuMXq6FmEct+9mvwDRT9bzmg/akfegrYTA9QiOEGsDKdx7KPYNbcvxWYnedlRWuzDZr
X-Proofpoint-GUID: VHgF_G3YeGlqFtACXPJeRatxucYmKxt0
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=68947f68 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=muU3JWixXP3YJbJcO1YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: hLwI0__C5l9eor7AFoAsBFZu824w8krA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070082

On Tue, Aug 05, 2025 at 09:45:39AM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> > This patch series introduces support for the PROBE_MEM32,
> > bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF JIT,
> > facilitating the implementation of BPF arena and arena atomics.
> 
> This series seems to be limited to powerpc64. Please make it explicit in all
> patches subject, see exemple below:
> 
> $ git log --oneline arch/powerpc/net/bpf_jit_comp64.c
> cf2a6de32cabb (tag: powerpc-6.17-2, origin/next-test, origin/next)
> powerpc64/bpf: Add jit support for load_acquire and store_release
> 59ba025948be2 powerpc/bpf: fix JIT code size calculation of bpf trampoline
> d243b62b7bd3d powerpc64/bpf: Add support for bpf trampolines
> 9670f6d2097c4 powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into
> bpf_jit_emit_func_call_rel()
> fde318326daa4 powerpc64/bpf: jit support for signed division and modulo
> 597b1710982d1 powerpc64/bpf: jit support for sign extended mov
> 717756c9c8dda powerpc64/bpf: jit support for sign extended load
> a71c0b09a14db powerpc64/bpf: jit support for unconditional byte swap
> 3c086ce222cef powerpc64/bpf: jit support for 32bit offset jmp instruction
> b1e7cee961274 powerpc/bpf: enforce full ordering for ATOMIC operations with
> BPF_FETCH
> 61688a82e047a powerpc/bpf: enable kfunc call
> 
Chris, will keep this in mind while sending v2.
> 
> > 
> > The last patch in the series has fix for arena spinlock selftest
> > failure.
> > 
> > This series is rebased on top of:
> > https://lore.kernel.org/bpf/20250717202935.29018-2-puranjay@kernel.org/
> > 
> > All selftests related to bpf_arena, bpf_arena_atomic(except
> > load_acquire/store_release) enablement are passing:
> > 
> > # ./test_progs -t arena_list
> > #5/1     arena_list/arena_list_1:OK
> > #5/2     arena_list/arena_list_1000:OK
> > #5       arena_list:OK
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > # ./test_progs -t arena_htab
> > #4/1     arena_htab/arena_htab_llvm:OK
> > #4/2     arena_htab/arena_htab_asm:OK
> > #4       arena_htab:OK
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > # ./test_progs -t verifier_arena
> > #464/1   verifier_arena/basic_alloc1:OK
> > #464/2   verifier_arena/basic_alloc2:OK
> > #464/3   verifier_arena/basic_alloc3:OK
> > #464/4   verifier_arena/iter_maps1:OK
> > #464/5   verifier_arena/iter_maps2:OK
> > #464/6   verifier_arena/iter_maps3:OK
> > #464     verifier_arena:OK
> > #465/1   verifier_arena_large/big_alloc1:OK
> > #465/2   verifier_arena_large/big_alloc2:OK
> > #465     verifier_arena_large:OK
> > Summary: 2/8 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > # ./test_progs -t arena_atomics
> > #3/1     arena_atomics/add:OK
> > #3/2     arena_atomics/sub:OK
> > #3/3     arena_atomics/and:OK
> > #3/4     arena_atomics/or:OK
> > #3/5     arena_atomics/xor:OK
> > #3/6     arena_atomics/cmpxchg:OK
> > #3/7     arena_atomics/xchg:OK
> > #3/8     arena_atomics/uaf:OK
> > #3/9     arena_atomics/load_acquire:SKIP
> > #3/10    arena_atomics/store_release:SKIP
> > #3       arena_atomics:OK (SKIP: 2/10)
> > Summary: 1/8 PASSED, 2 SKIPPED, 0 FAILED
> > 
> > All selftests related to arena_spin_lock are passing:
> > 
> > # ./test_progs -t arena_spin_lock
> > #6/1     arena_spin_lock/arena_spin_lock_1:OK
> > #6/2     arena_spin_lock/arena_spin_lock_1000:OK
> > #6/3     arena_spin_lock/arena_spin_lock_50000:OK
> > #6       arena_spin_lock:OK
> > Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Saket Kumar Bhaskar (6):
> >    bpf,powerpc: Introduce bpf_jit_emit_probe_mem_store() to emit store
> >      instructions
> >    bpf,powerpc: Implement PROBE_MEM32 pseudo instructions
> >    bpf,powerpc: Implement bpf_addr_space_cast instruction
> >    bpf,powerpc: Introduce bpf_jit_emit_atomic_ops() to emit atomic
> >      instructions
> >    bpf,powerpc: Implement PROBE_ATOMIC instructions
> >    selftests/bpf: Fix arena_spin_lock selftest failure
> > 
> >   arch/powerpc/net/bpf_jit.h                    |   6 +-
> >   arch/powerpc/net/bpf_jit_comp.c               |  32 +-
> >   arch/powerpc/net/bpf_jit_comp32.c             |   2 +-
> >   arch/powerpc/net/bpf_jit_comp64.c             | 378 +++++++++++++-----
> >   .../bpf/prog_tests/arena_spin_lock.c          |  23 +-
> >   .../selftests/bpf/progs/arena_spin_lock.c     |   8 +-
> >   .../selftests/bpf/progs/bpf_arena_spin_lock.h |   4 +-
> >   7 files changed, 348 insertions(+), 105 deletions(-)
> > 
> > base-commit: ea2aecdf7a954a8c0015e185cc870c4191d1d93f
> 

