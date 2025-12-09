Return-Path: <linux-kselftest+bounces-47289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA2CAF004
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 07:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D172E3004463
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A553203BC;
	Tue,  9 Dec 2025 06:10:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8D3203A9;
	Tue,  9 Dec 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765260619; cv=none; b=oZyV4xlmeezORDsVzX5vYg6VZxt4CKaENksTUTj3uVy8zowJa5l/zmSRCpS6zI37kNsds03Rfx0VgaNGzKXyGfJeOTf/5yAG4mUz7Y2Iuo09aA8Q47IoSKcRWcPLgD47kfPGa473EPIlRbcYvRvCFGEZP0G73mdaSDEvHk1KExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765260619; c=relaxed/simple;
	bh=wOJ9ca123sgJPd0zieyNSsFm4IRXy89/xqmc1NxqHBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr2XFncKhHPUwvYZHh6greE13PO5+ZHY1iXCxt/m0yWlCCAfokAOWfHGluxAnS6NW9lh2idaMYpM/rXs9IT5O82XOlc0IrhooS34NnhJG8Ud3844sGnQQuxomwadLGhk1vUWHGIQZ1mLgmIzhKWsTlgHbx38GYFBMSsqM3GG004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fg1-TZO_1765260602 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Dec 2025 14:10:06 +0800
Message-ID: <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
Date: Tue, 9 Dec 2025 14:10:02 +0800
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
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/9/2025 1:57 AM, Reinette Chatre wrote:
>> Thank you for the suggestion. How about using BIT_U8() instead of BIT()?
>> In my opinion, 8-bits type "unsigned int" is enough for "vendor id".
> BIT() is fine here. I prefer that types used by selftests are consistent, that is, not
> a mix of user space and kernel types. 
> There may be good motivation to switch to kernel types but then it needs to be
> throughout the resctrl selftests, which is not something this work needs to take on.

Thank you. I will keep BIT() here.


>> Should I split the code changes (using BIT_xx(), updates of type 'unsigned int') into a separate patch?	
> I agree this would be better as a separate patch.

Sure. I will add a prerequisite patch in this series.


>> The patch may look like:
>> -----------------------------
>> commit baaabb7bd3a3e45a8093422b576383da20488aca
>> Author: Xiaochen Shen <shenxiaochen@open-hieco.net>
>> Date:   Mon Dec 8 14:26:45 2025 +0800
>>
>>     selftests/resctrl: Improve type definitions of CPU vendor IDs
> Instead of a generic "Improve" it can just be specific about what it does:
> "selftests/resctrl: Define CPU vendor IDs as bits to match usage"

Thank you for the suggestion. The subject of the patch looks much better.


>>   In file resctrl.h:
>>     -----------------
>>       /*
>>        * CPU vendor IDs
>>        *
>>        * Define as bits because they're used for vendor_specific bitmask in
>>        * the struct resctrl_test.
>>        */
>>       #define ARCH_INTEL     1
>>       #define ARCH_AMD       2
>>     -----------------
>>
>>     The comment before the CPU vendor IDs defines attempts to provide
>>     guidance but it is clearly still quite subtle that these values are
> I wrote "clearly" in response to the earlier  patch that did not follow the quoted
> documentation, implying that the documentation was not sufficient. I do not
> think "clearly" applies here. This can just be specific about how these values
> are used ... which this paragraph duplicates from the quoted comment so either this
> paragraph or the code quote could be dropped?

Thank you for the suggestion.
The revised patch description as below:
--------------------------------------
    The CPU vendor IDs are required to be unique bits because they're used
    for vendor_specific bitmask in the struct resctrl_test.
    Consider for example their usage in test_vendor_specific_check():
            return get_vendor() & test->vendor_specific

    However, the definitions of CPU vendor IDs in file resctrl.h is quite
    subtle as a bitmask value:
      #define ARCH_INTEL     1
      #define ARCH_AMD       2

    A clearer and more maintainable approach is to define these CPU vendor
    IDs using BIT(). This ensures each vendor corresponds to a distinct bit
    and makes it obvious when adding new vendor IDs.
    ...
--------------------------------------

> 
>>     required to be unique bits. Consider for example their usage in
>>     test_vendor_specific_check():
>>             return get_vendor() & test->vendor_specific
>> -int get_vendor(void)
>> +unsigned int get_vendor(void)
>>  {
>> -       static int vendor = -1;
>> +       static unsigned int vendor;
>>
>> -       if (vendor == -1)
>> +       if (vendor == 0)
>>                 vendor = detect_vendor();
>> +
>> +       /* detect_vendor() returns invalid vendor id */
>>         if (vendor == 0)
>>                 ksft_print_msg("Can not get vendor info...\n");
> detect_vendor() returns 0 if it cannot detect the vendor. Using "0" as well as
> return value of detect_vendor() to indicate that detect_vendor() should be run will
> thus cause detect_vendor() to always be called on failure even though it will keep
> failing.

Thank you.
I got it. In original code, "static int vendor = -1;" does it intentionally.


> 
> Can vendor be kept as int and just cast it on return? This may be introducing the
> risky type conversion that the changelog claims to avoid though .... 

This is really a dilemma.
I could keep vendor as int, even thought the code doesn't look graceful. I will try to add a comment for it.
The code changes may look like:
-------------------------------
-int get_vendor(void)
+unsigned int get_vendor(void)
 {
        static int vendor = -1;

+       /*
+        * Notes on vendor:
+        *  -1: initial value, detect_vendor() is not called yet.
+        *   0: detect_vendor() returns 0 if it cannot detect the vendor.
+        * > 0: detect_vendor() returns valid vendor id.
+        *
+        * The return type of detect_vendor() is 'unsigned int'.
+        * Cast vendor from 'int' to 'unsigned int' on return.
+        */
        if (vendor == -1)
                vendor = detect_vendor();
+
        if (vendor == 0)
                ksft_print_msg("Can not get vendor info...\n");

-       return vendor;
+       return (unsigned int) vendor;
 }
-------------------------------

Thank you!

Best regards,
Xiaochen Shen

