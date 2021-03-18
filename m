Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2D340891
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 16:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhCRPQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 11:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231683AbhCRPQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 11:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616080595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vE1dYwm/OYVGmvG6Nwn7AfjNErBRScb3qhVkqFMoRok=;
        b=Wx1WGfewscAVa3dh/+HidK85wjXdeyw1Z1vgcBbIvqhAD7y/Y7ZL2v348hgK4b6/qNN4qp
        OZDAziRXKYIUvG0pg/rbgYidTucu6vs0jMcRJxTyFieyP+DzXH2wRPg2WB8Glzggy+V4GY
        pl2WIljjeX3c80gm+idsvC4Ng/00bOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Bf9FYAKJNnq8jDgJ8HOAnQ-1; Thu, 18 Mar 2021 11:16:33 -0400
X-MC-Unique: Bf9FYAKJNnq8jDgJ8HOAnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 821E0593A3;
        Thu, 18 Mar 2021 15:16:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 996731001B2C;
        Thu, 18 Mar 2021 15:16:25 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2 1/2] kvm/kvm_util: add _vm_ioctl
Date:   Thu, 18 Mar 2021 16:16:23 +0100
Message-Id: <20210318151624.490861-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As in kvm_ioctl and _kvm_ioctl, add
the respective _vm_ioctl for vm_ioctl.

_vm_ioctl invokes an ioctl using the vm fd,
leaving the caller to test the result.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2d7eb6989e83..d53a5f7cad61 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -133,6 +133,7 @@ void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
 int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
 		void *arg);
 void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
 void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 int _kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e5fbf16f725b..b8849a1aca79 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1697,11 +1697,16 @@ void vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 {
 	int ret;
 
-	ret = ioctl(vm->fd, cmd, arg);
+	ret = _vm_ioctl(vm, cmd, arg);
 	TEST_ASSERT(ret == 0, "vm ioctl %lu failed, rc: %i errno: %i (%s)",
 		cmd, ret, errno, strerror(errno));
 }
 
+int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
+{
+	return ioctl(vm->fd, cmd, arg);
+}
+
 /*
  * KVM system ioctl
  *
-- 
2.29.2

