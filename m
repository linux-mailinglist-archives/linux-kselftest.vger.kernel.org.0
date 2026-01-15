Return-Path: <linux-kselftest+bounces-49011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E83D24354
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A69B301A185
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73E36D4EC;
	Thu, 15 Jan 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8CNbPxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0736CDF0;
	Thu, 15 Jan 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477005; cv=none; b=iWFPOCHmV7ueMXEK8d+sgiRWnPlU2/+xinX4fsOAMe+RjGhcLW6HR2Zi6zoCjXEmSbR5wRFHfygLtygLHjlYl5e/HIaq+AcrFaWebUgL6TLICIuoTRhCJ65UF610lpy6SqTUXi2pjwD7k0brLYjO/o/SvjNaZFHaF3wQBWw/0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477005; c=relaxed/simple;
	bh=S1zVd7K5Qc88Ejy8WCF5u8TEVouXXbX4I5XXYHo/+h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkVy4whNsaSWzDOpM0GmSwah76rRSTS+g4Uql6TgVlj41DICHgsbe0vMK+t/+O4vkYlyN2AprLuWZJlJ/RlE2g7YI+V18PBSb4hsXAsSviJ7j3HNNGGQEobD/zANB1uvyJTAENBkq9hrAo2NnShqXIGCgnk9mU1pH/mKpX3SVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8CNbPxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133DDC116D0;
	Thu, 15 Jan 2026 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768477004;
	bh=S1zVd7K5Qc88Ejy8WCF5u8TEVouXXbX4I5XXYHo/+h8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E8CNbPxHwlPz6MuMrYgsYFGkSQmUk9HNmdh3pcNIDZSbmoYDf8cVa/jSDswrqMr7s
	 LK4t/yIAD/EtMSlMTlx4LOK/TPd45MDax62SJ+3O3Q0YgNFfDTFijkIAg1lgHmAFet
	 ZLg5oTrkDN6yoIwQoeGrM0zUtQcMB1vdp5ebbDP0A+JMoJhJKAYae7q0YHZlSwABpf
	 eLfAhNOWIvKpEmAuvyqbcGMhPB6lxrrDNZ8Cb61QxfBE0sevpIW2oWbFd7IpjgNtBM
	 w372oxjACbTY+qOLW+lduJnot3n72PPjcMewll9fK0svxdDcjV82jP+Ku6n3BWbSbA
	 +bALruDwx4eIw==
Message-ID: <71f71244-fad6-424e-8335-5476007418a0@kernel.org>
Date: Thu, 15 Jan 2026 11:36:40 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: add bpftool map manipulations
 tests
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <20260114-bpftool-tests-v1-3-cfab1cc9beaf@bootlin.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260114-bpftool-tests-v1-3-cfab1cc9beaf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-01-14 09:59 UTC+0100 ~ "Alexis Lothoré (eBPF Foundation)"
<alexis.lothore@bootlin.com>
> The test_bpftool_map.sh script tests that maps read/write accesses
> are being properly allowed/refused by the kernel depending on a specific
> fmod_ret program being attached on security_bpf_map function.
> 
> Rewrite this test to integrate it in the new test_bpftool runner. The
> new test spawns a few subtests:
> 
>   #1/1	maps_access/unprotected_unpinned: OK
>   #1/2	maps_access/unprotected_pinned: OK
>   #1/3	maps_access/protected_unpinned: OK
>   #1/4	maps_access/protected_pinned: OK
>   #1/5	maps_access/nested_maps: OK
>   #1/6	maps_access/btf_list: OK
>   #1	maps_access: OK
>   #2/1	metadata/metadata_unused: OK
>   #2/2	metadata/metadata_used: OK
>   #2	metadata: OK
>   Summary: 2 PASSED, 0 FAILED
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

