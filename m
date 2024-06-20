Return-Path: <linux-kselftest+bounces-12357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B2911177
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCC1C2178F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0159D1B373A;
	Thu, 20 Jun 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUkB6Xbe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F901AD3E8
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909594; cv=none; b=Qcsae8tsLcWHM9hijUMA8zGKd3cPbH36kHZmQhXOgOLtq9Wl92jzy9jk3iNPRasGDHY01gjoEGESuv1kPM8GthtRNLxdOteM2XLjD7PPlU5MvUgv0vRfvRkzZFU0bWx/B8PSrThP5iF58Pd+NZLRG8Y2avhymQ5tShSPLXALgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909594; c=relaxed/simple;
	bh=UHsauWZAVsnR/2X1IKfQMEacjE0bgcBA+va4oRMDsUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3ecNY6rD+YC8rMw5m/ztdFUdVvIMZ/rnlmQbQHZYVYFgr6Pfei5pm/MoY3ITr5l4/6J/q+UHOK/1qLSwWXFSQvnlMUf1i/KF79ODb3G9a33RBbeeuvtm3XCGpR4y9vTFKyh+vXRt63HzZVjcKYt5KDiHtyL64cYyF/SIdnZO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUkB6Xbe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718909592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nWMfq1+cMQVMteS3E1XpToh4XwOaxAJx3UrsgdMNLOA=;
	b=FUkB6XbecSgSRqcjrLsFwzTnVEmeZNsCEYHsye3dVhSA52XTkM87siYbwktdi1/axK1Agt
	HXHrXJYdZpnv2P6wx3TLGn1HvKosCDna3+s8yUj8em//ogWXiuJox90oOZUkAt6Rq8Bi7Y
	j2mOiej4QsJC7N4hng+KnbBK0z4ioVQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-DxGmC7idMbGVZPd1IA-leQ-1; Thu, 20 Jun 2024 14:53:11 -0400
X-MC-Unique: DxGmC7idMbGVZPd1IA-leQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4247d49a373so7939885e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 11:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909590; x=1719514390;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWMfq1+cMQVMteS3E1XpToh4XwOaxAJx3UrsgdMNLOA=;
        b=GQ9pHfzhu/ifnfHRgqfW0MuhqVmfkOsXueO6wCnMArRdWmIWmDs3JUszUic/GSqk73
         iyhx86MHUoCxN35pPuhUVbuB7xnvvfQYHgQwTIaEUaIWYUjFZf0lQsxpPH9XDyL+42xV
         qaetbtigqVceNWxM1GLdqYBeS826r3hzE2eRzLWDdltWbOEWgXsaCDQGuH5Jx6BURFNu
         qcez4Rthstof6D8BWnneC+iuSLmYB3NbrT6Nmi3GYKMKGugtIkMSnhnFICfplLO2E6v4
         73xcNTW3cY8/8/SFCVN0p3TZtnVj2nCV0yTjgn9I6n/c9MuQD9FnEBIM3Zyw/nkkfw2q
         gNrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+DJ4Emv+WYzygb2myA6aYJkEAEjK6ZrjResJGFGwRGnNHe4qkoZR5QcJVTy3/JWBGbWv4u0TfdwJxWbFiCv24ILeoIOGtx3x8WGCeNDkW
X-Gm-Message-State: AOJu0Yyl4cogTPLfnBPYArTirh1JQHfPsP2W3pherAuX6t0HOzkqZLpp
	EYmbpeF7oFv1GXswuzJ2z6002nuQCc3rQ3ANQRRhezDeh3J+E4ElxlPgbvW5nEmD9HqA2sp+8QB
	acuspOIbsPVM7gZiYFOSFsckYIJ3KIlpacB6u2IKNISBviiDjdn5eAfD9JoVmorjJHA==
X-Received: by 2002:adf:fe90:0:b0:356:48f5:4383 with SMTP id ffacd0b85a97d-36319a855a0mr4946431f8f.61.1718909589736;
        Thu, 20 Jun 2024 11:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfjXRdRXq39Gj/6Bp/g3arNHu5ZTNiLnZmmKAj1QUaaUhfikLvxFl9GJgycsizhlMOf3pULw==
