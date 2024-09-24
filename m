Return-Path: <linux-kselftest+bounces-18311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF4498491C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4151A1C22C5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DD1AC431;
	Tue, 24 Sep 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQBQjEYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6E1AB6EE;
	Tue, 24 Sep 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193935; cv=none; b=U2UbABDd5t5vmOzPdLEA79NjWkDVUxJtLvdeZw0dSNVpOenjA94dgwLCYoNCvx89CrzYOhw4KQztczwM4ePYnhJO4oTtbNvd/Ja3ON83oM9jgkzxnWpqCi9D2pwUc9haoXJSXQnZEPU1cMaZO/mY7LJ5Zm2MZQLk1yqmi/mXdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193935; c=relaxed/simple;
	bh=2tpYgf523CxsRxp9eyF4B5T1AKZi0nkjgTWs2B/7Flo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/0DyDXOPLDZMjSBNY89hg+VLh9S9UKBbxmSMJE2wpg7eg+wNk6TikhCVW2nX4rMY3/zwjWlDiDmE88Dhr5gHtqK0dWlWIlWPO3HUDjqyNXGEPCvnKnRXnSj3j2pq5sKRMB3MffcnLgKFzBnUqUKa0/f9L/89F10DZ17BbIGfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mQBQjEYF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=fcnHt2M//sLRFz0qJG4Glh1o2DI9tJqZxEPWpz+aIA0=; b=mQBQjEYF0LXTTfmLh4k6w43gnD
	wjuD04JeL92PfxcynMmccZRTFvyIqocHUB2woveq1RPR2v6rx9sV8Fw5l9eCh5Ps3HCfQkaH+tEOf
	PkbuPz3itMVfHhFzBCn0g0tAdS2XJmEL0pMoY48YL5jNZ5aEW7J3Ld9J+h2WPoo6CECl16SJW7XPt
	DM2mvtKV5Ed03XnT9HGob0ViUXfC/XNjtKX+y4IqTwnKVvPcpNyXn9S+dwdTupEAOH2zoOpdwc/dx
	o68d8cG9k/KAuMjk+hOrXnho8l2oaurw9UzgaAMXbMRq1ttRS/OlugCBHzMta3ArqS/qn7q7MRBY1
	L+bCxLXw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st82K-00000001vkM-3jKy;
	Tue, 24 Sep 2024 16:05:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1st82K-0000000HMif-2PW9;
	Tue, 24 Sep 2024 17:05:12 +0100
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for hibernate
Date: Tue, 24 Sep 2024 17:05:12 +0100
Message-ID: <20240924160512.4138879-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240924160512.4138879-1-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
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

The PSCI v1.3 specification (alpha) adds support for a SYSTEM_OFF2
function which is analogous to ACPI S4 state. This will allow hosting
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
 drivers/firmware/psci/psci.c | 37 ++++++++++++++++++++++++++++++++++++
 kernel/power/hibernate.c     |  5 ++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2328ca58bba6..fbf09a51b817 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -78,6 +78,7 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
+static bool psci_system_off2_hibernate_supported;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -333,6 +334,28 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+#ifdef CONFIG_HIBERNATION
+static int psci_sys_hibernate(struct sys_off_data *data)
+{
+	if (system_entering_hibernation())
+		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2),
+			       PSCI_1_3_HIBERNATE_TYPE_OFF, 0, 0);
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
@@ -364,6 +387,7 @@ static const struct {
 	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
 	PSCI_ID(1_1, MEM_PROTECT),
 	PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
+	PSCI_ID_NATIVE(1_3, SYSTEM_OFF2),
 };
 
 static int psci_debugfs_read(struct seq_file *s, void *data)
@@ -525,6 +549,18 @@ static void __init psci_init_system_reset2(void)
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
+	if (ret & BIT(PSCI_1_3_HIBERNATE_TYPE_OFF))
+		psci_system_off2_hibernate_supported = true;
+}
+
 static void __init psci_init_system_suspend(void)
 {
 	int ret;
@@ -655,6 +691,7 @@ static int __init psci_probe(void)
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


