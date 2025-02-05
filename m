Return-Path: <linux-kselftest+bounces-25871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5BA29CD0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 23:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445103A6F15
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0599219E8C;
	Wed,  5 Feb 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fhtun/HH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A9217739;
	Wed,  5 Feb 2025 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795749; cv=none; b=lHUhgrOj+HKyUa7v2dLmKzP1BUjsQhIk1EsTKnDDPGnWpA9i68w3YYMuxpYGHQcuPZo1s4CPUvjCPb5QxT5CC5oD+MrH4BUyoPrve7dlE3wWugX/Dz9llpKHR2ohfn9fpnjO+VZZnUQv0MUAXEeWSyO0Lajai04G82k+SGO48C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795749; c=relaxed/simple;
	bh=dZWWY11R6K2znUjsJgBeNLQ5otlAfqkditnlzHQVDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXB+r0uMDqo/7AVQwcsPoFsyzCHiQkE8e9T2Pb8xpUa6n3JJhpH+8webuRfNBK3ctCkINq2IgUK5H1lRHYWQ3vQDYDUebNc1zvdKnfidcP5OVyylIqm7iGf13doY7/LMqTQOLJTTn+/gcIJKS9oSHQVuhDVebL2to/3PVb694/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fhtun/HH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1107A203F59E;
	Wed,  5 Feb 2025 14:49:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1107A203F59E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738795747;
	bh=UKHV/JQ3QffWyh6cdizuTNe5OOYudjWKLtxMFE92V8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=Fhtun/HHTs8cKMk/GQjP30TwMFP3lggFolDvN5IWoUQCAavvOTaORuftLmNqt2MEe
	 wc/5XmAuc4gu++Yp7MgRaQsbFvJaau3iJQF2g8wJ8CizocAJrXFg3A9Iz60Nwuuoqf
	 Fi8d59U12O6oLOTupv0RXcxCJ3t2T30irlL6Thxo=
Date: Wed, 5 Feb 2025 14:49:04 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
 <kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
 <alex.williamson@redhat.com>, <joro@8bytes.org>, <shuah@kernel.org>,
 <reinette.chatre@intel.com>, <eric.auger@redhat.com>, <yebin10@huawei.com>,
 <apatel@ventanamicro.com>, <shivamurthy.shastri@linutronix.de>,
 <bhelgaas@google.com>, <anna-maria@linutronix.de>, <yury.norov@gmail.com>,
 <nipun.gupta@amd.com>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <patches@lists.linux.dev>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
 <mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
 <smostafa@google.com>, <ddutile@redhat.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Message-ID: <20250205144904.39285de4@DESKTOP-0403QTC.>
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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

On Fri, 10 Jan 2025 19:32:16 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> [ Background ]
> On ARM GIC systems and others, the target address of the MSI is
> translated by the IOMMU. For GIC, the MSI address page is called
> "ITS" page. When the IOMMU is disabled, the MSI address is programmed
> to the physical location of the GIC ITS page (e.g. 0x20200000). When
> the IOMMU is enabled, the ITS page is behind the IOMMU, so the MSI
> address is programmed to an allocated IO virtual address (a.k.a
> IOVA), e.g. 0xFFFF0000, which must be mapped to the physical ITS
> page: IOVA (0xFFFF0000) ===> PA (0x20200000). When a 2-stage
> translation is enabled, IOVA will be still used to program the MSI
> address, though the mappings will be in two stages: IOVA (0xFFFF0000)
> ===> IPA (e.g. 0x80900000) ===> PA (0x20200000) (IPA stands for
> Intermediate Physical Address).
> 
> If the device that generates MSI is attached to an IOMMU_DOMAIN_DMA,
> the IOVA is dynamically allocated from the top of the IOVA space. If
> attached to an IOMMU_DOMAIN_UNMANAGED (e.g. a VFIO passthrough
> device), the IOVA is fixed to an MSI window reported by the IOMMU
> driver via IOMMU_RESV_SW_MSI, which is hardwired to MSI_IOVA_BASE
> (IOVA==0x8000000) for ARM IOMMUs.
> 
> So far, this IOMMU_RESV_SW_MSI works well as kernel is entirely in
> charge of the IOMMU translation (1-stage translation), since the IOVA
> for the ITS page is fixed and known by kernel. However, with virtual
> machine enabling a nested IOMMU translation (2-stage), a guest kernel
> directly controls the stage-1 translation with an IOMMU_DOMAIN_DMA,
> mapping a vITS page (at an IPA 0x80900000) onto its own IOVA space
> (e.g. 0xEEEE0000). Then, the host kernel can't know that guest-level
> IOVA to program the MSI address.
> 
> There have been two approaches to solve this problem:
> 1. Create an identity mapping in the stage-1. VMM could insert a few
> RMRs (Reserved Memory Regions) in guest's IORT. Then the guest kernel
> would fetch these RMR entries from the IORT and create an
> IOMMU_RESV_DIRECT region per iommu group for a direct mapping.
> Eventually, the mappings would look like: IOVA (0x8000000) === IPA
> (0x8000000) ===> 0x20200000 This requires an IOMMUFD ioctl for kernel
> and VMM to agree on the IPA.

Should this RMR be in a separate range than MSI_IOVA_BASE? The guest
will have MSI_IOVA_BASE in a reserved region already, no?
e.g. # cat
/sys/bus/pci/devices/0015\:01\:00.0/iommu_group/reserved_regions
0x0000000008000000 0x00000000080fffff msi

