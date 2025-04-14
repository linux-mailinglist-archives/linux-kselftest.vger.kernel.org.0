Return-Path: <linux-kselftest+bounces-30779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021E4A88E58
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E43A6682
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEA221273;
	Mon, 14 Apr 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhUm5raR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702F21D585
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667343; cv=none; b=lQpI3abRdnz+t6JzPbYhe8KQEtbdqVQ+YvG6sL9QaD+L+OpIp0fSBtqYOg1ZBzBGgvrSyH298slHxGD6ZmU+QH2GCGGx1DRNVMd+bQxOWv5Y6XfX17XfNR14G4K9lKWC5xp2vo/2hWfeVtiLtWw8LXnaGsxpRyUwhYRmCn/TBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667343; c=relaxed/simple;
	bh=m6XZAFr9d7k1sePSC8lrRT9WZsZlOgeaGPEDDsdQtiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BrvsW07S1pj5W6zKE+Mx9nM6rxBVospb7UGMidJ3pY5xJGTczOLRXcjt0uf26zApHPXvi2tzjrinGtl40r4HDynlKOqFs+EhBqfmext5ZwBefZl2eugL0c6yavISIbZPfxIpEf+bJVGgF8bbR38bd/3e4OVllsYzrDhvESzrvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhUm5raR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso3055138a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667340; x=1745272140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSkGn0jO8D7u6Mzmo2Skc2pJxtV9/HYvntZJQxqwflU=;
        b=BhUm5raRcFe1Gb+Ok+pXJnlCIL6Ub9hqnkBFUR8G6DqRwL6SQnfDcaL0HGLxOFJksz
         Ux5fjCoPhlFUfoQJ2+m8jMJLJHuE3Wx+CLBDYW/yXkJYnVLn+nDbQ0N41aa3NDC1hjrI
         zLNxSMg7kAGjJAtvm2las05pE+rBDG0yUlIkvpDXhPYFoFVHuRqa96O8xMVP0UabcdaR
         43zi+O60RPVob89vKqMREKaN/xj0HmqsJ1E0BvvPeyTPVE3a6f03H20RITL7UZo/e5iG
         2fj2QTaNQZgBLTRws5wtTt8UAzy8Bef4d5AFtz/it3DhbPLI5wW/V+XL4fHlbmMXU90k
         09dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667340; x=1745272140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSkGn0jO8D7u6Mzmo2Skc2pJxtV9/HYvntZJQxqwflU=;
        b=dDNtChWcXvuFpH5f68SekuQb0GuOvWGwoHtlLKprhnX6nYWUF/MxZla9QoYa50Sdt+
         olfTZF5GI1FvN49cIeFa382WnPzSnbmWHauxmd8iis0Os6l9YssF5GbumfB7Pf2Akrx4
         VBTSBDAPXL/b/4/AyF42l0F14esSbuJnAfiUhE6MuTtRI2EoyHciafCIqAMi68Z1kYi9
         Pq7LXTy/FpUzC1y64wF1nvQH1z1llCGCue0RxgMlhZfh0tCzDjB1+11W0p9giwpQgUM/
         j9n//BX2cx5KHSbsu2ma84lQ9M5nL5cROVII05WqmVnB5kQdfuqnWJHk2U6Mc+aIdJO6
         ZQPQ==
X-Gm-Message-State: AOJu0YxOZhrZOGWhcLen/Sb1hxWihKjUhmlcsWObRFbrc4CVZOp3CcSQ
	BStK54/qfo2c2i7p2UCEoiAYp40GicuxBPa3E8+sODxikWCkOtJ+icBRAJBCH1/vlW2dPM2Ofkj
	vIGRozPPunIrXaVRHmH1rMswJd++irh2lYscsZxd3vTtq9MVtxMXZtR8J1zs/Pe8Jm8OExcDmtm
	WiJg4qFwOkI/2Yn79V/HzwIS9b6HehOLdebxn7qV8=
X-Google-Smtp-Source: AGHT+IE63zYFHniLEiomnIcid+bNx1GXO6+bLTGlcZ1tDQ3qmoI0tt9VtY+yKOzizresPhzJaGwy4CulQg==
X-Received: from pfgt32.prod.google.com ([2002:a05:6a00:13a0:b0:736:b37b:f363])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a03:b0:220:fce7:d3a6
 with SMTP id d9443c01a7336-22bea4bca1cmr186211395ad.23.1744667340531; Mon, 14
 Apr 2025 14:49:00 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:44 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-16-sagis@google.com>
Subject: [PATCH v6 15/30] KVM: selftests: TDX: Add TDX IO reads test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
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
2.49.0.504.g3bcea36a83-goog


