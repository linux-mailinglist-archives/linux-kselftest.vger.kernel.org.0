Return-Path: <linux-kselftest+bounces-15728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9B957805
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D9282BCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F51E211E;
	Mon, 19 Aug 2024 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B5p9yOH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3951E2113
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107559; cv=none; b=bdanjZaXoeQxtYnFPB/lqo1wvRotZlZUSID8edQZwHYfp4gYRsdJViiRtcXKLu/aO5LhbH/yOcor8q0gjpfLxPZllIU3IafC14RCRNfC2GC+51heAGtlBwsDBXHVqascHAEwUGmT6IsHrO1CqMHR8L3gooFE4StPAGJCoUA5Uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107559; c=relaxed/simple;
	bh=5JLeDpzyS9dJhH/m+G5XXy6Q35l9+dEhun5ey8UC8WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWY2v2t6mxJjxz4BaR4de/Iy39rdlt7O1otkMVIVrQd54TKwiIPMw+g9huW205QVv6vn65hOaVI0oE8yyDnhcMhvn0D/IcoDfEfJssthonEXAH1jnVtLA7HIncKGbwZ1TNEIPLilOZZ7bG4vHrm1m7g7TGpLMTNGL9IxpbNO944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B5p9yOH3; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0788766-e23e-4925-becb-0e2108cb9054@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724107555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqtoHF9mFAXgYmpgH4T8LBRT0yHyAd5RB1vDvwAPyGQ=;
	b=B5p9yOH3+9MG9S9/5t9H1cDuo0nRcTjGT1+HGJn2vJF443yHg9TW0qGJIoOj3PIdl26bkV
	cgVF3HomLKZgHDrPtpzL77VbUS8yhCRez8M4P93gUBM5vPXLPysD+KlRCnwS+2q5eK5jMX
	GUv6kSbGuyEH411ietDD3Kucvxgjh50=
Date: Mon, 19 Aug 2024 15:45:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
 <871q2o5lyl.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <871q2o5lyl.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/16/24 12:03 PM, Jakub Sitnicki wrote:
> On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
>> On 8/6/24 19:45, Jakub Sitnicki wrote:
>>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>>> Great, thanks for the review. With this completed, I guess we can unwind
>>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>>> wanted to take care of yourself or can I give it a try?
>>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>>>
>>> I haven't stated any work on. You're welcome to tackle that.
>>>
>>> All I have is a toy test that I've used to generate the redirect matrix.
>>> Perhaps it can serve as inspiration:
>>>
>>> https://github.com/jsitnicki/sockmap-redir-matrix
>>
>> All right, please let me know if this is more or less what you meant and
>> I'll post the whole series for a review (+patch to purge sockmap_listen of
>> redir tests, fix misnomers). Mostly I've just copypasted your code
>> (mangling it terribly along the way), so I feel silly claiming the
>> authorship. Should I assign you as an author?
> 
> Don't worry about it. I appreciate the help.
> 
> I will take a look at the redirect tests this weekend.
> 
>> Note that the patches are based on [2], which has not reached bpf-next
>> (patchwork says: "Needs ACK").
>>
>> [2] [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related fixes
>>      https://lore.kernel.org/bpf/20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co/
> 
> Might have slipped throught the cracks...
> 
> 
> Andrii, Martin,
> 
> The patch set still applies cleanly to bpf-next.
> 
> Would you be able to a look at this series? Anything we need to do?

will take a look. no need to resend.


