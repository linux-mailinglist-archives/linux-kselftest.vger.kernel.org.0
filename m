Return-Path: <linux-kselftest+bounces-8730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180218AF8B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6771C22ADE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DCE143868;
	Tue, 23 Apr 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgvAATui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942620B3E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906168; cv=none; b=nuWTsWyTq8bOIcIIZdSeDGZf7XLXTORvDodXYBmmsIvhW+0bFreSQsJZXQENHG3OoYdSsF4lktzN9Tob2zAdBDeViaUzJqddxVO+0m1QlD6kWf6kki4x0K1qoikJ6Ny+mksjjqvbkwX36IFQiznxTAFYquUEC6Rp7aQN/pKnAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906168; c=relaxed/simple;
	bh=42nvruzyY6ImBqfKJnawPKvzV07Fr0CgGhbxyeE6jgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvDRj725mgFVm4tXT9hiXpObTZy+5Hozs6Iu6h3shIEcQ2i1IPJtbGtunV+gczt28zkB5+NRPTURpBCGxYW10Xp5QYyOyi9tW88CnQymIWvx0/QyQlAtEZDScziOR/4K4mlUwRPH4KC/VZDJruPzUexZfV/pkLCNeobDi386asE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgvAATui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713906165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zxyy28Md6aPh5qs5ewJe58rAyJq1+GKjWz4Z6iDmhPc=;
	b=BgvAATuijUulfsdJCgMtUf8GO0VG+s0wXnVSGSGhTPB7+Fenq5QVi4SLZdKSbAYr/a+PB3
	B2MWs+Nly4T6mL6vPzOzJyxURnHTe3Rc2BCBMhrZtt0vmpI/NavDSGsPLrww1tLDpcBjbk
	B46l7slw3HDXorYLAf08idotjgXhg2E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-9NMmEJX4OviB2MFwrlc96A-1; Tue, 23 Apr 2024 17:02:43 -0400
X-MC-Unique: 9NMmEJX4OviB2MFwrlc96A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416e58bdc0eso25896035e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 14:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713906162; x=1714510962;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zxyy28Md6aPh5qs5ewJe58rAyJq1+GKjWz4Z6iDmhPc=;
        b=IvQtacIROSz2fyYCgO4MhBBviGId8NXpPJpHgw0bL+A9Pg6P8yZtQeweERI1wlOkIf
         L69MxbNtJxQdFN4YGjv6g5X+bt4usj6I3jw6R6fbBhyiOIgLNJWU44fmilwmVs4ZBnJv
         Dyzb2uyLgUfb1YK0ES1fKGr1hG1ii2DSkcxWq7PFgmBMP/PXu22GO6NJE1HeRxfA8cr+
         HvbKC9cfNTWi66s6M5zj1mnyPxkgmXmiiwkXaTdsEhF2cTKHUtRRC9J8xkYr+GynoYh5
         kp8k5nIZiCiwa97RpqwkD71vXqnlHlKP6zzroXTcZAGcdS7MgVn0L0P/j2pVWsV9caWQ
         e50A==
X-Forwarded-Encrypted: i=1; AJvYcCUK3ssqCscsc2Y97PydT1Ppyqm4NxfgLLFpj1L+4Y7Gw6sYhGUYkrpPzJU2WIXWbFfJFP18CKF8S0HqDX4S6+7y4uU1IzWeLiw5TuP1kg1s
X-Gm-Message-State: AOJu0Yx45Wzz4oojmd0wMtFgbFCbZdrjzyG5X296TIyiYDZINd2odyMh
	C8sU2/Uj75GnEnSJu5Jfteb5AT041ITolJ8crHyDA4FdsFzmHtoAF4fC5vcsUrct4YQWEgQd5/L
	qCMh1CM6dkCjJ8RK27SWna7DxAEH+LG794ENQJkLAJP/kqedZwqWRHnGD7HGDE0IntA==
X-Received: by 2002:a05:600c:154f:b0:418:e08c:817 with SMTP id f15-20020a05600c154f00b00418e08c0817mr261601wmg.32.1713906162426;
        Tue, 23 Apr 2024 14:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+UZR9KJP/97XDIfEkl4YcqwqEPrjxlxOqOm/ztwKYnaqQd4CrowBy7cR5Iuw7eetUht662w==
