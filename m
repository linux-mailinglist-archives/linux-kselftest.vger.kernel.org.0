Return-Path: <linux-kselftest+bounces-34430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74391AD0A28
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06A83B3AEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1023C506;
	Fri,  6 Jun 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jstj1ls3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB923A98D
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251154; cv=none; b=RNXbuKCBrTcxzter8shsg/Te44LS/cv9Qx7xxmp+eQ11vjpVbm9hyFiMp0sW2pcX76/74dPKsVMePBku2wvkX6lcYFnzN8jewtIk2DfIn/G3q8m/32tYUn4ATQZ7XXL/Z4jedKoZTCNn+ba/qU/DeEV55uNH6BlctK/U0E8cE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251154; c=relaxed/simple;
	bh=MW2wNb43ypWSdufjoPAtH5Ju1OuPQquVw5NL7Ah2DOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu+cQ0+apoJ6lRC2Re/zxxQJ1eVfoGioBqWDweFrUoUc/ZLhjCFQUSmzjJHfdFX6o1tKHj4n/PNQIpKreIm8kOrMN4R8DffX3JFrNY4n1y0j0Pgm0BFfFJLInJXSyJ737bjdYX/wxr0jffBOaQ7wRsSDu+8++8Nf68yrfofUaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jstj1ls3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c4476d381so2385487a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Jun 2025 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749251152; x=1749855952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0KcYnorcCYmwOfCT2vfZqpyW+O1lNC3ODlw57DQvoE=;
        b=jstj1ls37+b0ljHgs1FVN8vUogS6+mRWa6UsUgac1qk0wDCF6HzBMEk40Fem+iJ0dZ
         P4eucJdBHwisN1wEDDZ/XKz/BbbrgIKkEZ0WZVAS4OJuCMkr1y4IBhSBW/rzao4rfwqM
         3v2bB+dq4ErzT5No65utgJd6HoRGkngfibJmLgldKUmajKWoLK2bOw5czOu8pWkLZXlS
         JnyfWIj0M/2YcGbRyAywy/otv97MmykCO8f5x5MDCYRXSO8OnYz6YtLIG+OonSG2uME0
         e1RZAvz+V2pUgZ0diP4GQkMNw9TEjI8noDO/2UOs8W0rSz3TsqEVMrxWlqY4Jv3VPjxb
         TFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749251152; x=1749855952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0KcYnorcCYmwOfCT2vfZqpyW+O1lNC3ODlw57DQvoE=;
        b=L2X3PJqpNubh30KL4PCU4rr2p3NfRq6YJ5eq/CqwYJbktB4Doo5fDaZX6e7RAVPuB3
         pyB4r25G2OtltMyK5frdLnxJ/Co8TfEStEMO+nrCHSMNDXWuNypX9JqQy7BAGL+CYuCW
         SmBMTGnL7teb9WyAvfYdMyaENvTPQqiT7E+8NtRT0e92XQoiWfqaBmot9YlHtboi4EM6
         NEAJRrNSzDJtDozMtwu7QgXIiXN36Gi1gGpRlMUgcSyhlgQ8a1oCC6j2XPwxuCwm83h8
         s55t8HN/NvMocLcnVV4Dme9Q28qdpHxnY0An7xNF470vpH2eBdQ72pw4XaSAGtZ5YRjJ
         InlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrcie4kT0gkPAeBN51HqM4cJ2bFZn/Vr1iZpDcGCcaTSNFShSjd8hh/fZGvo0suf3K4eNbLSDixIo0koHlRDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWgiuPnEZdTt9mY+CBPITNE9RLxhCD4XAcdWnGOaXlhWzRvTU
	/SWvSMC/2gqBzgMq3fXQshqH4ay4OEoCrFHVojn3HOu5QkF/tjqhhPgkW0ZkbmXm3w==
