Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5225176259B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjGYWD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGYWDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF022D44
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583da2ac09fso37502767b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322559; x=1690927359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8vBrFCkVPWmU+M7A3ccxaHSTsC04IRp9XhTTjvg0yU=;
        b=cO02nmI9a1lgE9cpYBsbu9T5WKjLbzET1O1TyT5i0z7QXCF2HVWSvopdTfmoFM+NRr
         O5v5ebykd9LRCbkBfz+Uhvnoqz0stuzrvAT01w95oAXDEbDla2bl9sM1o6bwWnIKxOu8
         3hy7RZog0U6xu4vbG211oZwlmIpqOILYeGIXUpBP648dSiN/uo2IkC9I5fZjOAJPnHJv
         YOjMId5B347eR/Sts9YbZxn0UM+5qenIpN6KAyBQZNahgciiZiOMIRP6zew+n18VAR1F
         PPGBdiPEU1MeIvF8SntDCdBNP7vSpv0BT3OgYcpseAg8R+64GWA+WXrM8eEwO2WTPPmM
         MLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322559; x=1690927359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8vBrFCkVPWmU+M7A3ccxaHSTsC04IRp9XhTTjvg0yU=;
        b=WSxSXuNGTXAP3FdL8YrJRNvjSXxHYdvB5v3QwCTXJfHbLvmjL1+aXAsLhrFSkDgRQU
         GMbshX1FQghz9i4W71LtmHxXjuciQ78MTukp/4p+tDtXW7WuULmj5Du3sHbNeXryAfSq
         cR+9TODraIB2urgvOdLvBl9jdBigAP2Iim8vbN+n1RYWstLeKe946MAPxVZxJ0+CopCP
         3rmmdQ2M6CUFMDpd3jLVXUC7ouTWxkKWZYqiq+aL3hyNSBgmRPZR/azuFrGSY5DzUX+s
         Fpl/a9SQE19K2dmNI9oqsson27RK74RIfVKJWXHe/0MdNnNW0FKG5SFQFqP8BHqtwGi/
         oMWw==
X-Gm-Message-State: ABy/qLa9nJpTa0M8O29IL7n2jlJ1rapxS4GKt2cj1smHG654SgA1+JFR
        OaixHOddcoPnCt6RLIr9DdMF0DU2+iX9MvwEwg2w53x3o2OySD8zm7uk+IcrRpd0F8czEtXuNz8
        cCpg3ifsBkt7WxpfK4dU5uqBK0siVVnSYvHuZMJ0wX3hOb3uztOaQ9rT2zDgZ/H1CoBVunTbhxA
        cS
X-Google-Smtp-Source: APBJJlGrIzd+2OghRSxPRIy46lHVWi3hHjIbtoGsIEDC8v+CC3KMafEjpzAYct7tIANcxiuKA6iO4/EbM1l0
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:42c4:0:b0:bc0:bfa7:7647 with SMTP id
 p187-20020a2542c4000000b00bc0bfa77647mr2089yba.0.1690322558638; Tue, 25 Jul
 2023 15:02:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:19 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-27-afranji@google.com>
Subject: [PATCH v4 26/28] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
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

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I1eca6f65d627678c50b847b073041c61e71cdf0e
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 21 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b71bcea40b5c..12863a8beaae 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -6,6 +6,7 @@
 #include "kvm_util_base.h"
 
 #define TDG_VP_INFO 1
+#define TDG_VP_VEINFO_GET 3
 #define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
@@ -41,4 +42,24 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
+/*
+ * Used by the #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is a software only structure
+ * and not part of the TDX module/VMM ABI.
+ *
+ * Adapted from arch/x86/include/asm/tdx.h
+ */
+struct ve_info {
+	uint64_t exit_reason;
+	uint64_t exit_qual;
+	/* Guest Linear (virtual) Address */
+	uint64_t gla;
+	/* Guest Physical Address */
+	uint64_t gpa;
+	uint32_t instr_len;
+	uint32_t instr_info;
+};
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index d8c4ab635c06..71d9f55007f7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -241,3 +241,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
 {
 	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
 }
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve)
+{
+	uint64_t ret;
+	struct tdx_module_output out;
+
+	memset(&out, 0, sizeof(struct tdx_module_output));
+
+	ret = __tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = out.r10 & 0xffffffff;
+	ve->instr_info  = out.r10 >> 32;
+
+	return ret;
+}
-- 
2.41.0.487.g6d72f3e995-goog

