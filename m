Return-Path: <linux-kselftest+bounces-35061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA54ADAEA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32F018907A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44832DA763;
	Mon, 16 Jun 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XacZ9Hv+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBF2D5C71;
	Mon, 16 Jun 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073616; cv=none; b=ahCNGZBtjSgRpzT9XJC96i2NGV7LH/ud49IO/0UoxWaAMlTulRJEIf19MSlsTCjnI9rf3AqiIWKZ//V/VlegkA73BTSj+PPFos7Aua/ks4Egzk63Hd6o07Fin9GaDc4XGPBw62P6pRgRgX29EfsqaJYzxIqUIfchebqw6po/OaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073616; c=relaxed/simple;
	bh=TaASRe4qgqRwxxXiP0Y/pcupbVmXyYU7JDAROJSiwPw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rdO0Fnl4bWmKNr2y1tVMeOOeYa4srkTYfo+YSS0qkrYl4JAfUbYzgZ0I3v4aSW6zu3bXEgaOOREodLL+FF7vTqdayoLmqUD01RBlpQoOtuQA1+jmjTjIgxAINBhNzMhV8r0xkXB0LXJZEuokYDGpbfGX25/Ko+5nyRNGRupaezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XacZ9Hv+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750073615; x=1781609615;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TaASRe4qgqRwxxXiP0Y/pcupbVmXyYU7JDAROJSiwPw=;
  b=XacZ9Hv+jo2WeIQQWA2hO40n9JT6mSf2WQHFiXR5/p62QyjDhd6MUQZo
   om+4ObtCh3ZPUrNi7zO2lPX4COvFKeCFkXIkbSoXdq0EkafGjSk5jAGoH
   edIXe3SKuwzENwmTyMVVTtOvPBlhmhLHSxzh74BLSXLaPyyal851eHtO8
   XyJnRCe4Z1eJ5BWTpHrln69dIvvzPwcTMUp4s3vlzWXFg2KuYvB/p+/1I
   0WA3XzguNCThCBew7aqO2bj/fChN+HE25WmLxZ87zfb3ShtQN3HQVEiml
   myDhJKtgq6CHFls7wwzkz7nz3OZewBvHkgD4Mo3yZAhA3RBHfOC1u33PY
   Q==;
X-CSE-ConnectionGUID: hzFXzcsTTM6k2byiDV7H4A==
X-CSE-MsgGUID: VXvQCjjJQzG6XHgyVv+YMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="56014285"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="56014285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:33:33 -0700
X-CSE-ConnectionGUID: iWMVCjyURKeZAdHUUOXn7g==
X-CSE-MsgGUID: 7yInmTY6T6CqB6tjeGUWbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="179345988"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:33:25 -0700
Message-ID: <a774510d-bc55-4ea5-bc1a-2d31cb5bf589@linux.intel.com>
Date: Mon, 16 Jun 2025 19:33:22 +0800
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
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/2025 3:14 PM, Nicolin Chen wrote:
> For vIOMMU passing through HW resources to user space (VMs), allowing a VM
> to control the passed through HW directly by accessing hardware registers,
> add an mmap infrastructure to map the physical MMIO pages to user space.
> 
> Maintain a maple tree per ictx as a translation table managing mmappable
> regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
> where it stores the real PFN range for an io_remap_pfn_range call.
> 
> Keep track of the lifecycle of the mmappable region by taking refcount of
> its owner, so as to enforce user space to unmap the region first before it
> can destroy its owner object.
> 
> To allow an IOMMU driver to add and delete mmappable regions onto/from the
> maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

