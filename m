Return-Path: <linux-kselftest+bounces-19829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB79A04A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F6F283FF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E87204F7A;
	Wed, 16 Oct 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q//KR2p9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D12036FD
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068620; cv=none; b=BvsbINN11vMT9CGqht7OknWY9NlTAPfGnqQTYHGYCoKNnYZZ5jrw7DCabu4Sjk3tFN4cgdNpNL1XSkjB+9T8klBwF3VYNsJ0Glhf9r2EcpWyoX6Qygxc9qefKeVSwAXzb39KZvHtQWknDTBZU7lSU+Dfgw3Pj9khMqjdTTGX+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068620; c=relaxed/simple;
	bh=SW9GUdH7W7T53cpS0Bq5beJessHFnySmNI/tajjOQ/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POgVZol8pBugRGfKHPeQUy2yGbLT1GXjl/u6JbJqK9cwp58riOHaUEVnt8O7QzA7+0+f+xPaiwbl+U2su35eNTtnYccOEVgyYxzc8D4F7CKWgjoYA8NejNRnk80zXCPDjhCQOICwty7u2WGcVCL6rsq8ywzSruBGbdjk5b1QsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q//KR2p9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729068618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2xbgAUDqQsWMSu1xQj2HOctN3uI1yJePxhwRP2aZEKs=;
	b=Q//KR2p9saaeg4rzJBugebtbiNmhkfcm88Y1rkivbC6RVoH/ZFBZrIB9HIPQnF4P7onnbZ
	Cz8MHfBy4rBWVdHbK8mqA9lV51EntyP1VD/UMNl5hnJtJjEArjKHJHZTOYf3Z4ecU8MiNj
	D/LqlAAJkN7JQI54EF8+jBtUd2pqUqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-RzhdczZLOyy-vFS8GsmOqg-1; Wed, 16 Oct 2024 04:50:15 -0400
X-MC-Unique: RzhdczZLOyy-vFS8GsmOqg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4313a8e81fdso11202935e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068615; x=1729673415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2xbgAUDqQsWMSu1xQj2HOctN3uI1yJePxhwRP2aZEKs=;
        b=JrfihYkbug/Ey9yVBWh6EWwLW8LUWrD34B0cJbjxQISdzB9uylqwPPdmZpY28qA84n
         LK21KNFJZTU6VTs4vXb3SRaB8HgESrsuTs6mdSNlOTbOz3GZ7wI9qtYzPOhKbRcvuyp5
         EJdpRIYRL1S9C+5YZgd8j5QV8OFi4iUlcw+o/GN44Xt4TQMyEsnfd8S5ME0vDq9Qmyy1
         /eCfN1+0gmY/gTY2kllmzjNm4WTI87vqX8zdxYfUOfD8zt+iLu1l6cggEzcfaWtJECom
         OGwCYDYR+Ii+eC6HNOxFbB5MDnf/gk5TtdPrfTPI9ncpf9q+SVUKLMq/DgDFH1mB2muQ
         PofQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9YUgCMruFTSNCRla1ltFwYj84XsUfNi8DvXlhETKeakuKAT5pxKKNEiNLamQfKn/JStpY4HtCUJmCAlnqFYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxonmm56/+PjXG3kYyX+OmQ+2PeivpJkwoqZru1cNldCI40ogX
	fK1Zck4H201xBOeUrR3iYTAnCTs7smBZF/lyAhrRT/rm1MycnTa6GSGa+PC9pHW0+/O3jv0TK1w
	Mb8gqeABpiC37SKREkorFJA25TG8/+LDsnVQIaNZErpyHPWL9sbFALP8GOVwLOIh66w==
X-Received: by 2002:a05:600c:1e13:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-43155338fe7mr731525e9.29.1729068614725;
        Wed, 16 Oct 2024 01:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkYcCjmqKm+1tPH0Wpd8NVW9ATceX8OHLZ2B60u1nMEX3cJeq5pkt5KYme7VE5McZ6dd2s2w==
X-Received: by 2002:a05:600c:1e13:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-43155338fe7mr731275e9.29.1729068614273;
        Wed, 16 Oct 2024 01:50:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a200:af8e:d144:6284:4f93? (p200300cbc742a200af8ed14462844f93.dip0.t-ipconnect.de. [2003:cb:c742:a200:af8e:d144:6284:4f93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc2e305sm3703197f8f.98.2024.10.16.01.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:50:13 -0700 (PDT)
Message-ID: <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
Date: Wed, 16 Oct 2024 10:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Ackerley Tng <ackerleytng@google.com>, Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
 jgg@nvidia.com, rientjes@google.com, fvdl@google.com, jthoughton@google.com,
 seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
 fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
 muchun.song@linux.dev, erdemaktas@google.com, vannapurve@google.com,
 qperret@google.com, jhubbard@nvidia.com, willy@infradead.org,
 shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com,
 kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org,
 richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com,
 ajones@ventanamicro.com, vkuznets@redhat.com,
 maciej.wieczor-retman@intel.com, pgonda@google.com, oliver.upton@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I also don't know how you treat things like folio_test_hugetlb() on
>> possible assumptions that the VMA must be a hugetlb vma.  I'd confess I
>> didn't yet check the rest of the patchset yet - reading a large series
>> without a git tree is sometimes challenging to me.
>>
> 
> I'm thinking to basically never involve folio_test_hugetlb(), and the
> VMAs used by guest_memfd will also never be a HugeTLB VMA. That's
> because only the HugeTLB allocator is used, but by the time the folio is
> mapped to userspace, it would have already have been split. After the
> page is split, the folio loses its HugeTLB status. guest_memfd folios
> will never be mapped to userspace while they still have a HugeTLB
> status.

We absolutely must convert these hugetlb folios to non-hugetlb folios.

That is one of the reasons why I raised at LPC that we should focus on 
leaving hugetlb out of the picture and rather have a global pool, and 
the option to move folios from the global pool back and forth to hugetlb 
or to guest_memfd.

How exactly that would look like is TBD.

For the time being, I think we could add a "hack" to take hugetlb folios 
from hugetlb for our purposes, but we would absolutely have to convert 
them to non-hugetlb folios, especially when we split them to small 
folios and start using the mapcount. But it doesn't feel quite clean.

Simply starting with a separate global pool (e.g., boot-time allocation 
similar to as done by hugetlb, or CMA) might be cleaner, and a lot of 
stuff could be factored out from hugetlb code to achieve that.

-- 
Cheers,

David / dhildenb


