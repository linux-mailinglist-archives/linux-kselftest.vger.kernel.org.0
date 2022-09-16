Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED65BA60B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Sep 2022 06:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIPEwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Sep 2022 00:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIPEwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Sep 2022 00:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9CA0321
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663303930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvScjfkKuSDrLb00oYmoSVUq1hJaUCKKGbiWFg0bV0E=;
        b=cIRgKfbmtFbCP9ethpPmOOvm74e1xje/iFcqXyCT8JymrI3R7f/f3IJT9mF9E8cTT6EzbA
        8bXS4U60BJ5C5qsg8cXTH7bMFpKm9g0AuJbgCGwn29zHCCt5rZAiU2hKTUMKFKIFmUg/j7
        QSlIujwk4nhG40GX2QG6bkQLgB1/r/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-wtjeO_NONtu3aV4uaz66Lw-1; Fri, 16 Sep 2022 00:52:04 -0400
X-MC-Unique: wtjeO_NONtu3aV4uaz66Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D4D4185A794;
        Fri, 16 Sep 2022 04:52:03 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-126.bne.redhat.com [10.64.54.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C735140EBF3;
        Fri, 16 Sep 2022 04:51:56 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        catalin.marinas@arm.com, linux-kselftest@vger.kernel.org,
        bgardon@google.com, shuah@kernel.org, corbet@lwn.net,
        maz@kernel.org, drjones@redhat.com, will@kernel.org,
        zhenyzha@redhat.com, dmatlack@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, peterx@redhat.com, oliver.upton@linux.dev,
        shan.gavin@gmail.com
Subject: [PATCH v2 2/5] KVM: arm64: Enable ring-based dirty memory tracking
Date:   Fri, 16 Sep 2022 12:51:32 +0800
Message-Id: <20220916045135.154505-3-gshan@redhat.com>
In-Reply-To: <20220916045135.154505-1-gshan@redhat.com>
References: <20220916045135.154505-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This enables the ring-based dirty memory tracking on ARM64. The
feature is configured by CONFIG_HAVE_KVM_DIRTY_RING, detected and
enabled by KVM_CAP_DIRTY_LOG_RING. A ring buffer is created on every
VCPU when the feature is enabled. Each entry in the ring buffer is
described by 'struct kvm_dirty_gfn'.

A ring buffer entry is pushed when a page becomes dirty on host,
and pulled by userspace after the ring buffer is mapped at physical
page offset KVM_DIRTY_LOG_PAGE_OFFSET. The specific VCPU is enforced
to exit if its ring buffer becomes softly full. Besides, the ring
buffer can be reset by ioctl command KVM_RESET_DIRTY_RINGS to release
those pulled ring buffer entries.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/virt/kvm/api.rst    | 2 +-
 arch/arm64/include/uapi/asm/kvm.h | 1 +
 arch/arm64/kvm/Kconfig            | 1 +
 arch/arm64/kvm/arm.c              | 8 ++++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index abd7c32126ce..19fa1ac017ed 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8022,7 +8022,7 @@ regardless of what has actually been exposed through the CPUID leaf.
 8.29 KVM_CAP_DIRTY_LOG_RING
 ---------------------------
 
-:Architectures: x86
+:Architectures: x86, arm64
 :Parameters: args[0] - size of the dirty log ring
 
 KVM is capable of tracking dirty memory using ring buffers that are
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 316917b98707..a7a857f1784d 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -43,6 +43,7 @@
 #define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+#define KVM_DIRTY_LOG_PAGE_OFFSET 64
 
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 815cc118c675..0309b2d0f2da 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -32,6 +32,7 @@ menuconfig KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select HAVE_KVM_DIRTY_RING
 	select HAVE_KVM_MSI
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 2ff0ef62abad..76816f8e082b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -747,6 +747,14 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
 			return kvm_vcpu_suspend(vcpu);
+
+		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
+		    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
+			kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
+			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
+			trace_kvm_dirty_ring_exit(vcpu);
+			return 0;
+		}
 	}
 
 	return 1;
-- 
2.23.0

