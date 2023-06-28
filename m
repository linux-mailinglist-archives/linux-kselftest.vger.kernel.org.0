Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F316741B3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 23:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjF1V4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjF1Vzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 17:55:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DAD2D7C
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:55:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c22664c3df7so24892276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687989332; x=1690581332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1lKcqn9ySILuHAuk8KKZF1RwSNsgXAEhY3643E2F/0=;
        b=BRo0KRb5NEu7qjfuG+yJrx9L3lM9o2xl8qUFEVLG5EUlUs/qioeXBSoR5z6LDsE9ZY
         gPZeFxMbvifz00kbpJFWCMCfrf0Q2RJeMmsar6q3K0K3QpreHsH1twT4OjsNeoa/V6nb
         fdG6vrSspxz8fm6cCBqkCku4lf8VOMgCbv92Y/5ASoAwzLCQqBmFBMhWAa051ABRI1Dj
         PeA6D9aKqlwVebLuTluwqPwHVv9Zv6YZ1CiieJ+93pViWelJi2ZW7YGRgzc+l0o12+iC
         AmAPZP1GopOS9vB10hpjCpvo1ILZwLdWjf8G1dczq05oasD5dK449wgeNvZRdK8aioVK
         KbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989332; x=1690581332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1lKcqn9ySILuHAuk8KKZF1RwSNsgXAEhY3643E2F/0=;
        b=AQRK9+bDHLYcIaH2X7WqUxYa+HdfjcFWMY3m1rZ7lREnXYJ8kLzkOjFGlnAo6w6gGP
         H4IpYSULr03pu4B4pwiIQkttdMB8pUnmUvOMsWXQ7rIYZJLSCeDiRSyeVX+12WocMSe1
         yV4rLQQiNnn+mTGuTrKS+RDWUtRYdlJZASS6IaNNGRCDCWWYLirh0zLrw7bcHMohjkET
         NZ5dB8jQQR1Lrzx0MIYoBtQy6N6UwnLn/j8/+vpx/niAsNTufeELgtvG68LWIT9UjYwa
         khIJkd7GWbiPRlYq3/BTFDx5BiQ2d6sAcgN6NmSu6504N49p+L7Q1/2OmlnJCPW8givR
         QnQQ==
X-Gm-Message-State: ABy/qLYTaevKKNsuzfuqlI9KjCf0FBoM/zrJTqIR4wEblvidDPlzyUjv
        72kvvnrsDZONJ6yMFc3WR74R+1TRrDg=
X-Google-Smtp-Source: APBJJlFKvBpXnkX0H2yHtqHBM7Cd2bMIR38Te1JNjKYkfLsUjcuLMNcqnz4YWiw5D6/1sYDxAYEnbv+3kcA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1105:b0:c17:b9e7:4c2c with SMTP id
 o5-20020a056902110500b00c17b9e74c2cmr40499ybu.6.1687989332365; Wed, 28 Jun
 2023 14:55:32 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:55:30 -0700
