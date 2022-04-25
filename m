Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E750EB12
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiDYVMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbiDYVL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:11:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54BF6EC54
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:08:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r11so10207056ila.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dj+5dMDCvTEJVrzKshB6b4DWctTjsJvqWQXJDIVQeFI=;
        b=T7qeLWhHLe2L9Vg52i6AG8Hs+RgH6Mmrb8hHTcn5yaZhHwEoLdKdU2Clgb5TM/+tRS
         opYDp6Pg0WTZbd6StdorlMTT/7PjvKuNne2tok460ybXxEP1zB2tjYUtzRFztm8vlcee
         qU4up4WkTz3KBH7CLgVC3kqgMpyIT7MAb5K+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dj+5dMDCvTEJVrzKshB6b4DWctTjsJvqWQXJDIVQeFI=;
        b=V9hpzGix4LVIMMYHcJ9oiKCPWROR5kXg0UHhBed9qGl9/xe9Rpl3G7RNflCN45guFP
         fTtDlWLNxWsCLFNkX3hXEXFhZ01ViZ2L00HiZPBnSQti/tIofNCzmx28KK8w0gMhfEOe
         3iHCKaYtbAcuJXREXrdLyMZwLL8ixwnPKCGslMSGez+BYKzyEXDnnCmHDRy00S9Slhz5
         BfmZVJTBvk0kvFO1WO2DzoubuRuhNw088gW3Loxj8fjaP/LAb+WUKExBeKJweetDcxxK
         8YPSrWHnd7JWJW4Hz5ThAG0tTQmIlnHvQdoT8fKkdPiRh0pF1RjHkszmV6Gt2+vTBs3C
         jlXw==
X-Gm-Message-State: AOAM532aiRZIpAAB+aeKRoeUTnCAkO2HgguWGjPHWpZKCYpmcujtNvTn
        EnufqDQAzf9xBQGFNfGWoQiFaA==
X-Google-Smtp-Source: ABdhPJwBA6xDBIMr99W5DdIl70hnEvTF5gi4r05yFSv1MS8iw9Qcz39YRvxWB1lgM6Hvmq4zXvCikA==
X-Received: by 2002:a05:6e02:1a6b:b0:2cc:1eef:9c8c with SMTP id w11-20020a056e021a6b00b002cc1eef9c8cmr8143340ilv.256.1650920933998;
        Mon, 25 Apr 2022 14:08:53 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f10-20020a05660215ca00b0064d25228248sm8430892iow.11.2022.04.25.14.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:08:53 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] selftests: Remove duplicate CPUID wrappers
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, sandipan@linux.ibm.com,
        fweimer@redhat.com, desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1650918160.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c34b6dd7-fbae-3105-a8a9-c18957dc7ca2@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 15:08:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1650918160.git.reinette.chatre@intel.com>
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

On 4/25/22 3:01 PM, Reinette Chatre wrote:
> Changes since V2:
> - V2: https://lore.kernel.org/lkml/cover.1647360971.git.reinette.chatre@intel.com/
> - Rebased against v5.18-rc4, no functional changes.
> - Add text in cover letter and first patch to highlight that
>    the __cpuid_count() macro provided is not a new implementation but
>    copied from gcc.
> 
> Changes since V1:
> - V1: https://lore.kernel.org/lkml/cover.1644000145.git.reinette.chatre@intel.com/
> - Change solution to not use __cpuid_count() from compiler's
>    cpuid.h but instead use a local define of __cpuid_count()
>    provided in kselftest.h to ensure tests continue working
>    in all supported environments. (Shuah)
> - Rewrite cover letter and changelogs to reflect new solution.
> 
> A few tests that require running CPUID do so with a private
> implementation of a wrapper for CPUID. This duplication of
> the CPUID wrapper should be avoided.
> 
> Both gcc and clang/LLVM provide wrappers for CPUID but
> the wrappers are not available in the minimal required
> version of gcc, v3.2, that the selftests need to be used
> in. __cpuid_count() was added to gcc in v4.4, which is ok for
> kernels after v4.19 when the gcc minimal required version
> was changed to v4.6.
> 
> Copy gcc's __cpuid_count() to provide a local define of
> __cpuid_count() to kselftest.h to ensure that selftests can
> still work in environments with older stable kernels (v4.9
> and v4.14 that have the minimal required version of gcc of
> v3.2). Update tests with private CPUID wrappers to use the
> new macro.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Suchanek <msuchanek@suse.de>
> Cc: linux-mm@kvack.org
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> 
> Reinette Chatre (4):
>    selftests: Provide local define of __cpuid_count()
>    selftests/vm/pkeys: Use provided __cpuid_count() macro
>    selftests/x86/amx: Use provided __cpuid_count() macro
>    selftests/x86/corrupt_xstate_header: Use provided __cpuid_count()
>      macro
> 
>   tools/testing/selftests/kselftest.h           | 15 ++++++++++++
>   tools/testing/selftests/vm/pkey-x86.h         | 21 ++--------------
>   tools/testing/selftests/x86/amx.c             | 24 ++++++-------------
>   .../selftests/x86/corrupt_xstate_header.c     | 16 ++-----------
>   4 files changed, 26 insertions(+), 50 deletions(-)
> 
> 
> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
> 

Thank you. I will queue this up for Linux 5.19-rc1

thanks,
-- Shuah
