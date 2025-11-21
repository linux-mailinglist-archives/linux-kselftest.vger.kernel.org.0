Return-Path: <linux-kselftest+bounces-46212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A69C78B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03C3D4E9316
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EAB34A78C;
	Fri, 21 Nov 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNYqPw+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05784347FCD
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723492; cv=none; b=X8lOzcyYu3hk5OZs56w3rvgsIrNddUZOrOgIPep3qgvrpunwQnD04HtaItbISiRbN0KePjtvcRSoGqUhQSPj15UgFAnBLKztgW2enGy+/jvhq8hdqy+i88E1mmxQYYYpNuuhlBv7XT8y5NiufgD0rbu6Eh2BoJrjq1x53b6ieIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723492; c=relaxed/simple;
	bh=PJXfOYUgQ/koH9RKoJHaRKsC+CsEh7NIL8+BGeZYdZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/zg6gXN5OPcF7dNKnxfEx04U3UeW6wB5hdkVxQNiziT9hT0j7mtjCVwIH6M5PRl4+4djWdZaRAMJ5mWcaiMtrlxiPfJ0bibBW1fJawgUkgVSzs2QOKSgqV0frwUvB/ckrR1Mc6jprK9cEX2lJlcN0sspgncK+r2LSbQsuDFGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNYqPw+N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so1890670f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723487; x=1764328287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siFHznuHrhv1xGgfDI5kE0TqLDfCEZnyaPZRcY6rR3Y=;
        b=lNYqPw+N4EPoEcrfikcCNZxY1lNNAfsKecWuiQ+BUQXp/C+6LbeeQz4IDCEVgRrZRM
         Dgi4teePinz4GWLy1pVXamMMIwWutpdBHnE2Xuj1nHkfB7xfP79JJ3u4z7uFfTZWOOqr
         /Nj3+auWHDbSzQEsEQyWK/ZhKzncpPakAiBBGCR+IrND2YOk0/u3rhVyQg4G5EHA1P7S
         jwy0vRu1tqhhp77XCg0kovGE8mkt8q3/evM1uZgdVnk2CkKvaxlGlnVXsD3ihbhZFzke
         QqfK1S4bwa75oLpr+LDz1DCaRtxwjgBh+BSnNahIMbEDbQsACFZAwDXZKjceHVW/64bS
         l5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723487; x=1764328287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siFHznuHrhv1xGgfDI5kE0TqLDfCEZnyaPZRcY6rR3Y=;
        b=Jaq2NiK0GkvYKk6JcpFmDJEyZ06GjQg4RWNAM8GX+w2DMDYqPqvZ7J2PiiWduQjjTE
         wsrbyWZ3e8sr7P+p2K5+qrcgi01DJBNR5oiQKoxBI1ognBWSkYZGEiyENGpeS5wVdr+e
         l2kOVMqqrY21wv32yvS0t93nAj5dRsqy64/5zP2ZW1k9Q6BdMghfBntahJzF2rsX4Tyk
         Zq4rWfN3L83MY71TZ6WdkI/MhiQyDM9Y43AYjNlRzr33U9MmOvfjPUFSjEIv4Ho73V9H
         GEC4/kD9Az1jdAQJV0m6qyH/50EjsecIr8r+nw/B3MwuA1KNGq6WeKVNoO3xg5y5ahb4
         pHMw==
X-Forwarded-Encrypted: i=1; AJvYcCVBFDGt/f/sAzGMRzYtpWzKP3SncRcaQQ14OEgdGcYHT9vaAEmS6qF4hNCJcSv2ZeCRVrx+9KIhY2YroWkz9x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxE8DOtNHif74D4O9IXO/6hrrxpMWipdoGmXK6ucIvb0IUqn1
	7+U1VoeHR1g0at1BvLWA2lXS+7l7JSwFClPgfC6MUx3RgONRzvNZc5AS
