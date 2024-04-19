Return-Path: <linux-kselftest+bounces-8414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E108AABB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B631C20A41
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DD7BAF3;
	Fri, 19 Apr 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPN0L4D0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C17B3FE
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519922; cv=none; b=l7ZuxCygZNjWFOrmg6qOd2PVsAiLf91we0k0p60zV2sbc9VZf9aKnIMKvanI95clGeGhm/ImLC11y4Vc5V3cd+vYDbvZpX/HPyCo4nB0Tj+H13Va5yx6EEMo5rS/pGJAyhufJ5vd7s4nGV0X3Hevx3W+XSv9YtwBkSRwnlO9rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519922; c=relaxed/simple;
	bh=HMHZQ81dP0SN0T90W2TrPTOiS2bN4YfJlg8/lAMBsaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpJ3r5KeWL5OqWzpJpYAeS/rpJ5G7OrYGh0ftyvpZS3j0WuIpQUvT+bOk+HcnwN3lo3YzOPATBvssB/bwmSfdnUbxGR93j6q5lCUKE2SjZhAQlCXpfA6z+1GTDx22vRKDg8ntCPaK3yRsURAQf9u1vcp0ePaOEjLCH0iMPwvgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPN0L4D0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713519919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCoyntaCRZuUkWRpN1//7gRrd2DlONoI5NwEvNCqyxk=;
	b=JPN0L4D06QbjOY45vwyDtRzJhEwWD8nE+qAV4pYr5fo989HARQXCbIh/4Dkht6gOCB7gBH
	Bltx/rEqOQD3FJSLyieJZ/3iwiq6HnERC5yNNwstFP4qXFmcHRdDqXMRj4IY05SvG4iJp8
	n72qFijZwFJXrREMUG9kPxy3RqeJ6ug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-a3rPit-fOlaZvG03CVdnKQ-1; Fri, 19 Apr 2024 05:45:17 -0400
X-MC-Unique: a3rPit-fOlaZvG03CVdnKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4183909fec8so15343285e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713519916; x=1714124716;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MCoyntaCRZuUkWRpN1//7gRrd2DlONoI5NwEvNCqyxk=;
        b=Nz/xYE2EL6/0GGXVLXzVVZDlu6IKZefGMZse9hidj/ejIvp69p+jYduo+SCMj0jzu7
         zGnpYzzez8dhMxiCz7USTLTjLF/pi7AHfU85Fkqft1/+ijkb8ejcoYZz5nKer0S9kVCy
         FrBydvSCYuNWt8TCCZVZxfwiSkn7XlYGXwz88SvDioOjfHjWyrLbmRAXwSYH0KAbIqEb
         QoKYSv+bYTrbjgGZVaV4eFmFooK+oCJ0Nle9gZQ5Uo9YgmpYivXYujnu9FP5jG92N4JD
         QOqPIg4p04Gr1iJm9Co5x6/34IwJ+R65/FfjIABOa5OAdMgTm7zUZyWWJIdDVAIYvFXk
         upzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNAk4TJxoprATo3UgQBfhDrwS9wBYnrB4PEKzB8M/ac41AIz3tfjGOwD7O1xCWoSq8M+M1+bGN/0Yt1Ckd8xampa1n+N/bX6WsbPpA72vm
X-Gm-Message-State: AOJu0YyYKLUOEgvqAM/kPKIcyaNLqTuJGwvJug44OTDAFoyPgLS5XqSF
	BnlX/10ePWRWceCUdLSkoXl08cPXpaTpa8PiPZDh0cwnwGnyJw0bPjDsUAEQ8pjJSgDon+bwgLZ
	wN9+KPULkJ8tW5BJ6KfHNff8TH2NPUc/ZmXuY2Ei2W6W9yBwYahgeaSF67QuHtSVwSg==
X-Received: by 2002:a05:600c:1c9b:b0:416:4641:5947 with SMTP id k27-20020a05600c1c9b00b0041646415947mr1253925wms.34.1713519916648;
        Fri, 19 Apr 2024 02:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+/K45FeDxn6FkpbTtTiQddRh21Cb9uK8JSBlB/0djaFPbu8uI1joLih9P8K/TBbgBp5xLDw==
X-Received: by 2002:a05:600c:1c9b:b0:416:4641:5947 with SMTP id k27-20020a05600c1c9b00b0041646415947mr1253904wms.34.1713519916154;
        Fri, 19 Apr 2024 02:45:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:f300:c9f0:f643:6aa2:16? (p200300cbc716f300c9f0f6436aa20016.dip0.t-ipconnect.de. [2003:cb:c716:f300:c9f0:f643:6aa2:16])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b00418ef96472asm4485815wmq.0.2024.04.19.02.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:45:15 -0700 (PDT)
Message-ID: <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
Date: Fri, 19 Apr 2024 11:45:14 +0200
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
 Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mike Rapoport <rppt@linux.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 10:33, Shivansh Vij wrote:
