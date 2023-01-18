Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F873670F53
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 02:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjARBEV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjARBDu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 20:03:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCCD5CFDF
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 16:53:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v10-20020a17090abb8a00b00229c517a6eeso661167pjr.5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OP/pVpga7lDj6/YQtzq1BWYtDHKasyJVtPckxk0rWAI=;
        b=dLIBbCpG703ZUL9VaRXX9dZ4u2YhZQpkEfMFOAyGvwSq9JZ46d3in77dr+tfcY4h74
         nEid9m3I2bt7JI6Q63A3DXm9Z2VlLvw6HRzL8F06SCHAra30TcalEpHd1GmsNJqgGEYF
         XyWwEVRFChUPSTzUrpk8AafB/7+mcjFuImBIXOfVTpl4pkYP7mQLbx0iGaYFpFF9nOvs
         ADo2LAIxnrGWUh1UDZqDF8hh1FapZUryPUPchNq6RqmOPhq+A7aKmt27FJ9MNuFLimqT
         OgTD6Bzsshj7EHZxajmhMaISSHbt+HcW2RlLyKU7Q4YZajY0Dk9AblYCdPCV+4WEw33e
         6+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP/pVpga7lDj6/YQtzq1BWYtDHKasyJVtPckxk0rWAI=;
        b=MYl8SpobYseby771mctQQsU/oelThQRpktnQw/+E+APXhBRK/YmvBvI7I4pjuslb+d
         lnXPAr6HTG8w5aK45KFKqOHYsofG2/rkwWx8O562PBsRkbNQ7/tzHXUF5Z3TdU+XBm33
         icbjtpFK2s874nEqcdeyuv4VqqLdXUZZLlGLovVXpEoEC11PGniOunG0cWXkUj7Y4JaX
         v8mQUi+HLLxWzt0/HkDLZUDoNtsH6njOAvV6S2NMvj8x0aEjGf78g7AQlIp70SzqOjCP
         ljbxh4rSFsP1hNtGeNFOR+/WPz4wJG7yFDzs3N3MvgExzUTrM0TTV7ag0wRXi1JHLesc
         ZXvQ==
X-Gm-Message-State: AFqh2ko+pL2/F04mX5lpLydiRkvg8rxxAXCT0f+Mcv3mijx2mqycLJKM
        phjyIijZ9FfZcAfl4mRskCdGZg==
X-Google-Smtp-Source: AMrXdXsAfMPEFUll+JJwIMZqtBD+wiRuE8zoCiCMh7dBBN2X/3HwjjcCQOWUVnQKTYZIS/XQt5PpYg==
X-Received: by 2002:a05:6a21:33a1:b0:ac:af5c:2970 with SMTP id yy33-20020a056a2133a100b000acaf5c2970mr2951922pzb.3.1674003189375;
        Tue, 17 Jan 2023 16:53:09 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm17824664pgi.63.2023.01.17.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:53:08 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:53:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V2 PATCH 6/6] KVM: selftests: x86: Add selftest for private
 memory
Message-ID: <Y8dC8WDwEmYixJqt@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-7-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-7-vannapurve@google.com>
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

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> +#define TEST_AREA_SLOT		10

I vote using "DATA" instead of "TEST_AREA" just because it's shorter.

> +#define TEST_AREA_GPA		0xC0000000

Put the GPA above 4GiB, that way it'll never run afoul of the PCI hole, e.g. won't
overlap with the local APIC.

> +#define TEST_AREA_SIZE		(2 * 1024 * 1024)

Use the sizes from <linux/sizes.h>, e.g. SZ_2M.

> +#define GUEST_TEST_MEM_OFFSET	(1 * 1024 * 1024)

Same here.

> +#define GUEST_TEST_MEM_SIZE	(10 * 4096)

Why 10*4KiB?  SZ_2M + PAGE_SIZE seems like the best compromise until selftests
doesn't explode on mapping huge memslots in the guest.  That lets us test
boundary conditions wiith hugepages.

> +
> +#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)

Comments on this in the context of host_conv_test_fn().

> +#define TEST_MEM_DATA_PATTERN1	0x66

Regarding the values of the patterns, the patterns themselves are also not at all
interesting.  The goal of the test is to verify that KVM/kernel plumbs through the
correct memory.  Verifying that hardware doesn't barf on a pattern is very much a
non-goal, i.e. we aren't writing a test for DRAM.

