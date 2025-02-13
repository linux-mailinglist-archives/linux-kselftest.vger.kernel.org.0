Return-Path: <linux-kselftest+bounces-26542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7EA33EDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B877A43C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456B21D3F7;
	Thu, 13 Feb 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rmp5Exz8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0Z7BaOI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690A227EBE;
	Thu, 13 Feb 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448715; cv=none; b=O9+vxm42oXoIrIHCYUxEFZx3Ql1M0Zg/emNsW0H8vDD4G5iMq11OeCBNtkPTc3VUYPC2BTcMOkN8xutBO6EYZKg9H1z2S9BHuqXLnc7KQ+fTWfcaVgVdvwFhCHgiDyCESw+WiECl3ARYoQZGjSlPEsg2z4IZHH8B/H9MlkqAVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448715; c=relaxed/simple;
	bh=/+89HoxCR4P4bed6CdrcvksQl9SDCWv/He6EHKr8h/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzLURiUTmPskcv709kFInM47/Sok2LMoF9RYyhWKVRZduDOp89MrqYBLPgHP/SEH4HFjbd8WqsgqxYG9NIi6J5pI6gP73n1nNptRpo2XnJRxfufS5RlW2Box4ggh3v3JKHKBdhTFXmXMqgW9JsPqZudl2h9rUBdx59+lQ4XVkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rmp5Exz8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0Z7BaOI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739448697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3WCJyWHDo+iDYPmzNhUzFQSCU4PUPzZ8RBmSh5HlJo=;
	b=rmp5Exz8cDlyq2mtNnojNZqj7ZYko62PkYV3fFrSxq1Pna8q2IvK8E+v+gOW6NPZe3H/fm
	v/gtkPMIycGTOD7g5TCR12qEEc2t80l1kfok3Rr5lARpVi1Qol6Y/Sd07nLa3zrHO6P1uD
	O50ktZZ45CICbk5q7TDmQxGrtDowNsPOJGJn6yqOoBZIyKLUQ1hKtFRi6eLnOvEEHjww2q
	SwW7fGiysuI7EIJ/+QezmN6TjL+mWqU/MiABFTbAn3252BVLG630/SZ+iFVnkC6NPoWd6Z
	Q287nrW++IPa7QsqN/YAg8D4x2PbuybqPVxZJiezEtw2anHAwj18WosJkR1zeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739448697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3WCJyWHDo+iDYPmzNhUzFQSCU4PUPzZ8RBmSh5HlJo=;
	b=Y0Z7BaOIti331G1gEPWryQVQcDyrmBsKbcJIPPOQl1tBPL9Xa9fzRGB6QnuJbUWt05xtY/
	rPv67jYIe0eMiYCg==
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
 kevin.tian@intel.com, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com,
 patches@lists.linux.dev
Subject: Re: [PATCH v1 02/13] genirq/msi: Rename iommu_dma_compose_msi_msg()
 to msi_msg_set_addr()
In-Reply-To: <0cfaefcc104e29aeb031f316537249d8d53ef7fa.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <0cfaefcc104e29aeb031f316537249d8d53ef7fa.1739005085.git.nicolinc@nvidia.com>
Date: Thu, 13 Feb 2025 13:11:37 +0100
Message-ID: <87v7tejb7q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 08 2025 at 01:02, Nicolin Chen wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
>
> The new function is used to take in a u64 MSI address and store it in the

Which new function? The subject claims this is a rename. That's
confusing at best.

> msi_msg. If the iommu has provided an alternative address then that is
> replaced instead.
>
> All callers have a tidy u64 already so this also consolidates the repeated
> low/high code into a small helper.

Now I'm really confused. Something like:

    genirq/msi: Refactor iommu_dma_compose_msi_msg()

    The call sites of iommu_dma_compose_msi_msg() have the following
    pattern:

      1) Set the MSI message address to the non-translated address

      2) Invoke iommu_dma_compose_msi_msg() to apply IOVA translation if
         available.

    Rework and rename iommu_dma_compose_msi_msg() to handles both
    address set up variants in one consolidated helper.

Or something to that effect.

> -/**
> - * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> - * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> - * @msg: MSI message containing target physical address
> - */

Please keep and rework the documentation comment.

> -static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> -					     struct msi_msg *msg)
> +static inline void msi_msg_set_addr(struct msi_desc *desc, struct msi_msg *msg,
> +				    u64 msi_addr)

No line break required. You have 100 characters available.

>  {
>  #ifdef CONFIG_IRQ_MSI_IOMMU
>  	if (desc->iommu_msi_page_shift) {
> @@ -314,11 +309,14 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>  			       << desc->iommu_msi_page_shift;
>  
>  		msg->address_hi = upper_32_bits(msi_iova);
> -		msg->address_lo = lower_32_bits(msi_iova) |
> -				  (msg->address_lo &
> -				   ((1 << desc->iommu_msi_page_shift) - 1));
> +		msg->address_lo =
> +			lower_32_bits(msi_iova) |
> +			(msi_addr & ((1 << desc->iommu_msi_page_shift) - 1));

Please avoid unrelated random formatting changes. Especially in this
case this is even more non-sensical as you introduced the original
formatting in the previous patch. So fix it up there and make it:

		msg->address_lo = lower_32_bits(msi_iova) |
				  (msg->address_lo & ((1 << desc->iommu_msi_page_shift) - 1));

which is way more readable than this displaced variant above.

> +		return;
>  
> -	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
> +	msg->data = its_get_event_id(d);
> +	msi_msg_set_addr(irq_data_get_msi_desc(d), msg,
> +			 its_dev->its->get_msi_base(its_dev));

No line break required here and at the other places.

Thanks,

        tglx

