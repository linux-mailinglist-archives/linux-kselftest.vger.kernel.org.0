Return-Path: <linux-kselftest+bounces-40347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C4B3C563
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55DF584B3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5842C21C7;
	Fri, 29 Aug 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pITCHuWU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9823507E;
	Fri, 29 Aug 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507850; cv=none; b=OxBZmZHUUXkGuqdU5jzhZeBjstZ14ExAcehFnz5XM3MnAdORZFpdRYdiNXWEYewjqmqi6Q99oVW09EfGxBaED1cVkxTUBAh9AaBdwv7TbJUjrMEBU9LvPiUxZ3eRwQn6izwDdzmeAMydmZvx3WRzr2U5a3WxsCDax2Rp6gcmbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507850; c=relaxed/simple;
	bh=yQrl3gCtzdyKztNdAWjGjfEx4RFSnzGpjf6FUTnKgcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SogMMMGrJ5Io2j8ViZodebUFWKwu5oGMop/hxgxLGEoJGt9bKXVkWqVVzYOhkEoewPHTX+xJvn9H/8AsBXE+vOp0NdRnpP5DyW/0L44mhlsAkX/Jx2hd4f4fsAM7D5gVi/hQzLGzYiJI0o5K0oCgiM3P3zYPJaU2vOjUPi4U8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pITCHuWU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vBqocCSrw/I/eTnjICc/R9VLegWS9kJ8fWJ+dhUrmbM=; b=pITCHuWUJuiDHiaEscGXVXczcK
	I0/Wd74s+NDD/sEhJ3i0C7fgA9qpUSo8PJP1moXRGQnykNvxDXnxrqB2EIlySGG8dICRLkd4z6RHb
	8KmkRHhoO+I/My0S3KX39ab8d3rYDeE0cLqWyIEYKNp5So3JeyY3f4amPxDo5zRskH7MdCU2cT4Kg
	lkyk0k5hFEHpftWgCDxLX8H16kaIyfhbK35YVpzi0iECQVlLfDs/SxqnbrdaJz7dKqPuxbamvVnQ7
	pLhICedjX9Wm5Ox+ZzOhDlVKF8oktW8T2cu4SuiApJT5Yps43hWywifM8Dr6AoBWERW4ru+BpvfZ0
	QYZbU3VQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us7vg-00000006zQp-3RYK;
	Fri, 29 Aug 2025 22:50:44 +0000
Message-ID: <e11b42b9-8294-4cc3-b27c-2344ae898ce0@infradead.org>
Date: Fri, 29 Aug 2025 15:50:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] genpt: Generic Page Table base API
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <1-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <bdbd466f-01d3-40ac-abca-81527dbfb901@infradead.org>
 <20250829185124.GE79520@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250829185124.GE79520@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 11:51 AM, Jason Gunthorpe wrote:
> On Wed, Aug 27, 2025 at 12:11:40AM -0700, Randy Dunlap wrote:
>>> +/**
>>> + * pt_entry_num_contig_lg2() - Number of contiguous items for this leaf entry
>>> + * @pts: Entry to query
>>> + *
>>> + * Returns the number of contiguous items this leaf entry spans. If the entry is
>>
>>  * Returns:
> 
> I think I prefer to leave many of these as is, putting the entire body
> in a Returns: block seems too weird. I did the ones that seemed to fit
> that pattern.

Sure, no problem.

> Most of these descriptions are entirely talking about the return value
> since that is the only thing the function does.
> 
>>> + * If true the caller use at level 0 pt_install_leaf_entry(PAGE_SHIFT). This is
>>
>>                          uses
>> ?
>> although it might just be missing a word or two? I can't tell.
> 
>  * If true the caller can use, at level 0, pt_install_leaf_entry(PAGE_SHIFT).
>  * This is useful to create optimized paths for common cases of PAGE_SIZE
>  * mappings.

Ack.

>>> + * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
>>> + * that a non-contigous singe item leaf entry is supported. The following
>>
>>              non-contiguous
>> Also, is that               single
>> ?
>> or is "singe" a real word here? (IDK.)
> 
>  * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
>  * that a non-contiguous single item leaf entry is supported. The following

Ack.

thanks.

-- 
~Randy


