Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF950EC79
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiDYXQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiDYXQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:16:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796419F394
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:13:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 125so17565724iov.10
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hVW/zCoxHhKAXkYkOGavI6nF6v92eF3OlqPZcVw/Sm0=;
        b=GzXFoeQdCob2VkAjvbzEz1wYUBU8wwpfUaSeNiMLHxmcXZRMWpnvPV+2+VsqY5AN+i
         2lS0xX2Dt4X2X+u/FzOdvC2T3LhoNFckp8gVrJ2hCllKoIckFc5mb8eTcUH7oeJPvdC8
         hUDbjF8pCsOwz2itHQQfzIOpG7ii3MC+O5G9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVW/zCoxHhKAXkYkOGavI6nF6v92eF3OlqPZcVw/Sm0=;
        b=t451rg17Jj3arlke3b/RM3c9gtw6s0SFSOL2JYCHojgOYW5rxbVaKkyka4FI+JPhWI
         78BO7c2W2H4eiq4aeVFkDDrS5G9SDb8mNkgCZNXFVcDbgWgxdb32XbCoTDvq4eNyrdwe
         RofIpY+r2p5ACtg3FtbjPwXWcF4Kc3Td+xE2XVFc+bBGkYRRLURQmxyO+Es/1hImZFNz
         9pljZuwx4cfjWyyTzkMIjUjcKyS4cGrvx+YWHd+W2N6CM3O+fW77T6h8NZjjwX0xu7rc
         TxDBNnYhADnxzUbeZkWP3jyJefpXATQbGjVZ4KPfQ8wlgywr8dlk+KkzUr1sdcmhqTMZ
         M2ww==
X-Gm-Message-State: AOAM530aJmTmHfVmFCoXWBziHnNhmai4hHz9nWPo8G2S8e9JvNK/hiUj
        Ae3ut4p1WBx0C5wmNX5WgAA/RQ==
X-Google-Smtp-Source: ABdhPJyglNKOV4p0zGN3oZDXKFKIGr7ZfRtqFnfzagOQvqvDQgmbkqiMd9UiPc4DuoF4MTx9Ql/8hw==
X-Received: by 2002:a05:6638:4303:b0:328:95b9:f8b0 with SMTP id bt3-20020a056638430300b0032895b9f8b0mr8822753jab.288.1650928400783;
        Mon, 25 Apr 2022 16:13:20 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w2-20020a92c882000000b002c81bffee08sm6919287ilo.55.2022.04.25.16.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 16:13:20 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] selftests/resctrl: Add resctrl_tests into
 kselftest set
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e2f148cc-444c-f171-7364-587db92b60cb@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 17:13:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/22 2:12 AM, Shaopeng Tan wrote:
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
> Difference from v6:
> - Fixed the typos.
> https://lore.kernel.org/lkml/20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v6]
> 
> This patch series is based on 'next' branch of linux-kselftest.
> Note that Patch [4/6] uses KHDR_INCLUDES which is introduced by a patch
> on 'next' branch of linux-kselftest (not merged in mainline yet)
> linux-kselftest: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> 
> Shaopeng Tan (6):
>    selftests/resctrl: Kill child process before parent process terminates
>      if SIGTERM is received
>    selftests/resctrl: Change the default limited time to 120 seconds
>    selftests/resctrl: Fix resctrl_tests' return code to work with
>      selftest framework
>    selftests/resctrl: Make resctrl_tests run using kselftest framework
>    selftests/resctrl: Update README about using kselftest framework to
>      build/run resctrl_tests
>    selftests/resctrl: Add missing SPDX license to Makefile
> 
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/resctrl/Makefile      | 19 +++------
>   tools/testing/selftests/resctrl/README        | 39 +++++++++++++++----
>   .../testing/selftests/resctrl/resctrl_tests.c |  4 +-
>   tools/testing/selftests/resctrl/resctrl_val.c |  1 +
>   tools/testing/selftests/resctrl/settings      |  3 ++
>   6 files changed, 45 insertions(+), 22 deletions(-)
>   create mode 100644 tools/testing/selftests/resctrl/settings
> 

Applied now to linux-kselftest next for 5.19-rc1

thanks,
-- Shuah
