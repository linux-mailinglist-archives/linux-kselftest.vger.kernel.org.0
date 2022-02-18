Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE224BC146
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiBRUjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:39:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiBRUjx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:39:53 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88E53B47
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:39:36 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e11so5562861ils.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Owzp7ReUdsWuLc4QhsZpzCQwjgZ4ldLu5CKLQDlRO3M=;
        b=dsQWfFGCiMTZKKkTyzVrnC0tNFMqkn1VeDiBADvV+cWncrRQNRp9Dmid0j6+PC4f5n
         EpzNPPQUsOxl8Fyi94EXSYTlkUx6TZWLSG+xlnWNmc1PLPI6I2k2qSoo6WnnKr/h2nRl
         ieNzjbRA7+MLoBPhYG8ZsqaWcBxl/bvkSmY4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Owzp7ReUdsWuLc4QhsZpzCQwjgZ4ldLu5CKLQDlRO3M=;
        b=tKP0Csc3R/lZBFAEPeS47IpzzKikPV9T4OV/Q+v2TGHklpWY3ZFgCvHb3gx6oA0T5L
         XY0UUjiyPvOczGKbY43WW2R60S3m4E3g9nzfbdw8UCX6YzNp8vcScojeiN3k2CPpsQJf
         zDPsQ8mAvWORSl8NFMUQnZkcEjAJoWIV/vIsCn0BlZKg9pquko3wf74sFXA4Z5mvKUt9
         tfvDpNU1sNAnNQiu2o+u0jI3TzHz3h85pUnxm3ajf8U6PpC9ah+fa+BK5YDL+r+RGlyq
         XpF8SKPep0+99heaha6DcBC63VfBSyAYxAIrar+ioDFh4U+UftWZYSMMy35nuRxcwghI
         3Nog==
X-Gm-Message-State: AOAM531y7EL4pzdgH+Nrjbx67LXWVB7vzuqJ8ZjIuw8989muZvkKPyml
        Vt5KSG+3lMQHxA77YK3N7EPnOA==
X-Google-Smtp-Source: ABdhPJxVJ4pJJPMsDTPCsiQODKIBaR4Oamof5GieivoTGwr3QyJDB07tlQOgCrfiJ1iKax2b57oiVQ==
X-Received: by 2002:a92:3406:0:b0:2be:a7b8:4efb with SMTP id b6-20020a923406000000b002bea7b84efbmr6757465ila.67.1645216775783;
        Fri, 18 Feb 2022 12:39:35 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b24sm4989142ioc.24.2022.02.18.12.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:39:35 -0800 (PST)
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Fix resctrl_tests' return code
 to work with selftest framework
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-6-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1ebbc8d3-c04f-045c-164a-0ea8bd26422f@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:39:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-6-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> In kselftest framework, if a sub test can not run by some reasons,
> the test result should be marked as SKIP rather than FAIL.
> Return KSFT_SKIP(4) instead of KSFT_FAIL(1) if resctrl_tests is not run
> as root or it is run on a test environment which does not support resctrl.
> 
>   - ksft_exit_fail_msg(): returns KSFT_FAIL(1)
>   - ksft_exit_skip(): returns KSFT_SKIP(4)
> 

Thank for making this change to skip.

> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Some important feedbacks from v1&v2 are addressed as follows:
> 
> - It is important to highlight that a skipped test is marked
>    as successful to not unnecessarily report a feature failure
>    when there actually is a failure in the test environment.
>    => I highligted this content in changelog as follows.
>       "In kselftest framework, if a test is not run by some reason,
>       the test result is marked as SKIP rather than FAIL."
> 
> - The subject line can be made more succinct while the details are
>    moved to the commit message.
>    => I made subject line succinct and moved the details to changelog.
> 
> - How changing ksft_exit_fail_msg() to ksft_exit_skip() accomplishes
>    the goal of unifying the return code.
>    => In changelog, I explained why return code KSFT_SKIP(4) is needed
>       in kselftest framework and the return code of each function.
> 
>   tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..3be0895c492b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -205,7 +205,7 @@ int main(int argc, char **argv)
>   	 * 2. We execute perf commands
>   	 */
>   	if (geteuid() != 0)
> -		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
> +		return ksft_exit_skip("Not running as root, abort testing.\n");

Let's update the message to "This test must be run as root. Skipping..."
>   
>   	/* Detect AMD vendor */
>   	detect_amd();
> @@ -235,7 +235,7 @@ int main(int argc, char **argv)
>   	sprintf(bm_type, "fill_buf");
>   
>   	if (!check_resctrlfs_support())
> -		return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +		return ksft_exit_skip("resctrl FS does not exist\n");

Update the message to read -

"resctrl FS doesn not exist. Enable X86_CPU_RESCTRL and PROC_CPU_RESCTRL config options"

>   
>   	filter_dmesg();
>   
> 

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



