Return-Path: <linux-kselftest+bounces-27143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC492A3F03C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC59D1884948
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CA5203705;
	Fri, 21 Feb 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOsbBNx1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkGnpwX7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C9201017;
	Fri, 21 Feb 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130104; cv=none; b=gcA2+OgmDlR0oEXcLfbAclMxpozBU6hczzrE9Cp97Xq4wnoi1b1DsNn8Z9rLKtQDERQ0KJJ0k/rz8wDH+ESuINGtMdYKcqmAsbbXKjqxIh39/kSzahP/vHblc5URDz0TQL/HdqEvNHWtLNmnr5BzKltamV/2cE6DM+RfWF/roW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130104; c=relaxed/simple;
	bh=TFQcaNN4BhjsY8helJtRFXwS8Z3t6w4D7fo6NiCwK1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCooPulvHzMC7Kx88TtN/HCA7ES+TpXyX7ygt37q+XumCi/Nva4Wd9gZMtLDk9BGTpyrfe5+mAa8lq+KjBCqI3w1+ZuyNg1+4iFV02GfuS7tJ8za0r4gLrbNZSAM3ttX1bDyVeXBKP8gmKFkNo6HU3oUjqy5Eo/L4DKfGPLzw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DOsbBNx1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkGnpwX7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740130101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4RDEkxswbUbhEqdazfb85bOV8IiqvBYeb8Hqd67Gjw=;
	b=DOsbBNx15V3te3uSwQkkoQh8pumg9j1OQwos8Wq6tlZ1fHlK4USHZhrlj2Z+KFK5EV0a5Y
	yu52Dt06CaklHEPoASJGAtJs3VJF/LhNhSwM9ytDyySMI/slQ6yiW6DQPj06CrpXvFuR0e
	kCdlOsJm27epmZUSg5TuYitQKxZj4KdK1Z836JaiLvyqRvw28H1JAA11e9rmygxIO9tmdM
	gNtFCdP+zzJPnOEhkEPCbdVUaFfmiGjwz1cBHfhKJK7VGDp/4uwMnN2hdD3kw8cqyoeIWi
	KmcpfKqkKzPbqvV2KvP4UZxdXVq7Kv6mOM/7vIGJQ9wfSspsanV+Z/GUNxn8sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740130101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4RDEkxswbUbhEqdazfb85bOV8IiqvBYeb8Hqd67Gjw=;
	b=fkGnpwX7xaB0MJgMVSfZ73m14LAJWC3zzXp0zNdV5PL7QQKnBMpSPX9LZ/UcxHQpfJkKXk
	HoZaMLJZAc6KE6DA==
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
 kevin.tian@intel.com, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com,
 patches@lists.linux.dev
Subject: Re: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
In-Reply-To: <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
Date: Fri, 21 Feb 2025 10:28:20 +0100
Message-ID: <87ldtzhcjv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 17:31, Nicolin Chen wrote:
> Fix the MSI cookie UAF by removing the cookie pointer. The translated IOVA
> address is already known during iommu_dma_prepare_msi() and cannot change.
> Thus, it can simply be stored as an integer in the MSI descriptor.
>
> A following patch will fix the other UAF in iommu_get_domain_for_dev(), by
> using the IOMMU group mutex.

"A following patch" has no meaning once the current one is
applied. Simply say:

  The other UAF in iommu_get_domain_for_dev() will be addressed
  seperately, by ....

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

