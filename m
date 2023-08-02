Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6023C76D83B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjHBTzR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjHBTzP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 15:55:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41322704
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 12:55:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so173111276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691006112; x=1691610912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsTv4l3aM1hxHagjQekhivcP8BzeguBOu+Z/J5EBK6c=;
        b=1Z3rm52lW1E1rKJETarUbcMZebSxTyOBuPRcpXU6Ehr1utRe3K/BD3K56DJyi+3b5a
         g/nq4vTlMjA7Pv0e1ir4I/PIPkjNptQqKjUnyyt3egX7Szt6ApLbfg7ghYy2P0hNdSUv
         p9kRQkUhyY1QtAw8mYU5Y31X+GOPGBoyV4qD24uR8oqhxIWYZTZXrPku4n6lf08vVaHY
         d4MBneP8M5ztzeFfqTjmuS+wVfilMjNAzut+4jUUJpwzrsKLhQJq9BcVfPAl6b80y2lP
         9XNV6Nm9Aq36QpnLxbahmvLAf9KBlANqr3PvdwkAGPwPkA+Sf8CQBzON2UTJwGzjzzn/
         cu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691006112; x=1691610912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsTv4l3aM1hxHagjQekhivcP8BzeguBOu+Z/J5EBK6c=;
        b=EgiKW6vIPGcVEYh0jA9R1JpVZA5FMUdBSl4RjffxYrFfhJZ77PGW1hM2rXnIuLoGFr
         eP4CAfSTaj1hlMvyWDOOreSdnk0Qpd85VB+BVf2RBvXtBdIVbZzQZwjuXDfkZ/XBIn7G
         eSHaMUFxjW8c4QYf1uZx4QTveV3KMvCvUVva/c2nRIrhUBpIW4Wu3U42e1XPnYVrJyBJ
         WeRVrqNmzvl92b44OQTFNr4kMRsNsbTe841UtaDZnxKMoCMhlaGKX9c4Wpy9C/2wdLjt
         6+tOQcfcqsIDH2fDCAdt1fKzD3cDRMqznr9g42p4F9zYA4BTbs51B10yi2p5CGK/z8Pr
         KPWA==
X-Gm-Message-State: ABy/qLYDgenH0YNka3qmxLEEUKwdx+1w+0q/rxfIpInBS1K1qS9Ig9n2
        UA/9Eq4WzLQwPJ+0rwsGu7epfo+uqIQ=
X-Google-Smtp-Source: APBJJlGaw2tbZ5PGtoXoBNzA2JGWKl/m0J34RtXjTcrzSkFb8b3iZqAWlBYDvywJxnNUJKFwarIY6gvO2Y0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1582:b0:d0a:353b:b93b with SMTP id
 k2-20020a056902158200b00d0a353bb93bmr136607ybu.3.1691006111814; Wed, 02 Aug
 2023 12:55:11 -0700 (PDT)
Date:   Wed, 2 Aug 2023 12:55:09 -0700
In-Reply-To: <20230712075910.22480-3-thuth@redhat.com>
Mime-Version: 1.0
References: <20230712075910.22480-1-thuth@redhat.com> <20230712075910.22480-3-thuth@redhat.com>
Message-ID: <ZMq0nYYDbOX1cOKN@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: x86: Use TAP interface in the
 sync_regs test
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
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

On Wed, Jul 12, 2023, Thomas Huth wrote:
> The sync_regs test currently does not have any output (unless one
> of the TEST_ASSERT statement fails), so it's hard to say for a user
> whether a certain new sub-test has been included in the binary or
> not. Let's make this a little bit more user-friendly and include
> some TAP output via the kselftest_harness.h interface.
> To be able to use the interface, we have to break up the huge main()
> function here in more fine grained parts - then we can use the
> TEST_F() macro to define the individual tests. Since these are run
> with a separate VM now, we have also to make sure to create the
> expected state at the beginning of each test, so some parts grow
> a little bit - which should be OK considering that the individual
> tests are more self-contained now.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../selftests/kvm/x86_64/sync_regs_test.c     | 113 +++++++++++++++---

FYI, there's an in-flight patch[*] to expand this test's coverage, and I plan on
grabbing that in some form before this one (sorry).  Let me know if there are
any tweaks that can be done to Michal's patch to make it easier to convert the
test to tap.

I'll also try to get Michal's patch into kvm-x86/next sooner than later so that
you can use that as the basic.

Oh, and no need to post "KVM: selftests: Rename the ASSERT_EQ macro" in the next
version, I'm planning on grabbing that one straightaway.

[*] https://lore.kernel.org/all/20230728001606.2275586-3-mhal@rbox.co

