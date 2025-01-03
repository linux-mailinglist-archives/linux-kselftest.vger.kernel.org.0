Return-Path: <linux-kselftest+bounces-23839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31397A00245
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 02:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A51883E11
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3C148FE6;
	Fri,  3 Jan 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z905Qmmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241E3232;
	Fri,  3 Jan 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867308; cv=none; b=L1Mi+Knlo5TNPvGkpCZMyUt10jr/IotH+GTyrZVFwE2vIcnW5OlE97qEIuwG8sGjAQesPkAFCE/Lqjot4PXYqC03vQHfpz+DAqIC0caynGnbfZOHYk7CLy27pmwB1LseAWey+qWRqcDPoTmot7wx/RP3h0RKBCFkg+cGYPqf2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867308; c=relaxed/simple;
	bh=oERkHMNpZAO8boq4patQNzNmzLxeyP9280etk+NkYxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRxy6EFy5pUuA4enRT8V/8YflH3TrMTOlBAWhW/R3DPxYxGMtQipvwjMLLuWVzUIey03ynD4zFDSh4NXFuimKkdID/60/JJlFtUF2OaDIBzaN91NkgED9SaJgiJWomFO6S10Y9SK3Nt7ZbO/04Je+iyBX3zPW6PJOnDUpU4Ak2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z905Qmmd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735867306; x=1767403306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oERkHMNpZAO8boq4patQNzNmzLxeyP9280etk+NkYxI=;
  b=Z905QmmdNQci19gRstTjWicXbs7a4GuJc0bHNe8N8YB93A9IatqzQZ4P
   MG8OWPOMm6kB/P7C1U0IAlh1cMBvLv75A5bYfQCEPKoAqS04bAswQlEzL
   AzZMcD5L9U/4cL8dUV1pvCLEYSL6iIybunV5/wrVPV2CAzsqQvZVuHE6M
   apPzAFENAtapHhWAmJETibz+W+UitHDRliOTDMADESm296YYKZsT5ua8z
   T7EecfKSSDnwLPivWW1qN4LDHo0l6BsCOkN/agifTo5k2RszEl+5xUDxK
   1x8Oi/d8stS+MA6dPhG7h6MwVGADxsRR7PF0yQQoPQciH+ENyedlPT/h/
   g==;
X-CSE-ConnectionGUID: DsLc9JjLRUGXpFkuOeRIeQ==
X-CSE-MsgGUID: rsXLqi6mQvCyi7HOpq74Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="36277847"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36277847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 17:21:46 -0800
X-CSE-ConnectionGUID: l7d9TjMyT3+vsV64Qnxyyw==
X-CSE-MsgGUID: haCY/+8GQc64Sj1azNOVCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106695561"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 17:21:40 -0800
Message-ID: <33d397ce-c324-4594-9f83-8f7e513e86e7@linux.intel.com>
Date: Fri, 3 Jan 2025 09:19:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
 will@kernel.org, corbet@lwn.net, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, eric.auger@redhat.com, jean-philippe@linaro.org,
 mdf@kernel.org, mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
 <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
 <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
 <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
 <20250102202955.GE5556@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250102202955.GE5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/25 04:29, Jason Gunthorpe wrote:
> On Mon, Dec 23, 2024 at 10:28:32AM +0800, Baolu Lu wrote:
> 
>> However, considering page fault scenarios, which are self-contained but
>> linked to a hardware page table (hwpt), introduces ambiguity. Hwpt can
>> be created with or without a vIOMMU. This raises the question: should
>> the page fault message always report the iommufd device ID, or should
>> the reporting depend on whether the hwpt was created from a vIOMMU?
> I think every single event record read from the FD needs to clearly
> specify what its fields are.

That would work.

> Page fault need to clearly say it's field is a device ID.

Each field of fault message has been specified in uapi/linux/iommufd.h.

---
baolu

