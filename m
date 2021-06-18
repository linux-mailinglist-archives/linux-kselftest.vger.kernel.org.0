Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362E93AC27D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhFREug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhFREuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:50:35 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6600C061760
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n3-20020a0cee630000b029020e62abfcbdso4481313qvs.16
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bukdbRwMUSJYHcfC0g5wV3cuLtFARFPXL+QCNZB9HkI=;
        b=CFIxFC8Oo2hPcZjkU9vJdCcHlw1+GBkT1jqMwRNMaeEWeprKouL+E4o8Rm5l4I95G1
         I63xtcgDcDDmuw7WBl11o+R2N+5KK3XvWpah/ymAhHoNrLpwViq2ugHpadtTquQj3a1n
         doNT1IuSTXnWmYWhMniDcF8M4oURlwNNpP9MS1qlevmMlm6cceO6181J6BbtD448Sj61
         OWWcqFQO1xEVHLSmQgN6VmNNuFlkw80nSLn75kwG5BM3ofZgyE8Rmo5DgMci3uDhy6DN
         EDoK+n0kalckG7cbr81VtAuITJtoyrnii3sIV6rnWiboMXNN5n9qaa/ma76FAfLEpG5u
         8Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bukdbRwMUSJYHcfC0g5wV3cuLtFARFPXL+QCNZB9HkI=;
        b=Xjw0xE4qykfEtm04C0vxprZjAxjEGAwU8bNdaDFqAcPhMN6YCH//Xa+KefyYj36gJB
         9XUnaAtcSOfoUoOlyG6qpXusga3w75Dz1T+NPD8xPO+/+EGAN7NbAFR+F+5MACMjQMZ6
         z+MU41Hx+FhDPZkn19rwLuYht67U0FURQ1n99+wSzhMlFfrsYWMTmYmsqCPmPkMs+t5N
         qXz0iMHp7S6IfNYgt9MnhnvXXkWPyPpBAD0kDttB0Ce0Wk7FMAhHz3C3pHuyk8+4zct9
         edPQUWUyvV1ETk4w5n/eg1e1JFKRIB9QkeyNBXwoDEa95pgtoFlQaetsNyCkM/FM0UZ1
         U0MA==
X-Gm-Message-State: AOAM531+4lQt3Wd5m5aEkl/NutS730WHDz4tMnX6zvIbP5stAmXbaXc0
        SLeabUQAq/PGWY75d3usFUx7RIK69qUPyQtqjw==
X-Google-Smtp-Source: ABdhPJyyvmsW4L+DE66or+qFi6wsVVa2Blu1YmDiv7brHn1sfgvN1q4iXv46oIKGWEOjUuv9N1i8y9sA/mBvjQmVdA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a0c:f850:: with SMTP id
 g16mr3696140qvo.26.1623991705965; Thu, 17 Jun 2021 21:48:25 -0700 (PDT)
Date:   Fri, 18 Jun 2021 04:48:14 +0000
In-Reply-To: <20210618044819.3690166-1-jingzhangos@google.com>
Message-Id: <20210618044819.3690166-3-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats data
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
 include/linux/kvm_host.h  | 145 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h  |  42 +++++++++++
 virt/kvm/binary_stats.c   | 130 ++++++++++++++++++++++++++++++++++
 8 files changed, 323 insertions(+), 5 deletions(-)
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
index 5a31e0696360..2f0d12064ae7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1272,6 +1272,12 @@ struct kvm_stats_debugfs_item {
 	int mode;
 };
 
+#define KVM_STATS_NAME_LEN	48
+struct _kvm_stats_desc {
+	struct kvm_stats_desc desc;
+	char name[KVM_STATS_NAME_LEN];
+};
+
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
@@ -1285,8 +1291,147 @@ struct kvm_stats_debugfs_item {
 	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
 	  KVM_STAT_VCPU, ## __VA_ARGS__ }
 
+#define STATS_DESC_COMMON(type, unit, base, exp)			       \
+	.flags = type | unit | base |					       \
+	    BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |		       \
+	    BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |		       \
+	    BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),		       \
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
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE,		       \
+		      unit, base, exponent)
+#define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)		       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)  \
+
+/* Cumulative counter */
+#define STATS_DESC_COUNTER(SCOPE, name)					       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous counter */
+#define STATS_DESC_ICOUNTER(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
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
+ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
+		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
+		char __user *user_buffer, size_t size, loff_t *offset);
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9febe1412f7a..ab73e905105c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1086,6 +1086,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENFORCE_CPUID 199
 #define KVM_CAP_SREGS2 200
 #define KVM_CAP_EXIT_HYPERCALL 201
+#define KVM_CAP_BINARY_STATS_FD 202
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1905,4 +1906,45 @@ struct kvm_dirty_gfn {
 #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
+#define KVM_STATS_ID_MAXLEN		64
+
+struct kvm_stats_header {
+	__u32 name_size;
+	__u32 count;
+	__u32 desc_offset;
+	__u32 data_offset;
+	char id[];
+};
+
+#define KVM_STATS_TYPE_SHIFT		0
+#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
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
index 000000000000..1517e91d295b
--- /dev/null
+++ b/virt/kvm/binary_stats.c
@@ -0,0 +1,130 @@
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
+/*
+ * Common vm/vcpu stats read function to userspace.
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
+ * 2. Read descriptors from its offset and discover all the stats by parsing
+ *    descriptors. This is a one-time work for the lifecycle of the
+ *    corresponding vm/vcpu stats fd.
+ * 3. Periodically read stats data from its offset.
+ */
+ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
+		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
+		char __user *user_buffer, size_t size, loff_t *offset)
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
+	size_desc = header->count * sizeof(*desc);
+
+	len = KVM_STATS_ID_MAXLEN + size_header + size_desc + size_stats - pos;
+	len = min(len, remain);
+	if (len <= 0)
+		return 0;
+	remain = len;
+
+	/* Copy kvm stats header.
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
+	/* Copy kvm stats header id string.
+	 * The id string is unique for every vm/vcpu, which is stored in kvm
+	 * and kvm_vcpu structure.
+	 */
+	copylen = size_header + KVM_STATS_ID_MAXLEN - pos;
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
+	/* Copy kvm stats descriptors.
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

