Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D53E9110
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhHKMak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231778AbhHKMaR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628684993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2zltoeBUaiiUWd903sk/fd+wquvy5ZlpMpjy5zL9F8=;
        b=IbsCfNpI9PRRV3w7Yg2xV0sPhYTGa8mRkqZA3ZkCr/8PIgkrAmvKfLfjdQoqSDJbceIAZ2
        C+NFv3GAbm4TyceY2XWmWCk19oZmzJXckuf1P5t5ox4tYTm1U7p7pCZBmAvffCfEj2A9cC
        8Qukp5HDcvjAPDO0ruM0H/f6ykwoNcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Dv_T0RRpNGOnprh8ybR84w-1; Wed, 11 Aug 2021 08:29:52 -0400
X-MC-Unique: Dv_T0RRpNGOnprh8ybR84w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 210F0192D787;
        Wed, 11 Aug 2021 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 716085D9C6;
        Wed, 11 Aug 2021 12:29:42 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 2/6] KVM: x86: add force_intercept_exceptions_mask
Date:   Wed, 11 Aug 2021 15:29:23 +0300
Message-Id: <20210811122927.900604-3-mlevitsk@redhat.com>
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This parameter will be used by VMX and SVM code to force
interception of a set of exceptions, given by a bitmask
for guest debug and/or kvm debug.

This is based on an idea first shown here:
https://patchwork.kernel.org/project/kvm/patch/20160301192822.GD22677@pd.tnic/

CC: Borislav Petkov <bp@suse.de>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 3 +++
 arch/x86/kvm/x86.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fdc0c18339fb..092e2fad3c0d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -184,6 +184,9 @@ module_param(force_emulation_prefix, bool, S_IRUGO);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
 
+uint force_intercept_exceptions_mask;
+module_param(force_intercept_exceptions_mask, uint, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL_GPL(force_intercept_exceptions_mask);
 /*
  * Restoring the host value for MSRs that are only consumed when running in
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 7d66d63dc55a..2b59825213c7 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -347,6 +347,8 @@ extern struct static_key kvm_no_apic_vcpu;
 
 extern bool report_ignored_msrs;
 
+extern uint force_intercept_exceptions_mask;
+
 static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 {
 	return pvclock_scale_delta(nsec, vcpu->arch.virtual_tsc_mult,
-- 
2.26.3

