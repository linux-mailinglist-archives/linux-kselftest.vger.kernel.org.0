Return-Path: <linux-kselftest+bounces-40275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8972B3BA87
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FD5189A257
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB5314A81;
	Fri, 29 Aug 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFhBCrBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F9304BA0
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468848; cv=none; b=JqRvXPO15pGxeNr6TCL1PkXvVXVE3jbTmBkaGTSErKf8LrSDnGpulJF+yRHpa6RbsKTz0PDVSBMosfNeTJ5GcraSvlql1HJy4mdHwClCNnkRBQYNQ9HxCgQO9Ny7f40xMfVmlMSqi0kLqpFekMBduEZpccsM2QZG8IfC6pgvTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468848; c=relaxed/simple;
	bh=qcq3735yDXpxDQTbrZEw6XjTKqmBbOI7BOSNkjc0JK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opde8J5MIz4uyyKcn4RSNxXKClsGe3yplw0oS48BXzV9km3KmkxYJuqkhFrjRDORV42uM3RjldkcjgbOH4VRNK7Ox5lpM5hGIrZFLUnNZP7+uJQcAqVLyzbPOFEam4TkstJ/CPKft/YWiDtRGSutbjaBPQ0IK/6054aDUm/jmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFhBCrBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756468845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WRODc3MDTNqLHIXQzOQ9QRmb2QGRyzsJAWu0HJ+lHgE=;
	b=ZFhBCrBsuKThYsmda9YjgQueS10bMScbaRi1skeG1KwdbhHNoqOA6z8vA5HIwFw8Lw7bY7
	dMFKLeBRNVumx/gl9jOSnOTQysvhekjzYLXqn0uUMhMxp84y07Q8dUYwaMfK1YEEyINoBq
	wX3J2aOdWXTVODzaBXoFmcsm9k/t9iw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-jaHnIwkcOgG2UlW8Lg94ww-1; Fri, 29 Aug 2025 08:00:44 -0400
X-MC-Unique: jaHnIwkcOgG2UlW8Lg94ww-1
X-Mimecast-MFC-AGG-ID: jaHnIwkcOgG2UlW8Lg94ww_1756468843
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cba0146f7aso1009794f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 05:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468843; x=1757073643;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRODc3MDTNqLHIXQzOQ9QRmb2QGRyzsJAWu0HJ+lHgE=;
        b=BHAbZ4bx5EQEN/xVh9JJLvgckuDpUchXxjo+DXqz4surEmp6+vbgaBlrfkalvcu+Yv
         Nql0xkp4ccmH4ptRL/Wad2Ba4FXmsJoiZO9Ea0FkC02RLw3esMYDpUE4EfvEwnH8QnT7
         EgGH5zbkElq6Vvfo2aCkVZo7/BeiOX8inqjONVaxpo2VhAVoKVaoEgoUNydxN0k2FRyy
         MjyUP5ompj21AA5eriw2hX/ugF8cXi047fmkW06jjZg/D4VVkjqfwAcmLM/UUX3KNKje
         O5drYK1qJ4yJ64cHFbI5D4SNJBdAQfoV9t0d5UBJOX7XPctCsI4BFWnYpJcjwb0S/lkc
         QLrA==
X-Forwarded-Encrypted: i=1; AJvYcCU+13wrnWx4Gk2aYn653GwkPwW8aXmn21QvblQKX+cPlPbwHuOs4FOSZ88jz2D/j9DKmE5mxOSXG2T+cuoCWbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hieMorsuPrvvTvv59D2PQIubb9o8R3oB+OktynywuqsKL2SX
	Z9+5qFoekUIum/PtnVy8iRaxZjhunHKOWzBoXQtoE/j3sFXr37VQT09UFKR/umJSgFfsOp9Draj
	Yt/Mtdy4SGCNZT6clFFEtdgxGmD47z0XU/E7cB6i5rtdk/2GRZ5dJnq++M5BkRN+dB68elA==
