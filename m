Return-Path: <linux-kselftest+bounces-46217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5EC78B4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BAB4EB2E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4434678A;
	Fri, 21 Nov 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hju2Hlra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11634BA54
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723502; cv=none; b=FJFrCXfdWGerR40f3RQBGmyOBtuaui+e5EMxVEq6BH3IHj+t64WOUoYmpGOkhqNLIJrifak0x+D8Y3ac8/1zaCXnPYConJOiOI55CrgiwU4vN0u2Pgh2Lvn1DTV0bW7jfqDPB78gcr8CdwRFMUPKUKKwvxRbaDJy6Nr7HjCGRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723502; c=relaxed/simple;
	bh=IuqcEOEbe0+RixX82HnLhcdMi0Mf/0K4mfVR0f073pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfHPMTyjQR5+iUQkJi9cw01w1oY+RvQYpyCGes/N74lFQ+7aafS34HqcIeOUa0DoJwJkQusIjaxC00HkJLptCRCjkpmwikkvcO0eK2ewe0jXXFV96cTQC6f9UluNVAcj/LDp92vwEWT+5xv6Be0yaamtEKdwyVdnGhJmsncjtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hju2Hlra; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso1133002f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723495; x=1764328295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwlQx/OWwadt7gEx5Aj743IyAAkdjmoKIV+Gyuhnzno=;
        b=hju2HlraMTKxSAOEj+aejdFRCSCrnjPAb5+PNCWzEmHxEORtWGEg6qugUO+n4duIWa
         w33OGBh6w0s4EYPl4JuQbg9EWD9X3FpDvdzXdtVzLFMSwclpPZXKIGhY8Rltp5XBvGzC
         q3wy7sx9km3FpWLvGLRFwtQAYBxyUbqQigFBqU41p1YNOeBWaDNQhZstu9LP2onEsys8
         8jVlKnhJadzMXp48BQeZYdeRoU7QTjqtsdDQAPC1yBPY5N5XZO8xqm7DQglH4w03LQ44
         BLsfmtLyHEnbpqD7VfRipaJlbISsVcFpgvRF+QszkI/qF1R68gs46q60OiMWC09CGqQk
         HAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723495; x=1764328295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwlQx/OWwadt7gEx5Aj743IyAAkdjmoKIV+Gyuhnzno=;
        b=OQMDPzTckCgcF+pEFkrhDV9LaU6PcE8Y23LpUp1MXbcrShetIaQufYt2HCDl/iCT1M
         rhkRN+qXDUYRDEfGhpTj4zm3E/KBLKYSrv5PAx2+8tQB6STwlYzDZaWNJ1UfUQRVZJFE
         YMDGiM0CDJr6ao/MIKu7bacYZbWVUJh1Y35M4saFxkTXSglbUNmO7DCd9O9fDNyfjR9y
         1wEAKXh8yQn/v7fLlVj22iLJ1b8YKppgOT2mGN5wIBFaNtuQoltS1inpGN4In5QsBbxC
         XsyPh0qAtjbZZiCNWNnBwpUt9RgGXhZb/SdvV+/6gbWGw2MljuLK6LpZDxXc5YBmFxkN
         O6Og==
X-Forwarded-Encrypted: i=1; AJvYcCU4Q75yd128K2lHA7XRlVdbg026RRBYJ7DmD1oOtPYHcAfUizV/Tqtw9AvrRscNOxx3hdnvcx1jy1d37AYQE2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9idyuiN/jTKuZKAyTXOiOOo5vFnYrCkC2ns/4QlGwjBDg5X8
	j+WC24jj8aMvFuXZvD5XhBy0QmKfvFS66rFxIO0J9k7aCtKTiMeoazLZ
