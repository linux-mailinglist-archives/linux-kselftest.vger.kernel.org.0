Return-Path: <linux-kselftest+bounces-35062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A6ADAEA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D6F188E5BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74DB280308;
	Mon, 16 Jun 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSdYGFHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B21DFE1;
	Mon, 16 Jun 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073698; cv=none; b=fTS9k8bY/isA08VGPde8BDmAXBAUzMoaNHrYa82WPAVlwE+HvtozuvqOvEHR8v0KCy7jC0Y+QLjIhm0z2Of1DL56LTnBpijqIFQsZcaOYvCyS9fBZIYXy2faS4qQA3T+Ncp6cM95QAIApxwe+Z2E5UNYVwXIHvdaMaJ7reLBwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073698; c=relaxed/simple;
	bh=ojHEuztj0i3yHmHmm9T4QjxP+NTevWKTFSWpUEeibRQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nwmW/GrmcCjxEpzI4O+ar/wfn2iJYYPuWytLvuN6bZtnx1W4T6iYYvZj3SSrm6Z91rpWBWcCyt7jbX1E9Zdq04mAYZiE8BEe/WZCsfzXWn4NsE7zvEzi7+gJUbpXpnfIQkaK6kl23R9Grbsy26OcI6q6smOriNCrF4MfOrmJynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSdYGFHm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750073697; x=1781609697;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ojHEuztj0i3yHmHmm9T4QjxP+NTevWKTFSWpUEeibRQ=;
  b=SSdYGFHmirv6FtK1PnJJn/K3rpi9Okjk/d5sgWej9lItMuG/C503Nesz
   0f2Hh4F2wimLnhzEBLD4MpCD+He5vqg/zXpJlXfx5dlUFZ/3KG9ztPC8C
   +RnN55yYrqVA7azZuYETTIT1jXhSPn6IXQ+4LY/hyREzDUtBmVljAvKW3
   BddkUOuj2mvM5Fnl7Da/lMzqzrVgDtPSTHhkkOWs2P4Xzs9Zik19EQldo
   mQF58rY9s+zGxZ2rA6NPKr0aZkQpn9Ycul12JKQDXDiQt3yL48lzBfurK
   tRbSM+CJ5XaVIgewY834OeM39Lu/6l7t/OaTV1E8pd45yCHHNuTxYeHlC
   g==;
X-CSE-ConnectionGUID: LF3tsWK6QvSQ19G012IJ/A==
X-CSE-MsgGUID: dE15yrUFQhCQLqGilsihoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69657837"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="69657837"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:34:56 -0700
X-CSE-ConnectionGUID: gaIal/9STnGso6QkRJ98mQ==
X-CSE-MsgGUID: u+WnkkfGQnmQxYoDn68uJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="152282524"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:34:50 -0700
Message-ID: <68fda26e-f6d8-4be3-a411-a0cea13115b9@linux.intel.com>
Date: Mon, 16 Jun 2025 19:34:47 +0800
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
Subject: Re: [PATCH v6 15/25] Documentation: userspace-api: iommufd: Update HW
 QUEUE
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6931ee1643d717f13bdc30e7dfd9eeb9fd0fafa.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e6931ee1643d717f13bdc30e7dfd9eeb9fd0fafa.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/2025 3:14 PM, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc to reflect that.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

