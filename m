Return-Path: <linux-kselftest+bounces-9695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC058BFAB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD4A1C228A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D807E112;
	Wed,  8 May 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh/RcZaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990D82487;
	Wed,  8 May 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163087; cv=none; b=n1Y9Ws63rvGkQkMNwdE38sh8/MSVhqA6TVDfWSDQidDbOjN2WNP/CcJTjh8JD4mzqeD2Wckk+XZjZtPAEeW1SMW7eNJhQuesB2fXoIwliPO47hPVZtrD459RRFH58ovLVNDIGZXhQskUXKbJEXdSlcn5fl7y1ureER7PXH+LBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163087; c=relaxed/simple;
	bh=O01+4OxDhqfAMNBJajyRNazF4RaEhwcQwMkJgUw3EWY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLHs8nI304CGxa4RC1mYUOMwS1NwAUSJnszVHeC/Wl3oaaY3qlQImlFc1GPNaTTOM4yJLQJqLa7uqpF2unbLoXsxXDLvG/To9gj2dUsPgw6Kggup4TIDsE0HCtTUlRYnoQKLvOsxlLZ3TKkqZ0zNdCPADLceogOAImIEL/IL3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh/RcZaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EEFC4AF17;
	Wed,  8 May 2024 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163087;
	bh=O01+4OxDhqfAMNBJajyRNazF4RaEhwcQwMkJgUw3EWY=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=Zh/RcZaGT6E7lVROM1Ix/WzyM9U1WHn89iH+ECtYZyPi325pd5UBnddq6OsgQKhGj
	 dtgp1emBDcRguH+li8+LQOsvCJHPDTzLgdhPEnO6o2x9HZhEu0bjP2FV3Co8XIFCye
	 zN4xGHE8nKwPbF0b+AXMC9mFzQqGUrhGjtblR5TjB5mb2wy78uePKX7yUX6LcmK+Bj
	 EchcG9cYgys2zvHpPQstcBiSX9NWznB/RttR2UazhmwjIa9ODcL4uU00iHqmG+2hdb
	 wzt2m24Re/wGc58B9JxIG00Be3CU853Cea4h9d6mKsUD2Cdk99oG0QBZqNID/djXMX
	 O53MvfdTHggLA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, arm64: Add support for lse atomics in
 bpf_arena
In-Reply-To: <20240426161116.441-1-puranjay@kernel.org>
References: <20240426161116.441-1-puranjay@kernel.org>
Date: Wed, 08 May 2024 10:11:23 +0000
Message-ID: <mb61pzft0zk8k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> When LSE atomics are available, BPF atomic instructions are implemented
> as single ARM64 atomic instructions, therefore it is easy to enable
> these in bpf_arena using the currently available exception handling
> setup.
>
> LL_SC atomics use loops and therefore would need more work to enable in
> bpf_arena.
>
> Enable LSE atomics based instructions in bpf_arena and use the
> bpf_jit_supports_insn() callback to reject atomics in bpf_arena if LSE
> atomics are not available.
>
> All atomics and arena_atomics selftests are passing:
>
>   [root@ip-172-31-2-216 bpf]# ./test_progs -a atomics,arena_atomics
>   #3/1     arena_atomics/add:OK
>   #3/2     arena_atomics/sub:OK
>   #3/3     arena_atomics/and:OK
>   #3/4     arena_atomics/or:OK
>   #3/5     arena_atomics/xor:OK
>   #3/6     arena_atomics/cmpxchg:OK
>   #3/7     arena_atomics/xchg:OK
>   #3       arena_atomics:OK
>   #10/1    atomics/add:OK
>   #10/2    atomics/sub:OK
>   #10/3    atomics/and:OK
>   #10/4    atomics/or:OK
>   #10/5    atomics/xor:OK
>   #10/6    atomics/cmpxchg:OK
>   #10/7    atomics/xchg:OK
>   #10      atomics:OK
>   Summary: 2/14 PASSED, 0 SKIPPED, 0 FAILED

Gentle ping about this,

Thanks,
Puranjay

