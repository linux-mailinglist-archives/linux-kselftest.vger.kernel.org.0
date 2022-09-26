Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96E35EB58A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIZXU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIZXTM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2FAFAE8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:19:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so13975509pjq.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KTYkoGSnzoJvmcli4WcPkh9mD6LI1jnFnjX4Q4TT2Dw=;
        b=bUlA+hIf6EHrPg6Yjm1RD3TBCBKxD9VZxfMkGFaLz9DAFz2FV7tLQP4nBfEHN7nOja
         OwKLyjUqKKhJUAzlsz4s1RG32swgnsK9c4oxMKVYlAps2IEpfwejclDTVnpQaI3MUqTu
         UJfE5mlf3BkYySDs5sWm9/sK4tqpTI+jFjN/qtsmMK5EuJHF5rhR8xYH6Tnq3BKk2V2W
         77F91PPAOk5sVGm4o+KQS8KxNJADcBa8X5PPy3XftGUQQ4rxDXg6yHsII94yR34u7eO+
         lGmY4q/6ojKglw1GHKCj7VCcsvLO19KRRqfAZxDXmVBbNnWMKnmN5keiQ5Yya/kUI/rn
         EE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KTYkoGSnzoJvmcli4WcPkh9mD6LI1jnFnjX4Q4TT2Dw=;
        b=Uyz2I8D5pX23napxSTSnbEciuFeYKwOfol7M3JXJIrfZq/Fn7Ib5N3jvBZCrGfyEmL
         p4+AS8G7VwKMxi0fkczKC71CQyqJWARxf6UhsZXFHqMLOvciYSav+ArDuZ7DR50/V3oc
         3QynHSIptA4QVyX2N3CxhFZ8El/wjHx5Q0Pu4EPeZTMgAPuU1BxB9XT767kKkgfJaDNi
         I/AKmmV7KEt2hCKrjdX1i46jABDHgfI5i1cjP3xTupLhjk/XPnw7kkle5p2adUtydqCv
         OD/9OdbTpqAJZv/0wg6oI5mP2DMKmor8rQ2FBJCOJA38eTGfiCPE6PWKkR6J8ssa9GYd
         2Q2g==
X-Gm-Message-State: ACrzQf0q5MAmtyGug338GIncmdE73kYFmN4Yi0haj8RB3W96twXz+pGc
        4wHF66q4ax83UF2JRaVVxetK+t+z9Rkij8d91rJBww==
X-Google-Smtp-Source: AMsMyM6SalzArkfrof70ETM7z2kh8vAOPBfPGL6kbQpwN0aziTGkIJzl4D5AHxkvT231SdmTjqSWE63m9xyIl+4h4+I=
X-Received: by 2002:a17:90b:384b:b0:200:3215:878b with SMTP id
 nl11-20020a17090b384b00b002003215878bmr1184729pjb.176.1664234350226; Mon, 26
 Sep 2022 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-4-vannapurve@google.com> <Yyt586xOWrNEoCYF@google.com>
In-Reply-To: <Yyt586xOWrNEoCYF@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:18:59 -0700
Message-ID: <CAGtprH8=wjQAhpr97KNsziT_jAqSS6sMTb5=gzgbhssNPm8q_Q@mail.gmail.com>
Subject: Re: [V2 PATCH 3/8] KVM: selftests: Add arch specific post vm load setup
To:     David Matlack <dmatlack@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 21, 2022 at 1:54 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:43AM +0000, Vishal Annapurve wrote:
> > Add arch specific API kvm_selftest_post_vm_elf_load to possibly communicate
> > information to VM that is already known to selftest VMM logic.
> >
> > This API will be used in followup commit to convey cpu vendor type to the
> > guest vm.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
> >  tools/testing/selftests/kvm/lib/aarch64/processor.c | 4 ++++
> >  tools/testing/selftests/kvm/lib/elf.c               | 2 ++
> >  tools/testing/selftests/kvm/lib/riscv/processor.c   | 4 ++++
> >  tools/testing/selftests/kvm/lib/s390x/processor.c   | 4 ++++
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 ++++
> >  6 files changed, 22 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > index 98edbbda9f97..73cfee3ebd76 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -839,4 +839,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
> >   */
> >  void kvm_selftest_arch_init(void);
> >
> > +/*
> > + * API to execute architecture specific setup after loading the vm elf.
>
> It's not a "vm elf" per-se, it's "loading the elf into the VM". How
> about:
>
> /*
>  * API to execute arch-specific logic after loading the selftest ELF image
>  * into the VM.
>  */
>

Ack. Will update this in the next series.

> > + */
> > +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm);
> >  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> > diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > index 2281d6c5d02f..12627c560f66 100644
> > --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > @@ -528,3 +528,7 @@ void kvm_selftest_arch_init(void)
> >  {
> >       guest_modes_append_default();
> >  }
> > +
> > +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> > +{
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
> > index 9f54c098d9d0..b8963a7146ce 100644
> > --- a/tools/testing/selftests/kvm/lib/elf.c
> > +++ b/tools/testing/selftests/kvm/lib/elf.c
> > @@ -189,4 +189,6 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
> >                               phdr.p_filesz);
> >               }
> >       }
> > +
> > +     kvm_arch_post_vm_elf_load(vm);
> >  }
>
> Same suggestion here as the previous patch: Use __weak to define a
> default no-op implementation of kvm_arch_post_vm_elf_load().
>
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > index 26660dd2ba78..4491c0d4be45 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -366,3 +366,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
> >  void kvm_selftest_arch_init(void)
> >  {
> >  }
> > +
> > +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> > +{
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> > index 8654ec74009a..332501b3693f 100644
> > --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> > @@ -222,3 +222,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
> >  void kvm_selftest_arch_init(void)
> >  {
> >  }
> > +
> > +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> > +{
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index 20bf125f9363..25ae972f5c71 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -1315,3 +1315,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
> >  void kvm_selftest_arch_init(void)
> >  {
> >  }
> > +
> > +void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
> > +{
> > +}
> > --
> > 2.37.2.789.g6183377224-goog
> >