X-Gm-Gg: ASbGnctKVK7D/Zek6w/miAJvnLcBcg1DcdE6tlWUUtjARhCXBVUGn7Z5n/QTGKsSitt
	cbIpq10JRY08I7kM81NEggFN3WFggw6vohog7Yc1vu33mKWUWhjAQxVIJyqgy9YtPsREBSQxXTt
	6YJMkpxBU5oQVpB/hNemIisrvEnjBGdEtAKiZ27uG6B62o/7fm6cFKvXmIRRBEapSZo/SIHuwo/
	r1yNIF7jhHO6FD/2ksR8tw8FUiqZk3jJ7zRXjoNZYdLux35WOM6CZDDvB+A/VTlKvOgq4Tytf6o
	quir7IDR+3ZP1HkUHduZYCdzcVIqjy3CwcnHpOzSd3I9eDbYoU94R3n8oMMJcjye/2zCwxR+AS9
	cYQ+IvKuNMl4cp54bY0wA6qx6+9eGEQnj1OQHTqVwaAUHHgepXasJa4hkmtjfaltwWrSe0rp/nN
	Ywi9mTFCUuMbA1dtffR0TvIOHC0NUrIcxbrz+Wzexe/T2KyJM0JMLnfirTz3ZyvOJLMyMGPaGhj
	NwerCvkGrU4e6rHVLibYh71zOpdTgqp
X-Google-Smtp-Source: AGHT+IHVJpc9/f8dm4MnHiPG8rhAYbdabzUczXwVfUZb1zuYY7xjGjgQXaM7mOC9X5Auu/VvvvBTgQ==
X-Received: by 2002:a05:6000:1789:b0:42b:40b5:e64c with SMTP id ffacd0b85a97d-42cc1d0c3bdmr1976326f8f.30.1763723494827;
        Fri, 21 Nov 2025 03:11:34 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:34 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v3 08/10] KVM: x86: Add nested context management
Date: Fri, 21 Nov 2025 11:11:11 +0000
Message-ID: <20251121111113.456628-9-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Add infrastructure to persist nested virtualization state when L2 vCPUs
are switched on an L1 vCPU or migrated between L1 vCPUs.

The nested context table uses a hash table for fast lookup by nested
control block GPA (VMPTR for VMX, VMCB for SVM) and maintains a free
list for context management.

The kvm_nested_context_load() function searches for a context indexed by
the target GPA; if not found, it allocates a new context up to the
configured maximum. If at capacity, it recycles the oldest context from
the free list.

The oversubscription is hardcoded to support up to 8 L2 vCPUs per L1
vCPU.

The kvm_nested_context_clear() function moves the context to the free
list while keeping it in the hash table for potential reuse.

This allows nested hypervisors to multiplex multiple L2 vCPUs on L1
vCPUs without losing cached nested state, significantly improving
performance for workloads with frequent L2 context switches.

This patch adds the basic infrastructure. Subsequent patches will add
the nested VMX and SVM specific support to populate and utilize the
cached nested state.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  31 +++++
 arch/x86/include/uapi/asm/kvm.h |   2 +
 arch/x86/kvm/Makefile           |   2 +-
 arch/x86/kvm/nested.c           | 199 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |   5 +-
 5 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kvm/nested.c

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4675e71b33a7..75f3cd82a073 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1379,6 +1379,28 @@ enum kvm_mmu_type {
 	KVM_NR_MMU_TYPES,
 };
 