In-Reply-To: <20230608113420.14695-3-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230608113420.14695-1-cloudliang@tencent.com> <20230608113420.14695-3-cloudliang@tencent.com>
Message-ID: <ZJysUp5Ndnecok4S@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add PEBS test for MSR_IA32_PERF_CAPABILITIES
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> This commit adds a PEBS test that verifies all possible combinations
> of PEBS-related bits in MSR_IA32_PERF_CAPABILITIES. This comprehensive
> test ensures the accuracy of the PEBS feature.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> index 02903084598f..c1b1ba44bc26 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> @@ -21,6 +21,12 @@
>  
>  #define MAX_LINEAR_ADDR_MASK		GENMASK_ULL(15, 8)
>  #define ADDR_OFS_BIT			8
> +#define PMU_CAP_LBR_FMT		0x3f
> +#define PMU_CAP_SMM_FREEZE		BIT_ULL(12)
> +#define PMU_CAP_FW_WRITES		BIT_ULL(13)
> +#define PMU_CAP_PERF_METRICS_AVAILABLE	BIT_ULL(PERF_CAP_METRICS_IDX)
> +#define PMU_CAP_PEBS_OUTPUT_PT_AVAIL	BIT_ULL(PERF_CAP_PT_IDX)
> +#define PMU_CAP_PEBS_ALL		(PERF_CAP_PEBS_MASK | PMU_CAP_PEBS_OUTPUT_PT_AVAIL)
>  
>  union perf_capabilities {
>  	struct {
> @@ -331,6 +337,70 @@ static void test_ds_area_noncanonical_address(union perf_capabilities host_cap)
>  	kvm_vm_free(vm);
>  }
>  
> +static void test_pebs_bit_combinations(union perf_capabilities host_cap)
> +{
> +	int ret;

Reverse xmas tree.

> +	uint64_t pebs_val, val;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);

It's kinda silly, but I think it makes sense to wait until after all of the
TEST_REQUIRE()s to create the VM+vCPU.

> +
> +	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 1);
> +	TEST_REQUIRE(host_cap.capabilities & PERF_CAP_PEBS_FORMAT);
> +	TEST_REQUIRE(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE) &
> +		     MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL);
> +
> +	/*
> +	 * Test if PEBS_REC_FMT is set and the value is the same as host,
> +	 * the other PEBS bits are allowed to be set only if they are the
> +	 * same as host.
> +	 */
> +	pebs_val = host_cap.capabilities & PMU_CAP_PEBS_ALL;
> +
> +	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, pebs_val);
> +	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
> +		  (u64)pebs_val);

This cast shouldn't be necessary.  And if you're going to split lines...

	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
		  host_cap.capabilities & PMU_CAP_PEBS_ALL);

Though isn't that flawed?  E.g. will fail if MSR_IA32_PERF_CAPABILITIES has
non-PEBS bits set.  I think what you want is something like:

	guest_perf_caps = vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES);

	ASSERT_EQ(guest_perf_caps & PMU_CAP_PEBS_ALL,
		  host_cap.capabilities & PMU_CAP_PEBS_ALL);

> +
> +	/* Test all PEBS bit combinations. */
> +	for (val = 0x0; val <= (~0ul & PMU_CAP_PEBS_ALL); val++) {
> +		/* Skips values that are not related to PEBS. */
> +		if (val & (PMU_CAP_LBR_FMT | PMU_CAP_SMM_FREEZE |
> +		    PMU_CAP_FW_WRITES | PMU_CAP_PERF_METRICS_AVAILABLE))

Align things by their scope, i.e.

		if (val & (PMU_CAP_LBR_FMT | PMU_CAP_SMM_FREEZE
			   PMU_CAP_FW_WRITES | PMU_CAP_PERF_METRICS_AVAILABLE))

But even better would be to look for !PEBS, not some other values where it's not
clear they exhaustively cover all !PEBS value.  E.g. can't this be?

		if (val & ~PMU_CAP_PEBS_ALL)
			continue;

> +			continue;
> +
> +		/*
> +		 * Test that value of PEBS is rejected when the KVM doesn't

Just "KVM", not "the KVM".

> +		 * supports Intel PT.
> +		 */
> +		if ((val & PMU_CAP_PEBS_OUTPUT_PT_AVAIL) &&
> +		    (!(host_cap.capabilities & PMU_CAP_PEBS_OUTPUT_PT_AVAIL))) {
> +			ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
> +			TEST_ASSERT(!ret, "Bad PEBS auxiliary bits = 0x%lx didn't fail", val);
> +
> +			continue;
> +		}
> +
> +		/*
> +		 * Test that value of PEBS is rejected when carrying

I don't quite follow what you mean by "carrying".  Do you mean a non-zero value?

> +		 * PEBS_REC_FMT if the value of PEBS is not equal to host.
> +		 */
> +		if ((val & PERF_CAP_PEBS_FORMAT) && val != pebs_val) {
> +			ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
> +			TEST_ASSERT(!ret, "Bad PEBS auxiliary bits = 0x%lx didn't fail", val);
> +
> +			continue;
> +		}
> +
> +		/*
> +		 * Test that PEBS bits can be written simultaneously or
> +		 * independently if PEBS_REC_FMT is not carried.
> +		 */
> +		vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
> +		ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), val);
> +	}
> +
> +	kvm_vm_free(vm);
> +}
