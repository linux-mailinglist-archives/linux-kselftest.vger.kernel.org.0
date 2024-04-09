Return-Path: <linux-kselftest+bounces-7489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA589DAE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061B28B416
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9081386A4;
	Tue,  9 Apr 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lW7UwVc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0664130A5C
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670029; cv=none; b=iT8xLA+L3iylqtExhmub+hSZdg62wbt8br87ZCKmLiOP3oxtVBXV7pN3k27D00WTAMB6twQjxRn15ql3bMfpGQbk6MVWUIGpcRqPoH/ZDhadtAKCHMWK41zD1Ww192TjUXtsq8rKG+We/VRybL0H3nrWoWvWNrCuEgm2jSkWMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670029; c=relaxed/simple;
	bh=GAIobzzxboeQoxJgFVKL8n/DQn9A2upw/KMw2J/d+sY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYyXo+mVnQfM5z94jyjqtHQhua6WYlFASQg+k21lNTjduSCBqylPulzIuQUy7TDnN1qjSQ2MqWaiR3+p+7kGCfqAMUoZbiNLyueyUVv5KlaDimB0BcNgN6c0hjVW/V7zEFIDiIKYiM+NM6TeTvt4NEhuaqnu0ZP36EtgG+0U9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lW7UwVc0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd933a044baso7925483276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670027; x=1713274827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNEFFvzthCQ2SxLgYUrCxsmLZyU6XQAxNEXlnhRgbg=;
        b=lW7UwVc0N2wmg9r1KifO4bqne4KMwhPf76719ugoW3bczlTxRzQQk0v+or2InFrm43
         CJjpPBzcTL9WahkEuMsA/VbEiHIyfD8NL2ewcGQQ7YxHp80EX8jYGrwLrcPmaEEF3P+T
         ileg1KLfLwwkrphu1kLRVEHGfuoas/5+pplhPwHdvchD5LT98t9rgG1VH1Q7OUgMynX5
         sfSCf7ST7cjmCg3SC/zIzPOFSVU0PkQMnsLVJYkKKjR8Yc+aKYcQsMg4zOqzTp+QseQP
         AiFg9eLqLCivcdYftH0i7UXgu6mN2dzNmQFlGmWZpKxV4Vsi3hEPAfSj2E+jOYsH8Nr9
         ELXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670027; x=1713274827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNEFFvzthCQ2SxLgYUrCxsmLZyU6XQAxNEXlnhRgbg=;
        b=izkC8wkDU9ZZ15LSZp1Ht9CM9TqrQHcYqTze1kskol1KxL62KYiG+ZyK0788ikyb7V
         wlBs555cwVlOjh5cAPyjTUOHQWmk4r7qJa/QqgBtl6tGcWQBF6XGW+F1j/zRbJU9D//c
         XQBHe19xyIOJlqQH1P3LKq3D89etvY91/G11jxTLZEPLmmXrV7xM9ZZxalIBMHjeaUVV
         fDSFpxG7EGymffVRn8RoQtvXCaVXRevut42OOHafKzW3cuBCf9Hp3uobTKYVLUj86hNq
         +786rVyH4wBEGILohraP0ECyxD/W+qZGVDid0XuAbzF9XQzjX6gMmwddBqlsD0Tlsgvp
         VW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx50q/PG7b6KOk9HaYkf4CdMwrX+vJexs0xUv+HijS6tMQCgVQo5WQ6ZUwQE6jLx9Qg4jmEPpyabxI1QkPY55CiHWtq9TDACdoFle9/4kI
X-Gm-Message-State: AOJu0YwXeBVvsMvgmaAjISKU9BFEIbanYsCtXnh6aYIa6GZjKu9BrLcW
	cWSn45pro3a8Gu32d6gmJ58x7aabkLfMBTJAFC83qzrEfmpeReIo5TWOoz2cQVBvsw/1aFLqrad
	44A==
X-Google-Smtp-Source: AGHT+IEKsCBq+aM6z6+N2+c8FJ8Yhc0yVfyFcg83Huaf8k3nrOsQDp7J/38LV2sVOL1hIfaWY1pq8XOTm5M=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a25:8702:0:b0:dcc:2267:796e with SMTP id
 a2-20020a258702000000b00dcc2267796emr576941ybl.2.1712670026875; Tue, 09 Apr
 2024 06:40:26 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:59 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-7-pgonda@google.com>
Subject: [PATCH 6/6] Add ability for SEV-ES guests to use ucalls via GHCB
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Modifies ucall handling for SEV-ES VMs. Instead of using an out
instruction and storing the ucall pointer in RDI, SEV-ES guests use a
outsb VMGEXIT to move the ucall pointer as the data. Allows for SEV-ES
to use ucalls instead of relying the SEV-ES MSR based termination protocol.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 .../selftests/kvm/include/x86_64/sev.h        |  2 +
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 67 ++++++++++++++++++-
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 17 +++++
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 17 +----
 4 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 691dc005e2a1..26447caccd40 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -109,4 +109,6 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 bool is_sev_enabled(void);
 bool is_sev_es_enabled(void);
 
