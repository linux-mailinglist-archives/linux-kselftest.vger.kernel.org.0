Return-Path: <linux-kselftest+bounces-48575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB4D06A21
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 01:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF8E2300D938
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059B1D6195;
	Fri,  9 Jan 2026 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpwsC0xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0611891A9
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919420; cv=none; b=HnS9ZXFvwqdE4rPkS4Vw1WWBmRtyf9HohPnmK0jW94fz80ZcXlpfUvD8gmw3ZEP1P5WyNrzha3HYNwM47iii1HbLjjZ8QckAtjZtrt8EOUsm1WKy154dU2e3YQFfw1VBHnbsCIvKc9ydl6vNEtS42xrlUEcXao77ul152/orWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919420; c=relaxed/simple;
	bh=ImDAJpc9ddBxn/RspOb1AGWqX/jNoxkwypOF+YVbFcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdlDIZongCosn0gQil5K9u70oKM66HtMyWYJ4TWznVMJV0RFomOt+Cnl9FWdt9me21gtJ5yjJgJGSwCOdau0qOCKPzl9KNs8rfQcwUuZ15TaO7nGf9EPdEpDWSF6CswukzH5WgM0oV/vFRZOpABBrcDECdstOtYl8EOYyJ1KeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpwsC0xk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so1224209a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 16:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767919418; x=1768524218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51Qhk2QpnbWrPEp1VkKAc+tmXRgpBzJvdiLMKXqgx5g=;
        b=RpwsC0xkp9rLpmsg2bvNE/bSM6iEBV+x+zCWw3i5omEksd/vTmnE7JskK3S8K8yMOc
         is2ST26zXU08oVq5wL2bK5nNPuw4i9JV8VKFA8a4yKVoj88XnLKMc5rAhiklkFrK0DKy
         w4eFGgAuMPO8s5bnGIRseh2mSzgl0j9PZLsgj7+QfvqFJjUkX8aBbujy+J5VC046LCz2
         bFN7WYBO6PqjO0JldjCqejOjpR8e5hpvlTN3lXRv7rxv0fLCrQ2Y7nRcEe5kPvaITcDg
         pozq7u72ZxWNspFh8pFYH9o3qICzvQ2JvFD1KeDiYjZna7nV3feFyA/Ppn58GMcptqX+
         xlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767919418; x=1768524218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51Qhk2QpnbWrPEp1VkKAc+tmXRgpBzJvdiLMKXqgx5g=;
        b=lF+KjNPCsM9CtOcZPLboj7Y4xPTF3sZzhnURrKXoDRZNo/smAgOvyMgJ8p0GspC8p/
         YKvnHVESkMvsrskOd75wDBF6icG2pgk64m9m2DaEkVl2IAyhcNjnehMCqaLjlGVEGdZh
         PzkWEx/aT675IRIfuJYvqghV0Kt86iwEQMpQOFvtFmOHy7aBlwcyGyVEjzIGO08IMZgZ
         hWYtmdP/a+hqVpSp3zNzJWaubkixEGmi4wQYLElWxP+xBotABOWylsBZ7fdMNNvsXo3b
         P33Ig89bR/Zbhj0QkA7kFQMx+JTbcGdjAXDS8xgUBMYjx5LI4OXvOHgPR+5w96A3x+SU
         BrBw==
X-Forwarded-Encrypted: i=1; AJvYcCVGWpPp+BFjOgGZjwv11coLor+hak9RG/LAso7Iqw4TBqJyDOzfQBOl3htbKOliW/p8+YEh7GBFq0QdcRN2HO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhR1v7qVJx2gdI3GjaigMm2sIKrYzB3gIjnjGEI9qGM1ZiYX2
	vLJGzqf3BrF3ngkxuijGre1R1LIL7PUbTOXloX71jfskVUyaCNnBNtD+HJqeQbIk/g==
X-Gm-Gg: AY/fxX4GDjQIcPpz46etoaBaU6ir/Ex0rCR5jab0z+RgIn21JluC1ZKjvM+o+zwKLDY
	CKQlSnHJ7mdDl7cDbOUhgLGhW3dM431RZnWiQe3Vokfvd25avq96URIefefNpLPdMWfAjrpIHw3
	acf3F8veA0wxnuiUdid0huPK3F8mLMc+jcmIzLhTVfh5SwfgY4nDeaUcUNQEpz2gG8UHtVjqOu+
	9iZXSiwgCyLHEzY6JNPn9IP60wcGIkSn0G7qZlcsXn+VjwgiJm5jAtCZ5aQ6UTHNjb9yQhiItIG
	Kr8WrRClNdF6qI9SFS4KQaF/UovLBOW7TSQ4BdljA7KqHm1vs4RsuM3HLYPXkmfgRCaZIJ329De
	UV/6AU8FKi/Fddb+GzBUbPmMAX5eYP2AzB7fAEJKvkb8ZDBWvLjjSdOygX7144qEV+TlTfupi/n
	idjQWyN7U7a5L+vX1NUgnFgbnNiGShpNu2lh+4BrerOhF2
