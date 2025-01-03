Return-Path: <linux-kselftest+bounces-23868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B8A009D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 14:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC23E164195
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F181F9EDB;
	Fri,  3 Jan 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ss+nFNl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA91E00B4;
	Fri,  3 Jan 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910257; cv=none; b=K+wW7QDoII9VciNqr2jzcJsRuUxb60irvQuZesXqtoz1iNsmc5vk/JEpdJCNsqj+epO0XYsnXlXSonYqHIg4faaTQrD96RfYUTtWnXp6EhOrSw3WZur8//0YJyUxFUHV3OPn1zHmaUdvoyLm+1Fo83EmSyQp8xjjEkWwTnjF9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910257; c=relaxed/simple;
	bh=PMa3t4VFdc0cEUG6n0D73E69wmCrHy/FHFxulprvgNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwIpimN2lFJUwzzjsHUhwlNSa+302kLfPyjwcRIzF2c36yKwAhRTXNoLMbKSXXuqYGYhNMLklOHc0SS0HG2XyChCdd+pbOvlPQjCCOPuJUAWNDr/RIYC4blFSoaRtE7XtPssu1KZB15XEB1BDkjQYuxLZSR9bh2RPpOiKVHjsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ss+nFNl4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7683B1C0005;
	Fri,  3 Jan 2025 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735910246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fnjfa9S6M4rYYiaM1PrtnkytV8ZE2YbvjptvwGouvg=;
	b=Ss+nFNl4et6AiebbpSOid+30hkkjxfU0Z8utO2uk1So404Qrmbd79THBB5zJozQhOvW6Nn
	tUyj/w3mdUxOE6I8gNlU6/wxwCHc41AeaisMkpCaELq2/kJuS0Beawd29AmP2125plAxT4
	NN22+jUqVmRZ9Yi4RH7Vd5Gsw1c6Qv1cfYtnseldTPLGxqcirfKp3heTcpAaK4mhlkR4UE
	3wwB1gt75kySpUEbuV979lYjYXynOXy5UOLj0zdnaC8oDqcZxdyfdKRSBxZdtLLxacAvUb
	yqsq12VH+SCASW+fXLdCPW4NFoVXf+egLARdrF/UWC181zPhX3h8TCj82lq37Q==
Message-ID: <1c7bcca1-a940-44e4-aba3-b83b82d3bfbf@bootlin.com>
Date: Fri, 3 Jan 2025 14:17:24 +0100
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

On 1/3/25 11:10, Bastien Curutchet (eBPF Foundation) wrote:
> test_xdp_redirect.sh can't be used by the BPF CI.

> +	dummy_prog = bpf_object__find_program_by_name(skel_dummy->obj, "xdp_dummy_prog");
Also missed this one: why not using directly skel_dummy->progs.xdp_dummy_prog ?
(same for all progs below)

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

