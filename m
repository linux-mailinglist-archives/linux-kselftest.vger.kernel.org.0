Return-Path: <linux-kselftest+bounces-25569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6DA25AE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 14:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB5164E18
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AD205509;
	Mon,  3 Feb 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqMZGUJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A012205503;
	Mon,  3 Feb 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589420; cv=none; b=Vt64WLC66JsNNVLaBaU/8oidRTCUJCPf6yTYv6vPsEdDQVJa/ZoPTwQ3rZlRrm9T6gGRlmuAMEuVFbyb95cIWGg0vcUqYDVRJsJMVF46K8OOe9fx9bJylfg/KAjuI2ZCLT0XNovU4F1pFI+1vIwFpug7Vp2iMuxJTcxhw5Nrpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589420; c=relaxed/simple;
	bh=UHsxuptmb3xV5kDfCGAfaTxvZvdoOS9QghuWlrwnouQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f28t2Cx/DaNV8NWHKjwDZqbMt784o5tA6iqO6n/Uyjw26MKIq05nOqzPbVs6/JIZ28iGMecoBMOTph6RxAgzQBEqk5U/J2BX6VpoHIrAZK3ooteZLpa+a2MJpkffAOpux+6Gr7QyL6LAj7Pa47BHD1IPUYp2wZzR+N5we3sxWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqMZGUJK; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id D04C1583DE9;
	Mon,  3 Feb 2025 12:59:18 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 639374328A;
	Mon,  3 Feb 2025 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738587550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kud0vb2rndObrFVvKzvzQHf1HyyWb9BxitskvcdGEnE=;
	b=DqMZGUJKFTNXDmN2A3VAGBpAWNbvfP5Hrg1MTSGoA43JU0pawR054fEAdXBsaUttAA7kJ0
	6tA80lf1b0vhwJo6yMTUqTVzP74pLAhkNRasL8pvbLX7Q6fReJHm9cZqEghk4gLv8Hh/+Q
	v2AaME9sZsUS4NHfE06In9Z8nQeH9V8JoIo+eKJAKSOfgaOpTvTpk4fBhpoWkMyEIPCUJI
	vSiFfLyecBMxpQqHOiiul21J4dWefaoPzzUPNa4bho2v5A0jfFGIO3Zq5vENRruJ9bKr2V
	QENSUuOIXtH9r7MYcOCD/P7StfFmPGU6tudk3AUKlG79PG9cM/Pgdx5MM4LT1g==
Message-ID: <1b2965bc-87d6-4b44-bf7d-e491a08d89cd@bootlin.com>
Date: Mon, 3 Feb 2025 13:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 12/14] selftests/bpf: test_xdp_veth: Add XDP
 broadcast redirection tests
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
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
 <20250131-redirect-multi-v4-12-970b33678512@bootlin.com>
 <bba86a91-e945-4ab2-825e-b915216ba3c7@linux.dev>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <bba86a91-e945-4ab2-825e-b915216ba3c7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeiueejvdevvedvtdekteejieeuvdfgjefgvddtvdevjeegleeufeekteevkedvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Martin,

On 2/1/25 2:33 AM, Martin KaFai Lau wrote:
> On 1/30/25 11:21 PM, Bastien Curutchet (eBPF Foundation) wrote:
>> +#define BROADCAST_REDIRECT_SKEL_NB    2
>> +static void xdp_veth_broadcast_redirect(u32 attach_flags, u64

[...]

>> +
>> +    group_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_all);
>> +    if (!ASSERT_OK_FD(group_map, "open map_all"))
>> +        goto destroy_xdp_redirect_map;
>> +
>> +    flags_map = bpf_map__fd(xdp_redirect_multi_kern- 
>> >maps.redirect_flags);
>> +    if (!ASSERT_OK_FD(group_map, "open map_all"))
>> +        goto destroy_xdp_redirect_map;
>> +
>> +    err = bpf_map_update_elem(flags_map, &protocol, &redirect_flags, 
>> BPF_NOEXIST);
>> +    if (!ASSERT_OK(err, "init IP count"))
>> +        goto destroy_xdp_redirect_map;
>> +
>> +    cnt_map = bpf_map__fd(xdp_redirect_map->maps.rxcnt);
>> +    if (!ASSERT_OK_FD(cnt_map, "open rxcnt map"))
>> +        goto destroy_xdp_redirect_map;
>> +
>> +    bpf_objs[0] = xdp_redirect_multi_kern->obj;
>> +    bpf_objs[1] = xdp_redirect_map->obj;
>> +    for (i = 0; i < VETH_PAIRS_COUNT; i++) {
>> +        int ifindex = if_nametoindex(net_config[i].local_veth);
>> +
>> +        if (attach_programs_to_veth_pair(bpf_objs, 
>> BROADCAST_REDIRECT_SKEL_NB,
>> +                         net_config, prog_cfg, i))
>> +            goto destroy_xdp_redirect_map;
>> +
>> +        SYS(destroy_xdp_redirect_map,
>> +            "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
>> +            net_config[i].namespace, IP_NEIGH, 
>> net_config[i].remote_veth);
>> +
>> +        devmap_val.ifindex = ifindex;
>> +        err = bpf_map_update_elem(group_map, &ifindex, &devmap_val, 0);
> 
> I ran this test in a loop and failed at this line permanently (errno 
> E2BIG -7) after enough iterations. I believe the problem is the 
> group_map (aka "map_all" in the BPF program) has a max_entries 1024 and 
> ifindex can go beyond 1024 after some "./test_progs" iterations. 
> Understood that it is likely an existing assumption in the "map_all" 
> definition but it needs to be addressed first before moving to test_progs.
> 
>> +        if (!ASSERT_OK(err, "bpf_map_update_elem"))
>> +            goto destroy_xdp_redirect_map;
>> +
>> +    }
>> +

[...]

>> diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/ 
>> tools/testing/selftests/bpf/progs/xdp_redirect_map.c
>> index 
>> 682dda8dabbc9abbb5d1b0b22dd5f81124142e79..14385df71d7fc40c3b0ee5c6ea0760d0e7336d71 100644
>> --- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
>> +++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
>> @@ -1,7 +1,11 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> +#include <linux/if_ether.h>
>> +#include <linux/ip.h>
> 
> I have compiler error complaining about __always_inline not defined. 
> Likely ordering issue and environment specific. Regardless, I believe 
> the ip.h is unnecessary, so better clean it up.
> 
> I am going to land the patch 1-10 and change the cover letter a little 
> to reflect the fact that patch 11-14 will be a followup. Please post the 
> remaining patches after fixing the bpf_map_update_elem issue. Thanks.
> 

Ok thank you, I plan to solve this issue by using a dedicated namespace 
instead of the root namespace so the index won't be incremented every 
time `test_progs` is launched.
I'll send the new iteration once tested on my side.

Best regards,
Bastien

