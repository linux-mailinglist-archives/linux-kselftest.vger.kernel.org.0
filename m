Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5E7BF1AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 05:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442068AbjJJDvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 23:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbjJJDvk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 23:51:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE339D;
        Mon,  9 Oct 2023 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696909898; x=1728445898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PF+Ay1nF3twFmCEuJZa/1bgtgTYEZ6w5+iXaFlgUOHU=;
  b=fY0LmTuCmSzdAw5MYsCuoryREJskeKWLWif3p1xShuDtQrCZLukTlJdp
   eEo64RWRJdXVXVW7MW704kpP7ETeXWQfLJEJqnMP6aGZnNZa3bVfuJRHX
   xahz3buwtdgmNqoNVyKB22MtZsxP4SdC8mS+OuZon0xt0liGAi6a3EFB5
   JFFzwCI2oCERmoFAhBIGXRXre++IrgoYcvlNxn6AA0ImCIs3RzGRl9ll/
   COzsN2UVqdoABFZvugPYs+N7uUL2tmZs7pYxLFBkucSSNYJxjnWMmNlpD
   Sum2OUL3VGp+tz6a2s7HVC3E2zsIZsgXiv8L7neiSVcQqqZu34vgcmV02
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5860875"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="5860875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084603772"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1084603772"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.1.136]) ([10.238.1.136])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:51:34 -0700
Message-ID: <1793b780-cd15-b6a3-f951-c19a14a1310c@linux.intel.com>
Date:   Tue, 10 Oct 2023 11:51:32 +0800
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
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230927110219.b5n3fbbwrxtcwtzp@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/27/2023 7:02 PM, kirill.shutemov@linux.intel.com wrote:
> On Sun, Sep 24, 2023 at 07:33:46AM +0800, Binbin Wu wrote:
>> Zero out the buffer for readlink() since readlink() does not append a
>> terminating null byte to the buffer.
>>
>> Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>>   tools/testing/selftests/x86/lam.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
>> index eb0e46905bf9..9f06942a8e25 100644
>> --- a/tools/testing/selftests/x86/lam.c
>> +++ b/tools/testing/selftests/x86/lam.c
>> @@ -680,7 +680,7 @@ static int handle_execve(struct testcases *test)
>>   		perror("Fork failed.");
>>   		ret = 1;
>>   	} else if (pid == 0) {
>> -		char path[PATH_MAX];
>> +		char path[PATH_MAX] = {0};
> Shouldn't it be PATH_MAX+1 to handle the case when readlink(2) stores
> exactly PATH_MAX bytes into the buffer?
According to the definition of PATH_MAX in include/uapi/linux/limits.h
#define PATH_MAX        4096    /* # chars in a path name including nul */

IIUC, Linux limits the path length to 4095 and PATH_MAX includes the 
terminating nul.


>
>>   
>>   		/* Set LAM mode in parent process */
>>   		if (set_lam(lam) != 0)
>>
>> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
>> -- 
>> 2.25.1
>>

