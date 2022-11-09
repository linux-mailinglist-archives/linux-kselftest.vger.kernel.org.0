Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F162335E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKITWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKITWx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 14:22:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B8DE80
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 11:22:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so17086806pgc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLv3OyQL52LGPRwGlac/buhpBCkg1Ieh2JvpXhiIZC8=;
        b=tM1B501ybW4koBIxpoOtpMN1Ogpd3wLYBHlm1wJpE92/ftk3HZBkSc/coWGYkzUA7M
         JXomermPlfUprWO9+cLMB/+2UG8tc+ST7F8FONV6ctYz3Tk+mXqzJ9pYkHajH4bcyYj7
         w9wJhFXDquZbVZY9/TQs1WC3Qpw97DxBr0qY0S7y98jf1a10Di51uMd8rmx6uKnrh+Yy
         LOkzU47i4eNGq6MX+W4Ph9xsK6fkgliDYb4/VpKd4spMAoKrklQ+ocs5CFbMJTuJxi5R
         e1WH6bsHkRfldtCLzSBPUuLMMcLQXIiXNvnji3oZvdukrec+iZqkhPC3MN9SncQKoZ1l
         Xmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLv3OyQL52LGPRwGlac/buhpBCkg1Ieh2JvpXhiIZC8=;
        b=zEFWpIL1fsmWEg369UZu8kN8qbJu+MciFKBx/i5CgT9JaeYST3nA8FFFjAoT/DC3Ap
         dfqK2olEP3vNb8VH9BCIHwDurDZWjxWqza1Fke9GeLashbOjiw2vNQNbuUPclM6HFd6N
         WS+IQ7BrwAy36czhq5mtraFXkrQX4nyQoArl5XtHMtoQbkImrDeZ73/E40n0IQPXNaKx
         QjR3ZCMUl5kD1jYUxqzdFBEHjZwS08m4Mm1d0nEJ4qf5V67ELwj2S4jIdx/hlInN+vby
         vnxiMu2xAqYMtTgPU3iVXa9oSDe+mliPEeyoHTd2YUu28PY1fIiD3yMRTyGHKM7qQPL0
         2iYA==
X-Gm-Message-State: ACrzQf3ERB/wBrlIVVL29+YwH6emK7IJHPN4DB+QnycDQTIFBcuPj+rX
        AbPIBpIhI25WVpgQsHw489h9sw==
X-Google-Smtp-Source: AMsMyM4E66eh2tWqdAh/uCGl2GPERNL6j9lZq6UYULFy0cu0Is9RaMEnBN7V3IyrhrqDOnGybQ5YaQ==
X-Received: by 2002:a65:6404:0:b0:46f:a711:c481 with SMTP id a4-20020a656404000000b0046fa711c481mr47804596pgv.262.1668021771130;
        Wed, 09 Nov 2022 11:22:51 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u64-20020a626043000000b0056d2317455bsm8623362pfb.7.2022.11.09.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:22:50 -0800 (PST)
Date:   Wed, 9 Nov 2022 19:22:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Use TAP in some more KVM selftests
Message-ID: <Y2v+B3xxYKJSM/fH@google.com>
References: <20221004093131.40392-1-thuth@redhat.com>
 <Y0nOv6fqTe2NnPuu@google.com>
 <Y2mrh7h1jrZSPU5l@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2mrh7h1jrZSPU5l@google.com>
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

On Mon, Nov 07, 2022, David Matlack wrote:
> On Fri, Oct 14, 2022 at 09:03:59PM +0000, Sean Christopherson wrote:
> > On Tue, Oct 04, 2022, Thomas Huth wrote:
> > Adding a macro or three to let tests define and run testscases with minimal effort
> > would more or less eliminate the boilerplate.  And in theory providing semi-rigid
> > macros would help force simple tests to conform to standard patterns, which should
> > reduce the cost of someone new understanding the test, and would likely let us do
> > more automagic things in the future.
> > 
> > E.g. something like this in the test:
> > 
> > 	KVM_RUN_TESTCASES(vcpu,
> > 		test_clear_kvm_dirty_regs_bits,
> > 		test_set_invalid,
> > 		test_req_and_verify_all_valid_regs,
> > 		test_set_and_verify_various_reg_values,
> > 		test_clear_kvm_dirty_regs_bits,
> > 	);
> 
> There is an existing framework in
> tools/testing/selftests/kselftest_harness.h that provides macros for
> setting up and running tests cases. I converted sync_regs_test to use it
> below as an example [1].

Looks awesome!  Some thoughts to cut down on boilerplate below.  We'll also need
to deal with the ASSERT_EQ conflict.  Easiest thing there is to rename KVM's
version to TEST_ASSERT_EQ(), which IMO is an improvement irrespective of this
conversion.

> The harness runs each subtest in a child process, so sharing a VM/VCPU
> across test cases is not possible. This means setting up and tearing
> down a VM for every test case, 

This is a feature, not a bug.  My single biggest complaint about KVM-unit-tests
is the lack of isolation between sub-tests.  E.g. there have been far too many
bugs where sub-tests fail if run on their own due to sub-tests relying on setup
being done elsewhere.

