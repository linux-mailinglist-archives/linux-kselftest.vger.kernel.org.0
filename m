Return-Path: <linux-kselftest+bounces-35046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D4ADA82C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169AD18910B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D71DE2BD;
	Mon, 16 Jun 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKlG62xz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F59158520;
	Mon, 16 Jun 2025 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055194; cv=none; b=fjJbuhM7M21LsydaoPcEDWL/D54k0R0j4hb32Ootwjqt0j5zSIl2XmjqMfHZaHTdu9fhhVA6djx0+EfPh1abD2bhI0e9H/i/dVsKAOxDi0b/kA3nubBKrzLASTY38kuosKTSXM7KKIxXtv04HDw/mIcPBah4/Wqeac5bdICHiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055194; c=relaxed/simple;
	bh=HM/nycRhtf8N42uu6R05gdsOLIoLfoh3SEuT7ZJryPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAD1Ql67qSV8N0ZlY+KyQTrEgBr4SxmF7Zk/LQuzYVzfIKDMbpUPlr9DE59y/rqXDnQxtADYS+Fg1sTtYHCpOdLGY4tAk5pxO/pyh0w2ro7B1YX0cH2RLNhGlcaPpLrZ0TK1DUAB1CJkr+760bQlVNVQUl+lTHfKaMVqPi33ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKlG62xz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750055193; x=1781591193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HM/nycRhtf8N42uu6R05gdsOLIoLfoh3SEuT7ZJryPI=;
  b=gKlG62xzu4UiRGbbS/8UujqNGNbmqC1NK1ykVcNIDIyFC3BakmYtgmgc
   dTLQ7mAFkZ7rjihwFcCrI7iRtEa2jFUZjNyheCUe+Mie65VW7qov6ZHE4
   qePGy4D9PHN64Aq/m8WN3TY9mmrwkAYk8cQ4DOWQO3PfRyokQRhNUDaf8
   N23gMDF6OGDRY0SLsMxx0guaULFk3knoTdotJV/cr5Dsd1zuf3Ae2vWop
   LUO9rcNuOwrd86bo5NgANLrNaQ7myI/0ZChPwXecx0MFotHWbekmaDnUY
   S9wZkJQHDa9QLBMcXeqqCAcTp8dKjg/RZ9mDGp9ahWUsoLrL2IndInyeu
   g==;
X-CSE-ConnectionGUID: uDRwicS4Q6KOZADpocBraA==
X-CSE-MsgGUID: dtDb6qwVQPCZw4SD1JeY1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69632404"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="69632404"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:26:32 -0700
X-CSE-ConnectionGUID: bbwYisgpS32dkyJ6Bx5rnw==
X-CSE-MsgGUID: cFHQS0MtTmmVQHGxTz19LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148841753"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:26:25 -0700
Message-ID: <4bee4885-3e30-4376-947e-eae881e757d7@linux.intel.com>
Date: Mon, 16 Jun 2025 14:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL for
 internal use
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com, dwmw2@infradead.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/25 15:14, Nicolin Chen wrote:
> The access object has been used externally by VFIO mdev devices, allowing
> them to pin/unpin physical pages (via needs_pin_pages). Meanwhile, a racy
> unmap can occur in this case, so these devices usually implement an unmap
> handler, invoked by iommufd_access_notify_unmap().
> 
> The new HW queue object will need the same pin/unpin feature, although it
> (unlike the mdev case) wants to reject any unmap attempt, during its life
> cycle.
> 
> To reuse the access object for the new HW queue, allow its access->ops to
> be NULL. Error out a NULL access->ops in iommufd_access_notify_unmap() to
> reject an unmap operation and propagatethe errno upwards.
> 
> Then, update iommufd_access_change_ioas() and iommufd_access_pin_pages(),
> to allow this new use case.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

