Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616447C5B97
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjJKSrt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjJKSrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 14:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CDEA4
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697050015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HrWpP5EB4erpGzchcXAhQqrC/kAkv5vgdG0+5+I30o=;
        b=RM8AW+a+jV5uPvZ9FyjO8KmZgiVLz7pMKlZcSdYBh6N4mezWwdM+yx7IxQAusLIWl7l7+q
        EcwOD6OfRJZLnhlD0tlQ2z4NrSz1/P7xZjcu1badF2UZ1zrcDrrjFbrAaZKaafVvL3NUsc
        mFPzVXpkawExXMmEVfncS79prONcQjM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-NJ0nKMsGOn-eM2X6iUCweg-1; Wed, 11 Oct 2023 14:46:49 -0400
X-MC-Unique: NJ0nKMsGOn-eM2X6iUCweg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d8872a122so66021f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 11:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050008; x=1697654808;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HrWpP5EB4erpGzchcXAhQqrC/kAkv5vgdG0+5+I30o=;
        b=GBD973YPTu1FZw2Mdl2cdCeR0awLqEyDxooq+fivX01K9Ls+Sk25PefIjDUUjtilg3
         bg4Frh6IX8P3IMZx649Y51byauS3vjzjSYTdIryCKVqgzOg8TylVWP7TFmxSn1bQwS+1
         UN1VPM8B+YNxc55wf2paB15UbGEK7rEeHdMP73H5gU02ziBYbsjeOkGYJURgjUr4Lvz/
         hscOsbsZOmtmCcpqnayYZLPUmizvEv3+LNxrpzRjYzDUmfulp+pdT9+FOPneTjmzR5VF
         p0ZB0WDWIp9hMFD8dJ2e3Er0qoCwVGx71RzFI4UlukGv6AMvs5Ru2ehBxLeYhcqM6RV7
         cUfA==
X-Gm-Message-State: AOJu0YxFJ820I1qNQcbISpEVbhR+xy6fuGqYcqB49YWvf6+63uMDeQVL
        O7Wc8TPKAvwtzLJdRALxsjtNqdWNiINVxx5mDfHsfcvbpz3B/x8FSQrAjUlzW9Vze3n1kxfrQuf
        YUXBImpBjrItNkPDIIDHCQ3vICl3B
X-Received: by 2002:adf:f48e:0:b0:324:8239:2873 with SMTP id l14-20020adff48e000000b0032482392873mr21034213wro.37.1697050007831;
        Wed, 11 Oct 2023 11:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHll00uJXuN9WQLFF92LEHQMdfTNDvE9LxgHM+g6OKovYq592nyf2VXzc8O0h6Zhv7JBNMSWg==
X-Received: by 2002:adf:f48e:0:b0:324:8239:2873 with SMTP id l14-20020adff48e000000b0032482392873mr21034195wro.37.1697050007464;
        Wed, 11 Oct 2023 11:46:47 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id bv28-20020a0560001f1c00b0032d402f816csm5004673wrb.98.2023.10.11.11.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:46:47 -0700 (PDT)
Message-ID: <e2f344bd3c9f096e94889904f85333352dce0bcc.camel@redhat.com>
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, seanjc@google.com, dwmw2@infradead.org,
        joe.jin@oracle.com
Date:   Wed, 11 Oct 2023 21:46:45 +0300
In-Reply-To: <2604fa79-b114-60d9-c28d-0d53cd0dc5c7@oracle.com>
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
         <7c2a77bb3ec9f85f684218eb80654adcdfefd60d.camel@redhat.com>
         <2604fa79-b114-60d9-c28d-0d53cd0dc5c7@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

