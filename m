Return-Path: <linux-kselftest+bounces-48520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B327BD036B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E7B30164D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DF3E8C57;
	Thu,  8 Jan 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LBpMoTH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3793E8C50
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883088; cv=none; b=RpoVxOmXSzoEBqJQh10cQlAohRJ99bj+RYf2Ya2A2R5j104AngjPaNzjtTTVFkunqfu+rPdSx9aGL45+L7wOEfVVnGMt/z1gAw6NIQyvZS9zim/17AJxCHUDxRUOlHkTi+Efo1Y48Mf3RgIS0AWa41Kt/CZXZj7G+4R/ahYqRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883088; c=relaxed/simple;
	bh=GmpQwcX3AomhyK8IzIdam8W2T3co9C63wzdOxRK0XH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0hH8R9QW8IMZyUI5nP05TO6kUxafVg2m+dPYACkTot/sWEQ3wZWpXaAmWJu9ZBV0u3v1AHotnrlYnHGi+yWD01x0ZKsKt+m4t/ley9TQ1NUtVIMghmbo/Mbo9D/x/TDpp5oeBYRWsBveW/aX7g0sT6MtKHdD2LngL6zSBrRKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LBpMoTH+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so43886531cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767883085; x=1768487885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UkPzHJqtD9VgrmurNOGQIfU0hw+eIOkm7oGShw0jyU=;
        b=LBpMoTH+XOSJw1NjVMYwpajJWEpQvvAdGRG7o7YXDk9HDcdrYV8aIUzLB7XU3V2fxj
         tRTMKOXbs3pn5Yt4POCi7lY2H19XxxV5nCZRNzi1PUzACFILaLNPaFOPgo+quhz/jO3G
         QLaLcMwXcuUDj6W1aweV3rVWs+hoICwfEeSI8qOGy1MFIZG0dCfvvFWTmDonJo7IBMni
         Hi0yer+FzRZi4Je5mEAvVUkanQul1IPHPkvmvNRGGw9DY82MZubkDrhJBK3mikZgNr44
         5WIRtboYJUBYCF9jtQrErISdvUxtk2R3KSVjsueAwfq9I5MdR2AowXm1l0PLqaZUWxRt
         Umxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883085; x=1768487885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UkPzHJqtD9VgrmurNOGQIfU0hw+eIOkm7oGShw0jyU=;
        b=oQYntEY+QBqOFS1UtCZmN+HcNpDLbHOJZ24z7poRzWsvyndOStmYFL1fnUWzXvZ6cu
         qAsfAQnbto160e5CE1PPnyp6IaH3Cf5+Kf1IsYoGGieeNbTBpXmym+hVfrpNmpsWWrh0
         6EyItyspG1TRWL2OkyJ2D3djToN9ZVfqTwWBjoo/NIEPUve6HR04MfSsEmtVqvuZ46QW
         mNqI1Py7es1j6983pqJNNKgAruwJnLpyFAsr4lJWJExrA8CTwtsYCIrIIU6RlWhOE8rX
         tifir+qha0qsOJQdSDUfCumsrR2R8VyJ0FyXFkaO+6yrAyHXrCBDR+AY9hFDVrMx0eGK
         q45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY1QyqaFGGO6qcsrsrQWI3Kxg6FtQ5N7mTGM/G/fD1k9bvsKtajqDTReDy03q00EeIqSz3iY0ZrcZYKNIay7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFNYISdBhZBEBhgfDG4qPttPgOFQhAvL3EqmXVi31bC8n9pW/
	SofJUb/J1eCGQg3ydW2EcWmkh4CxUTAIRQFC9nG20I/96QQkkEGbJ7yuoC1pSDbSmX0=
X-Gm-Gg: AY/fxX6IQRhkIoafVl7uITKZAp7rjvybUras7o8OqNX7F/nE7SwhjqO6T6I5+X59UyO
	r6f/ghUeQIZlnhdOGkIHdM8hCr9z8XjBA4ZA2HYPTDesH6atJOZgLU8mtaNxPy69TbMXO+Y1wdP
	XhdljFX1vNV0EOUsFd0JyNToleM+eX2zm+ir/cQ6eNLaooU2wqy+PjhUrjEOC+7511Cxe4bIi1P
	Tks/NH4hLUumTXzZYSOP9DG6XBeql12PnNSzMnY4RWr5CtC/1PWq4P9Wtyekf907+fZaVOawUIM
	zUFmfXMl1JYZi+kDKPHluVcZp8YZZEsQAaNegFiuF+0L73GUp+wqdTe9WzUn/f4qJndtwAcjTcu
	ARJigBMsrGY69/qiiqRsjt9NVvab36E7GIa3e1eSMpIrYQxtlfhMmTY+NrINIyO3wyR1xgsRWO3
	pM9ZKxLzgIXKUyQVJkzSXn/WPZNpOfhKrH043vYKYtzacqb4YGXrr8OZjuCZXr0QkzQbk=
X-Google-Smtp-Source: AGHT+IH8++VROd0tcHeXvIN5iIXsNvVoQ9NVpIio+cuElHEEIvpqUWXZewjuHPXTe96KfUV3OyLsqQ==
X-Received: by 2002:a05:622a:1a98:b0:4f1:b9fc:eeda with SMTP id d75a77b69052e-4ffb4920c69mr75280691cf.37.1767883085548;
        Thu, 08 Jan 2026 06:38:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8c00acesm50442131cf.0.2026.01.08.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:38:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdr9I-00000002M9N-1rBb;
	Thu, 08 Jan 2026 10:38:04 -0400
Date: Thu, 8 Jan 2026 10:38:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108143804.GD545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>

On Wed, Jan 07, 2026 at 07:36:44PM -0800, Alex Mastro wrote:
> This was inspired by QEMU's hw/vfio/region.c which also does this rounding up
> of size to the next power of two [1].
> 
> I'm now realizing that's only necessary for regions with
> VFIO_REGION_INFO_CAP_SPARSE_MMAP where there are multiple mmaps per region, and
> each mmap's size is less than the size of the BAR. Here, since we're mapping the
> entire BAR which must be pow2, it shouldn't be necessary.

You only need to do this dance if you care about having large PTEs
under the VMAs, which is probably something worth testing both
scenarios.

> The intent of QEMU's mmap alignment code is imperfect in the SPARE_MMAP case?
> After a hole, the next mmap'able range could be some arbitrary page-aligned
> offset into the region. It's not helpful mmap some region offset which is
> maximally 4K-aligned at a 1G-aligned vaddr.
> 
> I think to be optimal, QEMU should be attempting to align the vaddr for bar
> mmaps such that
> 
> vaddr % {2M,1G} == region_offset % {2M,1G}
> 
> Would love someone to sanity check me on this. Kind of a diversion.

What you write is correct. Ankit recently discovered this bug in
qemu. It happens not just with SPARSE_MMAP but also when mmmaping
around the MSI-X hole..

I also advocated for what you write here that qemu should ensure:

  vaddr % region_size == region_offset % region_size

Until VFIO learns to align its VMAs on its own via Peter's work.

Jason

