Return-Path: <linux-kselftest+bounces-38904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D876B2508B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996051C20D04
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1E28C030;
	Wed, 13 Aug 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acQ+xBB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D21EE7B9;
	Wed, 13 Aug 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104383; cv=none; b=uotBTegkEWqsimy6ttVXpbUv2Dg4KmCaW8BmjQe5xecvGv051HFJAoadvsXYYjqa4xiKOQzubTdQ3/QzDY51jxXz/nPK87DskpT3NdVA5QSh1nmqMRXUHw7ojJxYDHdO578volMO1lZKowvte/dus0Uzy0gobxmnKbkJIeSRCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104383; c=relaxed/simple;
	bh=nlgFbqy8rmClY6z6xKuU5I1TyKeKX6mUd5e8t6MELV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYqz/dVjuGxXTLCTZN+Cj2ah7n1dViX49zPVOvsUd+3yN9EeuHucFyMoQ+ZdB079zhHrNIm7nxNrp/H5BMtPI4E5HUaUKG7lH4mrycbAGBRrIEwQ//rFDER5ThLyXE9tUxja7rM7EjOCngxjMNnSusKf8vUdXlzpC3K1iCpgDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acQ+xBB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83176C4CEEF;
	Wed, 13 Aug 2025 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104382;
	bh=nlgFbqy8rmClY6z6xKuU5I1TyKeKX6mUd5e8t6MELV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=acQ+xBB1UoVwNik5WVUbcau/nmENRNA/pGpHll3BoB6Co1OJXzRNb+/PHJQrVKHeV
	 Z4KxwQYDtaaSJTISAq1cdPlpVsVpsvk9LmMzXEEfBLKBL/1rMnltevKiLerlJl+VS2
	 RcWs0lgUVJCFXEPtLLdvfRlByk4pp71DxmXvBtXfDUPE0frAfG++zfZNR+fz4k0I34
	 XxYpFckDiin0jZ9+v3gkhuMs7THPRAo6/isR6r5y1RUywAOJ4rrF/nR0omiHWNZPMT
	 5BppHsJm+/m+s4VaMt8ZtlHbUAM4sQAopGU1QsbKDnWNluKNMOqsCX3WsnaoDj2rpK
	 kuz7f68D5DkfQ==
Message-ID: <67bc8bbb-9fad-4eb6-86d3-71098358e071@kernel.org>
Date: Wed, 13 Aug 2025 18:59:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Network Development <netdev@vger.kernel.org>,
 Matt Fleming <mfleming@cloudflare.com>
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/07/2025 16.34, Alexei Starovoitov wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
>> new file mode 100644
>> index 000000000000..522e1cbef490
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
[...]
>> +
>> +static void gen_random_key(struct trie_key *key)
>> +{
>> +       key->prefixlen = prefixlen;
>> +       key->data = bpf_get_prandom_u32() % nr_entries;
> bpf_get_prandom_u32() is not free
> and modulo operation isn't free either.
> The benchmark includes their time.
> It's ok to have it, but add a mode where the bench
> tests linear lookup/update too with simple key.data++

I've extended this bench with a "noop" and "baseline" benchmark[1].

  [1] 
https://lore.kernel.org/all/175509897596.2755384.18413775753563966331.stgit@firesoul/

This allowed us to measure and deduce that the:
   bpf_get_prandom_u32() % nr_entries

Takes 14.1 nanosec for doing the rand + modulo.

The "noop" test shows harness overhead is 13.402 ns/op
and on-top the "baseline" shows randomness takes 27.529 ns/op.

--Jesper

