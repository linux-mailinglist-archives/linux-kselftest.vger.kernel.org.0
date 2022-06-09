Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A0545559
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiFIUNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFIUNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:13:11 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4566572
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:13:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p128so3840832iof.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKc+U1SRT3lIUEwplxJ1g7gu3MxAOTky+TR86tMYBDY=;
        b=JUZ3+B9aaY9z4kkrxWoMF+Ef3bN9sgdScG3ToyXPQntscMm0g+3aLwmaNvgsOxVxsP
         csiHs3ET49gYmriaSf8MokB+6LNYE0GyCx6MBCy8wYVYZ4HhsNMfrGSPmkUfFXV+XQln
         8JO0a9KMd5gTEfMQL/D0J59R4tkKg5GJ84Rho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKc+U1SRT3lIUEwplxJ1g7gu3MxAOTky+TR86tMYBDY=;
        b=8FbmhotKLwvBbamurUZKY8Ijt3Y+2uDiiZasRR9d9lIT9T+kqe5g3vFAgxCtkWFgRv
         3c57alvC19z5aC1T7olSdO9VqBH6ABNJcQvIJdjkvkcf39t0yi2b2fyyluY5qJoy7Lgm
         mu9bJ44EdA2d7tudVORTj5HauPGxuYdqHp+rOl5sfpAbs3wZCsQ4awmnmFywAbRafLDV
         pX0qU5RKc7SAgLEiCRdoJ0eJ0r+4e7vVhjeVlRfKMw5kGpW+feF2cVb3zVJAD1AEGAPF
         ppIIxbLSb3KU94mJnf6iKax5hlCeStfFG2sB5toU+tytrFl2SVNpxMos9HiW/b/IXxgD
         F8Wg==
X-Gm-Message-State: AOAM533ztiRREyE21INcGBZoSQmwYBfeedE5qo4fwUwwzVk/p8JAsKGZ
        jmzGiSlPb0B/bGS/HlhM1Ave+A==
X-Google-Smtp-Source: ABdhPJxxtfqEc71Aqh2HSl6lJqmPNwTuyoAEY7QyE66WmYPUI1/OmqLRYr/4Z60geXCIwS6fE1fn+g==
X-Received: by 2002:a5d:9ec5:0:b0:669:29dd:252f with SMTP id a5-20020a5d9ec5000000b0066929dd252fmr15343617ioe.217.1654805589835;
        Thu, 09 Jun 2022 13:13:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c3-20020a92cf43000000b002cc20b48163sm10768655ilr.3.2022.06.09.13.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:13:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <20220603143242.870-2-mpdesouza@suse.com>
 <1e1afcc8-8df0-f35b-b39b-165ad0a6b4b9@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d608c4ba-3005-9f05-f861-8eef18d8def4@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:13:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1e1afcc8-8df0-f35b-b39b-165ad0a6b4b9@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/22 2:00 PM, Shuah Khan wrote:
> On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
>> It allows writing more complex tests, for example, an userspace C code
>> that would use the livepatched kernel code. As a bonus it allows to use
>> "gen_tar" to export the livepatch selftests, rebuild the modules by
>> running make in selftests/livepatch directory and simplifies the process
>> of creating and debugging new selftests.
>>
>> It keeps the ability to execute the tests by running the shell scripts,
>> like "test-livepatch.sh", but beware that the kernel modules
>> might not be up-to-date.
>>
>> Remove 'modprobe --dry-run' call as the modules will be built before
>> running the tests. Also remove the TEST_LIVEPATCH Kconfig since the
>> modules won't be build based on a Kconfig.
>>
>> Adjust functions.sh to call insmod and fix the check_result strings to
>> reflect the change.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>   arch/s390/configs/debug_defconfig             |  1 -
>>   arch/s390/configs/defconfig                   |  1 -
>>   lib/Kconfig.debug                             | 22 --------
>>   lib/Makefile                                  |  2 -
>>   lib/livepatch/Makefile                        | 14 ------
>>   tools/testing/selftests/livepatch/Makefile    | 27 +++++++++-
>>   tools/testing/selftests/livepatch/README      |  5 +-
>>   tools/testing/selftests/livepatch/config      |  1 -
>>   .../testing/selftests/livepatch/functions.sh  | 34 +++++--------
>>   .../selftests/livepatch/test-callbacks.sh     | 50 +++++++++----------
>>   .../selftests/livepatch/test-ftrace.sh        |  6 +--
>>   .../selftests/livepatch/test-livepatch.sh     | 10 ++--
>>   .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
>>   .../testing/selftests/livepatch/test-state.sh | 18 +++----
>>   .../selftests/livepatch/test_modules/Makefile | 24 +++++++++
>>   .../test_modules}/test_klp_atomic_replace.c   |  0
>>   .../test_modules}/test_klp_callbacks_busy.c   |  0
>>   .../test_modules}/test_klp_callbacks_demo.c   |  0
>>   .../test_modules}/test_klp_callbacks_demo2.c  |  0
>>   .../test_modules}/test_klp_callbacks_mod.c    |  0
>>   .../test_modules}/test_klp_livepatch.c        |  0
>>   .../test_modules}/test_klp_shadow_vars.c      |  0
>>   .../livepatch/test_modules}/test_klp_state.c  |  0
>>   .../livepatch/test_modules}/test_klp_state2.c |  0
>>   .../livepatch/test_modules}/test_klp_state3.c |  0
>>   25 files changed, 107 insertions(+), 110 deletions(-)
>>   delete mode 100644 lib/livepatch/Makefile
>>   create mode 100644 tools/testing/selftests/livepatch/test_modules/Makefile
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_atomic_replace.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_busy.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo2.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_mod.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_livepatch.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_shadow_vars.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state2.c (100%)
>>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state3.c (100%)
>>
> 
> Looks good to me.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Looks like this patch is moving modules under selftests. We keep modules
under lib.

I have to look at this more closely - so for now I am not okay with this
change.

thanks,
-- Shuah

