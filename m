Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7D3A78AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFOIF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhFOIF5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 04:05:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD0C0617AF
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 01:03:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so11138011ott.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CSh1z7Vp1/cJggYoB1jYFqsZlnKuhPcaTsNgRYwVSI=;
        b=O8yz83yvBRCtMVSzbGCfMg/eHcmAvfvQZTkOIrDmMi4Ya9lSWjT7L4v+4BdKPCHAr7
         o8i/5oXrv/AX3rVcPJxU+O2mwmLoFJX9GDiqaz5HSgNfEsgXYCPNJcP9FgE7IRuDoNkx
         tFHDu7d25Ci7vkTPCNOjJ0ZeoYPOGokqwLAGhgNmbyNuAeTPp5zd/L63WYBxn4HYzh91
         dRMVX09ftVaQWQV+pkiXcPlwECefKY/kQlEEaHx+kpinhn6YKL1DlJZq56FcetiW7RNx
         Kb+r7EfzgK//Y13xIojAuhb9Q27hA0AvG7oieQon3sgYE3dxk47SHgpgdFK6ACeBafwq
         FXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CSh1z7Vp1/cJggYoB1jYFqsZlnKuhPcaTsNgRYwVSI=;
        b=LGKQtJNKkFt7/YDq6po3EjJhI8HR8XOPKSgjsF/CBoxjNHO1aSCitEZjqG0zUzuSOV
         GdkhUJ9g7G8T8oNyOCU1NEyW2y1/aRBFgBtMDgXqsFrwqfFQQrc3HkVBhStHp5IQP8IF
         +5D5SscgXN+pq3Ydgmw8IWr45x7gmkWvLRTKtNGn9cTSo11g2E+s4bvpebmCVQwrExMH
         x0QntRn7O9PLxY86rpF2cPqniuL+M60w8+bEYR+nlq/WbyivYNv00rnjpvUFaQ093dkM
         +6eRWznh8ltbC4PvTZzENJbtfpwI3ydrkCDs1Epq2DfQtloJMEf3jO3lKVYSJdKz6KPG
         5F8w==
X-Gm-Message-State: AOAM530aMTNVsr1Qfx0RkYBntOFmRhrHSiazwkwnM0+IpJ3MyTeHdWMD
        WAdT9Q1FgyydSYiAyn8E7igKuSFcpjniHhyYFx36sQ==
X-Google-Smtp-Source: ABdhPJw2enLCtbwE/790AuD9R9YvbkgrP2ijrQxAzA0UdoAox+QIbPoUXnczIrY5AxRCozcc/VKv6rYEd/Kk/Su7FrA=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr16213078otp.144.1623744231983;
 Tue, 15 Jun 2021 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210614212155.1670777-1-jingzhangos@google.com> <20210614212155.1670777-5-jingzhangos@google.com>
In-Reply-To: <20210614212155.1670777-5-jingzhangos@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 15 Jun 2021 09:03:15 +0100
Message-ID: <CA+EHjTybjrYL5KUJebmjvj_R5yULDxXsiPzn6f5f-y5HzQqM6A@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jing,

> +int main(int argc, char *argv[])
> +{
> +       int max_vm = DEFAULT_NUM_VM, max_vcpu = DEFAULT_NUM_VCPU, ret, i, j;
> +       struct kvm_vm **vms;
> +
> +       /* Get the number of VMs and VCPUs that would be created for testing. */
> +       if (argc > 1) {
> +               max_vm = strtol(argv[1], NULL, 0);
> +               if (max_vm <= 0)
> +                       max_vm = DEFAULT_NUM_VM;
> +       }
> +       if (argc > 2) {
> +               max_vcpu = strtol(argv[2], NULL, 0);
> +               if (max_vcpu <= 0)
> +                       max_vcpu = DEFAULT_NUM_VCPU;
> +       }
> +
> +       /* Check the extension for binary stats */
> +       ret = kvm_check_cap(KVM_CAP_BINARY_STATS_FD);
> +       TEST_ASSERT(ret >= 0,
> +                       "Binary form statistics interface is not supported");

kvm_check_cap returns the value of KVM_CHECK_EXTENSION, which is 0 if
unsupported (-ERROR on an error). The assertion should be for ret > 0.

Made that change locally, and tested it with various configurations
(vhe, nvhe), as well as kernel versions (with and without
KVM_CAP_BINARY_STATS_FD), and it passes (or fails as expected).
Without that fix and with a kernel that doesn't support
KVM_CAP_BINARY_STATS_FD, it passes that assertion, but fails later at
vcpu_stats_test().

With that fixed:
Tested-by: Fuad Tabba <tabba@google.com> #arm64

Cheers,
/fuad


> +
> +       /* Create VMs and VCPUs */
> +       vms = malloc(sizeof(vms[0]) * max_vm);
> +       TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> +       for (i = 0; i < max_vm; ++i) {
> +               vms[i] = vm_create(VM_MODE_DEFAULT,
> +                               DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> +               for (j = 0; j < max_vcpu; ++j)
> +                       vm_vcpu_add(vms[i], j);
> +       }
> +
> +       /* Check stats read for every VM and VCPU */
> +       for (i = 0; i < max_vm; ++i) {
> +               vm_stats_test(vms[i]);
> +               for (j = 0; j < max_vcpu; ++j)
> +                       vcpu_stats_test(vms[i], j);
> +       }
> +
> +       for (i = 0; i < max_vm; ++i)
> +               kvm_vm_free(vms[i]);
> +       free(vms);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 5c70596dd1b9..83c02cb0ae1e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2286,3 +2286,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
>         n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
>         return vm_adjust_num_guest_pages(mode, n);
>  }
> +
> +int vm_get_stats_fd(struct kvm_vm *vm)
> +{
> +       return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
> +}
> +
> +int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
> +{
> +       struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +
> +       return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
> +}
> --
> 2.32.0.272.g935e593368-goog
>
