Return-Path: <linux-kselftest+bounces-44750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D54C32B9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 20:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FF784E937D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E7314B6B;
	Tue,  4 Nov 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wxrwdTvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CE2AF1D;
	Tue,  4 Nov 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282933; cv=none; b=gD1ihUygD60ltvqsDxEoSLj6Unxs3AYQRSSL65ABMbZBWhNGXihCMZtb12hphh/V5ESOGg7j/M8Z1FinD4SGG0vghKzl4ITaYyOMjDybaUjerxlCbk+L/2SgrKw4M15c0rNDTydZFGd2I0ZjdUQ0kdn5WcplsZILThWEU8sie2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282933; c=relaxed/simple;
	bh=Q5UStlbQr3l1L94tzSZaKAMYgwJaED6yicStdCUCTqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtSKKVyxGvEA6555kTC9pwQ3hOvuqk6tcISkK8Q8TSrVCwkHlcjYuS/VUaVy6FLva5v3GiBxdEvh2yIwF7QZ98LkIzWW+Mcl9ArCpWNXzdCV6a9RxJTu3ETK9TOlm9rLJE214VqE0yfDvUxxLfXwJkTlzf1ocx1gFX2IQ8OwYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wxrwdTvS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qcSi09vb0iqxwtRubfdSfbuCxuNy3V+98vVOVjExdPI=; b=wxrwdTvSB0Agwqri6xDTI08S6f
	XRMQKaFsPc96cqRxBCg/X7MInqa3k/JO4S9Ejc6gvpiqvU2adEjjq647qtuM5cs0zFgXh++CQWFlA
	0g5cdCj6luMhyiVzbyKDoMYuaB9j2LaXzMCqKmOnlxL3C3f2maz93dv4ckP1ct+5xn4T9fBTVpf8Y
	iUi7OJdqZx30IIvlcvauHwC5/Z4DgfF463CYUZiiZbwy9JGClxDI1E5VX4cJ0jb5Is5JDjbEHMZc2
	s0qBpmMd05vxGgFVWqjgqYUrXpJIrIMs520Q8I3Wp2Q4mgwYZavNZD12UlCNyl7T7qsLUmu45En/z
	ZMbzYF6g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMIB-0000000CSVt-467n;
	Tue, 04 Nov 2025 19:02:08 +0000
Message-ID: <d7ba7762-f398-4a7e-8e70-786ed9c4fa52@infradead.org>
Date: Tue, 4 Nov 2025 11:02:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] iommupt: Add iova_to_phys op
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
References: <5-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> +/**
> + * iova_to_phys() - Return the output address for the given IOVA
> + * @iommu_table: Table to query

      @domain: (as below)

> + * @iova: IO virtual address to query
> + *
> + * Determine the output address from the given IOVA. @iova may have any
> + * alignment, the returned physical will be adjusted with any sub page offset.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Return: 0 if there is no translation for the given iova.
> + */
> +phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
> +				    dma_addr_t iova)
> +{

-- 
~Randy