X-Received: by 2002:a05:600c:154f:b0:418:e08c:817 with SMTP id f15-20020a05600c154f00b00418e08c0817mr261583wmg.32.1713906161979;
        Tue, 23 Apr 2024 14:02:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b0041884b79b81sm21451088wmq.1.2024.04.23.14.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 14:02:41 -0700 (PDT)
Message-ID: <e001f009-0aeb-4a59-950e-3e5ed1c55751@redhat.com>
Date: Tue, 23 Apr 2024 23:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
To: Shivansh Vij <shivanshvij@outlook.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
 <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
 <ac4ffd88-2d13-4764-bb4e-18d0c4b9948d@redhat.com>
 <9e73ad2f-198c-4ab5-a462-2e238edd9b34@arm.com>
 <MW4PR12MB68755A569FE893DC72D86616B9112@MW4PR12MB6875.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <MW4PR12MB68755A569FE893DC72D86616B9112@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Shivansh, do you speak for CRIU? Are you able to comment on whether CRIU
>> supports checkpointing an app that uses uffd?
> 
> I do not speak for CRIU - I'm just a user (and hopefully a future contributor), but not a maintainer or owner. I can however comment on whether CRIU supports checkpointing an app that uses UFFD - it doesn't. Looking through both the implementation of CRIU (specifically how they restore memory [1]), and at recently filed Github issues [2], it's pretty clear that CRIU doesn't support processes using UFFD - that they do not currently have plans to [3].

Thanks for all these pointers!

> 
> [1] https://github.com/checkpoint-restore/criu/blob/criu-2.x-stable/criu/mem.c#L683
> [2] https://github.com/checkpoint-restore/criu/issues/2021
> [3] https://github.com/checkpoint-restore/criu/issues/2021#issuecomment-1346971967
> 
>>>
>>> Further ... isn't CRIU already using uffd in some cases? ...documentation
>>> mentions [1] that it is used for "lazy (or post-copy) restore in CRIU". At least
>>> if the documentation is correct and its actually implemented.
>>>
>>
>> Shivansh, same question - do you know the current CRIU status/plans for using
>> uffd-wp instead of soft-dirty? If CRIU doesn't currently implement it and has no
>> current plans to, how can we guage interest in making a plan?
>>
> 
> While I cannot gauge whether the maintainers or main contributors of CRIU plan on using uffd-wp instead of soft-dirty in the future, I can tell you that there is no currently open issue to track that work, and whenever anyone in the past has asked about ARM64 pre-dump support to CRIU (which is the feature that uses soft-dirty/would use uffd-wp), they've always just said it's not supported - but that they do want the feature [4].
> 
> So in summary, they want the feature, but no one is working on implementing it (either with soft-dirty or with uffd-wp).
> 
> I doubt that CRIU would have any issues with adding the feature via soft-dirty (since, as shown in [4] they're interested in it), but as for using uffd-wp they definitely haven't shown any interest thus far. Based on the fact that it would be a very significant amount of work and it would really only be for ARM64 support (which they're already fine without), I'd be very surprised if they were interested in pursuing it.
> 

Of course, nobody wants to do the work. But that doesn't mean that the 
kernel has to do the work :)

If there are some major challenges why it cannot possible be done with 
uffd-wp (unfixable), that's a different story.

> [4] https://github.com/checkpoint-restore/criu/issues/1859#issuecomment-1972674047
> 
>>>
>>>>
>>>>> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
>>>>> exist at the same time in the same process (or the VMA?). In theory, we
>>
>> My instinct is that MUXing a PTE bit like this will lead to some subtle problems
>> that won't appear on arches that support either one or both of the features
>> independently and unconditionally. Surely better to limit ourselves to either
>> "arm64 will only support uffd-wp" or "arm64 will support both uffd-wp and
>> soft-dirty". That way, we could move ahead with reviewing/merging the uffd-wp
>> support asynchronously to deciding whether we want to support soft-dirty.
>>
> 
> My personal preference is having both approaches supported - especially in the context of CRIU since I doubt they'll be willing to rewrite all of the dumping and restore logic just for ARM64 support.

Sure, nobody does any work unless they are forced to.

But this is something that arm64 maintainers will have to decide.

Let's start with uffd-wp that has other well-known users that could 
benefit (e.g., QEMU background snapshots).

-- 
Cheers,

David / dhildenb


