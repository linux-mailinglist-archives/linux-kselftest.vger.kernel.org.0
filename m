Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C284BC153
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiBRUob (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:44:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiBRUoa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:44:30 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907C53B47
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:44:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r7so3568407iot.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WK8jZzvHAYu7EdaYuU0zunNJGdi1tQkjpvO7VzmVYK8=;
        b=TV5SqcAIKTmxTEqsVmi7KA+GQteXXSLSpXhkfhN1b/rsNujUmfJDQ1Rcfytf/kry4m
         1pq8v56ZqJOrbifh63XpWa+pfmo1mhRKIphOaDSKAz+2SviNShkGCPpOL/YV/OzE1ktL
         oCN+t9bAJZAsIY1yqcFXx8uiITgxkngLRNNBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WK8jZzvHAYu7EdaYuU0zunNJGdi1tQkjpvO7VzmVYK8=;
        b=yAJtCB7T6CmXBCFk3G13o2FIFpVXgwFmh/f8KOQXmlr7GkBS03cySNQf1DVSmHxggu
         oP/+Rkp8E1P6wcuYsNGpi08IDhhnBbm+cK8f5QJFDZomqVgfdWlWd1ORLIvswOPjpXjo
         VT1OkvXY9DPa+0t2t3caYlVj8LfMrCvb1+BrxIpgJSYxcZC5J/e/WJczmYtXnyA7it+B
         EJZ9xJNLtaV6qyoeK6f00oGVAXEleo6/uWB82togXhuEY4BvEc89eMPJorUbUrWJIknO
         YVl8jodPysSs7H8/HhyzbPdPjuAhlTpOmAR8AReHA1GwJxn9vqIeumjjSplzUpghCvio
         xRwg==
X-Gm-Message-State: AOAM530CPsC8YxO9rD8v77i6DuK8+uCBetGXvY/R6DYgRNtl6nbvkO2p
        FU2xG5Pi1alw37jNsaGUbZcbEvkpG87JwQ==
X-Google-Smtp-Source: ABdhPJyeqm2rST3ZDcM0c0BvxxpWbiiEG5V4IURtdG4EGrDy6FHrcy16VWK7/oJ6Ffat+ZMRVQd+bg==
X-Received: by 2002:a5e:c749:0:b0:640:5ceb:d7ce with SMTP id g9-20020a5ec749000000b006405cebd7cemr5743814iop.118.1645217050628;
        Fri, 18 Feb 2022 12:44:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s18sm4905521iov.5.2022.02.18.12.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:44:10 -0800 (PST)
Subject: Re: [PATCH v3 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d9f81a0f-5f25-9304-fdca-fc164224a786@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:44:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> Hello,
> 
> The aim of this series is to make resctrl_tests run by using
> kselftest framework.
> - I modify resctrl_test Makefile and kselftest Makefile,
>    to enable build/run resctrl_tests by using kselftest framework.
>    Of course, users can also build/run resctrl_tests without
>    using framework as before.
> - I change the default limited time for resctrl_tests to 120 seconds, to
>    ensure the resctrl_tests finish in limited time on different environments.
> - When resctrl file system is not supported by environment or
>    resctrl_tests is not run as root, return skip code of kselftest framework.
> - If resctrl_tests does not finish in limited time, terminate it as
>    same as executing ctrl+c that kills parent process and child process.
> 
> Difference from v2:
> - I reworte changelog of this patch series.
> - I added how to use framework to run resctrl to README. [PATCH v3 2/5]
> - License has no dependencies on this patch series, I separated from it this patch series to another patch.
> https://lore.kernel.org/lkml/20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com/
> 
> With regard to the limited time, I think 120s is not a problem since some tests have a longer
> timeout (e.g. net test is 300s). Please let me know if this is wrong.
> 
> Thanks,
> 
> Shaopeng Tan (5):
>    selftests/resctrl: Kill child process before parent process terminates
>      if SIGTERM is received
>    selftests/resctrl: Make resctrl_tests run using kselftest framework
>    selftests/resctrl: Update README about using kselftest framework to
>      build/run resctrl_tests
>    selftests/resctrl: Change the default limited time to 120 seconds
>    selftests/resctrl: Fix resctrl_tests' return code to work with
>      selftest framework
> 
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/resctrl/Makefile      | 20 ++++-------
>   tools/testing/selftests/resctrl/README        | 34 +++++++++++++++++++
>   .../testing/selftests/resctrl/resctrl_tests.c |  4 +--
>   tools/testing/selftests/resctrl/resctrl_val.c |  1 +
>   tools/testing/selftests/resctrl/settings      |  1 +
>   6 files changed, 45 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/resctrl/settings
> 

Reviewed the patches - patches 1/5, 4/5 & 5/5 don't depend on kselftest
framework improvements. 2/5 and 3/5 are.

Please reorder the patches - move 4/5 and 5/5 up and make 2/5 and 3/5
the last in this series. Also see comments on individual patches.

thanks,
-- Shuah



