Return-Path: <linux-kselftest+bounces-14524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966F942B97
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60F91F221E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CB1A8C0B;
	Wed, 31 Jul 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KXib8HK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7C18DF88
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420370; cv=none; b=VU8f4n3cZp98BAwXea4dTYJB9GbDZ1uLgniYGjt3vSoViXczNY6Jb34OIsFgo2k+YX/s/tBYG+S9TeyOJXPjr6PtEnlPSM5mXHVZLurWkx2sPlWv8oCljSQk8hTgoxkz3o2bTC6GqUKA2OG2FsJQRhyUFkkH0f5ZCLxvpkumsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420370; c=relaxed/simple;
	bh=srmQMSPvjmzX6YVnb4EoadT8BWjHWmgLWmalAmQCuf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAI0caMMDS7HgbvA5r/XjB1M4FbC6DQioh6EjTvXbHmgjHgXDM7LswCnxFf3pWlYMAXuM5W9NmN7Fd0/9WmWKSMUXEbpXETDz3u17tjIvnqZzw/0AgshiRU2B0YewrIMGKvvcrHLPV5nEgT5cnxTbbSpoxPHcS2Eh4e2HZx2iRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KXib8HK7; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ6DS-007Dzc-5b; Wed, 31 Jul 2024 12:05:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7WS5w3a6OnGgEbNmijkTxVC2Csv3HLG/InjtySuGe5k=; b=KXib8HK7QGxqR3+4N85jlCWmeH
	ryBS3iHyrX2boZvL3pHMvmSC605z13qL/Cg9dDJ36VB2vZYlUpfiYcu/+pAeoFVDJtPQsNDsSs4Rw
	LXih0vizz96kIAzoMWCvu7Sb7S1wezRhlC96wZorPCFO9TUIBKe3uGhCg0ACGzV6SfWaCUyAcx5Iq
	/iGtIDUaVCy6mc4uiEqSGhwLB/wrUaogdwOL6N+hll263e6P1w+6DEehZThTQ7/w5hX6XxQTNWWTf
	ggJgmfEQIOpoO3H8ymIGAV6fqkQ7YPefVhRYQ2ONkMPk2U69MsLMi6MELAMTLCnx6gkYQq39sUdl+
	lqS656jg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ6DR-0005LZ-H5; Wed, 31 Jul 2024 12:05:53 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ6DB-003PbE-PN; Wed, 31 Jul 2024 12:05:37 +0200
Message-ID: <04c91b4c-8863-4306-81a2-4cf917e9de23@rbox.co>
Date: Wed, 31 Jul 2024 12:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/6] selftest/bpf: Support more socket types in
 create_pair()
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
 <20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
 <87cyn0kqxu.fsf@cloudflare.com>
 <7ae7a77c-c5ce-4a09-8a6c-b3cd014220f3@rbox.co>
 <87mslyztu9.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87mslyztu9.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 19:13, Jakub Sitnicki wrote:
> On Fri, Jul 26, 2024 at 10:29 PM +02, Michal Luczaj wrote:
>> On 7/26/24 19:23, Jakub Sitnicki wrote:
>>> I was going to suggest that a single return path for success is better
>>> than two (diff below), but I see that this is what you ended up with
>>> after patch 6.
>>>
>>> So I think we can leave it as is.
>>> [...]
>>
>> And speaking of which, would you rather have patch 1 and 6 squashed?
> 
> Don't have a straight answer, sorry . Would have to see if the diff is
> clear enough after squashing it. Use your best judgement.
> 
> It's certainly fine with me to review the steps that were taken to
> massage the code.

That's what I've assumed, thanks. So here's the bpf-next based respin:
https://lore.kernel.org/bpf/20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co


