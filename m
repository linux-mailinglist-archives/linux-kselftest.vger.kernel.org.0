Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D514CC5B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiCCTKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 14:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiCCTKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 14:10:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9E187E30
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 11:09:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so8550157pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j7TJLOnN6hgODDuo1callp0lhdyoclIZFm0WJljlY8s=;
        b=fVnhMSDNmlqJL+mlE4nr2PgQuPT9LGKEI5pLg6UMKecnlAeYN/FVWHDwnXJhWjrE/n
         DmINVFplNUArYTWf3s3r3hSQ8aSUka6JL/mICjXhADVYWnkAJ2AMABSG1FR+9aEbBXaQ
         MW2bjvj5LntyCBXcjwdKceOmtzdFX2X3FBxps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7TJLOnN6hgODDuo1callp0lhdyoclIZFm0WJljlY8s=;
        b=cCDAs+fgVrcBww04SJI2XM8d8OUdnmGBHplnuvlMYrFUxgPW61KDVp8VFzlRReOBSR
         0fL8BF2Of6oM/XzY7Vx2godIWA1tY46VM0LVenMyrEVqWOvlipXT6UzAiYfnT8OdfrWB
         WIkxrhxpo92zx4d9xd5DP9fvAfHJ9+bcVC23P6/VGJVq0EHR8pbGpZimHAJ2s1TXWP4I
         3sFILqF1nfADU9Q5fEs986XdTsxLotUTYEdE6DEMLfHfTtmoT+WCb8IIG2cowZCOzph3
         IBDzs5RlDx7J6kpqieRrlObqivSt96WcU9DjJwOzfzcMdbJqcm1mwycvj+q51RBQWcP9
         902Q==
X-Gm-Message-State: AOAM532gD2bqK3DFtB/YQRAnLdylE2szlryFly9PWdjNr/xJUksAQYS+
        xXxAzllfaerKdTo7iCKhVkQBQA==
X-Google-Smtp-Source: ABdhPJyfvwYzCoBtdXSSCDsYpSdESFLlaFH3e43QTFvMWUmnNTc6eJPUCpEnqo8wvQrcrYNq7n2KPQ==
X-Received: by 2002:a17:90b:1c11:b0:1bf:c13:e4a3 with SMTP id oc17-20020a17090b1c1100b001bf0c13e4a3mr5279740pjb.188.1646334575652;
        Thu, 03 Mar 2022 11:09:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a00244300b004bc9397d3d0sm3198347pfj.103.2022.03.03.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:09:35 -0800 (PST)
Date:   Thu, 3 Mar 2022 11:09:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Message-ID: <202203031105.A1B4CAE6@keescook>
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
 <20220303074339.86337-1-ashimida@linux.alibaba.com>
 <202203031010.0A492D114@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203031010.0A492D114@keescook>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 03, 2022 at 10:42:45AM -0800, Kees Cook wrote:
> Though, having the IS_ENABLED in there makes me wonder if this test
> should instead be made _survivable_ on failure. Something like this,
> completely untested:
> 
> 
> #ifdef CONFIG_ARM64
> static noinline void lkdtm_scs_set_lr(unsigned long *addr)
> {
> 	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
> 	*lr = addr;
> }
> 
> /* Function with __noscs attribute clears its return address. */
> static noinline void __noscs lkdtm_noscs_set_lr(unsigned long *addr)
> {
> 	unsigned long **lr = (unsigned long **)__builtin_frame_address(0) + 1;
> 	*lr = addr;
> }
> #endif
> 
> 
> void lkdtm_CFI_BACKWARD_SHADOW(void)
> {
> #ifdef CONFIG_ARM64
> 
> 	/* Verify the "normal" condition of LR corruption working. */
> 	do {
> 		/* Keep label in scope to avoid compiler warning. */
> 		if ((volatile int)0)
> 			goto unexpected;
> 
> 		pr_info("Trying to corrupt lr in a function without scs protection ...\n");
> 		lkdtm_noscs_set_lr(&&expected);
> 
> unexpected:
> 		pr_err("XPASS: Unexpectedly survived lr corruption without scs?!\n");
> 		break;
> 
> expected:
> 		pr_err("ok: lr corruption redirected without scs.\n");
> 	} while (0);
> 
> 
> 	do {
> 		/* Keep labe in scope to avoid compiler warning. */
> 		if ((volatile int)0)
> 			goto good_scs;
> 
> 		pr_info("Trying to corrupt lr in a function with scs protection ...\n");
> 		lkdtm_scs_set_lr(&&bad_scs);
> 
> good_scs:
> 		pr_info("ok: scs takes effect.\n");
> 		break;
> 
> bad_scs:
> 		pr_err("FAIL: return address rewritten!\n");
> 		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> 	} while (0);
> #else
> 	pr_err("XFAIL: this test is arm64-only\n");
> #endif
> }
> 
> And we should, actually, be able to make the "set_lr" functions be
> arch-specific, leaving the test itself arch-agnostic....

Yeah, as a tested example, this works for x86_64, and based on what you
had, I'd expect it to work on arm64 too:

#include <stdio.h>

static __attribute__((noinline))
void set_return_addr(unsigned long *expected, unsigned long *addr)
{
    /* Use of volatile is to make sure final write isn't seen as a dead store. */
    unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;

    /* Make sure we've found the right place on the stack before writing it. */
    if (*ret_addr == expected)
        *ret_addr = addr;
}

volatile int force_label;
int main(void)
{
    do {
        /* Keep labels in scope. */
        if (force_label)
            goto normal;
        if (force_label)
            goto redirected;

        set_return_addr(&&normal, &&redirected);
normal:
        printf("I should be skipped\n");
        break;
redirected:
        printf("Redirected\n");
    } while (0);

    return 0;
}


It does _not_ work under Clang, though, which I'm still looking at.

-- 
Kees Cook
