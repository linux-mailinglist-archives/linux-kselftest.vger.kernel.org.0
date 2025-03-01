Return-Path: <linux-kselftest+bounces-27955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05118A4A7F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF65189CE43
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBA14B08A;
	Sat,  1 Mar 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UZOfXT39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF81EF1D
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Mar 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795582; cv=none; b=BTWpErZJWADFREPFbSpSZrVGLz0NdbrySHdCfl8sIv36rizacv2TCsq3W2DwyprOl8Kyc0O8+BRqSuA94bk29PUpuzFRcHwPN+11Ym+kb9YCY1/KY5NWh2WopQFyeLnccx2NdWa0pDFSUyN/AkAv5a0328CIyQuCjmHeYSv/v9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795582; c=relaxed/simple;
	bh=kZsMvfWa8qntmAFeFfLmWLX+D9k6qyIykJXEp/W/2Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPJXB33DKwb25XpiFU2RP3Zt3wRmf2RLfqUwl9DTbvANcqhQuKAOlZSUFfwwHudidiWnJY9eAXMvyDOpTvg1bktdOOTmYFEefOKi3Tn5IKiS/fozc7S874EC8UDU646BVmJo7aUXQeCO+O/trloa1axa0cHAvCeTHn8JHTFlWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UZOfXT39; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd4dcf2df7so10519967b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 18:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795579; x=1741400379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4XZtAvaxTkTRVYPnyP6lhU6SQoTpqrSM17+f7p2/eo=;
        b=UZOfXT39WtWlmOmA5mnK/QbOFcxwXUDddSuG7qYexz89BtjYwDIT1nTtgMfiB83ESR
         /bQx+Gn9xFye75gSX+d9BYRViKs3Ai5Wg4MlPCvQSMxXo/uRlO1FcyCvh+4hhVPDR8vX
         Xns3W/0nbOneBINXQsHxEm7lUdTu0ijsUFJErWt6yBNVQxSkO1NQ9DmnNchUNeYT4L8j
         XoLfipTsZlDDx2qZU2Ffp/aSM6MYIGTLBJ5HE7XUTWPHGgeUSdZuvKvLlNKduJPHptkX
         olYp4r6C/jUd9bm9vG78PgFZtPXV0JebL3R8zSW1UDtw07kPPwXi+0G6ChmTQEdhqiCM
         D8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795579; x=1741400379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4XZtAvaxTkTRVYPnyP6lhU6SQoTpqrSM17+f7p2/eo=;
        b=rsxTAYJ/ojmchyT4EdpRA1DWiZ95R4zTrXUYV3zth6RMRmFVUPnpHQ/dfYp/TTe9M9
         ggwpS5wUCG+7F7+p3iIAxoL20VWyuEjL4WNBX1Ppim5+S48CB1i0jrCkohJGTnofGqa4
         mRupv1WcUEsqlCdZpZ2Ugv+3n1B7c4sThJpANRgruNTgWVBEZ8kHf0JC6r/xIxyawbVA
         pFnpokEebfGiM1xYyPGx4IEAcyGoXXnjzz793ZCmekDbXw1w4qJ/4q1Uh7m1WYTKdKf6
         mZ1Y4SbS/jWE6olmwzAVdKrTjUBY0VuHBrEOuqlBsPbv53FFiYn7gr3RCwuS47tF0eyn
         uM0g==
X-Forwarded-Encrypted: i=1; AJvYcCUZW2UsCg5m0a3+GlmE2fC1su5xPe/P6/1081sT9NEvIiYdNvV12CyqdC3aq1zJzcFlVLYE64/8q8fzIrmNI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8sucgYjtCqz09U2OQLa6Uob6Fa2MQUsL43cAZDYzKgDHw4EF
	y3tXQbeHS3HV4hmnOPfzcGEvRwYhehYw/3wz4Frh+ONQKidbnFQkY9pSC8/eCjA=
X-Gm-Gg: ASbGnct33vCuQpoOgBzhUk8hdEVq4RMxpsJZeMXN2GiACAVpLMA/jF31egHfIy+0a3f
	EAme4awinGHQIKzdYvaLk/AQWYLtGyG02YRwDBTK7HLAYCC4zJ4ZuNpDN/GKU4zGVgU0X7oqXUK
	AWCDF0vPkv3yUHvUgfMcMqrrOYO5Y2kTYrtGKcWXRNY6z6QLysA2+Ihi3SPxMU1Ibl9m3rNsDJn
	Fs0Hnj0ElhX0cvPXdG1MJ0xkNiY7iO5xvVxSqF59k5Rxkt+BjvAdP7fIs8M9hxUBEqmcmZU1zLZ
	lOFQFNUOl3Hy07l37vCW5jr6qS0Sr51qi4h0emkeVpcX
X-Google-Smtp-Source: AGHT+IHPbXyxz8wWnLiMHMh7DD3CmUXpngJlQ2P3Z57O3VfMgGqTT4+HJ3NwT8O/Y50+KLmi6i4NCg==
X-Received: by 2002:a05:690c:490e:b0:6f9:9e80:46bf with SMTP id 00721157ae682-6fd4a14d099mr74054517b3.29.1740795578759;
        Fri, 28 Feb 2025 18:19:38 -0800 (PST)
Received: from [192.168.21.25] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca443adsm9980187b3.36.2025.02.28.18.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 18:19:38 -0800 (PST)
Message-ID: <e6cb0304-f5b8-4122-b13f-a86224c2a8ee@kernel.dk>
Date: Fri, 28 Feb 2025 19:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] selftests: add ublk selftests
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org
References: <20250228161919.2869102-1-ming.lei@redhat.com>
 <360708f8-437f-4262-a734-b1bd680de339@kernel.dk> <Z8JexssISF2zsNRv@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z8JexssISF2zsNRv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 6:11 PM, Ming Lei wrote:
> On Fri, Feb 28, 2025 at 09:37:47AM -0700, Jens Axboe wrote:
>> On 2/28/25 9:19 AM, Ming Lei wrote:
>>> Hello Jens,
>>>
>>> This patchset adds ublk kernel selftests, which is very handy for
>>> developer for verifying kernel change, especially ublk heavily depends
>>> on io_uring subsystem. Also it provides template for target implementation.
>>>
>>> Please consider it for v6.15.
>>
>> Can we add the zc bits to the liburing test case as well?
> 
> OK, will unify the two tests and cover liburing too.
> 
> BTW, would you like to consider to move liburing tests or part of them
> into kernel selftests? 
> 
> This way looks more friendly for kernel developer:
> 
> - single repo, and single patchset can include both io_uring kernel
>   patches and selftests change
> 
> - easy to run test against same kernel repo

I have considered it, but at least the way I run the liburing tests, it
uses a bunch of different types of devices to get full coverage. It's
not really a fire-off-and-forget kind of setup. Yes you can run it like
that and not have it use any other fs or device, but you won't get full
coverage. The liburing regression tests are also meant to be run on ANY
kernel, not just the current kernel. Eg I do that for stable kernels.

As far as I can tell, the only win here would be that it'd be easier for
someone to run when making a kernel change. And that is a nice win
indeed. But there are so many downsides for me and the tests in general,
that I don't see that win as being nearly big enough to warrant
switching it over.

For new feature tests, I think adding that as kernel selftests may make
more sense - test that it works, test failure/error cases, etc.

> Also liburing development may be decoupled from io_uring kernel
> a bit.

It's already entirely decoupled from the kernel. At least as much as it
can be. Yes the uapi header is shared and synced across them, but
there's really no other dependency there and no version dependencies
between liburing and the kernel.

-- 
Jens Axboe