X-Gm-Gg: ASbGncsDgquUlcaJsjsW6lpeGuSA4UMeVvoTKjuLD3Y2hIfxKOJUULN6c4M+nXbR+o3
	FBaLQjmB3aH+dYiwH9OTpjgPxxJwRmB3n9tU71DfxQHDqvrom2koycDgT2uugBUsZisFyLyokRu
	5qbTUlgZMGlSyFo3zfpdItdYdSiDdImezjwJV6zTBZdj/MKHLH4i0GZJxxVehdwTEAJfW/rmSpj
	5Fse5Ttviq8CNjU3JXy7a84EbHv0AYjAgpWRlB3Spi0HTYzoA30FMuwAbjvfaVRsErWlke156Qd
	ZOaJfMbJ0KqkM+sKW2s0uNyLnmDLjawmrvev0lEZwY1k5Favltjgl+CNr3pwX4GyNGHvSthVssC
	qAC29JN3U2cc/twjg6Kjc2qbVh7eYx9cdfzj/Xi1Tslta+61sXbJBu+mSv2A3X5o=
X-Received: by 2002:a05:6000:4382:b0:3c8:89e9:6ac0 with SMTP id ffacd0b85a97d-3c889e96e1dmr12052198f8f.3.1756468842733;
        Fri, 29 Aug 2025 05:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRdmd8Qo16pG8X+TFP/6YOZ+W4nkc8QhqQPHcWWiC5lStBhb4N+Shci4juwvPlMY9VjElJMQ==
X-Received: by 2002:a05:6000:4382:b0:3c8:89e9:6ac0 with SMTP id ffacd0b85a97d-3c889e96e1dmr12052085f8f.3.1756468841352;
        Fri, 29 Aug 2025 05:00:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc0a8sm3118235f8f.7.2025.08.29.05.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:00:39 -0700 (PDT)
Message-ID: <d0b06885-9f04-483f-a7e1-f197c8431491@redhat.com>
Date: Fri, 29 Aug 2025 14:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/36] mm/hugetlb: cleanup
 hugetlb_folio_init_tail_vmemmap()
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-14-david@redhat.com> <aLADXP89cp6hAq0q@kernel.org>
 <377449bd-3c06-4a09-8647-e41354e64b30@redhat.com>
 <aLAN7xS4WQsN6Hpm@kernel.org>
 <6880f125-803d-4eea-88ac-b67fdcc5995d@redhat.com>
 <aLAVUePBQuz9D89T@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLAVUePBQuz9D89T@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 10:37, Mike Rapoport wrote:
> On Thu, Aug 28, 2025 at 10:18:23AM +0200, David Hildenbrand wrote:
>> On 28.08.25 10:06, Mike Rapoport wrote:
>>> On Thu, Aug 28, 2025 at 09:44:27AM +0200, David Hildenbrand wrote:
>>>> On 28.08.25 09:21, Mike Rapoport wrote:
>>>>> On Thu, Aug 28, 2025 at 12:01:17AM +0200, David Hildenbrand wrote:
>>>>>> +	/*
>>>>>> +	 * We mark all tail pages with memblock_reserved_mark_noinit(),
>>>>>> +	 * so these pages are completely uninitialized.
>>>>>
>>>>>                                 ^ not? ;-)
>>>>
>>>> Can you elaborate?
>>>
>>> Oh, sorry, I misread "uninitialized".
>>> Still, I'd phrase it as
>>>
>>> 	/*
>>> 	 * We marked all tail pages with memblock_reserved_mark_noinit(),
>>> 	 * so we must initialize them here.
>>> 	 */
>>
>> I prefer what I currently have, but thanks for the review.
> 
> No strong feelings, feel free to add
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 

I now have

"As we marked all tail pages with memblock_reserved_mark_noinit(), we 
must initialize them ourselves here."

-- 
Cheers

David / dhildenb


