Return-Path: <linux-kselftest+bounces-28752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3FA5C9EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E967A697C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9C261599;
	Tue, 11 Mar 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBQQntQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289226158C;
	Tue, 11 Mar 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708572; cv=none; b=Fa+d1UfSuJq1ueakiMCvo6YUXFvTL9fWWU3JfkzQYGnZv7HFGIPQGrQ6j0eQe9zkE1CyJAla69b9/3vA9afoKgzqJGwXlOhr1kiUrKNylY8Q+5jFlB7x7g+XLyc/j3JudJltcUJD6H34u681qU1GQMp10ffcKZyXEXG5dCw9SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708572; c=relaxed/simple;
	bh=WOD9YXSZJSsUah42YQG9e0FFUMU6LOcUUbHhH1HrEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU7k9n2uLv5h9ciB3l+6uXBxEQtYKWvA5hnxZKuL+J4pxNovCjTLL7rVqTUnA2FB8f2A5Z3htBwkNyKIYlx0jL1mY2BgugSIjg7/Jxow4TW0AXaSrw38eKbyBwjtlDcMBoH9yi3xrgayx7r21uN9IUndtTJzwsSOPdRVYu1m5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBQQntQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E2BC4CEF8;
	Tue, 11 Mar 2025 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708570;
	bh=WOD9YXSZJSsUah42YQG9e0FFUMU6LOcUUbHhH1HrEIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBQQntQA1R+j3qafaEL1jZtkhTsmjlsv/zv9uSVqkUw1X4hLlQ6kBf3bRWEozlIUa
	 EqR9O4ZIdtinIIaddOnR7M0YqWEv+rU84w9pt6dTQUk/2XLLJngY7q5T1x7Us8h+gq
	 b1IR6RNoH9miWzGOEAujHc5vw8Bd6f4KxN4x6//ID1kvPRHeYHUG+9Je48tSpohuLb
	 1UmgashYH4PzfVY6JMn1V/1RymsT2SRu9SoWM0G1N1rv8ksb5I8QEXsq2hBLG6GRSH
	 bbPTRAlXtTOMYZv9u4O7lsmj/lzHhvaMA0Tem6wlMiPFfNVEfOzTa9kdlJlkfa7aG+
	 9Ad00t9hyTP7A==
Date: Tue, 11 Mar 2025 15:56:02 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v8 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <20250311155602.GA5138@willie-the-truck>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f465dd9defdc0fc748c2fa2cfc829e37778a4ced.1740504232.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 25, 2025 at 09:25:42AM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> In the future, we might want to enable the MEV for non-nested cases too
> such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

