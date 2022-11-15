Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE2628F92
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 02:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKOBx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 20:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKOBxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 20:53:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CF1D0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 17:53:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 136so11938049pga.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sJL+OLm/9HBt9VTWAdJwvOJ+g8VmirxRTL8SSjHNQVg=;
        b=rkHRihBMn7TFJuWebxPgdWFVVvwFb3btFvnNICt5ntm9UbrFuQjanYptOIqbJHYQyN
         4ysQw2uCUwbfzesY4/LQsyZvxgC64PUwvMLuit482dri/z3JV0iZTPh1H5EOywaT9fc4
         iAhtFK7tij8bg8Tp40d8aAuFnUpIbMuqk8UMqe9OlqBkgv0wIv4ZOjQRHyAXR7WbMMIE
         5y3GH4AORF8PLSYcPxXegQhBIUGjlWWmC9pGpUcPzHhQqWHtQHVZe7pqz6yeg4xxIA9r
         QmvBz5o1VLxrcUc77Vt2WpHb9XlPavPLGzfbOuor2Ar7O9cDo9AiHlxWV/TUTuwu8h9B
         vk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJL+OLm/9HBt9VTWAdJwvOJ+g8VmirxRTL8SSjHNQVg=;
        b=nz4nmTcTQaXP2IVQbb/AJMlunerop53JXR4E8G+zjt6BIIPeQos53GYbKQUHJb9azt
         M3YyCAKKWyeK0aaE0Thw1wK6HEqOSGg8Voy2rA9TiF/6HRAw+dUce1xz9YpKPOiW72a1
         oGE0arMbvrCpL5PcEQTJG6PGzp7RCa21JRIFmgQ0bK6quAPZ2pjIEHSd4CbVmxxEZs07
         XvabW1+FF+y5mGvr7JFUkTaCW9ir0m2yfUp0DhDWMORQ+jo+s2fsbiC42+gddnPHMRaY
         wCdSZmyhVtJ5NVOYFrd/AjFxZ/JDlD/miYwBH8erukJ+dxAM48t1N2gyQATUx4Bu4956
         Hz3A==
X-Gm-Message-State: ANoB5pk86Ej+8D+RRGUVOWK5YLyu800qdPGtDmlgMxQoAJBg9u12o9Xh
        TNbXLpiYKjhBwaF0+wDRpg5u2KHTjto0/3iUIHjnNw==
X-Google-Smtp-Source: AA0mqf4+D70nwiuqmYZXKiMUqWwdK5UhdmuQ2WsugSkZYryDK0evBfEeHXyPyyLhkZaBOxTRRohXjk2oboz1mvld74I=
X-Received: by 2002:aa7:880d:0:b0:56b:676e:1815 with SMTP id
 c13-20020aa7880d000000b0056b676e1815mr16277604pfo.66.1668477203676; Mon, 14
 Nov 2022 17:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-5-vannapurve@google.com> <CAMkAt6qLC0BosvSN9Ri2XFYK65xH1E5sqJYNe6uAudb8U08rXw@mail.gmail.com>
In-Reply-To: <CAMkAt6qLC0BosvSN9Ri2XFYK65xH1E5sqJYNe6uAudb8U08rXw@mail.gmail.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 14 Nov 2022 17:53:12 -0800
Message-ID: <CAGtprH8TQ9ep5KQ5-U1PUBmzQQC7fBOLOfn2mNgnDLMO70ZYjg@mail.gmail.com>
Subject: Re: [V1 PATCH 4/6] KVM: selftests: x86: Execute VMs with private memory
To:     Peter Gonda <pgonda@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
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

