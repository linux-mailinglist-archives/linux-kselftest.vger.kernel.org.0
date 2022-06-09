Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637CC54553C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiFIUBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiFIUBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:01:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7A2348C1
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:00:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s23so23255094iog.13
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=72jkN4ju+goBMKslhc6TXf3gd64A5+ArY9dYo9qhEmY=;
        b=PUh5boLvty4arJJOuI+EyevD+8StTDZf3QcldSRSJ+iJqdKtaabG1FGfZPg3WsDk9U
         rvOw3KIBRn37PnYtY2z9TXwwZ6AuvgdocmZdIBwc3U2gBO/P6ItQCL8nOuvnbuvctQsm
         1XiPQUQoHgFsHJK5WjNpOKlJiwWpuewK2JLUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=72jkN4ju+goBMKslhc6TXf3gd64A5+ArY9dYo9qhEmY=;
        b=wr/SnZPAtAKCl7SgdRSsZgAtRqkVTiEGMtG7PPm9cYmggWLY3meImcoCXigWpKwXa4
         ukumhtydM2BKHjD1rkAU+3dnnxqj+h3KR5sL/u3lV/mTbd/IKg49Pp2cNSm7KM8bLLrx
         etKbVKdfpE7/k1IF+al2GDbNm+zaVQa8/gmnUhspy15pdLfN4d0FHYgW6f7/m6dSeae3
         bkteMVRj3QJSTg93ciPMcJhHOTFUvp8j7tlx5DEE1seXHuFRuzHtV+//7rMAEOIEfbYX
         hdEc32hptr5J5z2rMx28xm+k20PK6LFqDP7UvrAEQaNEx3S28CKemoRR9WFS/OlyLAzN
         Tj4w==
X-Gm-Message-State: AOAM530ISeRxlX7ISrYCZGeDJ+u4sA2JXfN9NA3pWiZujw2ho+RbkK9r
        bzG7bGwgmdqdXXncp1eD8yDIDVVVWHqzpA==
X-Google-Smtp-Source: ABdhPJwEK1Z2HX6t71F/h7JnBJYOLCK6hwa1pHD6Rrm834dgPwco6mr+p5rUrZYFsgmjIZ3rQfYlXw==
X-Received: by 2002:a05:6638:2608:b0:331:7527:ee67 with SMTP id m8-20020a056638260800b003317527ee67mr19350636jat.160.1654804857680;
        Thu, 09 Jun 2022 13:00:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a30-20020a02735e000000b0032be3784b9bsm9921952jae.117.2022.06.09.13.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:00:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <20220603143242.870-2-mpdesouza@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1e1afcc8-8df0-f35b-b39b-165ad0a6b4b9@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:00:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220603143242.870-2-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
> It allows writing more complex tests, for example, an userspace C code
> that would use the livepatched kernel code. As a bonus it allows to use
> "gen_tar" to export the livepatch selftests, rebuild the modules by
> running make in selftests/livepatch directory and simplifies the process
> of creating and debugging new selftests.
> 
> It keeps the ability to execute the tests by running the shell scripts,
> like "test-livepatch.sh", but beware that the kernel modules
> might not be up-to-date.
> 
> Remove 'modprobe --dry-run' call as the modules will be built before
> running the tests. Also remove the TEST_LIVEPATCH Kconfig since the
> modules won't be build based on a Kconfig.
> 
> Adjust functions.sh to call insmod and fix the check_result strings to
> reflect the change.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   arch/s390/configs/debug_defconfig             |  1 -
>   arch/s390/configs/defconfig                   |  1 -
>   lib/Kconfig.debug                             | 22 --------
>   lib/Makefile                                  |  2 -
>   lib/livepatch/Makefile                        | 14 ------
>   tools/testing/selftests/livepatch/Makefile    | 27 +++++++++-
>   tools/testing/selftests/livepatch/README      |  5 +-
>   tools/testing/selftests/livepatch/config      |  1 -
>   .../testing/selftests/livepatch/functions.sh  | 34 +++++--------
>   .../selftests/livepatch/test-callbacks.sh     | 50 +++++++++----------
>   .../selftests/livepatch/test-ftrace.sh        |  6 +--
>   .../selftests/livepatch/test-livepatch.sh     | 10 ++--
>   .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
>   .../testing/selftests/livepatch/test-state.sh | 18 +++----
>   .../selftests/livepatch/test_modules/Makefile | 24 +++++++++
>   .../test_modules}/test_klp_atomic_replace.c   |  0
>   .../test_modules}/test_klp_callbacks_busy.c   |  0
>   .../test_modules}/test_klp_callbacks_demo.c   |  0
>   .../test_modules}/test_klp_callbacks_demo2.c  |  0
>   .../test_modules}/test_klp_callbacks_mod.c    |  0
>   .../test_modules}/test_klp_livepatch.c        |  0
>   .../test_modules}/test_klp_shadow_vars.c      |  0
>   .../livepatch/test_modules}/test_klp_state.c  |  0
>   .../livepatch/test_modules}/test_klp_state2.c |  0
>   .../livepatch/test_modules}/test_klp_state3.c |  0
>   25 files changed, 107 insertions(+), 110 deletions(-)
>   delete mode 100644 lib/livepatch/Makefile
>   create mode 100644 tools/testing/selftests/livepatch/test_modules/Makefile
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_atomic_replace.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_busy.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo2.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_mod.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_livepatch.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_shadow_vars.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state2.c (100%)
>   rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state3.c (100%)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