У вт, 2023-10-10 у 09:31 -0700, Dongli Zhang пише:
> Hi Maxim,
> 
> On 10/10/23 09:13, Maxim Levitsky wrote:
> > У пт, 2023-10-06 у 10:57 -0700, Dongli Zhang пише:
> > > As inspired by the discussion in [1], the boottime wallclock may drift due
> > > to the fact that the masterclock (or host monotonic clock) and kvmclock are
> > > calculated based on the algorithms in different domains.
> > > 
> > > This is to introduce a testcase to print the boottime wallclock
> > > periodically to help diagnose the wallclock drift issue in the future.
> > > 
> > > The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
> > > wallclock nanoseconds immediately.
> > > 
> > > References:
> > > [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20231001111313.77586-1-nsaenz@amazon.com__;!!ACWV5N9M2RV99hQ!MOnoujF4PlfvZ3SUuyXgIpJC5mWiE5uLUsNW6AWgirGXcObN5uil_fnthRVcYaPA0N2uoNyLChBogHC7ZS6t$ 
> > > 
> > > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile          |   3 +-
> > >  .../selftests/kvm/x86_64/boottime_wallclock.c | 100 ++++++++++++++++++
> > >  2 files changed, 102 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> > > 
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > > index a3bb36fb3cfc..fea05b0118de 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -60,7 +60,8 @@ LIBKVM_riscv += lib/riscv/ucall.c
> > >  TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
> > >  
> > >  # Compiled test targets
> > > -TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
> > > +TEST_GEN_PROGS_x86_64 = x86_64/boottime_wallclock
> > > +TEST_GEN_PROGS_x86_64 += x86_64/cpuid_test
> > >  TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
> > >  TEST_GEN_PROGS_x86_64 += x86_64/dirty_log_page_splitting_test
> > >  TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> > > diff --git a/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> > > new file mode 100644
> > > index 000000000000..cc48c9b19920
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> > > @@ -0,0 +1,100 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2023 Oracle and/or its affiliates.
> > > + */
> > > +
> > > +#include <asm/kvm_para.h>
> > > +#include <asm/pvclock-abi.h>
> > > +
> > > +#include "kvm_util.h"
> > > +#include "processor.h"
> > > +
> > > +static int period = 10;
> > > +
> > > +#define GUEST_SYNC_WALLCLOCK(__stage, __val)                        \
> > > +		GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
> > > +
> > > +static void guest_main(vm_paddr_t wc_pa, struct pvclock_wall_clock *wc)
> > > +{
> > > +	uint64_t wallclock;
> > > +
> > > +	while (true) {
> > > +		wrmsr(MSR_KVM_WALL_CLOCK_NEW, wc_pa);
> > > +
> > > +		wallclock = wc->sec * NSEC_PER_SEC + wc->nsec;
> > > +
> > > +		GUEST_SYNC_WALLCLOCK(0, wallclock);
> > 
> > Won't this fill the output very fast?
> > Do you think it will be worth it to wait some time (e.g 1 second or at least 1/10 of a second)
> > between each print?
> 
> The wait time is controlled by the VMM side (of selftest) as in below.
> 
> In the while loop at VMM side, it sleeps for a period (configurable argument),
> until it runs into the guest again.
> 
> Therefore, the user can decide the frequency to print the boottime wallclock.


Sorry about this, I haven't noticed this code!


Best regards,
	Maxim Levitsky
> 
> +static void enter_guest(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	while (true) {
> +		vcpu_run(vcpu); -----------> to schedule guest vcpu here
> +
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_SYNC:
> +			handle_sync(&uc);
> +			break;
> +		case UCALL_ABORT:
> +			handle_abort(&uc);
> +			return;
> +		default:
> +			TEST_ASSERT(0, "unhandled ucall: %ld\n", uc.cmd);
> +			return;
> +		}
> +
> +		sleep(period);  ------------> sleep here
> +	}
> +}
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> > > +	}
> > > +}
> > > +
> > > +static void handle_sync(struct ucall *uc)
> > > +{
> > > +	uint64_t wallclock;
> > > +
> > > +	wallclock = uc->args[2];
> > > +
> > > +	pr_info("Boottime wallclock value: %"PRIu64" ns\n", wallclock);
> > > +}
> > > +
> > > +static void handle_abort(struct ucall *uc)
> > > +{
> > > +	REPORT_GUEST_ASSERT(*uc);
> > > +}
> > > +
> > > +static void enter_guest(struct kvm_vcpu *vcpu)
> > > +{
> > > +	struct ucall uc;
> > > +
> > > +	while (true) {
> > > +		vcpu_run(vcpu);
> > > +
> > > +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > > +
> > > +		switch (get_ucall(vcpu, &uc)) {
> > > +		case UCALL_SYNC:
> > > +			handle_sync(&uc);
> > > +			break;
> > > +		case UCALL_ABORT:
> > > +			handle_abort(&uc);
> > > +			return;
> > > +		default:
> > > +			TEST_ASSERT(0, "unhandled ucall: %ld\n", uc.cmd);
> > > +			return;
> > > +		}
> > > +
> > > +		sleep(period);
> > > +	}
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +	struct kvm_vcpu *vcpu;
> > > +	struct kvm_vm *vm;
> > > +	vm_vaddr_t wc_gva;
> > > +	vm_paddr_t wc_gpa;
> > > +	int opt;
> > > +
> > > +	while ((opt = getopt(argc, argv, "p:h")) != -1) {
> > > +		switch (opt) {
> > > +		case 'p':
> > > +			period = atoi_positive("The period (seconds)", optarg);
> > > +			break;
> > > +		case 'h':
> > > +		default:
> > > +			pr_info("usage: %s [-p period (seconds)]\n", argv[0]);
> > > +			exit(1);
> > > +		}
> > > +	}
> > > +
> > > +	pr_info("Capture boottime wallclock every %d seconds.\n", period);
> > > +	pr_info("Stop with Ctrl + c.\n\n");
> > > +
> > > +	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
> > > +
> > > +	wc_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
> > > +	wc_gpa = addr_gva2gpa(vm, wc_gva);
> > > +	vcpu_args_set(vcpu, 2, wc_gpa, wc_gva);
> > > +
> > > +	enter_guest(vcpu);
> > > +	kvm_vm_free(vm);
> > > +}
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 


