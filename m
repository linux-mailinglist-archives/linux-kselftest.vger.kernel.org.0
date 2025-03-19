Return-Path: <linux-kselftest+bounces-29446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6199A6963D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A428D3B442C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B411E5B81;
	Wed, 19 Mar 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EkKF9eI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D41B4138
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404854; cv=none; b=ZcN/jKhsgz3VCK+9kZ6odH4UDwhrUMF5vjU/WUEU9s2NnXLiOagWr+v6IGrvwWdDOcfpXjlxU8E0SvoDkP12zM8W+OdaqQhI5KZjcDLCuUREbZcdX5ggdOqZNrxfljokqXJV2ibJHpotPHqVybBz5R0J7AK9/SDjZcoGpn/JHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404854; c=relaxed/simple;
	bh=9eJhBp2CqpKw9RFoR2qkeJMFuZnpzDtvLg4WBOctADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q37dhBQjxLxpNQ/7yqSEnoCOFOREkCOH0toMZPaWAWCDeBsfXi+bue6AI1gUkM3MU37NOokSwOyjnbwqj9iQdh+6d1v/mIFXF2s4DqeRWZ8dH/g/pMb/R8SY0lrMqIervoLzp0ftNodvkOklp89/jJIX2YjHU/q1H/sBWJ0g80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EkKF9eI+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso31312039f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742404852; x=1743009652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wG+6kvFgd9GzD5/DJZ7WjNvBAVnDvESE/TrYFKU/DtM=;
        b=EkKF9eI+y7Iz2u4bunkNuL2n2kO4umohiZDOxeD42UlPcu7Qw/r65SDM2WEcpJz5XN
         5gRmyzllXdKJ9nTvWurT6RShDZDLem2AxIfhtXvN7R7DkxflWk/990oy3B1Rx0vls9lm
         mznNVcJsjqmgo7tVzN+31oaWV/kkFOWulIhcd+AxWaEcZr7BPyompZNmrPF1M1LWq2gl
         6L5TfZ5y5rq2F15QWcJeY148AG86abEh5H6hER1Kx36ORPucCtRvbJxEbZfcP3m+G4OK
         rZiP8ms7jq4RpSPCvrssuq+KdgexfEDTwdNI94dAkDpamo28+sYhHJuM33D57yDHJNNN
         PrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404852; x=1743009652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG+6kvFgd9GzD5/DJZ7WjNvBAVnDvESE/TrYFKU/DtM=;
        b=LH31cromRXpLtQr5lO4q1Gtij3pq0ZVWGq9vtkvEWAeg3CSB13Jv4kLk9QaTxHMIkV
         H1y9KriZsmYdBQGjYx1wXPTZKEhobbQ1r2lXAljaPb96SHIHEX7mMITmR0PdCVTWkQ5I
         6La3T2vf8yuH9sEomq9kRDI8rKKwsSoPIDyKdE8c7+1/h/JLNTYjQyPp12OmUYkt9rJj
         IJHjfFY15RKo/4obEEc6UoFkwRCpwRHpB0lm2pjndlWwVgtc6uCq8Mao2ynf1TBV7Q82
         IzJHQ+243hLGlHMId7jfYwE+HU0eX3B5MwSJFpt6obWcp9w17j7Ne5C4nGfVFlwlSUbL
         8Nrw==
X-Forwarded-Encrypted: i=1; AJvYcCUTaV1N1u89HcYmsF+d+9voFIWHLk63YbMr21ONwCGtD08JhDdmvogDFA5m3EaHsGmLb2wvdOt6momhJJ7SI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXtLv20Woq3ym/AW7hhhHVyDSIZsCuASOHaRVhOqfEk+cqov4
	b/6guZ9clPrEL2QlNsnpcpnsEtnINqj+RgKfV5aJogunCtWu6Bzk7dcGZiP1hkc=
X-Gm-Gg: ASbGncuo5J9X7HXrcG9plrx9y9HNnJsqJHYdMT+0CNm2NsnMyIzhwdqW2sVbDE2zO8G
	tyQZstkOH0qS/xgsLGcOsMl0sPNlFnHFLfZllNGukNYNlDV2PosTQ7xBY2phseQi6D5e4+2xUao
	cXneaWW83Z0qrkg7ZozPIaAQHkTFMghd4eeJUtmIwowgHGhaFeuPWd7J+QiJBFYH6tWZIxc9acz
	Pw3utGr3fvynSHR80MTzY5tjEQNxhA+KMqJbgRyczgjCIJY4IlNc6YoA01iDkTtMUb6qPaINXcK
	FfdykR5vDZftje9MdUXqhw/O0XD0gMzWIZiUfuZ6