X-Gm-Gg: ASbGncu+uxMY67Tj7xDtaYu1ntxGPzXsIGky6oskzeQKRvJM0BNivg/FtcghCBMoyfA
	I5p3vDFNLWbFIuLK1ZohBWxw3iuhgtuarre4TFF8ffOVs2alimKdhF5Y3duTOE28Q2Ktu7BzCbr
	TYtTyLWLXDRO/2BAdDgFiMDevj1tyUwWLL/OIJ5E0RCI8p8HckIz+O/3xLwGJ4E65E4vK2S8yNS
	IJr63o4C3OPhpwYQEw23c8mAa+bzppkiAKeSgb1BM5en4MwIiuO2kOd8OWsst9oa8VIAdgp+hPY
	eWajKA0fzeSe40Hcc7Vw5UQ0GzT17RgpE+1SMxRaFus+q68Ca5mlmt9U/Z4B5zXpjOLM88XIdga
	YCTZKR9cpnFU7qLBnepxOIz+0
X-Google-Smtp-Source: AGHT+IG7hO9GoY+lsjfIcKo8gdqn8/SJyMesPC+8pn55vRpHA2eE9UpdENnEjjBD2oj6HtS8wcJVKw==
X-Received: by 2002:a17:903:22c5:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2360204d1c3mr66275695ad.2.1749251151608;
        Fri, 06 Jun 2025 16:05:51 -0700 (PDT)
Received: from google.com (111.67.145.34.bc.googleusercontent.com. [34.145.67.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm17399595ad.72.2025.06.06.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:05:50 -0700 (PDT)
Date: Fri, 6 Jun 2025 23:05:46 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 07/33] vfio: selftests: Use command line to set
 hugepage size for DMA mapping test
Message-ID: <aEN0Sr96nyJkN3fL@google.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-8-dmatlack@google.com>
 <20250526171501.GE61950@nvidia.com>
 <CALzav=fxvZNY=nBhDKZP=MGEDx5iGqCi-noDRo3q7eENJ5XBWw@mail.gmail.com>
 <20250530172559.GQ233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530172559.GQ233377@nvidia.com>

On 2025-05-30 02:25 PM, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 09:50:22AM -0700, David Matlack wrote:
> > I'll explore doing this. For a single dimension this looks possible.
> > But for multiple dimensions (e.g. cross product of iommu_mode and
> > backing_src) I don't see a clear way to do it. But that's just after a
> > cursory look.
> 
> Explicitly list all the combinations with macros?
> 
> Enhance the userspace tests allow code to generate the
> variants? Kernel tests can do this:

I got a chance to play around with generating fixture variants today and
eneded up with this, which I think is pretty clean.

tools/testing/selftests/vfio/lib/include/vfio_util.h:

  #define ALL_IOMMU_MODES_VARIANT_ADD(...) \
  __IOMMU_MODE_VARIANT_ADD(vfio_type1_iommu, ##__VA_ARGS__); \
  __IOMMU_MODE_VARIANT_ADD(vfio_type1v2_iommu, ##__VA_ARGS__); \
  __IOMMU_MODE_VARIANT_ADD(iommufd_compat_type1, ##__VA_ARGS__); \
  __IOMMU_MODE_VARIANT_ADD(iommufd_compat_type1v2, ##__VA_ARGS__); \
  __IOMMU_MODE_VARIANT_ADD(iommufd, ##__VA_ARGS__)

tools/testing/selftests/vfio/vfio_dma_mapping_test.c:

  #define __IOMMU_MODE_VARIANT_ADD(_iommu_mode, _name, _size, _mmap_flags)	\
  FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, _iommu_mode ## _name)		\
  {										\
  	.iommu_mode = #_iommu_mode,						\
  	.size = (_size),							\
  	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),		\
  }

  ALL_IOMMU_MODES_VARIANT_ADD(anonymous, 0, 0);
  ALL_IOMMU_MODES_VARIANT_ADD(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
  ALL_IOMMU_MODES_VARIANT_ADD(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);

  #undef __IOMMU_MODE_VARIANT_ADD

Let me know if you think this looks reasonable.

