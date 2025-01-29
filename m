Return-Path: <linux-kselftest+bounces-25353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A4A217D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 07:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D87A238C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7B1917C2;
	Wed, 29 Jan 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gnnaGGJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20C6A33F;
	Wed, 29 Jan 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133879; cv=none; b=Jj8zcAnsMTj/TGMiqc2ApJ82aLF1fgabDPxBrlW2N9YhpUbWc8qVph+CddwZj8iGaHMedBlxp0R0MmAGi+L2FHAo7UP68axJEaxRZo0flp1yPgcQKDgEgnrzLkn907EHmbRq5T8+A4rhxHFrlQAi6j+JSMtqMCTDDjDVEyt1wgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133879; c=relaxed/simple;
	bh=YC1FDHPvIyhVgaotn9HTQ2tIBSTNErg1xrN15O9AmV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9X7u9xL4+a5Mf+/UlbI2mgF71btzYsng2uwEQpH/KWmK9sCGL3FyQW6E2HnVbbk4uGs8GFPQ7Wd78Eg7UYdR760OIm8F3b22JvkPOek0GJRicnyKVOQMZV35FvC4j9/IL4dLSGmQnp/W4LtHLHiLZrumZXuY/pHNdu5sTKVg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gnnaGGJ2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46C8944324;
	Wed, 29 Jan 2025 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738133868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oy9s+DlMVJVYzLw4V6sxoakophmWkFXPFuF+80B+ahA=;
	b=gnnaGGJ2OwbmTatOLwgXPXdAjiXdi+o0teojrbh12A25F91jHiV+gQ+3LrMMon1oeCIEAL
	14FwWonMpD3WqJhBT98WoYfO11Sd7wrAkMyxsCjhGL+K1bFbDsFv9x4l1N5PA7q9aCcbmv
	PQ5Dmu2Oeze5soLgKQSEFWX/b0MjxTnHe2XXQEYOkm5rhL7lQXfEKzB61UXXNvSrwtxReO
	Z8rFvQXHey28tx0E+HT1ODQq0UWahKgspa9cQyRdETbxzZmU8OKyIczLAEbNXIfY4ruKGY
	pCIZQKJO/nMujdQSRApQzSy55ShlLzhbrYijVBxlku2XqWXSKk9SGFnQ+JINEQ==
Message-ID: <718da5cc-1ab1-45ec-b61a-8a11162b2f15@bootlin.com>
Date: Wed, 29 Jan 2025 07:57:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/14] selftests/bpf: helpers: Add
 append_tid()
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
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
 <20250128-redirect-multi-v3-1-c1ce69997c01@bootlin.com>
 <e03f6c1d-37c3-4d0b-8e42-1f8980ed379a@linux.dev>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <e03f6c1d-37c3-4d0b-8e42-1f8980ed379a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvieeujedvveevvddtkeetjeeiuedvgfejgfdvtddvveejgeelueefkeetveekvdenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghloheplgfkrfggieemvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrggnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Martin,

On 1/28/25 11:49 PM, Martin KaFai Lau wrote:
> On 1/28/25 1:57 AM, Bastien Curutchet (eBPF Foundation) wrote:
>> Some tests can't be run in parallel because they use same namespace
>> names or veth names.
>>
>> Create an helper that appends the thread ID to a given string. 8
>> characters are used for it (7 digits + '\0')
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) 
>> <bastien.curutchet@bootlin.com>
>> ---
>>   tools/testing/selftests/bpf/network_helpers.c | 11 +++++++++++
>>   tools/testing/selftests/bpf/network_helpers.h | 10 ++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/ 
>> testing/selftests/bpf/network_helpers.c
>> index 
>> 80844a5fb1feef2ff73c2f0293e52495803ab769..d2ff7521aaa696ed04d8f1308394b4c01c1c038b 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>> @@ -446,6 +446,17 @@ char *ping_command(int family)
>>       return "ping";
>>   }
>> +int append_tid(char *str, size_t offset)
> nit. offset should always be strlen(str) now. The append_tid will be 
> easier to use if the append_tid always does the strlen() itself to 
> figure out the end of the str.
> 
> It will be useful to replace the "size_t offset" arg with "size_t sz" 
> which tells the max size of the "char *str" and the append_tid does a 
> check to ensure there is enough space to append the "%07d" tid.
> 

Ok, I'll do that.

Best regards,
Bastien