> but the harness makes this pretty easy with FIXTURE_{SETUP,TEARDOWN}(). With
> this harness, we can keep using TEST_ASSERT() as-is, and still run all test
> cases even if one fails.  Plus no need for the hard-coded ksft_*() calls in
> main().
> +FIXTURE(sync_regs_test) {
>  	struct kvm_vm *vm;

A dedicated "vm" field isn't necessary, it's available in the vcpu.

> +	struct kvm_vcpu *vcpu;
> +};
>  
> -	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
> -	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
> -	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
> +FIXTURE_SETUP(sync_regs_test) {
> +	self->vm = vm_create_with_one_vcpu(&self->vcpu, guest_code);
> +}
>  
> -	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +FIXTURE_TEARDOWN(sync_regs_test) {
> +	kvm_vm_free(self->vm);

From above, this would be:

	kvm_vm_free(self->vcpu->vm);

> +}
>  
> -	run = vcpu->run;
> +TEST_F(sync_regs_test, read_invalid) {

Regardless of what other selftests do, IMO we should dress these up to look like
the functions they are, i.e. put the curly brace on its own line.

> +	struct kvm_run *run = self->vcpu->run;

I don't love the @self boilerplate, and the setup+teardown will be identical for
the vast majority of simple tests.  There will also be tests that want to run
different guest code.

What if we add our own wrappers (because one can never have enough macros) to
handle most of the boilerplate?  Sample conversion below (the wrapper macros would
obviously go in a common header).  And then to support per-testcase guest code, we
could add vcpu_arch_set_guest_code() and another wrapper, e.g.

#define KVM_ONE_VCPU_TEST_EX(suite, test, guest_code)				\
static void __suite##_##test(struct kvm_vcpu *vcpu);				\
										\
TEST_F(suite, test)								\
{										\
	vcpu_arch_set_guest_code(guest_code);					\
	__suite##_##test(self->vcpu);						\
}										\
static void __suite##_##test(struct kvm_vcpu *vcpu)


Alternatives to "suite" would be bundle, crate, cluster, etc...

---
 .../selftests/kvm/x86_64/sync_regs_test.c     | 119 ++++++++++++++----
 1 file changed, 93 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 9b6db0b0b13e..b805170980bb 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -20,6 +20,9 @@
 #include "kvm_util.h"
 #include "processor.h"
 
+#undef ASSERT_EQ
+#include "../kselftest_harness.h"
+
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
 struct ucall uc_none = {
@@ -80,26 +83,34 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 #define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
 #define INVALID_SYNC_FIELD 0x80000000
 
-int main(int argc, char *argv[])
+#define KVM_ONE_VCPU_TEST_SUITE(name, guest_code)				\
+	FIXTURE(name) {								\
+		struct kvm_vcpu *vcpu;						\
+	};									\
+										\
+	FIXTURE_SETUP(name) {							\
+		(void)vm_create_with_one_vcpu(&self->vcpu, guest_code);		\
+	}									\
+										\
+	FIXTURE_TEARDOWN(name) {						\
+		kvm_vm_free(self->vcpu->vm);					\
+	}
+
+#define KVM_ONE_VCPU_TEST(suite, test)						\
+static void __suite##_##test(struct kvm_vcpu *vcpu);				\
+										\
+TEST_F(suite, test)								\
+{										\
+	__suite##_##test(self->vcpu);						\
+}										\
+static void __suite##_##test(struct kvm_vcpu *vcpu)
+
+KVM_ONE_VCPU_TEST_SUITE(sync_regs_test, guest_code);
+
+KVM_ONE_VCPU_TEST(sync_regs_test, read_invalid)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_regs regs;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu_events events;
-	int rv, cap;
-
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
-	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
-	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-
-	run = vcpu->run;
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
@@ -115,6 +126,12 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, set_invalid)
+{
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
@@ -130,11 +147,19 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
-	rv = _vcpu_run(vcpu);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -148,6 +173,21 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, set_and_verify_various)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
 
 	/* Set and verify various register values. */
 	run->s.regs.regs.rbx = 0xBAD1DEA;
@@ -156,7 +196,7 @@ int main(int argc, char *argv[])
 
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
-	rv = _vcpu_run(vcpu);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -176,6 +216,12 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_and_dirty)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
@@ -183,7 +229,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xDEADBEEF;
-	rv = _vcpu_run(vcpu);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -199,9 +245,10 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
+	vcpu_regs_get(vcpu, &regs);
 	regs.rbx = 0xBAC0;
 	vcpu_regs_set(vcpu, &regs);
-	rv = _vcpu_run(vcpu);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -213,6 +260,19 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_regs)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
 
 	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
 	 * with existing guest values but that guest values are overwritten
@@ -221,7 +281,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
 	run->s.regs.regs.rbx = 0xBBBB;
-	rv = _vcpu_run(vcpu);
+	vcpu_run(vcpu);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
 		    run->exit_reason,
@@ -233,8 +293,15 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+int main(int argc, char **argv)
+{
+	int cap;
 
-	kvm_vm_free(vm);
+	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
+	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
+	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
 
-	return 0;
+	return test_harness_run(argc, argv);
 }

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 

