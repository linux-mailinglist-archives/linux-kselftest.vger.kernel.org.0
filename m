Return-Path: <linux-kselftest+bounces-23976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73297A037DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 07:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00813A4F81
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BC199FC1;
	Tue,  7 Jan 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNBWoCvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491F2594B2;
	Tue,  7 Jan 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231386; cv=none; b=Lp/Zr+di0aUVpIXztSbkPjrGJG9o4Ul4ORyrrNeEY9EwBG+SpDlhXe83jly6169fKeuX6VQbr4Vgo0KVibTkKl22UiWFeUwnlICZklrFT55e1jR8zKeANnqC1Hh1f/WoHq8vXzQq65XlJtAM2OWRvQob6Fn+SSlj/HUZROKnalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231386; c=relaxed/simple;
	bh=2ZNBQV83qRYlGIdvmpF5D7UXo7BcBAAFyvP+LUtLJ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6yWCXuq2K+tRJ4ORaXtuYxk8ItTsoQ1fhXOJcDAxRlUNzF7PFQSCCFwgp1/1KDZzY8p/xYsbU+wivudYFYQNgrbs4vXtsXQOMtgZYdRc9KTVP6GSouaiqE9Ovin0UEMCbPU/mr12rIBMuw7aGWPqfZpBFm4EWvqnGpeAgRtBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNBWoCvz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736231385; x=1767767385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZNBQV83qRYlGIdvmpF5D7UXo7BcBAAFyvP+LUtLJ7w=;
  b=UNBWoCvzsnJEGqch395+NFIK6PndJBatctHUMd5+zyjvNTFJEd+4f55x
   kmzoeF3st2KDjNmCe6Cp52x4CnQTDNK/37iibTXS9VVuYiY1nRP9LzlHG
   6ihHAnQof/BwnOEvzVosC7fGyBa3l+tU0KvWIZVZ0tieEceD+Cr8Q8m7E
   OgS1ufVDr08UjPSXo3Coq0vTjxumTTRbe6d18Zpi1OXF/bccIGpcOLlcF
   OSmQACn0UAgI8Z/ebpxGFt7ggpy2wO9ale2rlW83PnbLktyVkkQcKiRTi
   jko9b3TlCKPZ0m7kZuQzyMtKLHCI+QSYqEKe0eVVQu9bj2iEbaq49jni0
   w==;
X-CSE-ConnectionGUID: HH1f5mX4T9uklcF/lg2aVg==
X-CSE-MsgGUID: zxRoSKnXQs2oN9N315IllQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="61775234"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="61775234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 22:29:44 -0800
X-CSE-ConnectionGUID: SW9KnGenTBmE8P1OnGYz/Q==
X-CSE-MsgGUID: qJ2kkw5RQxOVafkwq6rSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106702442"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 22:29:40 -0800
Message-ID: <150e283f-1858-4282-912d-0bb78719b46b@linux.intel.com>
Date: Tue, 7 Jan 2025 14:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
 <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
 <Z3wk9TvmUhB3/zlk@Asurada-Nvidia> <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
 <75456867-8993-4be4-bcdf-14df28fe92cc@linux.intel.com>
 <Z3zDA3xx6w6dSQY+@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z3zDA3xx6w6dSQY+@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/25 14:00, Nicolin Chen wrote:
> On Tue, Jan 07, 2025 at 01:54:00PM +0800, Baolu Lu wrote:
>> On 1/7/25 12:36, Nicolin Chen wrote:
>>> +static bool arm_vsmmu_supports_veventq(unsigned int type)
>>> +{
>>> +	return type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3;
>> Do you need to check the hardware capabilities before reporting this? I
>> am not familiar with the ARM architecture, but typically it's better to
>> make it like this,
>>
>> static bool arm_vsmmu_supports_veventq(struct iommufd_viommu *viommu,
>>                                         enum iommu_veventq_type type)
>> {
>> 	if (type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
>> 		return false;
>>
>> 	if (hardware_not_capable(viommu))
>> 		return false;
> I think the ARM version of viommu_alloc op has already implemented
> enough capability checks and rejected any of hardware_not_capable.
> So, viommu shouldn't be a thing that the driver could actually use
> to call this helper 🙂

Okay, fair enough.

