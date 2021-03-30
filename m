Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4134F19C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhC3Tam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 15:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233128AbhC3Tal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 15:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617132641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eTWTr8cAwYev5yD8LuZQ3faxQx+nRJ4mRBG0w/bSeiQ=;
        b=OIXvJaj7fTR6rzyC5QQHh1NXo9W99hjnT1glkX/Xa+d0BMBOR7QlR7ccJAZiXMAnysoopc
        HmR7PAYeXepusWcj/uhrJynhMJOzJvwC7ZU4vGgw4eRqIEloozFHIZZPTPAYvmjJYr3f8d
        Fe7klVA5fnrDsvJiNjJMffD8TE/dgug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-VdVI23fzMqqwbqr38R4dmQ-1; Tue, 30 Mar 2021 15:30:39 -0400
X-MC-Unique: VdVI23fzMqqwbqr38R4dmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F069CDA4;
        Tue, 30 Mar 2021 19:30:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99F9719C44;
        Tue, 30 Mar 2021 19:30:36 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] kvm: fix minor typos in x86/kvm.h and selftests/processor.c
Date:   Tue, 30 Mar 2021 21:30:29 +0200
Message-Id: <20210330193029.47746-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h              | 2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 5a3022c8af82..e00d44bc5f55 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -190,7 +190,7 @@ struct kvm_msrs {
 
 /* for KVM_GET_MSR_INDEX_LIST */
 struct kvm_msr_list {
-	__u32 nmsrs; /* number of msrs in entries */
+	__u32 nmsrs; /* number of msrs in indices */
 	__u32 indices[0];
 };
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index a8906e60a108..e676fe40bfe6 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -714,7 +714,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
  *
  * Return: KVM CPUID (KVM_GET_CPUID2)
  *
- * Set the VCPU's CPUID.
+ * Get the VCPU's CPUID.
  */
 struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 {
-- 
2.30.2

