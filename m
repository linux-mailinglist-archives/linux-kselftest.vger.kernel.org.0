Return-Path: <linux-kselftest+bounces-22244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E69D21F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5FBB218FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85A1A9B23;
	Tue, 19 Nov 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/p7my+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA41798C;
	Tue, 19 Nov 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006642; cv=none; b=qo9IdJVfbTYP08XZGoc+kChPCqpkKKZ8aJcMgY+RlKpohFNzA9c/MmU9FokmMbKAeoYMP/zlkywdAbG1ELspXtZ5BAg6g9uVCYvo2zukLlJcbkr6K8VVNAh2vtuVcrUknbdPch3L4cEPmoG220BdTqfFI+Nkt/VW5es3azU8H5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006642; c=relaxed/simple;
	bh=01mOnY+a8qSh1SokfXxE9W5gK3wHTvzsLqt9Vk0HDG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTj6vDJ9zUomyExd9+UR5HLI/S3VrtwswBNVEBo4lMu3dp5RasKYCfaqQPqwIue30dinnWHuqM+CnMBCzeKgPSIAgdT1mK9xyITYpuT3kJRKSLMBTVoiPw3WcLFFqTCLGZVC6lAJ8aCqKs4dgXvAq7xf3X+oIDWmptjQHkM5d4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X/p7my+z; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07C5740012;
	Tue, 19 Nov 2024 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732006632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDLMX9bwiKUPXm5HqirAa1WgF18sn8QriLeZ4mKqO1s=;
	b=X/p7my+zUThqfZtd/oVsk84v3RaXRAVl04osFZ0G8CSXu1bzLEaNt7ygD6XcYFErj8UJk7
	dtxVD5UquR/Goz8gYhMmqqI0712YnCZoiKAfqt3OyFh+keXS+0d5JCz2Y+sqwiKuRTnvM5
	vG5ZbEnyVJPQXYVtuUAmcr7IPuTjV71yHL1pRL8RU0Df9Z5kWdEgX+irCnyUlsfn76lzSQ
	Exm6QG8MuTNTf1C09Qvm0PtW5mQWHOo9RUJzmvTUfgODq8vxtejUF5A65tKwg48wCf1tNj
	qAyBhSA/DQsBJXhCqmV7j3DcZy7IFuOHW/Fj1Wg9EJfZHlq4Xwxc4ppgIeNEwQ==
Message-ID: <20802d12-004a-4b04-9b7d-93dc8b9866df@bootlin.com>
Date: Tue, 19 Nov 2024 09:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: add network helpers to
 generate udp checksums
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-11-ee4a3be3de65@bootlin.com>
 <ZzdunVLMaX1iy85i@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZzdunVLMaX1iy85i@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/15/24 16:54, Stanislav Fomichev wrote:
> On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
>> +static inline __sum16 build_udp_v4_csum(const struct iphdr *iph, __u8 l4_proto,
>> +					__u16 l4_len, const void *l4_start,
>> +					int num_words)
>> +{
>> +	unsigned long pseudo_sum;
>> +	int num_u16 = sizeof(iph->saddr); /* halfwords: twice byte len */
>> +
>> +	pseudo_sum = add_csum_hword((void *)&iph->saddr, num_u16);
>> +	pseudo_sum += htons(l4_proto);
>> +	pseudo_sum += l4_len;
>> +	pseudo_sum += add_csum_hword(l4_start, num_words);
>> +	return csum_fold(pseudo_sum);
> 
> I was expecting to see a call to csum_tcpudp_magic here. And csum_ipv6_magic
> down below. These build pseudo header csum, so no need to manually do it
> again.

I initially tried to fit csum_tcpudp_magic here and did not manage to make a
valid UDP checksum, but after more attempts, it looks like I had a
misunderstanding this checksum computation. I am now able to used
csum_tcpudp_magic in build_udp_v4_csum, it will be fixed in the next revision :)

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

