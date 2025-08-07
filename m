Return-Path: <linux-kselftest+bounces-38510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95CB1DDFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E935C7AECDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5727A13D;
	Thu,  7 Aug 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvWzZ3fx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B42367C4
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597823; cv=none; b=tnQkvWdYDU/otCDWn/s263KbCWFO0q+GO0uiJ6eUuCUcWT7uChXgS0p0ry8qBi0P2o7sQD3XIpeyPspmVcsJ/ZmZId/8okv8RZi/CKnr5DCOAPY0NSxbHXq/0sUf6ufwT2IEfg0j3lxWf6xsvPw8jyVSnJwU2hcUW8rdBlWSLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597823; c=relaxed/simple;
	bh=7uQDUuX2od2zF/xx4v0GXRq5KY5yDJtCLQKM9+Jz1zM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KaBNRZEZ8G3nSsORInQPXZae2X7LUIeP1rLRx27Ch6dtPFz374+IVHZhA4i06SytZmBB5/ke+KD63ed6RoNqBhdMpl3CPC+Xy9Wl6aqERkL1J03LY2gG4eNhNFTjeDXrPM2igtxUd2rOoxOmctI4nM7LcWVBEC1CVNWpAO2f5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvWzZ3fx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1435572a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597820; x=1755202620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xRcgcnY/7ITEoTgDsYsxXeksg15Fub5z9He1VHjXy8=;
        b=WvWzZ3fx96zkGt3NZFlJB1BOc9sBeOsJPeEaZzpjNrX3Oi7E7Dt50dVu4ohP1bjHjY
         SoIxRieAXD+oV0JIHrW0GTEFboKzfELPFd+evpgF/Cu6sU2RmYv03Y/95G4oyT5lwpYP
         wwh8YiE/sL6u7C4YxiEIHmlFVHCfVaHPeIJlSC/7Vp8i0nfssyqFhlxoCSxRaTlTuINU
         QlxTfntasNyIP4kPqBRXMlDn5S2xvLZJHyh72Uon5sy9qAPC8CjqqRNe2L6OFHlEL5V1
         kOi38zeVJQ+TMa5thJcPkuQPoEQgHLJ3lKXF0bLlHRUWE95X8d7c8I2TodChJqrmaSPu
         KQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597820; x=1755202620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xRcgcnY/7ITEoTgDsYsxXeksg15Fub5z9He1VHjXy8=;
        b=iyjDcKSpRKcJTVon2VX8f1L8uWzA2DBOUAJKWKI9QKr+yI8bTG7dNBSJopAo5zAkG1
         s/HCcwev+qacgdRcFmHbvWRIhTA9E3Pev1pdTsTbOx/CVdRXEdBtkxzsFBZD1Q6X48W+
         Defh1X6OTrIpUtcFz/IUTiT2lSIKzmzS3CJrMGaY7SjVAOCFJvooRzGZ404cej76bFXZ
         04VYhNRpuEteuZd0Cr+amkZRX7bpwiVI+Vsv55ZniXJVc0IBK5zytOXVUh64Dw4zDugh
         zXUWj9h0WwHf7UHMm8wa6rlYii7PxVu/PhOHwdRQ/Kte4EznMHpwOuT/mKkA/i1QsJkC
         c4eg==
X-Gm-Message-State: AOJu0YxudGk09ueGzDzFUZDiTCvCYQ7NfNn2DMT/4VFttY/3sEakzGck
	f53CHTr1nZ3lvGdBxi4KxmPSTlK9IBmuOXNH2bTHtI0sDyE6loBhQofuEyniqqVMQONHOFplXzM
	V8s2N1y2s9c8jcRezTRmtbMfOUokIT+IOh7f7w+H/2kJ4zDXZ4pGf4BUGMqifuKX5HpisQQVDuj
	pbA7ybi9RB87tDkDXnUNCzadX6g8iHsRduQ3/WEwAySDc=
X-Google-Smtp-Source: AGHT+IFCoZqmW5N9rtBu+azrFQx6VUYV75fQ2l8R4X8A051t1ZBw4o2UVRrTaky4Z8dlTuR8Yh4CSFgT4Q==
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:2e0:915d:d594])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b12:b0:315:aa28:9501
 with SMTP id 98e67ed59e1d1-32183c467b7mr474796a91.24.1754597820397; Thu, 07
 Aug 2025 13:17:00 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:11 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-16-sagis@google.com>
Subject: [PATCH v8 15/30] KVM: selftests: TDX: Add TDX IO reads test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test verifies IO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index f646da032004..ae5749e5c605 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -383,6 +383,78 @@ void verify_guest_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_READS_TEST_PORT 0x52
+
+/*
+ * Verifies IO functionality by reading values of different sizes
+ * from the host.
+ */
+void guest_io_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 1,
+					   PORT_READ, &data);
+	tdx_assert_error(ret);
+	if (data != 0xAB)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 2,
+					   PORT_READ, &data);
+	tdx_assert_error(ret);
+	if (data != 0xABCD)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 4,
+					   PORT_READ, &data);
+	tdx_assert_error(ret);
+	if (data != 0xFFABCDEF)
+		tdx_test_fatal(4);
+
+	/* Read an invalid number of bytes. */
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 5,
+					   PORT_READ, &data);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_reads);
+	td_finalize(vm);
+
+	printf("Verifying guest reads:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_READS_TEST_PORT, 1, PORT_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_READS_TEST_PORT, 2, PORT_READ);
+	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_READS_TEST_PORT, 4, PORT_READ);
+	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -390,7 +462,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(6);
+	ksft_set_plan(7);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -403,6 +475,8 @@ int main(int argc, char **argv)
 			 "verify_get_td_vmcall_info\n");
 	ksft_test_result(!run_in_new_process(&verify_guest_writes),
 			 "verify_guest_writes\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_reads),
+			 "verify_guest_reads\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