X-Google-Smtp-Source: AGHT+IFRIJ25W/ogwqAxdqm65EV+PQrMqVK4nXcMHoehq/ZaLwlz8F6/y6C/Lr8EqUAPWpYpQs5DBA==
X-Received: by 2002:a05:6602:3810:b0:85b:3874:6044 with SMTP id ca18e2360f4ac-85e1ef6c5d8mr27906239f.7.1742404852184;
        Wed, 19 Mar 2025 10:20:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879df59sm320382739f.21.2025.03.19.10.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:20:51 -0700 (PDT)
Message-ID: <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
Date: Wed, 19 Mar 2025 11:20:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:04 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
>> On 3/19/25 9:32 AM, Joe Damato wrote:
>>> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>>>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>>>> extensive work done by Pavel [1].
>>>>
>>>> What is a "zerocopy notification" 
>>>
>>> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
>>> sendmsg and passes MSG_ZEROCOPY a completion notification is added
>>> to the error queue. The user app can poll for these to find out when
>>> the TX has completed and the buffer it passed to the kernel can be
>>> overwritten.
>>>
>>> My series provides the same functionality via splice and sendfile2.
>>>
>>> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
>>>
>>>> and why aren't you simply plugging this into io_uring and generate
>>>> a CQE so that it works like all other asynchronous operations?
>>>
>>> I linked to the iouring work that Pavel did in the cover letter.
>>> Please take a look.
>>>
>>> That work refactored the internals of how zerocopy completion
>>> notifications are wired up, allowing other pieces of code to use the
>>> same infrastructure and extend it, if needed.
>>>
>>> My series is using the same internals that iouring (and others) use
>>> to generate zerocopy completion notifications. Unlike iouring,
>>> though, I don't need a fully customized implementation with a new
>>> user API for harvesting completion events; I can use the existing
>>> mechanism already in the kernel that user apps already use for
>>> sendmsg (the error queue, as explained above and in the
>>> MSG_ZEROCOPY documentation).
>>
>> The error queue is arguably a work-around for _not_ having a delivery
>> mechanism that works with a sync syscall in the first place. The main
>> question here imho would be "why add a whole new syscall etc when
>> there's already an existing way to do accomplish this, with
>> free-to-reuse notifications". If the answer is "because splice", then it
>> would seem saner to plumb up those bits only. Would be much simpler
>> too...
> 
> I may be misunderstanding your comment, but my response would be:
> 
>   There are existing apps which use sendfile today unsafely and
>   it would be very nice to have a safe sendfile equivalent. Converting
>   existing apps to using iouring (if I understood your suggestion?)
>   would be significantly more work compared to calling sendfile2 and
>   adding code to check the error queue.

It's really not, if you just want to use it as a sync kind of thing. If
you want to have multiple things in flight etc, yeah it could be more
work, you'd also get better performance that way. And you could use
things like registered buffers for either of them, which again would
likely make it more efficient.

If you just use it as a sync thing, it'd be pretty trivial to just wrap
a my_sendfile_foo() in a submit_and_wait operation, which issues and
waits on the completion in a single syscall. And if you want to wait on
the notification too, you could even do that in the same syscall and
wait on 2 CQEs. That'd be a downright trivial way to provide a sync way
of doing the same thing.

> I would also argue that there are likely user apps out there that
> use both sendmsg MSG_ZEROCOPY for certain writes (for data in
> memory) and also use sendfile (for data on disk). One example would
> be a reverse proxy that might write HTTP headers to clients via
> sendmsg but transmit the response body with sendfile.
> 
> For those apps, the code to check the error queue already exists for
> sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
> way to ensure safe sendfile usage.

Sure that is certainly possible. I didn't say that wasn't the case,
rather that the error queue approach is a work-around in the first place
for not having some kind of async notification mechanism for when it's
free to reuse.

> As far as the bit about plumbing only the splice bits, sorry if I'm
> being dense here, do you mean plumbing the error queue through to
> splice only and dropping sendfile2?
> 
> That is an option. Then the apps currently using sendfile could use
> splice instead and get completion notifications on the error queue.
> That would probably work and be less work than rewriting to use
> iouring, but probably a bit more work than using a new syscall.

Yep

-- 
Jens Axboe

