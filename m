Return-Path: <linux-kselftest+bounces-26586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E405DA34F5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241CE1883175
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3526618B;
	Thu, 13 Feb 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UTxDWhaL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4E24BC1D;
	Thu, 13 Feb 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478533; cv=none; b=kljTXWTV91l2YqgpqYOcoyXiwIOBASOhpKWeNDMlbVWIoOmpDWgFYyqXxwZOha7XPAGSBa7kjpNce6nhgXEWbXn4NhyWLxoJ/3E/EqfPEp5VgxT2vB9z45Pz6WHetf0jBa395HJT2qeiQer2G285UZ9qprIt8E5U6y3553Xp3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478533; c=relaxed/simple;
	bh=nknWJ+z0SP3wafNg+nCOAUI+rJEqqS7g4A0g13t8JSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2m9/ZgA8qWWhFJixV6igcQ6p+nNOKIuTGi9DmEEQclnULDr0a7WhugXX5ZxeB3Km8ST3O4lFJXVijhwLQ6U6TXUQxj2poznZT3aTzy8eT8oZUXh/QDpgffvX/y/RVMQ2870H/xrK5cQFGaTr3A0B1k2pJuqGxk0kWbJ7hSjUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UTxDWhaL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8833A203F3CB;
	Thu, 13 Feb 2025 12:28:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8833A203F3CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739478532;
	bh=FVY3r1RNzm3lnez0t18kEbUj6IdxjFad9QEqEvSyVcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=UTxDWhaLmrK+RIBYhfmZlfU+SvrmBBqYQNZoGWEz2tjVzT4yQC7trxO676DR7FvAV
	 1rlxBHV4FCCXWF8M730p8ExNvyaZGgFvqEd6wk9uuSze7bu1RwEhRWtPmYAAvWnkqh
	 oXCBNq0UUKRMd8x9wwBieI4m3gmNo9QULiyx5tt4=
Date: Thu, 13 Feb 2025 12:28:49 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
 <maz@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
 <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>, <yury.norov@gmail.com>,
 <patches@lists.linux.dev>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <20250213122849.34f5d1cb@DESKTOP-0403QTC.>
In-Reply-To: <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
	<a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
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

Hi Nicolin,

On Sat, 8 Feb 2025 01:02:34 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> -					     const void
> *iommu_cookie) +/**
> + * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> + * @msg: MSI message containing target physical address
> + */
Is it IOVA not PA?

> +static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +					     struct msi_msg *msg)
>  {
> -}
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	if (desc->iommu_msi_page_shift) {
> +		u64 msi_iova = desc->iommu_msi_iova
> +			       << desc->iommu_msi_page_shift;
> +
> +		msg->address_hi = upper_32_bits(msi_iova);
> +		msg->address_lo = lower_32_bits(msi_iova) |
> +				  (msg->address_lo &
> +				   ((1 <<
> desc->iommu_msi_page_shift) - 1));
> +	}
>  #endif
> +}

