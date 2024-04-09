Return-Path: <linux-kselftest+bounces-7488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DECF89DAE1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DB31C21271
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA16138487;
	Tue,  9 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIgNM4ol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A312FF6E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670026; cv=none; b=ql7fWe07iuQFAEcBxrlcdF/dluGjdT2+Za5Z9WOf9RJU0AC6V/Da2JO6DQcGbZFXBbtKu4UpPl3wb2h7r+vZXNEB/6fqFTV0TBOLNEILvJt9U/eguko7hWjxdpQSlTpowO66U0ajaqt9E15PAoq4NJ6wXwCCRwasLFxfwisgiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670026; c=relaxed/simple;
	bh=PVCOhdc6DDdw0dTatfHJ5V1Uh3Bi7tZFW7XYqRS1wkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUEJvM8UIhSsnV4SG56TJZi02jm6bUJ45PkZStYdDXTTMTWanbK0knr22WImUCTQ2G/AtjUHsgNUsE0KvscQzWdY27dqNcl8sGmXE6XFAlsLR0Fahud6GCSL+hq5cmK0y1r5XBzXwbiYNbUSOCDSfN/lGYRa1DP2xbW7ucy0dvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIgNM4ol; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e4b70e0dc9so3160715ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670023; x=1713274823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuEK38GC7iVK1ujFFvcKBa5p48Qfvr4eBgbugkaO1k=;
        b=uIgNM4olSYa9ysZXvZp+63Gf1FQXWeggLzsyu94VJb3YM6sUm0ZENCwefqBtOYSwr+
         ugE7ELpNW3WVFxmd6z2ilMrINVRuwFh9B00ufRfIK1MHgzVctVQz0B87/uaMQ3WazDLq
         9KX1NGsa2SCRInWGkZwyNU1B+9pURO9vCHUSeTd7X+CElhuJkGo+iAjkC+tzH7Fe3WjR
         +M3XeWago9jJdVfo12qiMss/qT+/XpHWjwSfKPhR/ce4jLNXi64zCgHS9CxW13+qRluj
         5RkJVSrMnE1k2bKGtG3EIAs3GvlO1TrXX+0Wh63iieWVJqUR48TiN9arIQ7Zx+FrdpmC
         RBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670023; x=1713274823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuEK38GC7iVK1ujFFvcKBa5p48Qfvr4eBgbugkaO1k=;
        b=t6ju0erKw8xlb9ar95K7U04X3+zX8upLYTFkORg0SwHP2BlvTCSMfDVkAbbpyxRpvf
         77Z1fNXyjRmJUDNN5Pzkp/Pp2bTz055p4zEf0/MDiTZPWUE+pzO070WQJ0V6MIVyt7QP
         eyCEJRgCihnwrJRQrFc6piFexWlC2E9NJyoQHyrRpllAyq1p9eEYmIqLGvpnmEFU1Sq3
         QvVJJY4zneOB7yCf8Po56gMoT66KiZ8VATVYd7554ezE797r+08gN7b1Bv3m9LfCcWbW
         XS9ogZ/CTvk+JxGmpZFdyJLk+3wqYoB0QB7sw4GFwN+U3UC/Wt8RkfG0NwKix74CLd0t
         9Okg==
X-Forwarded-Encrypted: i=1; AJvYcCXJbp4i3EVce0FXgOMJHWmN23p6cKqUK+nC2npi6N8PE4qpycmyTRffoNlQo+QSPcrn1KD/RGICAderuiXSfosOoDieEFkTXPVJ8p8NdLVI
X-Gm-Message-State: AOJu0Yyi7iaCfVYZKZAYTLlNlGgRfOHxerdvRZsRhtE8sy0o9XNnUFvE
	YzHRhknw9dOTq+iZQDktrpMciwfWGjf4DUmChoZMXfSQvTzOz/XtBALFS+VfzIncR3ExZZO9yhC
	02g==
X-Google-Smtp-Source: AGHT+IEzVv8xhsgMwJ9s01BpWKMedisC/JJ+Jv3539Rjq2P8BFX38qPyDM2NqZVs8iG+8eOnrpx1JA2POj8=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a17:902:e806:b0:1e3:cf18:7346 with SMTP id
 u6-20020a170902e80600b001e3cf187346mr532098plg.5.1712670023226; Tue, 09 Apr
 2024 06:40:23 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:57 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-5-pgonda@google.com>
Subject: [PATCH 4/6] Add GHCB allocations and helpers
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add GHCB management functionality similar to the ucall management.
Allows for selftest vCPUs to acquire GHCBs for their usage.

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
 .../selftests/kvm/lib/x86_64/processor.c      |  8 ++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 77 +++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 8a1bf88474c9..bfd481707f67 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -27,6 +27,8 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+int ghcb_nr_pages_required(uint64_t page_size);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 49288fe10cd3..fd94a1bd82c9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -584,6 +584,14 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 		sev_es_vm_init(vm);
 }
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape, uint64_t page_size)
+{
+	if (shape.subtype == VM_SUBTYPE_SEV_ES)
+		return  ghcb_nr_pages_required(page_size);
+
+	return 0;
+}
+
 void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e248d3364b9c..27ae1d3b1355 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -4,6 +4,80 @@
 #include <stdbool.h>
 
 #include "sev.h"
+#include "linux/bitmap.h"
+#include "svm.h"
+#include "svm_util.h"
+
+struct ghcb_entry {
+	struct ghcb ghcb;
+
+	/* Guest physical address of this GHCB. */
+	void *gpa;
+
+	/* Host virtual address of this struct. */
+	struct ghcb_entry *hva;
+};
+
+struct ghcb_header {
+	struct ghcb_entry ghcbs[KVM_MAX_VCPUS];
+	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
+};
+
+static struct ghcb_header *ghcb_pool;
+
+int ghcb_nr_pages_required(uint64_t page_size)
+{
+	return align_up(sizeof(struct ghcb_header), page_size) / page_size;
+}
+
+void ghcb_init(struct kvm_vm *vm)
+{
+	struct ghcb_header *hdr;
+	struct ghcb_entry *entry;
+	vm_vaddr_t vaddr;
+	int i;
+
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
+				      MEM_REGION_DATA);
+	hdr = (struct ghcb_header *)addr_gva2hva(vm, vaddr);
+	memset(hdr, 0, sizeof(*hdr));
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		entry = &hdr->ghcbs[i];
+		entry->hva = entry;
+		entry->gpa = addr_hva2gpa(vm, &entry->ghcb);
+	}
+
+	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
+}
+
+static struct ghcb_entry *ghcb_alloc(void)
+{
+	return &ghcb_pool->ghcbs[0];
+	struct ghcb_entry *entry;
+	int i;
+
+	if (!ghcb_pool)
+		goto ucall_failed;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
+			entry = &ghcb_pool->ghcbs[i];
+			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
+			return entry;
+		}
+	}
+
+ucall_failed:
+	return NULL;
+}
+
+static void ghcb_free(struct ghcb_entry *entry)
+{
+	/* Beware, here be pointer arithmetic.  */
+	clear_bit(entry - ghcb_pool->ghcbs, ghcb_pool->in_use);
+}
+
 
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
@@ -44,6 +118,9 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	struct kvm_sev_guest_status status;
 	int ctr;
 
+	if (policy & SEV_POLICY_ES)
+		ghcb_init(vm);
+
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 
-- 
2.44.0.478.gd926399ef9-goog