X-Gm-Gg: ASbGncvChTi8Ce0VHKIfS7HRLnIVlWzxrfamkYBVeeGazMoNJ7yoeAPfp6nhfpPuuS1
	KD2j9mkKwFAtha7D5zR37WfnL6R7efmeq0FCc+Q3di1QRBvgtlE/L1pGC1V5Rn+gYwrs9VzPyXK
	FSM5Pg8G9IGfaq7Zc6rWrfDBMuayWNz3bciq8ngblfrCoWRy8nPkt3Kd9EfL3lnIn4l9FaxlGMc
	FoU1t7GLWeA3MkP/ruEB7gfdOiKT3fHuLG2aDwmd8ejQiL1f6WVGsjc4bn/i8fvlWkZ+iWIH7Qh
	IMUs+r/ZP64cta5Z9A3U+8VDbR69NlzrMFPuE5kh6H7pkc59fbUy0EoZf1bb0E5+rMsXl1J89uv
	oJGbj5/QjjVET09db5V5gg29CNHYM7nxw0U6HQPrJ4+Y7QEB9Zg1G8AXZhsBIF0T58qfp+eZ3DH
	USpi8UnNJIfII6X0Qun6eIFb18F9sn2M5JUpcuXjWvm4AR2xy9Pf32oCt9GkbTzHiXnmgNvxYmI
	dlQv0lKQhLCOoxWB/nj/OfWW9BGCFPZ
X-Google-Smtp-Source: AGHT+IE5dgFYA+xYxxyFQN3JmCdA/JLY8RAcFtgzm4PUr5ke2lXeNl51iCj4HMCTmRGjYFM/hXQn3A==
X-Received: by 2002:a05:6000:4305:b0:429:ef72:c33a with SMTP id ffacd0b85a97d-42cba63b5e9mr6506218f8f.3.1763723487033;
        Fri, 21 Nov 2025 03:11:27 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:26 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v3 03/10] KVM: x86: Add nested state validation for pfncache support
Date: Fri, 21 Nov 2025 11:11:06 +0000
Message-ID: <20251121111113.456628-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Implement state validation for nested virtualization to enable pfncache
support for L1 guest pages.

This adds a new nested_ops callback 'is_nested_state_invalid()' that
detects when KVM needs to reload nested virtualization state. A
KVM_REQ_GET_NESTED_STATE_PAGES request is triggered to reload affected
pages before L2 execution when it detects invalid state. The callback
monitors L1 guest pages during guest entry/exit while the vCPU runs in
IN_GUEST_MODE.

Currently, VMX implementations return false, with full support planned
for the next patch.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/nested.c       |  6 ++++++
 arch/x86/kvm/x86.c              | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..4675e71b33a7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1960,6 +1960,7 @@ struct kvm_x86_nested_ops {
 			 struct kvm_nested_state __user *user_kvm_nested_state,
 			 struct kvm_nested_state *kvm_state);
 	bool (*get_nested_state_pages)(struct kvm_vcpu *vcpu);
+	bool (*is_nested_state_invalid)(struct kvm_vcpu *vcpu);
 	int (*write_log_dirty)(struct kvm_vcpu *vcpu, gpa_t l2_gpa);
 
 	int (*enable_evmcs)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0de84b30c41d..627a6c24625d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3588,6 +3588,11 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static bool vmx_is_nested_state_invalid(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 static int nested_vmx_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vmcs12 *vmcs12;
@@ -7527,6 +7532,7 @@ struct kvm_x86_nested_ops vmx_nested_ops = {
 	.get_state = vmx_get_nested_state,
 	.set_state = vmx_set_nested_state,
 	.get_nested_state_pages = vmx_get_nested_state_pages,
+	.is_nested_state_invalid = vmx_is_nested_state_invalid,
 	.write_log_dirty = nested_vmx_write_pml_buffer,
 #ifdef CONFIG_KVM_HYPERV
 	.enable_evmcs = nested_enable_evmcs,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b8138bd4857..1a9c1171df49 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2262,12 +2262,24 @@ int kvm_emulate_monitor(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_monitor);
 
+static inline bool kvm_invalid_nested_state(struct kvm_vcpu *vcpu)
+{
+	if (is_guest_mode(vcpu) &&
+	    kvm_x86_ops.nested_ops->is_nested_state_invalid &&
+	    kvm_x86_ops.nested_ops->is_nested_state_invalid(vcpu)) {
+		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+		return true;
+	}
+	return false;
+}
+
 static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
 	xfer_to_guest_mode_prepare();
 
 	return READ_ONCE(vcpu->mode) == EXITING_GUEST_MODE ||
-	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
+	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending() ||
+	       kvm_invalid_nested_state(vcpu);
 }
 
 static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
-- 
2.43.0


