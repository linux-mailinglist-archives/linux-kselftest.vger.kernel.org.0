Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5468726E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 01:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBBAiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Feb 2023 19:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBAhp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Feb 2023 19:37:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B4761DD
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 16:37:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so297222pjb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Feb 2023 16:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8S8LkIIV+AlMHhYoTbGzsUKCLPIHbJN6C9VR4H2aVWg=;
        b=FeiR69FdPNiRLfW96Ofno781eV28FxmGlOp8XPDNf6L0BTinviMc13f10S7fI/W1P+
         R1L8l1shqsIxAtPuQkiUJG4i6ayhIAxtjKKelxXYcnr1aOS+ajBLm4disbJKsFTeGP8t
         tCiHlHRdoKPw0c8RlxG5TVI75ek5iH3P93tQqNDuTqb5EdXS4Ti9V02sILs+XWTl7qWz
         InrfsZxE5B7QLWlfxyt4xHVtsL4SOK924yuE6KWi9avFYTo3GgqCZSomSTU61xuFd3DC
         My5qm/2a2aWVOaB7RjteivwXIbDPW5v4GzIBdvFCIz13iQYkpHrL8EsU/8i6Se+D0J8F
         /k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S8LkIIV+AlMHhYoTbGzsUKCLPIHbJN6C9VR4H2aVWg=;
        b=lhIyUlxQrptbfuxqVvez4D34Gg4eovB+/RtBVxxkJikt09raABeHG9c6z+7ZZnN802
         nl1tGIdnJ79FKDMn4d8y9+d7WX1aO0XXGOIhrJtaESFJzyPEHuyWpLCJffgis1IUFUc/
         eVypKp9Y/4/xG/dwEThPNrJvGOckabs5j5dnVmQsmOw9wL7WWc3gkr9VOdKM72uG3TES
         a9SdWbv3E7BaGif9kjWS5pjky/0m8MEMEHGCiNdwbC1Nhci1qy67s6TrIqNt5+KmhP/l
         YMQfxtjWUquIG1eGCa5+sUJbjMAllfoaUZ31tmR7FolFQg8WPqFCTqfWJzFzqYbbVn08
         mQFQ==
X-Gm-Message-State: AO0yUKWSc9fkbMxnuh+NSsZHbkkM31nxK2aBmNSyFiNzqM5fz1QoMI+j
        Fl/9VD+t9oAQMvLpiVQtNiNn3g==
X-Google-Smtp-Source: AK7set9qaZmHpUgiYk5goPmDLZfFaJSoQvNehVGDo9YWz1zOV7CvLxJuTAEvn3/yi7i8RkMr9S803g==
X-Received: by 2002:a17:902:d903:b0:198:af4f:de0d with SMTP id c3-20020a170902d90300b00198af4fde0dmr133094plz.13.1675298247023;
        Wed, 01 Feb 2023 16:37:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b001966eaf7365sm8312658plp.17.2023.02.01.16.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 16:37:26 -0800 (PST)
Date:   Thu, 2 Feb 2023 00:37:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] KVM: selftests: APIC_ID must be correctly
 updated when disabling x2apic
Message-ID: <Y9sFw0PkuR5EPm4l@google.com>
References: <20230109130605.2013555-1-eesposit@redhat.com>
 <20230109130605.2013555-3-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109130605.2013555-3-eesposit@redhat.com>
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

On Mon, Jan 09, 2023, Emanuele Giuseppe Esposito wrote:
> Make sure the APIC_ID is correctly shifted in the right bit positions
> when disabling x2APIC via KVM_SET_MSRS.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  .../selftests/kvm/x86_64/xapic_state_test.c   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> index d7d37dae3eeb..6ebda7162a25 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> @@ -132,6 +132,62 @@ static void test_icr(struct xapic_vcpu *x)
>  	__test_icr(x, -1ull & ~APIC_DM_FIXED_MASK);
>  }
>  
> +static void _test_lapic_id

There's no need for the underscore since this is "lapic" vs. "apic", though I would
prefer to name them both "apic" and go with double underscores, i.e. __test_apic_id().

> (struct kvm_vcpu *vcpu, bool x2apic_enabled,

Pass the entire apic_base value to avoid magic booleans, and then that also lets
this helper do the vcpu_set_msr().

> +			   int expected_id)

There's no need to pass the expected APIC ID, it can be derived from vcpu->id.

> +{
> +	struct kvm_lapic_state xapic;
> +
> +	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
> +	if (x2apic_enabled)
> +		ASSERT_EQ(xapic.regs[APIC_ID], expected_id);
> +	else
> +		ASSERT_EQ(xapic.regs[0x23], expected_id);

Oof.  It's gross (we need more helpers), but the APIC_ID should be read as a 32-bit
value, both to fully validate x2APIC and to check that KVM doesn't leave bits set
in the reserved portion of APIC_ID when in xAPIC mode.

	apic_id = *((u32 *)&xapic.regs[APIC_ID]);

And then shift the expected ID instead of the actual ID so that it's more obvious
what went wrong on failure, e.g. generate errors like

	APIC_ID not set back to xAPIC format; wanted = 1000000, got = 1

versus just seeing '0' from the high byte.

> +}
> +
> +static void test_apic_id(struct kvm_vcpu *vcpu, int id)
> +{
> +	int ret;
> +	struct {
> +		struct kvm_msrs info;
> +		struct kvm_msr_entry entries[1];
> +	} msr_data = {
> +		.info.nmsrs = 1,
> +		.entries[0].index = MSR_IA32_APICBASE,
> +	};
> +
> +	/* vcpu is initialized with xAPIC enabled */
> +	ret = __vcpu_ioctl(vcpu, KVM_GET_MSRS, &msr_data.info);
> +	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));

