Return-Path: <linux-kselftest+bounces-40265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A9B3B848
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2329D7ABF41
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31203090D7;
	Fri, 29 Aug 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlCqGzux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A92877DA
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462239; cv=none; b=ayUweMiabLOJ/XMZBBLbfEwKMu2iy4t6O90e42X6i5oMlLVYRNxiNIUDRV6JeDgAGNkovIlRFrKaeb3ztjbtatT5cZ5HVv+tYrFgjufbPbA1nNbBSFaeQujR7IbpdZ1hfgohwzaVqA0OhJHLONzhDkFKaRC+0pA70XQrYjy04V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462239; c=relaxed/simple;
	bh=w2ywswPb+Egg0+PbPt262C8ZCdnp1Z4P+pp4HQIEFpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5fFuZczQhnyzK3l6i9TYsFQXfe7Le/n5lE/yGz4rGfqCxDUpzqp4nC1VMn2ly2fMS1biC8v9mS+GI/Q+jlTeLEPoMyynzUXU1h8FxHO3+vjUdTOxxvRQtIgmUVnBhNUu7kp2uUna81Pd9ws0kNRgyH5Qc2UtOoJyYNRzMY2abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlCqGzux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756462236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=utCrFA9SyGV3mLz3PcpHz6c/4tyzaXDXayD3hFRPQRM=;
	b=DlCqGzuxpSUnEC5RbIm7bgsWh8H5Kkgaw8NA8Aklb27ibHHlzz0GsbvTp0IqTKAD5paVIq
	9PyirXekDKNsrT7Zs4X8rFHduUyL6MVYFJ+aWtqO/B86od4Ci/XrErWYgtcT6mbadxU//Y
	mfAxhuj58AjdWgmiqK1B3mRedRTBEAE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-RxEtlgM3OAu55UfHAoa0-A-1; Fri, 29 Aug 2025 06:10:35 -0400
X-MC-Unique: RxEtlgM3OAu55UfHAoa0-A-1
X-Mimecast-MFC-AGG-ID: RxEtlgM3OAu55UfHAoa0-A_1756462234
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cef6debe96so560549f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756462234; x=1757067034;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utCrFA9SyGV3mLz3PcpHz6c/4tyzaXDXayD3hFRPQRM=;
        b=D4mzb875cvmdnB8G/X9RUqWqzemRZlDL94nv2AzyxOsjIcRuGnlz3EqZY0WQkeKgXC
         jCfccf2lL1/vH1A9wSm4VD4lKWDbGPKgQyhIjdhwpHDOpAOD2gA3egDJz3VQDFlf6PzO
         NnO1Gu4riLa/nF+DBMRqXsKl93yInpznEs98RR7+c+9UUlSz7sRuDxJXmQYIPaUn53Sx
         4ahYOjORCBOOjObLoAWuPInhm5VIiIt2dwIfNojeSZyZoEJqwPtUfHaiXiOIv1ZYJW9j
         e+OvMJE/jwuaMD5rTnK3KflfsgZsvYhR8oMdM0p/YyQt2qUpOlwdSR7ZKYU/arj46Cwa
         y5eg==
X-Forwarded-Encrypted: i=1; AJvYcCUVdv85d3+Pgg/Rjs0bM3YzHfyFsiJSOPeZg1XepZSaVuVZ9ajrhzOwu6RJ8CGhgnuGKj3ITgWq6pOUb1gBIi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2V8v9REJpbwaL9wQh7wRYXgOlM8xs9Wh736M5SwTwQo0iAex
	gZAyEUQW0ArZedYRRl5TyRLFf1P2sV6TwJq+tpeZtzHJF0uaHQXkG6PUAdSKPqbjMSW26TakhnS
	+UhsCtMhsyolBnwpBr9EtWCqVAoDNCmL/s5+1kQtdtWszSxkWSIBrR5H5za3hNshm0fPJ0w==
X-Gm-Gg: ASbGncvKx2mxZ2TElE6d4RmvHfZTAFz/BYey3zsxfIxQGJsUi++qY3VmHJondgedsk0
	SoZRs5uF6toLgRbA4ZB6tN+TDEszOEFnHAmtzA+Sdjhp3bI54qFXfvxejiYMVoL8oCUVCFwYFbI
	aXSyxwvCUCOa9avhaM69QM0NLB3hPKcUgOeIOO8bOnf8llY59almQwn5+8g4MBJyzpM/MYFDgk4
	3o5vKo/+yKnPdi1ecNNr79dq6pDWQxH6SXNcm+OUr1Qnd+GCmrL15fmvMuRa62zoYzch1/9Dg32
	kLpeSft9G9lqR+6GyCYYPJzsE8RY62gx+EKpSOSDu0mL5YzPUlN0L1m1wTcwFRL5tnbu0qgm8xJ
	PZur/MQsnaXN3v63QBV/lnl5NAiY2oGm2kt77I81VqHMswH51NvIK5TjaYLjZ9HCW
X-Received: by 2002:a05:6000:4011:b0:3d0:bec0:6c35 with SMTP id ffacd0b85a97d-3d0bec06f52mr1040133f8f.34.1756462234028;
        Fri, 29 Aug 2025 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5N+hXboXv1Pvz2Dg0jTDmYwZsPnkQwUsFPtQ8nUdHm9G3EJc3XR4ExkZX65hTeoyT3mXdJQ==
X-Received: by 2002:a05:6000:4011:b0:3d0:bec0:6c35 with SMTP id ffacd0b85a97d-3d0bec06f52mr1040061f8f.34.1756462233448;
        Fri, 29 Aug 2025 03:10:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm31221455e9.12.2025.08.29.03.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 03:10:32 -0700 (PDT)
Message-ID: <a9b2b570-dc81-43dd-b2f3-a82a8de37705@redhat.com>
Date: Fri, 29 Aug 2025 12:10:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/36] mm: sanity-check maximum folio size in
 folio_set_order()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Alexander Potapenko <glider@google.com>,
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
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-11-david@redhat.com>
 <f0c6e9f6-df09-4b10-9338-7bfe4aa46601@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <f0c6e9f6-df09-4b10-9338-7bfe4aa46601@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:00, Lorenzo Stoakes wrote:
> On Thu, Aug 28, 2025 at 12:01:14AM +0200, David Hildenbrand wrote:
>> Let's sanity-check in folio_set_order() whether we would be trying to
>> create a folio with an order that would make it exceed MAX_FOLIO_ORDER.
>>
>> This will enable the check whenever a folio/compound page is initialized
>> through prepare_compound_head() / prepare_compound_page().
> 
> NIT: with CONFIG_DEBUG_VM set :)

Yes, will add that.

> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> LGTM (apart from nit below), so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   mm/internal.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 45da9ff5694f6..9b0129531d004 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
>>   {
>>   	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>>   		return;
>> +	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
> 
> Given we have 'full-fat' WARN_ON*()'s above, maybe worth making this one too?

The idea is that if you reach this point here, previous such checks I 
added failed. So this is the safety net, and for that VM_WARN_ON_ONCE() 
is sufficient.

I think we should rather convert the WARN_ON_ONCE to VM_WARN_ON_ONCE() 
at some point, because no sane code should ever trigger that.

-- 
Cheers

David / dhildenb


