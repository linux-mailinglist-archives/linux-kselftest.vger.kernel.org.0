Return-Path: <linux-kselftest+bounces-44773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6435C336CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 00:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80A124EDDBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400434B19B;
	Tue,  4 Nov 2025 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3qF+QSD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5372605;
	Tue,  4 Nov 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300149; cv=none; b=RcIfzM5svmvJnY/fAP310PsQJtem2A5N99jIG2U4Wp+/0TFssPTwOek0hpqvIQX01LqFxbCeMDgRo5aPleR7kDvofDMblsj1T/VGpUzFKIdi9+Rx22uz1cG5CroDXDmSsc0V6TkDC638vUDSFhY8NIfZvIInZ3zoQas2rHBE+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300149; c=relaxed/simple;
	bh=Uv2GCoeYI+xVlJW1KgNgqJt6+DR1iHLTRs5Iv9bYUac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6hS4OOlXn5fa/apc/ZqjpKuRN8z0n7GWbd+1DLJtvDnBp/z5099eCQeDuGRYfhMsOYhnojXc6nyx0/ssxQ5cvSamXdzP6xN2WTU27+5CnaVCsbF4F8DTSQ8lr3OuMSSY9opYyTejyr/iT+Nsbb189zBlk6AHbBAc1sGWU9gSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G3qF+QSD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=i63ehnnei9rWKWA2KJKI+guZ6phgMXfdcjPHS44W+e4=; b=G3qF+QSDeoGS+uQDnZMmZyNeAE
	dqCrbZhSh6FKZyMmmZlDSCXvAES/Azg+e+yhoGgNkuAWhwT4/bl5Qvcu0k+GQL6UCLwFzVWFyFhK1
	sSO+nca2ORM8u+BefKCO7ursEpUI4ZlP4wE1KGkTRtiLb1nKRiYY/qC16v9k9QvSUxrcu9pV/ijwo
	icaBxLI+7xF1CRYoOjLaKSEV9HpFG5qDNndeq+I8ejUFF/7vpnerTPu97vkAkuN0l6BeMxy0213+i
	UCBSohVjzv4jX4Amq/POD8tK48QlWq+x4XzBsa5NSea8y0Tj1ci1aL+Y/hUZZ2pGZyZcWEhqi1Nsx
	NdBeN8VA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQls-0000000CliN-0MMY;
	Tue, 04 Nov 2025 23:49:04 +0000
Message-ID: <0792f0d8-0ce5-4858-baa9-c76154c9fc9b@infradead.org>
Date: Tue, 4 Nov 2025 15:49:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] genpt: Add Documentation/ files
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <2-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> Add some general description and pull in the kdoc comments from the source
> file to index most of the useful functions.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/driver-api/generic_pt.rst | 142 ++++++++++++++++++++++++
>  Documentation/driver-api/index.rst      |   1 +
>  2 files changed, 143 insertions(+)
>  create mode 100644 Documentation/driver-api/generic_pt.rst
> 
> diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
> new file mode 100644
> index 00000000000000..210d1229aa1c1f
> --- /dev/null
> +++ b/Documentation/driver-api/generic_pt.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +Generic Radix Page Table
> +========================
> +
> +.. kernel-doc:: include/linux/generic_pt/common.h
> +	:doc: Generic Radix Page Table
> +
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
> +	:doc: Generic Page Table Language
> +
> +-----
> +Usage
> +-----

See Documentations/doc-guide/sphinx.rst for the usual order
of heading adornments. Section beginning:

* Please stick to this order of heading adornments:

-- 
~Randy


