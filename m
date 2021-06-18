Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C03AD50D
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhFRW31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhFRW30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 18:29:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EFC0617A6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a2-20020ad441c20000b0290251bb08ce61so5455093qvq.19
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JYI4qyPp6Ajd/JWkwOOiVCTCPjtCHH5+i1o7EQ+TA0M=;
        b=ZDoSGipCJRKnx4ybX85WazVkyv43WR6jQjn0sOXeETMDjhFnygc2FWjLNGy63kWz+U
         rueKq1yl6ULypPnHYLUPGJ3r9MqYebPG7YnTO4a+QMUUuIKB5nYQpl0XNbIXYXjj5GCw
         TDgPBknyw1vKLT7BrAhYtwr7iDKWaPU5LIVnJ53cYVxbyvnNGeqG971QPxwElCUN+5Ce
         U8NNeLIvDooIH8F8QXlSvMCCRF2cF4N893QhtMefnvtJPJRY6K8Y5GH+KfhvButlgRtX
         Jw2KSiKLo/Jzy0QixO3g3tv8PXmj+S4X3/24GQ/kDOWLRQN1M3Cf934BDKwYnN2jPfRS
         pzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JYI4qyPp6Ajd/JWkwOOiVCTCPjtCHH5+i1o7EQ+TA0M=;
        b=VsfkjT0J2x5dL8QRh/OR9NS4TWgWX2f666JrQkwuI3Tgp0PT8m+ZVLjs0jFe1etW2E
         V4q+zt8A32/B6mstt78GCvgN+5guMuhc56bSUcBedOMiqeLHu19pN9JYWHexaAlpnPn6
         s4+ho+0KivlWT6Icg9agrBfN7hQicWWPueV8e0kkbjsQcMUojIq/xvP0FP4NYDW+IxAj
         jRwuG30SKtmzBNNDL96kUtItjsL9cPVVf/Se/YiisqD1mnux0w+F9LKj62a5iXfInj6k
         2VpeRwjZU2zGaMoGvgfu3sE0B7xUm9SnEAYGwr/Vpjs5VAabrqXcHuX622VX+amLgrFr
         q7tg==
X-Gm-Message-State: AOAM532AxKJCCdcA/x1u2z2DtMFFCJeiJ9ZeRro72jdL3+4MEyfoGbEW
        i8ywwsvd8VO4ZlJhwhrIKkH9iRVREhwDzcv4iQ==
X-Google-Smtp-Source: ABdhPJw9BusY6QSygIliCIK9jFihHFP1rR6rsYj8uY63CBgx2PxvplzR8w7oRCI3wO+nUDDcAwKXbJu+Q0InMGpJOQ==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a25:aad4:: with SMTP id
 t78mr15524449ybi.266.1624055235841; Fri, 18 Jun 2021 15:27:15 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:27:04 +0000
In-Reply-To: <20210618222709.1858088-1-jingzhangos@google.com>
Message-Id: <20210618222709.1858088-3-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v12 2/7] KVM: stats: Add fd-based API to read binary stats data
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit defines the API for userspace and prepare the common
functionalities to support per VM/VCPU binary stats data readings.

The KVM stats now is only accessible by debugfs, which has some
shortcomings this change series are supposed to fix:
1. The current debugfs stats solution in KVM could be disabled
   when kernel Lockdown mode is enabled, which is a potential
   rick for production.
2. The current debugfs stats solution in KVM is organized as "one
   stats per file", it is good for debugging, but not efficient
   for production.
3. The stats read/clear in current debugfs solution in KVM are
   protected by the global kvm_lock.

Besides that, there are some other benefits with this change:
1. All KVM VM/VCPU stats can be read out in a bulk by one copy
   to userspace.
2. A schema is used to describe KVM statistics. From userspace's
   perspective, the KVM statistics are self-describing.
3. With the fd-based solution, a separate telemetry would be able
   to read KVM stats in a less privileged environment.
