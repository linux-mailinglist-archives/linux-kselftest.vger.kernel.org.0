Return-Path: <linux-kselftest+bounces-48576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D2D06A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 01:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E144D3038941
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D1F130B;
	Fri,  9 Jan 2026 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ggX30qBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71841E633C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920084; cv=none; b=dXXRtQ1dMSjSPSIzofnwiMQzvR0L83IPpIpWQxOIS+cIi/tQoXfoE8wHBLPE07dJbQ/65d+vZmuAZ1JmrN/IhjwXm1f+/lpw5Q5TJOtQmODAZfb40Fk67mbhBFRRBbW8/A+tpgmn7yZhU4pAMj49EmNZnd1BBFyOD0YgJzgbnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920084; c=relaxed/simple;
	bh=U+ERXgUfSRxYcQMpnmJcQtwAEw2tC+IRhF/3sM+ULAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/eXHs/hmLwQ+Gz5c0S5VpSVc9++6sp7V9aTQHHGq+6ZsqTAbyFxOY9rSEIsssqDaOvl6YNKEzyjgiRkqUZkqSDyuDYBNohpB+r9yapOPnHEC5FO4Jm2F6JrPgGshcxjXYzty3w8OlLljuGQLOtcJPYaepUneyLWhPHVPFxL1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ggX30qBi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2f2e5445so43739206d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 16:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767920082; x=1768524882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAZE/20dBWNTVWUx21XoEWWGeB11q9XckqXbeOgh60E=;
        b=ggX30qBiAA8FaTfWYEYTd5EVPvdmBPZZ6h4Fzhli80Hv/xquejjv4DN09tgGqAvd1y
         yAec770oyGkerbMoZxppKuWLybqrpqz3eU4ml/98fCnvuKO36Za7g4bdnyXAM247sZor
         qSUPOtjBCkrxaXONgBm5oZBIvj4McFWA62b6PeasVvYNnG1QTKH5Gw8uOCMlAyVYNWTU
         xC/ld2DlyymkCDkMBf4KZ1KzJWmHWTMvTe1xeZujFsL1AASI3zXTwp/PncVOgIeToS9s
         1Ei8ETUnTti6nu9Gs281fX3h6wmnHZtyIixVcYSbES5jyy+XBepBS5atgox2y4tDn+HD
         KQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920082; x=1768524882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAZE/20dBWNTVWUx21XoEWWGeB11q9XckqXbeOgh60E=;
        b=elsljxURQNoyD97dvCZfhbfxcr+9Rj8MUOeW2z34C81Lo6jqL9Dyfu/41tTwYlXqOD
         7k7WBou0rr7QAbo0pnMc1k/ChBGIbXfN+vpYrrF0ffBf6Bin4ip30fyMLJk4VaDHrE4A
         UnOdMprSN7L7rt12wNhTv05mH7FCbhqxu99uHW1kRwTxzn+Hj+KjwdlViSS8mV0xqxTR
         O+6XtYUhNslWRMAdLyNdxFc9uWIlxlc/4Qnkq8fOJsLpx0halzSYCSz2xtrh+kuFDiIM
         DTunDxyb+p5gWraIQ7967wPLoKVE85dJn1/T/dhFXuRWz+BjXLrMg1BKFzZW4vYEjqum
         BiNg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/kJPr+p7y4cI3KaqUAifYQZHR9bQM8IOqvBRNnZl5j20n8d1a8ESmbtx1NKD8+mBttA4X/KeGnNImkBqVkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekQ0Sd+DvBOFpk8Aylp/PN+WX+rwKDLdTIQPNfq6TCimdmFm9
	rLSn3YJI6hWTGvPGZ3Q31rinAHLDHr4gKcZDzcv7Wb9JrQL4NPv+glOr7JTN8qSQiez7hBwci6Q
	Qiku9
X-Gm-Gg: AY/fxX5u8YS/bUHYfBJ7X+yPFNR1xkOFBhpkAynwgbf03uGVDAOnV6sHmbcyZu2G/x1
	1r5sBlRUVzReYNbKR9+kASbj6Busi4y8Pb+ghp7+lOZlu9cSMSBItMgCZLMkhDu1/9jI0qpMtKU
	LLbgphy1N3kwSw9PQ8VKJKjhh7EjLMpoaxDQdJo8pNfcgVvAjhXkXmPfHlMhF/flzrRGpXHnh1I
	0Vuit491i5oyDlwXIuOpByO3S8EBHwULhk39S2PCQqvMAMaXRE9K219/BUIYDlqlAyMSYDlbIvs
	ZOMMfMGz2JjoniU25LuACK8sYx/oEFYNt0M05+JqD/ngeFgeHU9Qe+6N2JjJ6XufliyJ1ou3PRx
	zs0S/7BF+H9qXKDZ3EpzD/McHrPPBw+fJTXNN+JxbSq/iH3JkYJnoHArw35oPjrohujyoQQoj84
	LTcn+FMsV+kchFYGGcfqbAF8Uq8g+4k/y8jPTotYxKEtzLtjF++o4C5G5axbLK9dz8YjY=
