Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FE457C06A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 01:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGTXDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 19:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiGTXDn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 19:03:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743A550AA
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 16:03:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 23so17775351pgc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXDHjlYv2P+rZw8dJnZ/BzSjeOwzCCjrzMhE7/OThFw=;
        b=rYbMcMN4GxRngMr73pFMq9w2cLruGGCZMOxtyWcDR6IFL1b1clSZp3YeIADkyiP2at
         HGYOMPRu/ypbUFHoUxPIxVQhbPYX9FsH6i1y58BlKeOE6Se2gR5Vi95X0uvgXKjk1Idq
         sZLZw5SmrNCC0gVhye5Rs/nUzixZj+/34reu5GcXeTKeQTqaHXo2xemw80eUfQ4VXeS0
         7+FBfmaNR3u9MAolZZwxbANDg7VHxfx3o28hWX1vcMbnoJXyTTupiVp7aQHiyBrhlWYc
         YZtvqhH7adS1zIk4EvP0Ope09OqWV/PRNcEpboXNThw+lW0ihreSiHptTxFtGg4q+0Pe
         uVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXDHjlYv2P+rZw8dJnZ/BzSjeOwzCCjrzMhE7/OThFw=;
        b=CTfohC6VzLTMylArBuXFnXD2tGJPbCWue3lM4fp4eKU13wrqWGfbeiHDdyCiAjz6fD
         paQhDVfSeskelvXeiaKEzJJJe5tbeAWcVpZxBCBomxz0Y91IVRYrA1tfbmtVYQGdtUxx
         uKnebDACBsUJqoFtBRWO318aRb/ntYSpgQdGhMm1ECpbLRbEdIiac4nCwp7whKtahFuY
         RxFg7d0dWejnFfMszfQe1k7AR6Xj0FD7A1j6bMeTyeT5Vn/jfVfG0x+rc4dtMLrcusel
         1KlAY6+G0WzbuNLih9d+6ePAstuW7yPcpWfgnIQWcITaZfVKohIx3QI9euMjJ+dT1wxF
         NMQw==
X-Gm-Message-State: AJIora/P2QaMZbKW2vOH5B2lgwk/3o1dSM3zL3xERIdkk6SPI94dCyfq
        DsQrhZJ5r2OnvssZsGPN+EuJ5g==
X-Google-Smtp-Source: AGRyM1vzDre0jSqvUh3PVIENhxd4bnCR9CL4k62Zn7ugGSHVme6qlUccYjFAr+3hBU9AL4iQwiI6cg==
X-Received: by 2002:a63:307:0:b0:412:9a58:e187 with SMTP id 7-20020a630307000000b004129a58e187mr35899805pgd.70.1658358220850;
        Wed, 20 Jul 2022 16:03:40 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902714a00b0016c3f7b5b48sm80806plm.256.2022.07.20.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:03:39 -0700 (PDT)
Date:   Wed, 20 Jul 2022 23:03:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shauh@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com
Subject: Re: [RFC V2 PATCH 2/8] selftests: kvm: Add a basic selftest to test
 private memory
Message-ID: <YtiJx11AZHslcGnN@google.com>
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511000811.384766-3-vannapurve@google.com>
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

On Wed, May 11, 2022, Vishal Annapurve wrote:
> Add KVM selftest to access private memory privately
> from the guest to test that memory updates from guest
> and userspace vmm don't affect each other.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  tools/testing/selftests/kvm/priv_memfd_test.c | 283 ++++++++++++++++++

If this name stays around in any form, just spell out "private".  The file system
can handle three more characters.

>  2 files changed, 284 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/priv_memfd_test.c
> +/* Guest code in selftests is loaded to guest memory using kvm_vm_elf_load

Kernel style (except for net/ apparently?) for multi-line comments is to have a
"blank" first line:

	/*
	 * blahal;sdkfjas;flkjasd;flkj;aslkfjdsa;lkfjsa;lkfjsa;dlkfjas;dlkfj
	 * as;dflkjasdf;lkasjdf;lkasdjf;lkasdjf;lkjsad;flkjasd;flkjas;dflkj
	 */

And if you haven't already read through Documentation/process/coding-style.rst,
though I thikn this and indentation are the only glaring issues.

