Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCE249D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHSMOJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 08:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgHSMOH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 08:14:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874C6206DA;
        Wed, 19 Aug 2020 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839246;
        bh=Ftm+BgFLcJzi0bjTiz8IjEJjLINWXFqX3Rrl97pTpb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGdWwUzzLPnSon0iOKaq9SG/crBOPwsDLkl71Tmfh0jMLTfAf5jQ4WHrDimzHvqzI
         OLN3vtTxqe9E7ih91kchWM5gj1ra76v0Nyi+KCdk8cnu3GXosZ+xi8pK9yc/Yw0CjH
         GdTJGU0vhRSRF45VGT10z4h5NCYSpUPUYb7Hs2sA=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/5] arm64: vdso: Initialise the per-CPU vDSO data
Date:   Wed, 19 Aug 2020 13:13:16 +0100
Message-Id: <20200819121318.52158-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819121318.52158-1-broonie@kernel.org>
References: <20200819121318.52158-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Register with the CPU hotplug system to initialise the per-CPU data for
getcpu().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/vdso.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2a8d7ab76bee..d9743c659341 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -9,6 +9,7 @@
 
 #include <linux/cache.h>
 #include <linux/clocksource.h>
+#include <linux/cpuhotplug.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -18,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
@@ -466,6 +468,26 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
+static void vdso_cpu_init(void *p)
+{
+	struct arm64_vdso_data *data = (struct arm64_vdso_data *)vdso_data;
+	unsigned int cpu;
+
+	if (vdso_cpu_offset()) {
+		cpu = smp_processor_id();
+
+		data->cpu_data[cpu].cpu = cpu;
+		data->cpu_data[cpu].node = cpu_to_node(cpu);
+	}
+}
+
+static int vdso_cpu_online(unsigned int cpu)
+{
+	smp_call_function_single(cpu, vdso_cpu_init, NULL, 1);
+
+	return 0;
+}
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -494,6 +516,12 @@ static int __init vdso_init(void)
 	vdso_info[VDSO_ABI_AA64].dm = &aarch64_vdso_maps[AA64_MAP_VVAR];
 	vdso_info[VDSO_ABI_AA64].cm = &aarch64_vdso_maps[AA64_MAP_VDSO];
 
+	/*
+	 * Initialize per-CPU data, callback runs for all current and
+	 * future CPUs.
+	 */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "vdso", vdso_cpu_online, NULL);
+
 	return __vdso_init(VDSO_ABI_AA64);
 }
 arch_initcall(vdso_init);
-- 
2.20.1