X-Received: by 2002:adf:fe90:0:b0:356:48f5:4383 with SMTP id ffacd0b85a97d-36319a855a0mr4946418f8f.61.1718909589296;
        Thu, 20 Jun 2024 11:53:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362d76f10e8sm6459937f8f.15.2024.06.20.11.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:53:08 -0700 (PDT)
Message-ID: <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
Date: Thu, 20 Jun 2024 20:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Elliot Berman
 <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com
References: <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240620163626.GK2494510@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 18:36, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:
> 
>> If we could disallow pinning any shared pages, that would make life a lot
>> easier, but I think there were reasons for why we might require it. To
>> convert shared->private, simply unmap that folio (only the shared parts
>> could possibly be mapped) from all user page tables.
> 
> IMHO it should be reasonable to make it work like ZONE_MOVABLE and
> FOLL_LONGTERM. Making a shared page private is really no different
> from moving it.
> 
> And if you have built a VMM that uses VMA mapped shared pages and
> short-term pinning then you should really also ensure that the VM is
> aware when the pins go away. For instance if you are doing some virtio
> thing with O_DIRECT pinning then the guest will know the pins are gone
> when it observes virtio completions.
> 
> In this way making private is just like moving, we unmap the page and
> then drive the refcount to zero, then move it.
Yes, but here is the catch: what if a single shared subpage of a large 
folio is (validly) longterm pinned and you want to convert another 
shared subpage to private?

Sure, we can unmap the whole large folio (including all shared parts) 
before the conversion, just like we would do for migration. But we 
cannot detect that nobody pinned that subpage that we want to convert to 
private.

Core-mm is not, and will not, track pins per subpage.

So I only see two options:

a) Disallow long-term pinning. That means, we can, with a bit of wait,
    always convert subpages shared->private after unmapping them and
    waiting for the short-term pin to go away. Not too bad, and we
    already have other mechanisms disallow long-term pinnings (especially
    writable fs ones!).

b) Expose the large folio as multiple 4k folios to the core-mm.


b) would look as follows: we allocate a gigantic page from the (hugetlb) 
reserve into guest_memfd. Then, we break it down into individual 4k 
folios by splitting/demoting the folio. We make sure that all 4k folios 
are unmovable (raised refcount). We keep tracking internally that these 
4k folios comprise a single large gigantic page.

Core-mm can track for us now without any modifications per (previously 
subpage,) now small folios GUP pins and page table mappings without 
modifications.

Once we unmap the gigantic page from guest_memfd, we recronstruct the 
gigantic page and hand it back to the reserve (only possible once all 
pins are gone).

We can still map the whole thing into the KVM guest+iommu using a single 
large unit, because guest_memfd knows the origin/relationship of these 
pages. But we would only map individual pages into user page tables 
(unless we use large VM_PFNMAP mappings, but then also pinning would not 
work, so that's likely also not what we want).

The downside is that we won't benefit from vmemmap optimizations for 
large folios from hugetlb, and have more tracking overhead when mapping 
individual pages into user page tables.

OTOH, maybe we really *need* per-page tracking and this might be the 
simplest way forward, making GUP and friends just work naturally with it.

> 
>>> I'm kind of surprised the CC folks don't want the same thing for
>>> exactly the same reason. It is much easier to recover the huge
>>> mappings for the S2 in the presence of shared holes if you track it
>>> this way. Even CC will have this problem, to some degree, too.
>>
>> Precisely! RH (and therefore, me) is primarily interested in existing
>> guest_memfd users at this point ("CC"), and I don't see an easy way to get
>> that running with huge pages in the existing model reasonably well ...
> 
> IMHO it is an important topic so I'm glad you are thinking about it.

Thank my manager ;)

> 
> There is definately some overlap here where if you do teach
> guest_memfd about huge pages then you must also provide a away to map
> the fragments of them that have become shared. I think there is little
> option here unless you double allocate and/or destroy the performance
> properties of the huge pages.

Right, and that's not what we want.

> 
> It is just the nature of our system that shared pages must be in VMAs
> and must be copy_to/from_user/GUP'able/etc.

Right. Longterm GUP is not a real requirement.

-- 
Cheers,

David / dhildenb


