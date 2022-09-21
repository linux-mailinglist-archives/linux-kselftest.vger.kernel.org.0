Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD25E54C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIUUyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUUyW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 16:54:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB45A570A
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 13:54:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso43761pjd.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yRyK8uVIf6sgbn5S18i1u/lBRRBtPkKWicLJZ1+DWS0=;
        b=Z6ok7PvI18J/cu5qKQfW3/k/bpLSLP3R7uGuWlKinMlBE+yY2dnqp16xqQoGK/jFH3
         kQ8l4pWTPQtK+EaH4QXeleDMRoIS1A+6qqDuFR3UmBcDamrX9VbqRgLRS5PNe37jUU4L
         rFP3foWkIFLePNT0aGyiFarW0GWuSV4SPeBaTmOHhhb65aLp92SJlHZCCMVRJ+nD4AGN
         lFTb8VZXdyCfYpJYWg0l1fDWIxVCSla1Bp5m3u9HecH3Is1ItdJ1mdTvK9EMB3qbwJBb
         o1XpN2JbZ4PGTWPbUGuFEXg+6MGAfc2lbmOf0APWAu7xtXTM76xXtxoVRGyZfGttyZmJ
         L2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yRyK8uVIf6sgbn5S18i1u/lBRRBtPkKWicLJZ1+DWS0=;
        b=cc+lVWvOPn3b6XJG/EBatTZiqPiSvk622m0cGGPYorb0e4ZVxwZlniygGfMH88sild
         DoypqcPZ0/9zMsZCImK6w+nAFBak2JItH3+GDzevJhSzUgidBpODJrBR96WRT7WnekLv
         TYMVLz2NBq08l+HzCm2qi+ojpvxmoc+vhxRqqhJmR3J1l/uByVmrKMqrjnVbcO6ZMzea
         znZFGYILx48ZncnVqp8pP3mxPlLND5Y4I/Z2RdWEWLbHmAEDHt5gopMWZH9IykuCHMTf
         FhllfFISl1FqePmKKEXSPdmwiCsz8ywR7QZpkqCujahSNHyRwzhOLTs6gnXWTj4DcZos
         ndlg==
X-Gm-Message-State: ACrzQf3fW7pJEOEkhFIWPSB8Ru+M5uEtB2XOzg2zdwiN8zr+4VQ7gYz0
        pM5qSzj6+e71lrIC4qN8HlZm3Q==
X-Google-Smtp-Source: AMsMyM5orVQbA2y3SJp18iff5y/Pbllqj96/O+d1kUIsFRn0DQJwGF/cqk6KPwEXZKR6/vrwvCk59Q==
X-Received: by 2002:a17:90b:180e:b0:202:e725:19e2 with SMTP id lw14-20020a17090b180e00b00202e72519e2mr11738515pjb.163.1663793655850;
        Wed, 21 Sep 2022 13:54:15 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id u16-20020a632350000000b004277f43b736sm2280395pgm.92.2022.09.21.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:54:15 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:54:11 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 3/8] KVM: selftests: Add arch specific post vm load
 setup
Message-ID: <Yyt586xOWrNEoCYF@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-4-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-4-vannapurve@google.com>
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

On Thu, Sep 15, 2022 at 12:04:43AM +0000, Vishal Annapurve wrote:
> Add arch specific API kvm_selftest_post_vm_elf_load to possibly communicate
> information to VM that is already known to selftest VMM logic.
> 
> This API will be used in followup commit to convey cpu vendor type to the
> guest vm.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
>  tools/testing/selftests/kvm/lib/aarch64/processor.c | 4 ++++
>  tools/testing/selftests/kvm/lib/elf.c               | 2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c   | 4 ++++
>  tools/testing/selftests/kvm/lib/s390x/processor.c   | 4 ++++
>  tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 ++++
>  6 files changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 98edbbda9f97..73cfee3ebd76 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -839,4 +839,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>   */
>  void kvm_selftest_arch_init(void);
>  
> +/*
> + * API to execute architecture specific setup after loading the vm elf.

It's not a "vm elf" per-se, it's "loading the elf into the VM". How
about:

/*
 * API to execute arch-specific logic after loading the selftest ELF image
 * into the VM.
 */

> + */
> +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm);
>  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 2281d6c5d02f..12627c560f66 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -528,3 +528,7 @@ void kvm_selftest_arch_init(void)
>  {
>  	guest_modes_append_default();
>  }
> +
> +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
> index 9f54c098d9d0..b8963a7146ce 100644
> --- a/tools/testing/selftests/kvm/lib/elf.c
> +++ b/tools/testing/selftests/kvm/lib/elf.c
> @@ -189,4 +189,6 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
>  				phdr.p_filesz);
>  		}
>  	}
> +
> +	kvm_arch_post_vm_elf_load(vm);
>  }

Same suggestion here as the previous patch: Use __weak to define a
default no-op implementation of kvm_arch_post_vm_elf_load().

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 26660dd2ba78..4491c0d4be45 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -366,3 +366,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  void kvm_selftest_arch_init(void)
>  {
>  }
> +
> +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 8654ec74009a..332501b3693f 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -222,3 +222,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  void kvm_selftest_arch_init(void)
>  {
>  }
> +
> +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 20bf125f9363..25ae972f5c71 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1315,3 +1315,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  void kvm_selftest_arch_init(void)
>  {
>  }
> +
> +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> +{
> +}
> -- 
> 2.37.2.789.g6183377224-goog
> 
