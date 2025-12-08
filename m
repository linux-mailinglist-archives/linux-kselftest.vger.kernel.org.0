Return-Path: <linux-kselftest+bounces-47245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001DCABD79
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 03:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9F130142EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 02:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC82236E9;
	Mon,  8 Dec 2025 02:27:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666D18C008;
	Mon,  8 Dec 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160839; cv=none; b=NOO2SGDMennnc/0d6/s5XuGsVMaFACLQSpNLD1wDEnoI3PhD/l2BWiplw+Up0cbgaKQBj4iZ7vU5JGu7TLUmcabSKfnI/zKn6edOlOU2m9LoVaa7WjVRfrC35/cSrGA1R5MA7I/LrBgN4XOU/ShwYZB/+BdXpiSBrP2z+9cQB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160839; c=relaxed/simple;
	bh=HMwEExCEfcuPjUdEGUzAMa9A6VAcIMHwk8yBsgXnfD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sx7IKjIGVXI4Mzmwworac+AGw1GHB+rnE8CqaNQOczTw300KdeoORxAa+iue9A65N0WbypbecTjwH43CFjlv0Xt5NUD/Kh+dq48vwsusa3HQCSaWj/IjB2Mxv9iK92l/34bOFBplpD3ZC342Eam3UX3I0y66YK0VTcVjKgmcTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.ff5mvUz_1765160824 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 10:27:07 +0800
Message-ID: <811ed52e-7917-46f6-8189-2461af1c1139@open-hieco.net>
Date: Mon, 8 Dec 2025 10:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Fix a division by zero error on
 Hygon
To: Fenghua Yu <fenghuay@nvidia.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-3-shenxiaochen@open-hieco.net>
 <00ec47f1-194b-4d85-8c8b-3200b918e1d3@nvidia.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <00ec47f1-194b-4d85-8c8b-3200b918e1d3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 12/6/2025 2:53 AM, Fenghua Yu wrote:
>> @@ -243,6 +243,16 @@ int snc_nodes_per_l3_cache(void)
>>           }
>>           snc_mode = cache_cpus / node_cpus;
>>   +        /*
>> +         * On certain Hygon platforms:
> 
> nit. This situation could happen on other platforms than Hygon. Maybe it's better to have a more generic comment here?
>          * On some platforms (e.g. Hygon),
> 

I will update the comment as you suggested. Thank you!


> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thank you!

> 
>> +         * cache_cpus < node_cpus, the calculated snc_mode is 0.
>> +         *
>> +         * Set snc_mode = 1 to indicate that SNC mode is not
>> +         * supported on the platform.
>> +         */
>> +        if (!snc_mode)
>> +            snc_mode = 1;
>> +
>>           if (snc_mode > 1)
>>               ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
>>       }
> Thanks.
> -Fenghua


Best regards,
Xiaochen Shen

