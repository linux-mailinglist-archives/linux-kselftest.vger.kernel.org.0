Return-Path: <linux-kselftest+bounces-27145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B6DA3F04D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33F8860A58
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840E204C03;
	Fri, 21 Feb 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0oFasjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocZ9Ror/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF82046B7;
	Fri, 21 Feb 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130207; cv=none; b=WuE6TATnBmHZtB08VFQifCQGYHGrWWwT3Ogwd2Aw2r2fKMKZ3rSwPpM0s48oanuzJnLYj9C/tqqi2PgrfwneVLQSRAgbw5uinZENMx4xAV46ZBce/MrfLCL+bva3FbL8Egroj/smBXEosyQ6EV2sGzOqGCYxCzn0dbVooGoZwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130207; c=relaxed/simple;
	bh=RpcsefhhnfEYfdsMxYPb96qCBSHbkyV+wZHSLURNl3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnPlsCk5ZNXwro+xo1Z86FMrXkpSGJ97GlSbKxC06A3QTEJn1X6I58ueOKiAn3r3Tr1LsvXH0Ukpv4DhZ98icxZyJ9DDRahcaGNA5lu/E7dvmkxkDorr6Nq1u1aSAJZ8SQf+awj44fl+DwN4c5/hnZEYympRgw5f+16QsmuD2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0oFasjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocZ9Ror/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740130204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn1YK5Rbwl21fIMQLMa2jkRsxua5z7AprrlyzmypaHk=;
	b=z0oFasjwUX4OqPrCTmczsUAX4b9VPP+qb/2lqi56qbQKsREDNb7LRXybObX4Sri8xtEh40
	pJ/0xgrS406ocbif7fccA9wR1Np72hrF44BBcnSI/EN+VIOD8hdnL9v4vA+8wUfeqQh1x1
	vDg26BX0Y/Pd0GDfdmhbnJdaQ1WSqaU7N20QizOoRgSdEBk7ETU0pnHuA62oHYDh9oVl/t
	kYbV1/ynbFj4z7RjHX6LGzL6iivPjH406BMza5ecuWaRFsG+1bDTV70jZTI7m02vDDIY89
	aqc3yU3daGVh138wwksFkfXPsCeSQH9kAmKGNesuEv3SLNlxOrUF8P9+akghfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740130204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn1YK5Rbwl21fIMQLMa2jkRsxua5z7AprrlyzmypaHk=;
	b=ocZ9Ror/AAB+Q4FTa3HD5O9awyQCTRyOoL8WdHe7hnu0bgWzMQd+Vig5zy5amULt0hWGjE
	Mc0A5LU5PKJ2e6BQ==
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
 kevin.tian@intel.com, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com,
 patches@lists.linux.dev
Subject: Re: [PATCH v2 4/7] irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected
 by irqchips that need it
In-Reply-To: <a2620f67002c5cdf974e89ca3bf905f5c0817be6.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a2620f67002c5cdf974e89ca3bf905f5c0817be6.1740014950.git.nicolinc@nvidia.com>
Date: Fri, 21 Feb 2025 10:30:04 +0100
Message-ID: <87frk7hcgz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 17:31, Nicolin Chen wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
>
> Currently, IRQ_MSI_IOMMU is selected if DMA_IOMMU is available to provide
> an implementation for iommu_dma_prepare/compose_msi_msg(). However, it'll
> make more sense for irqchips that call prepare/compose to select it, and
> that will trigger all the additional code and data to be compiled into
> the kernel.
>
> If IRQ_MSI_IOMMU is selected with no IOMMU side implementation, then the
> prepare/compose() will be NOP stubs.
>
> If IRQ_MSI_IOMMU is not selected by an irqchip, then the related code on
> the iommu side is compiled out.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

I don't think I have conflicting changes here, so the MSI/IRQ related
changes can be routed through the IOMMU tree along with the rest.

Thanks,

        tglx

