Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC176259E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjGYWD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYWDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02F3A91
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563db371f05so370895a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322557; x=1690927357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QxayR1+38ThkDfjx5nIpGHvep+dFsgWVyrdLG8WNAS0=;
        b=iZXgv14xbs4ypE0+fJCZnqh6DPaH9qYrLol9WIcmwWp9hJrEMB06yc5oOt9YfjO/bh
         HwRybOKK0CbqEO25+XKNEteQEuanv0yjHGEUjLY9Jv8zD2Uc+5BvWqkDWJoQxKNQMvRn
         aqEfOTamPizEtwUdoyCGVEjqUSUYybSHYXzGVlNbam8Z9CGf0X3DxLb84YUre7PTpAcC
         Gs9C1FtJwVZ3eXrYO4wb83CPg2gEu/80AkOqMw2s9hLCli3wEAZt2UuvCT9wVOCiIeHf
         Lz/y69FzGU3OUSPJxChwBoTtdLRRvtEyvQx/DxGJZPrBEXoQjHHOp0inaCBkWv1QukPO
         /vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322557; x=1690927357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxayR1+38ThkDfjx5nIpGHvep+dFsgWVyrdLG8WNAS0=;
        b=XToH8peUivJRPwL/vQ+tYjoE0/Z+qOKcesao4rna/CWn3/8YRycdSybbsDIaTmkTD1
         p0BZ//wt55QVkoixf2uTXiHRrMYdeZx/HAq1OVTkntqGJig/Ipz4CcCJn7o/MrFio9Tr
         tu58yXjF56j6/ILaEzEHxflUKFf5g7HEP0X9Il0XXOoz6CvMO53S8pWI9ChqRerXgray
         y1iDhXnja/llv88AaKuQxzOg++wxl3dnX654Rwvi0XflGOzRyKc+NTubIs84I0ZcyJ+r
         Ilu7z6romjLUKYBw9+RwHLwkk3u4xs0gMsKT1sar2pK3UwES0ihXNim761tBjPy8fmso
         p4hw==
X-Gm-Message-State: ABy/qLZQZ+go4tuXMd1Gs/LaZgQWUl6L73rwzPOWSlBMT6ahxUvL4CTV
        PgAHPaWmJQVz0dKgDSlPAY8v4FKmLnkbAdLsYzKSUIBqYwUBrFB3y5f7guTWF28R0c9N7MpPu8U
        bR2of+ej5EAkqwhfn0Nj1VvEWEtMUPRWd88xOd8gb+UTYjVPyVDE7cRpi3bcVjOCQUrBSi0ma6q
        CY
X-Google-Smtp-Source: APBJJlHydqjh4hj3f5qsFPJ5aCYtVe+HgpKU8v5JOp0jYz5cex35w2qZKEsoSH46FkLUXlFVI1PI8xvFMtmX
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:6f86:0:b0:55a:12cf:3660 with SMTP id
 k128-20020a636f86000000b0055a12cf3660mr2082pgc.1.1690322556693; Tue, 25 Jul
 2023 15:02:36 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:18 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-26-afranji@google.com>
Subject: [PATCH v4 25/28] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
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
Change-Id: I93d3c84735df06b300a84c7c7bb66a3128354739
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index db4cc62abb5d..b71bcea40b5c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -6,6 +6,7 @@
 #include "kvm_util_base.h"
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -38,5 +39,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 061a5c0bef34..d8c4ab635c06 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -236,3 +236,8 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
+}
-- 
2.41.0.487.g6d72f3e995-goog

