Return-Path: <linux-kselftest+bounces-48063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C0CEEBE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6FEE3002B85
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA03128AB;
	Fri,  2 Jan 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj2qa9Pc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6F3128B1
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363883; cv=none; b=VuRcP1R+3iycyOUJsbtITpmoTjv2souRzgdW5BLF1LqeVGR5wB765cJ0vmByxSiyYaDQtFpug6ilZpX0UJty8rjjGgkt0e1KyXMevtn4q2Hmy0Z9r/Oqh97IuxeScBGzaTOM9w8/puNxHyJtXg8ZII0Y4VGK+QKVmZMwhcKGgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363883; c=relaxed/simple;
	bh=8bCdguI0P+zHvk9Zmg8dH3bElWlltPCX/49uN95TJ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibtl+6RNfsIeE7qMMU3N7aT7iZWEUQmfy+bbbr4uLJlgoIuFU71uO5vmIYrHg13OGx+4OY7dMZcRj1c0DHSPyQvKIBVVDeWMsQMPDniqXGhyZBqr846LnJVEN7bIyfGxuEMst0J1rR8FDgJpbZ+lRGRwQc30YLNXF/W8+pCU1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj2qa9Pc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso1999025e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363879; x=1767968679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUDBG+Z446ax35YwK/0xo41xTx4t//UNWGzLYXJpIEI=;
        b=jj2qa9Pc9jCcgFtWvo6SrF3BL7Bm5m2AykaxbH0/Mz5Pwy1MTTZUSv38GmXWSSN9WN
         jRQWzd6fllyESfv6vUL0rRRRIvEDZ0v6VcrCAGnmBIduOYhhx2ikC4HH/tLftnsG9uN3
         s/EtRnj+K2m+NNTRtKfC8qzS2ey/3ua+43FeWQH+86quTa+VB/ACqo/sKi65V9QJ3q5W
         4/RmUNE3KhsKR4pcQq95Ks2iWxmZDudr4nOVUFZba4zKUWm7DhqWr3gLz8TqWLabvZet
         1IPxnMsPGW0eUg/h98mEVKC8Ib86RsZrXk8kzBShTs5XqAGqKjkD9SE0x7Wyvd5fP6PP
         x36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363879; x=1767968679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUDBG+Z446ax35YwK/0xo41xTx4t//UNWGzLYXJpIEI=;
        b=c5HciYrMfU97TxzAIgunJlx8Rp8h8gUYEOjPf9hoSzXNW0yojc+0cNSsERBotsPVvC
         IvcC+wNNCVkG3B/yqLjgIkSna99+UFkJOYQVCguuvr+29X8pucTwj1/cXqsSj+QKlFMb
         iWsOCOawTTv08+iyIa1Jj/QTCIE/YCq/7yb5hyzH95w2zuE+pS2OxeyPSlfMG5VCfuVs
         YxOJ/1HDu8S0BCBnSoN6NkqaJvWm9GqCq2x3Xt7YeZ9kRWcWju0CKfCgN085+q9Q6UuX
         0k5cynJXDDOYiNi4Bk8BZGYVpzwxEVnFaVhFAjJE8iHQjmrbCm7UaEuUZzgB5pyiX4OT
         jdwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyjsAGEODNeEea8LOiejzl4XOCjCR1+f4z9pteJCR+VP6uURyMtYQBke9DMsGMcvTTppzPpp+No6fYSzFiu8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyi++IEoU40HoNpbJXvAnCaV07jPXEgqSQ/f50nC/jmsxSZcU4
	0KYIFbT1QZBDY2Z3nVqrbTJAncwAeNXi2NZDjiXgI8MhWWUFg5fwFG0s
X-Gm-Gg: AY/fxX5c00mmUwmkqSx+q+KMQmgvaKFVtyzM0Oq7eTcyqEmd4gHkjXfoxThkFEy76ey
	1fRRc6DChsQDr+DKzTZ8C2W/ucJIlZ+xZjM/RDM3TckugCIBjNC0NBE3J8G3i9Ur1oRfzSaGKaW
	YXtUyAhuTiv8eK4HuSJAgc+Of0xSSpIEs1WHNNxWR5Q80ZUYj0G9QJK7ldfckctFqrfr4WmuCtw
	KeJgEVBCgOsQHDrHt/tUnopkdZauNKsedyXpumROZVk83hWt3NxncvRm34QZR4OTQ/tn+y2KiZz
	oxNF36oqcZQ+oUUjQJ1xzFjTHkgtO+1G0mEDCsjrUyh+pSx9pQVpvEBOfAc0TTjvhqfIQslUU1k
	OYcmcau8+SV/NLvD79q3XDMb8ARtu/e8GeLmaOlEIH8lSrn6fw5lhEAM5d4Lu/gH32B2Ru7Q1FZ
	6w+u8N0lg6NqCda0nwFX9YthMYTHZ0r/jUPBREFl6aHE0lPaXUe9gTV6E0K0Xag+/jYyX/1ngfa
	/WuiKB/fQh2auW1QiFKJkKhA90KmQkh
X-Google-Smtp-Source: AGHT+IFuDIAl1iFvecTNI2RuxGtGC16JVZwqR1iDuYqgqETza5wGni24k5vxvT73r6kYc/g0EdQt5A==
X-Received: by 2002:a05:600c:45d3:b0:47d:4044:4ada with SMTP id 5b1f17b1804b1-47d40444b44mr363810125e9.13.1767363878923;
        Fri, 02 Jan 2026 06:24:38 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:38 -0800 (PST)
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
Subject: [PATCH v4 03/10] KVM: x86: Add nested state validation for pfncache support
Date: Fri,  2 Jan 2026 14:24:22 +0000
Message-ID: <20260102142429.896101-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
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
index 5a3bfa293e8b..c9a1a43fbfde 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1956,6 +1956,7 @@ struct kvm_x86_nested_ops {
 			 struct kvm_nested_state __user *user_kvm_nested_state,
 			 struct kvm_nested_state *kvm_state);
 	bool (*get_nested_state_pages)(struct kvm_vcpu *vcpu);
+	bool (*is_nested_state_invalid)(struct kvm_vcpu *vcpu);
 	int (*write_log_dirty)(struct kvm_vcpu *vcpu, gpa_t l2_gpa);
 
 	int (*enable_evmcs)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f05828aca7e5..a97d02b08ab8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3541,6 +3541,11 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
@@ -7485,6 +7490,7 @@ struct kvm_x86_nested_ops vmx_nested_ops = {
 	.get_state = vmx_get_nested_state,
 	.set_state = vmx_set_nested_state,
 	.get_nested_state_pages = vmx_get_nested_state_pages,
+	.is_nested_state_invalid = vmx_is_nested_state_invalid,
 	.write_log_dirty = nested_vmx_write_pml_buffer,
 #ifdef CONFIG_KVM_HYPERV
 	.enable_evmcs = nested_enable_evmcs,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff8812f3a129..d830770363ab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2257,12 +2257,24 @@ int kvm_emulate_monitor(struct kvm_vcpu *vcpu)
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