4. After the initial setup by reading in stats descriptors, a
   telemetry only needs to read the stats data itself, no more
   parsing or setup is needed.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com> #arm64
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/Makefile   |   2 +-
 arch/mips/kvm/Makefile    |   2 +-
 arch/powerpc/kvm/Makefile |   2 +-
 arch/s390/kvm/Makefile    |   3 +-
 arch/x86/kvm/Makefile     |   2 +-
 include/linux/kvm_host.h  | 151 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h  |  73 ++++++++++++++++++
 virt/kvm/binary_stats.c   | 144 ++++++++++++++++++++++++++++++++++++
 8 files changed, 374 insertions(+), 5 deletions(-)
 create mode 100644 virt/kvm/binary_stats.c

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 589921392cb1..989bb5dad2c8 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_KVM) += hyp/
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
-	 $(KVM)/vfio.o $(KVM)/irqchip.o \
+	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
 	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 30cc060857c7..c67250a956b8 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -2,7 +2,7 @@
 # Makefile for KVM support for MIPS
 #
 
-common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o)
+common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o binary_stats.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 2bfeaa13befb..b347d043b932 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -6,7 +6,7 @@
 ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
 KVM := ../../../virt/kvm
 
-common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o
+common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 common-objs-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
 common-objs-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 12decca22e7c..b3aaadc60ead 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -4,7 +4,8 @@
 # Copyright IBM Corp. 2008
 
 KVM := ../../../virt/kvm
-common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
+common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o \
+	      $(KVM)/irqchip.o $(KVM)/vfio.o $(KVM)/binary_stats.o
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 83331376b779..75dfd27b6e8a 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -11,7 +11,7 @@ KVM := ../../../virt/kvm
 
 kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
 				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o \
-				$(KVM)/dirty_ring.o
+				$(KVM)/dirty_ring.o $(KVM)/binary_stats.o
 kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5a31e0696360..30434be38858 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1272,6 +1272,12 @@ struct kvm_stats_debugfs_item {
 	int mode;
 };
 
+#define KVM_STATS_NAME_SIZE     48
+struct _kvm_stats_desc {
+	struct kvm_stats_desc desc;
+	char name[KVM_STATS_NAME_SIZE];
+};
+
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
@@ -1285,8 +1291,153 @@ struct kvm_stats_debugfs_item {
 	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
 	  KVM_STAT_VCPU, ## __VA_ARGS__ }
 
+#define STATS_DESC_COMMON(type, unit, base, exp)			       \
+	.flags = type | unit | base |					       \
+		 BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |	       \
+		 BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	       \
+		 BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),	       \
+	.exponent = exp,						       \
+	.size = 1
+
+#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vm_stat, generic.stat)   \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VM_STATS_DESC(stat, type, unit, base, exp)			       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vm_stat, stat)	       \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VCPU_STATS_DESC(stat, type, unit, base, exp)			       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vcpu_stat, stat)	       \
+		},							       \
+		.name = #stat,						       \
+	}
+/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
+#define STATS_DESC(SCOPE, stat, type, unit, base, exp)			       \
+	SCOPE##_STATS_DESC(stat, type, unit, base, exp)
+
+#define STATS_DESC_CUMULATIVE(SCOPE, name, unit, base, exponent)	       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE, unit, base, exponent)
+#define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)		       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)
+#define STATS_DESC_PEAK(SCOPE, name, unit, base, exponent)		       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_PEAK, unit, base, exponent)
+
+/* Cumulative read/write counter */
+#define STATS_DESC_COUNTER(SCOPE, name)					       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous read only counter */
+#define STATS_DESC_ICOUNTER(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous read/write counter */
+#define STATS_DESC_PCOUNTER(SCOPE, name)				       \
+	STATS_DESC_PEAK(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+
+/* Cumulative clock cycles */
+#define STATS_DESC_CYCLE(SCOPE, name)					       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_CYCLES,	       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous clock cycles */
+#define STATS_DESC_ICYCLE(SCOPE, name)					       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_CYCLES,		       \
+		KVM_STATS_BASE_POW10, 0)
+
+/* Cumulative memory size in Byte */
+#define STATS_DESC_SIZE_BYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 0)
+/* Cumulative memory size in KiByte */
+#define STATS_DESC_SIZE_KBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 10)
+/* Cumulative memory size in MiByte */
+#define STATS_DESC_SIZE_MBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 20)
+/* Cumulative memory size in GiByte */
+#define STATS_DESC_SIZE_GBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 30)
+
+/* Instantaneous memory size in Byte */
+#define STATS_DESC_ISIZE_BYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 0)
+/* Instantaneous memory size in KiByte */
+#define STATS_DESC_ISIZE_KBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 10)
+/* Instantaneous memory size in MiByte */
+#define STATS_DESC_ISIZE_MBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 20)
+/* Instantaneous memory size in GiByte */
+#define STATS_DESC_ISIZE_GBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 30)
+
+/* Cumulative time in second */
+#define STATS_DESC_TIME_SEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, 0)
+/* Cumulative time in millisecond */
+#define STATS_DESC_TIME_MSEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -3)
+/* Cumulative time in microsecond */
+#define STATS_DESC_TIME_USEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -6)
+/* Cumulative time in nanosecond */
+#define STATS_DESC_TIME_NSEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -9)
+
+/* Instantaneous time in second */
+#define STATS_DESC_ITIME_SEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous time in millisecond */
+#define STATS_DESC_ITIME_MSEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -3)
+/* Instantaneous time in microsecond */
+#define STATS_DESC_ITIME_USEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -6)
+/* Instantaneous time in nanosecond */
+#define STATS_DESC_ITIME_NSEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -9)
+
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
+ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
+		       const struct _kvm_stats_desc *desc,
+		       void *stats, size_t size_stats,
+		       char __user *user_buffer, size_t size, loff_t *offset);
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9febe1412f7a..703b44316fd4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1086,6 +1086,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENFORCE_CPUID 199
 #define KVM_CAP_SREGS2 200
 #define KVM_CAP_EXIT_HYPERCALL 201