While debugging my own goofs, I found it much, much easier to triage failures by
simply using the pattern number of the value, e.g. 1 = 0x11, 2 = 0x22, etc.

> +#define TEST_MEM_DATA_PATTERN2	0x99
> +#define TEST_MEM_DATA_PATTERN3	0x33
> +#define TEST_MEM_DATA_PATTERN4	0xaa
> +#define TEST_MEM_DATA_PATTERN5	0x12

While I like using macros instead of copy+pasting magic numbers, in this case the
macros make the code really, really hard to read.  Longish names with just one
character different all look the same when glancing through the code, e.g. identifying
when the test switches between patterns is difficult.

And IMO, having the guest explicitly tell the host what to expect yields a more
maintanable, easier to understand test overall.  And by having the guest say what
pattern(s) to expect/write, then there's no needed for the guest to have a priori
knowledge of the patterns, and thus no need for macros.

> +static bool verify_mem_contents(void *mem, uint32_t size, uint8_t pattern)
> +{
> +	uint8_t *buf = (uint8_t *)mem;
> +
> +	for (uint32_t i = 0; i < size; i++) {
> +		if (buf[i] != pattern)
> +			return false;

It took me blundering into a SHUTDOWN before I figured out these return booleans
instead of simply asserting: using TEST_ASSERT() in the guest obviously doesn't
fair well.

While I like deduplicating code, in this case it does more harm than good because
the context of exactly what fails is lost, e.g. expected vs. actual pattern,
offset, etc...  We could use macros to dedup code, i.e. have only the assertion
be different, but I don't think that ends up being a net positive either.

> +	}
> +
> +	return true;
> +}
> +
> +static void populate_test_area(void *test_area_base, uint64_t pattern)
> +{
> +	memset(test_area_base, pattern, TEST_AREA_SIZE);
> +}
> +
> +static void populate_guest_test_mem(void *guest_test_mem, uint64_t pattern)
> +{
> +	memset(guest_test_mem, pattern, GUEST_TEST_MEM_SIZE);

Generally speaking, don't add one-line wrappers that don't provide novel
functionality.  E.g. there's nothing fancy here, and so the wrappers just end up
obfuscating the size of a memset().

> +}
> +
> +static bool verify_test_area(void *test_area_base, uint64_t area_pattern,
> +	uint64_t guest_pattern)
> +{
> +	void *guest_test_mem = test_area_base + GUEST_TEST_MEM_OFFSET;
> +	void *test_area2_base = guest_test_mem + GUEST_TEST_MEM_SIZE;
> +	uint64_t test_area2_size = (TEST_AREA_SIZE - (GUEST_TEST_MEM_OFFSET +
> +			GUEST_TEST_MEM_SIZE));
> +
> +	return (verify_mem_contents(test_area_base, GUEST_TEST_MEM_OFFSET, area_pattern) &&
> +		verify_mem_contents(guest_test_mem, GUEST_TEST_MEM_SIZE, guest_pattern) &&
> +		verify_mem_contents(test_area2_base, test_area2_size, area_pattern));
> +}
> +
> +#define GUEST_STARTED			0
> +#define GUEST_PRIVATE_MEM_POPULATED	1
> +#define GUEST_SHARED_MEM_POPULATED	2
> +#define GUEST_PRIVATE_MEM_POPULATED2	3
> +
> +/*
> + * Run memory conversion tests with explicit conversion:
> + * Execute KVM hypercall to map/unmap gpa range which will cause userspace exit
> + * to back/unback private memory. Subsequent accesses by guest to the gpa range
> + * will not cause exit to userspace.
> + *
> + * Test memory conversion scenarios with following steps:
> + * 1) Access private memory using private access and verify that memory contents
> + *   are not visible to userspace.
> + * 2) Convert memory to shared using explicit conversions and ensure that
> + *   userspace is able to access the shared regions.
> + * 3) Convert memory back to private using explicit conversions and ensure that
> + *   userspace is again not able to access converted private regions.
> + */
> +static void guest_conv_test_fn(void)
> +{
> +	void *test_area_base = (void *)TEST_AREA_GPA;
> +	void *guest_test_mem = (void *)(TEST_AREA_GPA + GUEST_TEST_MEM_OFFSET);
> +	uint64_t guest_test_size = GUEST_TEST_MEM_SIZE;
> +
> +	GUEST_SYNC(GUEST_STARTED);
> +
> +	populate_test_area(test_area_base, TEST_MEM_DATA_PATTERN1);

Tangentially related to my "the patterns themselves are uninteresting" comment,
and very related to the "avoid global defines for the patterns",  I would like to
structure this test so that it's easy to test GPA+size combinations.  E.g. to
test that KVM does the right thing when a conversion spans regions that KVM is
likely to map with hugepages, or is misaligned with respect to hugepages, etc.

If the guest explicit tells the host which patterns to expect/write, then testing
combinations of addresses is just a matter of looping in the guest, e.g.

	struct {
		uint64_t offset;
		uint64_t size;
	} stages[] = {
		GUEST_STAGE(0, PAGE_SIZE),
		GUEST_STAGE(0, SZ_2M),
		GUEST_STAGE(PAGE_SIZE, PAGE_SIZE),
		GUEST_STAGE(PAGE_SIZE, SZ_2M),
		GUEST_STAGE(SZ_2M, PAGE_SIZE),
	};
	const uint8_t init_p = 0xcc;
	uint64_t j;
	int i;

	/* Memory should be shared by default. */
	memset((void *)DATA_GPA, ~init_p, DATA_SIZE);
	GUEST_SYNC4(DATA_GPA, DATA_SIZE, ~init_p, init_p);
	memcmp_g(DATA_GPA, init_p, DATA_SIZE);

	for (i = 0; i < ARRAY_SIZE(stages); i++) {
		blah blah blah
	}

> +	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED);