>  1 file changed, 98 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> index 2da89fdc2471a..e1359a4a07fea 100644
> --- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> @@ -16,6 +16,7 @@
>  #include <string.h>
>  #include <sys/ioctl.h>
>  
> +#include "kselftest_harness.h"
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> @@ -80,23 +81,24 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
>  #define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
>  #define INVALID_SYNC_FIELD 0x80000000
>  
> -int main(int argc, char *argv[])
> -{
> -	struct kvm_vcpu *vcpu;
> +FIXTURE(sync_regs_test) {
>  	struct kvm_vm *vm;
> -	struct kvm_run *run;
> -	struct kvm_regs regs;
> -	struct kvm_sregs sregs;
> -	struct kvm_vcpu_events events;
> -	int rv, cap;
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
> +}
>  
> -	run = vcpu->run;
> +TEST_F(sync_regs_test, read_invalid)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	int rv;
>  
>  	/* Request reading invalid register set from VCPU. */
>  	run->kvm_valid_regs = INVALID_SYNC_FIELD;
> @@ -112,6 +114,13 @@ int main(int argc, char *argv[])
>  		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
>  		    rv);
>  	run->kvm_valid_regs = 0;
> +}
> +
> +TEST_F(sync_regs_test, set_invalid)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	int rv;
>  
>  	/* Request setting invalid register set into VCPU. */
>  	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
> @@ -127,11 +136,22 @@ int main(int argc, char *argv[])
>  		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
>  		    rv);
>  	run->kvm_dirty_regs = 0;
> +}
> +
> +TEST_F(sync_regs_test, req_and_verify_all_valid)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	struct kvm_vcpu_events events;
> +	struct kvm_sregs sregs;
> +	struct kvm_regs regs;
> +	int rv;
>  
>  	/* Request and verify all valid register sets. */
>  	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>  	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

Just use vcpu_run() instead of _vcpu_run().  And please post that as a separate
patch, I think/hope it will make the conversion-to-tap patch smaller.

>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  
>  	vcpu_regs_get(vcpu, &regs);
> @@ -142,6 +162,22 @@ int main(int argc, char *argv[])
>  
>  	vcpu_events_get(vcpu, &events);
>  	compare_vcpu_events(&events, &run->s.regs.events);
> +}
> +
> +TEST_F(sync_regs_test, set_and_verify_various)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	struct kvm_vcpu_events events;
> +	struct kvm_sregs sregs;
> +	struct kvm_regs regs;
> +	int rv;
> +
> +	/* Run once to get register set */
> +	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> +	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

Same comment here.

> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  
>  	/* Set and verify various register values. */
>  	run->s.regs.regs.rbx = 0xBAD1DEA;
> @@ -151,6 +187,7 @@ int main(int argc, char *argv[])
>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>  	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
>  	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

And here.

>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  	TEST_ASSERT(run->s.regs.regs.rbx == 0xBAD1DEA + 1,
>  		    "rbx sync regs value incorrect 0x%llx.",
> @@ -167,6 +204,13 @@ int main(int argc, char *argv[])
>  
>  	vcpu_events_get(vcpu, &events);
>  	compare_vcpu_events(&events, &run->s.regs.events);
> +}
> +
> +TEST_F(sync_regs_test, clear_kvm_dirty_regs_bits)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	int rv;
>  
>  	/* Clear kvm_dirty_regs bits, verify new s.regs values are
>  	 * overwritten with existing guest values.
> @@ -175,10 +219,25 @@ int main(int argc, char *argv[])
>  	run->kvm_dirty_regs = 0;
>  	run->s.regs.regs.rbx = 0xDEADBEEF;
>  	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

Here too.

>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  	TEST_ASSERT(run->s.regs.regs.rbx != 0xDEADBEEF,
>  		    "rbx sync regs value incorrect 0x%llx.",
>  		    run->s.regs.regs.rbx);
> +}
> +
> +TEST_F(sync_regs_test, clear_kvm_valid_and_dirty_regs)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	struct kvm_regs regs;
> +	int rv;
> +
> +	/* Run once to get register set */
> +	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> +	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

At least you're consistent :-)

> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  
>  	/* Clear kvm_valid_regs bits and kvm_dirty_bits.
>  	 * Verify s.regs values are not overwritten with existing guest values
> @@ -187,9 +246,11 @@ int main(int argc, char *argv[])
>  	run->kvm_valid_regs = 0;
>  	run->kvm_dirty_regs = 0;
>  	run->s.regs.regs.rbx = 0xAAAA;
> +	vcpu_regs_get(vcpu, &regs);

Can you split this change to its own patch too?  I'm pretty sure that change
stands on its own, and slotting it in here made me do a double-take.

>  	regs.rbx = 0xBAC0;
>  	vcpu_regs_set(vcpu, &regs);
>  	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  	TEST_ASSERT(run->s.regs.regs.rbx == 0xAAAA,
>  		    "rbx sync regs value incorrect 0x%llx.",
> @@ -198,6 +259,20 @@ int main(int argc, char *argv[])
>  	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
>  		    "rbx guest value incorrect 0x%llx.",
>  		    regs.rbx);
> +}
> +
> +TEST_F(sync_regs_test, clear_kvm_valid_regs_bits)
> +{
> +	struct kvm_vcpu *vcpu = self->vcpu;
> +	struct kvm_run *run = vcpu->run;
> +	struct kvm_regs regs;
> +	int rv;
> +
> +	/* Run once to get register set */
> +	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> +	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

Once more, with feeling!

> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  
>  	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
>  	 * with existing guest values but that guest values are overwritten
> @@ -207,6 +282,7 @@ int main(int argc, char *argv[])
>  	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
>  	run->s.regs.regs.rbx = 0xBBBB;
>  	rv = _vcpu_run(vcpu);
> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);

Heh.

>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  	TEST_ASSERT(run->s.regs.regs.rbx == 0xBBBB,
>  		    "rbx sync regs value incorrect 0x%llx.",
> @@ -215,8 +291,15 @@ int main(int argc, char *argv[])
>  	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
>  		    "rbx guest value incorrect 0x%llx.",
>  		    regs.rbx);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int cap;
>  
> -	kvm_vm_free(vm);
> +	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
> +	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
> +	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
>  
> -	return 0;
> +	return test_harness_run(argc, argv);
>  }
> -- 
> 2.39.3
> 
