Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5862793F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfEWJbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 05:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJbV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 05:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A2798830E;
        Thu, 23 May 2019 09:31:21 +0000 (UTC)
Received: from thuth.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6E6E5D707;
        Thu, 23 May 2019 09:31:18 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Wrap vcpu_nested_state_get/set functions with x86 guard
Date:   Thu, 23 May 2019 11:31:14 +0200
Message-Id: <20190523093114.18182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 09:31:21 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct kvm_nested_state is only available on x86 so far. To be able
to compile the code on other architectures as well, we need to wrap
the related code with #ifdefs.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8c6b9619797d..a5a4b28f14d8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -118,10 +118,12 @@ void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
 void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 		     struct kvm_vcpu_events *events);
+#ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state);
 int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
 			  struct kvm_nested_state *state, bool ignore_error);
+#endif
 
 const char *exit_reason_str(unsigned int exit_reason);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cf62de377310..633b22df46a4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1248,6 +1248,7 @@ void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
 		ret, errno);
 }
 
+#ifdef __x86_64__
 void vcpu_nested_state_get(struct kvm_vm *vm, uint32_t vcpuid,
 			   struct kvm_nested_state *state)
 {
@@ -1279,6 +1280,7 @@ int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
 
 	return ret;
 }
+#endif
 
 /*
  * VM VCPU System Regs Get
-- 
2.21.0

