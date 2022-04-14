Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F092500B20
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 12:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiDNKdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiDNKdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 06:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75C6A56752
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649932238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vf8insFKsm0H/Xa5O9Bfm1akCLF8f2bCQgFw5dYlces=;
        b=UrJ9ccyRL2F+VGr2Aj2tfjcE+WpIsRePnixMKHrI8N6jlFWtgMZSXQrt1OS25pUpjLylla
        VhxdyFHRi9A2deO59l0dUhF1oFwsQgzZyzZ+Dy6SFE4Hv3IG7X6ruIC+I7ywzV6LL339iN
        bWpLeJmKWVhglbiQTyItZ8RGYRO3Hy4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-hAC-ND9RORqzAfxDFTvCPw-1; Thu, 14 Apr 2022 06:30:35 -0400
X-MC-Unique: hAC-ND9RORqzAfxDFTvCPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C1B438009EB;
        Thu, 14 Apr 2022 10:30:35 +0000 (UTC)
Received: from thuth.com (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E707B434844;
        Thu, 14 Apr 2022 10:30:33 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH] KVM: selftests: Silence compiler warning in the kvm_page_table_test
Date:   Thu, 14 Apr 2022 12:30:31 +0200
Message-Id: <20220414103031.565037-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When compiling kvm_page_table_test.c, I get this compiler warning
with gcc 11.2:

kvm_page_table_test.c: In function 'pre_init_before_test':
../../../../tools/include/linux/kernel.h:44:24: warning: comparison of
 distinct pointer types lacks a cast
   44 |         (void) (&_max1 == &_max2);              \
      |                        ^~
kvm_page_table_test.c:281:21: note: in expansion of macro 'max'
  281 |         alignment = max(0x100000, alignment);
      |                     ^~~

Fix it by adjusting the type of the absolute value.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/kvm_page_table_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index ba1fdc3dcf4a..2c4a7563a4f8 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -278,7 +278,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	else
 		guest_test_phys_mem = p->phys_offset;
 #ifdef __s390x__
-	alignment = max(0x100000, alignment);
+	alignment = max(0x100000UL, alignment);
 #endif
 	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
 
-- 
2.27.0

