Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ADB617EA2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiKCN7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiKCN7O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 09:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3CE167E2
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667483885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJCktf5q7jZ9/undR/aqzDAHm9J60Hmp1ceVzBBD+a0=;
        b=d8Ku9R5NNYe54WWUHgUuEhBF7F81QUr0qrYeL6QVqsWpcJe2mmKVRGACyPN8GXIVo5dMHh
        ayujmVAvwqq4931ibpsI9nnxrAvXF8vFgcVZ+rK6zKKvwQX9gaVw2DMm94yEUmTXUWYht6
        /w6eYupn5OksKAGpf8PwCcLhUAduWMo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-_DK-PyTPOtS6QuwQ90BdBQ-1; Thu, 03 Nov 2022 09:58:01 -0400
X-MC-Unique: _DK-PyTPOtS6QuwQ90BdBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E92B3C0DDD0;
        Thu,  3 Nov 2022 13:58:00 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D832040C83AD;
        Thu,  3 Nov 2022 13:57:56 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Colton Lewis <coltonlewis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 5/9] KVM: selftests: move idt_entry to header
Date:   Thu,  3 Nov 2022 15:57:32 +0200
Message-Id: <20221103135736.42295-6-mlevitsk@redhat.com>
In-Reply-To: <20221103135736.42295-1-mlevitsk@redhat.com>
References: <20221103135736.42295-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct idt_entry will be used for a test which will break IDT on purpose.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/include/x86_64/processor.h        | 13 +++++++++++++
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e8ca0d8a6a7e0a..5da0c5e2a7afc4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -748,6 +748,19 @@ struct ex_regs {
 	uint64_t rflags;
 };
 
+struct idt_entry {
+	uint16_t offset0;
+	uint16_t selector;
+	uint16_t ist : 3;
+	uint16_t : 5;
+	uint16_t type : 4;
+	uint16_t : 1;
+	uint16_t dpl : 2;
+	uint16_t p : 1;
+	uint16_t offset1;
+	uint32_t offset2; uint32_t reserved;
+};
+
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 39c4409ef56a6a..41c1c73c464d48 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1074,19 +1074,6 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 	}
 }
 
-struct idt_entry {
-	uint16_t offset0;
-	uint16_t selector;
-	uint16_t ist : 3;
-	uint16_t : 5;
-	uint16_t type : 4;
-	uint16_t : 1;
-	uint16_t dpl : 2;
-	uint16_t p : 1;
-	uint16_t offset1;
-	uint32_t offset2; uint32_t reserved;
-};
-
 static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
 			  int dpl, unsigned short selector)
 {
-- 
2.34.3

