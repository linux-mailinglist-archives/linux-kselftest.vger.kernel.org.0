Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD36A40916C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbhIMOBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 10:01:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245109AbhIMN7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:59:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A2BB21E9F;
        Mon, 13 Sep 2021 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631541470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJEQIgnm1bmcNwzuG5m4RwXUlGdjbwBKYPhETx8x9T4=;
        b=SppJC966jR24NoJJCtelnYM/GwS+HnuxXgAyhhwfiHlT68GxC5oRuf9dfylpsoVz4vbsCM
        yhoWzylsRQYhrOWqirpfhZncs5cXGrEoRdPGjUHuC1RbzS/ozy8YMOkJeAYnhpONXZsMAg
        SamdwZZojI6B4jKKkB9KAZ3uub1koGQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B98113AB2;
        Mon, 13 Sep 2021 13:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6MxvHN1YP2FMUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Sep 2021 13:57:49 +0000
From:   Juergen Gross <jgross@suse.com>
To:     kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS
Date:   Mon, 13 Sep 2021 15:57:44 +0200
Message-Id: <20210913135745.13944-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210913135745.13944-1-jgross@suse.com>
References: <20210913135745.13944-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_MAX_VCPU_ID is not specifying the highest allowed vcpu-id, but the
number of allowed vcpu-ids. This has already led to confusion, so
rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS to make its semantics more
clear

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 Documentation/virt/kvm/devices/xics.rst            | 2 +-
 Documentation/virt/kvm/devices/xive.rst            | 2 +-
 arch/mips/kvm/mips.c                               | 2 +-
 arch/powerpc/include/asm/kvm_book3s.h              | 2 +-
 arch/powerpc/include/asm/kvm_host.h                | 4 ++--
 arch/powerpc/kvm/book3s_xive.c                     | 2 +-
 arch/powerpc/kvm/powerpc.c                         | 2 +-
 arch/x86/include/asm/kvm_host.h                    | 2 +-
 arch/x86/kvm/ioapic.c                              | 2 +-
 arch/x86/kvm/ioapic.h                              | 4 ++--
 arch/x86/kvm/x86.c                                 | 2 +-
 include/linux/kvm_host.h                           | 4 ++--
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 2 +-
 virt/kvm/kvm_main.c                                | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/kvm/devices/xics.rst b/Documentation/virt/kvm/devices/xics.rst
index 2d6927e0b776..bf32c77174ab 100644
--- a/Documentation/virt/kvm/devices/xics.rst
+++ b/Documentation/virt/kvm/devices/xics.rst
@@ -22,7 +22,7 @@ Groups:
   Errors:
 
     =======  ==========================================
-    -EINVAL  Value greater than KVM_MAX_VCPU_ID.
+    -EINVAL  Value greater than KVM_MAX_VCPU_IDS.
     -EFAULT  Invalid user pointer for attr->addr.
     -EBUSY   A vcpu is already connected to the device.
     =======  ==========================================
diff --git a/Documentation/virt/kvm/devices/xive.rst b/Documentation/virt/kvm/devices/xive.rst
index 8bdf3dc38f01..8b5e7b40bdf8 100644
--- a/Documentation/virt/kvm/devices/xive.rst
+++ b/Documentation/virt/kvm/devices/xive.rst
@@ -91,7 +91,7 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     Errors:
 
       =======  ==========================================
-      -EINVAL  Value greater than KVM_MAX_VCPU_ID.
+      -EINVAL  Value greater than KVM_MAX_VCPU_IDS.
       -EFAULT  Invalid user pointer for attr->addr.
       -EBUSY   A vCPU is already connected to the device.
       =======  ==========================================
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 75c6f264c626..562aa878b266 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1073,7 +1073,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_MAX_VCPUS;
 		break;
 	case KVM_CAP_MAX_VCPU_ID:
