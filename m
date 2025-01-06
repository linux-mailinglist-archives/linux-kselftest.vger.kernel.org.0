Return-Path: <linux-kselftest+bounces-23926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF5A01DCB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5542E18842C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24EA182D7;
	Mon,  6 Jan 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcCB7Yq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874B11CBA;
	Mon,  6 Jan 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131811; cv=none; b=c/pkXbbhAhu0lidunRXkCnWP4My842Sj5xU1ChPwXc6r7LsW+0fTcNEDke7VMBtSXJFJeZdnEf4ZDYbm3L29L0fptleM2XDfX1EqOAY3MBrYDrtm3kWS2RJDrTgAi7pdvYhTWd7DHY4xd2Ku55JjGKAAxhg6BLhTyL18Ii5UIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131811; c=relaxed/simple;
	bh=pxVIE5U9doYqO1gtr5NtmGoE9CiEo7WfZB90wEQeGPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDaF2TROkLCLYCgk7VvEUnwxsNkFy2yngRCWkj//7CYJjkxyHvQmv6aFJjJEZCEdzKpUWuktfZB4qLl8jgxOwCLdOMoHazuREMU6P2Mnn8LO1cjGzR/cKowOkaV3HzjTcaLh5BN/82eJWh0melKb4osoFYef1GOW7P5A4qgfF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcCB7Yq3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131810; x=1767667810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pxVIE5U9doYqO1gtr5NtmGoE9CiEo7WfZB90wEQeGPk=;
  b=EcCB7Yq3wMw0QijJp67DiiksyppgftytIqcUWO3E2lJveesI6+PyLi07
   QbC4FUdbvXsrjndnUMtQR5Yx7ytNyspYxMINuv3NqwDvbvV1LLVz5eUBM
   wajcQ6T2rtk0g6s7ImM8BMrn3aJ/xtwERwDCA7TZTeNFNV0FHlhiZdHLQ
   HMxRRlCbqyn2JdNYmkB4hxMAoXyWFKWKREgRjz2fgwU7VSRWZnMBogLhz
   LV15FoMRmftPbG3o3kCQYofgYCvnhd04sgjA395Rmtht6HuYbpjr0hnIm
   CaHrzEuNqfIcR8mLkGvflS6dk5Bw5ZHqud9O4QWbETawKK68Va2ypCbPa
   w==;
X-CSE-ConnectionGUID: cUJiuPhLTjmUNHOVE0mA4w==
X-CSE-MsgGUID: MD6B0BS+SS6hHfV33NKryQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="53690606"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="53690606"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:50:10 -0800
X-CSE-ConnectionGUID: pJzxby5TQBapEJrT6rfaGw==
X-CSE-MsgGUID: oskUF8ejTMuiZEUNj5l2lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125599941"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:49:50 -0800
Message-ID: <821ed0c7-20ef-4695-9da8-a8f206f4318b@linux.intel.com>
Date: Mon, 6 Jan 2025 10:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] iommufd: Keep IOCTL list in an alphabetical
 order
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <32abff935ee97fb0be3f675a2a61b535492e242c.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <32abff935ee97fb0be3f675a2a61b535492e242c.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> Move VDEVICE upward to keep the order. Also run clang-format for the same
> coding style at line wrappings. No functional change.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/main.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

