Return-Path: <linux-kselftest+bounces-31728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3DA9E000
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07DB7A47FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634424111D;
	Sun, 27 Apr 2025 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtNBnlro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598731A8F89;
	Sun, 27 Apr 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745736223; cv=none; b=VQJ4kPJw4rBN37KdzQRfNN8B6sV1U5spnQOzDS22fglAlcJoMGypz+yNgJKqgRP6kniswXUfVJHKM3Tk52FYY53ly9AVbbfX2DCRNWLuyDtwEFDyyEWT1EGZz+/HDKuI5vHf3JFTIdfGWG6qq+GjiJEwEDtrcblotpsEoSvb8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745736223; c=relaxed/simple;
	bh=Avkh+IHRFhmXquqMCTj0xnURVEaMs2AVp7RorDHEx4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOwfJd6ZSHkWbln7Bb+m+vX1NrRfGyeLHDPreBmm3NhB5gAgeYmBbB8w8XeXVeTsPUmJ7imDqBsBn9oalj9tWI9dmFMmL7TXRz9sfN6MFgba0ZvolqjgpeG9ggVhOwAWCOIyjW/0X9gafO+4d0o1zEI4AYzqdNnELSMGKlkJ2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtNBnlro; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745736222; x=1777272222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Avkh+IHRFhmXquqMCTj0xnURVEaMs2AVp7RorDHEx4U=;
  b=MtNBnlrod1lCOiqBmmR4435x00jIG7QQVsbroKMOsieuErTCLfdFDC+7
   h4XFAsUyzDiVzs24sK62lizR8Z4oVvXWwdjRFAxHgD2g89UzaaQSlC/1+
   LiiW9cNphl/CSoWD0r7QYQq2oeQH470ONbE3DfOOj/ggHnU5MSecJPVpD
   +5iGtexoCiuGObh0K2o5479Y/Wnp9c477IwbhgY7iFU3t+mUO001L9c//
   GP2lAc+3r7L5IFwF4Yir6oOSJZw3n4poxsLtV+H7PNXupH3nBtkk7Alk7
   twFqcXtXzQxTjpm1N6TVyQOR3EjCxs7s938Fqfx6is9RQEvtYlPJhWiPi
   Q==;
X-CSE-ConnectionGUID: keQoUg4vRzCN2IF4nBqGrg==
X-CSE-MsgGUID: 09+AMdaWSfKouwlyBh1UxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47430898"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="47430898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:43:41 -0700
X-CSE-ConnectionGUID: nlUKeu2LRMaehOEljfFcBQ==
X-CSE-MsgGUID: RSaSroJwTzy9u9o2IB/EVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="133732043"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:43:35 -0700
Message-ID: <6dc981fd-f093-48fc-a162-4e4e989c22f2@linux.intel.com>
Date: Sun, 27 Apr 2025 14:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/22] iommu: Add iommu_copy_struct_to_user helper
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
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:57, Nicolin Chen wrote:
> Similar to the iommu_copy_struct_from_user helper receiving data from the
> user space, add an iommu_copy_struct_to_user helper to report output data
> back to the user space data pointer.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

