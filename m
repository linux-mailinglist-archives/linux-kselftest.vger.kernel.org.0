Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB062C6AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 18:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiKPRqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 12:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiKPRqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 12:46:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6B5E9D7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:46:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q71so17338662pgq.8
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv52GtCM4ZFXXxuwUGoAJXcvMEaghc29osYo4Ar8hBI=;
        b=MiYygNM/5XQMElbFC2unMG+pAxhnyg7+C5LBgp217oyIkofUkVEaIPvRzgrJbL7aPl
         UMeuugERF6NhNbFBnpT9g9XKv0tjs7Hbe22eAYnZ8atPfS5eOYr4ECiyGmpJHkp7NiaM
         OT3YamqRnoKn+k+b+0cpiyIgjWJ2evHfmOUSu4h2aKuUzsQ4bSDud8WU9QkX4U0hVQkt
         tYOIolzZUW5qlUK+X9ajceoM1ISyjfD2Ba5InvRlyMyQChVnLWkoJOXYHg/tT0fjuAZ6
         iKC90fC71vp9RFMjIGnUwgq7Fx9I3Vuuxr3WhEmIFDCCPTPJ6AykteocaC+8pnpFYMyF
         Ou9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv52GtCM4ZFXXxuwUGoAJXcvMEaghc29osYo4Ar8hBI=;
        b=TNktLss0VsLMJhciArk0mBTeJlQfxcEpY/lLoJMDPT0VGmj7Ut0VhrXjjl/ay1yWMj
         1pUvbGHj9Y7tfnkCRlFSRJKGXL00nBbdYnDAkpUZQs0lnQmhzmHOYh3GoPBbPYBhtMrq
         86BDyId9faJZ0zgiRk19HFIPWd4Mndnx6KWywFqJ/Al4pQh0IHRuBtrc70DzPJD4k1AW
         3StJTkWzaItu5IXC/7UL4NEd9wnuIxuVUwCX6WTDLj6aBo+57GR+h71nBavt9cPyzrNY
         oOXy0/6fvs0+PnJDyo1aCoZKB6sTGUCdrZD6VntcVBsBZxPdbsoEVxDFXy3mj4dC6vUy
         2WJg==
X-Gm-Message-State: ANoB5pnj1Sy7p05Stxj2JaIVjWA2W5/9kqu2FMyDVHAIJnaw/sMYf37l
        dD5gNiOT0HLD1nBqIsakxQzqzg==
X-Google-Smtp-Source: AA0mqf7R80u0SZ5wG9tdwu8k3agBZ8KDBIDbp2dwDJFMpsjhNdL1IbFUc01Z9q5V5Ls51GXhYsNe0A==
X-Received: by 2002:a62:7955:0:b0:56b:e64c:5c7e with SMTP id u82-20020a627955000000b0056be64c5c7emr23964157pfc.18.1668620769402;
        Wed, 16 Nov 2022 09:46:09 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b0017849a2b56asm12631823plg.46.2022.11.16.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:46:09 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:46:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V4 PATCH 2/3] KVM: selftests: Add arch specific initialization
Message-ID: <Y3Uh3cvVYfH0ZFEr@google.com>
References: <20221115213845.3348210-1-vannapurve@google.com>
 <20221115213845.3348210-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115213845.3348210-3-vannapurve@google.com>
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

On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
> handle initialization before running any selftest logic.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Reviewed-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
>  .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
>  tools/testing/selftests/kvm/lib/kvm_util.c     |  6 ++++++
>  3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index e42a09cd24a0..eec0e4898efe 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -838,4 +838,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>  	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
>  }
>  
> +/*
> + * API to execute architecture specific setup before executing main().
> + */

I find the "API" blurb to be somewhat confusing.  When I think of APIs, I think
of functions that are provided by a library that are called by users of the
library.

An example might also help readers understand what types of setup can/should be
done with this hook.

Maybe something like this?

/*
 * Arch hook that is invoked via a constructor, i.e. before exeucting main(),
 * to allow for arch-specific setup that is common to all tests, e.g. computing
 * the default guest "mode".
 */
