Return-Path: <linux-kselftest+bounces-45884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B438C6AE61
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3937A4ECB81
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7363AA1A6;
	Tue, 18 Nov 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvPdnyOA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5B29AAF3
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485888; cv=none; b=NbTiCtqXwUw1J5ZqmBSUpKVcIm8L0pJB4v+n9njOJRHr1M/TfOJhLUPm1K5SOsvurF52gIo/Gk0+zHWccOuVLSo7qaAziAhVE1q1Id8jwfzPZWrSbrI6dGZjdIiRPVQizN3j/Orx6cOHt4mdZJSH0T0SzlwgUjfnntZXEXJBdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485888; c=relaxed/simple;
	bh=PJXfOYUgQ/koH9RKoJHaRKsC+CsEh7NIL8+BGeZYdZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV5QI/TdXmqe/Dx41CrnziZNH4JpuAQWdNmG5VSQrVPH5j8L/br3gUjKSWlVbcMiFWBO5HoGJHzS2ilbYnoGk1z2Qfa++iqTPGV7Aq9bJKdI3q29xme/Gp9J1lKc+PJacqXu7+B535FoOH9pzzlbj2Mz+/LAazZIxJadd2TeuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvPdnyOA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477aa218f20so6910145e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485883; x=1764090683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siFHznuHrhv1xGgfDI5kE0TqLDfCEZnyaPZRcY6rR3Y=;
        b=RvPdnyOAMSIXCg5BDXB3EL0IDKorAWnXWdHbzUL1zfrhBE2SH6Gr1tQMOaAPZSpL0d
         BZ3pgqQGlIZ7jAfr210ymmjdgR4oXmcJfral+ZZltiShQ/I6N9GqUICh4ZmmG3za9d96
         J7z0lpAdxumeseY7d7yixRueQJwxMgE+P5TSeH2B4mhiPON4uWYkpvUTWM1miCz/IDB0
         Q6LusKbL0ipdyigAkAheslEztooOaYJXHPFlohznGC22MxSjRiWD5BjsElMUIqDIrn85
         PlFeQM+oGAPHUAQ1XEfHmz6vrtaodVwV+2B6fyPAW2IfAi9TDD2JK0lRnkEwXjwrXvqB
         AS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485883; x=1764090683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siFHznuHrhv1xGgfDI5kE0TqLDfCEZnyaPZRcY6rR3Y=;
        b=to1fK1S520RH+aQqZvtFwXtLWPpFQLKgqLtw+m1gUHJaHIPleEFsrdY+0S72YhWybs
         K9F6r6N8lkkA8KIxLo9EgylBpXeNja4zEQB6yN3hUvzw6LXTxsHBNDcWPl08JYwQjUZ1
         8RVTC1UYuoX8+fWI617RKZ0LdJ6OX7DUFGc+QUqyW2DYNvfBB6IVvc3lTDqIO+xDN4Mr
         s4qUwaeXzkEtLPOtx27w5xlyXU5ZxNvGdLex3O7J/Acc0MsVJ/m8Kfe7azGQbyAvLYOi
         +0y4dCJBR3MPgVPWXKTwTwRSJMYWbWvotQM5Phys8xA6OOW9pxysruqD67zgbZ0whlS9
         XCKA==
X-Forwarded-Encrypted: i=1; AJvYcCWwb7T8M/PB/YfVzu9oxTbJfWRTrCjOVM3F760inCHZmc7MoHhRQgCpZn614y64BzrsSOVHqa0/JGV9iiShZsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokyafPvEeeP6Y6xu8AKPlQfjYMTJkCnEruxuMvpRWDhWitvtN
	YHQNVaCNiJjOCZ9q+AEhnAVpklOUcaQlX4jFA1s8BBCLjkKs+MaRtXNN
X-Gm-Gg: ASbGncsr3JDXQlI6/EKVld9nUN9AtTdxQMVGEvMv/QrzPVTHYj1L2G0//+kv69tUSOK
	xUjNObg2g8BKMbY1kx1i34cH7WziZi9y+7OY+skK7O+SfEtufJPCSicA+8ekxFgGti1ro9/7Z0D
	RuUaj374mIpSh9fq9+PI1Ulm/LQSHmhXd9iT1LNy4K29bu5476D4ErCB6lSM/ZOPTfrpIdqHqP9
	qDOTxbyTjfImJPJsfdLOACDC1F37WFuiL88LGjCpS3HNzDkz5i+6b2Vg923LKovbQpn5DRamBVK
	baNjLBeWyicxPuLes0tB3hYVIGEH3SBuCcGQv4CfvzlpUPD/pYSdMfl/Jb/ukCtAm9XcBDOzuJH
	Xjb+6nPcBSJlMqSxTA4YTP+QirPBqOCKBALkeYI+kjko/tCDkhJ6RTjyhQC50JmoFU7PEoA4H/B
	kcuWCQvq+X5f2iKpvezf1tbRrxsHEW5FfTFX7eZff1RLq4cjd56fnaIp+Vty+L0od5Tf/JOmGLD
	NgkgDieZqBwAQ1Z9bdMlWGwhzYaFju8vmyrQTqc6H8=
X-Google-Smtp-Source: AGHT+IEsc9qshXMo1MZ9h5TXUYy1hPn5Z+YQvhGiarIKg24AewgPdrGERLkgj3wJlAvljKWYB9vjUg==
X-Received: by 2002:a05:600c:45d5:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-4778fe57241mr164751365e9.11.1763485883079;
        Tue, 18 Nov 2025 09:11:23 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103d312sm706385e9.13.2025.11.18.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:11:22 -0800 (PST)
From: griffoul@gmail.com
X-Google-Original-From: griffoul@gmail.org
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v2 03/10] KVM: x86: Add nested state validation for pfncache support
Date: Tue, 18 Nov 2025 17:11:06 +0000
Message-ID: <20251118171113.363528-4-griffoul@gmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118171113.363528-1-griffoul@gmail.org>
References: <20251118171113.363528-1-griffoul@gmail.org>
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


