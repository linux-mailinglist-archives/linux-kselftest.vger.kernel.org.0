Return-Path: <linux-kselftest+bounces-48574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65784D069EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 01:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4782B3010E59
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB715A85A;
	Fri,  9 Jan 2026 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QleLx14W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7181F95C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767918985; cv=none; b=lAyvusevoNdPuGCjX/nFY2tnZT6GJwBHQ046Qvqqj07T47hOAh3M/NacnrajLePwsSwQgk2jfGzSrDgHOKw2zMOnMWc2W8wH6UASrLxJ/LYm3gnYPoZaxbyjTIDwVboM2OdSoIX+5Yi1uEFNpxtGzDfU/8eBKqTYqiXFgqaxvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767918985; c=relaxed/simple;
	bh=HSbyzJte7ef9LUSwX8ZKl4Km7f9/oIn4+KkoGy1YFfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZSqFlZn6A9SIlhw6hOTy8pRJtgxWNZJdvm9O/0QVe144hyt9gIPeIfKn1RzQFhaHbNDhZGnmJZWnQDyj27fN53c8XXsrB2yAVSznuBhJGGEYDVZxoAipg+J94wdl3jO28mJ1h0E01sNh5bI66BEYCnJ2MYgy4kmbGnCMLse48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QleLx14W; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88fe44cce7eso30512626d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767918983; x=1768523783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akXataDrrm2I8aSPYbuC2L/r92iwVSgkWRP1kilxNcE=;
        b=QleLx14W8+B1sjcbDSeHYPuLmdRPt64TE4pSsYuMOogdNbj5w0gjjjMdVDbSWS/xxW
         cWhcMj44zUdkiTADW28uJ8i8I9MahK1tdkwcXADKhbbF+H1cqo2a4WKG9LepEgWPFFjI
         IpqNvBl6nsvEdB7yNmMc2wJep5ad6xW4wEUoP9q4gu81oJt42MVN90lPSV4hxOtfbdlX
         PPb6vYbZSIjNU2hiJ6TYNNYA/fiJkh4Ck53VKP7VK1JABgAfvphXZMs6bwyaOR8yqzAf
         pSc/YcT/ORcOxS+SP/R05iaeYZxV9bV6BLawGzZbERjmsTvrOed2nl16kFGcXtPcDh16
         tB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767918983; x=1768523783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akXataDrrm2I8aSPYbuC2L/r92iwVSgkWRP1kilxNcE=;
        b=Cw1+E83TyNEE7xi8FgJjKoLVIbQL8xbMvMck3gMm4vqsKqQ7N9PVijBdOirMuRLZqH
         vNg9cVOzUYxaYqONhEvH/ARWThTJa+cl4JyGwlRQiq4L3CLpS/twqy8pdaw5cZiCIbG+
         v4lKcdMSAuhl/zd/2erEQWGj7T0Bm5pSWsOi4yrme5eUw+h65kJDFVVTynzJfurH7dCw
         vrTXTyzuGbzAGouzr4WqJ85nEl/7rsKZ4vMZFdPRDDPgUbVwHQqiCJ7JdTtD9fa9WoIz
         Y4WiC9I8eUl9NxFnIAdDnQ3a/rzpn5c19tNbn4M7MnE2YYUaOVcJ1JcDuDdyeB40YBD4
         Kmkg==
X-Forwarded-Encrypted: i=1; AJvYcCUbb5fG0C0sjYEZYhSibBcm+Zii9ERFw1c6yfwAI31KIaM6nfpOOXyvObCSFB8ATmMgE2jX0ZkIQCTIiocmxiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/fAqkQy4Myq38DBPv8jE6EiYgcTOkQertDgFPJZOwLzra5Gp
	Phrxhd7xwizAWCrAL9TO6ZIY0bHgUFIkfLR0XQJCh14aeKFRLnYnBdGDKGlzM5xtQlg=
