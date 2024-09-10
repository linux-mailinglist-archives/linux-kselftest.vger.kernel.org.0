Return-Path: <linux-kselftest+bounces-17615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C127973BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27224B26C50
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7219E827;
	Tue, 10 Sep 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="u9duiKmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962819AD81;
	Tue, 10 Sep 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981972; cv=none; b=YyjULrgjz0s/rJrzFfkJTWA5wuBYNTbGUWpzp+hr3JPkVLQPmgjE6vgFHJt8X34+0pzclWABiI9b8XgP07Wl1EZrrUxiTjfIM8Emfjc9rGVRHdxl04+Gwit9GjPitXU7h8Wux2oFUZKkUflVGjhqzITHrlnzI7qT+gZvc27Go/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981972; c=relaxed/simple;
	bh=++HidJlPLgLwaU/8+cLxxidpjLOQ5iKZF0hGZox10tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpBRFKmYfv9Vy67Rv/IPZgL7G9DyXMkGugBWovm8+WI8WYiIjN6j6a0VeEMqEHQCIgirTPrlGIFhc9pVuLzFJAZ7Re97Y2lHYVATK/5y2/lzQjr2C4vnOUyoUromjhbkF40eINAl1OKZesv/pEQx2wf+wYl4W+Nk4hwhMbNgTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=u9duiKmX; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981971; x=1757517971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyhv+EAHgrh/iCvCQUdCsSUgOa9xa1Wd76nhgoQDloY=;
  b=u9duiKmX9pqi7g76xsw1uex/8eLRjCIQExkQ61YVv10C8vPtLateKtV7
   JzDr5Y5pj/EqIYyJ4fXbysWZJwEMgKKKyXBwgityWjWtHoSJG5rhpllgw
   M6oal1X7MYuwXeZHg4YT+XCtOjAZhPZEMc/ErDv3nswmSeM/GEE4WvHTA
   0=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="432460735"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:26:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:10936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.253:2525] with esmtp (Farcaster)
 id c98c2613-8b3f-4de2-87d9-65fcddd7723f; Tue, 10 Sep 2024 15:26:06 +0000 (UTC)
X-Farcaster-Flow-ID: c98c2613-8b3f-4de2-87d9-65fcddd7723f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:06 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:26:03 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 13/15] KVM: Add KVM_TRANSLATE2 stub
Date: Tue, 10 Sep 2024 15:22:05 +0000
Message-ID: <20240910152207.38974-14-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add stub function for the KVM_TRANSLATE2 ioctl, as well as generic
parameter verification. In a later commit, the ioctl will be properly
implemented for x86.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c78017fd2907..de6557794735 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1492,6 +1492,8 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu);
 
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 				    struct kvm_translation *tr);
+int kvm_arch_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
+				   struct kvm_translation2 *tr);
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d51357fd28d7..c129dc0b0485 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4442,6 +4442,32 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 }
 #endif
 
+int __weak kvm_arch_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
+					  struct kvm_translation2 *tr)
+{
+	return -EINVAL;
+}
+
+static int kvm_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
+				     struct kvm_translation2 *tr)
+{
+	/* Don't allow FORCE_SET_ACCESSED and SET_BITS without SET_ACCESSED */
+	if (!(tr->flags & KVM_TRANSLATE_FLAGS_SET_ACCESSED) &&
+	    (tr->flags & KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED ||
+	     tr->flags & KVM_TRANSLATE_FLAGS_SET_DIRTY))
+		return -EINVAL;
+
+	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_DIRTY &&
+	    !(tr->access & KVM_TRANSLATE_ACCESS_WRITE))
+		return -EINVAL;
+
+	if (tr->flags & ~KVM_TRANSLATE_FLAGS_ALL ||
+	    tr->access & ~KVM_TRANSLATE_ACCESS_ALL)
+		return -EINVAL;
+
+	return kvm_arch_vcpu_ioctl_translate2(vcpu, tr);
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4585,6 +4611,21 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_TRANSLATE2: {
+		struct kvm_translation2 tr;
+
+		r = -EFAULT;
+		if (copy_from_user(&tr, argp, sizeof(tr)))
+			goto out;
+		r = kvm_vcpu_ioctl_translate2(vcpu, &tr);
+		if (r)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user(argp, &tr, sizeof(tr)))
+			goto out;
+		r = 0;
+		break;
+	}
 	case KVM_SET_GUEST_DEBUG: {
 		struct kvm_guest_debug dbg;
 
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


