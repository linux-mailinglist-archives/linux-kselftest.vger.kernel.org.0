Return-Path: <linux-kselftest+bounces-47261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD526CAC755
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 09:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91AC2301C953
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66EB2D5A13;
	Mon,  8 Dec 2025 08:07:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A21136672;
	Mon,  8 Dec 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181234; cv=none; b=dsF+Yje3lLdm9Cqu+XdV6UtmEIxK0sIh+XDQngR+crBfbgWjC6zyBPepglTnT/PRe9LgKRu9L5psdhF8FmAvIBhBz6O+NdOD1YqcHBqBJHGpzZdjErCYvehmO8PhcvMQ7/+HhVvW3zcXmk4W+BdrHgZeOZhvwDmfl0lxZKUozGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181234; c=relaxed/simple;
	bh=QOXZS/6ShKKm/1oNO2hfiIh6Z9RhdrVKF2FzcpojzOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioEGgeD8IpM4pQFvVUGizxhQjgoZAtrlXcVMXcIV0reKSDyDGCbRiWkbxAe8RWIhPEQRlGp5M6lw1w5tbBEx5LRv8PyrtUnufzxb4m0jTI1QmZnkfrNs3PTCrJZ+hy5FJGYXkb19er+kcy8QXA9xYJoTKyTab64NawpTrw+4DHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.ffHc5IZ_1765181219 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 16:07:01 +0800
Message-ID: <4a87af74-7656-491a-8bab-48074a4341a2@open-hieco.net>
Date: Mon, 8 Dec 2025 16:06:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/resctrl: Fix non-contiguous CBM check
 for Hygon
To: Fenghua Yu <fenghuay@nvidia.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-4-shenxiaochen@open-hieco.net>
 <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 12/6/2025 3:39 AM, Fenghua Yu wrote:
>>     static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   {
>> -    /* AMD always supports non-contiguous CBM. */
>> -    if (get_vendor() == ARCH_AMD)
>> +    /* AMD and Hygon always supports non-contiguous CBM. */
>> +    if (get_vendor() == ARCH_AMD || get_vendor() == ARCH_HYGON)
> 
> nit. Better to avoid call get_vendor() twice (or even more in the future)?
> 
> unsigned int vendor_id = get_vendor();
> 
> if (vendor_id == ARCH_AMD || vendor_id == ARCH_HYGON)

Thank you! I will update the code as you suggested.

> 
> 
>>           return true;
>>     #if defined(__i386__) || defined(__x86_64__) /* arch */
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thank you!


> 
> Thanks.
> 
> -Fenghua


Best regards,
Xiaochen Shen

