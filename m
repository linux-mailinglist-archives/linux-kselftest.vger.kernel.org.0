Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F207BF597
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379476AbjJJIVB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442856AbjJJIUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 04:20:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E5FC;
        Tue, 10 Oct 2023 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696926012; x=1728462012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CVDY86Kq17Gy1keBALdJS87eRrKs2wjwnGupzMLRVQI=;
  b=JmSBrg92cwye/m+aRN4vQs6/kl5O/HRBd9S7rbKkgTMvoZW3As+LmS7z
   RW+TFDEMzvYAuth4Q+hhWh2y62fZVHt7CMizcZpQiaTMgbrRzdB+z4UT4
   NHqtV1qb+ooBrzzr4m5I+HYgIJkSznsLrxKg8EyAlj4uKYLRhj+G08W2c
   AdYuGC+sVDP4jJc1r9fSShxPxqneMWoo5jJ0pgTVPiaWEH60I8xmldUrr
   FvhYk5/noPUKf2nLQQEXX/9boMf8o2zTzHoHdt8pS88I3TTmJGB4aIhs0
   beSAyWdoKxOmX0SWYxKRo0qhkn+GYmsBqOwCaJ3cyUt33edLBFoVKKfaY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383216838"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="383216838"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="927054957"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="927054957"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.1.136]) ([10.238.1.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:20:05 -0700
Message-ID: <a6bb7412-0398-97b2-d20e-33bbff260b5a@linux.intel.com>
Date:   Tue, 10 Oct 2023 16:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests/x86/lam: Zero out buffer for readlink()
To:     kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, weihong.zhang@intel.com
References: <20230923233346.12726-1-binbin.wu@linux.intel.com>
 <20230927110219.b5n3fbbwrxtcwtzp@box.shutemov.name>
 <1793b780-cd15-b6a3-f951-c19a14a1310c@linux.intel.com>
 <20231010054631.kud3zvv57je2buad@box.shutemov.name>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231010054631.kud3zvv57je2buad@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/10/2023 1:46 PM, kirill.shutemov@linux.intel.com wrote:
> On Tue, Oct 10, 2023 at 11:51:32AM +0800, Binbin Wu wrote:
>>
>> On 9/27/2023 7:02 PM, kirill.shutemov@linux.intel.com wrote:
>>> On Sun, Sep 24, 2023 at 07:33:46AM +0800, Binbin Wu wrote:
>>>> Zero out the buffer for readlink() since readlink() does not append a
>>>> terminating null byte to the buffer.
>>>>
>>>> Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
>>>>
>>>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>>>> ---
>>>>    tools/testing/selftests/x86/lam.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
>>>> index eb0e46905bf9..9f06942a8e25 100644
>>>> --- a/tools/testing/selftests/x86/lam.c
>>>> +++ b/tools/testing/selftests/x86/lam.c
>>>> @@ -680,7 +680,7 @@ static int handle_execve(struct testcases *test)
>>>>    		perror("Fork failed.");
>>>>    		ret = 1;
>>>>    	} else if (pid == 0) {
>>>> -		char path[PATH_MAX];
>>>> +		char path[PATH_MAX] = {0};
>>> Shouldn't it be PATH_MAX+1 to handle the case when readlink(2) stores
>>> exactly PATH_MAX bytes into the buffer?
>> According to the definition of PATH_MAX in include/uapi/linux/limits.h
>> #define PATH_MAX        4096    /* # chars in a path name including nul */
>>
>> IIUC, Linux limits the path length to 4095 and PATH_MAX includes the
>> terminating nul.
> Consider the case when kernel bump PATH_MAX to 8192. The binary that
> compiled from lam.c against the older kernel headers will get compromised.
>
> Increase the size of the buffer by one or pass PATH_MAX - 1 as buffer size
> to readlink(2).

Make sense, thanks!
I will send a new version as following:

diff --git a/tools/testing/selftests/x86/lam.c 
b/tools/testing/selftests/x86/lam.c
index eb0e46905bf9..8f9b06d9ce03 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -573,7 +573,7 @@ int do_uring(unsigned long lam)
         char path[PATH_MAX] = {0};

         /* get current process path */
-       if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+       if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
                 return 1;

         int file_fd = open(path, O_RDONLY);
@@ -680,14 +680,14 @@ static int handle_execve(struct testcases *test)
                 perror("Fork failed.");
                 ret = 1;
         } else if (pid == 0) {
-               char path[PATH_MAX];
+               char path[PATH_MAX] = {0};

                 /* Set LAM mode in parent process */
                 if (set_lam(lam) != 0)
                         return 1;

                 /* Get current binary's path and the binary was run by 
execve */
-               if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+               if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
                         exit(-1);

                 /* run binary to get LAM mode and return to parent 
process */


>

