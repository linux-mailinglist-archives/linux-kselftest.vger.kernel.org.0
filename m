Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF34AA489
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 00:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiBDXke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 18:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378613AbiBDXkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 18:40:06 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CEDDFFE362
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Feb 2022 15:39:41 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d188so9327747iof.7
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Feb 2022 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=chay6cI5krPMdvmjI0OgtPSx/juylZb2Zp77TTGYBDU=;
        b=ghF9s5MbclL4SAtvIK2qGV+BljWVspJXqofubIdxJEF14Xz9ytHpkkFxpswuY/BsgI
         jyktOsJw7HiIBplyOMdLypyl5fEAN123X3pm30RrXatGH7VJLU0G2sGL6oulw1BlK47Q
         zlEtzHahkHzgXbyjsAtGOBVSuOZtqDlBcOdjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=chay6cI5krPMdvmjI0OgtPSx/juylZb2Zp77TTGYBDU=;
        b=q9DP0RL7HY/9Cn7Gze9kpTQtPRew1VqarfZv5YI53Gi2Q5rBPn1WzhecULUaJXe+1T
         Y4mmgIrtHL6la8ivhErC+lMAAvDKXvxasYPSxAv5SzvbBLYNMzPeh+LZVUAbwIdDChtF
         FQuaODceEZxygCIw8KS2NCCnqgYE4I9LIIIErBxI2AHEguZdHovWpp7XLnA9APpm8HnG
         RtbiLg2l9DmMjjxvSoAdXTlMNxRCBSJrxWhv1t+0Y4aeNI6EoywlZULwew5mLABUKNjt
         x4szgKZVN7szswycAbcrOCvj4Jsx1y6srMC0ldo/tZVSOwweaeQjFOPJzgNYOayjI41W
         MVZA==
X-Gm-Message-State: AOAM531RugKKtgZ/0DOMHk1mZc9TajY4nVLgyqs0AYXlj+d7KnUfH+zW
        mxHe4xziGiDeNogqqsKSkbzEZw==
X-Google-Smtp-Source: ABdhPJxwry8B1iySH3HNGgjwyySt2sl1IYQJ9sPBEZsfj1ARJPiZ4Cfn77PbNSIkbwQAa0+fQ9Qv2g==
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr681599jat.219.1644017980601;
        Fri, 04 Feb 2022 15:39:40 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e17sm1654076ilm.67.2022.02.04.15.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 15:39:40 -0800 (PST)
Subject: Re: [PATCH 0/3] selftests: Remove duplicate CPUID wrappers
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, linux-mm@kvack.org,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1644000145.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81df8c0e-fde6-f3b8-f988-b539f193635b@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 16:39:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1644000145.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/4/22 12:17 PM, Reinette Chatre wrote:
> A few tests that require running CPUID do so with a private
> implementation of a wrapper for CPUID. This duplication of
> the CPUID wrapper should be avoided but having one is also
> unnecessary because of the existence of a macro that can
> be used instead.
> 
> This series replaces private CPUID wrappers with calls
> to the __cpuid_count() macro from cpuid.h as made available
> by gcc and clang/llvm.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ram Pai <linuxram@us.ibm.com>
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
> Reinette Chatre (3):
>    selftests/vm/pkeys: Use existing __cpuid_count() macro
>    selftests/x86/amx: Use existing __cpuid_count() macro
>    selftests/x86/corrupt_xstate_header: Use existing __cpuid_count()
>      macro
> 
>   tools/testing/selftests/vm/pkey-x86.h         | 22 +++---------------
>   tools/testing/selftests/x86/amx.c             | 23 +++++--------------
>   .../selftests/x86/corrupt_xstate_header.c     | 17 ++------------
>   3 files changed, 11 insertions(+), 51 deletions(-)
> 

I am all for this cleanup. However, I am not finding __cpuid_count()
marco on my system with gcc:

gcc --version
gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0

My concern is regression on older gcc versions.

thanks,
-- Shuah
