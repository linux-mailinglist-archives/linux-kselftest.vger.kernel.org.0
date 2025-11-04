Return-Path: <linux-kselftest+bounces-44753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C18C32BFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 20:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55674E497E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 19:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99D280308;
	Tue,  4 Nov 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/vJg95g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC9747F;
	Tue,  4 Nov 2025 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283974; cv=none; b=Af7VvGYINYgjLK/6Asd16Wuew95OxE+AgggM8i/Pv/9J0KI7u3tdU5LGh2i3GMiecTaqpGVCOsS+yewqQlPf5dF9N5ArYgofgls3agnxfyYZEU6dDEKF0UhxOpFs2vn4wNQpXM6nc9/kHFQxVYux/bZg5sNAcsowZm+Y1Dwzpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283974; c=relaxed/simple;
	bh=4Zz7FFu2rCvI5eS2OLj7RM91IXB/pz1QE383kxwiF4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFF8ZBPT0SscGwffjayyFUIlhGeWJMbCpn+Y0DvPtY75LBF/PcSgTq7PSjnWtPB7qYBOmFpAm05zXYhucT3bpQoDHguY/WOys8N8W1k3BiU27oHL4EMdyXSbLzk+zxMKVophoeNa6siR/VzJ1Udr99x5XFm7FRr98JWJwtNoAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z/vJg95g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hGVyhLvl9m1AEn9/C+EEFagP6yuL/zGYtIEBGie646U=; b=z/vJg95grnK4KRsjgomzl96ekl
	5WO/rJKABVEPjyWRTIa/4KMQfnfB8aDDBj5w+xS6AQejrKiLICppJLEwsxbGF/S+y0dH0YL/YQj5e
	L8A2TW9EyADRcABInxIAl4Xi2x5tuWXJxb9LtTiHuSB8n/aKYFDSAeVxoL5Ceilwj9hV/68RAAvwO
	xmEvRVU/HFXs4nTON56c6nb5A1JXRiOoOIwT3TQ/VWWUyfPyfm3hUofST1Ub9GJUU3UdVYItYFCDB
	G9IZ0tMkV3YdRblVpKHHvE56RyHed3j3Jb+oLGZg2TXr6ocW3teulWjZQoHy9U2PQ0y/Mnm2Syj6/
	UFHoUcjA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMZ0-0000000CTqz-3WRt;
	Tue, 04 Nov 2025 19:19:30 +0000
Message-ID: <eb1411af-ed57-4e18-95c1-33ed70a5d488@infradead.org>
Date: Tue, 4 Nov 2025 11:19:29 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/15] iommupt: Add read_and_clear_dirty op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <8-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <5c0e6abd-f217-4361-b5bd-99f31c9094a7@infradead.org>
 <20251104191723.GB1678406@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251104191723.GB1678406@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 11:17 AM, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 11:13:06AM -0800, Randy Dunlap wrote:
>>
>>
>> On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
>>> +/**
>>> + * read_and_clear_dirty() - Manipulate the HW set write dirty state
>>> + * @domain: Domain to manipulate
>>> + * @iova: IO virtual address to start
>>> + * @size: Length of the IOVA
>>> + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
>>> + * @dirty: Place to store the dirty bits
>>> + *
>>> + * Iterate over all the entries in the mapped range and record their write dirty
>>> + * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
>>> + * the entries will be left dirty, otherwise they are returned to being not
>>> + * write dirty.
>>> + *
>>> + * Context: The caller must hold a read range lock that includes @iova.
>>> + *
>>> + * Returns: -ERRNO on failure, 0 on success.
>>> + */
>>> +int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
>>> +				    unsigned long iova, size_t size,
>>> +				    unsigned long flags,
>>> +				    struct iommu_dirty_bitmap *dirty)
>>> +{
>>
>> Just FYI:
>>
>> I guess that a function with DOMAIN_NS() is going to confuse
>> scripts/kernel-doc.py.
>>
>> From patch 3 of this series:
>>
>> +#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
> 
> Yeah, I don't think kdoc is pointed at this file. Still need to
> document the function though..

OK, sounds good.

-- 
~Randy


