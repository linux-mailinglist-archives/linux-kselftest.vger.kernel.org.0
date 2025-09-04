Return-Path: <linux-kselftest+bounces-40741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CAB4330A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE3C200310
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD65299AB1;
	Thu,  4 Sep 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQo00vHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D30298991
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968923; cv=none; b=t9aFzlrXr6muQzLpnjvHfUh1qGsdRz8NsWCc3ukWfOzXtpC8L5TwA2YbZ6MlAfeBd0tVUP1GNjNMRKNRxeV9TRG3P3h6ejsMui8McgRT9+RIhnAjy3nQXXfSrp+j/g06k02QHOaZP0b4TkwmPCVNTMXNL6wqMvc2b1Cd778wESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968923; c=relaxed/simple;
	bh=aonB/eCuRYccRY3VvDhmGFtx766iDhuLel2iFuyfPvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gi3swZAVwlnynZ7hcFqQgKtHbtEHAt4lwl1KN3y9tNwXmD4s5pbuYvuw3KpZWB5SjOTMVsMRDY4Mm3TyUKvMkYmBKC7TQafDQJyu+UOaR0subucxy6j1BpkP4aWS9T8QjL0whd3z8LydEqC51frUb34dLuxHVa41zhdpRZ238Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQo00vHn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b58eeb874so605287a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968922; x=1757573722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvz/RUhUzWK3YIgJJiz6JbOWQToi8UuNVcz+/1d9b6I=;
        b=rQo00vHnws4of/13pq5YZRpX/DZUksBrzhJfddzAEP2gRHWPf5KivAenZfqm4FpIvw
         kMg70VCD4+s4nviNiLg066PcHNRJ5BcwhWCN9cBQ6KBj3DakGOusybVw/u7ooLDX+rgS
         SaNfxdF/YLYUY+ZdmJUjdoBJVRKR0/R8gSmhimJ539F/2GmCnOGOJ7vgVPUDcKoK+4Am
         8eXu3xdKY+jlZJazebckSyffm823fpyVMu3OF3U2lLF+kIFCbRZ5rzSHH74nZ7t1oISH
         r1poren6zlgLgfJBHXXyjn7y7m1JCyQcx+eqKf2P5iqQ/inSub5+QjAxYhPQTQB3icRv
         KVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968922; x=1757573722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvz/RUhUzWK3YIgJJiz6JbOWQToi8UuNVcz+/1d9b6I=;
        b=g/YhjJdxwyEBi+mX/UUOP03H06XxrE05//yz64v8DTk+Ovj8vl/v8gcuAJ4kAlAngU
         qeqGof9lIv4KZtlIsPYXD5uZZwp5EvdaVFvgY25v9lyhOwXf0m6JxLAkJgyFk7rENiKO
         LGUY/RS3a3IyClZuhcO1J83Q998mpB2sjaMzj5W/7FVRRhaFjH3+XSEskdFEZ76/fw9d
         7zJwzH5C24PSDrxfwnPohGEyBjBuhTPkRZCeG7C+kZF65VmOSfU1+rJPd6WvUUs1xfCS
         iz4YzDWA+d3kO/IaxgqUv5p6kzwCW3zZ3kLXn+39aQYT5g3KkbwoRD2d1XjRys22tVTF
         fc4Q==
X-Gm-Message-State: AOJu0YyjruBwGHrYV0sjdFBdGi6bPXgRlUgA3YlDlXjSdA7V+jXnhpBE
	axPShzeh15mt7iKge7Xv55pD5Y5e8xT1Xb4B2CI0/JIKP/UAQyGkvHBFNcCsVb2Gsg4f0KbJ+j9
	lcuyFTE0SEIDVboFtY8gvEj/HWMxE3ZS31XmzNwbDFbJlnZ2qiFsNV5jImtk/oDkpDYSymSS7pf
	StcdYS3KGWNVsP+y8Po8VaLRFzLMl0TrCbfmLc0lTDOjQ=
X-Google-Smtp-Source: AGHT+IHOjWuQK34dUf4IdxwrpKRnSqRG6X0hBaPJ0I2Ra4SwU/ya2UpxFzedgGOgdGACsTrDLh7HJK5caQ==
X-Received: from pjbse15.prod.google.com ([2002:a17:90b:518f:b0:32b:95bb:dbc])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:570d:b0:329:f535:6e3c
 with SMTP id 98e67ed59e1d1-329f5356ef7mr10386542a91.35.1756968921579; Wed, 03
 Sep 2025 23:55:21 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:42 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-13-sagis@google.com>
Subject: [PATCH v10 12/21] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make sure that all the attributes enabled by the test are reported as
supported by the TDX module.

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index aa0cb6c2205b..1b5c01faf1cd 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -234,6 +234,18 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
 	free(tdx_cap);
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* Make sure all the attributes are reported as supported by the TDX module */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -253,6 +265,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
-- 
2.51.0.338.gd7d06c2dae-goog


