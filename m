Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193EF62058F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 02:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiKHBGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiKHBGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 20:06:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7223BD2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 17:06:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so12030102pji.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E01Oa1tuNVBV3Nw8IeSBu5E315kgqb9xSnaNRubhtgg=;
        b=P3TIRdyb7BbLNpWrF+7qZPPVQvEOPBCwj2deEn0tkWCiaQJJV0ml/7ZTEMhtf3svkN
         pVwNm6TUm3ib+KbixI0/HQUoSSCpM6eIlFr7SO5GFv084HqbkBPrH5NGPDpHMeeYwgc3
         NtA/XWv2IM0RI4cQ0oMl7E621WFD2I2TS7HwqE6852Kwbku3jupiSeq4E3TDkrIweP6W
         AoY3tf6m3V4t/9X3w3siJ/VsqHgYgbxVkXqcs9H4LJw7l/wVkO0SbmG/3IzuQBt2evIo
         /FhzXK/8XI1+DO5VwbeJuhamxQYs3U3zPtKY+K6vMOOwImedqy58r4qhb0ZvAHgiwVQd
         hibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E01Oa1tuNVBV3Nw8IeSBu5E315kgqb9xSnaNRubhtgg=;
        b=r+PLgs2fbOY6CoKAr5LEY88AXpzpDDdHqE1xCPAQnE9GmVCEv3eFkXdAPO7IiLNhUG
         +cijmtHf9g9eDlbrOmk29dfO5ZY0RU2etNuwhgBN2K8kKGpTXilPtcYKcP+P99Qov/32
         pTgJu2Ll7LX2G32wxpJ2+fZJ/SE9GEvAKHGcePgo2rI3laFS4ZIR3JWDeT9kAJRWZeAH
         iuPNnj5326Uv0mCRMBMvC/kQ9zt2UnUT633Cqqu/oAR5O7y1mf4MJZpgdusuzRnEFq3f
         3kdslVsgge4tdxsMSGm8Q2KJr57PC9vwYaDnj+3F0lMd2jrGoqnhEaRX5o9NiNbNZyK1
         rdQg==
X-Gm-Message-State: ACrzQf3BwhbsdPAmDXBLXXwQLP3aWtz4hJt94GHz+BgDi2omwrLSf6qV
        qCHU9xmSCAusAxyIvHUlWrpgzw==
X-Google-Smtp-Source: AMsMyM7IRPuB+hkYd3dePhxYZibHC9hQsKuKbv65LlU3FnAEpDoj2sVsCadhxJikgBUZvMve22Jt6g==
X-Received: by 2002:a17:902:b10d:b0:187:29fe:bda0 with SMTP id q13-20020a170902b10d00b0018729febda0mr41029538plr.16.1667869581719;
        Mon, 07 Nov 2022 17:06:21 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id b29-20020a631b5d000000b0047022e07035sm4719435pgm.47.2022.11.07.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:06:20 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:06:15 -0800
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Use TAP in some more KVM selftests
Message-ID: <Y2mrh7h1jrZSPU5l@google.com>
References: <20221004093131.40392-1-thuth@redhat.com>
 <Y0nOv6fqTe2NnPuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0nOv6fqTe2NnPuu@google.com>
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

