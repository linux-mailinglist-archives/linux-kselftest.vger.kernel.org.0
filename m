Return-Path: <linux-kselftest+bounces-33324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFCABBF1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1713E188BC3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757E2797A4;
	Mon, 19 May 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W036MQbW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3C1A3177
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661336; cv=none; b=cMhsufOIECNq0glmU8dhcQoyWgm0z/RrI37Ki1fZFakZx7qcOgxrOl4TMVxqTNdHCcFlZcnUwnqmPKTHWjEGn9yVWbZBk7+fxsBZpfRYxzi8UuaLStnm1g3fkAIhV1twlpB67KAHzwudo5xcQcTEpnAJJuetH42CjVO5ULs0YoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661336; c=relaxed/simple;
	bh=gaErXZom/SXbS7oWY3Y26Q3auH/Bb0Nnh+BmJjpjXnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7cYABXgCooVzdu2DuutyIxbF01zV1UxODwDWlhNQ6pH9E1vO6x/qzMaISf3fNKlRpR8Y/P+rUM5IwP22rkb70VWcmA2k81NwGanfbdYVWRChVJVIO1VLLmir7Tm9gil+AgHaUA2tjbANlExPSL5B6/i5jZV6nWLxs7OAzM4PKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W036MQbW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747661332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LnZPk51OG5730zmFf6blk68sjraSbAgAbyfB3yfDnXw=;
	b=W036MQbW64V5XDFs8KbfhNqlesDvLNDcxUzwCbAF7ns675TC/lH89TJZirCZxwJNdRQnc0
	piV6Ge0S7haVXX4XMcKW5nCW0VdTdr9amOSUO4ones3ehuznv1FE4v7RCZr3EH9fBT3eL+
	FniZW1CDxsvKXRBtRxhuxDy9hRzmV1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Sq3U8IjJPxy6oPSdyXFYtQ-1; Mon, 19 May 2025 09:28:50 -0400
X-MC-Unique: Sq3U8IjJPxy6oPSdyXFYtQ-1
X-Mimecast-MFC-AGG-ID: Sq3U8IjJPxy6oPSdyXFYtQ_1747661330
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44059976a1fso19529275e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747661329; x=1748266129;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnZPk51OG5730zmFf6blk68sjraSbAgAbyfB3yfDnXw=;
        b=JnErwhz7k3v6EkijDj5XL8qUFod4lbRjizkcim8kMvM4UVGu3XJL4GP/nzXvHE2YW3
         neIG4sbv5FFBVj2Udj3wGNrl948obWwH/rTmjGZQsOqi7KE6Dt3S24o2Vt8zOxs44a1K
         K1A39I2f2p+CUWKTXFwiwWbqtJ+sS0gLVgDwXUbwpsswom99/GKF2LBV5R9MAzQ/Y+Il
         XvIZe+dvHaCzPIFlVPATlDeG21GDW/ZK87Lt5Z1BoJy2hpwr9YNmN4sIvBF7fr3yJG70
         OQW8KPxP/ANm51N4uC6RL8rjZk+0y+iXJfxlwfZljrnS1XGJ2R8Rhi61YUB/EDsW7spf
         cHQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFWMi9W1gwzqKmHtihRayF6eku0j8ACxtzgXzhPEkEChmKNg+CmHdO2+Iu+u9HVuwJMVW+Y5oVds2nfiFEymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcrx9cX6Pzn8zfT/9Bk1dubkicXovotxZrXtRjaEDlahQ0Bz2
	y6DjNtuvAWyLy1TKTL+kv6rzBlICbH8WtOeadM+/nWcODIpwymvtJ4xIstpQtImlOVxcfYoAlX2
	g9oIazMFcXBxxv8cp7a1MHLlA53F52JS2EQSGNzVD4QDluWUnCNrwiGmbGO8zh1IczqbgZS17rv
	JTHiB/
X-Gm-Gg: ASbGncs9eCaGj79D/dX352AdOriEvrV8W/GXwjSEuhLKys6Gnq1QsVzXTLabA+b4fNO
	xFb5fgRHh36mxJkAriPmUh/sfntQIn5rQW0PPlifKCwGJkaZdyupoAxvLpQghLmRqUSEpeaFllX
	6lVZ36AI5fV0c0HZY+Rkfi84LXOwiAFswgd5VZUeeo+Idx7F1ev/9rh0pseawLwJ54tsluO54lz
	xkCiqDvwUwtidNyhpf8ov/neEw47QMZpJNlUOZoT/WDbiXnx/9PM63AVCYzmLD9IK31oLnCBH3F
	A3Zj4QcLxIHnFrKcg+BdC+rEwrqvKqiXclyAu0wa1FNaMWQmOqhCoUeC7Gjrvr5N7N59y+5APnt
	2ADmU95IolaBsL/UYCCB+X65F+kQtEKXtD5gxSUE=
X-Received: by 2002:a05:600c:c0da:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-442fe667ec9mr98110475e9.29.1747661329565;
        Mon, 19 May 2025 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv/14e2S6T0zf4P7jwon6xq8VRpY0NANQiw20OZzdDZ81YY+TIomD54n5XNTVyMN7y1wWMJw==
X-Received: by 2002:a05:600c:c0da:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-442fe667ec9mr98110265e9.29.1747661329140;
        Mon, 19 May 2025 06:28:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583f71sm136833005e9.27.2025.05.19.06.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 06:28:48 -0700 (PDT)
Message-ID: <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
Date: Mon, 19 May 2025 15:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
 <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 20:07, Mark Brown wrote:
> On Fri, May 16, 2025 at 04:12:08PM +0200, David Hildenbrand wrote:
>> On 16.05.25 15:09, Mark Brown wrote:
> 
>>>> I'm afraid we have other such tests that report duplicate conditions. cow.c
>>>> is likely another candidate (written by me ;) ).
> 
>>> That one's not come up for me (this was one of four different patches
>>> for mm selftests I sent the other day cleaning up duplicate test names).
> 
>> $ sudo ./cow
> 
> ...
> 
>> 1..778
>> # [INFO] Anonymous memory tests in private mappings
>> # [RUN] Basic COW after fork() ... with base page
>> ok 1 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped out base page
>> ok 2 No leak from parent into child
> 
>> Aren't the duplicate "No leak from parent into child" the problematic bits?
>> But maybe I am getting it wrong, what needs to be "unique" :)
> 
> Ah, yes - that's got the same issue.  I'm not running that program one
> way or another, it's not immediately clear to me why not - I can't see
> any sign of it being invoked by the runner script but I also can't see
> anything that I'd expect to stop that happening.  I'll have to have a
> poke at it, thanks for flagging that.
> 
> [Converting to kselftet_harness]
>>> That'd certainly work, though doing that is more surgery on the test
>>> than I personally have the time/enthusiasm for right now.
> 
>> Same over here.
> 
>> But probably if we touch it, we should just clean it up right away. Well,
>> if we decide that that is the right cleanup. (you mention something like that
>> in your patch description :)
> 
> OTOH there's something to be said for just making incremental
> improvements in the tests where we can, they tend not to get huge
> amounts of love in general which means perfect can very much be the
> enemy of good.  If there's some immediate prospect of someone doing a
> bigger refactoring then that'd be amazing, but if not then it seems
> useful to make things play better with the automation for now.

I would agree if it would be a handful of small changes.

But here we are already at

  1 file changed, 107 insertions(+), 56 deletions(-)

-- 
Cheers,

David / dhildenb


