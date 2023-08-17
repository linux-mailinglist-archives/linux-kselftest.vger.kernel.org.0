Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894877FD71
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbjHQSCb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 14:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354190AbjHQSCC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 14:02:02 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD42102
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 11:02:00 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c32a706b09so994387fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692295320; x=1692900120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYb4Pd47UFlcMLjK0TyKHWunAauH0WdeCKCWucrXGAs=;
        b=YbXL9Hs6z5ZuNLmZ+yLinpxkNiAnyvofipKx3SNA40CElWHpjhsMaVmhSm3YiSYMYl
         gpDh4yrPCEBHb8F9sPw0jRjHgNslCPc+WFsIUC8Wxrw4Xf3XwRxO+5EDJHe8IXB67PYn
         ZGuYoQ62+pOIxlkwfiPG4I4vLm7DQbem8afI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295320; x=1692900120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYb4Pd47UFlcMLjK0TyKHWunAauH0WdeCKCWucrXGAs=;
        b=QOpK+H0dLTwAXc1nsP3+kOqZivHWACVqW8j/mG92XhHf8CruacSg1yTpQg95tE8HQ2
         d4c2tQ0cN8bBmrofsmfD9Ocz3VFM2AVyB0JQirnOtS5B6Ql1Z20SnTQX3NutZD4COkpE
         CjjcmXBp8tVl+PsVngQpAEP0owM1OkIYQlOzW0A2dTvUYPp8WI9hBo3y/DUozJmzZj+A
         +VzvPj3jPdvy5s3pr0nYOq7T3PhS6gFEvw3os/BHGyvoafBhnzONQOawHmuFpvOiE6lD
         XEnwCwhcT/qRF7W9qN1ADnzrvdendtAKAftsxF01qbLBuKB7t0c03t2Pl+qNkYQ0yH1q
         Zv3g==
X-Gm-Message-State: AOJu0YysCIefw02x74Fib3mIuPIYXR+yon0gKrJTLStXsWHTcb+wQ4WL
        0UQLeZm54JtJd1Xc4jYvKVRMqw==
X-Google-Smtp-Source: AGHT+IHqAFbrL4qdvGW97H1r5YhxKtn+dJdhOGwnTl2VThvVgLzvX54ojzU6tKtuiGeN6/G6QY07AQ==
X-Received: by 2002:a05:6871:209:b0:1c0:d0e8:8ff5 with SMTP id t9-20020a056871020900b001c0d0e88ff5mr189976oad.1.1692295320147;
        Thu, 17 Aug 2023 11:02:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o24-20020a02cc38000000b0042b3e04510asm5035568jap.98.2023.08.17.11.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 11:01:59 -0700 (PDT)
Message-ID: <c1fd09a3-3c15-62b7-fbae-2ea04cbe06e8@linuxfoundation.org>
Date:   Thu, 17 Aug 2023 12:01:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] selftests: cachestat: test for cachestat availability
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
 <20230815155612.2535947-4-andre.przywara@arm.com>
 <59c0fcd1-a1f2-de37-c94d-76687934acd5@linuxfoundation.org>
 <20230817154754.278218ae@donnerap.manchester.arm.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230817154754.278218ae@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/17/23 08:47, Andre Przywara wrote:
> On Wed, 16 Aug 2023 11:11:49 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> Hi,
> 
>> On 8/15/23 09:56, Andre Przywara wrote:
>>> As cachestat is a new syscall, it won't be available on older kernels,
>>> for instance those running on a build machine. In this case, a run
>>> reports all tests as "not ok" at the moment.
>>>
>>> Test for the cachestat syscall availability first, before doing further
>>> tests, and bail out early with a TAP SKIP comment.
>>>
>>> This also uses the opportunity to add the proper TAP headers, and add
>>> one check for the syscall error handling (illegal file descriptor).
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>    .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
>>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
>>> index a5a4ac8dcb76c..77620e7ecf562 100644
>>> --- a/tools/testing/selftests/cachestat/test_cachestat.c
>>> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
>>> @@ -15,6 +15,8 @@
>>>    
>>>    #include "../kselftest.h"
>>>    
>>> +#define NR_TESTS	8
>>> +
>>>    static const char * const dev_files[] = {
>>>    	"/dev/zero", "/dev/null", "/dev/urandom",
>>>    	"/proc/version", "/proc"
>>> @@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
>>>    
>>>    int main(void)
>>>    {
>>> -	int ret = 0;
>>> +	int ret;
>>> +
>>> +	ksft_print_header();
>>> +
>>> +	ret = syscall(__NR_cachestat, -1, NULL, NULL, 0);
>>> +	if (ret == -1 && errno == ENOSYS) {
>>> +		printf("1..0 # Skipped: cachestat syscall not available\n");
>>> +		return KSFT_SKIP;
>> What happens when other errors besides ENOSYS? The test shouldn't
>> continue.
> 
> -1 is an illegal file descriptor, and this is checked below (still using
> the same ret and errno), but reported using the normal framework.
> This check above is done early, before we even announce the plan, so that
> we can skip *all* of the tests, since they don't make any sense when the
> syscall is not available at all.
> 
> Does that make sense?
> 

Yup. I will apply this for Linux 6.6-rc1. You will get patchbot notification
shortly.

thanks,
-- Shuah

