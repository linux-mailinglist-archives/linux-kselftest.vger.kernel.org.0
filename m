Return-Path: <linux-kselftest+bounces-38499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA80B1DDD9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2094418C602D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016EA274651;
	Thu,  7 Aug 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k68Pe9QS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE727381C
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597805; cv=none; b=Q6EgnnXpRzuDca2I+IDNJz/lf/VOIBbGxG8LW3X5s/Xj0irrNMNdfAIUVm/1HQw5ixpIJ9bsB7+Y3lMXMLEtL8jheL5FemQhAp5lVY1TtfGYlUWTRjs6ZMfXDGqfdF1upFBC58B04qV0PhGpLbJkE+6w97U6XEtLBaclY126aPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597805; c=relaxed/simple;
	bh=vvoyDwfrz40cXS2E/qfKw0KPWURpKZQSXbiY0G7zSzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gaZ9O5UeOzltq9kphLYOU+MRtSnQXqhkCT4GIzD2a86r4U/d9PNCoZEHsP3pUhxxG13fw5v3GmHqaCeyx+7TBIiiiaLga8G37kPCqp3G5s6dYsOt4W8qq9feqSJSAG1vNFW68Vr8TG3sABrrK4HDDhUfiPR6GlPPhFrrjehLVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k68Pe9QS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ed2a7d475so1426623a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597803; x=1755202603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZhMhm+oGoXjR1ZKMvnfqRkH9sxXvmJdgGAeHzetkDQ=;
        b=k68Pe9QSBBrKDbEBN5dUL1XNCnuokeOQkA0CnjBPEAkuCVl3X4m2aErekq/HEpm2vJ
         a4i2Z94Rz6n6CM2LYx/wYFRFNtbixIoYi1GuJh+lw7K/py6pvAtfPFlqN0ccCduLITbe
         v7b94KAmE2h2kT4p8NhdW3gBltVXJiipGbwjcG7dHJwpkKxlq36/kbg3jqsjG6a5sa37
         5mACZv9JfwpLcDN4z3DSEmXRoNiovdyUfH2gtSeJDzDs1F4YdgAUW61cGjU5RQCWzXtz
         Y83LaCpfzYbbw3nNKXJmJbh6MeENE58TU7XyyOmbwyiz1+j37ap3EQY3oQiEfcam+zjQ
         p1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597803; x=1755202603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZhMhm+oGoXjR1ZKMvnfqRkH9sxXvmJdgGAeHzetkDQ=;
        b=kM1qu/3lPN65SMHnQWm4Am77j3oC5sAH9WSD6gcgfDgwd5QfhC6g8Jz2KLp59B6Gxo
         8gKC0rC7+OwdDmENGPWzHZVgOyVuB0b11SnDH1iBeJQk+n6biEWr+18Kh4wbdHTDf4XK
         OkLbsKqIvxjI2Ug4pkFDeOXsnUAIPN3u/6Guzw+SXSot5grVCWXKC1+Kfv8QLDr77fFS
         IFUXcsQGkjnSIdLrTQUAxgaDNlFPkWREBcgjdjUYVeQ6Nd9wcV688mGwbqQBxjvQeE0p
         f0AOXXbmhTPU9BydmPFvIs/1x32WpYrEAAedCoXm9tcn8HzyS2rOERcQR6fBPtalkrHg
         t8Vw==
X-Gm-Message-State: AOJu0YyMqg8qz9VKD37czAlB7w9sqx3Y0C/UYAc1RgeHUJ8pvD/Msmfv
	TseGOTJ96BZX02Z4oIKxzxn7bjKxgoD8WOT98R7IWAPcqRrM6qNon4YW3C0Wy41WXb4HnKSf+4o
	xxSKzbVhiUUVWZeJr9qpYlE8pZQkAfQc8DWz5L7BwYd7nptmDqYWwviKpy6KtRxD6IvuyJNIbGO
	xS+uvG5v51RG8Wohua4pZwyjTNJ/y9ZdpA3tbP47C8Mhc=
X-Google-Smtp-Source: AGHT+IHjDcLQX1WhIoIZLM1WoaOz3EieXlE18GHV1p955qAC5wr4S8qpo4H4d6sFinEdYcxFY537Ys6L5w==
X-Received: from pjbqb13.prod.google.com ([2002:a17:90b:280d:b0:31f:61fc:b283])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f90:b0:31e:c8fc:e630
 with SMTP id 98e67ed59e1d1-32183c46068mr418295a91.26.1754597803497; Thu, 07
 Aug 2025 13:16:43 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:00 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-5-sagis@google.com>
Subject: [PATCH v8 04/30] KVM: selftests: Add vCPU descriptor table
 initialization utility
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

Turn vCPU descriptor table initialization into a utility for use by tests
needing finer control, for example for TDX TD creation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 +
 tools/testing/selftests/kvm/lib/x86/processor.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index f2eb764cbd7c..37ad1e4d86ba 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1178,6 +1178,7 @@ struct idt_entry {
 	uint32_t offset2; uint32_t reserved;
 };
 
+void sync_exception_handlers_to_guest(struct kvm_vm *vm);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index da6e9315ebe2..d082d429e127 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -585,6 +585,11 @@ void route_exception(struct ex_regs *regs)
 		   regs->vector, regs->rip);
 }
 
+void sync_exception_handlers_to_guest(struct kvm_vm *vm)
+{
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
 static void vm_init_descriptor_tables(struct kvm_vm *vm)
 {
 	extern void *idt_handlers;
@@ -600,7 +605,7 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
 	for (i = 0; i < NUM_INTERRUPTS; i++)
 		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0, KERNEL_CS);
 
-	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+	sync_exception_handlers_to_guest(vm);
 
 	kvm_seg_set_kernel_code_64bit(&seg);
 	kvm_seg_fill_gdt_64bit(vm, &seg);
-- 
2.51.0.rc0.155.g4a0f42376b-goog


