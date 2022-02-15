Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1C4B64C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiBOHs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 02:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiBOHsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 02:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B2CDA043F
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 23:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644911316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7mqaQERLi8FqjBn6o0qRtuyA3NkSe11glfd42h6C9JY=;
        b=SNK0X3icgeEfggyKHvXZO4jZotOmT1uvuJK2gGPkQePQ52IFdmcnCprogg0iWGxOeZ0SjI
        ZC/eDT72Pcnv8IasELhNB46X5lW4bIfmpJs/tgbIhB0DIAytSE31L0p5Xi1hm6LR/Wi7JE
        NtPwlXJ+Hl9vgR5SURL0bdXLnAkLQZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-6Q_O5W5LNZK5CC9nkERWug-1; Tue, 15 Feb 2022 02:48:32 -0500
X-MC-Unique: 6Q_O5W5LNZK5CC9nkERWug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A0A2F26;
        Tue, 15 Feb 2022 07:48:31 +0000 (UTC)
Received: from thuth.com (dhcp-192-183.str.redhat.com [10.33.192.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10F362D7B;
        Tue, 15 Feb 2022 07:48:26 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal guests
Date:   Tue, 15 Feb 2022 08:48:24 +0100
Message-Id: <20220215074824.188440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
guest") fixed the behavior of the SIDA memops for normal guests. It
would be nice to have a way to test whether the current kernel has
the fix applied or not. Thus add a check to the KVM selftests for
these two memops.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9f49ead380ab..d19c3ffdea3f 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -160,6 +160,21 @@ int main(int argc, char *argv[])
 	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
 	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
 
+	/* Check that the SIDA calls are rejected for non-protected guests */
+	ksmo.gaddr = 0;
+	ksmo.flags = 0;
+	ksmo.size = 8;
+	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.sida_offset = 0x1c0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL,
+		    "ioctl does not reject SIDA_READ in non-protected mode");
+	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL,
+		    "ioctl does not reject SIDA_WRITE in non-protected mode");
+
 	kvm_vm_free(vm);
 
 	return 0;
-- 
2.27.0

