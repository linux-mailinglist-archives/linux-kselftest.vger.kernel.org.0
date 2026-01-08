Return-Path: <linux-kselftest+bounces-48560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69ED06516
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 22:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAB23010A87
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384E337B8E;
	Thu,  8 Jan 2026 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uu+sGzHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741143358D3
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907776; cv=none; b=eZIJl8dFYkGBGxrtu5RWF6FTNQd1skQvnRZxriT8aUsWi2n+R8auWTTPkU7FXbQITeqA9CrN0LmiWEKcmwmmGJu0lvUyQQUf74zc0Dzy2KVE5Tgu0xtn2+OYw1xpm9lqthXWA1in3TbLfVJr0ZcpIrEm+0vxjg3guV7jiaq63+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907776; c=relaxed/simple;
	bh=V8aaW2wlWIxBYmN1io/X6lniPwIvDQZMjId6cleyTII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnW04YOexkCdg2swzc5RdbZbGsoVGpjXxSk/z/TnH3RNC79Ow/yV5S3NW5qkc+T3S+Sy/ttwGV53gwSpqlKQCjeknmFRUBmGq8qn2zhuEYNBhzaG53B/pgcBfEqgcc0U/TPWmSd6BRZ8Hfa+p8dIr1e/gRchYmWlaoPPzd5CS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uu+sGzHE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a099233e8dso26800765ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767907775; x=1768512575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UQGShhuDSY7VMtoaHlIJU7v//N/6s3YoH997K8k7n0=;
        b=uu+sGzHE6aM+8cKRR1irD44NEx5mZQnSaFZL1mAkZHh5VpKaWZ8rxJiyq0VL4xoFiR
         wU58V2dyjGDL7d4XaG4/hhEsiMt9xiI09TsEMwaUFTHdDYdxy3HD7kOc3zHInhzke2TO
         hbmdEOWAgxDocDtCdbJ2/h/S55xZeF1VuEdQuz7zaFpcepTKOFZrDFgDyLS7CIIW+pIZ
         OZemiNJybtVIlcdAP65t2ai7cDC5jEH8LjIy+SOR/jxIRr2B4JXv9e8yrOk4fRMwslE4
         ae1rWIWSC/wnaSpA94XhsePJ9wovbA8xNityX7vEI7jabTc/D8X1qlrjtpL5UesvPtGs
         vf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907775; x=1768512575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UQGShhuDSY7VMtoaHlIJU7v//N/6s3YoH997K8k7n0=;
        b=YVnYC1vZUMEUrKoYNPeHlFS/O7ZPTR5syL9BoNyCN7eJWFROMcv8SGeF4Nz/tCnF7A
         os5ksBi8wdZQF4J8UpLDWqYypdpSY2oGFx1ShaNWCFbN8nqFSJhm/S9S6rwNqkrsFD5U
         VS+pt4iTVfTZELY1TK8SJ4EfAxSy6Lc8yZEtPvjeY45DDCKg7TkQr3Kzg7WG0SBxVCPm
         8fEBoII+LMSarYOYt79Hdokgr1rZqbYV0L09QTLGkbX7rZbcZp4HlL9hy+RPFpKXpvT7
         BJ3CU3RFXQwh0Y7LPpBVL39t+f661rNCo/eeisYN9zG7MegHJDnT4VAYu/RtKKgPIoUN
         m1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUwxsnyxAlD7bhR43D33vVkNozJQMx2GjtotS6nOtZ+XfWUQIy+cnkDWz925vCCU6C/qYhutFHBDKp9VlR5ZOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9m1diWGNT1VYv2vKgRPdtATosSZQ+Y85Y8dlcd9oKjFDACnY2
	fxRl6o1r2AkfU5JbdVh5E30kSkj3kCDDgy5bRUwwGE2gjcJXd9tVSTALX8sTJmSvqw==
X-Gm-Gg: AY/fxX49fr9jT9AgTqMs3LR/ozHh2ANToGcsH4Mm7ndd4dhEALtaeVZLdbmIAb/oX29
	gs7O3EcHQBC8gd8h1s6H7gbECbZLEN9TxDACFM+iJbg8O5h9ybsbtQ67oR3I4LYIoNLvW1YfdVk
	MtHaqtfc12wNq6mqGT0pi4vt2YPfYC4DJekieTahrcNMFJA/Xbrxc6fpLesSCmzWvv88zAikyDy
	7LpuGCbeUhr7ySTuyf41YGZloB0WWYKFdDUkdfabn50HYnqyb+PlxEyE+aXQJtVm9RtQMH35+p3
	fFc8Ax48hSrMstrCBf49jr/qFiki8qO8RR66oefIMk9dr/ZfTrXk5aGchZ77RSAi2IoOygc1Lma
	0DAPy8DvT/reGUQ6ypP/ALxXeUvt4dq4TNoX7FMDNvEgBwZzHRVUk/fVpT2hS2XampFZk5bFd7V
	Zk3H9F4BazsMqjJ13BSmPphlvQ1jbYqFef6d/EmL0PoOGb
X-Google-Smtp-Source: AGHT+IG8G3Re0NFNu3C4hZ7C7HNKESD16GY55MKYmgCs1doiEwN9AfvbG7NZlPjwL3+jqLpFkECpHA==
X-Received: by 2002:a17:902:cf05:b0:294:f1fa:9097 with SMTP id d9443c01a7336-2a3ee4900a3mr67869205ad.34.1767907774415;
        Thu, 08 Jan 2026 13:29:34 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ceeasm85964085ad.45.2026.01.08.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 13:29:33 -0800 (PST)
Date: Thu, 8 Jan 2026 21:29:29 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <aWAhuSgEQzr_hzv9@google.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
 <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org>
 <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
 <20260108183339.GF545276@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108183339.GF545276@ziepe.ca>

On 2026-01-08 02:33 PM, Jason Gunthorpe wrote:
> On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > > Oh, I was thinking about a compatability only flow only in the type 1
> > > > emulation that internally magically converts a VMA to a dmabuf, but I
> > > > haven't written anything.. It is a bit tricky and the type 1 emulation
> > > > has not been as popular as I expected??
> > >
> > > In part because of this gap, I'd guess.  Thanks,
> > 
> > Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU is
> > another gap I'm aware of.
> > vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap
> > fails when IOMMUFD_VFIO_CONTAINER is enabled.
> 
> What is this? I'm not aware of it..

It's one of the test cases within
tools/testing/selftests/vfio/vfio_dma_mapping_test.c.

Here's the output when running with CONFIG_IOMMUFD_VFIO_CONTAINER=y:

  #  RUN           vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap ...
  Mapped HVA 0x7f0480000000 (size 0x40000000) at IOVA 0x0
  Searching for IOVA 0x0 in /sys/kernel/debug/iommu/intel/0000:6a:01.0/domain_translation_struct
  Found IOMMU mappings for IOVA 0x0:
  PGD: 0x0000000203475027
  P4D: 0x0000000203476027
  PUD: 0x0000000203477027
  PMD: 0x00000001e7562027
  PTE: 0x00000041c0000067
  # tools/testing/selftests/vfio/vfio_dma_mapping_test.c:188:dma_map_unmap:Expected 0 (0) == mapping.pte (282394099815)
  # dma_map_unmap: Test terminated by assertion
  #          FAIL  vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dma_map_unmap

