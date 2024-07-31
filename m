Return-Path: <linux-kselftest+bounces-14508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1589425F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 07:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69131F24D5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 05:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43C4AEDA;
	Wed, 31 Jul 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Coa763Pn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AD946F;
	Wed, 31 Jul 2024 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404827; cv=none; b=dySvlG+kjSbkHMhlq/bcBSotBrsiQAm5ozWsWIgR4Fekhnlj+E48o2p2dKiVMocktpDqNU35K8NGuP9W3sL3iohivkfvdQKsSALzXxgEty0pUhrDf93lkyK+trqhHdpY6LfEoLR2SSYyCn7UJZrecYXZ1wvwxanYj9FuOBX1BNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404827; c=relaxed/simple;
	bh=Kwxp/YTQ0HmCswgUSlLDLxSYZxOvCISDnJ6zLcutNPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrYKVhYZUvMBzu0NK9Tt1KQvLgcjzGUlnBpMVk1XgwKE9CGPoD9OiYXpyNUYdQn4u9TLuuZuDWBlGelV0G1oPF4LyokszSZFRoaHPLRPQcLvnnTeiWCU0u7uXgbjSbpFAuLothfaxaxxEOgvVbLN9C2eegqtQjbe5WwG8GcK3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Coa763Pn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CC661C0005;
	Wed, 31 Jul 2024 05:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722404822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LtOVFsotfqSyGMean6WbQS7hiGP/orLvSJEUh7UOIA=;
	b=Coa763PnFeZECscuoZYH2LLSSrXkyOsCLNnGt6P/mqmS2vFo3JoyR3v6ZFjXpiGXAiQ7XQ
	A0dTUs8Oy+HoshPcFK+e1xm5Rp218cPhwAxVDty9ztQxE5G2NlFpTjBV9miFjjesAFrO7y
	mfgo/8i18C4O8i5MdQ43LC/B2+ByDOAObd6gFwAgXBMuhBIgjtePxfqIYqHy/t3hAidA5z
	rtBVP8CoAzJbFwRuz+OFP7RpA9fu6lOa2HqAnxWeXeIa3vuR6x16ZFBn7RRgcwAJooYcGy
	AJa4wAfA/LZ9DKxXPBgZ5URHYEafdodNyCvHFdVjXfBJ3EVXujlUKSkb26JKRQ==
Message-ID: <91d18e79-b8fd-4ad1-95eb-dab888f58a2f@bootlin.com>
Date: Wed, 31 Jul 2024 07:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
 <20240730-convert_dev_cgroup-v3-2-93e573b74357@bootlin.com>
 <06f7a546-aec8-4804-8f80-1b7000229120@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <06f7a546-aec8-4804-8f80-1b7000229120@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Martin,

On 7/31/24 02:34, Martin KaFai Lau wrote:
> On 7/30/24 4:59 AM, Alexis Lothoré (eBPF Foundation) wrote:
>> +static void test_read(const char *path, char *buf, int buf_size,
>> +              int expected_ret)
>> +{
>> +    int ret, fd;
>> +
>> +    fd = open(path, O_RDONLY);
>> +
>> +    /* A bare open on unauthorized device should fail */
>> +    if (expected_ret < 0) {
>> +        ASSERT_EQ(fd, expected_ret, "open file for read");
> 
> One nit. expected_ret is actually expected_errno. It just happens -EPERM is -1,
> so testing fd against expected_errno works here but is confusing to read. How
> about separating the fd and errno test in the access rejected case. First test
> for fd == -1 and then test for errno == expected_errno.

Ah you are right, I mixed up things here, I'll fix it.

> Please also carry Stanislav's Ack in patch 1 and 3 in the next respin.

Sure, will do.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


