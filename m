Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5516F220E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Apr 2023 03:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjD2B0Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347249AbjD2B0O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 21:26:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA5468F;
        Fri, 28 Apr 2023 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682731570; x=1714267570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3MViQk5cJbqCpKwe3c9u4njFfHK4UXRbtmvJlbjadrE=;
  b=PPq4pgEHC9pRsk4MevBxrVwl4sEd1cX4EE1h4fHYD3Uc4/KTWLy/ZVCd
   nY40zmGyIPuEFGrNrddGsDAYsEWJ44BD9pgLgunItSxvcqZ9A1nGo/y6o
   Cim/l1sr7itpbISlw/6rZR4nFL38r1+uRFeyYuVU7lj2RV0vajC5vggtI
   28y9ZPd0D56WkRdTbNptaqiHDVvZz5UIuK7Km04adUuWFmEgRRy2rMdU5
   pXTH2Yq0myj+ElziZdmJYnfc6t/gDh0xMG6MsyO9VWi5/sI6Xgy/iF29l
   q/JgbdMBZcM10PAjHhGvW9KIbuCWVPQRj33MKU1TiCfgDMWWtjFhL+hCj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="332218206"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="332218206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 18:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="941311401"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="941311401"
Received: from jli61-mobl.ccr.corp.intel.com (HELO [10.254.211.72]) ([10.254.211.72])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 18:26:06 -0700
Message-ID: <62b0e0ab-02b6-0789-3289-fb0d54bc93c5@linux.intel.com>
Date:   Sat, 29 Apr 2023 09:25:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Yi Lai <yi1.lai@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, shuah@kernel.org, jethro@fortanix.com,
        bp@suse.de
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        heng.su@intel.com, pengfei.xu@intel.com
References: <20230421033123.445883-1-yi1.lai@intel.com>
 <9005b73c-85c5-8296-e329-5bb87bc8c3ec@collabora.com>
Content-Language: en-US
From:   "Lai, Yi1" <yi1.lai@linux.intel.com>
In-Reply-To: <9005b73c-85c5-8296-e329-5bb87bc8c3ec@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/28/2023 8:31 PM, Muhammad Usama Anjum wrote:
> On 4/21/23 8:31 AM, Yi Lai wrote:
>> The "test_encl.elf" file used by test_sgx is not installed in
>> INSTALL_PATH. Attempting to execute test_sgx causes false negative:
> I've ran the following on next-20230427:
> make -C tools/testing/selftests O=build2 -j `nproc`
> 
> find | grep test_encl.elf
> ./build2/kselftest/sgx/test_encl.elf
> 
> test_encl.elf is being copied already. Am i missing something?
>>
>> "
>> enclave executable open(): No such file or directory
>> main.c:188:unclobbered_vdso:Failed to load the test enclave.
>> "
>>
>> Add "test_encl.elf" to TEST_FILES so that it will be installed.
>>
>> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
>> Signed-off-by: Yi Lai <yi1.lai@intel.com>
>> ---
>>  tools/testing/selftests/sgx/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
>> index 75af864e07b6..50aab6b57da3 100644
>> --- a/tools/testing/selftests/sgx/Makefile
>> +++ b/tools/testing/selftests/sgx/Makefile
>> @@ -17,6 +17,7 @@ ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
>>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
>>  
>>  TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
>> +TEST_FILES := $(OUTPUT)/test_encl.elf
> I think this isn't needed just like sign_key.o is being copied already.
> test_encl.elf is being copied.
>> 
Hi,

When using tools/testing/selftests/kselftest_install.sh

test_encl.elf can be built but not copied to tools/testing/selftests/kselftest_install/sgx/

>>  ifeq ($(CAN_BUILD_X86_64), 1)
>>  all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
> 

Regards,
Yi Lai