+#define KVM_CAP_BINARY_STATS_FD 202
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1905,4 +1906,76 @@ struct kvm_dirty_gfn {
 #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
+/**
+ * struct kvm_stats_header - Header of per vm/vcpu binary statistics data.
+ * @flags: Some extra information for header, always 0 for now.
+ * @name_size: The size in bytes of the memory which contains statistics
+ *             name string including trailing '\0'. The memory is allocated
+ *             at the send of statistics descriptor.
+ * @num_desc: The number of statistics the vm or vcpu has.
+ * @id_offset: The offset of the vm/vcpu stats' id string in the file pointed
+ *             by vm/vcpu stats fd.
+ * @desc_offset: The offset of the vm/vcpu stats' descriptor block in the file
+ *               pointd by vm/vcpu stats fd.
+ * @data_offset: The offset of the vm/vcpu stats' data block in the file
+ *               pointed by vm/vcpu stats fd.
+ *
+ * This is the header userspace needs to read from stats fd before any other
+ * readings. It is used by userspace to discover all the information about the
+ * vm/vcpu's binary statistics.
+ * Userspace reads this header from the start of the vm/vcpu's stats fd.
+ */
+struct kvm_stats_header {
+	__u32 flags;
+	__u32 name_size;
+	__u32 num_desc;
+	__u32 id_offset;
+	__u32 desc_offset;
+	__u32 data_offset;
+};
+
+#define KVM_STATS_TYPE_SHIFT		0
+#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_PEAK		(0x2 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_PEAK
+
+#define KVM_STATS_UNIT_SHIFT		4
+#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
+
+#define KVM_STATS_BASE_SHIFT		8
+#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
+
+/**
+ * struct kvm_stats_desc - Descriptor of a KVM statistics.
+ * @flags: Annotations of the stats, like type, unit, etc.
+ * @exponent: Used together with @flags to determine the unit.
+ * @size: The number of data items for this stats.
+ *        Every data item is of type __u64.
+ * @offset: The offset of the stats to the start of stat structure in
+ *          struture kvm or kvm_vcpu.
+ * @unused: Unused field for future usage. Always 0 for now.
+ * @name: The name string for the stats. Its size is indicated by the
+ *        &kvm_stats_header->name_size.
+ */
+struct kvm_stats_desc {
+	__u32 flags;
+	__s16 exponent;
+	__u16 size;
+	__u32 offset;
+	__u32 unused;
+	char name[];
+};
+
+#define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
new file mode 100644
index 000000000000..fbc148a0e6c9
--- /dev/null
+++ b/virt/kvm/binary_stats.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM binary statistics interface implementation
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+
+/**
+ * kvm_stats_read() - Common vm/vcpu stats read function to userspace.
+ * @id: identification string of the stats
+ * @header: stats header for a vm or a vcpu
+ * @desc: start address of an array of stats descriptors for a vm or a vcpu
+ * @stats: start address of stats data block for a vm or a vcpu
+ * @size_stats: the size of stats data block pointed by @stats
+ * @user_buffer: start address of userspace buffer
+ * @size: requested read size from userspace
+ * @offset: the start position from which the content will be read for the
+ *          corresponding vm or vcp file descriptor
+ *
+ * The file content of a vm/vcpu file descriptor is now defined as below:
+ * +-------------+
+ * |   Header    |
+ * +-------------+
+ * |  id string  |
+ * +-------------+
+ * | Descriptors |
+ * +-------------+
+ * | Stats Data  |
+ * +-------------+
+ * Although this function allows userspace to read any amount of data (as long
+ * as in the limit) from any position, the typical usage would follow below
+ * steps:
+ * 1. Read header from offset 0. Get the offset of descriptors and stats data
+ *    and some other necessary information. This is a one-time work for the
+ *    lifecycle of the corresponding vm/vcpu stats fd.
+ * 2. Read id string from its offset. This is a one-time work for the lifecycle
+ *    of the corresponding vm/vcpu stats fd.
+ * 3. Read descriptors from its offset and discover all the stats by parsing
+ *    descriptors. This is a one-time work for the lifecycle of the
+ *    corresponding vm/vcpu stats fd.
+ * 4. Periodically read stats data from its offset using pread.
+ *
+ * Return: the number of bytes that has been successfully read
+ */
+ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
+		       const struct _kvm_stats_desc *desc,
+		       void *stats, size_t size_stats,
+		       char __user *user_buffer, size_t size, loff_t *offset)
+{
+	ssize_t len;
+	ssize_t copylen;
+	ssize_t remain = size;
+	size_t size_desc;
+	size_t size_header;
+	void *src;
+	loff_t pos = *offset;
+	char __user *dest = user_buffer;
+
+	size_header = sizeof(*header);
+	size_desc = header->num_desc * sizeof(*desc);
+
+	len = KVM_STATS_NAME_SIZE + size_header + size_desc + size_stats - pos;
+	len = min(len, remain);
+	if (len <= 0)
+		return 0;
+	remain = len;
+
+	/*
+	 * Copy kvm stats header.
+	 * The header is the first block of content userspace usually read out.
+	 * The pos is 0 and the copylen and remain would be the size of header.
+	 * The copy of the header would be skipped if offset is larger than the
+	 * size of header. That usually happens when userspace reads stats
+	 * descriptors and stats data.
+	 */
+	copylen = size_header - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = (void *)header + pos;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	/*
+	 * Copy kvm stats header id string.
+	 * The id string is unique for every vm/vcpu, which is stored in kvm
+	 * and kvm_vcpu structure.
+	 * The id string is part of the stat header from the perspective of
+	 * userspace, it is usually read out together with previous constant
+	 * header part and could be skipped for later descriptors and stats
+	 * data readings.
+	 */
+	copylen = size_header + KVM_STATS_NAME_SIZE - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = id + pos - size_header;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	/*
+	 * Copy kvm stats descriptors.
+	 * The descriptors copy would be skipped in the typical case that
+	 * userspace periodically read stats data, since the pos would be
+	 * greater than the end address of descriptors
+	 * (header->header.desc_offset + size_desc) causing copylen <= 0.
+	 */
+	copylen = header->desc_offset + size_desc - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = (void *)desc + pos - header->desc_offset;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	/* Copy kvm stats values */
+	copylen = header->data_offset + size_stats - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = stats + pos - header->data_offset;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	*offset = pos;
+	return len;
+}
-- 
2.32.0.288.g62a8d224e6-goog