X-Google-Smtp-Source: AGHT+IEZs++vifxK2irZp/20XefsAkmL6blTJ2OewTq/V0KD+K9JOYPvZ0wrg4AeAg9Aq7isQibh6Q==
X-Received: by 2002:a05:6214:4509:b0:88a:3c0e:3251 with SMTP id 6a1803df08f44-8908425445emr106914126d6.32.1767920081945;
        Thu, 08 Jan 2026 16:54:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726041fsm67934866d6.45.2026.01.08.16.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 16:54:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ve0m0-00000002vlZ-3hDX;
	Thu, 08 Jan 2026 20:54:40 -0400
Date: Thu, 8 Jan 2026 20:54:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260109005440.GH545276@ziepe.ca>
References: <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
 <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org>
 <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
 <20260108183339.GF545276@ziepe.ca>
 <aWAhuSgEQzr_hzv9@google.com>
 <20260109003621.GG545276@ziepe.ca>
 <aWBPNHOsaP1sNvze@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWBPNHOsaP1sNvze@google.com>

On Fri, Jan 09, 2026 at 12:43:32AM +0000, David Matlack wrote:
> On 2026-01-08 08:36 PM, Jason Gunthorpe wrote:
> > On Thu, Jan 08, 2026 at 09:29:29PM +0000, David Matlack wrote:
> > > On 2026-01-08 02:33 PM, Jason Gunthorpe wrote:
> > > > On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > > > > > Oh, I was thinking about a compatability only flow only in the type 1
> > > > > > > emulation that internally magically converts a VMA to a dmabuf, but I
> > > > > > > haven't written anything.. It is a bit tricky and the type 1 emulation
> > > > > > > has not been as popular as I expected??
> > > > > >
> > > > > > In part because of this gap, I'd guess.  Thanks,
> > > > > 
> > > > > Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU is
> > > > > another gap I'm aware of.
> > > > > vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> > > > > fails when IOMMUFD_VFIO_CONTAINER is enabled.
> > > > 
> > > > What is this? I'm not aware of it..
> > > 
> > > It's one of the test cases within
> > > tools/testing/selftests/vfio/vfio_dma_mapping_test.c.
> > > 
> > > Here's the output when running with CONFIG_IOMMUFD_VFIO_CONTAINER=y:
> > > 
> > >   #  RUN           vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap ...
> > >   Mapped HVA 0x7f0480000000 (size 0x40000000) at IOVA 0x0
> > >   Searching for IOVA 0x0 in /sys/kernel/debug/iommu/intel/0000:6a:01.0/domain_translation_struct
> > >   Found IOMMU mappings for IOVA 0x0:
> > >   PGD: 0x0000000203475027
> > >   P4D: 0x0000000203476027
> > >   PUD: 0x0000000203477027
> > >   PMD: 0x00000001e7562027
> > >   PTE: 0x00000041c0000067
> > >   # tools/testing/selftests/vfio/vfio_dma_mapping_test.c:188:dma_map_unmap:Expected 0 (0) == mapping.pte (282394099815)
> > >   # dma_map_unmap: Test terminated by assertion
> > >   #          FAIL  vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> > 
> > I can't think of any reason this would fail, I think your tests have
> > found a real bug?? Can you check into it, what kernel call fails and
> > where does the kernel code come from?
> 
> Oh I thought it was by design. This code in iommufd_vfio_set_iommu():
> 
> 	/*
> 	 * The difference between TYPE1 and TYPE1v2 is the ability to unmap in
> 	 * the middle of mapped ranges. This is complicated by huge page support
> 	 * which creates single large IOPTEs that cannot be split by the iommu
> 	 * driver. TYPE1 is very old at this point and likely nothing uses it,
> 	 * however it is simple enough to emulate by simply disabling the
> 	 * problematic large IOPTEs. Then we can safely unmap within any range.
> 	 */
> 	if (type == VFIO_TYPE1_IOMMU)
> 		rc = iopt_disable_large_pages(&ioas->iopt);
> 
> git-blame says some guy named Jason Gunthorpe wrote it :P

Er, maybe I mis understood the output then?

This is not a "failure" though, the map succeeded and gave a small
page mapping.

This is not reflecting a bug in iommufd but a bug in the TYPE1 support
in VFIO itself because it definitely cannot maintain the required
unmap anywhere semantic if it mapped in a 1G huge page like this.

Basically, if you are mapping with TYPE1 mode then this should be triggered:

        if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
                mapping_size = SZ_4K;

And VFIO should be the one to fail, not iommufd.

If you really want to test TYPE1 you need to test what makes it
unique, which is that you can map any VMA and then unmap any slice of
it. Including within what should otherwise be a 1G page.

But I doubt anyone cares enough to fix this, so just exclude
VFIO_TYPE1_IOMMU from this test?

Jason

