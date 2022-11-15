Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A2629CB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKOO45 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 09:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKOO4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 09:56:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A51CFD23
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668524155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9HIxue0KMKbjnBL2oQWw8AB6rmAvAfXGoZztesxy7o=;
        b=epucXR8aYqp4E/HcD0Mb4SKtPxW1OqfH80O3s+8N+6NOQsae6ruKRW+uEA9PArsCGVcxlU
        Y+FaIjSQC7wFCQyfRR9gTlfYiopARd9KFkm3YdR2iIqdO390N/Lmm0XCuox9iO8/l+GQTX
        12nJ7OIQ/uQOqH8rWJVUOk+kcsqcMqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-QeeRTiLSMl2nLW_LG1Zh6A-1; Tue, 15 Nov 2022 09:55:54 -0500
X-MC-Unique: QeeRTiLSMl2nLW_LG1Zh6A-1
Received: by mail-wr1-f72.google.com with SMTP id m24-20020adfa3d8000000b00236774fd74aso2856601wrb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 06:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9HIxue0KMKbjnBL2oQWw8AB6rmAvAfXGoZztesxy7o=;
        b=QzjFPjvv83LbpfYuCXUTn2A9Elf7IHTbXD6eaFFYHVdgvMHy+vAnHKJy94YV6meFsr
         Ecps5wVv42Nt4M/URrIU2gGdRv7Bw8SRsHN/4xyxrv8EQqKP5BkKDH/uhYXu25YfUBj5
         xn4Na7Z0ZTF0qOQ75M+QaaSBagUXXlz3sReFTiRSr0aY2NIhCA18wikePlT0q5GBrxog
         rCqdaVsdMpEPN3TiTlF3Y5Ecf+vNjELd7Utf53NFOs/lTWehsp+oamTsZF4gre2N0dHV
         JdFw4PUTP9Uu4pOsqPsoAvD0SqAGPflGzSDr5JmCIAuxo11XHw3CYFrPwoIw6ua97waB
         T+7w==
X-Gm-Message-State: ANoB5plbnYb47jHC7gWrP2tkLYo/zQlUsW8gpXfvYPj6VOLvptnOfuhD
        jau6Inyb0SnZEJMLemkMaLySn8V3bWQ8G+mT9hZOdQjgzyAMuM3L8IqEqT/Pu6bQJnPPhDPlmFS
        gHAdcrDJZ0GAE42nJyNpwuKEgYS8g
X-Received: by 2002:a5d:48d1:0:b0:236:55dc:b86b with SMTP id p17-20020a5d48d1000000b0023655dcb86bmr10572752wrs.708.1668524153107;
        Tue, 15 Nov 2022 06:55:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jXzMKLlY7ZGpsnwG1JIhAgG5kUd18FUfxgZ0bakWxcbhfs8wp+SL/jF/OKC68SpSe97FIQw==
X-Received: by 2002:a5d:48d1:0:b0:236:55dc:b86b with SMTP id p17-20020a5d48d1000000b0023655dcb86bmr10572739wrs.708.1668524152888;
        Tue, 15 Nov 2022 06:55:52 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d404b000000b0022ae0965a8asm12643129wrp.24.2022.11.15.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:55:52 -0800 (PST)
Message-ID: <830bdd664f7b307cc407c93974ef4906c4c9cc3f.camel@redhat.com>
Subject: Re: [PATCH v2 0/9] nSVM: Security and correctness fixes
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
Date:   Tue, 15 Nov 2022 16:55:50 +0200
In-Reply-To: <20221103141351.50662-1-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-11-03 at 16:13 +0200, Maxim Levitsky wrote:
> Recently while trying to fix some unit tests I found a CVE in SVM nested code.
> 
> In 'shutdown_interception' vmexit handler we call kvm_vcpu_reset.
> 
> However if running nested and L1 doesn't intercept shutdown, we will still end
> up running this function and trigger a bug in it.
> 
> The bug is that this function resets the 'vcpu->arch.hflags' without properly
> leaving the nested state, which leaves the vCPU in inconsistent state, which
> later triggers a kernel panic in SVM code.
> 
> The same bug can likely be triggered by sending INIT via local apic to a vCPU
> which runs a nested guest.
> 
> On VMX we are lucky that the issue can't happen because VMX always intercepts
> triple faults, thus triple fault in L2 will always be redirected to L1.
> Plus the 'handle_triple_fault' of VMX doesn't reset the vCPU.
> 
> INIT IPI can't happen on VMX either because INIT events are masked while in
> VMX mode.
> 
> First 4 patches in this series address the above issue, and are
> already posted on the list with title,
> ('nSVM: fix L0 crash if L2 has shutdown condtion which L1 doesn't intercept')
> I addressed the review feedback and also added a unit test to hit this issue.
> 
> In addition to these patches I noticed that KVM doesn't honour SHUTDOWN intercept bit
> of L1 on SVM, and I included a fix to do so - its only for correctness
> as a normal hypervisor should always intercept SHUTDOWN.
> A unit test on the other hand might want to not do so.
> I also extendted the triple_fault_test selftest to hit this issue.
> 
> Finaly I found another security issue, I found a way to
> trigger a kernel non rate limited printk on SVM from the guest, and
> last patch in the series fixes that.
> 
> A unit test I posted to kvm-unit-tests project hits this issue, so
> no selftest was added.
> 
> Best regards,
>         Maxim Levitsky
> 
> Maxim Levitsky (9):
>   KVM: x86: nSVM: leave nested mode on vCPU free
>   KVM: x86: nSVM: harden svm_free_nested against freeing vmcb02 while
>     still in use
>   KVM: x86: add kvm_leave_nested
>   KVM: x86: forcibly leave nested mode on vCPU reset
>   KVM: selftests: move idt_entry to header
>   kvm: selftests: add svm nested shutdown test
>   KVM: x86: allow L1 to not intercept triple fault
>   KVM: selftests: add svm part to triple_fault_test
>   KVM: x86: remove exit_int_info warning in svm_handle_exit
> 
>  arch/x86/kvm/svm/nested.c                     | 12 ++-
>  arch/x86/kvm/svm/svm.c                        | 10 +--
>  arch/x86/kvm/vmx/nested.c                     |  4 +-
>  arch/x86/kvm/x86.c                            | 29 ++++++--
>  tools/testing/selftests/kvm/.gitignore        |  1 +
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/include/x86_64/processor.h  | 13 ++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 13 ----
>  .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++
>  .../kvm/x86_64/triple_fault_event_test.c      | 73 ++++++++++++++-----
>  10 files changed, 172 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
> 
> -- 

Kind ping on the patch series.


Best regards,
	Maxim Levitsky

> 2.34.3
> 
> 


