Return-Path: <linux-kselftest+bounces-12407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE3911E18
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9851C21163
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63C171E6A;
	Fri, 21 Jun 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6k7nssS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE517164E
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956937; cv=none; b=NmH1umkQF117exG/V/9x0+xtxBoH1oru7uk+i+YXDd6Q2ctdMab+Ckxkc2gSfkI7nVMP9RFittoDpiWZjl/RbT0jJTpP2tgGvah8amPpwIW4mddQIdKFAEn0JZadqvg4Z+DULiwbGvpGGVvRb5KXdof2OBSulvv2q85V9U/mC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956937; c=relaxed/simple;
	bh=0Th6Xok/0gWyXNtdGG59lNrK/zpanX2lkhvgzUGtnhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV/e6U8KXaGlUcNdKOZIMTJkCHLIHQWiDsrmT1ABVdgRB0SQdl8Xf4WBp5J7f9F8Fdhpr1HUyDGkV7Mh6zWtw+mSnz6xnETgakPtjab1uoD3kOCfcW3ZqB1uyvHbEQAS8k48mohijQBUQFfag96hTnTQbC6DWmW9NjxYoC5i0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6k7nssS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718956933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xkmx4VxgKTDJ6kTchpyZaVShYEbHtP+HAhQKYy4kBtU=;
	b=U6k7nssStMfJ3qsQavBeAas82mZB3LUKb8K/25McebsFzfWNBn6+pCk0eAmu0aEWloPKKY
	PnQHuVr8WM+jBxHGNVn+Ym/AyWxDhor/oVMkD+bCaHx/hthG5R+LRqtOypiGMtsAoqrZc6
	c/ZFE4WOQeAkbEgsizIoMBOqkcQyqGQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-1cFVfupOOHK58-RYhI0v9Q-1; Fri, 21 Jun 2024 04:02:11 -0400
X-MC-Unique: 1cFVfupOOHK58-RYhI0v9Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36536118656so739987f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 01:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718956930; x=1719561730;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xkmx4VxgKTDJ6kTchpyZaVShYEbHtP+HAhQKYy4kBtU=;
        b=gcoVF39672rEeCsrjQ6GMP6tE0MnphAzJVMUPDniysx1Gzc+PY456mgrMVJGIEF7ZR
         5H0JW68h5+gXHQoESXEFHPqxgFNuLeZ/UjjX1tlpHcKxRTNBjzGD0cPQAes4GPEn28R+
         ukg53Rfmq/ZoDvxZGxXA3JQRf/2gIZwLlUU1oPoCL20nJ7rlRhu2z9iv++GgJBPIRD6U
         IZf/szEtWCEm4TtWmJlkoKePVW9wi627NbkT4m7/37Qao/KiSfyaG1UjB1DJHZX8l5no
         HvkODkSELiZ2YWgA18ssFZzAMYkU8l6NhCCuSUfipQR6Lc/H0SszetJAjvt8HOmyMPW3
         nw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUODn8Urvls5ZkxySZu8VenyHLRH9ZM+x+5tJrTGS3/+xZ6P5TzBaj/nWSdYn2ZoeHZXVkiqsmoGT+USU/tBZjEIj/cebl2/LECOT4qCuo2
X-Gm-Message-State: AOJu0Yw54IosJcXH3h8iI3mIcSnjTVbSY6VgKQCMnFHh/oY+6sYKU/Kk
	YLQMQfWs1Kcr5U7gIk7qqoEYbItoNLWBndLEStymU0o42gN6j2Z/f8WCOGA9SuoPpgIs6/mPe6a
	J0snAVz1JU9rIlhMZVu2xM1LY06DgYl06YAj/nNoEIN3Vc3LE2kekiTFtnffx/5HJ/Q==
X-Received: by 2002:adf:cd0b:0:b0:360:8769:2bcd with SMTP id ffacd0b85a97d-363ec4f3a35mr4232186f8f.22.1718956930353;
        Fri, 21 Jun 2024 01:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSQMV3nkBUbWMbVYELKjHtfrKlZ7Qwe5QzWr06EgevF7vNjrJxpQ7CrJ3ZgBR3qkCYw9QWfw==
X-Received: by 2002:adf:cd0b:0:b0:360:8769:2bcd with SMTP id ffacd0b85a97d-363ec4f3a35mr4232160f8f.22.1718956929840;
        Fri, 21 Jun 2024 01:02:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c16esm965765f8f.57.2024.06.21.01.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 01:02:09 -0700 (PDT)
Message-ID: <c05f2a97-5863-4da7-bfae-2d6873a62ebe@redhat.com>
Date: Fri, 21 Jun 2024 10:02:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Quentin Perret <qperret@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Fuad Tabba <tabba@google.com>,
 Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com
