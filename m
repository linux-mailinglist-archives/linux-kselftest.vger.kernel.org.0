Return-Path: <linux-kselftest+bounces-2983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096482D9B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE282821E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498581805E;
	Mon, 15 Jan 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="X8tc+QAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B3179AA;
	Mon, 15 Jan 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=vhDaPzwkV56FJ2IKKJnZAREIZ8hyNHEQ8EwaNCh+Lzw=; b=X8tc+QAJO4rOAZFb8IlkTFSAzR
	pxscFvtmYwXukh341UHaiPZiSmVWBqdqwNxevSEZZk/LixVNeozbrES8LhmIMo4TJFr+xnygOtrTh
	lBJZt8L61vFdK3usLB3lIcKVRxVVUOxlIRiTOLVkrmfUZUSBihxV7ojm2s/wgHUvfU90=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMiY-00035k-US; Mon, 15 Jan 2024 13:09:30 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXP-0002kM-FP; Mon, 15 Jan 2024 12:57:59 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by fixed HVA
Date: Mon, 15 Jan 2024 12:56:58 +0000
Message-Id: <20240115125707.1183-12-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
References: <20240115125707.1183-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

The shared_info page is not guest memory as such. It is a dedicated page
allocated by the VMM and overlaid onto guest memory in a GFN chosen by the
guest and specified in the XENMEM_add_to_physmap hypercall. The guest may
even request that shared_info be moved from one GFN to another by
re-issuing that hypercall, but the HVA is never going to change.

Because the shared_info page is an overlay the memory slots need to be
updated in response to the hypercall. However, memory slot adjustment is
not atomic and, whilst all vCPUs are paused, there is still the possibility
that events may be delivered (which requires the shared_info page to be
updated) whilst the shared_info GPA is absent. The HVA is never absent
though, so it makes much more sense to use that as the basis for the
kernel's mapping.

Hence add a new KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA attribute type for this
purpose and a KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA flag to advertize its
availability. Don't actually advertize it yet though. That will be done in
a subsequent patch, which will also add tests for the new attribute type.

Also update the KVM API documentation with the new attribute and also fix
it up to consistently refer to 'shared_info' (with the underscore).

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

v8:
 - Re-base.

v2:
 - Define the new attribute and capability but don't advertize the
   capability yet.
 - Add API documentation.
---
 Documentation/virt/kvm/api.rst | 25 ++++++++++++++++------
 arch/x86/kvm/xen.c             | 39 ++++++++++++++++++++++++++--------
 include/uapi/linux/kvm.h       |  6 +++++-
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3ec0b7a455a0..3372be85b335 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -372,7 +372,7 @@ The bits in the dirty bitmap are cleared before the ioctl returns, unless
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is enabled.  For more information,
 see the description of the capability.
 
-Note that the Xen shared info page, if configured, shall always be assumed
+Note that the Xen shared_info page, if configured, shall always be assumed
 to be dirty. KVM will not explicitly mark it such.
 
 
@@ -5487,8 +5487,9 @@ KVM_PV_ASYNC_CLEANUP_PERFORM
 		__u8 long_mode;
 		__u8 vector;
 		__u8 runstate_update_flag;
