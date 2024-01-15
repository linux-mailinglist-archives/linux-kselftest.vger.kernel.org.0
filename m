Return-Path: <linux-kselftest+bounces-2982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F1182D9B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED63AB20AF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047C18039;
	Mon, 15 Jan 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="ySRZY6ok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF517998;
	Mon, 15 Jan 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=HoFDRo1yTIjthonncEFLrbdyHWleYvDMrMvB1NXYJjo=; b=ySRZY6ok33Eubiam5nibBoDkA1
	pQRYBHm46xeRkj7E7IPrlL/GbDgM4V9e1ZI09xhHemf5CDPlG5xqUBqW0o7Yc3SWBFulkBHIzvpXl
	42Kd1D2me0RfislnbNOB3nH/yEztsv35P6Jy4qr+uEAeeEJVli39FDwWmcG2hwtqdAdg=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMiZ-00035u-8E; Mon, 15 Jan 2024 13:09:31 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXR-0002kM-QP; Mon, 15 Jan 2024 12:58:02 +0000
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
Subject: [PATCH v12 12/20] KVM: xen: allow vcpu_info to be mapped by fixed HVA
Date: Mon, 15 Jan 2024 12:56:59 +0000
Message-Id: <20240115125707.1183-13-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
References: <20240115125707.1183-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

If the guest does not explicitly set the GPA of vcpu_info structure in
memory then, for guests with 32 vCPUs or fewer, the vcpu_info embedded
in the shared_info page may be used. As described in a previous commit,
the shared_info page is an overlay at a fixed HVA within the VMM, so in
this case it also more optimal to activate the vcpu_info cache with a
fixed HVA to avoid unnecessary invalidation if the guest memory layout
is modified.

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

v5:
 - New in this version.
---
 Documentation/virt/kvm/api.rst | 26 +++++++++++++++++++++-----
 arch/x86/kvm/xen.c             | 34 ++++++++++++++++++++++++++++------
 include/uapi/linux/kvm.h       |  3 +++
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3372be85b335..bd93cafd3e4e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5523,11 +5523,12 @@ KVM_XEN_ATTR_TYPE_SHARED_INFO
   Sets the guest physical frame number at which the Xen shared_info
   page resides. Note that although Xen places vcpu_info for the first
   32 vCPUs in the shared_info page, KVM does not automatically do so
-  and instead requires that KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO be used
-  explicitly even when the vcpu_info for a given vCPU resides at the
-  "default" location in the shared_info page. This is because KVM may
-  not be aware of the Xen CPU id which is used as the index into the
-  vcpu_info[] array, so may know the correct default location.
+  and instead requires that KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO or
+  KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA be used explicitly even when
+  the vcpu_info for a given vCPU resides at the "default" location
+  in the shared_info page. This is because KVM may not be aware of
+  the Xen CPU id which is used as the index into the vcpu_info[]
+  array, so may know the correct default location.
 
   Note that the shared_info page may be constantly written to by KVM;
   it contains the event channel bitmap used to deliver interrupts to
@@ -5649,6 +5650,21 @@ KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO
   on dirty logging. Setting the gpa to KVM_XEN_INVALID_GPA will disable
   the vcpu_info.
 
+KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA
+  If the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA flag is also set in the
+  Xen capabilities, then this attribute may be used to set the
+  userspace address of the vcpu_info for a given vCPU. It should
+  only be used when the vcpu_info resides at the "default" location
+  in the shared_info page. In this case it is safe to assume the
+  userspace address will not change, because the shared_info page is
+  an overlay on guest memory and remains at a fixed host address
+  regardless of where it is mapped in guest physical address space
+  and hence unnecessary invalidation of an internal cache may be
+  avoided if the guest memory layout is modified.
+  If the vcpu_info does not reside at the "default" location then
+  it is not guaranteed to remain at the same host address and
+  hence the aforementioned cache invalidation is required.
+
 KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO
   Sets the guest physical address of an additional pvclock structure
   for a given vCPU. This is typically used for guest vsyscall support.
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 813d63a8703a..c99008d217f4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -779,20 +779,33 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 	switch (data->type) {
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:
+	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA:
 		/* No compat necessary here. */
 		BUILD_BUG_ON(sizeof(struct vcpu_info) !=
 			     sizeof(struct compat_vcpu_info));
 		BUILD_BUG_ON(offsetof(struct vcpu_info, time) !=
 			     offsetof(struct compat_vcpu_info, time));
 
-		if (data->u.gpa == KVM_XEN_INVALID_GPA) {
-			kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
-			r = 0;
-			break;
+		if (data->type == KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO) {
+			if (data->u.gpa == KVM_XEN_INVALID_GPA) {
+				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
+				r = 0;
+				break;
+			}
+
+			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
+					     data->u.gpa, sizeof(struct vcpu_info));
+		} else {
+			if (data->u.hva == 0) {
+				kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
+				r = 0;
+				break;
+			}
+
+			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
+						 data->u.hva, sizeof(struct vcpu_info));
 		}
 
-		r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
-				     data->u.gpa, sizeof(struct vcpu_info));
 		if (!r)
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 
@@ -1021,6 +1034,15 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		r = 0;
 		break;
 
+	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA:
+		if (vcpu->arch.xen.vcpu_info_cache.active &&
+		    vcpu->arch.xen.vcpu_info_cache.gpa == KVM_XEN_INVALID_GPA)
+			data->u.hva = vcpu->arch.xen.vcpu_info_cache.uhva;
+		else
+			data->u.hva = 0;
+		r = 0;
+		break;
+
 	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO:
 		if (vcpu->arch.xen.vcpu_time_info_cache.active)
 			data->u.gpa = vcpu->arch.xen.vcpu_time_info_cache.gpa;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ac5caba313d1..d2665319db6e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1809,6 +1809,7 @@ struct kvm_xen_vcpu_attr {
 	union {
 		__u64 gpa;
 #define KVM_XEN_INVALID_GPA ((__u64)-1)
+		__u64 hva;
 		__u64 pad[8];
 		struct {
 			__u64 state;
@@ -1839,6 +1840,8 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID		0x6
 #define KVM_XEN_VCPU_ATTR_TYPE_TIMER		0x7
 #define KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR	0x8
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA */
+#define KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA	0x9
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.39.2


