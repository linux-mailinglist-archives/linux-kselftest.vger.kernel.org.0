Return-Path: <linux-kselftest+bounces-23936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07EBA02013
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 08:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F43A3C9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1E1D5AC3;
	Mon,  6 Jan 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qx+eqjqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B7B676;
	Mon,  6 Jan 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150072; cv=none; b=n6srBVHO2LECKIA/UNn+sbSjl484CJcd2fdH3TqJQqWDZ9skAtQi94YvnJHX+TEtPWAZgRw2gAmsaltotbqLRMKXJ93X3Y4Y9A9CCnOhks4ya0X5MsEZxGQ5K4+cOLHyRUEuxrfHCGz8uqStGnpMco+RWUAutCwsocH+E5XLJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150072; c=relaxed/simple;
	bh=uVhaCB8dTvQKOKi/9Zpe3Ckh4EC4m1wh+mtzskJQF+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3Rood0GaGEImYtkL06NUMPIWSK/sZ67h3iudxJJ1jSdnycKbmnLbd1RC03q1Ge2hnZAk5T6b6TS+TqHXfEF5juzV4Esu01wSB23nYb3HY7OIjQJeUBIvUqvrc/6trzz+loL64Wp8F0PFLHL/a5Hk9GLgYEJy/4rtLjqkWyja4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qx+eqjqg; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1467340005;
	Mon,  6 Jan 2025 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736150060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/Sjodq7qq2EI8HalXNJGQv85lzSJjUANME+DYv7yG0=;
	b=Qx+eqjqgPlBBZ4Q652C3bmAM5CdL8koUIdmX6WiQ41eCELpQcqVM8dsiB8a6eXWyL6xQ/m
	gVscO+rYVkII4ZYa3lzV9DgLhg9Xp5mzzeBMFc4c4qN21aWS2wv74prbmpqoZMj0hWztDj
	KwwGDpqYxgtBxmBWFUptCyTJbTZVAXzJvA02kTUbVR7U9ykLb7dv8G+eXs88w4oztSJDxJ
	ojXuCQhOQjCY06qryHNQrj9RzA5mV/Bvh2qKbxUWcNYssG16ABWN0H1DpbClVPyz7H1Pg1
	NbC4cJ5qMBZ+vYhSXNYrVeX+vtXOq9FTmwPburl9Td5BR1z2QQ+azBX9uJ5Lhw==
Message-ID: <9a18fec7-8f73-48c6-81d4-5baa5b701f76@bootlin.com>
Date: Mon, 6 Jan 2025 08:54:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/bpf: Migrate test_xdp_redirect.sh to
 xdp_do_redirect.c
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
 <c7ff7788-d3af-4867-8b13-57a0bf1f529a@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <c7ff7788-d3af-4867-8b13-57a0bf1f529a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Alexis,

On 1/3/25 1:54 PM, Alexis Lothoré wrote:
> Hi Bastien,
> 
> On 1/3/25 11:10, Bastien Curutchet (eBPF Foundation) wrote:
> 
> [...]
> 
>> +		SYS(fail, "ip link add veth%d index %d%d%d type veth peer name veth0 netns %s",
>> +		    i, i, i, i, ns_name);
> 
> nit: since you have to run an ip command through SYS anyway, you can reduce the
> open ns/run command/close ns dance (and all the resulting error checks) by
> running directly `SYS("ip netns exec %s ip link add [...]", NS0, [...])`
> 
> [...]
> 

True, thanks.

>> +	ret = bpf_xdp_attach(if_nametoindex("veth2"),
>> +			     bpf_program__fd(prog_to_111),
>> +			     data->xdp_flags, NULL);
> 
> nit: since we are setting static if index at veth creation (which looks needed
> for this test), the if_nametoindex could be replaced by the corresponding index,
> which could be directly a define
> 

Also true, thanks.

>> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
>> +		goto close;
>> +
>> +	ret = bpf_xdp_attach(if_nametoindex("veth1"),
>> +			     bpf_program__fd(prog_to_222),
>> +			     data->xdp_flags, NULL);
>> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
>> +		goto close;
>> +
>> +	close_netns(nstoken);
>> +
>> +	nstoken = open_netns(NS1);
>> +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
>> +		goto close;
>> +
>> +	SYS(close, "ping -c 1 %s.2", IPV4_NETWORK);
>> +
>> +	close_netns(nstoken);
>> +
>> +	nstoken = open_netns(NS2);
>> +	if (!ASSERT_OK_PTR(nstoken, "open NS2"))
>> +		goto close;
>> +
>> +	SYS(close, "ping -c 1 %s.1", IPV4_NETWORK);
> 
> Is it really useful to check ping originating from both interfaces, isn´t a
> single ping able to stimulate programs attached to both veth0 ?
> 

Indeed, I think a single ping would be enough, I just wanted to stick 
with what test_xdp_redirect.sh does.

> Aside from those minor points, LGTM :)
> 

Best regards,
Bastien

