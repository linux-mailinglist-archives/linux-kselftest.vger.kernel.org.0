Return-Path: <linux-kselftest+bounces-40015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9AAB37594
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDFF1B26B24
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800A2FABEB;
	Tue, 26 Aug 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGqsLHkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104C288C96;
	Tue, 26 Aug 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251238; cv=none; b=GuLpp6ZIy8R0vPKRSkg61YYTcVdOkMt6xj3Dz/yJuDZKYpSeO3E7RRptXuLDBTreSSIyiiLZLWOEpuAK0sGX/mgBnJC/hTStUDw3V75qnt52kxRy/HihaB1I0zVYMiqX1g1fEeMFZcwv10NfMfpFdwTciEraOupmzm4lqN6cMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251238; c=relaxed/simple;
	bh=fCj+cByLyqBjHXHIsgTkCY0aVnSIa4wo2qjp075setg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyZfTsfTROOQNnlWJhE5s/VoTdkwp82xr8jACcHT82nKzUcgF3zrv5uPj4AwMKbS0X8+t+gIu+sVkN9Q0tE5WkoTkgGB5GqkRzgOFK3ikElw4eK7x135TW9iZ9ZyStE9tij+c+fjELfRZktQ77ZnFtEOSUKTOYErgRZEMK561/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGqsLHkT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NwNXwIfcqJlEQIvorsP28aAIFoZ2HxZ6G9XhmWWx7PA=; b=pGqsLHkT7f+e/BViTmO5YfwKXE
	XGCFCsB5d07LHAcrlLlB+menQT2ds3khuC5Qs1bxs1eMX1kb0MD3ajlxKEgZKc0GwaIwsPldTtyVw
	bxKg49hSXf4e7ttYMGRutbY3pvD8D/GAuS6MwLsBSXCf6T5chy0NxJ/fzzEcfY84qkhG1IPdG7I3p
	OB0iKbwidykeiY8BWANew3il3ql1jcNeTPLTh7Xq62KbzrsPhRynNb9y9LRhZ76GuMMLN5PrTVFn/
	9NtRG92w5ieXROO1XTJ2yPU/PKMStrKRHTPRc7JoeiSWC0Sxg4eMX6MXpCtCKtVL5luSrZBiEPOvv
	YuAjQGUA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur3Am-0000000DMCh-3M8W;
	Tue, 26 Aug 2025 23:33:52 +0000
Message-ID: <08421ad9-12cb-4d1e-b777-343b27d82467@infradead.org>
Date: Tue, 26 Aug 2025 16:33:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] iommufd: Change the selftest to use iommupt
 instead of xarray
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <11-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <11-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index cbe6433550f380..58c9fa74fb0701 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -73,6 +73,18 @@ struct pt_iommu_info {
>  };
>  
>  struct pt_iommu_ops {
> +	/**
> +	 * set_dirty() - Make the iova write dirty

Should be:
	 * @set_dirty: Make the iova write dirty

> +	 * @iommu_table: Table to manipulate
> +	 * @iova: IO virtual address to start

These will be ignored by kernel-doc (for now), but that's OK.

> +	 *
> +	 * This is only used by iommufd testing. It makes the iova dirty so that
> +	 * read_and_clear_dirty() will see it as dirty. Unlike all the other ops
> +	 * this one is safe to call without holding any locking. It may return
> +	 * -EAGAIN if there is a race.
> +	 */
> +	int (*set_dirty)(struct pt_iommu *iommu_table, dma_addr_t iova);
> +
>  	/**
>  	 * get_info() - Return the pt_iommu_info structure

	 * @get_info: Return the pt_iommu_info structure

Should be:>  	 * @iommu_table: Table to query
-- 
~Randy


