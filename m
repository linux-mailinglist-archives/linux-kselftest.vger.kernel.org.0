Return-Path: <linux-kselftest+bounces-38407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C1B1CBAB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7383A721E33
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBD1D47B4;
	Wed,  6 Aug 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUyop0RJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743481FFC6D
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503642; cv=none; b=o5YzHgrO8x773FG5w0a9RMgFBxJfX3WaJQaf4S4nGP8GaIe5Pzp19b4JAQD4TKnh+/k2cd+4/JqCOTZiEWnWGSpPD4neMKQK7Zbu6/p0MgAsmSmzcQGu05iU7QeFSTP0zS42/qkI8zHkVNyTeLGeUTXtPEZkjPyhqv028TqglpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503642; c=relaxed/simple;
	bh=j4xeOQsgKmvG1+Tp9JfNurlTANGK8Gppg96UJhS+iPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGnz0iDaAp/hFO/7sXSVQhhKdAuv2mgXwW516pDr3QiHifWOI1vT08sBLfZEac4V65PmyazeL5x+DiAfafT9rJEqFfh1AZuZcflkub8hg/9nHyQuF1N5iilnDYHTzitrDAuxYn7iHqBFLHpY/D+AU1knw37u7kVLAZaXJogklcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUyop0RJ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <064cc6f1-8406-4cb4-8eb8-b02755079d7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754503625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFW0rIXuEESEnNMQnqpbXexQinc6nJdA8zZ7nAzTptI=;
	b=gUyop0RJPjUrkBViD4d0us0Pn/FUO9g2NV+hyOwJivBVqG6trDVTWwWH69bX8gysSKs9HD
	c+/mCyRWe4Ua+CGAq+fpBbtkP5f9fX7qAMUYcP5UwsXMbdEmeKy9MK4bmACEOtUCc05EZp
	+yHUkUNPWJIgHz8L960nUPdNaXZgoVM=
Date: Wed, 6 Aug 2025 11:07:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/2] libbpf: fix USDT SIB argument handling causing
 unrecognized register error
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806092458.111972-1-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806092458.111972-1-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 2:24 AM, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> The current USDT implementation in libbpf cannot parse these two formats,
> causing `bpf_program__attach_usdt()` to fail with -ENOENT
> (unrecognized register).
>
> This patch series adds support for SIB addressing mode in USDT probes.
> The main changes include:
> - add correct handling logic for SIB-addressed arguments in
>    `parse_usdt_arg`.
> - add an usdt_o2 test case to cover SIB addressing mode.
>
> Testing shows that the SIB probe correctly generates 8@(%rcx,%rax,8)
> argument spec and passes all validation checks.
>
> The modification history of this patch series:
> Change since v1:
> - refactor the code to make it more readable
> - modify the commit message to explain why and how
>
> Change since v2:
> - fix the `scale` uninitialized error
>
> Change since v3:
> - force -O2 optimization for usdt.test.o to generate SIB addressing usdt
>    and pass all test cases.
>
> Change since v4:
> - split the patch into two parts, one for the fix and the other for the
>    test
>
> Change since v5:
> - Only enable optimization for x86 architecture to generate SIB addressing
>    usdt argument spec.
>
> Change since v6:
> - Add an usdt_o2 test case to cover SIB addressing mode.
> - Reinstate the usdt.c test case.
>
> Do we need to add support for PC-relative USDT argument spec handling in
> libbpf? I have some interest in this question, but currently have no
> ideas. Getting offsets based on symbols requires dependency on the symbol
> table. However, once the binary file is stripped, the symtab will also be
> removed, which will cause this approach to fail. Does anyone have any
> thoughts on this?
>
>
> Jiawei Zhao (2):
>    libbpf: fix USDT SIB argument handling causing unrecognized register
>      error
>    selftests/bpf: Force -O2 for USDT selftests to cover SIB handling
>      logic
>
>   tools/lib/bpf/usdt.bpf.h                      | 33 ++++++++-
>   tools/lib/bpf/usdt.c                          | 43 +++++++++--
>   tools/testing/selftests/bpf/Makefile          |  8 +++
>   .../selftests/bpf/prog_tests/usdt_o2.c        | 71 +++++++++++++++++++
>   .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
>   5 files changed, 185 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c
>
Please add proper tag like [PATCH bpf-next v7 ...] so CI can test it
properly.


