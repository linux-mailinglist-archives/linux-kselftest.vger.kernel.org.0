Return-Path: <linux-kselftest+bounces-26005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F63A2C5C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528833A4C9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4623ED7A;
	Fri,  7 Feb 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwqW32XE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jtOnsBd2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E813BAE4;
	Fri,  7 Feb 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939382; cv=none; b=SxJpRox7+OpxnVXscU6H+OFjePQj+uMP+XixD8GOIZ19NT3FpB8S+1Nkk3fH3vQsM2Wh+LfpcH3yFn5Ujuayb10jY5ENw1o42t2JlJlLgzAH4NMPoz9yvHZT9+GVZvWS0Ulqiw0bJsK0yGKPfU+JjmFQpqc/lkl2YeRiqQxx670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939382; c=relaxed/simple;
	bh=GaRceLLlogc4o9OjwuUlKdf9YKZMOrqTjM3515LS+Rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAxw5YXUSR3vrSBdVTLe5jfhaQfOjX4yMeGWowgNlbzX4lLAaemjGwBpNfdami6/f7Z1uhTtH9xMtsdPJnJzsRmqFQGPG/pfwepfSbgH78LjMOpqFwlStFJ1GIgghyjqJorXXzyiYuSqlfkSAxl16s9ifuhN2htaxVXUKLAP5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwqW32XE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jtOnsBd2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738939374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkeDqYa1HLfts95iCxAWRO24Np4zPeA8eWDtJpHaVXY=;
	b=uwqW32XETTfe2u7CGshYrBNeAd+It/c+WnC1sALbfdPFvSaCtEi7ErbTUgR20g6mvbu/M/
	uyvL6Ru9wTI1Y0k9fNu8yDrlaUV2ObuZoPfcTi3xIleR68BXK9QKXuoRiyttaV7PTP0ToX
	CpdmTtj8Gh+78L3eD8joO+se52SZdPVUImCVceOqlT5aSIJjg7ajcZi5g8reOqVnNJNWNN
	y7uOinjdrR/DeMZQnvZ9J7QX7HY7bNnhgHbtN0EbdUw7g+C+tHDuSX7687DWMztvSYlAP6
	l5zNYX6/GNhCbR0TZkryf+LybkBfHCcigSqJQzRD/JXEeIOJP7CRm15wLJa+FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738939374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkeDqYa1HLfts95iCxAWRO24Np4zPeA8eWDtJpHaVXY=;
	b=jtOnsBd24wYOO8DUY4nJeuOxusWoOJiTGUPwTktLczqPvXUzX1fViIYAMoXBFt08EuQf8G
	aOJ7fsBoWZzxXVBg==
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 robin.murphy@arm.com, maz@kernel.org
Cc: will@kernel.org, kevin.tian@intel.com, alex.williamson@redhat.com,
 joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
 eric.auger@redhat.com, yebin10@huawei.com, apatel@ventanamicro.com,
 shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
 anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
 ddutile@redhat.com
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
In-Reply-To: <20250207143402.GA3651395@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <20250207143402.GA3651395@nvidia.com>
Date: Fri, 07 Feb 2025 15:42:54 +0100
Message-ID: <87lduhlssx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 07 2025 at 10:34, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2025 at 07:32:16PM -0800, Nicolin Chen wrote:
>> Though these two approaches feel very different on the surface, they can
>> share some underlying common infrastructure. Currently, only one pair of
>> sw_msi functions (prepare/compose) are provided by dma-iommu for irqchip
>> drivers to directly use. There could be different versions of functions
>> from different domain owners: for existing VFIO passthrough cases and in-
>> kernel DMA domain cases, reuse the existing dma-iommu's version of sw_msi
>> functions; for nested translation use cases, there can be another version
>> of sw_msi functions to handle mapping and msi_msg(s) differently.
>> 
>> To support both approaches, in this series
>>  - Get rid of the duplication in the "compose" function
>>  - Introduce a function pointer for the previously "prepare" function
>>  - Allow different domain owners to set their own "sw_msi" implementations
>>  - Implement an iommufd_sw_msi function to additionally support a nested
>>    translation use case using the approach (2), i.e. the RMR solution
>>  - Add a pair of IOMMUFD options for a SW_MSI window for kernel and VMM to
>>    agree on (for approach 1)
>>  - Add a new VFIO ioctl to set the MSI(x) vector(s) for iommufd_sw_msi()
>>    to update the msi_desc structure accordingly (for approach 2)
>
> Thomas/Marc/Robin, are we comfortable with this general approach?
> Nicolin can send something non-RFC for a proper review.
>
> I like it, it solves many of the problems iommufd had here and it
> seems logical from the irq side.

I haven't seen anything horrible. My main concern of having a proper
cached and writeable message is addressed.

Thanks,

        tglx

