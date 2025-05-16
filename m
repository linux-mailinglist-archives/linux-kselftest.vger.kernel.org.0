Return-Path: <linux-kselftest+bounces-33193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B2AB9E51
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E551BA3ECF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2C13C914;
	Fri, 16 May 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkBLlJc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253DC3209
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404735; cv=none; b=QXx7eJytIEziz5s6z2r9PjcAGa1huEKmdfMnnsEtpYdFdmGzgxX+bxaVJ8XLIcMrC0ibNg0K23HqgauGAb5ONB8L8p3NsOkILXubaQr0koPX/8m5bdwOpb8pP9VlcQXxGfFkitW7hPNT6rDivTf7H67obDXgCQ3ztIp0aWL5830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404735; c=relaxed/simple;
	bh=7ER+KFJeSmj9f1hoOabGbraMMjS+y0YzY+3+9LbfKes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlvB7kWn4fmVDKjb+I4WM3FmSRkI/wbtB+vmA0TdpqbC/kUYSPfGGY7foGysZrY5N0tgctn5+Z+QDhH0EBmZaXtu5BM7uyRscHTt13fKKZWy87AqjcwmWVTLYwLT2BQ8A3mICDlnn0afQVPsvU10SYb1qNvWkWVHTIUIGtE65Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkBLlJc3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747404733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RV57MWQg7F6HC/SxgV/H9HoWeKSuZyndLSxdpcc4MpI=;
	b=CkBLlJc3BPgm1yGnPkH7ymOZIdgx0X8+x2Q3kDxeGARQYawkHTHtnzDVygZxgv02SM3MgB
	5oi5CYszIckNW+zqaEFgtNmwjlAu1sMGhrc8yDrNAdeWnrq1JoVthtStSq6mYCqP+msPRp
	7wFCXAadFof0kxLbBewfFgtQhv6v9SQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-mj_JRd7xPrGuh8wGpc7Jag-1; Fri, 16 May 2025 10:12:11 -0400
X-MC-Unique: mj_JRd7xPrGuh8wGpc7Jag-1
X-Mimecast-MFC-AGG-ID: mj_JRd7xPrGuh8wGpc7Jag_1747404730
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so11673195e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 07:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747404730; x=1748009530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RV57MWQg7F6HC/SxgV/H9HoWeKSuZyndLSxdpcc4MpI=;
        b=BHiqzQKELJRoz89X8n+OgtDFlC6ZC6Ubwuf3CeuQy+Bew+KZ2/4sUv+XbVmZnCiOhD
         RsNWThOtXfahLZMEHtkbuQ5zmJOUs+a4rOy+l3q8TMFOlI/4sdsI6Uuz0Wn9CLgQUpus
         PypCXzb+GSMT+oAwDntYVvTHP0T/UVKH+hBlxDVGxzN8Yu9GGlTr4F/f0aS7eqUv0NYy
         19AaLfEgjYCcwdxLFHjH6x0f3+sH5wb+3zCcnxqGIpOrfteNhmTKYI82z4Bgdky8I8OJ
         bF0CKlM9ytyfTlrxWccMzCnd3VFxz/TgxqyUuuL45uJyUFZS72UorYVl06sQio1MNGiY
         L4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHYopOshyD+UXRuLax2cuYRsRcfNH/3lqiXt4WCsMaRN7zwxPFMo8XyuzS/8wbUD50m76aULytBaO7YaP+1tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjsAA1f9Ng1OVXm8l7OfIVq4QUF99u2JZrpRauBfclAqZDN+N
	OZd+FDAd3HJfnU2v9fwYuAgY3OfwOwu8jsfV6qldEb9i2qcvjcsW6XzsZ5W1EZCAna0B9fzWCcy
	+o5BTsP0VdcqOtbBdaxFElmPMAMz3SL0IdzsWZSDHJ9jcjxGXDhFHMnTTkuQEy0fLU4btvA==
X-Gm-Gg: ASbGncspDntr6yUwlRmIrdAPAumNM+OWsWsvp9bOzkX6IMbNXPPSkhHn0XCHCHhFYC/
	YMJR3FXKlokXuOP5diJP9HLa2qh6fz2xStY/9yK/J74h+aGipj+gd2ujpl/RzaOsWvGlzydGF5A
	nu1Bcr+hCWFrWqug7h9N+MK/cthjT9amGuWlTiwvFczR+8oIm7Wfv8gjjM7bw34An9CndYjEZ8G
	Y8wKHROTk2GohJ0PjpHxbelfBNLrtqc5D9q3Ud0CUBYqZLgdQlst/XoVSq0k+Xs5MzCgPexofxQ
	YuIIGN2o8SU8GaYnM3qb7KRK5TWieuSuIRRnSbmoq/gK6KambklG7I94+hqhU+oKpMU0yo4hbgm
	TeDxcVGgzvm+c8ah7GC3f7aK/OiniQaIckkZri/g=
X-Received: by 2002:a05:600c:530c:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-442fd6272f8mr46451355e9.10.1747404730367;
        Fri, 16 May 2025 07:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0kAt7yQ6JyxgC1pqM/wcF1jrZj59oYvW9d5IdxwQrJv98krDj2LpvsFvNqHtE9mAvp6sR8w==
