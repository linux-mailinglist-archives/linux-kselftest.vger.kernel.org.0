Return-Path: <linux-kselftest+bounces-14286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7D93D9F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B70B1F23BA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A793149DF1;
	Fri, 26 Jul 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pMjBjA0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5B210EC;
	Fri, 26 Jul 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026737; cv=none; b=Vv/GKtTXR/2X+9W830rDm1GE+lR/SWx4NZeus2uPJstoZTz7oFyTR8dw2MFjSXLdYjae9bdhj4hObhmvhwe4h4tqb7BVvys9P6ib+vezopa2CqC5xmsPJawj7jZMbqD0Y7KGvdMX4Loe9trkQqiZFDclnvHP8Yg+CCPnXSjs+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026737; c=relaxed/simple;
	bh=D5Kds4oTdYUJDagA9z1q5H3IBWQMpKsWEDMHLLY5CUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mICftb4o21/928ufVq6gu2kUajLUNmuIAQUK9cCbZYliUXE0InBJTflU3Vysukx0idRPBcX/DOWqRb+2A44apMK/DqqxNOzTJmky2JZhVVxa5RrvWzEGMlTES8i7OdHwh3yV71JLvh/LiyktcN3sPpUVP7imTppB/EZ4RxolhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pMjBjA0S; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sXRoZ-00D7bp-W9; Fri, 26 Jul 2024 22:45:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=zrT9ifHlIsnaqKTjRvsVB3EVCGFeERnZ55LV4Q/VAL8=; b=pMjBjA0SyNoB4RUHbVyFS95oYu
	kEUuyIL5E2jLLOPj8jooKrEBmrL1+Oon0iLTvoSDO9Q20yoUZa6jjaDVVcvJ7mt8KHAjbbutCl2mB
	zTJNJuOZAks7Btrye4sHVmV3yw9rLFLe7AGtciZjgDjU6d/FvM+Dvd9MxE8OWL23N6ZIUh9wU8Uds
	+tAgPakzbR22oOcbeH/vv5c+O3j68FanVoKc++zvRBBeHgu20QjnABtEYFgBdf1LUMKtev5CV/z3x
	rAMbr5g8noG6anUIBSI8fwfUjfs0k4RoX6mt1w3uBkyH3AnnFv0L0k3MBoRYZEiVFvjeTSoKSq4YW
	+TqkP23g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sXRoZ-0004QX-CT; Fri, 26 Jul 2024 22:45:23 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sXRoO-007VgG-KS; Fri, 26 Jul 2024 22:45:12 +0200
Message-ID: <da8502d6-38b7-44a8-bd9a-708a64e9fd83@rbox.co>
Date: Fri, 26 Jul 2024 22:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 0/6] selftest/bpf: Various sockmap-related fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
 <871q3gkqd6.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <871q3gkqd6.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 19:36, Jakub Sitnicki wrote:
> On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
>> Series takes care of few bugs and missing features with the aim to improve
>> the test coverage of sockmap/sockhash.
>>
>> Last patch is a create_pair() rewrite making use of
>> __attribute__((cleanup)) to handle socket fd lifetime.
>>
>> v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>>   - No declarations in function body (Jakub)
>>   - Don't touch output arguments until function succeeds (Jakub)
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> I see this depends on your previous series that got applied onto bpf
> tree, but this seems more like bpf-next material considering it's all
> tests, and a mix of improvements and fixups.

Yeah, I guess you're right. I'll just wait for bpf-next to catch up, then
rebase and respin.