-		struct {
+		union {
 			__u64 gfn;
+			__u64 hva;
 		} shared_info;
 		struct {
 			__u32 send_port;
@@ -5516,10 +5517,10 @@ type values:
 
 KVM_XEN_ATTR_TYPE_LONG_MODE
   Sets the ABI mode of the VM to 32-bit or 64-bit (long mode). This
-  determines the layout of the shared info pages exposed to the VM.
+  determines the layout of the shared_info page exposed to the VM.
 
 KVM_XEN_ATTR_TYPE_SHARED_INFO
-  Sets the guest physical frame number at which the Xen "shared info"
+  Sets the guest physical frame number at which the Xen shared_info
   page resides. Note that although Xen places vcpu_info for the first
   32 vCPUs in the shared_info page, KVM does not automatically do so
   and instead requires that KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO be used
@@ -5528,7 +5529,7 @@ KVM_XEN_ATTR_TYPE_SHARED_INFO
   not be aware of the Xen CPU id which is used as the index into the
   vcpu_info[] array, so may know the correct default location.
 
-  Note that the shared info page may be constantly written to by KVM;
+  Note that the shared_info page may be constantly written to by KVM;
   it contains the event channel bitmap used to deliver interrupts to
   a Xen guest, amongst other things. It is exempt from dirty tracking
   mechanisms — KVM will not explicitly mark the page as dirty each
@@ -5537,9 +5538,21 @@ KVM_XEN_ATTR_TYPE_SHARED_INFO
   any vCPU has been running or any event channel interrupts can be
   routed to the guest.
 
-  Setting the gfn to KVM_XEN_INVALID_GFN will disable the shared info
+  Setting the gfn to KVM_XEN_INVALID_GFN will disable the shared_info
   page.
 
+KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA
+  If the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA flag is also set in the
+  Xen capabilities, then this attribute may be used to set the
+  userspace address at which the shared_info page resides, which
+  will always be fixed in the VMM regardless of where it is mapped
+  in guest physical address space. This attribute should be used in
+  preference to KVM_XEN_ATTR_TYPE_SHARED_INFO as it avoids
+  unnecessary invalidation of an internal cache when the page is
+  re-mapped in guest physcial address space.
+
+  Setting the hva to zero will disable the shared_info page.
+
 KVM_XEN_ATTR_TYPE_UPCALL_VECTOR
   Sets the exception vector used to deliver Xen event channel upcalls.
   This is the HVM-wide vector injected directly by the hypervisor
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d595d476a5b3..813d63a8703a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -617,7 +617,6 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 {
 	int r = -ENOENT;
 
-
 	switch (data->type) {
 	case KVM_XEN_ATTR_TYPE_LONG_MODE:
 		if (!IS_ENABLED(CONFIG_64BIT) && data->u.long_mode) {
@@ -638,20 +637,32 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		}
 		break;
 
-	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
 		int idx;
 
 		mutex_lock(&kvm->arch.xen.xen_lock);
 
 		idx = srcu_read_lock(&kvm->srcu);
 
-		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
-			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
-			r = 0;
+		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
+			if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
+				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
+				r = 0;
+			} else {
+				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
+						     gfn_to_gpa(data->u.shared_info.gfn),
+						     PAGE_SIZE);
+			}
 		} else {
-			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
-					     gfn_to_gpa(data->u.shared_info.gfn),
-					     PAGE_SIZE);
+			if (data->u.shared_info.hva == 0) {
+				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
+				r = 0;
+			} else {
+				r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache,
+							 data->u.shared_info.hva,
+							 PAGE_SIZE);
+			}
 		}
 
 		srcu_read_unlock(&kvm->srcu, idx);
@@ -715,13 +726,23 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		break;
 
 	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
-		if (kvm->arch.xen.shinfo_cache.active)
+		if (kvm->arch.xen.shinfo_cache.active &&
+		    kvm->arch.xen.shinfo_cache.gpa != KVM_XEN_INVALID_GPA)
 			data->u.shared_info.gfn = gpa_to_gfn(kvm->arch.xen.shinfo_cache.gpa);
 		else
 			data->u.shared_info.gfn = KVM_XEN_INVALID_GFN;
 		r = 0;
 		break;
 
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA:
+		if (kvm->arch.xen.shinfo_cache.active &&
+		    kvm->arch.xen.shinfo_cache.gpa == KVM_XEN_INVALID_GPA)
+			data->u.shared_info.hva = kvm->arch.xen.shinfo_cache.uhva;
+		else
+			data->u.shared_info.hva = 0;
+		r = 0;
+		break;
+
 	case KVM_XEN_ATTR_TYPE_UPCALL_VECTOR:
 		data->u.vector = kvm->arch.xen.upcall_vector;
 		r = 0;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c3308536482b..ac5caba313d1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1246,6 +1246,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
+#define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
 
 struct kvm_xen_hvm_config {
 	__u32 flags;
@@ -1744,9 +1745,10 @@ struct kvm_xen_hvm_attr {
 		__u8 long_mode;
 		__u8 vector;
 		__u8 runstate_update_flag;
-		struct {
+		union {
 			__u64 gfn;
 #define KVM_XEN_INVALID_GFN ((__u64)-1)
+			__u64 hva;
 		} shared_info;
 		struct {
 			__u32 send_port;
@@ -1788,6 +1790,8 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_XEN_VERSION		0x4
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG */
 #define KVM_XEN_ATTR_TYPE_RUNSTATE_UPDATE_FLAG	0x5
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA */
+#define KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA	0x6
 
 /* Per-vCPU Xen attributes */
 #define KVM_XEN_VCPU_GET_ATTR	_IOWR(KVMIO, 0xca, struct kvm_xen_vcpu_attr)
-- 
2.39.2


