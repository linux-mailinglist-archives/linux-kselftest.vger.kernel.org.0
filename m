Return-Path: <linux-kselftest+bounces-39653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41CB30EAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA107AEBF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCE2E371C;
	Fri, 22 Aug 2025 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkzQtCvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2122E2F0F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843529; cv=none; b=CIs4bEFGKqbDrHaDuRaBBDMC3RZmVh96ikoJAigST3n04PRtyCCagLcNdFFScPKsdxqq0Y6A86m3hBlCl/3wCv6vUAyawSGNWgaqQKle5r9IRc+rNOqYYvIYYPBnx4WAAJ13vY7sp8VCaAvYOi5Spsr0z5/1VKKCtq/eRQV73i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843529; c=relaxed/simple;
	bh=Ipdvs+TlyksrM4l/hJDMakLp93JAanz9a9w+7zx003g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMy0feAfNgiz2Er4FJE7Zm0ZBfPng0YNhkRd/sBd2hzcMB6hWZtZaiy6h+DOcKhyNpnYJSDwATLE4vTJNpX0X4FtZR56moZFYCUc0ig5pMutn8NSGuzRjLLyGaKuro171tMFxUCrK1D5FxQVB6rjpERMgG/cI3nEcKi3FIEw+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkzQtCvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755843527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=niXcAgzmbCLTQjKBYxU2ktBBprjtNy5MGdyac9sGLRc=;
	b=OkzQtCvu9K0jp5DStkMTdwMA41eVci/U5ckfSs6Qy3WNZ1I0HE989EckcUIH9KSIF0R/Yh
	baOXVdPAZU9+LBdZ62c3QXJXS1JSk+N5QQY6jXOfFX+gKhIKnV7HNP3lzC3ysQgeGfZQ7c
	GvLABDi6HOkPsA2Ep9awNdNGhYAdnEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-fHa8rYZMN6i_Ysm2DmbuLg-1; Fri, 22 Aug 2025 02:18:45 -0400
X-MC-Unique: fHa8rYZMN6i_Ysm2DmbuLg-1
X-Mimecast-MFC-AGG-ID: fHa8rYZMN6i_Ysm2DmbuLg_1755843524
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so10729365e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 23:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843524; x=1756448324;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niXcAgzmbCLTQjKBYxU2ktBBprjtNy5MGdyac9sGLRc=;
        b=KlxH+hSEv+2AiGGDz2zTzn2nwoP5/yWRJsCkJwo7D6DGyfmftmkM5D84F8WZTFJUW8
         zsaOmkZCXTh8D2jMdqdn3fRriEeMSIl1eN3ivYLqf9a/v6NbGByCEHvHR02jeNE1usW2
         qa2AMKQ98YA4bMEQqqDKTwxD9tze+/9IQ1ELRlmKKxEYFdGlIyfa4NfmQb7SGcWXoAWi
         xeP2k6fTjLac+3YmPgCL04pUFW5lZ931S0p3Fq+hGvpHJ9ZUWsQ1GFYlL/hOCCdKuznj
         MVdxx8ssrpOOtRPNkhje2HDV7eDCHNZtl5bSSnFEkgsGlKLABp+MdYRxsCCVMvuSqaZj
         EByQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh6XWW5AOv5TiW5p2xXBmYXYSwX5kn9psL2XUl+OcN7Z9RW6FSyKjHMtBaykwvudk563nQfxUlnmjE7BnFujQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygs7ygOx1a8mPPv1fLtezx7zPBqjh5gUdn7WWKFpY1I8amzJ+1
	N7T++prEfhJF5qYmraEiSSzOeGtTc+Mq4GwZnk5i6kOE8yD97b7t/JfN0vIdkya3prD1fqgY9jB
	qleXwNMGz27eb0nsHgVcQH4VtqPnOBWZ8gl7Seonn5uOStxDNWfe+mS2uqM3ts8MxaxoAgA==
X-Gm-Gg: ASbGncuokdAykisxFAAOpP8h1OkjKstKmE+3oJrTLcWRJFOKfIZsYxruNz8mv8M3WYn
	blbLp50BDt9aOiYikQKbf+IcpxW4ooDdjJ8k2bxlIgR7lAqYUQBQmxa21zbiSBTLgfJDvHgcSxn
	qgCgRqWPLWSeS2NPJttXbV0fCDNhXbq9G/1xBApYg0llNuf5H0HsiV99cVr1twmaTZi22ley/A5
	aElSA9WO7zjT8w3s5orLKt/U9N4Y+oDv2POUX2gu7QjfaZxIu+8/CmRJ2C7KbdAYHbScw1ygdCU
	wlRFJFsQX00D953huUFh7lFmK/r8F6GXtCGbIHVebCB+av2HY86XZskr/WJtBa8nw6/a4A==
X-Received: by 2002:a05:600c:4e8c:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45b5179e7e8mr12435685e9.12.1755843523911;
        Thu, 21 Aug 2025 23:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdnIqi4Hq3cqdHCtXLM1BskgbP/iNxi6JCTe3b4/5WxUiRcTB1IoXLbvfQ3J7NKdKWtFg41A==
X-Received: by 2002:a05:600c:4e8c:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45b5179e7e8mr12435175e9.12.1755843523431;
        Thu, 21 Aug 2025 23:18:43 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f25c.dip0.t-ipconnect.de. [79.241.242.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50d62991sm24078285e9.0.2025.08.21.23.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 23:18:42 -0700 (PDT)
Message-ID: <6bff5a45-8e52-4a5d-81cb-63a7331d7d0b@redhat.com>
Date: Fri, 22 Aug 2025 08:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG
 entry
To: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Alexander Potapenko
 <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-25-david@redhat.com>
 <3812ed9e-2a47-4c1c-bd69-f37768e62ad3@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3812ed9e-2a47-4c1c-bd69-f37768e62ad3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 03:59, Damien Le Moal wrote:
> On 8/22/25 05:06, David Hildenbrand wrote:
>> It's no longer required to use nth_page() when iterating pages within a
>> single SG entry, so let's drop the nth_page() usage.
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/ata/libata-sff.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 7fc407255eb46..9f5d0f9f6d686 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>>   	offset = qc->cursg->offset + qc->cursg_ofs;
>>   
>>   	/* get the current page and offset */
>> -	page = nth_page(page, (offset >> PAGE_SHIFT));
>> +	page += offset / PAGE_SHIFT;
> 
> Shouldn't this be "offset >> PAGE_SHIFT" ?

Thanks for taking a look!

Yeah, I already reverted back to "offset >> PAGE_SHIFT" after Linus 
mentioned in another mail in this thread that ">> PAGE_SHIFT" is 
generally preferred because the compiler cannot optimize as much if 
offset would be a signed variable.

So the next version will have the shift again.

-- 
Cheers

David / dhildenb