As above, use the sync to effectively tell/request the host to do something, as
opposed to having the host infer what it's supposed to do based on the current
stage.

Aside from wanting to be able to iterate on GPA+size, I really, really dislike
the GUEST_SYNC(stage) pattern.  It works ok for small tests, but the pattern
doesn't scale, e.g. see xen_shinfo_test.c.  Even at smaller scales, the resulting
magic numbers can be unnecessarily difficult to understand, e.g. smm_test.c isn't
doing anything _that_ complex, but every time I look at the test I spend several
minutes relearning what it does.  Using macros instead of magic numbers helps a
little, but it doesn't fix the underlying issue of bundling a bunch of testcases
into a single monolithic sequences.

> +	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
> +		TEST_MEM_DATA_PATTERN1));

Align params to help delineate the boundaries between the assert and the function
call.  E.g. if we ended up with this code:

	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
				      TEST_MEM_DATA_PATTERN1));

But as (much further) above, just assert in the comparison helper to avoid
the problem entirely.

> +
> +	kvm_hypercall_map_shared((uint64_t)guest_test_mem, guest_test_size);
> +
> +	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN2);
> +
> +	GUEST_SYNC(GUEST_SHARED_MEM_POPULATED);
> +	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
> +		TEST_MEM_DATA_PATTERN5));
> +
> +	kvm_hypercall_map_private((uint64_t)guest_test_mem, guest_test_size);
> +
> +	populate_guest_test_mem(guest_test_mem, TEST_MEM_DATA_PATTERN3);
> +	GUEST_SYNC(GUEST_PRIVATE_MEM_POPULATED2);
> +
> +	GUEST_ASSERT(verify_test_area(test_area_base, TEST_MEM_DATA_PATTERN1,
> +		TEST_MEM_DATA_PATTERN3));
> +	GUEST_DONE();
> +}
> +
> +#define ASSERT_CONV_TEST_EXIT_IO(vcpu, stage) \
> +	{ \
> +		struct ucall uc; \
> +		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
> +		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC); \
> +		ASSERT_EQ(uc.args[1], stage); \
> +	}
> +
> +#define ASSERT_GUEST_DONE(vcpu) \
> +	{ \
> +		struct ucall uc; \
> +		ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_IO); \
> +		ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE); \
> +	}
> +
> +static void host_conv_test_fn(struct kvm_vm *vm, struct kvm_vcpu *vcpu)

For future reference, "fn" is completely redundant.  It's a function, no need for
the label.  When a function pointer is a parameter, and isn't obviously such, then
"fn" can be helpful, but here it's just noise.

