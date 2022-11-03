Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E4617F89
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiKCO3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiKCO3q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CECB1D
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667485728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B66upLAnk+FlTO6dJW2iKl9/HLFq373CjyL5PbrrDJI=;
        b=Ti51hT1BtgvYRYRcoyvRktVIAfKPKgVWWAQKDP4XQ/ry/TOgKjrxpTduRfMX1tnS5sj6SH
        6jLy8r54EutdkDIVH7sIGlI0PiERKBzQMvT4v4/QGsuDjBJcUoflE2uqquUMm3ku4h5NMc
        Pa0aPl+3wSbKFKrVXOKrWTFqTEVNiRg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-DqiP8lobNI6vWzt1JCanIw-1; Thu, 03 Nov 2022 10:28:46 -0400
X-MC-Unique: DqiP8lobNI6vWzt1JCanIw-1
Received: by mail-qv1-f69.google.com with SMTP id ob9-20020a0562142f8900b004bba5363ad9so1394271qvb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 07:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B66upLAnk+FlTO6dJW2iKl9/HLFq373CjyL5PbrrDJI=;
        b=3LXvUJ77gzfRVxZtA7nj3AgLMxqZ5YXmRwQjeT5RjKvW8qmhnRkiBP9Ew802ZqWLY5
         V5lCZunSRopLgQkk2um+ESEk/TfHTFTvme6bBOfqSd6DPZ65Z4KZvm/8Eh8W0I1ICFLG
         xNtJtbVyRKGWTasPhWXOnE/7NTquq1gjuj/w8yeKXQvhN2QFiGiiCa9SQeRt4Q05JCrO
         Fl8tzauH+dlHIDu0YTDo2/G2fcFgmd51CjJ92DdxkiG+cw5kJfM284NIUgUZGu7hs8SR
         fIaB5+6K9qDtwsFJcUA5bKFZNEwJDyBBaqBx0pNHiIwmvODGC59hnB1wUpfCgQ0GJ/pg
         Fw5A==
X-Gm-Message-State: ACrzQf0WkV042YOsa9qHiKuO7DOfxQePTb0b0Fy2gpFXUZ7osquTiNyQ
        8imOlZPfMrXEUmu8fKJwLOvirhLu27Dyp3Ra1Sg4znDueR2c2/bSQlXu0Nc/D7mKY1m5C3kWT1z
        cdcLZuhN1bAJei9Q4LlRSn/7pluOx
X-Received: by 2002:ae9:e015:0:b0:6fa:2b3a:9680 with SMTP id m21-20020ae9e015000000b006fa2b3a9680mr17040820qkk.417.1667485726443;
        Thu, 03 Nov 2022 07:28:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5vY6xnRzmp29h8M10tJaHJGmMNqtPheheeZNFI6W2Xyl31AGhDLacuUYZt7X88vOdJm4qbZA==
X-Received: by 2002:ae9:e015:0:b0:6fa:2b3a:9680 with SMTP id m21-20020ae9e015000000b006fa2b3a9680mr17040786qkk.417.1667485726218;
        Thu, 03 Nov 2022 07:28:46 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a02c700b0039cc0fbdb61sm616221qtx.53.2022.11.03.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:28:45 -0700 (PDT)
Message-ID: <2dccbbaa2d9e9aa7895fc03488c503c544aa0399.camel@redhat.com>
Subject: Re: [PATCH v2 6/9] kvm: selftests: add svm nested shutdown test
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
Date:   Thu, 03 Nov 2022 16:28:41 +0200
In-Reply-To: <20221103141351.50662-7-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
         <20221103141351.50662-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-11-03 at 16:13 +0200, Maxim Levitsky wrote:
> Add test that tests that on SVM if L1 doesn't intercept SHUTDOWN,
> then L2 crashes L1 and doesn't crash L2
I mean doesn't crash L0, sorry for typo.

Best regards,
	Maxim Levitsky
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |  1 +
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 2f0d705db9dba5..05d980fb083d17 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -41,6 +41,7 @@
>  /x86_64/svm_vmcall_test
>  /x86_64/svm_int_ctl_test
>  /x86_64/svm_nested_soft_inject_test
> +/x86_64/svm_nested_shutdown_test
>  /x86_64/sync_regs_test
>  /x86_64/tsc_msrs_test
>  /x86_64/tsc_scaling_sync
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 0172eb6cb6eee2..4a2caef2c9396f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -101,6 +101,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
> +TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_soft_inject_test
>  TEST_GEN_PROGS_x86_64 += x86_64/tsc_scaling_sync
>  TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
> new file mode 100644
> index 00000000000000..e73fcdef47bbe9
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * svm_nested_shutdown_test
> + *
> + * Copyright (C) 2022, Red Hat, Inc.
> + *
> + * Nested SVM testing: test that unintercepted shutdown in L2 doesn't crash the host
> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +
> +static void l2_guest_code(struct svm_test_data *svm)
> +{
> +       __asm__ __volatile__("ud2");
> +}
> +
> +static void l1_guest_code(struct svm_test_data *svm, struct idt_entry *idt)
> +{
> +       #define L2_GUEST_STACK_SIZE 64
> +       unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +       struct vmcb *vmcb = svm->vmcb;
> +
> +       generic_svm_setup(svm, l2_guest_code,
> +                         &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +       vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
> +
> +       idt[6].p   = 0; // #UD is intercepted but its injection will cause #NP
> +       idt[11].p  = 0; // #NP is not intercepted and will cause another
> +                       // #NP that will be converted to #DF
> +       idt[8].p   = 0; // #DF will cause #NP which will cause SHUTDOWN
> +
> +       run_guest(vmcb, svm->vmcb_gpa);
> +
> +       /* should not reach here */
> +       GUEST_ASSERT(0);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_run *run;
> +       vm_vaddr_t svm_gva;
> +       struct kvm_vm *vm;
> +
> +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +
> +       vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
> +       vm_init_descriptor_tables(vm);
> +       vcpu_init_descriptor_tables(vcpu);
> +
> +       vcpu_alloc_svm(vm, &svm_gva);
> +
> +       vcpu_args_set(vcpu, 2, svm_gva, vm->idt);
> +       run = vcpu->run;
> +
> +       vcpu_run(vcpu);
> +       TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
> +                   "Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
> +                   run->exit_reason,
> +                   exit_reason_str(run->exit_reason));
> +
> +       kvm_vm_free(vm);
> +}