X-Received: by 2002:a05:600c:530c:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-442fd6272f8mr46450595e9.10.1747404729748;
        Fri, 16 May 2025 07:12:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8896dsm2962634f8f.73.2025.05.16.07.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:12:09 -0700 (PDT)
Message-ID: <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
Date: Fri, 16 May 2025 16:12:08 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 15:09, Mark Brown wrote:
> On Fri, May 16, 2025 at 02:55:24PM +0200, David Hildenbrand wrote:
>> On 16.05.25 14:29, Mark Brown wrote:
>>> On Fri, May 16, 2025 at 10:02:16AM +0200, David Hildenbrand wrote:
> 
>>>> reason), what exactly is the problem with that?
> 
>>>> We run tests. If all pass, we're happy, if one fails, we investigate.
> 
>>> None of the tooling is able to either distinguish between the multiple
>>> tests that are being run in gup_longterm, nor compare the results of
>>> multiple runs effectively.  If all the tests run they report themselves
> 
>> Okay, so this is purely to make tooling happy. Humans are smart enough to
>> figure it out.
> 
> Not just the tools, humans interact with the selftests and their results
> via tools (unless I'm actively working on something and running the
> specific test for that thing I'm unlikely to ever directly look at
> results...).

Yes, that makes sense.

> 
>> What mechanism do we have in place to reliably prevent that from happening?
>> And is this at least documented somewhere ("unique identifier for a test")>
> 
> It comes from TAP, I can't see a direct reference to anything in the
> kernel documentation.  The main thing enforcing this is people running
> tooling noticing bad output, unfortunately.

:(

> 
>> I guess when using kselftest_harness, we get a single identifier per tests
>> (and much less output) just automatically.
> 
> Nothing stops something using the harness from logging during the test,
> the harness tests actually tend to be a little chattier than a lot of
> the things written directly to kselftest.h as they log the start and end
> of tests as well as the actual TAP result line as standard.
> 
>>> If a selftest is reporting multiple tests it should report them with
>>> names that are stable and unique.
> 
>> I'm afraid we have other such tests that report duplicate conditions. cow.c
>> is likely another candidate (written by me ;) ).
> 
> That one's not come up for me (this was one of four different patches
> for mm selftests I sent the other day cleaning up duplicate test names).

$ sudo ./cow
TAP version 13
# [INFO] detected PMD size: 2048 KiB
# [INFO] detected THP size: 16 KiB
# [INFO] detected THP size: 32 KiB
# [INFO] detected THP size: 64 KiB
# [INFO] detected THP size: 128 KiB
# [INFO] detected THP size: 256 KiB
# [INFO] detected THP size: 512 KiB
# [INFO] detected THP size: 1024 KiB
# [INFO] detected THP size: 2048 KiB
# [INFO] detected hugetlb page size: 2048 KiB
# [INFO] detected hugetlb page size: 1048576 KiB
# [INFO] huge zeropage is enabled
1..778
# [INFO] Anonymous memory tests in private mappings
# [RUN] Basic COW after fork() ... with base page
ok 1 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped out base page
ok 2 No leak from parent into child
# [RUN] Basic COW after fork() ... with PTE-mapped THP (16 kB)
ok 3 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (16 kB)
ok 4 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of THP (16 kB)
ok 5 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of swapped-out THP (16 kB)
ok 6 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially mremap()'ed THP (16 kB)
ok 7 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially shared THP (16 kB)
ok 8 No leak from parent into child
# [RUN] Basic COW after fork() ... with PTE-mapped THP (32 kB)
ok 9 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (32 kB)
ok 10 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of THP (32 kB)
ok 11 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of swapped-out THP (32 kB)
ok 12 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially mremap()'ed THP (32 kB)
ok 13 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially shared THP (32 kB)
ok 14 No leak from parent into child
# [RUN] Basic COW after fork() ... with PTE-mapped THP (64 kB)
ok 15 No leak from parent into child
# [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (64 kB)
ok 16 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of THP (64 kB)
ok 17 No leak from parent into child
# [RUN] Basic COW after fork() ... with single PTE of swapped-out THP (64 kB)
ok 18 No leak from parent into child
# [RUN] Basic COW after fork() ... with partially mremap()'ed THP (64 kB)
ok 19 No leak from parent into child
...


Aren't the duplicate "No leak from parent into child" the problematic bits?
But maybe I am getting it wrong, what needs to be "unique" :)


> 
>> Probably, the affected tests should be converted to use kselftest_harness,
>> where we just report the result for a single tests, and not the individual
>> assertions.
> 
>> That would reduce the output of these tests drastically as well.
> 
>> So that is likely the way to clean this up properly and make tooling happy?
> 
> That'd certainly work, though doing that is more surgery on the test
> than I personally have the time/enthusiasm for right now.

Same over here.

But probably if we touch it, we should just clean it up right away. Well,
if we decide that that is the right cleanup. (you mention something like that
in your patch description :) )

-- 
Cheers,

David / dhildenb


