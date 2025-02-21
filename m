Return-Path: <linux-kselftest+bounces-27154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76EA3F2B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09E319C1AF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D312080E7;
	Fri, 21 Feb 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="KBZWlUTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37520767F;
	Fri, 21 Feb 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136250; cv=none; b=ttLZxJDd8t5zBlU5JMns3rnv+CEnxwUKNRVLiMzw8OMkJlqIAfs3Z+HidcxOHKa5wSjehulULtU30eJHYdBJq0fUmGD2A2IavVQBx/U4GgxkU2eGofaXjQwl+cm1WddgDSO+DHTaZY/S87EHumOynFCNEPnIesiWUU0s3+m1qkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136250; c=relaxed/simple;
	bh=SBubaC/2dyR78TdRAfMdzusbN+238FcRcI5z7z2jjnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGDsPpS/Jt87lXlUX1acVhcH8HFah3SRgBlIszD8/ctburOWPbr7idMcB0DQfkFQlak21hpKqhaJwcD1g/b/bamyDs3xRCwRC4i/YvbA3e3Q75goQIAoJ9wv9oHOb3VzJ1j4B70O9UgdkS18aHk8Pnkc8aHbOP9lC92wvqRGGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=KBZWlUTW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7EEEC42FC0;
	Fri, 21 Feb 2025 12:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740136247;
	bh=SBubaC/2dyR78TdRAfMdzusbN+238FcRcI5z7z2jjnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBZWlUTWyN5bgQAUNi2L5/qtL/GRXOV7ioh9y/luURzXl3Jphnjyo5x77n0TFLtW1
	 +wLpgZrvijun/aZq18OwnJLqiHWFd2r1UusVMwKzYPo1YsdbqAXzAHGhVYl/fPP3nt
	 ZRbqOdbY8qIje9bfWiSu5XCUy1nJH+jq9kLskquTa2Y+oLxKRzvC34BxGY8biv4bKv
	 EzPoTRApatNO4Gpy/fU1cGfu7lBmdoCa+fijBG2YCR20OYzhRDkWDb7XnLKPdYaJde
	 +due+eJYRr9mXrDekqseqlJMtQ9oZkDEWO13OjGjhWrGaLOZ1qSV7St+E1WEtmIuCd
	 RkGna71M/HsLA==
Date: Fri, 21 Feb 2025 12:10:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, jgg@nvidia.com,
	kevin.tian@intel.com, maz@kernel.org, will@kernel.org,
	robin.murphy@arm.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <Z7hfNlnSj8BI6C7l@8bytes.org>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
 <87ldtzhcjv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldtzhcjv.ffs@tglx>

Hi Nicolin,

On Fri, Feb 21, 2025 at 10:28:20AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 19 2025 at 17:31, Nicolin Chen wrote:
> > Fix the MSI cookie UAF by removing the cookie pointer. The translated IOVA
> > address is already known during iommu_dma_prepare_msi() and cannot change.
> > Thus, it can simply be stored as an integer in the MSI descriptor.
> >
> > A following patch will fix the other UAF in iommu_get_domain_for_dev(), by
> > using the IOMMU group mutex.
> 
> "A following patch" has no meaning once the current one is
> applied. Simply say:
> 
>   The other UAF in iommu_get_domain_for_dev() will be addressed
>   seperately, by ....
> 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With that fixed:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Can you please send a v3 with updated commit message and all the
review/acked tags added? I will pick it up then.

Thanks,

	Joerg