Use vcpu_get_msr().

> +	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
> +		  MSR_IA32_APICBASE_ENABLE);

This is hard to read.  I get annoyed with TEST_ASSERT() requiring a message, but
in this case using ASSERT_EQ() to avoid the message is a net negative (I blinked
a few times to figure out what it was asserting).

		TEST_ASSERT(apic_base & MSR_IA32_APICBASE_ENABLE,
			    "APIC not in ENABLED state at vCPU RESET");
		TEST_ASSERT(!(apic_base & X2APIC_ENABLE),
			    "APIC not in xAPIC mode at vCPU RESET");

> +	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, 0);
> +	_test_lapic_id(vcpu, false, id);
> +
> +	/* enable x2APIC */
> +	msr_data.entries[0].data |= X2APIC_ENABLE;
> +	ret = __vcpu_ioctl(vcpu, KVM_SET_MSRS, &msr_data.info);
> +	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));
> +	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
> +		  MSR_IA32_APICBASE_ENABLE);
> +	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, X2APIC_ENABLE);
> +	_test_lapic_id(vcpu, true, id);
> +
> +	/*
> +	 * Check that disabling x2APIC correctly updates the APIC ID to the
> +	 * xAPIC format.
> +	 */
> +	msr_data.entries[0].data ^= X2APIC_ENABLE;

XOR works, but it obfuscates the code.  AND ~, or just use the original value.

> +	ret = __vcpu_ioctl(vcpu, KVM_SET_MSRS, &msr_data.info);
> +	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));
> +	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
> +		  MSR_IA32_APICBASE_ENABLE);
> +	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, 0);
> +	_test_lapic_id(vcpu, false, id);
> +}
> +
> +#define NCPUS 3
> +
>  int main(int argc, char *argv[])
>  {
>  	struct xapic_vcpu x = {
> @@ -139,6 +195,14 @@ int main(int argc, char *argv[])
>  		.is_x2apic = true,
>  	};
>  	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpus[NCPUS] = { 0 };
> +	int i;
> +
> +	vm = vm_create_with_vcpus(NCPUS, NULL, vcpus);
> +	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
> +	for (i = 0; i < NCPUS; i++)
> +		test_apic_id(vcpus[i], i);
> +	kvm_vm_free(vm);

I would prefer to put this in the helper, test_apic_id(), so that there isn't
confusion between the number of vCPUs for that sub-test and the existing tests.

This is what I ended up with:

static void __test_apic_id(struct kvm_vcpu *vcpu, uint64_t apic_base)
{
	uint32_t apic_id, expected;
	struct kvm_lapic_state xapic;

	vcpu_set_msr(vcpu, MSR_IA32_APICBASE, apic_base);

	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);

	expected = apic_base & X2APIC_ENABLE ? vcpu->id : vcpu->id << 24;
	apic_id = *((u32 *)&xapic.regs[APIC_ID]);

	TEST_ASSERT(apic_id == expected,
		    "APIC_ID not set back to %s format; wanted = %x, got = %x",
		    (apic_base & X2APIC_ENABLE) ? "x2APIC" : "xAPIC",
		    expected, apic_id);
}

/*
 * Verify that KVM switches the APIC_ID between xAPIC and x2APIC when userspace
 * stuffs MSR_IA32_APICBASE.  Setting the APIC_ID when x2APIC is enabled and
 * when the APIC transitions for DISABLED to ENABLED is architectural behavior
 * (on Intel), whereas the x2APIC => xAPIC transition behavior is KVM ABI since
 * attempted to transition from x2APIC to xAPIC without disabling the APIC is
 * architecturally disallowed.
 */
static void test_apic_id(void)
{
	const uint32_t NR_VCPUS = 3;
	struct kvm_vcpu *vcpus[NR_VCPUS];
	uint64_t apic_base;
	struct kvm_vm *vm;
	int i;

	vm = vm_create_with_vcpus(NR_VCPUS, NULL, vcpus);
	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);

	for (i = 0; i < NR_VCPUS; i++) {
		apic_base = vcpu_get_msr(vcpus[i], MSR_IA32_APICBASE);

		TEST_ASSERT(apic_base & MSR_IA32_APICBASE_ENABLE,
			    "APIC not in ENABLED state at vCPU RESET");
		TEST_ASSERT(!(apic_base & X2APIC_ENABLE),
			    "APIC not in xAPIC mode at vCPU RESET");

		__test_apic_id(vcpus[i], apic_base);
		__test_apic_id(vcpus[i], apic_base | X2APIC_ENABLE);
		__test_apic_id(vcpus[i], apic_base);
	}

	kvm_vm_free(vm);
}
