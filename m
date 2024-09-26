Return-Path: <linux-kselftest+bounces-18417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC6987951
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE42C1C21633
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074617C23D;
	Thu, 26 Sep 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6hBLEpk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA841779BC;
	Thu, 26 Sep 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376369; cv=none; b=QWebNsv1p4nA+wzVst7pOD8+vVr78LyUlpxwgVTrZMqET02V5vod7xIBJu8K0VkZ3VRj0zd7I7xWrT8Gu/i67bNtmLqSRxtYkaxRystCkTi80FOPXG/7vyKVF7pUkVw1yzEY5iGcvhEviTnKv6zs2MVHtv+zM/ofKQV6P0EzEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376369; c=relaxed/simple;
	bh=Y9jyTa8JY2pR6SJk1tnmTM3AezQ30ecxje2j87j3LzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJVXLByXGBBK9KtxHcLaoo3fZrG56X9koYeUJnxOHb/1Nidu58fProPsf8J0mhW7PYmagjdx4mKC21YOf9Hs044w4DPhof6qzZLAA/h5KZYLz841WjjsNiEPxODDOlPP9OROPpigK7AFe7EVLYmlN0Qps/ewykelsuRJYK4vUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d6hBLEpk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=XsoFAYg36sX+pP1hwK7qiUVja+uDZbdJ5kaUXqOaGrQ=; b=d6hBLEpk55Kyjd+EwF/trt7mOv
	Y9ynTPkRb5WQmi1mkx0QTJ1Iz+N3m9iXG4oEekJuWfB++0iNsDjgNUVftzNdaP3vd1lYJ1C+wGtA+
	36Zd77GJovm5TErsBJIdmMaZ0/YuoeVXM1c5uyr8SuMSqZHQfpJEbMcdW2+bPcBo0Nruq60NRL2B/
	/wR+yUBLShpW4JLvCwhvtn5xeueyptFgzTSOa+bzyQ/Dz11krSyQQmf5ToSNaszMPwNzxW4/LMzzo
	n+u7Mxbxq+FI8PLZJmkzpsRlU0qkpKeoYtBvCWngaiDZ1Fb0XYMeM2gefRdYwYNTyGdGCLrutQuNQ
	y4zUbZ6A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sttUs-00000002EaW-0x8G;
	Thu, 26 Sep 2024 18:45:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sttUq-00000003YbP-3WJ5;
	Thu, 26 Sep 2024 19:45:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH v5 2/5] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for hibernation
Date: Thu, 26 Sep 2024 19:37:57 +0100
Message-ID: <20240926184546.833516-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240926184546.833516-1-dwmw2@infradead.org>
References: <20240926184546.833516-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The PSCI v1.3 specification adds support for a SYSTEM_OFF2 function
which is analogous to ACPI S4 state. This will allow hosting
environments to determine that a guest is hibernated rather than just
powered off, and ensure that they preserve the virtual environment
appropriately to allow the guest to resume safely (or bump the
hardware_signature in the FACS to trigger a clean reboot instead).

Although this new feature is inflicted unconditionally on unexpecting
userspace, it should be OK because it still results in the same
KVM_SYSTEM_EVENT_SHUTDOWN event, just with a new flag which hopefully
won't cause userspace to get unhappy.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst    | 11 +++++++++
 arch/arm64/include/uapi/asm/kvm.h |  6 +++++
 arch/arm64/kvm/psci.c             | 37 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b3be87489108..2918898b7047 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6840,6 +6840,10 @@ the first `ndata` items (possibly zero) of the data array are valid.
    the guest issued a SYSTEM_RESET2 call according to v1.1 of the PSCI
    specification.
 
+ - for arm64, data[0] is set to KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2
+   if the guest issued a SYSTEM_OFF2 call according to v1.3 of the PSCI
+   specification.
+
  - for RISC-V, data[0] is set to the value of the second argument of the
    ``sbi_system_reset`` call.
 
@@ -6873,6 +6877,13 @@ either:
  - Deny the guest request to suspend the VM. See ARM DEN0022D.b 5.19.2
    "Caller responsibilities" for possible return values.
 
+Hibernation using the PSCI SYSTEM_OFF2 call is enabled when PSCI v1.3
+is enabled. If a guest invokes the PSCI SYSTEM_OFF2 function, KVM will
+exit to userspace with the KVM_SYSTEM_EVENT_SHUTDOWN event type and with
+data[0] set to KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2. The only
+supported hibernate type for the SYSTEM_OFF2 function is HIBERNATE_OFF
+0x0).
+
 ::
 
 		/* KVM_EXIT_IOAPIC_EOI */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 964df31da975..66736ff04011 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -484,6 +484,12 @@ enum {
  */
 #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2	(1ULL << 0)
 
+/*
+ * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
+ * Valid only when the system event has a type of KVM_SYSTEM_EVENT_SHUTDOWN.
+ */
+#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2	(1ULL << 0)
+
 /* run->fail_entry.hardware_entry_failure_reason codes. */
 #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED	(1ULL << 0)
 
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 1f69b667332b..fd0f82464f7d 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -194,6 +194,12 @@ static void kvm_psci_system_off(struct kvm_vcpu *vcpu)
 	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_SHUTDOWN, 0);
 }
 
+static void kvm_psci_system_off2(struct kvm_vcpu *vcpu)
+{
+	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_SHUTDOWN,
+				 KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2);
+}
+
 static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
 {
 	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET, 0);
@@ -358,6 +364,11 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 			if (minor >= 1)
 				val = 0;
 			break;
+		case PSCI_1_3_FN_SYSTEM_OFF2:
+		case PSCI_1_3_FN64_SYSTEM_OFF2:
+			if (minor >= 3)
+				val = BIT(PSCI_1_3_HIBERNATE_TYPE_OFF);
+			break;
 		}
 		break;
 	case PSCI_1_0_FN_SYSTEM_SUSPEND:
@@ -392,6 +403,32 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 			break;
 		}
 		break;
+	case PSCI_1_3_FN_SYSTEM_OFF2:
+		kvm_psci_narrow_to_32bit(vcpu);
+		fallthrough;
+	case PSCI_1_3_FN64_SYSTEM_OFF2:
+		if (minor < 3)
+			break;
+
+		arg = smccc_get_arg1(vcpu);
+		if (arg != PSCI_1_3_HIBERNATE_TYPE_OFF) {
+			val = PSCI_RET_INVALID_PARAMS;
+			break;
+		}
+		kvm_psci_system_off2(vcpu);
+		/*
+		 * We shouldn't be going back to guest VCPU after
+		 * receiving SYSTEM_OFF2 request.
+		 *
+		 * If user space accidentally/deliberately resumes
+		 * guest VCPU after SYSTEM_OFF2 request then guest
+		 * VCPU should see internal failure from PSCI return
+		 * value. To achieve this, we preload r0 (or x0) with
+		 * PSCI return value INTERNAL_FAILURE.
+		 */
+		val = PSCI_RET_INTERNAL_FAILURE;
+		ret = 0;
+		break;
 	default:
 		return kvm_psci_0_2_call(vcpu);
 	}
-- 
2.44.0


