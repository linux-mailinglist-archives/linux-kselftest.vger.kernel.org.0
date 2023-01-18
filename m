Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2273672646
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 19:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjARSGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 13:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjARSFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 13:05:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523225A823
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 10:03:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g68so24005891pgc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LWD9/QLpObyf7uK4hbDzgQfFl7VFFLA3YY+bVGtV2A=;
        b=EmorF5thQTFFqPxBHfiajOhPpV4kMBr2heHGT5Nxk7gEWpjPWQVv7PvLYdr/SIkIqh
         3+V/J9iAtXDUR5/KO7ldxpBFPXIZt+3vXRi890HHMQRzkYYumlG2fgJvuI41a3NeE+kl
         7D2TU1iuEreOX3I7BOsoDu7KhXITypHsoXhk1fUaqJn2wbyH2YGfx7ygQzCsgCyEA2RY
         AnQFps5xWyYMMZY25ZmReDxwFsd9yrriiId7x/1N0ok9+qLlAxdVBcJf2b2klq8sLAyi
         iAXChOsswjZ3UjzKefnbxLKFjC7GGt3BkZB8yBA0ypwJ/6BlNm2zCp4Qxlt9hU6igRE6
         yMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LWD9/QLpObyf7uK4hbDzgQfFl7VFFLA3YY+bVGtV2A=;
        b=MNe44nPWjIn+3f/ZamaTq1quBnJ6oz9+Xh7gwvmdZLC8h4ZoKn95pSciYuFULmikuI
         7dZVpUZUzlUWBA23vw+wbN7YZXn5EDg50nH9sWQsI19wRxprROm1yMnqjOfryhGzsmJY
         RyMMH3+F9BSCSzeT4S5O36o0QAgzGFEKdXSaf/02D6OaIdEhBYEGnfl6gaVKPNwVGyVx
         5wxTghy9LKYVvhTB8VhyVWd9xDfVlnaqyVhY3O2VZpWHvDODep5oGb45z1C9SLRBwVsA
         RedAEm5oNVUZCCxt1El45EHrnaVIhq00NaBUhQY2yZBl1QipHwwh5iosFkDvrpWe1ADi
         N0cg==
X-Gm-Message-State: AFqh2krne+ZoQ9TvQu9oSbFtmNJnylvovXtEJxlAP1TZsqeyB0iEAGwv
        cX36ZS+aXoi4ngFsDZ3ovnPTsw==
X-Google-Smtp-Source: AMrXdXtiFexFV6OeMcBVrHc0yLyJV0VjIVxq5F3AHMqYHHbWZxOSlD1/ie70xe37tAttZMs8iz4jSw==
X-Received: by 2002:aa7:9041:0:b0:58b:cb1b:978f with SMTP id n1-20020aa79041000000b0058bcb1b978fmr1487655pfo.1.1674065002413;
        Wed, 18 Jan 2023 10:03:22 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 124-20020a621882000000b0057709fce782sm17720022pfy.54.2023.01.18.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:03:22 -0800 (PST)
Date:   Wed, 18 Jan 2023 18:03:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Fix initialization of GDT limit
Message-ID: <Y8g0Zv0IjLEBw5qO@google.com>
References: <20230114161557.499685-1-ackerleytng@google.com>
 <20230114161557.499685-2-ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114161557.499685-2-ackerleytng@google.com>
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

On Sat, Jan 14, 2023, Ackerley Tng wrote:
> Subtract 1 to initialize GDT limit according to spec.

Nit, make changelogs standalone, i.e. don't make me read the code just to
understand the changelog.  "Subtract 1" is meaningless without seeing the
existing code.  The changelog doesn't need to be a play-by-play, e.g. describing
the change as "inclusive vs. exclusive" is also fine, the important thing is that
readers can gain a basic understanding of the change without needing to read code.

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index acfa1d01e7df..33ca7f5232a4 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -502,7 +502,12 @@ static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
>  		vm->gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
>  
>  	dt->base = vm->gdt;
> -	dt->limit = getpagesize();
> +
> +	/*
> +	 * Intel SDM Volume 3, 3.5.1:

As a general rule, especially in code comments, never reference manual sections
by their index/numbers, there's a 99% chance the comment will be stale within a
few years.

Quoting manuals is ok, because if the quote because stale then that in and of
itself is an interesting datapoint.  If referencing a specific section is the
easiest way to convey something, then use then name of the section, as that's less
likely to be arbitrarily change.

In this case, I'd just omit the comment entirely.  We have to assume readers have
a minimum level of knowledge, and IMO this is firmly below (above?) the threshold.

> "the GDT limit should always be one less
> +	 * than an integral multiple of eight"
> +	 */
> +	dt->limit = getpagesize() - 1;
>  }
>  
>  static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
