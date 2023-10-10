Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA477C0159
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjJJQON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343501AbjJJQOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB7CF
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696954395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1753iSDySdyPeq52nW4qkiN8umTNgnvnTBeNQOoWhk=;
        b=DU++KwZUUcmI1OHtqfQhcSVP0/5d7NeWR0FyB9NkIyWhDywGaUhD1rmNxezBwY1pBtBeVy
        cHMJwoHUtqfm2+pZnog+vqJ56Fb4JbUDRNjfxURZcco9rYw1qP8GwvQvef+c9nQmy0bDQH
        gq/Zrhua77bCdbPF5krVv6gce+VQOFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-6ATwMR8PNvOGCnDrP6ywjQ-1; Tue, 10 Oct 2023 12:13:13 -0400
X-MC-Unique: 6ATwMR8PNvOGCnDrP6ywjQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40570ccc497so42868975e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 09:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954392; x=1697559192;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1753iSDySdyPeq52nW4qkiN8umTNgnvnTBeNQOoWhk=;
        b=GlBdx9Rv/JpMiRtzHkies9MOXXyEe5ieh0V+iPjCNvWbDFysVoYwg7EO6B6a9DJayB
         ICMQRQslgGDpnEjRxjTtxDnXL/jt03cy50CdU4TqRUnrAWJuSmum006GaMVG39NKKPrc
         O8n6v1Yt076f4PfMJtXmEHEUeKyD0aG+s1QBMY5OSzkWypb583vyx/o++XrLlQVUkSvz
         r3l2GRJod60joZFINkY2i9H2zpuR5sU6Uza5vu1Xm5vE7ldKa5+0cj1apNc4nG56MrGy
         w97c1IpjmwZzmtyjYJpY+kQ9rlDY36Kk4q2xqSezNY2WeHIsDtS0e/og0uQ8vqTQonzm
         O2/w==
X-Gm-Message-State: AOJu0YyHv9tjLmYX1rru/ocDDHfJuDeyI7kvK/iwBAZfov658mFqLYQY
        N30UvRNfCiwg9oY8DDx67mTWMTwHJwbo8jZoefMKuJFejoAoR0cDASldl3BxWSoSnIvBrLRiGtE
        xREYxsQHO85q+NHseBfsnim0P31lR
X-Received: by 2002:a05:600c:ad0:b0:405:375d:b860 with SMTP id c16-20020a05600c0ad000b00405375db860mr17819264wmr.21.1696954392695;
        Tue, 10 Oct 2023 09:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs2fH4NHjpkUxflX5p7dSmGCMRr2l+ZvyM5EgqLstCWYTU6mdw3EFtRmwc7jHyDGY6IYO9kg==
X-Received: by 2002:a05:600c:ad0:b0:405:375d:b860 with SMTP id c16-20020a05600c0ad000b00405375db860mr17819250wmr.21.1696954392437;
        Tue, 10 Oct 2023 09:13:12 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm16790678wmc.6.2023.10.10.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:13:11 -0700 (PDT)
Message-ID: <7c2a77bb3ec9f85f684218eb80654adcdfefd60d.camel@redhat.com>
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, seanjc@google.com, dwmw2@infradead.org,
        joe.jin@oracle.com
Date:   Tue, 10 Oct 2023 19:13:10 +0300
In-Reply-To: <20231006175715.105517-1-dongli.zhang@oracle.com>
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

У пт, 2023-10-06 у 10:57 -0700, Dongli Zhang пише:
> As inspired by the discussion in [1], the boottime wallclock may drift due
> to the fact that the masterclock (or host monotonic clock) and kvmclock are
> calculated based on the algorithms in different domains.
> 
> This is to introduce a testcase to print the boottime wallclock
> periodically to help diagnose the wallclock drift issue in the future.
> 
> The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
> wallclock nanoseconds immediately.
> 
> References:
> [1] https://lore.kernel.org/all/20231001111313.77586-1-nsaenz@amazon.com
> 
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   3 +-
>  .../selftests/kvm/x86_64/boottime_wallclock.c | 100 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a3bb36fb3cfc..fea05b0118de 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -60,7 +60,8 @@ LIBKVM_riscv += lib/riscv/ucall.c
>  TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
>  
>  # Compiled test targets
> -TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
> +TEST_GEN_PROGS_x86_64 = x86_64/boottime_wallclock
> +TEST_GEN_PROGS_x86_64 += x86_64/cpuid_test
>  TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
>  TEST_GEN_PROGS_x86_64 += x86_64/dirty_log_page_splitting_test
>  TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> diff --git a/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> new file mode 100644
> index 000000000000..cc48c9b19920
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Oracle and/or its affiliates.
> + */
> +
> +#include <asm/kvm_para.h>
> +#include <asm/pvclock-abi.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +static int period = 10;
> +
> +#define GUEST_SYNC_WALLCLOCK(__stage, __val)                        \
> +		GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
> +
> +static void guest_main(vm_paddr_t wc_pa, struct pvclock_wall_clock *wc)
> +{
> +	uint64_t wallclock;
> +
> +	while (true) {
> +		wrmsr(MSR_KVM_WALL_CLOCK_NEW, wc_pa);
> +
> +		wallclock = wc->sec * NSEC_PER_SEC + wc->nsec;
> +
> +		GUEST_SYNC_WALLCLOCK(0, wallclock);

Won't this fill the output very fast?
Do you think it will be worth it to wait some time (e.g 1 second or at least 1/10 of a second)
between each print?

> +	}
> +}
> +
> +static void handle_sync(struct ucall *uc)
> +{
> +	uint64_t wallclock;
> +
> +	wallclock = uc->args[2];
> +
> +	pr_info("Boottime wallclock value: %"PRIu64" ns\n", wallclock);
> +}
> +
> +static void handle_abort(struct ucall *uc)
> +{
> +	REPORT_GUEST_ASSERT(*uc);
> +}
> +
> +static void enter_guest(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	while (true) {
> +		vcpu_run(vcpu);
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
> +		sleep(period);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	vm_vaddr_t wc_gva;
> +	vm_paddr_t wc_gpa;
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "p:h")) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			period = atoi_positive("The period (seconds)", optarg);
> +			break;
> +		case 'h':
> +		default:
> +			pr_info("usage: %s [-p period (seconds)]\n", argv[0]);
> +			exit(1);
> +		}
> +	}
> +
> +	pr_info("Capture boottime wallclock every %d seconds.\n", period);
> +	pr_info("Stop with Ctrl + c.\n\n");
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
> +
> +	wc_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
> +	wc_gpa = addr_gva2gpa(vm, wc_gva);
> +	vcpu_args_set(vcpu, 2, wc_gpa, wc_gva);
> +
> +	enter_guest(vcpu);
> +	kvm_vm_free(vm);
> +}


Best regards,
	Maxim Levitsky


