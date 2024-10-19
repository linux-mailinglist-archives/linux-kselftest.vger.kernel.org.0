Return-Path: <linux-kselftest+bounces-20194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C79A4DBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06AF282E77
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791E1E04B0;
	Sat, 19 Oct 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FjNrm0cd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AF1DE2AE;
	Sat, 19 Oct 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340043; cv=none; b=EKXH6AjkpdXxbQ3hNqvpj6K9lAqwejt6QBS4urfFW4Oe7Tmu/uJgpwjORM0Z3QhJWhJTL41gwzDWoRKGjQ8NAT9dEI+glr3PpaGGzzciU1uc0hN8ICONYkx1Kwwqawk7M6HKYAcmXshGg+UVw9sDMF3fzhQVnUV1UUvgRqAlHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340043; c=relaxed/simple;
	bh=Zh3CNlvJGgEu6+hGG/XSE58JLkiLtoLZGdNKNVgf8xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4aXxeA9h6nFHaPErO7pwBW8uvbJiOb6v8bgVfsj6GHEDjNZf+cRuJ/S+qlDEGpmUCk+EOykhPZW/gedg62uoOzYbEo3zs6qCBuEltf+F/+UtSZS5E5vG6IAso37FhjqJpxMuzHQUsvgCOUCrtTVrEf8wGJQ+Hu0fwntqyqbxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FjNrm0cd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9759E0002;
	Sat, 19 Oct 2024 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729340037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3svayMFxw0v0m0oN6qpWeSzMSDxNCpu8Ituu40pyy0=;
	b=FjNrm0cdmER2Z/qwTmF1DxYAsGtb+6BspLseSNudntV/cu8KhLEs+8bTYfC0kPh7ABgjBZ
	OUKy6XJXA4+itlgqghRr2nrVRNgQYMELkeI/ESsddtihHMkQA5fVEwE4G9iVRy/JXeFpiR
	1InCfl6J4Ww6fpqkpg68H5saJKLUhcRc0iGNb968J39GFDlPhMXwzdeYVm2izTlTCkWRq1
	KKEiNe10mcKf+fpLBvWO27+ZuKQEvcKjV8Sb/C2XgMQwaMRWqOcj2UqEYpeQdMYeMNYqWK
	E6LP7wJq8ekZ5QA+UJkqs1yUtP88lNYYgUcmMPWmKFzc6kTxyI8GzQ09oeSd/Q==
Message-ID: <4d438cdf-7e16-4a75-b2ca-d3dea6f1c045@bootlin.com>
Date: Sat, 19 Oct 2024 14:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: add missing ns cleanups in
 btf_skc_cls_ingress
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-2-3b7a0de12153@bootlin.com>
 <18cb274a-a214-42c0-bcec-cbda34703893@linux.dev>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <18cb274a-a214-42c0-bcec-cbda34703893@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Martin, thanks for the review !

On 10/19/24 01:57, Martin KaFai Lau wrote:
> On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:
>> btf_skc_cls_ingress.c currently runs two subtests, and create a
>> dedicated network namespace for each, but never cleans up the created
>> namespace once the test has ended.
>>
>> Add missing namespace cleanup after each namespace to avoid accumulating
>> namespaces for each new subtest. While at it, switch namespace
>> management to netns_{new,free}
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

[...]

>>   -    if (CHECK(unshare(CLONE_NEWNET), "create netns",
>> -          "unshare(CLONE_NEWNET): %s (%d)",
>> -          strerror(errno), errno))
>> -        return -1;
>> +    ns = netns_new(TEST_NS, true);
>> +    if (!ASSERT_OK_PTR(ns, "create and join netns"))
>> +        return ns;
>>         if (CHECK(system("ip link set dev lo up"),
>>             "ip link set dev lo up", "failed\n"))
> 
> nit. netns_new() takes care of "lo up" also, so the above can be removed.

Ah, indeed, I missed it in make_netns. Thanks, I'll remove this part from the
test then.
> 
> test_progs.c has restore_netns() after each test, so the netns was not cleaned
> up. The second unshare should have freed the earlier netns also.
> 
> Using netns_new() removed the boiler plate codes. It is nice to see this change
> here regardless.



-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