On Fri, Oct 14, 2022 at 09:03:59PM +0000, Sean Christopherson wrote:
> On Tue, Oct 04, 2022, Thomas Huth wrote:
> > Many KVM selftests are completely silent. This has the disadvantage
> > for the users that they do not know what's going on here. For example,
> > some time ago, a tester asked me how to know whether a certain new
> > sub-test has been added to one of the s390x test binaries or not (which
> > he didn't compile on his own), which is hard to judge when there is no
> > output. So I finally went ahead and implemented TAP output in the
> > s390x-specific tests some months ago.
> > 
> > Now I wonder whether that could be a good strategy for the x86 and
> > generic tests, too?
> 
> Taking Andrew's thoughts a step further, I'm in favor of adding TAP output, but
> only if we implement it in such a way that it reduces the burden on writing new
> tests.  I _really_ like that sync_regs_test's subtests are split into consumable
> chunks, but I worry that the amount of boilerplate needed will deter test writes
> and increase the maintenance cost.
> 
> And my experience with KVM-unit-tests is that letting test writers specify strings
> for test names is a bad idea, e.g. using an arbitrary string creates a disconnect
> between what the user sees and what code is running, and makes it unnecessarily
> difficult to connect a failure back to code.  And if we ever support running
> specific testcases by name (I'm still not sure this is a net positive), arbitrary
> strings get really annoying because inevitably an arbitrary string will contain
> characters that need to be escaped in the shell.
> 
> Adding a macro or three to let tests define and run testscases with minimal effort
> would more or less eliminate the boilerplate.  And in theory providing semi-rigid
> macros would help force simple tests to conform to standard patterns, which should
> reduce the cost of someone new understanding the test, and would likely let us do
> more automagic things in the future.
> 
> E.g. something like this in the test:
> 
> 	KVM_RUN_TESTCASES(vcpu,
> 		test_clear_kvm_dirty_regs_bits,
> 		test_set_invalid,
> 		test_req_and_verify_all_valid_regs,
> 		test_set_and_verify_various_reg_values,
> 		test_clear_kvm_dirty_regs_bits,
> 	);

There is an existing framework in
tools/testing/selftests/kselftest_harness.h that provides macros for
setting up and running tests cases. I converted sync_regs_test to use it
below as an example [1].

The harness runs each subtest in a child process, so sharing a VM/VCPU
across test cases is not possible. This means setting up and tearing
down a VM for every test case, but the harness makes this pretty easy
with FIXTURE_{SETUP,TEARDOWN}(). With this harness, we can keep using
TEST_ASSERT() as-is, and still run all test cases even if one fails.
Plus no need for the hard-coded ksft_*() calls in main().

[1]

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 9b6db0b0b13e..11cf25d3e4a3 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -20,6 +20,8 @@
 #include "kvm_util.h"
 #include "processor.h"
 
+#include "../kselftest_harness.h"
+
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
 struct ucall uc_none = {
@@ -80,26 +82,23 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 #define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
 #define INVALID_SYNC_FIELD 0x80000000
 
-int main(int argc, char *argv[])
-{
-	struct kvm_vcpu *vcpu;
+FIXTURE(sync_regs_test) {
 	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_regs regs;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu_events events;
-	int rv, cap;
-
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
+	struct kvm_vcpu *vcpu;
+};
 
-	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
-	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
+FIXTURE_SETUP(sync_regs_test) {
+	self->vm = vm_create_with_one_vcpu(&self->vcpu, guest_code);
+}
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+FIXTURE_TEARDOWN(sync_regs_test) {
+	kvm_vm_free(self->vm);
+}
 
-	run = vcpu->run;
+TEST_F(sync_regs_test, read_invalid) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	int rv;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
@@ -115,6 +114,12 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
+}
+
+TEST_F(sync_regs_test, set_invalid) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	int rv;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
@@ -130,6 +135,15 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
+}
+
+TEST_F(sync_regs_test, req_and_verify_all_valid) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
@@ -148,6 +162,22 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+TEST_F(sync_regs_test, set_and_verify_various) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
+
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
 
 	/* Set and verify various register values. */
 	run->s.regs.regs.rbx = 0xBAD1DEA;
@@ -176,6 +206,13 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+TEST_F(sync_regs_test, clear_kvm_valid_and_dirty) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_regs regs;
+	int rv;
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
@@ -199,6 +236,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
+	vcpu_regs_get(vcpu, &regs);
 	regs.rbx = 0xBAC0;
 	vcpu_regs_set(vcpu, &regs);
 	rv = _vcpu_run(vcpu);
@@ -213,6 +251,20 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+TEST_F(sync_regs_test, clear_kvm_valid_regs) {
+	struct kvm_run *run = self->vcpu->run;
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_regs regs;
+	int rv;
+
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
 
 	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
 	 * with existing guest values but that guest values are overwritten
@@ -233,8 +285,15 @@ int main(int argc, char *argv[])
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