> + * which doesn't handle global offset table updates. Calling standard libc
> + * functions would normally result in referring to the global offset table.
> + * Adding O1 here seems to prohibit compiler from replacing the memory
> + * operations with standard libc functions such as memset.
> + */

Eww.  We should either fix kvm_vm_elf_load() or override the problematic libc
variants.  Playing games with per-function attributes is not maintainable.

> +static bool __attribute__((optimize("O1"))) do_mem_op(enum mem_op op,
> +		void *mem, uint64_t pat, uint32_t size)

Oof.  Don't be so agressive in shortening names, _especially_ when there's no
established/universal abbreviation.  It took me forever to figure out that "pat"
is "pattern".  And for x86, "pat" is especially confusing because it already
a very well-established name that just so happens to be relevant to memory types,
just a different kind of a memory type...

> +{
> +	uint64_t *buf = (uint64_t *)mem;
> +	uint32_t chunk_size = sizeof(pat);
> +	uint64_t mem_addr = (uint64_t)mem;
> +
> +	if (((mem_addr % chunk_size) != 0) || ((size % chunk_size) != 0))

All the patterns are a repeating byte, why restrict this to 8-byte chunks?  Then
this confusing assert-but-not-an-assert goes away.

> +		return false;
> +
> +	for (uint32_t i = 0; i < (size / chunk_size); i++) {
> +		if (op == SET_PAT)
> +			buf[i] = pat;
> +		if (op == VERIFY_PAT) {
> +			if (buf[i] != pat)
> +				return false;

If overriding memset() and memcmp() doesn't work for whatever reason, add proper
helpers instead of a do_stuff() wrapper. 

> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/* Test to verify guest private accesses on private memory with following steps:
> + * 1) Upon entry, guest signals VMM that it has started.
> + * 2) VMM populates the shared memory with known pattern and continues guest
> + *    execution.
> + * 3) Guest writes a different pattern on the private memory and signals VMM
> + *      that it has updated private memory.
> + * 4) VMM verifies its shared memory contents to be same as the data populated
> + *      in step 2 and continues guest execution.
> + * 5) Guest verifies its private memory contents to be same as the data
> + *      populated in step 3 and marks the end of the guest execution.
> + */
> +#define PMPAT_ID				0
> +#define PMPAT_DESC				"PrivateMemoryPrivateAccessTest"
> +
> +/* Guest code execution stages for private mem access test */
> +#define PMPAT_GUEST_STARTED			0ULL
> +#define PMPAT_GUEST_PRIV_MEM_UPDATED		1ULL
> +
> +static bool pmpat_handle_vm_stage(struct kvm_vm *vm,
> +			void *test_info,
> +			uint64_t stage)


Align parameters, both in prototypes and in invocations.  And don't wrap unnecessarily.

static bool pmpat_handle_vm_stage(struct kvm_vm *vm, void *test_info,
				  uint64_t stage)


Or even let that poke out (probably not in this case, but do keep in mind that the
80 char "limit" is a soft limit that can be broken if doing so yields more readable
code).

static bool pmpat_handle_vm_stage(struct kvm_vm *vm, void *test_info, uint64_t stage)

> +{
> +	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
> +
> +	switch (stage) {
> +	case PMPAT_GUEST_STARTED: {
> +		/* Initialize the contents of shared memory */
> +		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
> +			"Shared memory update failure");

Align indentation (here and many other places).

> +		VM_STAGE_PROCESSED(PMPAT_GUEST_STARTED);
> +		break;
> +	}
> +	case PMPAT_GUEST_PRIV_MEM_UPDATED: {
> +		/* verify host updated data is still intact */
> +		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
> +			TEST_MEM_DATA_PAT1, TEST_MEM_SIZE),
> +			"Shared memory view mismatch");
> +		VM_STAGE_PROCESSED(PMPAT_GUEST_PRIV_MEM_UPDATED);
> +		break;
> +	}
> +	default:
> +		printf("Unhandled VM stage %ld\n", stage);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void pmpat_guest_code(void)
> +{
> +	void *priv_mem = (void *)TEST_MEM_GPA;
> +	int ret;
> +
> +	GUEST_SYNC(PMPAT_GUEST_STARTED);
> +
> +	/* Mark the GPA range to be treated as always accessed privately */
> +	ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
> +		TEST_MEM_SIZE >> MIN_PAGE_SHIFT,
> +		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
> +	GUEST_ASSERT_1(ret == 0, ret);

"!ret" instead of "ret == 0"

> +
> +	GUEST_ASSERT(do_mem_op(SET_PAT, priv_mem, TEST_MEM_DATA_PAT2,
> +			TEST_MEM_SIZE));
> +	GUEST_SYNC(PMPAT_GUEST_PRIV_MEM_UPDATED);
> +
> +	GUEST_ASSERT(do_mem_op(VERIFY_PAT, priv_mem,
> +			TEST_MEM_DATA_PAT2, TEST_MEM_SIZE));
> +
> +	GUEST_DONE();
> +}
> +
> +static struct test_run_helper priv_memfd_testsuite[] = {
> +	[PMPAT_ID] = {
> +		.test_desc = PMPAT_DESC,
> +		.vmst_handler = pmpat_handle_vm_stage,
> +		.guest_fn = pmpat_guest_code,
> +	},
> +};

...

> +/* Do private access to the guest's private memory */
> +static void setup_and_execute_test(uint32_t test_id)

This helper appears to be the bulk of the shared code between tests.  This can
and should be a helper to create a VM with private memory.  Not sure what to call
such a helper, maybe vm_create_with_private_memory()?  A little verbose, but
literal isn't always bad.

> +{
> +	struct kvm_vm *vm;
> +	int priv_memfd;
> +	int ret;
> +	void *shared_mem;
> +	struct kvm_enable_cap cap;
> +
> +	vm = vm_create_default(VCPU_ID, 0,
> +				priv_memfd_testsuite[test_id].guest_fn);
> +
> +	/* Allocate shared memory */
> +	shared_mem = mmap(NULL, TEST_MEM_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
> +	TEST_ASSERT(shared_mem != MAP_FAILED, "Failed to mmap() host");
> +
> +	/* Allocate private memory */
> +	priv_memfd = memfd_create("vm_private_mem", MFD_INACCESSIBLE);
> +	TEST_ASSERT(priv_memfd != -1, "Failed to create priv_memfd");
> +	ret = fallocate(priv_memfd, 0, 0, TEST_MEM_SIZE);
> +	TEST_ASSERT(ret != -1, "fallocate failed");
> +
> +	priv_memory_region_add(vm, shared_mem,
> +				TEST_MEM_SLOT, TEST_MEM_SIZE,
> +				TEST_MEM_GPA, priv_memfd, 0);
> +
> +	pr_info("Mapping test memory pages 0x%x page_size 0x%x\n",
> +					TEST_MEM_SIZE/vm_get_page_size(vm),
> +					vm_get_page_size(vm));
> +	virt_map(vm, TEST_MEM_GPA, TEST_MEM_GPA,
> +					(TEST_MEM_SIZE/vm_get_page_size(vm)));
> +
> +	/* Enable exit on KVM_HC_MAP_GPA_RANGE */
> +	pr_info("Enabling exit on map_gpa_range hypercall\n");
> +	ret = ioctl(vm_get_fd(vm), KVM_CHECK_EXTENSION, KVM_CAP_EXIT_HYPERCALL);
> +	TEST_ASSERT(ret & (1 << KVM_HC_MAP_GPA_RANGE),
> +				"VM exit on MAP_GPA_RANGE HC not supported");

Impressively bizarre indentation :-)

> +	cap.cap = KVM_CAP_EXIT_HYPERCALL;
> +	cap.flags = 0;
> +	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
> +	ret = ioctl(vm_get_fd(vm), KVM_ENABLE_CAP, &cap);
> +	TEST_ASSERT(ret == 0,
> +		"Failed to enable exit on MAP_GPA_RANGE hypercall\n");
> +
> +	priv_memfd_testsuite[test_id].shared_mem = shared_mem;
> +	priv_memfd_testsuite[test_id].priv_memfd = priv_memfd;
> +	vcpu_work(vm, test_id);
> +
> +	munmap(shared_mem, TEST_MEM_SIZE);
> +	priv_memfd_testsuite[test_id].shared_mem = NULL;
> +	close(priv_memfd);
> +	priv_memfd_testsuite[test_id].priv_memfd = -1;
> +	kvm_vm_free(vm);
> +}
