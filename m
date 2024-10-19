Return-Path: <linux-kselftest+bounces-20201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DC9A500D
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8711C23C6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC0192B69;
	Sat, 19 Oct 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJMdKFy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3011917E6;
	Sat, 19 Oct 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358718; cv=none; b=Nyj+fFX5rqgMdSbd44wnqr4fGli56antfK0IbL7byuXCJm7wjQIYzu0f9LO9YgZbVB1NuN9Y4K3nMKepQzyn34VfcYNjoyt0dfCLthsdgaIOjzT4SRzqwoJOJmtkN4lOqui9Q7z3ne+f157bUp7LISZjQSI7Xtc/SsZpd3IlH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358718; c=relaxed/simple;
	bh=K2m8obFhWuwPQuikGUdYpspkIHuhwoUO0TZOETINH7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlQYFIk3KVTck5f0rCeCAhufN/+fiWco35JUyL98adgJxXZf1GKax9x36k3pin2+gW3OqqPESYrzyudICGHlSc7z05Krc8nJeivwM8HN6tH/nW7bIbsQ/XSbR4Kq+rqa7K4kOo6ChpZ6Usy8xB4OAm/hgZI3qAgkl0jpfVsZUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJMdKFy7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=T/6p2P3AuQICDZdTmCqeIRHYUbD9P11W996yxXSWcPU=; b=aJMdKFy7DJvlTP1XnRcUjL6xbY
	Q5EoK5K3U51yRlgxxEb40YRiBgw/w7hBzAWytf0A1aXUXARRqTR8mw4PqxNKx+HwUEscYrVaMJ6UG
	liArW3tl3xOmGMt4Dpt5nfhKf9vp8d8pBn8fEF0P4V48jTe19emOfLUMSKevdrre9oaVr0tzxPX68
	KfkJ/EsRHkgLLB5dH7lDB4jVFjJfjpSy7Y5Mw2LDmiGnt1LIQ4CxfZRhtcrH3zNvWAd2AAUQHcieH
	OM3tssMkLM/axWzt9O7aiyFjtlV312lwVSI0HPBT/9ylp6SB+/poGIBPaux2rtzL8LJBP7GtVHMPr
	/yWn6Ahw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCK-0000000EUiq-3cTV;
	Sat, 19 Oct 2024 17:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKv-3xjU;
	Sat, 19 Oct 2024 18:25:02 +0100
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
Subject: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for hibernate
Date: Sat, 19 Oct 2024 18:15:47 +0100
Message-ID: <20241019172459.2241939-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241019172459.2241939-1-dwmw2@infradead.org>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The PSCI v1.3 specification adds support for a SYSTEM_OFF2 function
which is analogous to ACPI S4 state. This will allow hosting
environments to determine that a guest is hibernated rather than just
powered off, and handle that state appropriately on subsequent launches.

Since commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and
poweroff") the EFI shutdown method is deliberately preferred over PSCI
or other methods. So register a SYS_OFF_MODE_POWER_OFF handler which
*only* handles the hibernation, leaving the original PSCI SYSTEM_OFF as
a last resort via the legacy pm_power_off function pointer.

The hibernation code already exports a system_entering_hibernation()
function which is be used by the higher-priority handler to check for
hibernation. That existing function just returns the value of a static
boolean variable from hibernate.c, which was previously only set in the
hibernation_platform_enter() code path. Set the same flag in the simpler
code path around the call to kernel_power_off() too.

An alternative way to hook SYSTEM_OFF2 into the hibernation code would
be to register a platform_hibernation_ops structure with an ->enter()
method which makes the new SYSTEM_OFF2 call. But that would have the
unwanted side-effect of making hibernation take a completely different
code path in hibernation_platform_enter(), invoking a lot of special dpm
callbacks.

Another option might be to add a new SYS_OFF_MODE_HIBERNATE mode, with
fallback to SYS_OFF_MODE_POWER_OFF. Or to use the sys_off_data to
indicate whether the power off is for hibernation.

But this version works and is relatively simple.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++++++++++++++++++
 kernel/power/hibernate.c     |  5 ++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2328ca58bba6..8809455a61a6 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -78,6 +78,7 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
+static bool psci_system_off2_hibernate_supported;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -333,6 +334,33 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+#ifdef CONFIG_HIBERNATION
+static int psci_sys_hibernate(struct sys_off_data *data)
+{
+	/*
+	 * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
+	 * and is supported by hypervisors implementing an earlier version
+	 * of the pSCI v1.3 spec.
+	 */
+	if (system_entering_hibernation())
+		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2),
+			       0 /*PSCI_1_3_OFF_TYPE_HIBERNATE_OFF*/, 0, 0);
+	return NOTIFY_DONE;
+}
+
+static int __init psci_hibernate_init(void)
+{
+	if (psci_system_off2_hibernate_supported) {
+		/* Higher priority than EFI shutdown, but only for hibernate */
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+					 SYS_OFF_PRIO_FIRMWARE + 2,
+					 psci_sys_hibernate, NULL);
+	}
+	return 0;
+}
+subsys_initcall(psci_hibernate_init);
+#endif
+
 static int psci_features(u32 psci_func_id)
 {
 	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
@@ -364,6 +392,7 @@ static const struct {
 	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
 	PSCI_ID(1_1, MEM_PROTECT),
 	PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
+	PSCI_ID_NATIVE(1_3, SYSTEM_OFF2),
 };
 
 static int psci_debugfs_read(struct seq_file *s, void *data)
@@ -525,6 +554,18 @@ static void __init psci_init_system_reset2(void)
 		psci_system_reset2_supported = true;
 }
 
+static void __init psci_init_system_off2(void)
+{
+	int ret;
+
+	ret = psci_features(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2));
+	if (ret < 0)
+		return;
+
+	if (ret & PSCI_1_3_OFF_TYPE_HIBERNATE_OFF)
+		psci_system_off2_hibernate_supported = true;
+}
+
 static void __init psci_init_system_suspend(void)
 {
 	int ret;
@@ -655,6 +696,7 @@ static int __init psci_probe(void)
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
 		psci_init_system_reset2();
+		psci_init_system_off2();
 		kvm_init_hyp_services();
 	}
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e35829d36039..1f87aa01ba44 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -685,8 +685,11 @@ static void power_down(void)
 		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
-		if (kernel_can_power_off())
+		if (kernel_can_power_off()) {
+			entering_platform_hibernation = true;
 			kernel_power_off();
+			entering_platform_hibernation = false;
+		}
 		break;
 	}
 	kernel_halt();
-- 
2.44.0


