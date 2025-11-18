Return-Path: <linux-kselftest+bounces-45889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 498D8C6ADF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3C1FF2CCDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF131ED8D;
	Tue, 18 Nov 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkTCh3q1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F331ED74
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485895; cv=none; b=a8uZL7SGXHmjvgqW6z8BmR28JRCi7eOhf2oW/jWmEXNI0nBsMHES4/i3/rQDla+xjAXprIe7vxv6mM/kNIRv4cSI0ukvaZ6lYlU6BPFWF+QtmGAuHLvIvDhcv3qvCNYtQaNFUcePG5SP3bzHnOw4shFaD7/TPf28wtKduhiNn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485895; c=relaxed/simple;
	bh=qOLV8Bi1e4ENQ+HKeqe/SRVss1oeBj0jwvM6TksA9Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAW9LFkkjlq1YO7q2WuZ7L8PHOGxqll31d6x1z5w9kWP3zLej35dcQfUMbz0yriM++umEAgZqR/upWVYz4ZyB8QsDuVKYVP74SBlYmWDQPdIA81Kj8qLYl/VfbHpZk/IMhhh+Eq/EH3DSTJkjxzghJdybiku2Xb+cGgJ/rO8Zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkTCh3q1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so35240885e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485891; x=1764090691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69iXRF+UJC1hs3xkkz0CKthrLlBOVoAMZk7s5v+Iu2k=;
        b=WkTCh3q1TYT8VkIdZcv5yL7DGt9e3TOWL97uUgd56AhSBpljzINiIwj4EXhFqtGqd8
         ZApYnrcDsbwiyPQtlQwXLgWm94Ri8aOZxk6jpq5NwcKYDv5wylzm2oomUl4X/d2L3o0A
         DnWo7q/xUJUscKQI0rw2lhi2Vsw2PrrtMRNNQFcTHdCs0zkwhA2EtRZbb4/T0WrNqwIR
         UYLKazCRkVccbvLwE52+wKMX5etZdfaVRu+LX1DGWiNd85CFJmSMkQLhi6gGwZqUW3kR
         dcGIBZtSLy+951J4F8aL6TnuyPGLmRpFS+bqg8mbFWeGTZ/XItjIa6IBtyBT6gJWKh1L
         f2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485891; x=1764090691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69iXRF+UJC1hs3xkkz0CKthrLlBOVoAMZk7s5v+Iu2k=;
        b=rq4D2us1EhCzsdVpKRYQuOnJChP4yNPYKBbsBdBIjEpoR4Ow6zl0oaVVuiTehc+d37
         UMnRYdVbK2gaYxPIpe5xmWgGYDZe8Rlw5d5Zh0CZ4RvbElw2o9kyMMm+sFUoHHWsQuTY
         6221vH73+9D7Ui3B2wooxBo13o+0Iix7chjEWsRjVerTsHUq79az/m9u2Mb/s82m6irE
         FX4FD7QxLnnMy/cjLkuS6aCq75tzfkyrb1ORPaHSXy43p6xuwi+cl+6m/0U4FcXvX9bd
         NWq2jJFGvwOLeiOkwPuZXPAFt7oXiYMuIELqnEPIhch++0lwE69v+yFG6TkGjTMBxPx6
         17Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXxozsdRqe9Xy5e6yx//MlWVT+1zFOGjz7IDKoJOQG+RWiN8/8iBEtiLQhUb06JiZwUcGcwXkVxPsdg2gbNk00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfwRLPCae2CwFYdz7sXCJShGgrWh6Ki9npK6zaM0rgdQfZ7rT
	7neNChJd/7oHzb9TPUfC8X2gOLsJieRlf6CFHLq4tCKIsVog5cc1xVNTqnHyRHbhNdZZxQ==
X-Gm-Gg: ASbGncuimZDQcUmigN9XaS4VMFnficSknjq9efNkcEv30wnWmTC6hVTGd/wU66DQiA4
	2ZM7+bs1V0sxrShpjGwOQdX71dCqHXPuYeKouyVQXNbdi8asRo6Wk6NfI2IOcK7ycmCHvYYechu
	HJmSH+asalQPAkJ/4XUX2DkQG4YCnnFHMUL75dgxuE/pi59buoqGsS3wsuFRwpO+XomXVd64/3V
	4UM5fiewgLtn74kUo5OxNBnMzspTf20Lun82AJqyQ82f9yU/jNEX1pk/lSxnFcTTXDG2OtM8gEY
	1SoL7tBznmW3keTsIq+RTvr6nWGSPyXBQR/iDbU9P6S4FdyUg7aChWdtSIROgwDlhKWnPmrlxrr
	6NLkNry7/1bufldckgm1nWGRD1/gd9EX4K4IGPcKXnmJEXadzYHtEiDoGymN689Go6RJvGRew3U
	iS0JNdjDCnmWyR2lboTmOmCUxrjJdfmU40rWW8wBKT792aysOp4d/zox5uEINNw6SFJRPDGHli1
	KQZBVNB2kB4HOpsUUZaAI9W4D8v+CxTz9TWJpHafIs=
X-Google-Smtp-Source: AGHT+IFe10O1HbN8XBISm2rDJQYB2sWUAALs7N+f2tKf49wh6KXWZD3EXSl0Z/nwQeJNMFeLXzIjZQ==
X-Received: by 2002:a05:600c:a04:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4778fe5dccdmr193648735e9.16.1763485891125;
        Tue, 18 Nov 2025 09:11:31 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103d312sm706385e9.13.2025.11.18.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:11:30 -0800 (PST)
From: griffoul@gmail.com
X-Google-Original-From: griffoul@gmail.org
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v2 08/10] KVM: x86: Add nested context management
Date: Tue, 18 Nov 2025 17:11:11 +0000
Message-ID: <20251118171113.363528-9-griffoul@gmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118171113.363528-1-griffoul@gmail.org>
References: <20251118171113.363528-1-griffoul@gmail.org>
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
index 000000000000..6e4e95567427
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
+		return false;
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


