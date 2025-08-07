Return-Path: <linux-kselftest+bounces-38520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A61B1DE21
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146F33BFCBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EA281372;
	Thu,  7 Aug 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEYHgR5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DA27F4D9
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597838; cv=none; b=YAVDhcc803gIjtXSrmGU5yGWenn9UUS56b95L8DsRk+wC+kb/9hxxptYrGIJs2VsoHaCZtldOXZbsVL5KlmTTTNgoEsSLeaxfRw81TxabIzgFdRGz45ZCfwI94obM+VFg0vCvYv5/HD5JJRTNyn6Fc/PhMrbTQXXlIMFyHs4um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597838; c=relaxed/simple;
	bh=nf0EzG5NgSXKa/TrkEawzdB34B3daS0Giz+DgYxepKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVdx8lsupC2WT9cCwgkEqwNsm9ok/lbSImTrEOEjCm+wHL/8CEIqbkUCfY6AQzjkDIDjGIKL8yZ9s965OZostIn6p6DdgzVkq6wNosYkTKqC18lMCeAsxYfXmOt4LCoRchf89BghAEDxJEIZ6cUJVBb9gajALfLo8hVwtcnZ7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEYHgR5I; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so1615541a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597836; x=1755202636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iq172XdXxDqkESP8AaCKlxAjIACVlq1lEydY7qNJG/k=;
        b=eEYHgR5Ig2P560wuONsaZ/RZZ+sv1mUM1WNVm94Ajo5W9FVpE382KJWbsD1sEQMPM5
         7O/9SVcsEe1c4j4xpLPNHUgy0aJKjlooNNC4vcGU7Mgk64yfamNSxXjH6VJNcs4PsDg8
         uc+ztRONLyFPy9XDoQOzyxbLn1twHgBc1lVLWGVesqF6ZAJcUwGRHBhFT0FP5Fj9GcWB
         afETwl2vYRZa96rIZySdHxveUw6ARX//WJVnIIXLgI5xm0IpGDCHcsOuNbVQ/GdwLHwh
         vTp1ZjIGTrVzkkEdBZoSyRqD5BxqMdevBziqeSyyWqCV2TRSQ0yvLsfiyjR6Wj45vdI0
         m92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597836; x=1755202636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq172XdXxDqkESP8AaCKlxAjIACVlq1lEydY7qNJG/k=;
        b=fjzsUgHOIkLH4gTh38aGcalIgByYel8q/TdQAMAiP8OAFVI9coM69uHTLYY/RddjSK
         DBjXcXlJjmFgfijKhMfQhG2qNUuFGLAGVoDEFJuNAJTGz2r2NuHYeB4fKTE9PKd+iHQG
         s8qhQxeFFvRfZ1nQKh4T0ZYh19yfVtvO4rAgDJs34afAJhveRNU7yhF/EAo1bc9vwaOA
         OaaHAQp+58aVYJaYalEEVTEW/SSO/bPQKN7pCXCTQfAYGg8FMenQwYuFTuA1piNY81EH
         p8jiTho/nLC1B3SlfryfCcNFYyuKLpqjVvYIfclos7oLSvZkN86++EKq0Zoh0eV3KBVB
         nC0w==
X-Gm-Message-State: AOJu0Ywn+FbT6vfb5k4zGEq3A9AreVKb5uYfWj6tE5+S71EpiTJdnNvJ
	l1ffH+ZsACbdw8SbrK15QmyBLA7adgb5QsZUxnBLpzDgLhreGHH2cPi95ZmYCnJMxT4nI3J28/K
	c74ERVn19TzNwI6s/B5p1EKMzR9nZ6zwH4ca7jAIUkFm4V+P0p4fihQFkj2Hw27Pvp1G4LAhMnv
	CKKaI6kAl+KboN8rH8+Fq4Zh6VGiuvf3yqE0ctCF3iCAo=
X-Google-Smtp-Source: AGHT+IF9GDKYO/YboaNdsTUnSP/4IoWgR2B49CtjJAmqyOJRj3Eemq3TkQ+JtNffql2w5H+tGl/Z0AxnOA==
X-Received: from pjvb4.prod.google.com ([2002:a17:90a:d884:b0:314:29b4:453])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc3:b0:311:fde5:c4c2
 with SMTP id 98e67ed59e1d1-321839c8a75mr496473a91.1.1754597835694; Thu, 07
 Aug 2025 13:17:15 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:21 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-26-sagis@google.com>
Subject: [PATCH v8 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
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
2.51.0.rc0.155.g4a0f42376b-goog


