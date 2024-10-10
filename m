Return-Path: <linux-kselftest+bounces-19460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B604998CCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8332816FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C11CEAAC;
	Thu, 10 Oct 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1u0AOUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCF1CCEE3
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576417; cv=none; b=VthvzlkjZJAziSjtT9dV9XSvIyr1HQdklBcT7+mjOOkLdGGr1tWxZNiWIvlixrO9Bgph3NIQmZtSDdlvCcDGXj3zkF8VnKQU+SgDIlsXHC2PsrMouyXLW6ZyMYL/KcwXmdsnnqnrrMkyy0aVzFvc+SggU9PNCfFsdAl4F0iy5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576417; c=relaxed/simple;
	bh=iiFqIaeGWzn5Xw4KqI1wHYf2EWVoHUdUhd1tZQSD++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+aEs3nBLdVub6BEQT0kTh+kQe4TUo6yWGJtGiSyLOsNAtWU6kO3dF+YV/p68M3HvT0UtfCfoAUL43sHQdRXGbXA9Bfw8JKdJdPFUYCyel2fkkv+fbXHYItcHLC8rZZbkGwjvDk94v4yPLXFylEkaV7YMGqn9ZhU34BwX94PCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1u0AOUL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728576414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/HNyejBOzZNAS2pmhlTCa73HqHtmX71UiVQvzZUuQU=;
	b=V1u0AOULdDT4aTiLhd0uILLJHo488sn1SJ8DVNpGQb7Fw46so9hsbRVQcYadI9Hq1KesxN
	kE2K42prgx27iD8XuU8IAgx3US3I5g6KoU5CuD8+Q3W6mpj+DR4e6pzCdws7Aj12wNdUhl
	U0THedGEEcA7T5Lxc7LkZ7Sxvt29jdA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-k_TrgjQkMTyWPvynoK5MSw-1; Thu, 10 Oct 2024 12:06:51 -0400
X-MC-Unique: k_TrgjQkMTyWPvynoK5MSw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e108cc964so1208747b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576410; x=1729181210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/HNyejBOzZNAS2pmhlTCa73HqHtmX71UiVQvzZUuQU=;
        b=lghu/0Ktaypbvx+UMCZzUxJpHa2qR4WmzmQZLMzI8B2dzQas/XfWqAMQqhbJjsyDSh
         1b8eq0BHIrGgyOyytNcvVr6hL8qyHyCUdSPPAnY2bS5wC1L1iAtwbtdtEdcMxw0cNCsk
         UtueNJthzf3dmKPjg6OABFhBlCBXbpb5wJMDBgvtRCrec1m3GoqU/uGj0aqk8AzYWThT
         RL2ATkS0nPn80H7tpObteWRAnF134ziW/OZEvRgWMYWT59k1ghg8CGfpHrOEpNOZbqlu
         +9a0uHkOvcfAgnQgBGBVxBqtjhGmehHJx9tH+X5q9WnlLggz4dJswq/29Qj57oGwHYZO
         ANVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpEaM8Kh1awF3FaXaHkdTO68U6Z43thOB9yrdt/uRVB7DSdV87uUuoh2PIX6U7PfnSuGz69FFpO67KZyEDuD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIY11E/8Hsg4J8lEFHKqo1A6S1LFSF/ZU6alNoB3yF48u0bf3H
	S6KRHxn+iynfIof6d5tJCtvUHGGhBjTLzcxWBxzgky5LxzOg0RRjYVlLx+1ZKtOCVSLOeMv1OWM
	CXlhkvTHLOn7oKhM7t39mxaJ03nyM0qOEMYbKQDomGfGpfwI9gVKHCoOJo374LdUajw==
X-Received: by 2002:a05:6a00:179b:b0:719:7475:f07e with SMTP id d2e1a72fcca58-71e1db6481fmr11819886b3a.4.1728576410030;
        Thu, 10 Oct 2024 09:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+7f1RLhbjySKF/4qyAXiKo7lGpEQ+qrTVlBlzhq+59C96dfh+Iq8tKg2tVLc+cHIQsd5gOg==
X-Received: by 2002:a05:6a00:179b:b0:719:7475:f07e with SMTP id d2e1a72fcca58-71e1db6481fmr11819813b3a.4.1728576409638;
        Thu, 10 Oct 2024 09:06:49 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9ea46csm1229368b3a.17.2024.10.10.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:06:48 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:06:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <Zwf7k1wmPqEEaRxz@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
> The faultability xarray is stored on the inode since faultability is a
> property of the guest_memfd's memory contents.
> 
> In this RFC, presence of an entry in the xarray indicates faultable,
> but this could be flipped so that presence indicates unfaultable. For
> flexibility, a special value "FAULT" is used instead of a simple
> boolean.
> 
> However, at some stages of a VM's lifecycle there could be more
> private pages, and at other stages there could be more shared pages.
> 
> This is likely to be replaced by a better data structure in a future
> revision to better support ranges.
> 
> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
> pointer. inode->i_mapping->i_private_data.

Could you help explain the difference between faultability v.s. the
existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
confused, otherwise might be good to enrich the commit message.

The latter is per-slot, so one level higher, however I don't think it's a
common use case for mapping the same gmemfd in multiple slots anyway for
KVM (besides corner cases like live upgrade).  So perhaps this is not about
layering but something else?  For example, any use case where PRIVATE and
FAULTABLE can be reported with different values.

Another higher level question is, is there any plan to support non-CoCo
context for 1G?

I saw that you also mentioned you have working QEMU prototypes ready in
another email.  It'll be great if you can push your kernel/QEMU's latest
tree (including all dependency patches) somewhere so anyone can have a
closer look, or play with it.

Thanks,

-- 
Peter Xu


