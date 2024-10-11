Return-Path: <linux-kselftest+bounces-19539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1F99A2FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 13:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D076FB21281
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A520B208;
	Fri, 11 Oct 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YxzuBb11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036D17D2;
	Fri, 11 Oct 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647457; cv=none; b=VxIPiLvWdeRbgIbydjcnaf1AlJic0YpEyLicFBf/evAklHEh1S5ATejhmCS85Q5q2U38jo5t+KFXQ5tBW+TQt/8jrHd59KyXiOAW1jWd9X4NCkm7t2pmL5ENaDa4QqSCU21wr355+9CZsTMS4eEUu8jd5G0qA3gP0IhFicdIa20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647457; c=relaxed/simple;
	bh=pxRqVi3UQB4mFifGkeUsmRAjXdg+WloYw2WTh/e/MSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxkRaFAqAQLj2NqiL39oahAV2vhVjepB3EdWLKykzLb9zB3ifCc4nwl7Ff0BVq0LujfBYZSH2/6C3WtqE/NQLVGQqkfIZ2OPqcQ4uJfn9USFI4AVkT1dkImEKzrhySuGx79eyVs9NNmT0I2+Xwe2JtxdaDIiHdHeYVzlTn/nubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YxzuBb11; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A62A21C0003;
	Fri, 11 Oct 2024 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728647453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeTCu/MFBYLE1Q8uTwR3q13ruJYicgTT90hCDUMzXoI=;
	b=YxzuBb11m9CBa6+PLxB/QcpQxH0zg+5VGYwMnTTGkHNfKW322/ohoI4VAsW6IyZmr4HGYF
	KsWwoAUeRZJMa+zsb2FGQuB72/J0prbI9dEU0Xmhfpzd68999g9TcnzsclFLzbi6YGywlV
	GomgcePK8L618ArkXdvqPCz/1BPkQahiLivTEZTmmK+39HRxOFAwN8VZLmQrcEbzI5wqUu
	lGrpuqhrAGpvD4+XuMQUIcrEu6Q4C0vzdXKECdrJjY/wjGqdDZyzgaHlGGuS7pQfEhNYdn
	XjVKgXdNsqnbGat6xQs/sX+gxWj4GFLev64pFe3czIKRvbBtf0qNaGZVYBb3rA==
Message-ID: <84554ad2-befc-46f0-b5e1-574606ae9fee@bootlin.com>
Date: Fri, 11 Oct 2024 13:50:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: make xdp_cpumap_attach
 keep redirect prog attached
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
 <20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com>
 <ffd94cd8-f29e-49e8-9c6f-23be9d9b1bc5@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <ffd94cd8-f29e-49e8-9c6f-23be9d9b1bc5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Martin,

On 10/11/24 03:23, Martin KaFai Lau wrote:
> On 10/9/24 3:12 AM, Alexis Lothoré (eBPF Foundation) wrote:
>> -    int err, prog_fd, map_fd;
>> +    int err, prog_fd, prog_redir_fd, map_fd;
>> +    struct nstoken *nstoken = NULL;
>>       __u32 idx = 0;
>>   +    SYS(out_close, "ip netns add %s", TEST_NS);
>> +    nstoken = open_netns(TEST_NS);
>> +    if (!ASSERT_OK_PTR(nstoken, "open_netns"))
>> +        goto out_close;
>> +    SYS(out_close, "ip link set dev lo up");
> 
> There is easier helper netns_{new,free} to do all these:
>     netns_obj = netns_new(TEST_NS, true);
> 
> Only fyi for your future work.

ACK, thanks !


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

