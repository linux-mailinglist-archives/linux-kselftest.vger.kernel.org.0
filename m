Return-Path: <linux-kselftest+bounces-23862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE4A00983
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E93A4130
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA01FA170;
	Fri,  3 Jan 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AXKxr+Gw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE391F9AB5;
	Fri,  3 Jan 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908849; cv=none; b=Wl9t8kYpb36JK+jyawZTZr4NbWjeTSWFRxNILX20XDwjfHeugPQsDiOOv/tZSfBc/LiQJZOf3yAyr9Uj9sGCxqJnzTQZpPCNzNxzekBn+7NgT7dzFyTnSN1wgywfHky2T+3BoL0ObAx0JGVKPBRbd7eNegYynQmpDpuVCcoVQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908849; c=relaxed/simple;
	bh=DokGVZAo+UUlU+hYOCt41gahFKtvvzU+qiTRiI/6lOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNlPNLfE5jRirRrT2qJzT5AXpy3YE45rR8vo6TIMbKr+SSxA9xKlBgILLPYrAvIFEAgEKo5Yybmphl3lZ+81DMqwNAd87Z9bgOiFy8OPqvB0N0/E1jES2+WdOlyqOb9mG3BBE5SuXDD81EPFuGZN8S+BM4pqqcvO/s6gHZ3XQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AXKxr+Gw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8CAB40004;
	Fri,  3 Jan 2025 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735908845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrP471C2ngogmcSn0oE7jqDyzd1g7ACgc1oMTOJHdMA=;
	b=AXKxr+GwEwJu/GQ5aWiYySvcHNa+qUcLgRh14jeGg2k2oj+Q47a7vkeFxJgdxQg7g1qlrF
	gF9HRLW64zofeSaYhVR/PFeGPxLqDfaKTuLPaWGPaQOOnN3XPcrSAEBvK1g/5bfBHskW6U
	TcT7p/PK5iCGY/Qa7Vlfd++DmBsRT7uvtC4qSFzVEK0TXs6ZPF9U2DgTqm26z6tWyodmKg
	OHdRe4ODBozI9Va1iwjp/4Yv0hugHQ3EKgVq8Cdx843mLNim2ZZArVxK0DcHqdVmLYRKCG
	IsW1n9jZf2B7N3kdTnwVXmbJWlKnjGyg9FcYRPPzLSZ/yxmcM1Im/FH1rutKeA==
Message-ID: <c7ff7788-d3af-4867-8b13-57a0bf1f529a@bootlin.com>
Date: Fri, 3 Jan 2025 13:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/bpf: Migrate test_xdp_redirect.sh to
 xdp_do_redirect.c
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
 <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Bastien,

On 1/3/25 11:10, Bastien Curutchet (eBPF Foundation) wrote:

[...]

> +		SYS(fail, "ip link add veth%d index %d%d%d type veth peer name veth0 netns %s",
> +		    i, i, i, i, ns_name);

nit: since you have to run an ip command through SYS anyway, you can reduce the
open ns/run command/close ns dance (and all the resulting error checks) by
running directly `SYS("ip netns exec %s ip link add [...]", NS0, [...])`

[...]

> +	ret = bpf_xdp_attach(if_nametoindex("veth2"),
> +			     bpf_program__fd(prog_to_111),
> +			     data->xdp_flags, NULL);

nit: since we are setting static if index at veth creation (which looks needed
for this test), the if_nametoindex could be replaced by the corresponding index,
which could be directly a define

> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto close;
> +
> +	ret = bpf_xdp_attach(if_nametoindex("veth1"),
> +			     bpf_program__fd(prog_to_222),
> +			     data->xdp_flags, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto close;
> +
> +	close_netns(nstoken);
> +
> +	nstoken = open_netns(NS1);
> +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
> +		goto close;
> +
> +	SYS(close, "ping -c 1 %s.2", IPV4_NETWORK);
> +
> +	close_netns(nstoken);
> +
> +	nstoken = open_netns(NS2);
> +	if (!ASSERT_OK_PTR(nstoken, "open NS2"))
> +		goto close;
> +
> +	SYS(close, "ping -c 1 %s.1", IPV4_NETWORK);

Is it really useful to check ping originating from both interfaces, isn´t a
single ping able to stimulate programs attached to both veth0 ?

Aside from those minor points, LGTM :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