-		r = KVM_MAX_VCPU_ID;
+		r = KVM_MAX_VCPU_IDS;
 		break;
 	case KVM_CAP_MIPS_FPU:
 		/* We don't handle systems with inconsistent cpu_has_fpu */
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index caaa0f592d8e..3d31f2c59e43 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -434,7 +434,7 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
 #define SPLIT_HACK_OFFS			0xfb000000
 
 /*
- * This packs a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
+ * This packs a VCPU ID from the [0..KVM_MAX_VCPU_IDS) space down to the
  * [0..KVM_MAX_VCPUS) space, using knowledge of the guest's core stride
  * (but not its actual threading mode, which is not available) to avoid
  * collisions.
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 080a7feb7731..59cb38b04ede 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -33,11 +33,11 @@
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
-#define KVM_MAX_VCPU_ID		(MAX_SMT_THREADS * KVM_MAX_VCORES)
+#define KVM_MAX_VCPU_IDS	(MAX_SMT_THREADS * KVM_MAX_VCORES)
 #define KVM_MAX_NESTED_GUESTS	KVMPPC_NR_LPIDS
 
 #else
-#define KVM_MAX_VCPU_ID		KVM_MAX_VCPUS
+#define KVM_MAX_VCPU_IDS	KVM_MAX_VCPUS
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index a18db9e16ea4..225008882958 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1928,7 +1928,7 @@ int kvmppc_xive_set_nr_servers(struct kvmppc_xive *xive, u64 addr)
 
 	pr_devel("%s nr_servers=%u\n", __func__, nr_servers);
 
-	if (!nr_servers || nr_servers > KVM_MAX_VCPU_ID)
+	if (!nr_servers || nr_servers > KVM_MAX_VCPU_IDS)
 		return -EINVAL;
 
 	mutex_lock(&xive->lock);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b4e6f70b97b9..8ab90ce8738f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -649,7 +649,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_MAX_VCPUS;
 		break;
 	case KVM_CAP_MAX_VCPU_ID:
-		r = KVM_MAX_VCPU_ID;
+		r = KVM_MAX_VCPU_IDS;
 		break;
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_PPC_GET_SMMU_INFO:
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8f48a7ec577..261b7d857fc0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -50,7 +50,7 @@
  * so ratio of 4 should be enough.
  */
 #define KVM_VCPU_ID_RATIO 4
-#define KVM_MAX_VCPU_ID (KVM_MAX_VCPUS * KVM_VCPU_ID_RATIO)
+#define KVM_MAX_VCPU_IDS (KVM_MAX_VCPUS * KVM_VCPU_ID_RATIO)
 
 /* memory slots that are not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 3
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 698969e18fe3..3358123be946 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -96,7 +96,7 @@ static unsigned long ioapic_read_indirect(struct kvm_ioapic *ioapic,
 static void rtc_irq_eoi_tracking_reset(struct kvm_ioapic *ioapic)
 {
 	ioapic->rtc_status.pending_eoi = 0;
-	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID);
+	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_IDS);
 }
 
 static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 27e61ff3ac3e..e66e620c3bed 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -39,13 +39,13 @@ struct kvm_vcpu;
 
 struct dest_map {
 	/* vcpu bitmap where IRQ has been sent */
-	DECLARE_BITMAP(map, KVM_MAX_VCPU_ID);
+	DECLARE_BITMAP(map, KVM_MAX_VCPU_IDS);
 
 	/*
 	 * Vector sent to a given vcpu, only valid when
 	 * the vcpu's bit in map is set
 	 */
-	u8 vectors[KVM_MAX_VCPU_ID];
+	u8 vectors[KVM_MAX_VCPU_IDS];
 };
 
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 28ef14155726..fec43997522b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4070,7 +4070,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_MAX_VCPUS;
 		break;
 	case KVM_CAP_MAX_VCPU_ID:
-		r = KVM_MAX_VCPU_ID;
+		r = KVM_MAX_VCPU_IDS;
 		break;
 	case KVM_CAP_PV_MMU:	/* obsolete */
 		r = 0;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 041ca7f15ea4..d2b405170f6e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -39,8 +39,8 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
-#ifndef KVM_MAX_VCPU_ID
-#define KVM_MAX_VCPU_ID KVM_MAX_VCPUS
+#ifndef KVM_MAX_VCPU_IDS
+#define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
 #endif
 
 /*
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 0299cd81b8ba..f968dfd4ee88 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -53,7 +53,7 @@ int main(int argc, char *argv[])
 		kvm_max_vcpu_id = kvm_max_vcpus;
 
 	TEST_ASSERT(kvm_max_vcpu_id >= kvm_max_vcpus,
-		    "KVM_MAX_VCPU_ID (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
+		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);
 
 	test_vcpu_creation(0, kvm_max_vcpus);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 439d3b4cd1a9..62fcbc897e1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3557,7 +3557,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	struct kvm_vcpu *vcpu;
 	struct page *page;
 
-	if (id >= KVM_MAX_VCPU_ID)
+	if (id >= KVM_MAX_VCPU_IDS)
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
-- 
2.26.2

