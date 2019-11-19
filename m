Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8E1011AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfKSDMy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:12:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:21246 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfKSDMy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105733"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 19:12:42 -0800
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 11/19] KVM: VMX: Check for full VMX support when verifying CPU compatibility
Date:   Mon, 18 Nov 2019 19:12:32 -0800
Message-Id: <20191119031240.7779-12-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Explicitly check the current CPU's VMX feature flag when verifying
compatibility across physical CPUs.  This effectively adds a check on
IA32_FEATURE_CONTROL to ensure that VMX is fully enabled on all CPUs.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index eff28130cb54..d9bd99977464 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6831,6 +6831,11 @@ static int __init vmx_check_processor_compat(void)
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
 
+	if (!this_cpu_has(X86_FEATURE_VMX)) {
+		pr_err("kvm: VMX is disabled on CPU %d\n", smp_processor_id());
+		return -EIO;
+	}
+
 	if (setup_vmcs_config(&vmcs_conf, &vmx_cap) < 0)
 		return -EIO;
 	if (nested)
-- 
2.24.0

