Return-Path: <linux-kselftest+bounces-48447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9593D007FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 01:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F2E3020C5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4D1E3DF2;
	Thu,  8 Jan 2026 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l7eBb33+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431351C3C1F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833649; cv=none; b=gBNZOn21eo5bTzITVffeSEhig/wjFHNPYsWQf/zvp2Dgch33p93inpSm1SelWEyKhF9krdMJadiEgbkXtES3UeyUV+WiO6tBuwG2rribM1kuuU7bkJtE0H06WxbLWX3ME7FjhQAS2dLCeS3W9hnmyPxZuuEUk3NvJ1wS+1ubiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833649; c=relaxed/simple;
	bh=qkl7DK3BpNF47DqlUVY8OBjoLVg1f80p3hzeztShHy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPl6aAQst2alQTDw26PLbVOF5kgAjXovSFR7p/l7u8Lb9BuSouwfsiuTSiEPRpHIJgcOigQOd03cS05ZDnLg50ikj9yZKRafCeEX0zbwMfw25+qz2GiQi6IwyyMu5dmebg/ju/ZgUAdUGTDbJrP9zfWewmhVyHhyZ3/GU5iquCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l7eBb33+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a367a1dbbso39473636d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 16:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767833647; x=1768438447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zl/wCLSFYxDTasNNIFB7qMIXn4ZfCjA7D6KoNe2mE2Q=;
        b=l7eBb33+ErdcqaeYohuxsJyrZZWB/2cWlSnM4FMY8waLhQukyvymAgVgI21SKtvFEB
         cH7ujbYmBeVbmYG4guQ0+FykwuOX192VG9+YrXo4XWMYPVdVxZ7COS7BNJ/Em9oqT+eT
         JYLA73DI+UDDfeNEIW1j0+MtVTHIh6l95l78qzpGxCpirhzczCQMUk8PRLT70FLLgn2L
         wUUQ13FrV1vliJkqVqkAkPcBLi6btuCWXeqZ+uZdgnvgw0IWPJJjBqwURxEfOD+hiGEf
         GwV2uJGeHhHjf992b6V34cgvpEVJ0NzlJhpWuVegY12RkW74njUvx1M/4V7g9LJMCiUc
         97+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833647; x=1768438447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl/wCLSFYxDTasNNIFB7qMIXn4ZfCjA7D6KoNe2mE2Q=;
        b=mGgcKQZCqxh7s/f41AFvIYFGC3NcbZKjnlU0gX3y5c6aiZ1Aw2lNOn55bLdw3XdmQB
         ulculyuORhhdPuyefcg+qyMxxb/OQtB0oyv5M1cvZJZeoW5PbgYEKQzZgn95sC7iHnhU
         iPBLC9BpOuwfYfszFqrnmSD1hpSdbsFGcf24nAVUv6npFGJ0cKZQXnhonXGmEIOoHfNV
         uf63QG+vIJqLcbHUWH/439aWNqM9K3FIwqBpULuM3xgAGR2LLBSbbvZrPkz80JScps2j
         woh2i9z0HcQtJv46DO5np6GhBYlFIc6GlqZQk9dN3wbDY8+GPUuf6JMWuxR5iKaTEbBy
         9XRA==
X-Forwarded-Encrypted: i=1; AJvYcCWOYwIbL6x8/DasuRzCAqglM6RM8883DEBerF6yeej3YsP3UyYHO79FcG3jczzLAFEk1rwIacYCYF1LknlM1oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG+txjrMdsXtxkEKu1W35KbqEieY9mTRY9FYpvUZd78DffP8+
	yFKrHQ2O9cmvgqleBMuFMW8mLDOmFtXyI/CEl1Q9tAEBg286GZU7FQDt4lfMm/LyA+Q=
X-Gm-Gg: AY/fxX7SGqCtwzavAdMuFODSygEKDW+ei2fzQV1NH0phndeFBD8/DN128PMu2NjQNCO
	gHrF91AeYjVrac/eL7OB7O56dKKDyg7InN7L/olwS0gBfXTCIb54/XVwC/UxW21tLBrsqhU1k4X
	XMPcrChVi0JxyF1NL02O0QRFBmiO7Fz/ZTi6SsiJa8KH/cc+ZOZD6bB2fvCmfZJgs4cXP1lITet
	+1F70IwLYWXS/daF0yR6fGn7kmv8Znceh1OcRVj1bQPZUcAJ9o1/ECEfnmdnLqnjN+E48Xs3+iD
	UXzcn5yKfwv8eN7ELNf0y3+Ho86bkJZYxsUXsBSq3v+qprZyPVmYVeIf4j+uU94SK2s6g2THRSq
	eC/rF02JXtCfKv6lyn3i6YKsY9UL01SUjqKUQtmwghC11yH/CdoSL4RTvxWIpl+ZIRE+QoUB3go
	A/Xs2Ja894eZS1zt3S/d95HsC7Pm/cI1Qp5g9x+7HAXNs147N8i7P/R2PO7FazJAgvH0lzCR2eU
	CKGEw==
X-Google-Smtp-Source: AGHT+IFzwWFM1xm57ldcpfy5lJ/TQeABRvizVWmezixsdp8w652r/WsKLDXS4GvPiS9CZXAymOEobA==
X-Received: by 2002:a05:6214:4a93:b0:88a:7617:6b8c with SMTP id 6a1803df08f44-890842a1684mr68378556d6.48.1767833647102;
        Wed, 07 Jan 2026 16:54:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e217bsm42850346d6.13.2026.01.07.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:54:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdeHu-00000002Hrc-0KPf;
	Wed, 07 Jan 2026 20:54:06 -0400
Date: Wed, 7 Jan 2026 20:54:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108005406.GA545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV7yIchrL3mzNyFO@google.com>

On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> On 2026-01-07 02:13 PM, Alex Mastro wrote:
> > Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.
> 
> Thanks for adding this!
> 
> > Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> > page mappings.
> > 
> > Only vfio_type1 variants are tested; iommufd variants can be added
> > once kernel support lands.
> 
> Are there plans to support mapping BARs via virtual address in iommufd?
> I thought the plan was only to support via dma-bufs. Maybe Jason can
> confirm.

Only dmabuf.

> Assuming not, should we add negative tests here to make sure iommufd
> does not allow mapping BARs?

Yes
 
> And then we can add dma-buf tests in a future commit.

Yes

Jason

