Return-Path: <linux-kselftest+bounces-27144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F7A3F043
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3771B701B36
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D52045A5;
	Fri, 21 Feb 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rft1jIC3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+KPnXw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B32040AE;
	Fri, 21 Feb 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130132; cv=none; b=BqjvmEZamukuyBExFO4mz8okp0dZzALIMeM/MhUj7A3Mh2ZHoHbNn6qKw6BsbYRK5FSdAvkx28a/hQz3fUtxjdv8NnVptoM80AJ8JqcpB3fka3Un0FV+cXDdCyTuRnrssWjfW3jE9nF0YmUS8BmGrUXnYTg6vJIRXmNHckAm9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130132; c=relaxed/simple;
	bh=iwUITOpMFwTi/W8s/xf6chXl/H4CSWnHTKuu/cNkV+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6U/8RBYRwIVyIFj3qCSMUrauZxa1fBgy/tB5h3B5i5yaOp7i7D+KmC/I8q4MnhlT3Ku3dKNwR55ZOcztDiTh7jVn2NCNABU3eH0hjL8z6uMAEWkbhOxV4jIYzBGSp/SGn5Cc6/UTO4cZw5VV68cBmmtjMCz8aWgfUMspqeex78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rft1jIC3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+KPnXw5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740130129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwUITOpMFwTi/W8s/xf6chXl/H4CSWnHTKuu/cNkV+Y=;
	b=Rft1jIC3rQkJoE7ktmxfkISLJACrDfiV6yT2t1mrEsrrvrMsFcMh9LAAsgjtcHjO+iGIV7
	7Uimzs+uA08ag7Zw6Yd0AcgKAETr/ty5Cn9lnjuf1WrbsU/un+oG3S/7QLvlWvIB/Q3/Qa
	JmUgGr15GKukhSOtvTAk4Ve/DWl2pvZ6xe5/8EbszUIp3HOotmQqXvMwF0Zfe74xJKvolq
	JDc9LYS7weYz0Au5rIuJ3117mpJTUrUw0U6Mr9JxkmJiH8Eai2djymgBdfAAk1gRCItlQe
	/YoGy/ImnMlFzjZfst6JAB2yRLMCbOcs4b1E/GfQjwMCM688FKot2ywYYCR+PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740130129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwUITOpMFwTi/W8s/xf6chXl/H4CSWnHTKuu/cNkV+Y=;
	b=T+KPnXw5Wr2dPlolH6aNGJaBaBOXcpbTXXzHKxX6PowtAno4QpBmWblRtwqYDSoMbjfhhW
	5yDF1qjXgyrByPAg==
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
 kevin.tian@intel.com, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com,
 patches@lists.linux.dev
Subject: Re: [PATCH v2 2/7] genirq/msi: Refactor iommu_dma_compose_msi_msg()
In-Reply-To: <eda62a9bafa825e9cdabd7ddc61ad5a21c32af24.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <eda62a9bafa825e9cdabd7ddc61ad5a21c32af24.1740014950.git.nicolinc@nvidia.com>
Date: Fri, 21 Feb 2025 10:28:48 +0100
Message-ID: <87ikp3hcj3.ffs@tglx>
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
> The two-step process to translate the MSI address involves two functions,
> iommu_dma_prepare_msi() and iommu_dma_compose_msi_msg().
>
> Previously iommu_dma_compose_msi_msg() needed to be in the iommu layer as
> it had to dereference the opaque cookie pointer. Now, the previous patch
> changed the cookie pointer into an integer so there is no longer any need
> for the iommu layer to be involved.
>
> Further, the call sites of iommu_dma_compose_msi_msg() all follow the same
> pattern of setting an MSI message address_hi/lo to non-translated and then
> immediately calling iommu_dma_compose_msi_msg().
>
> Refactor iommu_dma_compose_msi_msg() into msi_msg_set_addr() that directly
> accepts the u64 version of the address and simplifies all the callers.
>
> Move the new helper to linux/msi.h since it has nothing to do with iommu.
>
> Aside from refactoring, this logically prepares for the next patch, which
> allows multiple implementation options for iommu_dma_prepare_msi(). So, it
> does not make sense to have the iommu_dma_compose_msi_msg() in dma-iommu.c
> as it no longer provides the only iommu_dma_prepare_msi() implementation.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