+void sev_es_ucall_port_write(uint32_t port, uint64_t data);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 5b3f0a8a931a..276477f2c2cf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -8,11 +8,18 @@
 #include "svm.h"
 #include "svm_util.h"
 
+#define IOIO_TYPE_STR (1 << 2)
+#define IOIO_SEG_DS (1 << 11 | 1 << 10)
+#define IOIO_DATA_8 (1 << 4)
+#define IOIO_REP (1 << 3)
+
+#define SW_EXIT_CODE_IOIO 0x7b
+
 struct ghcb_entry {
 	struct ghcb ghcb;
 
 	/* Guest physical address of this GHCB. */
-	void *gpa;
+	uint64_t gpa;
 
 	/* Host virtual address of this struct. */
 	struct ghcb_entry *hva;
@@ -45,16 +52,22 @@ void ghcb_init(struct kvm_vm *vm)
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		entry = &hdr->ghcbs[i];
 		entry->hva = entry;
-		entry->gpa = addr_hva2gpa(vm, &entry->ghcb);
+		entry->gpa = (uint64_t)addr_hva2gpa(vm, &entry->ghcb);
 	}
 
 	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
 }
 
+static void sev_es_terminate(void)
+{
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+}
+
 static struct ghcb_entry *ghcb_alloc(void)
 {
 	return &ghcb_pool->ghcbs[0];
 	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
 	int i;
 
 	if (!ghcb_pool)
@@ -63,12 +76,18 @@ static struct ghcb_entry *ghcb_alloc(void)
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
 			entry = &ghcb_pool->ghcbs[i];
-			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
+			ghcb = &entry->ghcb;
+
+			memset(&ghcb, 0, sizeof(*ghcb));
+			ghcb->ghcb_usage = 0;
+			ghcb->protocol_version = 1;
+
 			return entry;
 		}
 	}
 
 ucall_failed:
+	sev_es_terminate();
 	return NULL;
 }
 
@@ -200,3 +219,45 @@ bool is_sev_es_enabled(void)
 	return is_sev_enabled() &&
 	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
 }
+
+static uint64_t setup_exitinfo1_portio(uint32_t port)
+{
+	uint64_t exitinfo1 = 0;
+
+	exitinfo1 |= IOIO_TYPE_STR;
+	exitinfo1 |= ((port & 0xffff) << 16);
+	exitinfo1 |= IOIO_SEG_DS;
+	exitinfo1 |= IOIO_DATA_8;
+	exitinfo1 |= IOIO_REP;
+
+	return exitinfo1;
+}
+
+static void do_vmg_exit(uint64_t ghcb_gpa)
+{
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	__asm__ __volatile__("rep; vmmcall");
+}
+
+void sev_es_ucall_port_write(uint32_t port, uint64_t data)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+	const uint64_t exitinfo1 = setup_exitinfo1_portio(port);
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	ghcb_set_sw_exit_code(ghcb, SW_EXIT_CODE_IOIO);
+	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
+	ghcb_set_sw_exit_info_2(ghcb, sizeof(data));
+
+	// Setup the SW Stratch buffer pointer.
+	ghcb_set_sw_scratch(ghcb,
+			    entry->gpa + offsetof(struct ghcb, shared_buffer));
+	memcpy(&ghcb->shared_buffer, &data, sizeof(data));
+
+	do_vmg_exit(entry->gpa);
+
+	ghcb_free(entry);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index 1265cecc7dd1..24da2f4316d8 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "processor.h"
+#include "sev.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
@@ -21,6 +23,10 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
 #define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
 	"rcx", "rsi", "r8", "r9", "r10", "r11"
 
+	if (is_sev_es_enabled()) {
+		sev_es_ucall_port_write(UCALL_PIO_PORT, uc);
+	}
+
 	asm volatile("push %%rbp\n\t"
 		     "push %%r15\n\t"
 		     "push %%r14\n\t"
@@ -48,8 +54,19 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
+		uint64_t addr;
+
+		if (vcpu->vm->subtype == VM_SUBTYPE_SEV_ES) {
+			TEST_ASSERT(
+				run->io.count == 8 && run->io.size == 1,
+				"SEV-ES ucall exit requires 8 byte string out\n");
+
+			addr = *(uint64_t *)((uint8_t *)(run) + run->io.data_offset);
+			return (void *)addr;
+		}
 
 		vcpu_regs_get(vcpu, &regs);
+
 		return (void *)regs.rdi;
 	}
 	return NULL;
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 1d84e78e7ae2..2448533a9a41 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -18,12 +18,7 @@ static void guest_sev_es_code(void)
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
 	GUEST_ASSERT(is_sev_es_enabled());
 
-	/*
-	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
-	 * force "termination" to signal "done" via the GHCB MSR protocol.
-	 */
-	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	__asm__ __volatile__("rep; vmmcall");
+	GUEST_DONE();
 }
 
 static void guest_sev_code(void)
@@ -45,16 +40,6 @@ static void test_sev(void *guest_code, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (policy & SEV_POLICY_ES) {
-			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
-				    "Wanted SYSTEM_EVENT, got %s",
-				    exit_reason_str(vcpu->run->exit_reason));
-			TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
-			TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
-			TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
-			break;
-		}
-
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			continue;
-- 
2.44.0.478.gd926399ef9-goog


