Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4608928417
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfEWQnW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60781 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbfEWQnW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72318821D1;
        Thu, 23 May 2019 16:43:22 +0000 (UTC)
Received: from thuth.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 130DB643E1;
        Thu, 23 May 2019 16:43:19 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/9] KVM: selftests: Guard struct kvm_vcpu_events with __KVM_HAVE_VCPU_EVENTS
Date:   Thu, 23 May 2019 18:43:02 +0200
Message-Id: <20190523164309.13345-3-thuth@redhat.com>
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 16:43:22 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The struct kvm_vcpu_events code is only available on certain architectures
(arm, arm64 and x86). To be able to compile kvm_util.c also for other
architectures, we have to fence the code with __KVM_HAVE_VCPU_EVENTS.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a5a4b28f14d8..b8bf961074fe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -114,10 +114,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
 int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
 		    struct kvm_sregs *sregs);
+#ifdef __KVM_HAVE_VCPU_EVENTS
 void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
 void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
+#endif
 #ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ba1359ac504f..08edb8436c47 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1224,6 +1224,7 @@ void vcpu_regs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs)
 		ret, errno);
 }
 
+#ifdef __KVM_HAVE_VCPU_EVENTS
 void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events)
 {
@@ -1249,6 +1250,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 	TEST_ASSERT(ret == 0, "KVM_SET_VCPU_EVENTS, failed, rc: %i errno: %i",
 		ret, errno);
 }
+#endif
 
 #ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
-- 
2.21.0

