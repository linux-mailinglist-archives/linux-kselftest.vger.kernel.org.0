Return-Path: <linux-kselftest+bounces-31726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D952A9DFEB
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA99D461CDE
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177223F434;
	Sun, 27 Apr 2025 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihKM1lxl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CA1A3145;
	Sun, 27 Apr 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735771; cv=none; b=Src4kFaa/ZCN4ieVN/e2m7Bu97eH3Q9NLqCGzNeKbukEhj7PYmOfcS26Sn5j5AJFuP+Tm/YGeShuRqTn7giIeiHXN3oL92CBQHMcA7orOnnNhFRV05BZL5U1jhs2csJgo3Ium6/l3KvvvEJsEn+eHgz+LL+jVzgb6NkTeS2VkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735771; c=relaxed/simple;
	bh=nMJQw4mASCaotj7CeCbT8hl1dGmW66KZ98Yv5np3pOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/iDiC01BGwoiEiDdh19xRUK5WAOPn+hnE2tgCjjRwyJ42qOWCGWWscof6M2FpbTYS6y/Oyx4NJzEoe9QaeU+EV/1VBIiDtamzLNxnfzQxpKtTtmaTQbMygACRQRFMkHcp0kimUttQKKDyGVocAlOOeoZkFBF5NOjR2oE/8xC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihKM1lxl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745735770; x=1777271770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nMJQw4mASCaotj7CeCbT8hl1dGmW66KZ98Yv5np3pOw=;
  b=ihKM1lxl/bI/e8pa7J5Gb5VCT2Gi8yY31uKEbcXrWqeaGZEFnajhFVUX
   qHf8dUFS+xku1M+TOeGH2M5pgPHIPtdC8P9Z9WHM8oVeBd0spac3OuImv
   lf9RYIRrzBKe8I8sg+tAXzf9s1yr8QgdngzFB1UBZ+3nsOy+b5a0e2G1c
   IG8Z77zV4FcHWHI5ViiGmk5/BrW+jwCcwHh/mcXHGCRpzBQIJacx4uH3E
   2+o2iANyGUAWVX0+L5aRWJwUuvIPC+FlFXxDm8NfHjf+VN9fXicu2zEz3
   J/xq6OEKnmo2wQ3PF4rE8kVr4WTENlORB1xvKvGlrE+HTgVICcb7aaRQY
   Q==;
X-CSE-ConnectionGUID: 6YkKZODxT+6A9c60z4SLlg==
X-CSE-MsgGUID: ZkdsWK1kSDGUvpezFQFlOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="69841266"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="69841266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:36:09 -0700
X-CSE-ConnectionGUID: mBeNWfFqTZen1E8BpfidTw==
X-CSE-MsgGUID: cmIWTG8QT0iiV/8hqXye+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="138048971"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:36:03 -0700
Message-ID: <e569c927-65ff-4c0f-8922-45e404fefc5e@linux.intel.com>
Date: Sun, 27 Apr 2025 14:31:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
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
 <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:57, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
> data structure from user space via iommufd, so add a user_data to the op.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

It would be better to add some words explaining what kind of user data
can be passed when allocating a vIOMMU object and the reason why this
might be necessary.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

