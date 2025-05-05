Return-Path: <linux-kselftest+bounces-32421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3EAA9B24
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B313BE742
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416426C39A;
	Mon,  5 May 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOwcUnrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBD25C837;
	Mon,  5 May 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468017; cv=none; b=ksonnV3TrrfwnnkK5IOSiBlOK6xEQthB6c/8GXQ75a2aPBnFYfSPcJ9dQYM/O2ahjlFWcT4lW3eL6puMJl02TTRmwKZuuviFcYdR7k1wfm23/aLOKa4ow83PwQ3bcG1n8Xwqro79zmXWa5S37CnidOVJQycYxsXVgVfIeRxRmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468017; c=relaxed/simple;
	bh=SyuJCXGPY7uJmZfwK1Q4fdOdbczqIsfd1IX1yjE334I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBwCEWx5kXCUQMflvuE5+3dWjY2sFsP+FeKput0TMQZqPqYKLqu2UpM80ShFkoSeJn+8ZZoUu6yG34TFfS7593IdgV2kJXJVrfaq3W+uUFRQ1FNLtRDd6HzhwywaD8KV0hF02pjrUftwWNeHOw8kWY7L8ctAUN3TcsOQSr+qpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOwcUnrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D10C4CEE4;
	Mon,  5 May 2025 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746468016;
	bh=SyuJCXGPY7uJmZfwK1Q4fdOdbczqIsfd1IX1yjE334I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOwcUnrq5q/mg7rpZyKzvtUhwljlt1z2mV7oyMHdrSa+bRJh6J7TUnDkQg+/sY3Le
	 VznN/o9/v5135pCRacF9yohdN1gx729n/IC8ni+VZRIMIjB6KliYiwfzhFQKmKi9O9
	 DwbkN8Th/Al/LCHPmrQ7hLxrjocoFALtovqhMc1nAESdI1QR/kEbnnIm/mGoPZeogF
	 gZg1EmQQ+/wrPZGqsW3wJWbAC/bkUOvcBCt1auOJB1+VztIFFHNLcV1n1gHlWcq3km
	 m+NZ7pNXaQpWjBMlyKnX/0gi+9dXmY9jm7ID+uvPzP0lhiYRSYhfJOn6ZfhcNBX3l7
	 wKsbUJ5k/N3lQ==
Date: Mon, 5 May 2025 11:00:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <20250505180009.GA717568@ax162>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <15-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <20250505174458.GA226031@ax162>
 <20250505174747.GA4155135@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505174747.GA4155135@nvidia.com>

On Mon, May 05, 2025 at 02:47:47PM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 10:44:58AM -0700, Nathan Chancellor wrote:
> > On Mon, May 05, 2025 at 11:18:45AM -0300, Jason Gunthorpe wrote:
> > > This intends to have high coverage of the page table format functions and
> > > the IOMMU implementation itself, exercising the various corner cases.
> > > 
> > > The kunit can be run in the kunit framework, using commands like:
> > > 
> > > tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=1 --make_options LLVM_SUFFIX=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> > 
> > Just a small comment about the command:
> > 
> >   --make_options LLVM=1 --make_options LLVM_SUFFIX=-19
> > 
> > can be simplified to just
> > 
> >   --make_options LLVM=-19
> > 
> > You should never need to specify either LLVM_SUFFIX or LLVM_PREFIX.
> 
> Oh wow, I had no idea. Can I encourage you to send a patch for 'make
> help' to explain how to use it?

I will see if I can come up with something concise for 'make help' but
we have it written up in Documentation/kbuild/llvm.rst:

https://docs.kernel.org/kbuild/llvm.html

Cheers,
Nathan

