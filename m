Return-Path: <linux-kselftest+bounces-22242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1869D21D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FACD2829EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7D19D07E;
	Tue, 19 Nov 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LHU0IYU/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660719D072;
	Tue, 19 Nov 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006183; cv=none; b=KaVtTqqr7Igh1lNNJk6/UJfZeMgMPlftIb5KORmfP9IDh4HZYtcPhCSXLBoeqOT9YV9ur+MC1QdqscstA4NMW0Vp/38XAVA+eIqEiSEnrJ8yBf9YZACzJz9brq0Xo8PuHjfMP/cuotMyIsFtgm1Wy0PiGbYTD9mAM0v30x/1DjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006183; c=relaxed/simple;
	bh=uMgB+5uUNBgBUTbqdd8UUwDS+ZOWODedX2q3Khw1kd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INXn8d6kTj1bHv6zbnJyxB8SaGrHWpb5zoLyBHTmT2DLk6vc4UwvZnA9q5nDxFVLITBn03RZIBomE2lBfRom6K/1t68YzinBWX74wvAbXU5y6zr6DGSIWY/Su1R43/TYYu8F/a1N5vKsIbHZLN/eJZEmdKWu2p/ExBZsj1RBynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LHU0IYU/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 642B8E000A;
	Tue, 19 Nov 2024 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732006173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLPwCmOJirkQA+SOX3QaF6mG/lQKRCB2VKXxApvD/+E=;
	b=LHU0IYU/Dt3gn3KgUYMOd73LyhehQ0wcaSJZqRg0my8nsoWc3KdrD/v4XDNs98GLgGDwBN
	Ipj182mNpTD7pRwvOUdyJQKwOCMEPwLS0+M9ECMzgHqIkCCmfjvt4Uk9qZdOZo1cs1Fba2
	Z895Rztex1HtXEf10SFAxELMMdtTGQceSLVuRnEGeWq3P0PYiC0ds+E//aZdZUC82MZJzL
	O1dMNG5Q2of+mK+IjcESkXHOirU6OC3fQ1ZACajaXlu3WsuO9HC3i595KsyJpRtpzPbAQP
	BPCveF6kpq7XjWwkKUTzqnB9fPkcosydsQj5TnKm6Wv3ziFr8U5Wx9DShrW8hA==
Message-ID: <66c6702a-d4a8-4354-8cd3-6edc93d0ae79@bootlin.com>
Date: Tue, 19 Nov 2024 09:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/13] selftests/bpf: move ip checksum helper
 to network helpers
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
 <20241114-flow_dissector-v2-9-ee4a3be3de65@bootlin.com>
 <ZzdpeMsHGh1zCZei@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZzdpeMsHGh1zCZei@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Stanislas,

On 11/15/24 16:32, Stanislav Fomichev wrote:
> On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
>> +static unsigned long add_csum_hword(const __u16 *start, int num_u16)
>> +{
>> +	unsigned long sum = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < num_u16; i++)
>> +		sum += start[i];
>> +
>> +	return sum;
>> +}
> 
> Sorry for nitpicking, but can we call it csum_partial? And match
> kernel's prototype with extra sum argument? Should be more greppable
> for the future test cases that might want to use it...

Sure. TBH I did not realize that those were based on the kernel ones. I'll
update this to keep the same prototype.


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

