Return-Path: <linux-kselftest+bounces-26951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D990A3B8C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6117DCB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45B1E008B;
	Wed, 19 Feb 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI3a4SJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B41C1AD4
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956556; cv=none; b=EPacVWRog7aeXGNmZAMWnJLZSKVVFgK9C1i9Eo+ZHPUiON7V1dTAC9fakaSgzmviP28EyEiXTai5es01GzX8Z3LKRmXYsNtJcXhLWY9QkE4XQI13GqDXbQNOiX+vjvdaasFDIsRz8bGlyGI8IOp0EkeH/7iB9aM015hdNBA3V9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956556; c=relaxed/simple;
	bh=eRVv+MgePqfkaSxqiRaZ4GVLYh03FpfCVHcUgIbgF1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLuZtdVPLzj9XpVPUK/S66yeoVdKsVJTigeBIUBv3to5CnpidhKInyhAaZ+ZkWto2t3nzV/PZqwBWxRaIXD8FBsf3PfLIToG4wW9+2+matbOMo1yx488NjBZPM8u184uNuc+xCJbK2S2RB8B3AF9gW9oThNZ+a/LVXCrBsDIFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AI3a4SJn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739956553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RxCmmDXQ3YUW8NPe8t8CwOpgi3kQxg5DuIm3PdVw+PY=;
	b=AI3a4SJnDDMapkWWEamZbMJOdJlKf6ZrI6cKCqvqiuqRd6LntnS+bsHLm+ud4z8x8czFSF
	qXy/ptcxrptgodaTjVD1x34bdXrbay18KyGE7HaJfax3QcId3Riu6eGP+7SLbGDoO2uxqQ
	qeYZJwo4Ua+N8sBrPeeNcrLyBIkINEs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-xJCiFnmcMUu8tWqoNLSIRg-1; Wed, 19 Feb 2025 04:15:52 -0500
X-MC-Unique: xJCiFnmcMUu8tWqoNLSIRg-1
X-Mimecast-MFC-AGG-ID: xJCiFnmcMUu8tWqoNLSIRg_1739956551
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1159978f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 01:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956551; x=1740561351;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RxCmmDXQ3YUW8NPe8t8CwOpgi3kQxg5DuIm3PdVw+PY=;
        b=vXVoGfAAmhkW2C/0EspD6568pBgkbNKAAD9s9eNivuD0UYBYdtG9R2WOMvfNJbQ3PR
         VGK9oh+nV72abU2yM/OiQvUpAdyTel5PKDv6IT6pcg9OsaYL/1+ebe0+wuokcu+2OjOS
         PXqKmFApUkL+g1mV/7PFDlcR9t7izVClnE6iO+aRWJbrIZkjMM/7ucwhVN34NhXBvVQj
         izSzpgHgB6k7w1ObtwrBadwla9fv+LDYYwIyRUTTHvwjQyS8XpypslgUssAFHXU+a/lI
         1RQfq5Eq1VGyY1lxeKivpdS4ZNVwN31WjqIh5hVtDiQ7rp7DTuQssVUZDc2jFSRBGeOg
         pPjA==
X-Forwarded-Encrypted: i=1; AJvYcCXUfPy+2i49BNDfskjwGHxdnb30Hi+Zxcn/2W+N4cfyHbreqo+w/g6yGg/qqekExDu2eFbFEeXVGHl0+Ln+yc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RrdzIpfHFX/626PKrIFGIGdnBYVQiDXiprv5mJE8GolU2+Xo
	x2Q5oSXEizQOBDa8TjISy3FAo9qET1LC2y6/iRwbqE0LjmGmNbgRzm28DVyA73UEFZJTfDc1kYd
	ZaCjn1pHpexXxVj2IUBPlWa0YBar3+k5HZkchmWbuB58yoAlTMlqRekTUA+0KEGoylA==
X-Gm-Gg: ASbGncuvAmLt6xVtToIk+atIjWwkzYAFFI4zy72YXs+Ln8DQJnOko+Rte1KdNLDMmvn
	hIPMwhgkf5sM8z9oKd5hI7cQQxRTRoVXW2ysnFWLWk+n9yl2L8GRXIrTdpEINIW4IAFCQAgLeXl
	0PnLZleFzBE3PxLm6Rh1p1p6a115HzvrtaH1DV28vdbgv2dGhLIxrF/ajTLh7FOhjdN9hKyAaI1
	vD+NjWZXCzlYZRYDqTbx5W35RErD7LnTgYsA/qyeL6D9I9yVzBEiV/TQBORDZdZk7LUxvdYg9nT
	w5YRE50rjdDCqY/PPnKRyKosHdKizgTr9VJCXrvCVIce4lJGpxCA3TmxvdFG4/LB3Bw/tJeTdcN
	Dwa+9g8wxRdEBEmKd/ljPEhoiBC0gBVp0
