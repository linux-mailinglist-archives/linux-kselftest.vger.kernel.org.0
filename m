Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422E812873A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfLUEr2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:47:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:31824 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfLUEp5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:45:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620075"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:45:55 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v5 05/19] x86/mce: WARN once if IA32_FEAT_CTL MSR is left unlocked
Date:   Fri, 20 Dec 2019 20:44:59 -0800
Message-Id: <20191221044513.21680-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

WARN if the IA32_FEAT_CTL MSR is somehow left unlocked now that CPU
initialization unconditionally locks the MSR.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index c238518b84a2..5627b1091b85 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -116,14 +116,15 @@ static bool lmce_supported(void)
 	/*
 	 * BIOS should indicate support for LMCE by setting bit 20 in
 	 * IA32_FEAT_CTL without which touching MCG_EXT_CTL will generate a #GP
-	 * fault.
+	 * fault.  The MSR must also be locked for LMCE_ENABLED to take effect.
+	 * WARN if the MSR isn't locked as init_ia32_feat_ctl() unconditionally
+	 * locks the MSR in the event that it wasn't already locked by BIOS.
 	 */
 	rdmsrl(MSR_IA32_FEAT_CTL, tmp);
-	if ((tmp & (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED)) ==
-		   (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED))
-		return true;
+	if (WARN_ON_ONCE(!(tmp & FEAT_CTL_LOCKED)))
+		return false;
 
-	return false;
+	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
 bool mce_intel_cmci_poll(void)
-- 
2.24.1

