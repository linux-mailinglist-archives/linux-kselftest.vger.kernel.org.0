Return-Path: <linux-kselftest+bounces-47260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A957CAC716
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91D32301B2EB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09C1F5435;
	Mon,  8 Dec 2025 08:01:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795117BA6;
	Mon,  8 Dec 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180877; cv=none; b=dMX9aK7kd2/FQnD5kAfDO7MVtXjNjwIwA09056rU05dVwcEml6LU+qRzbg9BamASBNb99Y4E++PdhXs/4EjcJzaklTRHj+t9OC0YlYXHienNkJZ2lB2P8xGWu0BtWEoLCukoqq4SL+7LlS3iK3GJq/mzFa/tbUluf+f7agTGbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180877; c=relaxed/simple;
	bh=Ibp6ugHdL6VSNdPHgn8NM5fd1AUuAx5n38QgSy+Hq2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzY1fU+IT5XEYMdI4TKhbzZjwMeTgT+jwA9xjCCNQj+gmbUKuIYM3EmLbXOh9DAqiuWhgpNls6tIlw4SAK+dj00CzjdHLk10tRZxLEtCUsGJSwSKcJhDPTW4mhcD6kXrHh65qZT2l97JxBD13A0PTyuoeIWEtXow4t/7yxIH0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.ffQGtSx_1765180866 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 16:01:07 +0800
Message-ID: <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
Date: Mon, 8 Dec 2025 16:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Fenghua Yu <fenghuay@nvidia.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 12/6/2025 3:28 AM, Fenghua Yu wrote:
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -42,6 +42,8 @@ static int detect_vendor(void)
>>           vendor_id = ARCH_INTEL;
>>       else if (s && !strcmp(s, ": AuthenticAMD\n"))
>>           vendor_id = ARCH_AMD;
>> +    else if (s && !strcmp(s, ": HygonGenuine\n"))
>> +        vendor_id = ARCH_HYGON;
>>   
> Since vendor_id is bitmask now and BIT() is a UL value, it's better to define it as "unsigned int" (unsigned long is a bit overkill). Otherwise, type conversion may be risky.

Thank you for the suggestion. How about using BIT_U8() instead of BIT()?
In my opinion, 8-bits type "unsigned int" is enough for "vendor id".

> 
> Is it better to change vendor_id as "unsigned int", static unsigned int detect_vendor(), and a couple of other places?

Yes. It is better to update the return types of detect_vendor() and get_vendor() from 'int' to 'unsigned int'
to align with their usage as bitmask values and to prevent potentially risky type conversions.

Should I split the code changes (using BIT_xx(), updates of type 'unsigned int') into a separate patch?	

The patch may look like:
-----------------------------
commit baaabb7bd3a3e45a8093422b576383da20488aca
Author: Xiaochen Shen <shenxiaochen@open-hieco.net>
Date:   Mon Dec 8 14:26:45 2025 +0800

    selftests/resctrl: Improve type definitions of CPU vendor IDs

    In file resctrl.h:
    -----------------
      /*
       * CPU vendor IDs
       *
       * Define as bits because they're used for vendor_specific bitmask in
       * the struct resctrl_test.
       */
      #define ARCH_INTEL     1
      #define ARCH_AMD       2
    -----------------

    The comment before the CPU vendor IDs defines attempts to provide
    guidance but it is clearly still quite subtle that these values are
    required to be unique bits. Consider for example their usage in
    test_vendor_specific_check():
            return get_vendor() & test->vendor_specific

    A clearer and more maintainable approach is to define these CPU vendor
    IDs using BIT(). This ensures each vendor corresponds to a distinct bit
    and makes it obvious when adding new vendor IDs.

    Additionally, update the return types of detect_vendor() and
    get_vendor() from 'int' to 'unsigned int' to align with their usage as
    bitmask values and to prevent potentially risky type conversions.

    Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
    Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
    Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..2922dfbf9090 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,6 +23,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/bits.h>
 #include "../kselftest.h"

 #define MB                     (1024 * 1024)
@@ -36,8 +37,8 @@
  * Define as bits because they're used for vendor_specific bitmask in
  * the struct resctrl_test.
  */
-#define ARCH_INTEL     1
-#define ARCH_AMD       2
+#define ARCH_INTEL     BIT_U8(0)
+#define ARCH_AMD       BIT_U8(1)

 #define END_OF_TESTS   1

@@ -163,7 +164,7 @@ extern int snc_unreliable;
 extern char llc_occup_path[1024];

 int snc_nodes_per_l3_cache(void);
-int get_vendor(void);
+unsigned int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5154ffd821c4..0fef2e4171e7 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -23,10 +23,10 @@ static struct resctrl_test *resctrl_tests[] = {
        &l2_noncont_cat_test,
 };

-static int detect_vendor(void)
+static unsigned int detect_vendor(void)
 {
        FILE *inf = fopen("/proc/cpuinfo", "r");
-       int vendor_id = 0;
+       unsigned int vendor_id = 0;
        char *s = NULL;
        char *res;

@@ -48,12 +48,14 @@ static int detect_vendor(void)
        return vendor_id;
 }

-int get_vendor(void)
+unsigned int get_vendor(void)
 {
-       static int vendor = -1;
+       static unsigned int vendor;

-       if (vendor == -1)
+       if (vendor == 0)
                vendor = detect_vendor();
+
+       /* detect_vendor() returns invalid vendor id */
        if (vendor == 0)
                ksft_print_msg("Can not get vendor info...\n");

-----------------------------


Thank you!

Best regards,
Xiaochen Shen

