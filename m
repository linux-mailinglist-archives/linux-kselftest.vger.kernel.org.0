Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74D2CDC21
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501959AbgLCRNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 12:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731525AbgLCRNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 12:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd+lJPFWy0m+3K/46pw2A3DNxUcmHii9mZMdRl39SGs=;
        b=bBFU6PULQjuNJRlMMmpSD84lbvrCk4t2JW1k678BxsxHPp78VCha/a3N+K86lYTM+5jBYj
        3wo5quafbMikl2umtH8J8HduHF4hEVbuJlnWli5gKjBXWb19BXrObBo8Mkze4TukwS0ft9
        R5xczATcYVSV3XxeyJKWI8iqL5oQTRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-P_LlYtaeNaCLjF2S9EoQQw-1; Thu, 03 Dec 2020 12:12:12 -0500
X-MC-Unique: P_LlYtaeNaCLjF2S9EoQQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740CA1926DBD;
        Thu,  3 Dec 2020 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895EB60854;
        Thu,  3 Dec 2020 17:11:42 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v2 3/3] kvm/selftests: update tsc_msrs_test to cover KVM_X86_QUIRK_TSC_HOST_ACCESS
Date:   Thu,  3 Dec 2020 19:11:18 +0200
Message-Id: <20201203171118.372391-4-mlevitsk@redhat.com>
In-Reply-To: <20201203171118.372391-1-mlevitsk@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run the test once with quirk enabled and once disabled,
and adjust the expected values accordingly.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/x86_64/tsc_msrs_test.c      | 79 ++++++++++++++++---
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index e357d8e222d47..3900c543a7ee1 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -79,8 +79,6 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 {
 	struct ucall uc;
 
-	vcpu_args_set(vm, vcpuid, 1, vcpuid);
-
 	vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
 
 	switch (get_ucall(vm, vcpuid, &uc)) {
@@ -101,7 +99,7 @@ static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
 	}
 }
 
-int main(void)
+void run_test(bool quirk_disabled)
 {
 	struct kvm_vm *vm;
 	uint64_t val;
@@ -109,6 +107,14 @@ int main(void)
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 
 	val = 0;
+	if (quirk_disabled) {
+		struct kvm_enable_cap cap = {
+			.cap = KVM_CAP_DISABLE_QUIRKS,
+			.args[0] = KVM_X86_QUIRK_TSC_HOST_ACCESS,
+		};
+		vm_enable_cap(vm, &cap);
+	}
+
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
@@ -124,20 +130,67 @@ int main(void)
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
-	/*
-	 * Host: writes to MSR_IA32_TSC set the host-side offset
-	 * and therefore do not change MSR_IA32_TSC_ADJUST.
-	 */
-	vcpu_set_msr(vm, 0, MSR_IA32_TSC, HOST_ADJUST + val);
+	if (quirk_disabled) {
+		struct kvm_tsc_state state = {
+			.tsc = HOST_ADJUST + val,
+			.flags = 0
+		};
+		vcpu_ioctl(vm, VCPU_ID, KVM_SET_TSC_STATE, &state);
+	} else {
+		/*
+		 * Host: writes to MSR_IA32_TSC set the host-side offset
+		 * and therefore do not change MSR_IA32_TSC_ADJUST
+		 */
+		vcpu_set_msr(vm, 0, MSR_IA32_TSC, HOST_ADJUST + val);
+	}
+
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+
+	if (quirk_disabled) {
+		/*
+		 * Host: writes to MSR_IA32_TSC work like in the guest
+		 * when quirk is disabled
+		 */
+		vcpu_set_msr(vm, 0, MSR_IA32_TSC, val);
+		ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
+		ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
+
+		/* Restore the value */
+		vcpu_set_msr(vm, 0, MSR_IA32_TSC, HOST_ADJUST + val);
+		ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	}
+
 	run_vcpu(vm, VCPU_ID, 3);
 
-	/* Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC.  */
+	/*
+	 * Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC,
+	 * (unless the quirk is disabled)
+	 */
 	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, UNITY * 123456);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
+	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC),
+		  quirk_disabled ? UNITY * 123456 + HOST_ADJUST : HOST_ADJUST + val);
 	ASSERT_EQ(vcpu_get_msr(vm, 0, MSR_IA32_TSC_ADJUST), UNITY * 123456);
 
+	if (quirk_disabled) {
+		/*
+		 * Host: writes via KVM_SET_TSC_STATE
+		 * to MSR_IA32_TSC and MSR_IA32_TSC_ADJUST can be done
+		 * independently
+		 */
+		struct kvm_tsc_state state = {
+			.tsc = UNITY * 42,
+			.tsc_adjust = UNITY * 42 - HOST_ADJUST,
+			.flags = KVM_TSC_STATE_TSC_ADJUST_VALID
+		};
+
+		vcpu_ioctl(vm, VCPU_ID, KVM_SET_TSC_STATE, &state);
+
+		ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), UNITY * 42);
+		ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST),
+			  UNITY * 42 - HOST_ADJUST);
+	}
+
 	/* Restore previous value.  */
 	vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, val);
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
@@ -162,6 +215,12 @@ int main(void)
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
 
 	kvm_vm_free(vm);
+}
+
 
+int main(void)
+{
+	run_test(false);
+	run_test(true);
 	return 0;
 }
-- 
2.26.2