> +{
> +	void *test_area_hva = addr_gpa2hva(vm, TEST_AREA_GPA);
> +	void *guest_test_mem_hva = (test_area_hva + GUEST_TEST_MEM_OFFSET);
> +
> +	vcpu_run_and_handle_mapgpa(vm, vcpu);
> +	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_STARTED);
> +	populate_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4);
> +	VM_STAGE_PROCESSED(GUEST_STARTED);

Again for future reference since I think it's better to avoid named stages, if
you add macros to wrap trivial code in order to do something clever (pretty print
the name of the stage), use a name that more precisely captures the triviality of
the code.  VM_STAGE_PROCESSED() sounds like the macro is doing bookkeeping,
e.g. advancing a stage/counter or something, whereas something like print_stage()
makes it fairly clear that the helper/macro is doing nothing more than printing,
i.e. saves the reader from having to go look at the implementation to understand
the code.

Regarding the printing itself, I suspect one of the reasons why you added the
pretty printing of stages was to help debug.  While there is a time and place for
printf debugging, when it comes to KVM tests, the "need" to resort to printing
out every step is usually the symptom of unhelpful assertions and error messages.

E.g. if pattern "encodes" its number (p1 = 0x11), capturing the line number, expected
versus actual pattern, and the GPA provides pretty much all the debug info needed to
figure out what failed.

Seeing the test actually make progress can be useful, e.g. as a heartbeart for
long-running tests, but again outside of development/debug it's mostly noise.
E.g. if a test fails in CI, earlier messages may or may not be captured depending
on the whims of the CI instance/robot, and so we want as much information as
possible in the error message itself.

> +	vcpu_run_and_handle_mapgpa(vm, vcpu);
> +	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED);
> +	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
> +			TEST_MEM_DATA_PATTERN4), "failed");
> +	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED);
> +
> +	vcpu_run_and_handle_mapgpa(vm, vcpu);
> +	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_SHARED_MEM_POPULATED);
> +	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
> +			TEST_MEM_DATA_PATTERN2), "failed");
> +	populate_guest_test_mem(guest_test_mem_hva, TEST_MEM_DATA_PATTERN5);
> +	VM_STAGE_PROCESSED(GUEST_SHARED_MEM_POPULATED);
> +
> +	vcpu_run_and_handle_mapgpa(vm, vcpu);
> +	ASSERT_CONV_TEST_EXIT_IO(vcpu, GUEST_PRIVATE_MEM_POPULATED2);
> +	TEST_ASSERT(verify_test_area(test_area_hva, TEST_MEM_DATA_PATTERN4,
> +			TEST_MEM_DATA_PATTERN5), "failed");
> +	VM_STAGE_PROCESSED(GUEST_PRIVATE_MEM_POPULATED2);
> +
> +	vcpu_run_and_handle_mapgpa(vm, vcpu);
> +	ASSERT_GUEST_DONE(vcpu);
> +}
> +
> +static void execute_vm_with_private_test_mem(
> +			enum vm_mem_backing_src_type test_mem_src)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_enable_cap cap;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_conv_test_fn);
> +
> +	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);

TEST_REQUIRE() so that the test is skipped, not failed.

> +	cap.cap = KVM_CAP_EXIT_HYPERCALL;
> +	cap.flags = 0;
> +	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
> +	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);

vm_enable_cap() will do most of this for you.

> +
> +	vm_userspace_mem_region_add(vm, test_mem_src, TEST_AREA_GPA,
> +		TEST_AREA_SLOT, TEST_AREA_SIZE / vm->page_size, KVM_MEM_PRIVATE);

Align params.

> +	vm_allocate_private_mem(vm, TEST_AREA_GPA, TEST_AREA_SIZE);
> +
> +	virt_map(vm, TEST_AREA_GPA, TEST_AREA_GPA, TEST_AREA_SIZE/vm->page_size);
> +
> +	host_conv_test_fn(vm, vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	execute_vm_with_private_test_mem(
> +				VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD);
> +
> +	/* Needs 2MB Hugepages */
> +	if (get_free_huge_2mb_pages() >= 1) {
> +		printf("Running private mem test with 2M pages\n");
> +		execute_vm_with_private_test_mem(
> +				VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD);
> +	} else
> +		printf("Skipping private mem test with 2M pages\n");
> +
> +	return 0;
> +}
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
