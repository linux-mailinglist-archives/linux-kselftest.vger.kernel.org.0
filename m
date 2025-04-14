Return-Path: <linux-kselftest+bounces-30789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4081A88E75
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D97189B215
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D1233D7B;
	Mon, 14 Apr 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XleRTEzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE723370C
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667359; cv=none; b=Iux3IPjsfAcYLkwGinpORusexAVzEKuz3h77dfvhW+Zgh6IS2w/rIgiEoeb6bRM4b0MGPBWRrWwCw4UEMkZsIp2H5VdV6nSbu1Ee3yqL8cO8hHs/xjlwvHjPT/qhQHHURSh7M7be971Y+UlbbdzUkOsoPtS7V7uHeOeHgdCvLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667359; c=relaxed/simple;
	bh=RUYEkYTMaq/3BlLYohoirll+7ThOc3FAQ0S52ejBi18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAgvA/XHSvX43KgohnWVJcjVtUgIPsEJsL9QQSt10iqjlOXeF7kaPdd+jJaLKXudDTugUuaS0Kpc+8b+CU74l8tpnQ7XKakE+Rhp9r9jDyBMSvuAk7jM7QOKktasMt8sBVUrFqSxA1ep10uMeu2Na5kp8UU3CjjQIgT9aKSHlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XleRTEzV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso3966351a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667357; x=1745272157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMPet3QDUUSXb/aMjIhmKZ7iY71MK1Il6Y5uwK/4fYE=;
        b=XleRTEzV3Yo6DloZX+M7+GmKccLglAR0DsLqI2wRA+w6Q8tHM/wHYiA0puNPac2avA
         4CtWmWdWJnawcRCpSlFhkpg6rkL0Ju5U9uuyWs0pSEK7hJpCOiZ2iItH1rlwRSo7eDve
         RCyI5reNDgFl9gIfpptvIRGK7EvE+iTY+/yLdDaspRF+1QKbEfQ6/ufqKIDV7zL7bnZI
         O6w4ZO5VPup4AwntR2goV6qcCGsXjlEeEn+bM7XVMeU11ue809EG0H/kkqWY1cy5/tl/
         TAwnTi+X0AIMha/4x2U2wFMXE/x5ek1MElwMg+rDNVG2tvF/HfCMFfAcasAtklLHKnZy
         HTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667357; x=1745272157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMPet3QDUUSXb/aMjIhmKZ7iY71MK1Il6Y5uwK/4fYE=;
        b=XNR+IbcZO/7HH8i7gubClfLDAQiAVXZrWaAR065UiuR1lOmvcLtMzOYBtjI0hdtnEe
         qiaI3pJXp6n0wzbO77q/DZvajDUI8VZPdAxW5XTRv1ZiJy6G8mtjmb0F5f9WiNX7Jz1F
         tSoPx8LGubFmWh0H6hZSBkf7pacHj8WS2hkthwFjo4+WPnMcoe++fvMMdXtraYy3gUrx
         yL4nErTdHD/YGo9a4ZCzX750bDl5OGQP0NUU/xRjT6s5Z56JuqvlnrDRN2SaZM621vDd
         emnNT2VBFQqG2xSrUfX6NhwHzdH5nK9ZwJxOt6AHTyHO1+IZMxuEU8we1O9k2Jkpc4xs
         t5Iw==
X-Gm-Message-State: AOJu0YwcQhxOBeJMafCExZJZauXdpCKPZ6/qakB513eNuusfKUT8mckd
	M1ye6stMKJiPyJEbFvsd2vEYotUo2cj1dbxRsdAUaqiURJjHdhyBISe6RWdAFXkgG3QZiPUzxwh
	OslpAcmBUwqTUl8QlFD9MLH37Qyx781KRSeN9EQEv4FXRwxAIIaQediLb1OH1c9WyrQdz78T5BC
	5Q4fjCowl5JQPIJ3KdiLLltokRuFMO3KxS7d5+us4=
X-Google-Smtp-Source: AGHT+IF6DTwMtcpY+dm9XhXfMkBL/aQSNoT9zozLSWGA40+RquY/Obe0DR00PEcuF3BMTI6cgXnFJZGzFw==
X-Received: from pjbtc15.prod.google.com ([2002:a17:90b:540f:b0:2fa:1fac:2695])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:534d:b0:2ee:863e:9ffc
 with SMTP id 98e67ed59e1d1-30823646e88mr17299676a91.21.1744667356611; Mon, 14
 Apr 2025 14:49:16 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:54 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-26-sagis@google.com>
Subject: [PATCH v6 25/30] KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
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
index 442e34c6ed84..690aef6f887c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -611,6 +611,9 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
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
index 008f01831036..9e0e28b6e9dd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1486,6 +1486,13 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
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
2.49.0.504.g3bcea36a83-goog