On Mon, Nov 14, 2022 at 11:37 AM Peter Gonda <pgonda@google.com> wrote:
>...
> > +static void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm,
> > +                               struct kvm_vcpu *vcpu)
> > +{
> > +       uint64_t gpa, npages, attrs, size;
> > +
> > +       TEST_ASSERT(vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE,
> > +               "Unhandled Hypercall %lld\n", vcpu->run->hypercall.nr);
> > +       gpa = vcpu->run->hypercall.args[0];
> > +       npages = vcpu->run->hypercall.args[1];
> > +       size = npages << MIN_PAGE_SHIFT;
> > +       attrs = vcpu->run->hypercall.args[2];
> > +       pr_info("Explicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
> > +               (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) ? "private" : "shared");
> > +
> > +       if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
> > +               vm_allocate_private_mem(vm, gpa, size);
> > +       else
> > +               vm_unback_private_mem(vm, gpa, size);
> > +
> > +       vcpu->run->hypercall.ret = 0;
> > +}
> > +
> > +static void vcpu_work(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> > +       struct vm_setup_info *info)
> > +{
> > +       struct ucall uc;
> > +       uint64_t cmd;
> > +
> > +       /*
> > +        * Loop until the guest is done.
> > +        */
> > +
> > +       while (true) {
> > +               vcpu_run(vcpu);
> > +
> > +               if (vcpu->run->exit_reason == KVM_EXIT_IO) {
> > +                       cmd = get_ucall(vcpu, &uc);
> > +                       if (cmd != UCALL_SYNC)
> > +                               break;
> > +
> > +                       TEST_ASSERT(info->ioexit_cb, "ioexit cb not present");
> > +                       info->ioexit_cb(vm, uc.args[1]);
> > +                       continue;
> > +               }
>
> Should this be integrated into the ucall library directly somehow?
> That way users of VMs with private memory do not need special
> handling?
>
> After Sean's series:
> https://lore.kernel.org/linux-arm-kernel/20220825232522.3997340-3-seanjc@google.com/
> we have a common get_ucall() that this check could be integrated into?
>
> > +
> > +               if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL) {
> > +                       handle_vm_exit_map_gpa_hypercall(vm, vcpu);
> > +                       continue;
> > +               }
> > +
> > +               TEST_FAIL("Unhandled VCPU exit reason %d\n",
> > +                       vcpu->run->exit_reason);
> > +               break;
> > +       }
> > +
> > +       if (vcpu->run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
> > +               TEST_FAIL("%s at %s:%ld, val = %lu", (const char *)uc.args[0],
> > +                         __FILE__, uc.args[1], uc.args[2]);
> > +}
> > +
> > +/*
> > + * Execute guest vm with private memory memslots.
> > + *
> > + * Input Args:
> > + *   info - pointer to a structure containing information about setting up a VM
> > + *     with private memslots
> > + *
> > + * Output Args: None
> > + *
> > + * Return: None
> > + *
> > + * Function called by host userspace logic in selftests to execute guest vm
> > + * logic. It will install test_mem_slot : containing the region of memory that
> > + * would be used to test private/shared memory accesses to a memory backed by
> > + * private memslots
> > + */
> > +void execute_vm_with_private_test_mem(struct vm_setup_info *info)
> > +{
> > +       struct kvm_vm *vm;
> > +       struct kvm_enable_cap cap;
> > +       struct kvm_vcpu *vcpu;
> > +       uint64_t test_area_gpa, test_area_size;
> > +       struct test_setup_info *test_info = &info->test_info;
> > +
> > +       TEST_ASSERT(info->guest_fn, "guest_fn not present");
> > +       vm = vm_create_with_one_vcpu(&vcpu, info->guest_fn);
>
> I am a little confused with how this library is going to work for SEV
> VMs that want to have UPM private memory eventually.
>
> Why should users of UPM be forced to use this very specific VM
> creation and vCPU run loop. In the patch
> https://lore.kernel.org/lkml/20220829171021.701198-1-pgonda@google.com/T/#m033ebc32df47a172bc6c46d4398b6c4387b7934d
> SEV VMs need to be created specially vm_sev_create_with_one_vcpu() but
> then callers can run the VM's vCPUs like other selftests.
>
> How do you see this working with SEV VMs?
>

This VM creation method can be useful to run the VMs whose execution
might call mapgpa to change the memory attributes. New VM creation
method specific to Sev VMs can be introduced.

I tried to reuse this framework earlier for Sev VM selftests via:
1) https://lore.kernel.org/lkml/20220830224259.412342-8-vannapurve@google.com/T/#m8164d3111c9a17ebab77f01635df8930207cc65d
2) https://lore.kernel.org/lkml/20220830224259.412342-8-vannapurve@google.com/T/#m8164d3111c9a17ebab77f01635df8930207cc65d

Though these changes need to be refreshed after this updated series.
