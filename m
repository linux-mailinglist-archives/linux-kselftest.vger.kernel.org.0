Return-Path: <linux-kselftest+bounces-35052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DBEADA8F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2700416C9C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923A1EDA09;
	Mon, 16 Jun 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6gEqGOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590327454;
	Mon, 16 Jun 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057811; cv=none; b=prihuV0xT5Y1vNg5/NhrCDFu/HKQ36nQKWzrge3Joq8yPkUmBFYW53DFF1/DXn0GdGgsxx3f4cqmimBtNf5gD7PXAVkGiCApQby28WLgAPHqsFvJ1WJ0FcDbe5o36hGrFngj+r30kMVJ0J9r/y0nvxpYgvRYW1+5r2Ahb5r67G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057811; c=relaxed/simple;
	bh=HhwKjP8VbV2N/fsxYWO7bqaMkvO7ZpTuQ+h5KlIDRzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1qMTlqTshHJnklix3tmJMu+Y+kszuLCcTHV2FiO8t5uuKFoR04DnHjQboTsJOT8om+0O42RmsjYtK4M7hvMg6x5sZGNNlFmR0XEp5wzz6Lni+rruJ6occAkc817ImEI8pT30OtcNxxdp6nSLc280fF8MuqoPwJmsIogo2ln5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6gEqGOE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750057810; x=1781593810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HhwKjP8VbV2N/fsxYWO7bqaMkvO7ZpTuQ+h5KlIDRzk=;
  b=N6gEqGOEfXmGXoSbrpPIHQyFhVmVdAlR/PXrM8/qI5TPEgD4vP+ucsir
   P3XKqHo0qlxCMRmkR9IRxq8WOLpksoN1V7ukm+lTv8iDdepcePfndBTDF
   AbsPxxIXBFNQiwmS/31gdIJd2p5jivZ/tScV/3yHH9CdOEMB9ENMJDY4j
   rVSbv/Qyoe7hS6K0k7ki0xjo3FKkPnpyKpuQNzEZnyJhEz2UpKQPfKxgQ
   /xGFrAodUkjtTdnC4VNj8dCCiOQie6JHazTN1TNQN8NAs2tbCLjBZcfEj
   MThVxzLDh7cR0qFaLfIAiEQh3iyGWZFX2jKRftZdOO9rx8ObBPvKP9ifi
   A==;
X-CSE-ConnectionGUID: 0+tK7ra2R1SC/BTeD5Zviw==
X-CSE-MsgGUID: 8ps4hjyqTxmoEzQlnzO8jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62465432"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="62465432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 00:10:09 -0700
X-CSE-ConnectionGUID: HFp5YyxzShG8ZygBfit8+A==
X-CSE-MsgGUID: dPn4q0uRTlCcfFecEvm0Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148225683"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 00:10:01 -0700
Message-ID: <0e3c15ab-f38f-43e3-9de0-78e8ce486aca@linux.intel.com>
Date: Mon, 16 Jun 2025 15:09:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com, dwmw2@infradead.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
 <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
 <aE+976F9zPsjtfry@nvidia.com>
 <b9a7ae65-edc6-46e9-bea0-163a51459884@linux.intel.com>
 <aE/B40NRb+GecpRi@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aE/B40NRb+GecpRi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/25 15:04, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 02:54:10PM +0800, Baolu Lu wrote:
>> On 6/16/25 14:47, Nicolin Chen wrote:
>>> On Mon, Jun 16, 2025 at 02:12:04PM +0800, Baolu Lu wrote:
>>>> On 6/14/25 15:14, Nicolin Chen wrote:
>>>>> +	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
>>>>> +	    !viommu->ops->hw_queue_init_phys) {
>>>>> +		rc = -EOPNOTSUPP;
>>>>> +		goto out_put_viommu;
>>>>> +	}
>>> Hmm, here it does abort when !viommu->ops->hw_queue_init_phys ..
>>>
>>>>> +	/*
>>>>> +	 * FIXME once ops->hw_queue_init is introduced, this should check "if
>>>>> +	 * ops->hw_queue_init_phys". And "access" should be initialized to NULL.
>>>>> +	 */
>>>> I just don't follow here. Up until now, only viommu->ops->
>>>> hw_queue_init_phys has been added, which means the current code only
>>>> supports hardware queues that access guest memory using physical
>>>> addresses. The access object is not needed for the other type of
>>>> hardware queue that uses guest IOVA.
>>>>
>>>> So, why not just abort here if ops->hw_queue_init_phys is not supported
>>>> by the IOMMU driver?
>>> .. so, it already does.
>>>
>>>> Leave other logics to the patches that introduce
>>>> ops->hw_queue_init? I guess that would make this patch more readible.
>>> The patch is doing in the way to support the hw_queue_init_phys
>>> case only. It is just adding some extra FIXMEs as the guideline
>>> for the future patch adding hw_queue_init op.
>>>
>>> I personally don't feel these are confusing. Maybe you can help
>>> point out what specific wording feels odd here? Maybe "FIXME"s
>>> should be "TODO"s?
>> Oh, I probably misunderstood the logic here. For both hw_queue_init and
>> hw_queue_init_phys, using an access object to pin the pages for hardware
>> access is necessary, right? My understanding was that pinning pages is
>> only required for hw_queue_init_phys.
> No. The access is only used by the ops->hw_queue_init_phys case.
> 
> The ops->hw_queue_init case will use the cmd->nesting_parent_iova
> directly without calling iommufd_hw_queue_alloc_phys().
> 
> This FIXME means that, when adding ops->hw_queue_init, add this:
> 
> -	struct iommufd_access *access;
> +	struct iommufd_access *access = NULL;
> ...
> -	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> +	if (ops->hw_queue_init_phys) {
> +		access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> 
> Also, the other FIXME guideline states that these two ops should be
> mutually exclusive. So, add this too:
> +	if (WARN_ON_ONCE(ops->hw_queue_init &&
> +			 ops->hw_queue_init_phys)) {
> +		rc = -EOPNOTSUPP;

Okay, above matches my understanding. Thanks for the explanation.

Thanks,
baolu

