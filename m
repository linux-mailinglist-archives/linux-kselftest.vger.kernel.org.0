Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC71FD50A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQTFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 15:05:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:48978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgFQTFJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 15:05:09 -0400
IronPort-SDR: AaiEpV1M2bHzO3SoB3gB0kDeMlLcmFiso+sqionkh6V0Y2sUWRjKZOjqQBSZhXw+wVZKAlu31Y
 MBkvjzRcaAIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 12:05:09 -0700
IronPort-SDR: XaTM/0pxYcUKBtQfhnD+idd+M4VFhRN/WvrCorf4TvEgLkY2ri0Xu/TSQT3k5nLvh2ixTBEmy0
 BGSU6Y+wGWJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273609601"
Received: from gza.jf.intel.com ([10.54.75.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 12:05:07 -0700
From:   John Andersen <john.s.andersen@intel.com>
To:     corbet@lwn.net, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, sean.j.christopherson@intel.com,
        liran.alon@oracle.com, drjones@redhat.com,
        rick.p.edgecombe@intel.com, kristen@linux.intel.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, john.s.andersen@intel.com,
        arjan@linux.intel.com, caoj.fnst@cn.fujitsu.com, bhe@redhat.com,
        nivedita@alum.mit.edu, keescook@chromium.org,
        dan.j.williams@intel.com, eric.auger@redhat.com,
        aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 1/4] X86: Update mmu_cr4_features during feature identification
Date:   Wed, 17 Jun 2020 12:07:54 -0700
Message-Id: <20200617190757.27081-2-john.s.andersen@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617190757.27081-1-john.s.andersen@intel.com>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In identify_cpu when setting up SMEP/SMAP/UMIP call
cr4_set_bits_and_update_boot instead of cr4_set_bits. This ensures that
mmu_cr4_features contains those bits, and does not disable those
protections when in hibernation asm.

setup_arch updates mmu_cr4_features to save what identified features are
supported for later use in hibernation asm when cr4 needs to be modified
to toggle PGE. cr4 writes happen in restore_image and restore_registers.
setup_arch occurs before identify_cpu, this leads to mmu_cr4_features
not containing some of the cr4 features which were enabled via
identify_cpu when hibernation asm is executed.

On CPU bringup when cr4_set_bits_and_update_boot is called
mmu_cr4_features will now be written to. For the boot CPU,
the __ro_after_init on mmu_cr4_features does not cause a fault. However,
__ro_after_init was removed due to it triggering faults on non-boot
CPUs.

Signed-off-by: John Andersen <john.s.andersen@intel.com>
---
 arch/x86/kernel/cpu/common.c | 6 +++---
 arch/x86/kernel/setup.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d07809286b95..921e67086a00 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -297,7 +297,7 @@ __setup("nosmep", setup_disable_smep);
 static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_SMEP))
-		cr4_set_bits(X86_CR4_SMEP);
+		cr4_set_bits_and_update_boot(X86_CR4_SMEP);
 }
 
 static __init int setup_disable_smap(char *arg)
@@ -316,7 +316,7 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_SMAP)) {
 #ifdef CONFIG_X86_SMAP
-		cr4_set_bits(X86_CR4_SMAP);
+		cr4_set_bits_and_update_boot(X86_CR4_SMAP);
 #else
 		cr4_clear_bits(X86_CR4_SMAP);
 #endif
@@ -333,7 +333,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_UMIP))
 		goto out;
 
-	cr4_set_bits(X86_CR4_UMIP);
+	cr4_set_bits_and_update_boot(X86_CR4_UMIP);
 
 	pr_info_once("x86/cpu: User Mode Instruction Prevention (UMIP) activated\n");
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758..d9c678b37a9b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -138,9 +138,9 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
-__visible unsigned long mmu_cr4_features __ro_after_init;
+__visible unsigned long mmu_cr4_features;
 #else
-__visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
+__visible unsigned long mmu_cr4_features = X86_CR4_PAE;
 #endif
 
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
-- 
2.21.0