X-Google-Smtp-Source: AGHT+IFY3AzA/hqaVzD+wKEUy1ckpWYyBi6bM8hjoLRfJLC75Sr8twLClEK01ALzwBO0jLOSqxhH8g==
X-Received: by 2002:a17:90b:568d:b0:343:e692:f8d7 with SMTP id 98e67ed59e1d1-34f68c01825mr7895194a91.11.1767919418342;
        Thu, 08 Jan 2026 16:43:38 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b88d984sm2604341a91.3.2026.01.08.16.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 16:43:37 -0800 (PST)
Date: Fri, 9 Jan 2026 00:43:32 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aWBPNHOsaP1sNvze@google.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
 <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org>
 <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
 <20260108183339.GF545276@ziepe.ca>
 <aWAhuSgEQzr_hzv9@google.com>
 <20260109003621.GG545276@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109003621.GG545276@ziepe.ca>

On 2026-01-08 08:36 PM, Jason Gunthorpe wrote:
> On Thu, Jan 08, 2026 at 09:29:29PM +0000, David Matlack wrote:
> > On 2026-01-08 02:33 PM, Jason Gunthorpe wrote:
> > > On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > > > > Oh, I was thinking about a compatability only flow only in the type 1
> > > > > > emulation that internally magically converts a VMA to a dmabuf, but I
> > > > > > haven't written anything.. It is a bit tricky and the type 1 emulation
> > > > > > has not been as popular as I expected??
> > > > >
> > > > > In part because of this gap, I'd guess.  Thanks,
> > > > 
> > > > Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU is
> > > > another gap I'm aware of.
> > > > vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> > > > fails when IOMMUFD_VFIO_CONTAINER is enabled.
> > > 
> > > What is this? I'm not aware of it..
> > 
> > It's one of the test cases within
> > tools/testing/selftests/vfio/vfio_dma_mapping_test.c.
> > 
> > Here's the output when running with CONFIG_IOMMUFD_VFIO_CONTAINER=y:
> > 
> >   #  RUN           vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap ...
> >   Mapped HVA 0x7f0480000000 (size 0x40000000) at IOVA 0x0
> >   Searching for IOVA 0x0 in /sys/kernel/debug/iommu/intel/0000:6a:01.0/domain_translation_struct
> >   Found IOMMU mappings for IOVA 0x0:
> >   PGD: 0x0000000203475027
> >   P4D: 0x0000000203476027
> >   PUD: 0x0000000203477027
> >   PMD: 0x00000001e7562027
> >   PTE: 0x00000041c0000067
> >   # tools/testing/selftests/vfio/vfio_dma_mapping_test.c:188:dma_map_unmap:Expected 0 (0) == mapping.pte (282394099815)
> >   # dma_map_unmap: Test terminated by assertion
> >   #          FAIL  vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> 
> I can't think of any reason this would fail, I think your tests have
> found a real bug?? Can you check into it, what kernel call fails and
> where does the kernel code come from?

Oh I thought it was by design. This code in iommufd_vfio_set_iommu():

	/*
	 * The difference between TYPE1 and TYPE1v2 is the ability to unmap in
	 * the middle of mapped ranges. This is complicated by huge page support
	 * which creates single large IOPTEs that cannot be split by the iommu
	 * driver. TYPE1 is very old at this point and likely nothing uses it,
	 * however it is simple enough to emulate by simply disabling the
	 * problematic large IOPTEs. Then we can safely unmap within any range.
	 */
	if (type == VFIO_TYPE1_IOMMU)
		rc = iopt_disable_large_pages(&ioas->iopt);

git-blame says some guy named Jason Gunthorpe wrote it :P

> 
> I don't think I can run these tests with the HW I have??

FWIW all you need any PCI device that can be bound to vfio-pci and
mapped by VT-d. This test does not rely on any of the VFIO selftests
drivers to trigger DMA.

