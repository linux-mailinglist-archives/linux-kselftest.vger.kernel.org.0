Return-Path: <linux-kselftest+bounces-24591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E77A12A53
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6273A5EBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6041D54E3;
	Wed, 15 Jan 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWiYQGLk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7565223
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963878; cv=none; b=QnrV9veRjNYX5Ju4i4Zp3jAmdBbvjEi8z3kRpKyKbKwMdg2xBdC83TaX3uZOfQ6nARkpLVr5xQJwtt/lKfQn/2ra5rcHIPQvNIuS4WaSgqDtmj49raCdGVRumEaqnLnVcgMXwCdQxjUStrCECi4H4IN0O8B4E8S5+2cKCzynUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963878; c=relaxed/simple;
	bh=LZQ8fPjz687OON6jUEjJHXKOtHqb1s5cvAQZuOJFRYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tj5G4jiyq7Kh07HxAeg3MJbxmBXZflDo74eSxpO0Ei8675ktikb1YKkrM/eK4AMlMxAAqXNZxu6VF6dtLJbwIEMjfd/OzS8yCppf8eQZm5Kp2Q80WDAl0+iuPvtdU5zsN53yTFzKqnSEOG/7zruTURPva1C5nOoip+dH3GwgWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWiYQGLk; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844de072603so1528739f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736963875; x=1737568675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kchx5FBff+Jkr7uune4RFLdzHTx4luoy6cm+6F6IEz0=;
        b=WWiYQGLkK2BkN2Q/qjbzCk/C1hClDvGy+vbE/YezLeZVKc34PXvhgMRsyt81DuhbK1
         vlbmXQSgr/jsQBfgfaasVtSUnGqMwofLBeylBVwrkBEuJknJk80bY6o8njRy8JKlmwsF
         9IGmCWl+//0F/jZ2UohxulukaIu7BbibHwLVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963875; x=1737568675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kchx5FBff+Jkr7uune4RFLdzHTx4luoy6cm+6F6IEz0=;
        b=srb8w7jvn6S/QYLu0VIEaKvl/WLpb2rn/3cvvTvkj/Kn5N1V2xhXzVPmnPnwzeB9yU
         kMLrbklynuIai8Ld1aWEEl6XlnJup8C31v8HoE7hwd6XpCMQrDmFXS6G7o2xa2CLBWHz
         gnLmsbv5BZsrcO+WRyj43vncYz0U1EZs0IPgV7hWstyLihfxRerU3wKKA4z+BwDIEUrU
         GP6IRjoQuY/I/9IYVViz5azQLBBY90Wm+705lXHxOJOdwvs1CfXdpuIU/yvrTtc+LtAz
         U5ZzbqqepdUNEYhDjzU/3mBWK32faGyP54TexOuTEBbda6nRxKbEc3kj+gd1SzjK7VAW
         fZRw==
X-Forwarded-Encrypted: i=1; AJvYcCXIM5hoCj7+ZmHrGzzRp/T27jFqKoRi9uwr50V9MxhUQeZTdiBoLK8ajGjg4nzAm6E8mWS1jltYgIP7jmF7XB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCy+VjOWiHmDFuiMJXoPskIwMTBkT2GBHV874ev/0pe1mTdvGY
	UBWDWcA1YVmqjLtHQv4VLEIytHSo8HOzsV40YZ/J/LqcZTkh/V8VLdbA7/xP6pZRObx5Weq0IN8
	/
X-Gm-Gg: ASbGncta37kSg58RNYK5D0G4v1tnrHT9hMan7qR+3amT8rX0fCrorp48wjy3YcVFAEi
	oZgBZZz0ArEOdEjq8IdmqGlAuXsIhFIjYwVE6QkGFjpEUUy+LA95C6NbOnVgedB3uVWrfLoavLx
	aF31h23YKSKpu6MoPAeIcScC1fmfMbnUuQz97AdQ7geXq2rWUJyf4xHrdSMiJOJuYx9tDX626N+
	ws/L31RZNMrkMzKYaOj3fM8YBdyz6FEK7pAB3d51o0KK8YvCkHofyg+8TUI9Sbdnfs=
X-Google-Smtp-Source: AGHT+IGstEoRVFWLCX1rvF+GzBxjB+Sl3fQa9h+tTaAmxar0MaFf0w/59fRqmG4CurK8euJFsPuFxA==
X-Received: by 2002:a05:6602:418d:b0:84a:7902:d424 with SMTP id ca18e2360f4ac-84cdfdce129mr2968127539f.0.1736963875219;
        Wed, 15 Jan 2025 09:57:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b718433sm4164039173.109.2025.01.15.09.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:57:54 -0800 (PST)
Message-ID: <0e4bfd16-76da-430d-a7a4-f1d31448ea43@linuxfoundation.org>
Date: Wed, 15 Jan 2025 10:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix handling of glibc without rseq
 support
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Raghavendra Rao Ananta
 <rananta@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
 <9b7228cf-29ed-4f35-8b8a-b4f8482c434e@linuxfoundation.org>
 <28c050bb-d844-4b85-a49b-39f2defc20ef@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <28c050bb-d844-4b85-a49b-39f2defc20ef@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/25 17:45, Mathieu Desnoyers wrote:
> On 2025-01-14 19:14, Shuah Khan wrote:
>> On 1/14/25 07:51, Mathieu Desnoyers wrote:
>>> When porting librseq commit:
>>>
>>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>>>
>>> from librseq to the kernel selftests, the following line was missed
>>> at the end of rseq_init():
>>>
>>>    rseq_size = get_rseq_kernel_feature_size();
>>>
>>> which effectively leaves rseq_size initialized to -1U when glibc does not
>>> have rseq support. glibc supports rseq from version 2.35 onwards.
>>>
>>> In a following librseq commit
>>>
>>> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
>>>
>>> to mimic the libc behavior, a new approach is taken: don't set the
>>> feature size in 'rseq_size' until at least one thread has successfully
>>> registered. This allows using 'rseq_size' in fast-paths to test for both
>>> registration status and available features. The caveat is that on libc
>>> either all threads are registered or none are, while with bare librseq
>>> it is the responsability of the user to register all threads using rseq.
>>>
>>> This combines the changes from the following librseq commits:
>>>
>>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>>> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
>>>
>>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")

Fixed this commit id
commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")

>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> Hi Mathieu,
>>
>> Can you double check these commits and make sure these are right
>> ones in the mainline rc7?
>>
>> I am seeing "Unknown commit id" warnings on all of these - my
>> repo is at 6.13 rc7
> 
> This is because those are commits in the librseq project at
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/
> which is a different tree from the Linux kernel. I am not
> sure what is the preferred approach when citing a
> commit ID from a different project ?
> 
> I've been keeping both rseq selftests and librseq in
> sync since 2018. I plan to eventually add a dependency
> of the rseq selftests on librseq, but this cannot
> happen until we freeze the API and cut a librseq
> release.
> 
> This was premature before we reached the major milestone
> of having extensible rseq support in glibc.
> 
> Now that it's merged into glibc (as of last week),
> we can start looking forward to a librseq release,
> which should eventually eliminate code duplication
> with rseq selftests.
> 
> Perhaps we should add a Link: to the librseq
> repository ?
> 
>>
>> Also would you like to add Reported-by for Raghavendra Rao Ananta?

Added. The patch is now in linux-kselftest next

thanks,
-- Shuah

