Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E75577EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFWKdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiFWKdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 06:33:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6240E7E;
        Thu, 23 Jun 2022 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655980416; x=1687516416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gn5ZpRg4Tt3g3k8kBqC/n3XCLGoTrgvw3Xe7VLjDhQc=;
  b=Eyrz51ArEUejTnsCAyPGbHM8ASzJ3BReZFM631HTOMUSjdbMTedmzr21
   F8skAiFzb+Z8fSQOfpHZsU4xB3P9jNTbG9vITVcW50LYXGha+KV4CtyiP
   5JJgAuX70xs47jQWkqX4bR6s8AJAEMIxWw15OTOIKwrjydHGgECV0fvBl
   M0clgVuLyQKJbDXwaFjXEWWnSVwRC3bctv9UN6ibtDkJYjSXkNm2Sv7n0
   +r+7H+FyDJnyR1bPgmE7WPNXaoqIVmbw9f63c1JdUbOW4CdB4AbXNm/7g
   Wx64ucblwTogb8CmJP6DjMVeXVG8zLV0jopTBvd2AzwRBNkVjCqI0quHP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278232928"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278232928"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:33:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644674791"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:33:34 -0700
Date:   Thu, 23 Jun 2022 18:33:19 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in
 x2APIC mode
Message-ID: <20220623103314.GA14006@gao-cwp>
References: <20220623094511.26066-1-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623094511.26066-1-guang.zeng@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 23, 2022 at 05:45:11PM +0800, Zeng Guang wrote:
>Hardware would directly write x2APIC ICR register instead of software
>emulation in some circumstances, e.g when Intel IPI virtualization is
>enabled. This behavior requires normal reserved bits checking to ensure
>them input as zero, otherwise it will cause #GP. So we need mask out
>those reserved bits from the data written to vICR register.

OK. One open is:

Current KVM doesn't emulate this #GP. Is there any historical reason?
if no, we will fix KVM and add some tests to verify this #GP is
correctly emulated.

>
>Remove Delivery Status bit emulation in test case as this flag
>is invalid and not needed in x2APIC mode. KVM may ignore clearing
>it during interrupt dispatch which will lead to fake test failure.
>
>Opportunstically correct vector number for test sending IPI to
>non-existent vCPUs.
>
>Signed-off-by: Zeng Guang <guang.zeng@intel.com>
>---
> .../selftests/kvm/x86_64/xapic_state_test.c   | 20 ++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
>index 0792334ba243..df916c6f53f9 100644
>--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
>+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
>@@ -70,13 +70,27 @@ static void ____test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
> 	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
> 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
> 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
>-	if (!vcpu->is_x2apic)
>+	if (!vcpu->is_x2apic) {
> 		val &= (-1u | (0xffull << (32 + 24)));
>-	ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
>+		ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
>+	} else {

>+		ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);

Probably add a comment for it would be better. E.g.,

APIC_ICR_BUSY is removed and not used when CPU is in x2APIC mode.
It is undefined whether write 1 to this bit will be preserved. So,
even KVM keeps this bit cleared in some cases even in x2apic mode,
no guarantee that hardware (specifically, CPU ucode when Intel IPI
virtualization enabled) will clear the bit. So, skip checking this
bit.
