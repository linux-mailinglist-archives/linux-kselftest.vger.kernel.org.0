Return-Path: <linux-kselftest+bounces-23933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBBA01DE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4F1885518
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B313A250;
	Mon,  6 Jan 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BK5JMp4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD8182D7;
	Mon,  6 Jan 2025 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736132019; cv=none; b=HGFhIhpxwYyv0NoLKSmwvktp7iABV/WnJqLfzlfHhJyOM4nd08xoipqA44uiDhfmEK5CmBcCkezlQhjtRgEjFGt26wPH8sdvpJNKvxC9pK3DgVZB2UTemn3r7Hw5FbyfHSaQpp/D1lXwGgmivO82W89juLNjy98rEwCdPHle55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736132019; c=relaxed/simple;
	bh=ob+FMX6fj9S7JNBy4TjIUMzy4NByQm6piaqnxNepR9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie9Kynz3GONvJKq0sPeGvVKKFBaapHvHITQpCmh67/PjTEAdVUaF5/VaICXfO/2GLkVz1fcmOEj9HUoRp2h5CLPT7VR0bP/8KFND6G3TuYrgMvn8s6ETB8u9DjAQjvudKlnWDpT5zDICwfi0UqjxgHMiJ4/WH27+PGy+F9mc7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BK5JMp4Y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736132019; x=1767668019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ob+FMX6fj9S7JNBy4TjIUMzy4NByQm6piaqnxNepR9g=;
  b=BK5JMp4YmbtWBRoNUd39YuWc/KUlL9ppQknxAAdrbcQtht/0JRRfTsYc
   kyysrRZBsBOyYLd5Zdxmu0P2sQ5DEAFk/iqWd8mRnrEqWLSZZKQbqhDfN
   /CprFLfr37yCAjGqIn/azL7bhq7w3XpwezkOzL1deIGDZH5eSnHzCLFLi
   ZtgLZIYo2/RAqWZodHP3N3y7zC7p8Av2ZDq1TV2bV2W604f51JtFZJl77
   mjah2alC1aAv0eggTYKU2jCwp8EddkqF0oWTxxXZKj1dIkY1GKRWG69fq
   ERbBQd5k8FJhog7dDClcxWyA6GxTDXj6PUgZHZrFpNg06FVCck9TlprzX
   A==;
X-CSE-ConnectionGUID: 4WrOjB4+RyOd9fGIwx9Gug==
X-CSE-MsgGUID: AbfUWWFjRjC0L+CJkyslgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="40044037"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="40044037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:53:38 -0800
X-CSE-ConnectionGUID: 7LLmMcadQ7OiwX+kEigIPQ==
X-CSE-MsgGUID: PIZuysybS4yL0VfWNamrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="107172768"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:53:32 -0800
Message-ID: <d65e1a7f-8b3d-4d3b-bcd0-38ef02791ca7@linux.intel.com>
Date: Mon, 6 Jan 2025 10:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
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
 <cbf90c55a1b8fb7c9d0619d0c12362e699d2b642.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <cbf90c55a1b8fb7c9d0619d0c12362e699d2b642.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> Similar to iommu_report_device_fault, this allows IOMMU drivers to report
> vIOMMU events from threaded IRQ handlers to user space hypervisors.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   include/linux/iommufd.h        | 11 ++++++++++
>   drivers/iommu/iommufd/driver.c | 40 ++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