References: <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620231814.GO2494510@nvidia.com> <ZnUsmFFslBWZxGIq@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZnUsmFFslBWZxGIq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 09:32, Quentin Perret wrote:
> On Thursday 20 Jun 2024 at 20:18:14 (-0300), Jason Gunthorpe wrote:
>> On Thu, Jun 20, 2024 at 03:47:23PM -0700, Elliot Berman wrote:
>>> On Thu, Jun 20, 2024 at 11:29:56AM -0300, Jason Gunthorpe wrote:
>>>> On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
>>>>> Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
>>>>> now the VM requests to make one subpage private.
>>>>
>>>> I think the general CC model has the shared/private setup earlier on
>>>> the VM lifecycle with large runs of contiguous pages. It would only
>>>> become a problem if you intend to to high rate fine granual
>>>> shared/private switching. Which is why I am asking what the actual
>>>> "why" is here.
>>>>
>>>
>>> I'd let Fuad comment if he's aware of any specific/concrete Anrdoid
>>> usecases about converting between shared and private. One usecase I can
>>> think about is host providing large multimedia blobs (e.g. video) to the
>>> guest. Rather than using swiotlb, the CC guest can share pages back with
>>> the host so host can copy the blob in, possibly using H/W accel. I
>>> mention this example because we may not need to support shared/private
>>> conversions at granularity finer than huge pages.
>>
>> I suspect the more useful thing would be to be able to allocate actual
>> shared memory and use that to shuffle data without a copy, setup much
>> less frequently. Ie you could allocate a large shared buffer for video
>> sharing and stream the video frames through that memory without copy.
>>
>> This is slightly different from converting arbitary memory in-place
>> into shared memory. The VM may be able to do a better job at
>> clustering the shared memory allocation requests, ie locate them all
>> within a 1GB region to further optimize the host side.
>>
>>> Jason, do you have scenario in mind? I couldn't tell if we now had a
>>> usecase or are brainstorming a solution to have a solution.
>>
>> No, I'm interested in what pKVM is doing that needs this to be so much
>> different than the CC case..
> 
> The underlying technology for implementing CC is obviously very
> different (MMU-based for pKVM, encryption-based for the others + some
> extra bits but let's keep it simple). In-place conversion is inherently
> painful with encryption-based schemes, so it's not a surprise the
> approach taken in these cases is built around destructive conversions as
> a core construct. But as Elliot highlighted, the MMU-based approach
> allows for pretty flexible and efficient zero-copy, which we're not
> ready to sacrifice purely to shoehorn pKVM into a model that was
> designed for a technology that has very different set of constraints.
> A private->shared conversion in the pKVM case is nothing more than
> setting a PTE in the recipient's stage-2 page-table.
> 
> I'm not at all against starting with something simple and bouncing via
> swiotlb, that is totally fine. What is _not_ fine however would be to
> bake into the userspace API that conversions are not in-place and
> destructive (which in my mind equates to 'you can't mmap guest_memfd
> pages'). But I think that isn't really a point of disagreement these
> days, so hopefully we're aligned.
> 
> And to clarify some things I've also read in the thread, pKVM can
> handle the vast majority of faults caused by accesses to protected
> memory just fine. Userspace accesses protected guest memory? Fine,
> we'll SEGV the userspace process. The kernel accesses via uaccess
> macros? Also fine, we'll fail the syscall (or whatever it is we're
> doing) cleanly -- the whole extable machinery works OK, which also
> means that things like load_unaligned_zeropad() keep working as-is.
> The only thing pKVM does is re-inject the fault back into the kernel
> with some extra syndrome information it can figure out what to do by
> itself.
> 
> It's really only accesses via e.g. the linear map that are problematic,
> hence the exclusive GUP approach proposed in the series that tries to
> avoid that by construction. That has the benefit of leaving
> guest_memfd to other CC solutions that have more things in common. I
> think it's good for that discussion to happen, no matter what we end up
> doing in the end.

Thanks for the information. IMHO we really should try to find a common 
ground here, and FOLL_EXCLUSIVE is likely not it :)

Thanks for reviving this discussion with your patch set!

pKVM is interested in in-place conversion, I believe there are valid use 
cases for in-place conversion for TDX and friends as well (as discussed, 
I think that might be a clean way to get huge/gigantic page support in).

This implies the option to:

1) Have shared+private memory in guest_memfd
2) Be able to mmap shared parts
3) Be able to convert shared<->private in place

and later in my interest

4) Have huge/gigantic page support in guest_memfd with the option of
    converting individual subpages

We might not want to make use of that model for all of CC -- as you 
state, sometimes the destructive approach might be better performance 
wise -- but having that option doesn't sound crazy to me (and maybe 
would solve real issues as well).

After all, the common requirement here is that "private" pages are not 
mapped/pinned/accessible.

Sure, there might be cases like "pKVM can handle access to private pages 
in user page mappings", "AMD-SNP will not crash the host if writing to 
private pages" but there are not factors that really make a difference 
for a common solution.

private memory: not mapped, not pinned
shared memory: maybe mapped, maybe pinned
granularity of conversion: single pages

Anything I am missing?

-- 
Cheers,

David / dhildenb


