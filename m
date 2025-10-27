Return-Path: <linux-kselftest+bounces-44136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03629C0FEE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF4854E77C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8526316918;
	Mon, 27 Oct 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcOw3B6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A066FBF;
	Mon, 27 Oct 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590054; cv=none; b=g1Xtakq1V/K8BXiez/hYyskRjWbHUx0SoSvOuCxLNnC7z3jzBWzeAOvnFTTae+85exHifjFId6aSP/qZSjbed2lu0UNOAIiJQf7wxplEzK4H3MkGE5MQKw+xXuWyxn7w/8DwVs6JkEttae+8CF6aF9gQDNvyOSMTgEdo5o4i/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590054; c=relaxed/simple;
	bh=Sjtta4buWzcQQnNBIyYVFESl5qf6B112yZ9sf+V7RlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4GstgZ7o+OaApZejtqg/wqUXPHr03pZQpk6k6Xp/RCEKvifiHwa0aU41eum8Yp6HUeE7ChpWhD41Km+FipEVEOwfTWShzKepo38l7vrV3r40GXgItQkkiMTKx/ehuLY/5avByzyK64jzOvoWpuLfRlD+AhhG7TiG22AfoZ55Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcOw3B6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32138C4CEF1;
	Mon, 27 Oct 2025 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590053;
	bh=Sjtta4buWzcQQnNBIyYVFESl5qf6B112yZ9sf+V7RlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcOw3B6lf9oxjJTjftncCDpwlUt2yrNGODV2N6B9UbzbWoYuWLIIfAJG8fGn55XDq
	 XxUqYjtDesWP4JGFiTebJN74VNQk47kNcrSgL7ZZyJ/Sn7cSlbbA+DWgHdWwl2FqvO
	 9g1wV05Ym5OBWOMFiBvPtcJR93d4W0mNeQICsbkJWSfiMqtdDVdiV4jyxaCikFVZaH
	 3AxJFgdThBjGR/8FqQQ0rtNTgOvWDxvwbxQ4cG3ovGFkgePgBdOOz7bE7QPfcSMVtv
	 P9fYGH8FzU3VGwM2da/CvNJk33SuLt54GCoggM9zF/1TuZbaXMwOZWTVwGGFeYClrD
	 V42LSpx3BFjug==
Date: Mon, 27 Oct 2025 20:34:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev, Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/8] Initial DMABUF support for iommufd
Message-ID: <20251027183409.GO12554@unreal>
References: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>

On Mon, Oct 27, 2025 at 02:30:59PM -0300, Jason Gunthorpe wrote:
> This series is the start of adding full DMABUF support to
> iommufd. Currently it is limited to only work with VFIO's DMABUF exporter.
> It sits on top of Leon's series to add a DMABUF exporter to VFIO:
> 
>   https://lore.kernel.org/all/cover.1760368250.git.leon@kernel.org/

<...>

> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf
> 
> The branch has various modifications to Leon's series I've suggested.

I'm working on v6 these days.

Thanks

