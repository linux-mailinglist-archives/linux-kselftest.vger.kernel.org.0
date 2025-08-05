Return-Path: <linux-kselftest+bounces-38285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14EB1B020
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C533B2BBB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB50124167B;
	Tue,  5 Aug 2025 08:20:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC961DF759;
	Tue,  5 Aug 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382037; cv=none; b=t0Bn5RfM/EZBGfCFwZ010YB6fSz0ywXoZ8GNnEb3EsPXbIYFFdVA8vGd2dHTC6EOJeUP/umNT3G2O0rgVl20r10PiBILNiztJ+HryHxAu/WihQuftfqc3YEzWu+/Hp3bH89CmzaUDrO5dxuqvZrIWbtjsx0PdBzfw4bxsNJg8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382037; c=relaxed/simple;
	bh=HZM4ddfrpH24I++YTi0PgJXSfKIvXWqtY/jr7JoMrRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvRH8u1rMvlPwz8x4I4RS4OxRkBX3WammJY/a2jILz8bVJluZKTbDVCOACoQh8LYtQ6rpXeOvTdQXrftjD7N714NJO/Q27G2TAQ8oSrcwi9HWOeOCpzmiyHRhCA3L9fgAqqZu21CgEFbbP4lYs18abFrY8gPkOfvVhIs6ScY8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bx57n0CXYz9tMd;
	Tue,  5 Aug 2025 09:45:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IuSqCUxyKqzr; Tue,  5 Aug 2025 09:45:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bx57m6FKRz9tMS;
	Tue,  5 Aug 2025 09:45:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD7068B765;
	Tue,  5 Aug 2025 09:45:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id flY4ShmDsG9w; Tue,  5 Aug 2025 09:45:40 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8ACC88B763;
	Tue,  5 Aug 2025 09:45:39 +0200 (CEST)
Message-ID: <5af0d7d9-71cb-4977-b496-6046c2c64d52@csgroup.eu>
Date: Tue, 5 Aug 2025 09:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next 0/6] bpf,powerpc: Add support for bpf arena and arena
 atomics
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250805062747.3479221-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> This patch series introduces support for the PROBE_MEM32,
> bpf_addr_space_cast and PROBE_ATOMIC instructions in the powerpc BPF JIT,
> facilitating the implementation of BPF arena and arena atomics.

This series seems to be limited to powerpc64. Please make it explicit in 
all patches subject, see exemple below:

$ git log --oneline arch/powerpc/net/bpf_jit_comp64.c
cf2a6de32cabb (tag: powerpc-6.17-2, origin/next-test, origin/next) 
powerpc64/bpf: Add jit support for load_acquire and store_release
59ba025948be2 powerpc/bpf: fix JIT code size calculation of bpf trampoline
d243b62b7bd3d powerpc64/bpf: Add support for bpf trampolines
9670f6d2097c4 powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into 
bpf_jit_emit_func_call_rel()
fde318326daa4 powerpc64/bpf: jit support for signed division and modulo
597b1710982d1 powerpc64/bpf: jit support for sign extended mov
717756c9c8dda powerpc64/bpf: jit support for sign extended load
a71c0b09a14db powerpc64/bpf: jit support for unconditional byte swap
3c086ce222cef powerpc64/bpf: jit support for 32bit offset jmp instruction
b1e7cee961274 powerpc/bpf: enforce full ordering for ATOMIC operations 
with BPF_FETCH
61688a82e047a powerpc/bpf: enable kfunc call


> 
> The last patch in the series has fix for arena spinlock selftest
> failure.
> 
> This series is rebased on top of:
> https://lore.kernel.org/bpf/20250717202935.29018-2-puranjay@kernel.org/
> 
> All selftests related to bpf_arena, bpf_arena_atomic(except
> load_acquire/store_release) enablement are passing:
> 
> # ./test_progs -t arena_list
> #5/1     arena_list/arena_list_1:OK
> #5/2     arena_list/arena_list_1000:OK
> #5       arena_list:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> # ./test_progs -t arena_htab
> #4/1     arena_htab/arena_htab_llvm:OK
> #4/2     arena_htab/arena_htab_asm:OK
> #4       arena_htab:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
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
> 
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
> 
> All selftests related to arena_spin_lock are passing:
> 
> # ./test_progs -t arena_spin_lock
> #6/1     arena_spin_lock/arena_spin_lock_1:OK
> #6/2     arena_spin_lock/arena_spin_lock_1000:OK
> #6/3     arena_spin_lock/arena_spin_lock_50000:OK
> #6       arena_spin_lock:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> Saket Kumar Bhaskar (6):
>    bpf,powerpc: Introduce bpf_jit_emit_probe_mem_store() to emit store
>      instructions
>    bpf,powerpc: Implement PROBE_MEM32 pseudo instructions
>    bpf,powerpc: Implement bpf_addr_space_cast instruction
>    bpf,powerpc: Introduce bpf_jit_emit_atomic_ops() to emit atomic
>      instructions
>    bpf,powerpc: Implement PROBE_ATOMIC instructions
>    selftests/bpf: Fix arena_spin_lock selftest failure
> 
>   arch/powerpc/net/bpf_jit.h                    |   6 +-
>   arch/powerpc/net/bpf_jit_comp.c               |  32 +-
>   arch/powerpc/net/bpf_jit_comp32.c             |   2 +-
>   arch/powerpc/net/bpf_jit_comp64.c             | 378 +++++++++++++-----
>   .../bpf/prog_tests/arena_spin_lock.c          |  23 +-
>   .../selftests/bpf/progs/arena_spin_lock.c     |   8 +-
>   .../selftests/bpf/progs/bpf_arena_spin_lock.h |   4 +-
>   7 files changed, 348 insertions(+), 105 deletions(-)
> 
> base-commit: ea2aecdf7a954a8c0015e185cc870c4191d1d93f