> (Sorry about the previous HTML email, accidentally used the wrong email client)
> 
> Hey All,
> 
>> On 19/04/2024 08:43, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> This series adds uffd write-protect and soft-dirty tracking support for arm64. I
>>> consider the soft-dirty support (patches 3 and 4) as RFC - see rationale below.
>>>
>>> Previous attempts to add these features have failed because of a perceived lack
>>> of available PTE SW bits. However it actually turns out that there are 2
>>> available but they are hidden. PTE_PROT_NONE was previously occupying a SW bit,
>>> but it only applies when PTE_VALID is clear, so this is moved to overlay PTE_UXN
>>> in patch 1, freeing up the SW bit. Bit 63 is marked as "IGNORED" in the Arm ARM,
>>> but it does not currently indicate "reserved for SW use" like it does for the
>>> other SW bits. I've confirmed with the spec owner that this is an oversight; the
>>> bit is intended to be reserved for SW use and the spec will clarify this in a
>>> future update.
>>>
>>> So we have our two bits; patch 2 enables uffd-wp, patch 3 enables soft-dirty and
>>> patches 4 and 5 sort out the selftests so that the soft-dirty tests are compiled
>>> for, and run on arm64.
>>>
>>> That said, these are the last 2 SW bits and we may want to keep 1 bit in reserve
>>> for future use. soft-dirty is only used for CRIU to my knowledge, and it is
>>> thought that their use case could be solved with the more generic uffd-wp. So
>>> unless somebody makes a clear case for the inclusion of soft-dirty support, we
>>> are probably better off dropping patches 3 and 4 and keeping bit 63 for future
>>> use. Although note that the most recent attempt to add soft-dirty for arm64 was
>>> last month [1] so I'd like to give Shivansh Vij the opportunity to make the
>>> case.
>>
>> Ugh, forgot to mention that this applies on top of v6.9-rc3, and all the uffd-wp
>> and soft-dirty tests in the mm selftests suite run and pass. And no regressions
>> are observed in any of the other selftests.
> 
> Appreciate the opportunity to provide input here.
> 
> I personally don't know of any applications other than CRIU that make heavy use of soft-dirty, and my use case is specifically focused on adding live-migration support to CRIU on ARM.
> 
> Cloud providers like AWS have pretty massive discounts for ARM-based spot instances (90% last time I checked), and having live-migration in CRIU would allow more applications to take advantage of that.
> 
> As Ryan mentioned, there are two ways to achieve this - add dirty tracking to ARM (Patch 3/4), or tear out the existing dirty tracking code in CRIU and replace it with uffd-wp.
> 
> I picked option one (dirty tracking in arm) because it seems to be the simplest way to move forward, whereas it would be a relatively heavy effort to add uffd-wp support to CRIU.
> 
>  From a performance perspective I am also a little worried that uffd will be slower than just tracking the dirty bits asynchronously with sw dirty, but maybe that's not as much of a concern with the addition of uffd-wp async.
> 
> With all this being said, I'll defer to the wisdom of the crowd about which approach makes more sense - after all, with this patch we should get uffd-wp support on arm so at least there will be _a_ way forward for CRIU (albeit one requiring slightly more work).

Ccing Mike and Peter. In 2017, Mike gave a presentation "Memory tracking 
for iterative container migration"[1] at LPC

Some key points are still true I think:
(1) More flexible and robust than soft-dirty
(2) May obsolete soft-dirty

We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part of 
[2], because getting soft-dirty return reliable results in some cases 
turned out rather hard to fix.

We might still have to optimize that approach for some very sparse large 
VMAs, but that should be solvable.

  "The major defect of this approach of dirty tracking is we need to
  populate the pgtables when tracking starts. Soft-dirty doesn't do it
  like that. It's unwanted in the case where the range of memory to track
  is huge and unpopulated (e.g., tracking updates on a 10G file with
  mmap() on top, without having any page cache installed yet). One way to
  improve this is to allow pte markers exist for larger than PTE level
  for PMD+. That will not change the interface if to implemented, so we
  can leave that for later.")[3]


If we can avoid adding soft-dirty on arm64 that would be great. This 
will require work on the CRIU side. One downside of uffd-wp is that it 
is currently not as avilable on architectures as soft-dirty.

But I'll throw in another idea: do we really need soft-dirty and uffd-wp 
to exist at the same time in the same process (or the VMA?). In theory, 
we could have a VMA flag that defines the semantics of the bit and 
simply have arch code use a single, abstracted PTE bit. Requires a bit 
more work, though, but the benfit would be that architecturs that do 
support soft-dirty could support uffd-wp.


[1] 
https://blog.linuxplumbersconf.org/2017/ocw//system/presentations/4724/original/Memory%20tracking%20for%20iterative%20container%20migration.pdf
[2] 
https://lore.kernel.org/all/20230821141518.870589-1-usama.anjum@collabora.com/
[3] 
https://lore.kernel.org/all/20230821141518.870589-2-usama.anjum@collabora.com/

-- 
Cheers,

David / dhildenb