+struct kvm_nested_context {
+	gpa_t gpa;
+	struct hlist_node hnode;
+	struct list_head lru_link;
+	struct kvm_vcpu *vcpu;
+};
+
+struct kvm_nested_context_table {
+	spinlock_t lock;
+	u32 count;
+	struct list_head lru_list;
+	DECLARE_HASHTABLE(hash, 8);
+};
+
+void kvm_nested_context_clear(struct kvm_vcpu *vcpu, gpa_t gpa);
+struct kvm_nested_context *kvm_nested_context_load(
+		struct kvm_vcpu *vcpu,
+		gpa_t gpa);
+
+int kvm_nested_context_table_init(struct kvm *kvm);
+void kvm_nested_context_table_destroy(struct kvm *kvm);
+
 struct kvm_arch {
 	unsigned long n_used_mmu_pages;
 	unsigned long n_requested_mmu_pages;
@@ -1618,6 +1640,9 @@ struct kvm_arch {
 	 * current VM.
 	 */
 	int cpu_dirty_log_size;
+
+	/* Cache for nested contexts */
+	struct kvm_nested_context_table *nested_context_table;
 };
 
 struct kvm_vm_stat {
@@ -1640,6 +1665,8 @@ struct kvm_vm_stat {
 	u64 nx_lpage_splits;
 	u64 max_mmu_page_hash_collisions;
 	u64 max_mmu_rmap_size;
+	u64 nested_context_recycle;
+	u64 nested_context_reuse;
 };
 
 struct kvm_vcpu_stat {
@@ -1967,6 +1994,10 @@ struct kvm_x86_nested_ops {
 			    uint16_t *vmcs_version);
 	uint16_t (*get_evmcs_version)(struct kvm_vcpu *vcpu);
 	void (*hv_inject_synthetic_vmexit_post_tlb_flush)(struct kvm_vcpu *vcpu);
+
+	struct kvm_nested_context *(*alloc_context)(struct kvm_vcpu *vcpu);
+	void (*free_context)(struct kvm_nested_context *ctx);
+	void (*reset_context)(struct kvm_nested_context *ctx);
 };
 
 struct kvm_x86_init_ops {
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index d420c9c066d4..637ed9286f8e 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -1042,4 +1042,6 @@ struct kvm_tdx_init_mem_region {
 	__u64 nr_pages;
 };
 
+#define KVM_NESTED_OVERSUB_RATIO 8
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index c4b8950c7abe..2a5289cb5bd1 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -6,7 +6,7 @@ ccflags-$(CONFIG_KVM_WERROR) += -Werror
 include $(srctree)/virt/kvm/Makefile.kvm
 
 kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o pmu.o mtrr.o \
-			   debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o
+			   debugfs.o nested.o mmu/mmu.o mmu/page_track.o mmu/spte.o
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_IOAPIC) += i8259.o i8254.o ioapic.o
diff --git a/arch/x86/kvm/nested.c b/arch/x86/kvm/nested.c
new file mode 100644
index 000000000000..986820cb525f
--- /dev/null
+++ b/arch/x86/kvm/nested.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm_host.h>
+
+static struct kvm_nested_context_table *kvm_nested_context_table_alloc(void)
+{
+	struct kvm_nested_context_table *table;
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL_ACCOUNT);
+	if (!table)
+		return NULL;
+
+	spin_lock_init(&table->lock);
+	INIT_LIST_HEAD(&table->lru_list);
+	hash_init(table->hash);
+	return table;
+}
+
+static void kvm_nested_context_table_free(struct kvm_nested_context_table
+					  *table)
+{
+	kfree(table);
+}
+
+int kvm_nested_context_table_init(struct kvm *kvm)
+{
+	struct kvm_nested_context_table *table;
+
+	if (!kvm_x86_ops.nested_ops->alloc_context ||
+	    !kvm_x86_ops.nested_ops->free_context ||
+	    !kvm_x86_ops.nested_ops->reset_context)
+		return -EINVAL;
+
+	table = kvm_nested_context_table_alloc();
+	if (!table)
+		return -ENOMEM;
+
+	kvm->arch.nested_context_table = table;
+	return 0;
+}
+
+void kvm_nested_context_table_destroy(struct kvm *kvm)
+{
+	struct kvm_nested_context_table *table;
+	struct kvm_nested_context *ctx;
+	struct hlist_node *tmp;
+	int bkt;
+
+	table = kvm->arch.nested_context_table;
+	if (!table)
+		return;
+
+	hash_for_each_safe(table->hash, bkt, tmp, ctx, hnode) {
+		hash_del(&ctx->hnode);
+		kvm_x86_ops.nested_ops->free_context(ctx);
+	}
+
+	kvm_nested_context_table_free(table);
+}
+
+static unsigned int kvm_nested_context_max(struct kvm *kvm)
+{
+	return KVM_NESTED_OVERSUB_RATIO * atomic_read(&kvm->online_vcpus);
+}
+
+static struct kvm_nested_context *__kvm_nested_context_find(struct kvm_nested_context_table
+							    *table, gpa_t gpa)
+{
+	struct kvm_nested_context *ctx;
+
+	hash_for_each_possible(table->hash, ctx, hnode, gpa) {
+		if (ctx->gpa == gpa)
+			return ctx;
+	}
+
+	return NULL;
+}
+
+static struct kvm_nested_context *kvm_nested_context_find(struct
+							  kvm_nested_context_table
+							  *table,
+							  struct kvm_vcpu *vcpu,
+							  gpa_t gpa)
+{
+	struct kvm_nested_context *ctx;
+
+	ctx = __kvm_nested_context_find(table, gpa);
+	if (!ctx)
+		return NULL;
+
+	WARN_ON_ONCE(ctx->vcpu && ctx->vcpu != vcpu);
+
+	/* Remove from the LRU list if not attached to a vcpu */
+	if (!ctx->vcpu)
+		list_del(&ctx->lru_link);
+
+	return ctx;
+}
+
+static struct kvm_nested_context *kvm_nested_context_recycle(struct
+							     kvm_nested_context_table
+							     *table)
+{
+	struct kvm_nested_context *ctx;
+
+	if (list_empty(&table->lru_list))
+		return NULL;
+
+	ctx =
+	    list_first_entry(&table->lru_list, struct kvm_nested_context,
+			     lru_link);
+	list_del(&ctx->lru_link);
+	hash_del(&ctx->hnode);
+	return ctx;
+}
+
+static void kvm_nested_context_insert(struct kvm_nested_context_table *table,
+				      struct kvm_nested_context *ctx, gpa_t gpa)
+{
+	hash_add(table->hash, &ctx->hnode, gpa);
+	ctx->gpa = gpa;
+}
+
+struct kvm_nested_context *kvm_nested_context_load(struct kvm_vcpu *vcpu,
+						   gpa_t gpa)
+{
+	struct kvm_nested_context_table *table;
+	struct kvm_nested_context *ctx, *new_ctx = NULL;
+	struct kvm *vm = vcpu->kvm;
+	bool reset = false;
+
+	table = vcpu->kvm->arch.nested_context_table;
+	if (WARN_ON_ONCE(!table))
+		return NULL;
+retry:
+	spin_lock(&table->lock);
+	ctx = kvm_nested_context_find(table, vcpu, gpa);
+	if (!ctx) {
+		/* At capacity? Recycle the LRU context */
+		if (table->count >= kvm_nested_context_max(vcpu->kvm)) {
+			ctx = kvm_nested_context_recycle(table);
+			if (unlikely(!ctx))
+				goto finish;
+
+			kvm_nested_context_insert(table, ctx, gpa);
+			++vm->stat.nested_context_recycle;
+			reset = true;
+
+		} else if (new_ctx) {
+			++table->count;
+			ctx = new_ctx;
+			kvm_nested_context_insert(table, ctx, gpa);
+			new_ctx = NULL;
+
+		} else {
+			/* Allocate a new context without holding the lock */
+			spin_unlock(&table->lock);
+			new_ctx = kvm_x86_ops.nested_ops->alloc_context(vcpu);
+			if (unlikely(!new_ctx))
+				return NULL;
+
+			goto retry;
+		}
+	} else
+		++vm->stat.nested_context_reuse;
+
+	ctx->vcpu = vcpu;
+finish:
+	spin_unlock(&table->lock);
+
+	if (new_ctx)
+		kvm_x86_ops.nested_ops->free_context(new_ctx);
+
+	if (reset)
+		kvm_x86_ops.nested_ops->reset_context(ctx);
+
+	return ctx;
+}
+
+void kvm_nested_context_clear(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	struct kvm_nested_context_table *table;
+	struct kvm_nested_context *ctx;
+
+	table = vcpu->kvm->arch.nested_context_table;
+	if (WARN_ON_ONCE(!table))
+		return;
+
+	spin_lock(&table->lock);
+	ctx = __kvm_nested_context_find(table, gpa);
+	if (ctx && ctx->vcpu) {
+		/*
+		 * Move to LRU list but keep it in the hash table for possible future
+		 * reuse.
+		 */
+		list_add_tail(&ctx->lru_link, &table->lru_list);
+		ctx->vcpu = NULL;
+	}
+	spin_unlock(&table->lock);
+}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a9c1171df49..db13b1921aff 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -255,7 +255,9 @@ const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_ICOUNTER(VM, pages_1g),
 	STATS_DESC_ICOUNTER(VM, nx_lpage_splits),
 	STATS_DESC_PCOUNTER(VM, max_mmu_rmap_size),
-	STATS_DESC_PCOUNTER(VM, max_mmu_page_hash_collisions)
+	STATS_DESC_PCOUNTER(VM, max_mmu_page_hash_collisions),
+	STATS_DESC_COUNTER(VM, nested_context_recycle),
+	STATS_DESC_COUNTER(VM, nested_context_reuse)
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
@@ -13311,6 +13313,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_page_track_cleanup(kvm);
 	kvm_xen_destroy_vm(kvm);
 	kvm_hv_destroy_vm(kvm);
+	kvm_nested_context_table_destroy(kvm);
 	kvm_x86_call(vm_destroy)(kvm);
 }
 
-- 
2.43.0


