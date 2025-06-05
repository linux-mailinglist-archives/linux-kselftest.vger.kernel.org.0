Return-Path: <linux-kselftest+bounces-34407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD4ACF919
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 23:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D243A3AFF0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39D27CCEA;
	Thu,  5 Jun 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cD7s8vD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75927452;
	Thu,  5 Jun 2025 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157448; cv=none; b=e2ATYI2lORvTE5eMgORlc5VCzLeNKe2zHekf/RYBUe1Qxl5wJBzIr2WiEITI7z9ptK4GwKdxIs/2BIpl3Q9R7UX3rY7oEG/RXPpZR6CM7Y5Ch7gJdKAWEvfBubC6SXCEQV+7DssJTjQdvwDNEQiry4IHRGk0nGv+I2TuU0jssRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157448; c=relaxed/simple;
	bh=5z4lyN6eFPIUIuW6ETWM+sIFBqvUb6kdsqF23bzMXIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx9MWYnh8TJkgyXsnR8JlBij0O0tl+mnZTxvbBjymSoCKCGiQw2jG53Jp2QiTxULSRt+XDGTHIbnU+Bn/uzxRywK1cp63+v2jt3QMxbZH/CtRi9G+rXieOvHiZ4Y/QnqMZLpOSRGViFA/xqG9OB9TInUBk399cMqgUc6zn6Y75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cD7s8vD0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8450D210D0C2;
	Thu,  5 Jun 2025 14:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8450D210D0C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749157441;
	bh=Gund+dK5aJW6UtaEJ+x2rgplZpVnxwe1S5F5gyh6HAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=cD7s8vD0a0AfPh3ebIr231hpAoYtxnmr5f0EAkqfQvSQ1jXXObO60Olle7BNyh26Y
	 PQSAfLA3l+EG5LI4UboSinv7mYXWDeCbzO5VLzMylLYL36WykSm86yqe0ISRwemYjE
	 RuzFbs8q4U3a2qW3X85abq+4uV8QpooHP9orWnmw=
Date: Thu, 5 Jun 2025 14:03:58 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
 <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, Bill Wendling
 <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon
 <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>,
 Michael Roth <michael.roth@amd.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 12/15] iommupt: Add the x86 64 bit page table format
Message-ID: <20250605140358.2dd6c083@DESKTOP-0403QTC.>
In-Reply-To: <12-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
	<12-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon,  5 May 2025 11:18:42 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> +config IOMMU_PT_X86_64
> +       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	default n
> +	help
> +	  iommu_domain implementation for the x86 64 bit 4/5 level
> page table.
> +	  It supports 4K/2M/1G page sizes and can decode a sign
> extended
> +	  portion of the 64 bit IOVA space.
> +
> +	  Selected automatically by an IOMMU driver that uses this
> format. +
>  config IOMMU_PT_KUNIT_TEST
>  	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
>  	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
> +	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
Is this intended? or you mean:
depends on IOMMU_PT_X86_64 || IOMMU_PT_AMDV1