X-Received: by 2002:a5d:5885:0:b0:38d:d99d:d221 with SMTP id ffacd0b85a97d-38f33f3750fmr14909281f8f.1.1739956550555;
        Wed, 19 Feb 2025 01:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHryNc8iIWt9nuv/n6tOim6c5co/9kFT5YuLXq76klWhWMEihOqwUx9HIU09wJt9akrZV+hJw==
X-Received: by 2002:a5d:5885:0:b0:38d:d99d:d221 with SMTP id ffacd0b85a97d-38f33f3750fmr14909235f8f.1.1739956550059;
        Wed, 19 Feb 2025 01:15:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:8400:50d0:d1c1:90d6:e2e0? (p200300cbc712840050d0d1c190d6e2e0.dip0.t-ipconnect.de. [2003:cb:c712:8400:50d0:d1c1:90d6:e2e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8730sm17691713f8f.93.2025.02.19.01.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:15:49 -0800 (PST)
Message-ID: <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
Date: Wed, 19 Feb 2025 10:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.02.25 10:03, Lorenzo Stoakes wrote:
> On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
>> On Thu, Feb 13, 2025 at 10:18 AM Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com> wrote:
>>>
>>> The guard regions feature was initially implemented to support anonymous
>>> mappings only, excluding shmem.
>>>
>>> This was done such as to introduce the feature carefully and incrementally
>>> and to be conservative when considering the various caveats and corner
>>> cases that are applicable to file-backed mappings but not to anonymous
>>> ones.
>>>
>>> Now this feature has landed in 6.13, it is time to revisit this and to
>>> extend this functionality to file-backed and shmem mappings.
>>>
>>> In order to make this maximally useful, and since one may map file-backed
>>> mappings read-only (for instance ELF images), we also remove the
>>> restriction on read-only mappings and permit the establishment of guard
>>> regions in any non-hugetlb, non-mlock()'d mapping.
>>
>> Hi Lorenzo,
>>
>> Thank you for your work on this.
> 
> You're welcome.
> 
>>
>> Have we thought about how guard regions are represented in /proc/*/[s]maps?
> 
> This is off-topic here but... Yes, extensively. No they do not appear
> there.
> 
> I thought you had attended LPC and my talk where I mentioned this
> purposefully as a drawback?
> 
> I went out of my way to advertise this limitation at the LPC talk, in the
> original series, etc. so it's a little disappointing that this is being
> brought up so late, but nobody else has raised objections to this issue so
> I think in general it's not a limitation that matters in practice.
> 
>>
>> In the field, I've found that many applications read the ranges from
>> /proc/self/[s]maps to determine what they can access (usually related
>> to obfuscation techniques). If they don't know of the guard regions it
>> would cause them to crash; I think that we'll need similar entries to
>> PROT_NONE (---p) for these, and generally to maintain consistency
>> between the behavior and what is being said from /proc/*/[s]maps.
> 
> No, we cannot have these, sorry.
> 
> Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of this
> feature is to avoid having to accumulate VMAs for regions which are not
> intended to be accessible.
> 
> Secondly, there is no practical means for this to be accomplished in
> /proc/$pid/maps in _any_ way - as no metadata relating to a VMA indicates
> they have guard regions.
> 
> This is intentional, because setting such metadata is simply not practical
> - why? Because when you try to split the VMA, how do you know which bit
> gets the metadata and which doesn't? You can't without _reading page
> tables_.
> 
> /proc/$pid/smaps _does_ read page tables, but we can't start pretending
> VMAs exist when they don't, this would be completely inaccurate, would
> break assumptions for things like mremap (which require a single VMA) and
> would be unworkable.
> 
> The best that _could_ be achieved is to have a marker in /proc/$pid/smaps
> saying 'hey this region has guard regions somewhere'.

And then simply expose it in /proc/$pid/pagemap, which is a better 
interface for this pte-level information inside of VMAs. We should still 
have a spare bit for that purpose in the pagemap entries.

-- 
Cheers,

David / dhildenb


