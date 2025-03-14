Return-Path: <linux-kselftest+bounces-29031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3CA610A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3096F3B911D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC851FDE29;
	Fri, 14 Mar 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFReOsjM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC842AA6
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954255; cv=none; b=tsMpvIK/nbZCFIG7kruoF+7PtaT+1poOQTcZb7FBNjhsXcRJxAHvphO0UvZatWwYcYUAskV8LMprl7qDjFLedwsTFkehtTES3hQIaG/V+c4I4dtMw9PzNsFu7/191TzwumY2rUmwG7q+pz2HFpmSgXQ6Q9P3oxJ7aDuOzlbEeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954255; c=relaxed/simple;
	bh=XbIiHJcoZC9B43KXCo0L2pc6+TBkTn1NwxGG5MpFWXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dORZ07jcQKw4YLRCpMhp/UyY9etGsiYhe4KjVhBL9JgNpKigsBKdwQ0PfgEMRIRNmt+vHN7rHgVKcM1v9HzpImHMpV0bS/QrlZrvNNz6opvXyK4mHimeB3tSAIORUeNvi7/I88hfsdNvAcT+veUoQ1G2YO+lGLPmr0n+/2gjkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFReOsjM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N+W7JLYSi3FHd5wiExWEG1bnYG61jBb9yzI4idWzEYc=;
	b=dFReOsjMg+u2A6l7GBU1B/9dwPWO9g8hSpbWsBokKYdvjHBF0DjrtW69UMo7j0Jo09/LS0
	5AHxTk0/3fVOSm9v3obab5qz1KJDE5xlDtSQYgk5KbuxJBRGS72K4dqWWiXpJBi71gpLSH
	FU9p6/bX/H4vuHchcyXW9qj2AK2n8Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Bft7BHhEO_qZkPGK9Y1i8A-1; Fri, 14 Mar 2025 08:10:51 -0400
X-MC-Unique: Bft7BHhEO_qZkPGK9Y1i8A-1
X-Mimecast-MFC-AGG-ID: Bft7BHhEO_qZkPGK9Y1i8A_1741954250
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso16071035e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 05:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954250; x=1742559050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+W7JLYSi3FHd5wiExWEG1bnYG61jBb9yzI4idWzEYc=;
        b=BybkpdFKlgJxQsvx8+Mfla0e81WOZNTcFYN0+LuPj6navLqpnyjLmYye0M4yM29iEU
         8kzjRmkTU+cYgh/+tAMY7zll3p8X7oxFdUCR8vNY8miZIaBHQs/7XofHW9uoQTIcx34t
         GwNSQHth3cevdUOBCf3bv5u9q3laj0ELvMJK9vLEI1sclrOEBGxPOrcdoruvQjTrLvDo
         aIlfjqWdsYyw5GGK0g5EdndPOrUo68JBQWwgcvvjr3/Oj6Z0MZfpvdGBbEy2ytEUZjt2
         qDbUNrpXnlINNfYuSwaxloNMY6r/OwbRTGR8FilyBCyreZ89CtRFT0kXF8FEspyn55D8
         +kjg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIw/9eIWJ2vZPqQcFL2SOTUyEGlAAZCGxh97rd7ykk9bdNPYtzNf4zSa8RNKMmTh6/y/La+vikjfF+dHdzXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUBYI8BRfpdN2SaHHuZ/dYnLo43+6xP6XAh2ZSnFGCXS3tm6B
	tpGk75xs9CtHSazDJzsuMXKk4bYcuRjWzQaXYvTMTeXLJ1fEII+g+/NopwjegNexflwofRefx0/
	qD8OXDtpQ9Frpoeu5lqx+aorGCLV2kBpa5BSWPOR1sHXYn6vT2s1j+XFP6VuTPCSfEPCHSC78PU
	4E
X-Gm-Gg: ASbGncsSHfLB+H5LJGks3wxTTqCHCgC1WV2E2nqWXX+ok4gOUuhifhq3BoLBjDQhPm4
	RbmrHs8Ql1+Osoj47IOIU7irBcSbMa1fxA24S5xZkI8JgXQU/w5jq3ocQUOvIh/DaRh3GxRhpBl
	kMFOODF9g7iPBSmnoXcTGhvVm0U73PueZimaDiPrW1+OFHWU8wcIfsEDb1zljXSxiLPIMMHjQs4
	B4CwxA/vkL3Vjl0MSHWJodAjFD26OGA4wnOWQrclXyMF/cFS/j/+ARSBAjTArP6+9wGMns/BCyY
	0V4RtRsdlmFZs6hQPOVJ/lvXHwBAAJRjwp82epsnpPuiAH+gfkBQ2yQwXmPIXrXJoGZBlZuJVrc
	OgPGk2Y6CnpOmCNxUjFKT7h1k79B2pYlzkPUdFhwrmGI=
X-Received: by 2002:a05:600c:1908:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-43d1ec80980mr31107565e9.7.1741954250529;
        Fri, 14 Mar 2025 05:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoxby3mE34K41WTlTk/z5r+dIaWHqYottBOdqY1VDqMeig1kOOVvVsfUN57fluTQqQAxwE/g==
X-Received: by 2002:a05:600c:1908:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-43d1ec80980mr31107225e9.7.1741954250152;
        Fri, 14 Mar 2025 05:10:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d? (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de. [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcfbcsm15437505e9.11.2025.03.14.05.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:10:49 -0700 (PDT)
Message-ID: <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Date: Fri, 14 Mar 2025 13:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9FHEdZoYbCMoj64@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.25 09:34, Brendan Jackman wrote:
> On Tue, Mar 11, 2025 at 08:53:02PM +0100, David Hildenbrand wrote:
>>> 2. 9pfs seems to pass the f_type through from the host. So you can't
>>> detect it this way anyway.
>>>
>>> [3. I guess overlayfs & friends would also be an issue here although
>>> that doesn't affect my usecase.]
>>>
>>> Anyway, I think we would have to scrape /proc/mounts to do this :(
>>>
>>
>> The question I am asking myself: is this a 9pfs design bug or is it a 9pfs
>> hypervisor bug. Because we shouldn't try too hard to work around hypervisor
>> bugs.
>>
>> Which 9pfs implementation are you using in the hypervisor?
> 
> I'm using QEMU via virtme-ng. IIUC virtme-ng knows how to use viortfs
> for the rootfs, but for individually-mounted directories with
> --rwdir/--rodir it uses 9pfs unconditionally.

Ah okay, that makes sense.

> 
> Even if it's a bug in QEMU, I think it is worth working around this
> one way or another. QEMU by far the most practical way to run these
> tests, and virtme-ng is probably the most popular/practical way to do
> that.

I'm afraid yes. Although allocating temp files form 9pfs is rather ... 
weird. :) One would assume that /tmp is usually backed by tmpfs. But 
well, a disto can do what it wants.

> I think even if we are confident it's just a bunch of broken
> code that isn't even in Linux, it's pragmatic to spend a certain
> amount of energy on having green tests there.
> 

Yeah, we're trying ...

> (Also, this f_type thing might be totally intentional specified
> filesystem behaviour, I don't know).

I assume it's broken in various ways to mimic that you are a file system 
which you are not.

Your approach is likely the easiest approach to deal with this 9pfs crap.

Can you document in the code+description better what we learned, and why 
we cannot even trust f_type with crappy 9pfs?

---
Cheers,

David / dhildenb


