Return-Path: <linux-kselftest+bounces-26595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A50A35086
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937991890B67
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7252661AF;
	Thu, 13 Feb 2025 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bNx9G9k2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2B1487FA;
	Thu, 13 Feb 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482404; cv=none; b=KoHvVgxVucHbqF1k+nLFa2RmcX4pIYAcFxi4/SMQNEH5t/15Z57NgCbv7ZWthzLJ6yovGGlvF+4S/ORST/qt4zNvpclu5DzJFBJ0Z8O+KHoQPUrS/Gno+8gNl3R8v503T9vVns9yN2WAcUojuz1m9jwwC/MuS5z2i/x/7ak/uJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482404; c=relaxed/simple;
	bh=Le2z6S/TGp1M20Zwm8Z+44wgyjoL+8Qxoo4FggOcqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pltCDphIY13Dcp43zF274iutWQYlp3i/uA6zf2+V8u1ko3tAU6VFAaqNhIb1z5CQzXvGrvtu22v5DmTB20t2pmVKHY26iFbBRmLLQUwuvxunXBgKyAvY9ykCGpHmBzJ4euG2FyYVFSBu7Pbbe8cuCNrbQEHXMlJagpkVZMY3760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bNx9G9k2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4288203F3E5;
	Thu, 13 Feb 2025 13:33:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4288203F3E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739482402;
	bh=C2Qeaegt7gPI3p1M+fiOMj28QzePyAgRVdlTTwKHzsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=bNx9G9k2b1k2PvrknvZWUyUuOKi33Pq8K/Yxf4u+Mh57ytYmaCO8Ct8YmR5Vz7tiR
	 hmHm7t++NioulCcTUlm1ahRJLMF083h5rB1Kmlu3WCeT2Pj2k/8MPm5TyVYsv+nCGh
	 okcQsYiSAsGjpyhm/r+dPvd4bv+roNWNqT8vWB6g=
Date: Thu, 13 Feb 2025 13:33:20 -0800
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
Message-ID: <20250213133320.5a031289@DESKTOP-0403QTC.>
In-Reply-To: <Z65d4wr1D3F5bBeC@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
	<a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
	<20250213122849.34f5d1cb@DESKTOP-0403QTC.>
	<Z65d4wr1D3F5bBeC@Asurada-Nvidia>
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

On Thu, 13 Feb 2025 13:02:27 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Feb 13, 2025 at 12:28:49PM -0800, Jacob Pan wrote:
> > Hi Nicolin,
> > 
> > On Sat, 8 Feb 2025 01:02:34 -0800
> > Nicolin Chen <nicolinc@nvidia.com> wrote:
> >   
> > > -static inline void msi_desc_set_iommu_cookie(struct msi_desc
> > > *desc,
> > > -					     const void
> > > *iommu_cookie) +/**
> > > + * iommu_dma_compose_msi_msg() - Apply translation to an MSI
> > > message
> > > + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> > > + * @msg: MSI message containing target physical address
> > > + */  
> > Is it IOVA not PA?  
> 
> This is moved from dma-iommu.c so we didn't change that.
> 
> And I think it's correct to say "target physical address" as the
> irqchip driver does pass in a PA via @msg.
> 
> Then iommu_dma_compose_msi_msg() kind of reverse-translates that,
> overwriting the msg with the "IOVA" from @desc.
> 
It is just confusing that the msg can be IOVA, not always PA as the
comment says. I see it gets deleted anyway in the next patch :)

