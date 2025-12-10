Return-Path: <linux-kselftest+bounces-47354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BBCB1EB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 05:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8C83063873
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 04:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAB1DDC28;
	Wed, 10 Dec 2025 04:47:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BBC148;
	Wed, 10 Dec 2025 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765342025; cv=none; b=Kb+9epr5npt8hk/nQSbXd0pgN9VhU0/7ua0huhDXTYJbwuREii/f/pX3voWCpvXAIxXgdiQ5I7j6TVAT8ZScjGfndLehC1meoaVcFns0Qy4mKg4x1eof2AMCj6vD4HtsfM138DReVoK9xx82X/HLYNeR5F3W9E2tHl8vEu+wT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765342025; c=relaxed/simple;
	bh=WhBwMpnNITrc6HpUVSdkhFjKuWlDyPs2ko+iJDx1bsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm+oc8NMSFjrmXEtCbmf9hvsSI8uugkvrDdENA0AF8go0VH3iB7NZrI/6D80wmdLRHTylmSXP1s/N1lNVS0/rJcrEtxtrE5Fum+HJGhequ70BKnGB4Q6iYeZarujvv8PKUz2CUcx2ydoClO9gZrXOMMy9JQ2NMQN+A1eIFj0uZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fgwqYvh_1765342008 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 12:46:51 +0800
Message-ID: <d28d3e39-3f09-4187-934a-19b71ce188cc@open-hieco.net>
Date: Wed, 10 Dec 2025 12:46:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Reinette Chatre <reinette.chatre@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, tony.luck@intel.com, bp@alien8.de,
 shuah@kernel.org, skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
 <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
 <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
 <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
 <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/10/2025 7:02 AM, Reinette Chatre wrote:
> I suggest this be simplified to not have the vendor ID be used both as a value and as a state.
> Here is some pseudo-code that should be able to accomplish this:
> 
> 
> 	unsigned int detect_vendor(void)
> 	{
> 		static bool initialized = false;
> 		static unsigned int vendor_id;
> 		...
> 		FILE *inf;
> 
> 
> 		if (initialized)
> 			return vendor_id;
> 
> 		inf = fopen("/proc/cpuinfo", "r");
> 		if (!inf) {
> 			vendor_id = 0;
> 			initialized = true;
> 			return vendor_id;
> 		}
> 
> 		/* initialize vendor_id from /proc/cpuinfo */
> 
> 		initialized = true;
> 		return vendor_id;
> 	}
> 
> 	unsigned int get_vendor(void)
> 	{
> 		unsigned int vendor;
> 		
> 		vendor = detect_vendor();
> 
> 		if (vendor == 0)
> 			ksft_print_msg(...);
> 
> 		return vendor;
> 	}
> 
> Reinette


Thank you very much! I will make the change in v3 patch series.

Could you help review the revised patch description for the change?
--------------------------------
    ...
    and makes it obvious when adding new vendor IDs.

    Accordingly, update the return types of detect_vendor() and get_vendor()
    from 'int' to 'unsigned int' to align with their usage as bitmask values
    and to prevent potentially risky type conversions.

    Furthermore, introduce a bool flag 'initialized' to simplify the
    get_vendor() -> detect_vendor() logic. This ensures the vendor ID is
    detected only once and resolves the ambiguity of using the same variable
    'vendor' both as a value and as a state.

--------------------------------

Thank you!
 
Best regards,
Xiaochen Shen

