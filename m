Return-Path: <linux-kselftest+bounces-26535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B368A33E7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0924916A1A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBC21CC61;
	Thu, 13 Feb 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3BI4qYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jc11mgkW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CB2147F7;
	Thu, 13 Feb 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447659; cv=none; b=Bpo7yAMdOWJDslRl/BeXXQmbKqPYKBGhqk5gLpiO45mKj1anfHVN+GSFOWxRx04dWb21BTGheJAfaZJ29dHhCyqi8ZTUSjUo+ryJzIDTwIy4gC8bWFIU3H/eemWwRD0Z7sA9PiG3hElFOBlkZEb/9gMXT29MlZLfUmFSJTC3OUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447659; c=relaxed/simple;
	bh=MqDW9zds1aMzuxEr+ieIN3w8AUaeMBOtLSwPLf49hX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwa9QQqBS7Z5ZaFDP81yT1HNdjw2kCdkknVZaxymQZoICjUv9plzwiBFGhDyKnA98R8Qm7Zew1BmiIanJIQIafSWx+LV4/nLa06oHQJmmZBOcTiXGTy5LBSpTvRdM+r7lmt7x4WOT/Cj4GwqwERCeCdghhtkOhPGr2svUuM8PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3BI4qYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jc11mgkW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739447656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVCFtiwujzbXkpW5Uts1EM44uRKfVCoT8Jxt43kwJZs=;
	b=Q3BI4qYOehHagnGv2BUg8gNnenIzTcCi1NMESdqL0fLyHd4Yzz9+IYpIkFW3DSmDQXC8IS
	mDGtthYVDx2iQwWZwUnTh5RKYIrVO3hb0Gfqd1n1IKRRgimeBkq0ktFM6oTIF5/fZCTowq
	Gq3dQ9PHcGRe4lFk/9u9qz7xDA+MuzWXW085gYb3gIveOvL3Y5trtL5vHA8iXcWnWTD0YW
	N5txuktSnn/uYzDWCNP62XXc7dXXwAOMmprC65aAK79c1RgYmPW9hsupcNDm5bZgV/YLLR
	o5Wz5nWNxmHCU6rp6EVQiJketXY0mDMiDZ3D3yWCHb/4u5bU1K44Ws+l+l30Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739447656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVCFtiwujzbXkpW5Uts1EM44uRKfVCoT8Jxt43kwJZs=;
	b=Jc11mgkW0InKn0tScvUbjLrXp5+HWbjchgXOPuZeADaKpvfZUaX8cj1bJW72TjyGhkpFQJ
	YQ0RMmw6VpI9zhBw==
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
 kevin.tian@intel.com, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com,
 patches@lists.linux.dev
Subject: Re: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
In-Reply-To: <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
Date: Thu, 13 Feb 2025 12:54:15 +0100
Message-ID: <87y0yajc0o.ffs@tglx>
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
> All the iommu cases simply want to override the MSI page's address with
> the IOVA that was mapped through the iommu. This doesn't need a cookie
> pointer, we just need to store the IOVA and its page size in the
> msi_desc.

We need to do nothing :)

> Instead provide msi_desc_set_iommu_msi_iova() which allows the IOMMU side
> to specify the IOVA that the MSI page is placed during
> iommu_dma_prepare_msi(). This is stored in the msi_desc and then
> iommu_dma_compose_msi_msg() is a simple inline that sets address_hi/lo.
>
> The next patch will correct the naming.
>
> This is done because we cannot correctly lock access to group->domain
> in

Now this gets really confusing. How is the next patch which corrects the
naming related the locking problem?

> the atomic context that iommu_dma_compose_msi_msg() is called under. Today
> the locking miss is tolerable because dma_iommu.c operates under an
> assumption that the domain does not change while a driver is probed.
>
> However iommufd now permits the domain to change while the driver is
> probed and VFIO userspace can create races with IRQ changes calling
> iommu_dma_prepare_msi/compose_msi_msg() and changing/freeing the
> iommu_domain.
>
> Removing the pointer, and critically, the call to
> iommu_get_domain_for_dev() during compose resolves this race.

So this change log really fails to follow the basic structure:

   The context, the problem and the solution

Something like this:

   The IOMMU translation for MSI message addresses is a two stage
   process:

     1) A cookie containing the IOVA address is stored in the MSI
        descriptor, when a MSI interrupt is allocated

     2) The compose callback uses this cookie to apply the translation
        to the message address.

   This worked so far because .......

   With the iommufd rework this becomes racy, because ...

   Fix this by storing ... instead of ... ....

Hmm?

        tglx


