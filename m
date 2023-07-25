Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE7762599
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjGYWDx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGYWDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB643A86
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5634dbfb8b1so2801035a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322555; x=1690927355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsBS7k8bBReIl/gHH9kbfcLhxHw1lqqyuWyKVcuOGx4=;
        b=e5iRB7HbY0HCZBIgKoiJvs6hXr3F1dZh9Vqp9ysCQoH4sFqmNeYyYZIoneskM/b2UZ
         KRkXQ+0os9CNXTLr9DJf6yZFGc8ncDPoU8RdJTOOtu4LLMMTgu9t7khqF1FmcdG4ncBR
         74QSRxpYBnaMb68bqn8yyfjfCd3XanDr7a+bEZ5/nhcEkV2aKsbvrCvijBq42VBcToy2
         PAlp/Q/RAKe+DE6ULklvTY5fxMlO+aAc23Da+F9mZ0dqqAPib3BzgS3on/B8V0BRwmUW
         /3VSEF4rSux0iZeMUEO4EeFL7xWfnd2GGMgsZW09mJhdy7kKGI9Cny5iyLqEnSOKreef
         jL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322555; x=1690927355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsBS7k8bBReIl/gHH9kbfcLhxHw1lqqyuWyKVcuOGx4=;
        b=WVHd9ARvFLaPYM2myU5LTpWOH6C7niOS/8mBGVY4g1HXCAu1OArHBYFDkFBE8EkoiF
         bYqLhrN0wpVph4/87nFSxmKBL2NNCKyTlJsQjjFdIR9tIoeDtAANPAlgrlGmqFS3C85W
         1UWhSsD3ukAuXfVgrSbNod1Aq7Q5l5+079QRt2PjduarqpNVnPm4kUbDuoC9I2BeqEHM
         wg3KBO2cUM4mV3w6dCd08ZaqyyI+VqLSNsWr+aH57QuPP7upfGHSiJEpbNrhJidmti88
         us+lEYMTaqxZ+iy+SQKRsSJT86vqwbxzcVsvMzmFje80j7iAUgqsVjnDp5fec8CmpAyz
         JL1g==
X-Gm-Message-State: ABy/qLZk6d7l9IqdiEXDuVmnhIvNekV5R1KENJ0FFlAb1z5ibOcpiGjw
        K/VkV0wiZXCdny5lxAD9wRILfj/YKSBXJHEhQ/+oOKfGW0P1wuLQdoPvUbRtt4EqMYf8TjvyCeP
        1HD1zBttPh2kuiRlSQQxkyPqCksMGDN4d10T/hcwZVxlcV7H4+u6yRcRZMfn0aIIiN/o7frEajL
        mD
X-Google-Smtp-Source: APBJJlHRoMNVyyg+IsDkk5apOFRfJvxDaF0jUd2p0D/mElXiKebhnUs6z5/HZPfO4XBZUEbbn1+u1HIQjkK8
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:7d1a:0:b0:55b:4887:9e99 with SMTP id
 y26-20020a637d1a000000b0055b48879e99mr2179pgc.1.1690322554792; Tue, 25 Jul
 2023 15:02:34 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:17 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-25-afranji@google.com>
Subject: [PATCH v4 24/28] KVM: selftests: Expose _vm_vaddr_alloc
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

vm_vaddr_alloc always allocates memory in memslot 0. This allows users
of this function to choose which memslot to allocate virtual memory
in.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I2755287f0c0c2983d278094776a3c51d1c9ce448
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c          | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index d793355599e1..4d02d1e6eb53 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -511,6 +511,9 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
 vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t _vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+			   vm_paddr_t paddr_min, uint32_t data_memslot,
+			   bool encrypt);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7db9437505d7..bed218c4f8b4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1393,7 +1393,7 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-static vm_vaddr_t
+vm_vaddr_t
 _vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 		vm_paddr_t paddr_min, uint32_t data_memslot, bool encrypt)
 {
-- 
2.41.0.487.g6d72f3e995-goog

