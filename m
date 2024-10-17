Return-Path: <linux-kselftest+bounces-19997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073669A2A59
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812AD1F2851D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956D1E0DB2;
	Thu, 17 Oct 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkGruWTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E861E0B85
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184759; cv=none; b=HHo3tft8DwAoe8XVJts7amshNiXguccMzsK9vJq57KVo3Obtm+JRkttF0Tj2BVPxVwQAU/74fkiUlB2saygiWD0D/AyIBWDLixaq0giE08LIYi2Wwa2hu25vi9hjhg11HxtTVbnNGU8d0W0FJwRW13s5OZpsfYWrKHvqZq5HXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184759; c=relaxed/simple;
	bh=nwUmW3HwWk2L8wzAarlBvpMicClGRl1zSOHwmH7o7OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qegSCLksIIDPKy+4q5W1mE+CtJpQevgyOgJyzp7SizqrSTAy1b+z0IVFKRy6cfYnGhKEVHAC48jI3mQXVwDA6GangyDCoMYbeTKYjwEiy8FfeOEfDZ/Bmmrr+4p/2dtifImCgqNK1u+xcL/QRo7SuZFzJzT63lBFGeYIi8u326Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkGruWTX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729184756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTxdalYG31XpePFBi14kwyLsxFtz4ngJLPKLlOmswew=;
	b=WkGruWTXwrSN9o9w1kCmjGcmG+oUTBJFKEWU0UsXQZMIJCVTHr3GQ4EqAhS/k4Yb0YV05U
	e/hGYvGzcFMd1H+iQvYShjxUYIq8yVnTzDvcQBBET+jBigOmwIwCflN1XsdZm9mMwhd5jW
	bF+oBtz05l/UwhUz02IggzjBQ6cYaTc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-0A7YGLJ5PKO_xIk17rWcdA-1; Thu, 17 Oct 2024 13:05:53 -0400
X-MC-Unique: 0A7YGLJ5PKO_xIk17rWcdA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b14fc05206so152771385a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 10:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184753; x=1729789553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTxdalYG31XpePFBi14kwyLsxFtz4ngJLPKLlOmswew=;
        b=gJLBXIC/o1kpqIuatxD0zuc4leFWUdBFJymVWIMjT1aIrY+JhqJTFvXOC5FoFwGu9j
         n8zq/1W5wfb79PluDd2yLyzr+ZKpyVAMEE+F/a3YrKwHUrvSpydR97N1b9ooRV542fcR
         NAgRguDB4Dg9+aMz1YU5rkw6flsV8Y4uqcdFmNzvYv2lDq7uPigKRDKWKBBR5njlLmjQ
         qPKcrP+d8E0dsKEN2xF8d8bxiok92tXvy42vcY02iv6UtEdq1kduLRVwHQJJlHWwJl8w
         BMgk7I/vnothUaVFI4fc+A92X7DYKmgYoc7sDn9eVpHk8IozlamOIi0f47IO+Bvu8aFl
         jdIw==
X-Forwarded-Encrypted: i=1; AJvYcCWYAhnh7Qt1HwNhfjbH8uh6ul0fg0HSEOGY9uhdmb3KviITVUixaJPxJXX/oISS0KGAVANImMfzgYY5BFjIcDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+LYIrg730xuTfZgH1asV1YgQFfkU2Rr3/s3Q6m8YtHyc7SHZ
	MZwoAPgWHsu/cmfXv6933px2x7B9S5jLUVq4n4esMx1/D3kFGpnW5ck3qIYaG5BwDehd3OVJE94
	GPdpK86quVuz3eKWDQE/nCLPHGa4D6W0q8ZYFSkGPWm86afiXASRy40St1n4fJMxmpA==
X-Received: by 2002:a05:620a:372c:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b1417b3191mr1094412885a.13.1729184753020;
        Thu, 17 Oct 2024 10:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD0En3wQDJBS0nydKh7vHrLHOJlIadS3w4LKE69c5NsvIujdsOvlVIWDnzPR18WON37rexWg==
X-Received: by 2002:a05:620a:372c:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b1417b3191mr1094408885a.13.1729184752627;
        Thu, 17 Oct 2024 10:05:52 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136170dd7sm308639185a.53.2024.10.17.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:05:51 -0700 (PDT)
Date: Thu, 17 Oct 2024 13:05:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <ZxFD3kYfKY0b-qFz@x1n>
References: <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017164713.GF3559746@nvidia.com>

On Thu, Oct 17, 2024 at 01:47:13PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:
> 
> > My question was more torwards whether gmemfd could still expose the
> > possibility to be used in VA forms to other modules that may not support
> > fd+offsets yet.
> 
> I keep hearing they don't want to support page pinning on a guestmemfd
> mapping, so VA based paths could not work.

Do you remember the reasoning of it?  Is it because CoCo still needs to
have a bounded time window to convert from shared back to private?  If so,
maybe that's a non-issue for non-CoCo, where the VM object / gmemfd object
(when created) can have a flag marking that it's always shared and can
never be converted to private for any page within.

So how would VFIO's DMA work even with iommufd if pages cannot be pinned?
Is some form of bounce buffering required, then?

It sounds like if so there'll be a lot of use cases that won't work with
current infrastructure..

> 
> > I think as long as we can provide gmemfd VMAs like what this series
> > provides, it sounds possible to reuse the old VA interfaces before the CoCo
> > interfaces are ready, so that people can already start leveraging gmemfd
> > backing pages.
> 
> And you definitely can't get the private pages out of the VA interface
> because all the VMA PTEs of private pages are non-present by definition.

It's the same as "not present" if the fault() gets a SIGBUS always for
private pages, IIUC.

My prior references to "VA ranges" are mostly only for shared / faultable
pages. And they'll get zapped too when requested to be converted from
shared -> private, aka, always not present for private.

> 
> Hence, you must use the FD for a lot of use cases here.

Thanks,

-- 
Peter Xu


