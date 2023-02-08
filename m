Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776C68E550
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHBRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBHBRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 20:17:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AA23B0D1
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 17:17:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g17so91462ply.11
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Feb 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xB13fF1PmyLmoTaKAw3VOcBhmK5OeazECIG9zVrIq7Y=;
        b=TWbGHdgroF8gB44kgjoIqnZo0WmWKS2hV8bq/6MDOqbD4ag6ODZjQl5J7JUSYNdbSh
         fRpTIGiSE5mEcyrGza4OjljrO1AhNs9WKIQkaoiQ1MJ//WmjF74MGmX8WbVH/3eeaQRI
         e6fN7Uu12anaCc4Ip30OLdg2iFHidIVgCi1X/wBE4CpGbCFSsgJPXcv0EFttCuaWvNM3
         7yeLp4vSFDex/NHKD4aiyT8pmzBYILmvH4T8vQ4iePK3go0tcyTtunf7WvVHGxx52SKa
         tHR8QzEbzA2ce26qdE3anHhOc4w5nGzH9Wbgv1rSvnVv6hS2/9GVNOaRmSiOTxEZek5r
         nSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB13fF1PmyLmoTaKAw3VOcBhmK5OeazECIG9zVrIq7Y=;
        b=dH1hQOwUk8fzCdvDsyo1zBrwbSv0htUmV/EKSrRvI0sjQKqaxdWlzat75/cmhRWfbH
         RmpS1CjJEg2JIHtuZULsedvDDmrAb/YWXaWzhqHKWVbSrFxQARUPotljVKyjsCpZK1au
         5GWfTag5BSuWm2Zwi07IUNW5heschALyeWH9Ttxh2EE19HG2T9uqLT+dc2QdAPClFSeU
         i8TZajpSO8DqxvGLkspi21TP2j2++rqVQibWFq4kYwEeh6NgC5rxinAHen7HRl8e3GA5
         KVxGrlqgHsBORPswV6T47daUeHtSr4VxPyBbcvbFrbrdUR7TJRVueQ9qMP+YiYaMb/SJ
         Wf8g==
X-Gm-Message-State: AO0yUKWggcJLu0nzdDk7Wcq/G5ZbVM1qT1C1GZ8XRXXUXyeVmnYWCvpj
        C7TJ8Ua4STuUHE8nBUDIRt0tiw==
X-Google-Smtp-Source: AK7set9e+0OSXRRK2C2oN9BODtXLAEl/rsuryLY+ttHMJegyR+WJUjWxZVaVgVdW2AlptngYWcnWbA==
X-Received: by 2002:a17:902:d902:b0:199:3909:eaee with SMTP id c2-20020a170902d90200b001993909eaeemr110736plz.6.1675819051383;
        Tue, 07 Feb 2023 17:17:31 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0058d9b68042fsm309103pfn.14.2023.02.07.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:17:30 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:17:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: x86: Add check of IA32_XFD in
 amx_test
Message-ID: <Y+L4J4djWImiRvej@google.com>
References: <20230110185823.1856951-1-mizhang@google.com>
 <20230110185823.1856951-3-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185823.1856951-3-mizhang@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> When #NM is triggered, the handler needs to ensure the exception is

State what the patch does (and explain why), don't say ABC needs/should do XYZ.
The #NM handler doesn't _need_ to ensure the #NM wasn't due to CR0.TS

> triggered by AMX by checking IA32_XFD_ERR and not because of CR0.TS[bit 3]

CR0.TS is a single bit, using square braces makes it look like an index into CR0.TS.
I would drop the "bit 3" part altogether, it's not relevant

> is 1. Note that the value of IA32_XFD_ERR comes from "the logical AND of
> the IA32_XFD MSR and the bitmap corresponding to the state components
> required by the faulting instruction." (Intel SDM vol 1. Section 13.14)
> 
> Add the missing check of CR0.TS before checking the value of IA32_XFD_ERR.
> In addition, add an extra check to IA32_XFD to ensure the behavior is
> consistent with the AMX archtecture. In addition, repeat the checks across
> context switch to ensure the values of IA32_XFD and IA32_XFD_ERR are well
> preserved.

Split the MSR_IA32_XFD checks to a separate patch.  Or I guess given the shortlog
is about IA32_XFD, split the CR0.TS check to a separate patch.

> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index 16533949a189..b2369f956fea 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -226,9 +226,12 @@ void guest_nm_handler(struct ex_regs *regs)
>  {
>  	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
>  	GUEST_SYNC(7);
> +	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);

	GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));

>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT((rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);

Isn't this just

	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);

or am I horribly misreading the code?

>  	GUEST_SYNC(8);
>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT((rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);

Same here.

>  	/* Clear xfd_err */
>  	wrmsr(MSR_IA32_XFD_ERR, 0);
>  	/* xfd=0, enable amx */
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
