Return-Path: <linux-kselftest+bounces-15083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363294D527
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863C51C2039A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F538384;
	Fri,  9 Aug 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyZecz6t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C117C7C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222912; cv=none; b=EAe4+kj6EnqZrn4MJYvvZnWEQkvnP68mVuCQbRrLgZh9ci/67g+xZslYU6pNOJQOw+7GAq/ARuYNEW9UXp4ie17irEwhnNMz6swOCv2ebiyLpQAbPqK8DSY32I4ZT4ekfUKYrODtdjP1IZNI+v46GgTrQG+uyKjqA2wG6Wk5p+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222912; c=relaxed/simple;
	bh=kO+4Qg2Kos2wHUaffFnXRBuCVtxo8Uf72SitEfqHUNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5qdB00WeOWGzjxby/qTEhY12MlN6XqU5GM2VwIqkDYuMtbd2AVwtPzyJ03xc+NzL/m5G1A0oN3yILINhgQ+kplmPO70VCZYDTINcTsbzf96FDNmQhpb4UcYRLosLcRRqHdKIHoGAkk8nKwlx0ymeLPtvDUuzO8ukAjvRlgEYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyZecz6t; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81fdcd41e4cso7265539f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723222909; x=1723827709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDDjHGtk+i/sBtfC6S1Ya7WBwtIwzRoHly+Mr+MUcXc=;
        b=fyZecz6txWfWabkJ5SO8+fnoemqimtdBt2U84K9lxPKxAUN4ueK4cxRavlcFHAfud/
         0PPAlBbmbj3PdhdfJ04l5nL664pBkc2OM5PEhSm7AtUqh+TGBZYmwN2WKk74Vmp97Fkd
         NLrs2gAFDEcZvqzqN6f4a1cwUREZaXO5zsgSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222909; x=1723827709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDDjHGtk+i/sBtfC6S1Ya7WBwtIwzRoHly+Mr+MUcXc=;
        b=LjFTat5B7y760fPrZYLRmuQeJLwIC8bbTn8qFdrcbem+DwqPz5EFi+OMBrhXgeN4EL
         ug3Yw2D3bglkHt56wSW/bzxTIGYUPWms2zEHbe/xAGe2nBvaGW29+eO2lsUjPHsWAgiz
         QJt8zt+QP7gQCXjJxDulYzqzxWaT7ppmwhCCft18dluZPEQL7s7d+NwWsqdeCfqEwlYI
         qVlk6crTasCOWsr9oT3lq7/pQQvOineUzYwpsR2SrlQevhZspEMy3osUWJGOjC6a6kzL
         FOg1JptLgnJQoVkbfF2ReyuZjrqy1Efd3GS43zwN/2wUID7JhZKc4+LNRPKz/VXOuC5P
         AY/A==
X-Forwarded-Encrypted: i=1; AJvYcCXN+BdyU14JX8dN1+Xc/ePPrR/Cd29tFB1m4Dnlp3IRYrOKiDs53ilXDE7XT32YEu0g6zsgWPgWqEfCMuvj4eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiF3RqbcNI31aPrtjgwANfor/ZSYAdhnZ4VRxeFOHUKtMTjw7A
	mLXsZKF2LdSknNEmGgnx01DAAuFWgjRdtFR2b1SzrXqcmihUjd9EqghW/b9x7Jg=
X-Google-Smtp-Source: AGHT+IEVM26zTJDnq4KUOavT/txNlVM1PwFY7bjzhsFY01vmETUlAlxZW29W+mujXaC/jkXCKqSlMA==
X-Received: by 2002:a5d:9755:0:b0:822:3c35:5fc0 with SMTP id ca18e2360f4ac-8225ee4d6a1mr150211739f.3.1723222909444;
        Fri, 09 Aug 2024 10:01:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769105cbsm9501173.27.2024.08.09.10.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:01:49 -0700 (PDT)
Message-ID: <41cb60af-3175-42ab-896f-b890e51cde0d@linuxfoundation.org>
Date: Fri, 9 Aug 2024 11:01:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240808145639.GA20510@asgard.redhat.com>
 <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
 <20240809010044.GA28665@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809010044.GA28665@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 19:00, Eugene Syromiatnikov wrote:
> On Thu, Aug 08, 2024 at 02:20:21PM -0600, Shuah Khan wrote:
>> Wouldn't make sense to fix fix this in selftests main Makefile
>> instead of changing the all the test makefiles
> 
> As of now, the usage of rpath is localised, so it is relatively easy
> to evaluate the effect/prudence of such a change;  I am not so confident
> in imposing rpath on all of the selftests (and, if doing so, I would
> rather opt for runpath, to leave out an ability to override the search
> path via LD_LIBRARY_PATH, if such need arises);  in that case it is possibly
> also worth to add -L$(OUTPUT) to the CFLAGS as well, as the compile-time
> counterpart.  But, again, I was trying to avoid the task of evaluating
> the possible side effects of such a change, considering the variability
> in environments and setups selftests are run.

Okay.

> 
>> Same comment on all other files.
> 
>> It would be easier to send these as series
> 
> I hesitated to do so due to the fact that different selftests are seemingly
> maintained by different people.

You can cc everybody on the cover-letter explaining the change
and the individual patches can be sent selectively.

This is a kind of change it would be good to go as a series so
it will be easier for reviewers.

I had to comment on all 3 patches you sent - instead I could have
sent one reply to the cover letter. It makes it so much easier for
people to follow the discussion and add to it.

> 
>> please mentioned the tests run as well after this change.
> 
> I have checked the ldd output after the change remained the same (and that ldd
> is able to find the libraries used when run outside the directory the tests
> reside in) and did a cursory check of the results of the run of the affected
> tests

Please mention that then in the change log.

I applied this patch and ran alsa test without any issues. You
could do the same with:

make kselftest TARGETS=alsa

(but not so sure about the BPF selftests, as they don't compile as-is
> due to numerous "incompatible pointer types" warnings that are forced
> into errors by -Werror and the fact that it hanged the machine I tried
> to run them on).
> 

I see a bpf patch from you in the inbox - if you mention the issues bpf
people might be able to help you.

I am not replying to your other patches. Take these as comments on others
as well.

thanks,
-- Shuah