X-Gm-Gg: AY/fxX5T1DVvNykf//6cG0PUJOmuHbb6jvnMtCidp2Zvttnljv8Hb0OGyJv4LOJHeUA
	/1EVSrg/AQpASkjBVo/qe7/zetqBG2NEKYi6u9wCRo2SH/C1me1qZJdJ8g3tBkQPqwVg1bHgwLR
	LYm29AopsobssiAWgS3wiCzxItDbn7jtsrAw0D4kBV1H0myoXfYdlNAIXmLJzAyffYKtmafx25G
	T2DYwxJqRsrnTd1C1YngLdr8/yeKbHci9/o4HUW4BpnTCQd6QSnGFMBD/pz3qE539wMZxadeph/
	un9NPy9SV79hBNh2NMSDRPb+3MceI6ue/8Z6CBHtT/MNuhluSZG6nQylhO61GkTCEmiN7GZ4H2C
	zsc4IhXTxr+NEfAwjlSXxznByMNH2760C7dujg923AEnX8GX6/J4Ho6Ve7AeyF673xxfEurmiy2
	c7Lj7W1qadW1+wm95wyQnZXB3Q9z9r36vBKN6JYYPziSnfRGEjo/51PzhkpYAUBrldV3i0ylhKc
	3HqrA==
X-Google-Smtp-Source: AGHT+IHmWhRihsDEqETUF+e9G1AVgeqEhpLtMexa+k8HuoAsY94LO++GxPutVwxZ0KIRKX6KuiPb9Q==
X-Received: by 2002:ac8:5785:0:b0:4e8:9920:be58 with SMTP id d75a77b69052e-4ffb456fd65mr100400051cf.0.1767918982598;
        Thu, 08 Jan 2026 16:36:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e6257esm57727181cf.31.2026.01.08.16.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 16:36:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ve0UH-00000002vXg-1uqs;
	Thu, 08 Jan 2026 20:36:21 -0400
Date: Thu, 8 Jan 2026 20:36:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260109003621.GG545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
 <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org>
 <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
 <20260108183339.GF545276@ziepe.ca>
 <aWAhuSgEQzr_hzv9@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWAhuSgEQzr_hzv9@google.com>

On Thu, Jan 08, 2026 at 09:29:29PM +0000, David Matlack wrote:
> On 2026-01-08 02:33 PM, Jason Gunthorpe wrote:
> > On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > > > Oh, I was thinking about a compatability only flow only in the type 1
> > > > > emulation that internally magically converts a VMA to a dmabuf, but I
> > > > > haven't written anything.. It is a bit tricky and the type 1 emulation
> > > > > has not been as popular as I expected??
> > > >
> > > > In part because of this gap, I'd guess.  Thanks,
> > > 
> > > Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU is
> > > another gap I'm aware of.
> > > vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> > > fails when IOMMUFD_VFIO_CONTAINER is enabled.
> > 
> > What is this? I'm not aware of it..
> 
> It's one of the test cases within
> tools/testing/selftests/vfio/vfio_dma_mapping_test.c.
> 
> Here's the output when running with CONFIG_IOMMUFD_VFIO_CONTAINER=y:
> 
>   #  RUN           vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap ...
>   Mapped HVA 0x7f0480000000 (size 0x40000000) at IOVA 0x0
>   Searching for IOVA 0x0 in /sys/kernel/debug/iommu/intel/0000:6a:01.0/domain_translation_struct
>   Found IOMMU mappings for IOVA 0x0:
>   PGD: 0x0000000203475027
>   P4D: 0x0000000203476027
>   PUD: 0x0000000203477027
>   PMD: 0x00000001e7562027
>   PTE: 0x00000041c0000067
>   # tools/testing/selftests/vfio/vfio_dma_mapping_test.c:188:dma_map_unmap:Expected 0 (0) == mapping.pte (282394099815)
>   # dma_map_unmap: Test terminated by assertion
>   #          FAIL  vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap

I can't think of any reason this would fail, I think your tests have
found a real bug?? Can you check into it, what kernel call fails and
where does the kernel code come from?

I don't think I can run these tests with the HW I have??

Jason

