Return-Path: <linux-kselftest+bounces-13975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2E9385E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A95428113A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295416A396;
	Sun, 21 Jul 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cyT32yN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA80323D;
	Sun, 21 Jul 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589927; cv=none; b=nom/908AKNCMGbGuUo8ucahXnP4R4xi9ALZQ6X0HYf0Z232qcDGMT41gusTROcId8gUjxUkQDF/0Leukz/LIGD9hK1I4xH+XEX+5iueV7n8q13+yPAmkT+V0/ILoNVKBJhJQIqi9/pmPHI5E5YmGSGq4ip1Ed7z8LyMrD5eMVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589927; c=relaxed/simple;
	bh=0aMDTS1Q+ke2bybc1XR+ru3LcVw9Wcs/qntj2msfcms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9b/3hD+3DqtxPMcCkOxeMEQXMvLrjF+y18ZnWBbps3V11PzTaFi+5R86qkYKFxVVQ3hTuNGQe4e66gzoBZVihL37l/R1cxhR6fUSN/oTtu3sqP912IZ56kILHg5rTcCoxWn0Ps25GTZwqmB2GyNeC/Rh9eIWiKgdMKpHyVgWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cyT32yN8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B78B6C6021;
	Sun, 21 Jul 2024 19:25:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8C431C0003;
	Sun, 21 Jul 2024 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721589907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipOvCn4HjAe9SOCKtKgYOzgGnVV6yEDgzBHQOmIDXk0=;
	b=cyT32yN8ebkxAJm6p7v0v82pOdPdyhlmgY17uvkuiVg2/4/oGNFI/UWNJC4yN2IY4dbPl6
	lkUDWzJQEKl7o3REkH6j3kLjdqIS0sFqmM0CK4+Vw1py0jt+2PBT+TxB0f4C8hTGCKh+Ex
	P2LiqPi4Z4HKsBtyp5f5qnoDJpYAiAjERjJruOw/PZ3JQFjOA4Rm/HJMw0w7j3k47KDdXv
	0hXc8TzT4hsrGsYmH0c/TmopQ/iJCUzv2+ikeUVO72adumAPYr+vtLESgusAd1QeXsAKUL
	hSyIdUpQyCqx4tU0zSHAN52PA3b3mCqlKZ6ZBVATiwj/Lswqzx2RwiVfx5fB5Q==
Message-ID: <a348aa4d-d2c2-48f5-a1ed-4f97ffd093d7@bootlin.com>
Date: Sun, 21 Jul 2024 21:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/bpf: integrate test_xdp_veth into
 test_progs
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
 <20240716-convert_test_xdp_veth-v3-2-7b01389e3cb3@bootlin.com>
 <3b1949b9-775a-8093-6a14-16dec843a446@iogearbox.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <3b1949b9-775a-8093-6a14-16dec843a446@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Daniel,

On 7/19/24 17:14, Daniel Borkmann wrote:
> On 7/16/24 12:13 PM, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>> +    nstoken = open_netns(config[index].namespace);
>> +    if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
>> +        return -1;
>> +    interface = if_nametoindex(config[index].remote_veth);
>> +    if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
>> +        return -1;
> 
> Missing `close_netns(nstoken);` in error path here, otherwise looks reasonable
> to me.
Ah yes, good catch, thanks. v4 incoming with the corresponding fix.

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


