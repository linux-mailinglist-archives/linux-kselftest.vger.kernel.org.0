Return-Path: <linux-kselftest+bounces-37840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE5B0E045
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0003E7AB593
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AB261573;
	Tue, 22 Jul 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCyM/fJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4C25E44B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197633; cv=none; b=hnBe0H5/GpmO7vcW/HVcS7PPlmAOXfiQJm6o4JhyEOZUKcAOEgTZV+BtdqqtwAxa81/TvpdIj0kOdkpc9YI1Iqtl9sy1uz2Q0vYxNms9zim8PoGroZ7SCWxFjuqaeuQkMs1SFBZTtTmXk87MZu3hXoxujvfLLZvKgLLRsY0Pv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197633; c=relaxed/simple;
	bh=EgrrwcZ6j7CSJT5s0hlrma2bExgZWXc7DwZ6upbMXg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT29Xon9COqPb44Y6L+3ba1Sk1thJicU/FDH1/4iKVewHBECUJmAFnm/CxO/c9EOVhN4X0B+fQAU7TKTjb8hpR60vOVQkKyo2X6el/7yzBsC8m1ZcjapQdZJG8DmXEL8SNR6Cf2whObKzKnF1h8mAU7NXwr/mVZEEJRGJ9PNinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCyM/fJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753197629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UR686UB6W95T3RcYAhWHnco9tSypYtrsdOEb8UEkv7E=;
	b=BCyM/fJTLec8DSK8VlC5rTRXteotCE2s9QEgC5jdDd1sPCMSlZywGQrq2/OyL4ojVjDlG+
	x56L7Kiwxovn+Ty5zAqyzIP0YObOlD3a9oFywJY0q4etj+VWjwc2+xdEOG6UyuUKBEBLs9
	lTu5OVpBd224x+nNP3sGNB6/CkTZJxg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-lVjAVMCHOsSF-gnNM2QjAQ-1; Tue, 22 Jul 2025 11:20:28 -0400
X-MC-Unique: lVjAVMCHOsSF-gnNM2QjAQ-1
X-Mimecast-MFC-AGG-ID: lVjAVMCHOsSF-gnNM2QjAQ_1753197627
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so46158195e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 08:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197627; x=1753802427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UR686UB6W95T3RcYAhWHnco9tSypYtrsdOEb8UEkv7E=;
        b=ZucHlEbl8rztb7ohTZ8Ir9DCX+KtzV+8pT/kqKQwji15xaiiFVs64JCHf5H2VI6B/p
         TrqlRaLvRAHldmTPBDHuXfMqLVkzK8ejtY99iCyfvt/nsv+v+JHC95yPSgTNkwjDd3lD
         c+/BIN1DPdpAawEMowdWS4IWpOUv01ezbJ//g2FUR5GQjARFrybBCDTp4CAuDO8C26i5
         dkDIddiDXosG3N8Cj6iER9BxezprTqy1blactHpdU6E9pwZUol9fetn9vKv+4KxttWdR
         AadjuJ30G8ygh6vbYsJVUHMkxKY7Xma/TnDSIbUTEAIKf7gJpoAmwp19JbAmmk5oEvUE
         Q2tg==
X-Forwarded-Encrypted: i=1; AJvYcCXcFk8Gj2WHKVvL5DNTYvgIkxpSaxm8Yx+oWgv5xRHb5gNgOrjJMOYmfHdXlP1ODzA4lWfKA6tNpl6Zg5aKJK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Yu6NpUxtg7tHBHlYjyAuciKMIIhaxwgopuVP2BnNY7vojx9O
	EAzuuyZETTp54ifj8qywkbgea+kY/Iz6exfT+qk3XqCEaSLS4xJfrlrvQOtu0lBGIRtMZVxBwGG
	PWAtO6tzF4BP/uYWxIKQ1cKkpBrGaP+fIkTwFwl7jVrBgUQ6hetZE0ygKjnkAAVLxlKplwQ==
X-Gm-Gg: ASbGncuDT7g//+KH7NtnvzcGekHfd+hEQN+DaNcv3GDe/jI7NqlmmmntPJEoL7qMVXV
	+x9Yqkh2rKgGD+86ujdizvx9hhGBDzwA2YZ2fYIngND1VG6CnOYrqV0ufX1dC6k49ZszRlksxeW
	AylMKLDfGcPRv9Lg2Y668OqSVAK3UKxjob7kHTEbsXDNzx1KhedwkIOiMfNyqFcQtPsQ4mavWin
	OmBy3DItkBIhVkmYeDPEJoadHgrpE/0yZAqjM1WJINzw/RstcdX4dJXyw75mFvS1d2eiGiol1p9
	U0Gcplb46I9x1EH5N99SYfVC3Me2qhC8wm+IpecFUeNEclUnDc+DrFJZAGsNfhgAkcFg/y8kGEh
	xNT0R/ORm4yeR8eEzH9K/sxuvMdeOXFjj0aH0GkeXfaLPorDEBLizy4udXpf7/1Rx7IM=
X-Received: by 2002:a05:600c:4f4b:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-456340160d3mr221374935e9.15.1753197626708;
        Tue, 22 Jul 2025 08:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa43nqfLMQERCC1j/wmVHQ7UtK8l0NZCMFbPH2YHsoDOoAl1UMnjReWSKUBgR3S4TG9WNPmw==
X-Received: by 2002:a05:600c:4f4b:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-456340160d3mr221373905e9.15.1753197625794;
        Tue, 22 Jul 2025 08:20:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586144f80asm38163855e9.1.2025.07.22.08.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:20:25 -0700 (PDT)
Message-ID: <2dae19aa-7913-4350-b031-38d00a20057f@redhat.com>
Date: Tue, 22 Jul 2025 17:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 2/7] mm/filemap: Add NUMA mempolicy support to
 filemap_alloc_folio()
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <20250713174339.13981-5-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250713174339.13981-5-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.25 19:43, Shivank Garg wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
> page cache allocations. This will be used by upcoming changes to
> support NUMA policies in guest-memfd, where guest_memory need to be
> allocated NUMA policy specified by VMM.
> 
> All existing users pass NULL maintaining current behavior.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


