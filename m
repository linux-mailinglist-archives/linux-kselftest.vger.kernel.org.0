Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD05BA605
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Sep 2022 06:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIPEwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Sep 2022 00:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIPEwB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Sep 2022 00:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5550A0306
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Sep 2022 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663303919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOBgBY51VPGo3XH10vBQxgJ7uR9+D8WGU5ehFHOdBgE=;
        b=VxFBrD2pkANx9AEzpw1ezthVBdaWI92SqjIcVK3ILTO67evS4K6OfuINda4yWKMdDMZexF
        gbnvZp5zcnxg9tC2IXusyBj7mqO/xwK6V/x9D+E6n/t2TL5T00JBvDRBhngxmeFuLEp+9Y
        pW0MEIOCt775bmnUvTzUovfqgRAMQ6Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-pQbKUtYYOCaCmTQgQlG5hw-1; Fri, 16 Sep 2022 00:51:56 -0400
X-MC-Unique: pQbKUtYYOCaCmTQgQlG5hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE9BB3C0D865;
        Fri, 16 Sep 2022 04:51:55 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-126.bne.redhat.com [10.64.54.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CFBB140EBF3;
        Fri, 16 Sep 2022 04:51:48 +0000 (UTC)
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
Subject: [PATCH v2 1/5] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
Date:   Fri, 16 Sep 2022 12:51:31 +0800
Message-Id: <20220916045135.154505-2-gshan@redhat.com>
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

This adds KVM_REQ_RING_SOFT_FULL, which is raised when the dirty
ring of the specific VCPU becomes softly full in kvm_dirty_ring_push().
The VCPU is enforced to exit when the request is raised and its
dirty ring is softly full on its entrance.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/x86/kvm/x86.c       | 5 +++--
 include/linux/kvm_host.h | 1 +
 virt/kvm/dirty_ring.c    | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 43a6a7efc6ec..7f368f59f033 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10265,8 +10265,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	/* Forbid vmenter if vcpu dirty ring is soft-full */
-	if (unlikely(vcpu->kvm->dirty_ring_size &&
-		     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
+	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
+	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
+		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
 		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
 		trace_kvm_dirty_ring_exit(vcpu);
 		r = 0;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f4519d3689e1..53fa3134fee0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -157,6 +157,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_VM_DEAD           (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UNBLOCK           2
 #define KVM_REQ_UNHALT            3
+#define KVM_REQ_RING_SOFT_FULL    4
 #define KVM_REQUEST_ARCH_BASE     8
 
 /*
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index f4c2a6eb1666..f0e49937bc9e 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -149,6 +149,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
 
 void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
 {
+	struct kvm_vcpu *vcpu = container_of(ring, struct kvm_vcpu, dirty_ring);
 	struct kvm_dirty_gfn *entry;
 
 	/* It should never get full */
@@ -166,6 +167,9 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
 	kvm_dirty_gfn_set_dirtied(entry);
 	ring->dirty_index++;
 	trace_kvm_dirty_ring_push(ring, slot, offset);
+
+	if (kvm_dirty_ring_soft_full(ring))
+		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
 }
 
 struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset)
-- 
2.23.0

