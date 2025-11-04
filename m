Return-Path: <linux-kselftest+bounces-44751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C20C32BE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 20:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121D43BC014
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF933C52F;
	Tue,  4 Nov 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEVvFN9N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315731BCAA;
	Tue,  4 Nov 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283593; cv=none; b=Kdi6sBvmFHA2x/2eFTOTGNTLDGTOrz92M3+u4h6bVkkMMS8mO5Vy3KpaFbXw9ALaV8te76hjtBHsYFL+Mwmf+jjzzwhskscM6CQd2iYWwR8DKqbTK7M30loMLvp+7cG4GtgKC91yopwX4qPPLLNYNswB59iT/r5QqgUQwLYETTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283593; c=relaxed/simple;
	bh=TMk1XTUPiBd/DVEp8DFaex02G8aGZvJcwVTDUHt8fOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WErJC/bE3khCAeMmVp1/ULqIsLqo8cc9AIpO6akrTetrQLjDv8L5IvBGlyX4Po7thVQjUAtBHeRiUpzMqo+VzcymI7o/lMp3gFjVH5SZXFwXiNcM6+antNeAOAP/LysfHD56ERsvOJUPl/okKk53zhZFPmbcjceRuDNPMHCNzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KEVvFN9N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IndwIUyfLdZJntfdeD9AjkBm8EQS2x+ONVPC5f/x8eU=; b=KEVvFN9NtgRd+ipQPElA+RWNRF
	aG1BoZPz2cVmOr+thuytFF/Jz6K7/sZ08ujBHZvyrpTVoSJ02JbS9cIhsyaE9gxi9LoZeLdwlXyJ6
	gmOe8b+f66AGRnwW8Bu5nSWfhF2y4Fa5sNzq4uCMzMzxBTLk1HYXuZeuZbKythKM0lSblPR106OL5
	00mdLxzgN6mOsT5CYt1Hq00TlRPdoU/Fz40J/XSyPkNL2RIiG7V9KBWlVzNjjof2inG2yB0JUR2Ll
	8Pmf8iUAY9TqP4C4Vu5P3cpxBFmNe0I0pGSfR7vpouBhOPtLAYAA8GKcwzuOhE1y6JckSyTkUgQCg
	nlrWxVLw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMSp-0000000CTPE-2MDz;
	Tue, 04 Nov 2025 19:13:07 +0000
Message-ID: <5c0e6abd-f217-4361-b5bd-99f31c9094a7@infradead.org>
Date: Tue, 4 Nov 2025 11:13:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/15] iommupt: Add read_and_clear_dirty op
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
References: <8-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> +/**
> + * read_and_clear_dirty() - Manipulate the HW set write dirty state
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @size: Length of the IOVA
> + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
> + * @dirty: Place to store the dirty bits
> + *
> + * Iterate over all the entries in the mapped range and record their write dirty
> + * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
> + * the entries will be left dirty, otherwise they are returned to being not
> + * write dirty.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
> +				    unsigned long iova, size_t size,
> +				    unsigned long flags,
> +				    struct iommu_dirty_bitmap *dirty)
> +{

Just FYI:

I guess that a function with DOMAIN_NS() is going to confuse
scripts/kernel-doc.py.

From patch 3 of this series:

+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)


-- 
~Randy


