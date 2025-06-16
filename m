Return-Path: <linux-kselftest+bounces-35064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC61ADAF26
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D153B3A45
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADF2EB5B4;
	Mon, 16 Jun 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCndAI6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D42EB5A9;
	Mon, 16 Jun 2025 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074879; cv=none; b=ll/cZXV+ymQPrQPeEkfqYABGGy9QkF/BoUpqOmTJlsK0LjUf7MEGIo3+RyI51UpSJycXjRlWPjyghJzIUQ+6zekjPwJOxQrHoEKh2w4COEOzmYejfPk19G4f6BEfgALnDEUrDllbPijtFAW9RfFdlvfmy+2oXjQJmsn8y88Z7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074879; c=relaxed/simple;
	bh=a4308r24XGn+BMFT+GUDp6JTrDSZTiUE/F3YsroUvUM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ou5xmJMU3kOmoLaNeBePW361mONUW4+hD4B7eRb3bDr1lMfHgwjntOxRWSNg2iQr2FuWjPW8BWCRvjgOjoKihLqtADPxKoH52Gdoyht+E7+hAnSGbEuAeiDKmx7AVtv7JKaT2JklFuFlfrBRefaDU8Y5W43O9S881YuJogI4t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCndAI6n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750074878; x=1781610878;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a4308r24XGn+BMFT+GUDp6JTrDSZTiUE/F3YsroUvUM=;
  b=MCndAI6nQbgl+aW7ifyAHQxlGUoRgSluXnyeIfbW4oqWxG8C6uXOXF66
   HT+x+k8do595YAw27leKCFR16/Dk5wCV6xijYPv1xkfvCdJr4bB/XW7vQ
   wMW4j/yH/kFV/SMYy/uvjJmx79BOjGTfi4DWaBANQ0sL/bOt+qe1imeNz
   LTWDmNfW74jSKykI1YSskelSVy19ofnezf6vbZfaaX0eiAt531A+GK5rr
   H7zgSUy1kHlQ2A+86slDVzh4KO8wFKlgmn36vM0ntLW9RQSwKvWTKIrlZ
   5La080asbJbRuGC+1mPwBwgWMvkaE4GF9jL6IA9zJHbUNUHM8DPNjaw7j
   Q==;
X-CSE-ConnectionGUID: X52ILO8SQVCmwwS3K6pFvw==
X-CSE-MsgGUID: 21Prh0tTQ360tgb8mwYStw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51323398"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51323398"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:54:35 -0700
X-CSE-ConnectionGUID: IYbJH8q2SSmGyMvltH3CVA==
X-CSE-MsgGUID: VG9tbGEyRFWbq9Pf22lypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148824406"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:54:29 -0700
Message-ID: <78d05dff-f396-4214-a7fc-f0c674144aef@linux.intel.com>
Date: Mon, 16 Jun 2025 19:54:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, bagasdotme@gmail.com, robin.murphy@arm.com,
 joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
 jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
 vasant.hegde@amd.com, dwmw2@infradead.org
Subject: Re: [PATCH v6 17/25] iommufd: Allow an input data_type via
 iommu_hw_info
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <8e1d8432fb7e11f0ed514bc96690ece1f5e47fdd.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8e1d8432fb7e11f0ed514bc96690ece1f5e47fdd.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/2025 3:14 PM, Nicolin Chen wrote:
> The iommu_hw_info can output via the out_data_type field the vendor data
> type from a driver, but this only allows driver to report one data type.
> 
> Now, with SMMUv3 having a Tegra241 CMDQV implementation, it has two sets
> of types and data structs to report.
> 
> One way to support that is to use the same type field bidirectionally.
> 
> Reuse the same field by adding an "in_data_type", allowing user space to
> request for a specific type and to get the corresponding data.
> 
> For backward compatibility, since the ioctl handler has never checked an
> input value, add an IOMMU_HW_INFO_FLAG_INPUT_TYPE to switch between the
> old output-only field and the new bidirectional field.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

