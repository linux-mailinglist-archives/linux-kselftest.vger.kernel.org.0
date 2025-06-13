Return-Path: <linux-kselftest+bounces-34954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727DAD9558
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C61BC3565
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F942E92C4;
	Fri, 13 Jun 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc03Tefr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB82E8890
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842092; cv=none; b=jcwQExGqwOxSbDkaKkfbTfsUJmbjxRmGhjBwU5v/qqy1g7q/PaselKqbLHKRn06jmGZsdfiQUlqdHyM34/HH1O1joNyYv/Xjbc/0oM3i1ImGdUjhgLw6DbPypQUI89A5/V3Qv2DaepaNciM03c69gCfS4+xh+dpHmTR3Dj78Abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842092; c=relaxed/simple;
	bh=EYmmSlBF4C/72f7adu2xrFOYMqAVykY+Yges75e1mk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZjuR3tHW4UbRHmDUuP83CRb3INtowqW8eheu5t/iNnBEHtd2n9EEqhj4UlCNA2KLouNGYXBQAEYjxJCMmcqdL/evfYSwvwLj6VgE2pr7ZTUs91QZe4ZeWwQsC49kgbt0swJZTUGYtHC0H0TUglBvLC+zro6ueuGgSlpBNLrfLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc03Tefr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso2107435b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842090; x=1750446890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQS9KEcxjrfBhT5g6y6btmmw0Zrm/EBAnz28lESsUJQ=;
        b=mc03Tefrk34C1Ez1tsp8bzS/pW5L/dgSM+oDnEu8kCEz/Hf89u5nPArn3PDYVLZZwh
         mHlLRe4CIAVX/6f3Q37gpzPfFUFVhJS3fxHA1fuWIi3xOPTvPG3ZIq7tADUB4UZq/CXd
         6/FtXg7QLDu4mJIhfHoRK/IZHUQKK9jsQOx7Ofyv5o5apTWYHMF7Fo+IVtv3se5WUaLg
         Hduq0xJZBM+yO1JHaTsdyuBtVjbMRWuJDHsNKEh/qcOf1yWXprixmY+PNDqinuSz3KGg
         Sm1UiRxFUiuW/FlVIOiVpIRFj7rXS4b+Ut+KaH4zCCfPoxJhZwCFCeoviz4jEVFpZ0EH
         /Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842090; x=1750446890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQS9KEcxjrfBhT5g6y6btmmw0Zrm/EBAnz28lESsUJQ=;
        b=lZskw1b3BqMdqfWc2oFdrwaGYsgyI6EwG73ljSQZK1sQRvSD6mJFDWiSE1jq0c0JmY
         1w+YWoHLa52LuFz+28xK6cCJkqMaJ8E8Rxesdo0Co0mI5C95nflNSRd/RizARunwNI3B
         LVjEfhEl3eNgBgR2Czyn6V6RletU1KNTKi10EjwAAkABzK/4ns0kAUg8K3EEzq5uUt2j
         LJH87kYZWCdHNdEvU+J7NoWL7o7tweaQA9o6mBQbQ/uSe/UfXzy1bxK6knkXkYXshFIh
         CdJAh0ULDDxDloalPyXT8k4j500Mov33RhGEvWXOoGKmTMipzXOZspU6Wn8y1NIgWMSR
         JPzQ==
X-Gm-Message-State: AOJu0YxnvtofBsCWP/JRg35tIIaM5vApulN51NQYCvZ/MD3XBBAz1xZ7
	t6KmdXyQ8rnNbRmKW/4DX8T+ld4RAyiAqQ+6zDmqUaa2NDHm6boeCXUPZ2x8PgfUjMG6Em3zGqZ
	mwQMklTHKdqlPV7LJCmJmAtrrcte42GRSrKITl01FiNMxj1fc2x7Vr4zg9cXPdjS4bk4rcfih0j
	U3CrGxg8BTbjLYdYRGVyWLgLgLpcjs8SJhgEfSMQDu0EE=
X-Google-Smtp-Source: AGHT+IEOP4GrUzQcNjvdcHvZ0T90I3oYrH2Eb488bsbJSQug0p1LrqzO/9hpSqb5M4HMhpMKbNB+gqPsIg==
X-Received: from pfbhx21.prod.google.com ([2002:a05:6a00:8995:b0:747:a9de:9998])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2185:b0:736:a8db:93bb
 with SMTP id d2e1a72fcca58-7489cdedbb5mr672632b3a.5.1749842089751; Fri, 13
 Jun 2025 12:14:49 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:52 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-26-sagis@google.com>
Subject: [PATCH v7 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
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

From: Ackerley Tng <ackerleytng@google.com>

vm_vaddr_alloc_private allow specifying both the virtual and physical
addresses for the allocation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2e444c172261..add0b91ebce0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -652,6 +652,9 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
+vm_vaddr_t vm_vaddr_alloc_private(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				  enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_identity_alloc(struct kvm_vm *vm, size_t sz,
 				   vm_vaddr_t vaddr_min,
 				   enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 14edb1de5434..2b442639ee2d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1503,6 +1503,13 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 	return ____vm_vaddr_alloc(vm, sz, vaddr_min, KVM_UTIL_MIN_PFN * vm->page_size, type, false);
 }
 
+vm_vaddr_t vm_vaddr_alloc_private(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				  enum kvm_mem_region_type type)
+{
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, paddr_min, type, true);
+}
+
 /*
  * Allocate memory in @vm of size @sz beginning with the desired virtual address
  * of @vaddr_min and backed by physical address equal to returned virtual
-- 
2.50.0.rc2.692.g299adb8693-goog


