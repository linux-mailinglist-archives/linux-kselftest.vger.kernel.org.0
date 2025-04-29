Return-Path: <linux-kselftest+bounces-31903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AEAA0F78
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A21A1895A6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1EB21504F;
	Tue, 29 Apr 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT5RlqXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E417588
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938155; cv=none; b=WsfK1kYYt6RKuW5PgphZzfqUN29Wwlcxfx8qhCLQLd+k8s24nj5Livb8SSH30bcQOre0T3NeabJk4LJLlhDWC+CEqiCchzrHjlBJ9eHZBwdQN+Z/KZc3i4Xc2FMUwZWxbWhU0JwSLIeK9gPCuP2NSlnRBKPl5lpHdlnnk57Sag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938155; c=relaxed/simple;
	bh=GLzAW9i8G2S790fvJT54iIGjcBXQWF5+pxqBgUrcd5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHuAhsCogT7X9mDuWk8p2EEh936wf1Wb95DeGpV6zqwTKrclIGZ9uKwJ4kh2rPJt+pPmDbWSsW+KskrsOHFG2fFEmBEp2lVkVUuktMdmIbA7f86EBk8CZlsoy6QjQmXyTnfrt4aL9d/N3REGKQt0iHBOPhzQ8gYGgExnIhkn6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT5RlqXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745938152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRLeE5mXTuY3mhtQAJn1s429K2TNKhmag459CJyPsyA=;
	b=dT5RlqXpyj5Up0R8mie1Su8PKQ4nQKGZZIGhwRNq1y4uBkIie7NA0iSUaxY7M1MaovPrw5
	NUCaEaSSrYrJjdVaWQzecNh6ckmy42F6m06Lmanm5muEM1guyTfhQ62UNDVLojTYeT3Aze
	WwEsInZv5c0aJM3/s/35SENggq2xbZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-9-ZDVXb8MTSsI34RL8ZIvA-1; Tue, 29 Apr 2025 10:49:10 -0400
X-MC-Unique: 9-ZDVXb8MTSsI34RL8ZIvA-1
X-Mimecast-MFC-AGG-ID: 9-ZDVXb8MTSsI34RL8ZIvA_1745938150
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-440a4e2bad7so17204735e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 07:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938149; x=1746542949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRLeE5mXTuY3mhtQAJn1s429K2TNKhmag459CJyPsyA=;
        b=iDpEOz50R5b8z+FXt2GMy8EOgKj2WIeUFudy0ppjxrnDQMoiiMo/l+BIgMDppzl1rV
         zlGCcHZOCue8qtf5lCJmyep03bIwvUaAqofim/ao2jKDG/c1FQz/DSjAe8qLaPD94v3k
         E2ruKGNGKbP9n1d1VpvQVnp6COJzrkoBn8z9HHNBW4N9MCcr4XKMcq+RZtSkuYiESN5V
         WbWbUIGOsRHOUjEG1qMUH0ZCHPhy8+BvEIN2YW8/y6H7TWeJpktiUrIUi8wOci7TERNK
         ffBiZh55/yFWT1HfPH/ghWB1QSKnccqJ7uVIj7DTz8IlT9koga9p6YnI9Ah6TIDn5crQ
         uk/A==
X-Forwarded-Encrypted: i=1; AJvYcCXrqTfDhoAsZ0glUHDc710/5V8aYXdtv9BxukwwnTN5w8Ju6lSoaShq5BG2pIwDVANZ/DkvorzhZUQYHR32ZRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDStEvjx8mm0rkVN0uwZN/feUSCwnAUI/ZNDgGy0tiXvAfZURe
	EUMTm87kbvVR8efGIF3JBF3roAmkA4zLdCtV+OpPRrNs7KDQNRDkjoRFHdAKMFoglzBf/Llgm8a
	OhQe8oa1BGDE52KeqNtkdeML77yFdIFg/S3TYtbkdyBZ0Rf293Y5bOdDrdzqAOK6DVg==
X-Gm-Gg: ASbGncsOsudM5lJc/1UXodcdE4W6KWicShHA81NrVUK1ilPtFVl2I5XH6PUI6w9wmSS
	cXVt87F7y6dCD2y/ceK56HjRc6JdtXkKHEhwgOUiEsLnjQAhVG1N/nn4rpSGXbRh31q/QzNVjF6
	bEgKwfo8Q4AhwWmvbR+jZ5uz6FboSmf/mFNBEpie1iT6SOwj8Z31aJZ64XJPiW8dTDLIDb2UYKt
	OKZZaUUeK1XPL589CFVno090GqQpCg5OEOHk+uxyi7VpAz1Vr8K4S0d79bfCOSVgxZKxy0bYTY3
	fqSzuuzrCBMJP/jC178=
X-Received: by 2002:a7b:cb88:0:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-441acaa8d6amr27372785e9.1.1745938149542;
        Tue, 29 Apr 2025 07:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAU/uIt3jIn6qteBdEJpE7YYQmT2sXmtYbeftFAijdpp1guCLQBM3tVBZM1Yl/ZYHze6lAag==
X-Received: by 2002:a7b:cb88:0:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-441acaa8d6amr27372525e9.1.1745938149201;
        Tue, 29 Apr 2025 07:49:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5303c68sm158323505e9.12.2025.04.29.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:49:08 -0700 (PDT)
Message-ID: <6f9d20d9-8037-438f-8281-7eac82289696@redhat.com>
Date: Tue, 29 Apr 2025 16:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 willemb@google.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20250425151757.1652517-1-kuba@kernel.org>
 <680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
 <20250428132425.318f2a51@kernel.org>
 <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 3:27 AM, Willem de Bruijn wrote:
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Jakub Kicinski wrote:
>> On Sat, 26 Apr 2025 11:15:34 -0400 Willem de Bruijn wrote:
>>>> @@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
>>>>      return env
>>>>  
>>>>  
>>>> +term_cnt = 0
>>>> +  
>>>
>>> A bit ugly to initialize this here. Also, it already is initialized
>>> below.
>>
>> We need a global so that the signal handler can access it.
>> Python doesn't have syntax to define a variable without a value.
>> Or do you suggest term_cnt = None ?
> 
> I meant that the "global term_cnt" in ksft_run below already creates
> the global var, and is guaranteed to do so before _ksft_intr, so no
> need to also define it outside a function.
> 
> Obviously not very important, don't mean to ask for a respin. LGTM.

FWIW I think it's better to avoid the unneeded assignment in global
scope, so I would suggest either follow-up or a v2, whatever is simpler.

Thanks,

Paolo


