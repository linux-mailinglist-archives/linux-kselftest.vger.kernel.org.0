Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB6662687
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 14:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjAINJ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 08:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjAINJD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 08:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33222604
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673269572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqnAszpgy0KJ191Ho69gF9UoikTfczETJLDKhGuW5zw=;
        b=DeNF5kJCbmCeHbtc9tHMng7m9JcG8TezVGo8cckAwCWQSI0vZBsfkBsED+tSB7eNAs/FOy
        6vcC7PyNr8y4S8z6c7AC457y3/4pd5SbgK3Tsp0EMHw4tgoXBZ38anWPXLr2qnIfiUAmIV
        wQgaYU2j0ANLMWrjOdBooiLz3pekW2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-yTRL9aU4O3yaIXCTW92jXQ-1; Mon, 09 Jan 2023 08:06:11 -0500
X-MC-Unique: yTRL9aU4O3yaIXCTW92jXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0144E183B3CA;
        Mon,  9 Jan 2023 13:06:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91D53175AD;
        Mon,  9 Jan 2023 13:06:09 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/2] KVM: selftests: APIC_ID must be correctly updated when disabling x2apic
Date:   Mon,  9 Jan 2023 08:06:05 -0500
Message-Id: <20230109130605.2013555-3-eesposit@redhat.com>
In-Reply-To: <20230109130605.2013555-1-eesposit@redhat.com>
References: <20230109130605.2013555-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sure the APIC_ID is correctly shifted in the right bit positions
when disabling x2APIC via KVM_SET_MSRS.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index d7d37dae3eeb..6ebda7162a25 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -132,6 +132,62 @@ static void test_icr(struct xapic_vcpu *x)
 	__test_icr(x, -1ull & ~APIC_DM_FIXED_MASK);
 }
 
+static void _test_lapic_id(struct kvm_vcpu *vcpu, bool x2apic_enabled,
+			   int expected_id)
+{
+	struct kvm_lapic_state xapic;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
+	if (x2apic_enabled)
+		ASSERT_EQ(xapic.regs[APIC_ID], expected_id);
+	else
+		ASSERT_EQ(xapic.regs[0x23], expected_id);
+
+}
+
+static void test_apic_id(struct kvm_vcpu *vcpu, int id)
+{
+	int ret;
+	struct {
+		struct kvm_msrs info;
+		struct kvm_msr_entry entries[1];
+	} msr_data = {
+		.info.nmsrs = 1,
+		.entries[0].index = MSR_IA32_APICBASE,
+	};
+
+	/* vcpu is initialized with xAPIC enabled */
+	ret = __vcpu_ioctl(vcpu, KVM_GET_MSRS, &msr_data.info);
+	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));
+	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
+		  MSR_IA32_APICBASE_ENABLE);
+	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, 0);
+	_test_lapic_id(vcpu, false, id);
+
+	/* enable x2APIC */
+	msr_data.entries[0].data |= X2APIC_ENABLE;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_MSRS, &msr_data.info);
+	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));
+	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
+		  MSR_IA32_APICBASE_ENABLE);
+	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, X2APIC_ENABLE);
+	_test_lapic_id(vcpu, true, id);
+
+	/*
+	 * Check that disabling x2APIC correctly updates the APIC ID to the
+	 * xAPIC format.
+	 */
+	msr_data.entries[0].data ^= X2APIC_ENABLE;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_MSRS, &msr_data.info);
+	TEST_ASSERT(ret == 1, __KVM_IOCTL_ERROR("__vcpu_ioctl", ret));
+	ASSERT_EQ(msr_data.entries[0].data & MSR_IA32_APICBASE_ENABLE,
+		  MSR_IA32_APICBASE_ENABLE);
+	ASSERT_EQ(msr_data.entries[0].data & X2APIC_ENABLE, 0);
+	_test_lapic_id(vcpu, false, id);
+}
+
+#define NCPUS 3
+
 int main(int argc, char *argv[])
 {
 	struct xapic_vcpu x = {
@@ -139,6 +195,14 @@ int main(int argc, char *argv[])
 		.is_x2apic = true,
 	};
 	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpus[NCPUS] = { 0 };
+	int i;
+
+	vm = vm_create_with_vcpus(NCPUS, NULL, vcpus);
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS);
+	for (i = 0; i < NCPUS; i++)
+		test_apic_id(vcpus[i], i);
+	kvm_vm_free(vm);
 
 	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
 	test_icr(&x);
-- 
2.31.1

