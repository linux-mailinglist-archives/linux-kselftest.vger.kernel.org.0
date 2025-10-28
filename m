Return-Path: <linux-kselftest+bounces-44227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 144FCC16F73
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33E774FF2FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B63E358D24;
	Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PN3EpJhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528D3587B2
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686473; cv=none; b=Ir1DKveK+UWhZeGOxr8N3fL1ZvPxCkfYfPH5PM9OF3TjykqFzZkVV6zNaUpqjMDjBnaW5rztL36JrdpMEw1uLjc7SlekWa/qE1IVY1a9zr9/ZmbigyClFJW36z8zLiixCv16sCQBGU3RNe3r5DBRFceIWk4k/hIyN2bNyFeunEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686473; c=relaxed/simple;
	bh=SSju8hpgRQCCYa/WGy2Hfs2TSfVu9BNYRaRjeYxTtX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AJmHQQI9/a8NomqPIBSAKFSOoeT4IqL+jyFfqOYUJ6yDf85ngEPAqtzO7d1vk6Zh+z2YnTOFzRfWEauzI8zCVDfrJclEUeDIbwrMq9ajR5J9O5JdYQ0YwCOTtu3eAH36Gxv12BQydSYkX1cDnUb4Vwne/NNo4hdg5MwTE1ewAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PN3EpJhS; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-886e347d2afso683726939f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686471; x=1762291271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBAte3bSxg2BqVPcwX5kZwUWKIXNaVBiblLvlrGYl+I=;
        b=PN3EpJhSz93SgWE/QgkZAghervIAL9XSnR9IcBr8s/H6juAoBlRXTF0JPhLBfI8xpj
         hsG19I+qSB2trM6gNHNDASSoUTqAaRERBheYztBE/bVwekLANafAEfFfnsoaUQP6Q/1w
         hBIERKBN2Hyq0P9Vw2yP9bT2MKoKZVW0YuaqIe8SYYmFmMLkqmeUYwydQifJUDYAgJNj
         da0AAeOap1yXo6iTRjKBSz80TapPysmD6WRwVZ9RyUh/s9JmN9yvp6mYSi28Bu5wKEzt
         e8xyB97M91cMKUWxaReN+Y+yaglPY2OaDnV7G51kRxIgP3lP9bS8aMd0zJhVL+93pPCz
         OxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686471; x=1762291271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBAte3bSxg2BqVPcwX5kZwUWKIXNaVBiblLvlrGYl+I=;
        b=j8FKGt35mtRNiQ18fWgziua3ddnnR2eJ3W8h0DZMPZoY/wz3MXq4UB2scKHwyb1X4a
         wHq2S+fXW6vz/yDAeZv+3iXA/aAS4z0ASqh6+FUJy/YuSa2HICUWCWQvPpg/iZ581YSK
         5cQ7woxkiwy1RsIBKDHp9y0e6rSlt07ZQK8iDZ3ZWcoF4/vj+BY5Pps++j5MLR5hqPMk
         VcqmzE8P2vhn2Rc4m6DoaVlhJ7YGrSlz+cPMIxW/qZFN0hutmcyVxXfaWpGvEgO8i94X
         i8SZAJtafBSFtMtj/uEA83nAWFZmT9yPW5wvRRuOVP5lOZKbaM+lqu0UfZI3+6Yyov/E
         OHww==
X-Gm-Message-State: AOJu0Yy3ZZFN867TNcjsjlYVav7GYBQnGyWURyTv0OXp2FrFhNVTTGjb
	wpx9hTUFQdSuYQRRsKFt3U3St0+G8+TO8+GzYiazEGXHKceoh9s+kRyUzcr9LGozaYcIHriTUSv
	j7otjeCpeb42WUuDmyXgqsYk28zyz9Re09Yv2wFrxIiJfdpoKPjMccSQaij4xWJTnZphMBeYndw
	Ihv+6gHo66NEwzqLIYDRGBGXE+7Cy21iOWJuNwTT/rKSU=
X-Google-Smtp-Source: AGHT+IFVnL1JsXwsLvk50B/SKrEvdQC++PNX0X79tl9ZHtDXjwYj/yy71zzwBMqAzW19g/ROZBqxSRYz3g==
X-Received: from iobbh7.prod.google.com ([2002:a05:6602:3707:b0:941:eeba:3c0b])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6d84:b0:945:b097:7cf1
 with SMTP id ca18e2360f4ac-945c965dc0amr154513839f.3.1761686470850; Tue, 28
 Oct 2025 14:21:10 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:42 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-17-sagis@google.com>
Subject: [PATCH v12 16/23] KVM: selftests: Setup memory regions for TDX on vm creation
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

Guest registers are inaccessible to kvm for TDX VMs. In order to set
register values for TDX we use a special boot code which loads the
register values from memory and write them into the appropriate
registers.

This patch sets up the memory regions used for the boot code and the
boot parameters for TDX.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0e6a487ca7a4..086e8a2a4d99 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2018, Google LLC.
  */
+#include "tdx/tdx_util.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -435,7 +436,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif
@@ -469,6 +470,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
+	if (is_tdx_vm(vm)) {
+		/* Setup additional mem regions for TDX. */
+		vm_tdx_setup_boot_code_region(vm);
+		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
+	}
+
 	kvm_vm_elf_load(vm, program_invocation_name);
 
 	/*
-- 
2.51.1.851.g4ebd6896fd-goog


