Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DEB67624E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjAUAU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAUAUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:20:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF5976A
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h136-20020a25d08e000000b007e1b1a30d5dso7414635ybg.15
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoLQ6HYLr8hLhvXe0so57mY+HUAjh6mBgI+e1/IQeng=;
        b=QDv9eBq1lt7YIEJZzgzCx+7X/eRNoD6R+YX07ysF2YQEyCGPjLbpF2Zk/+B6V0JmYp
         iOhVBV4999QsqCJ2dtSGxhRkxLnJJBBreJTZVdsAnpE+VZ17j7iDfuvsh03Lkp8iyJeA
         aARFOPNZjnB2E4meZsGWwu0ob3tJGhfB1jLd8eR9wfUu7xEapJC2W4LTPxaw/u7sO29Q
         cHWamv2K+Q9MUkeGpSmm/v/SRdJyZpZx2Vfpzpsqe6Oy4umv0qn3QDdMZjYnRVczl7PS
         dBzSBedrLPL6zYX5K6SpUnot+4hCMshgzariewcc9LqId9QonvzYc1b8RuZfzfk5sdif
         PtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoLQ6HYLr8hLhvXe0so57mY+HUAjh6mBgI+e1/IQeng=;
        b=N/lWnXaXgJrcS3fGqTtvzXGTJMgkYi/eZXKx27axoWzPz7vcFczXosJikr2chU40DC
         gqiQpJsXqz23iCXsgcdTXBtgQhxVu/nZSZnFcE1bdpSx7cnnuCbJd0AIc3Rs8PGAsoA4
         hF9dLDG5vOMVBw1Cr4cWKARUaJckp9fJzYC2vqR9TVba/lbzR4LJbZlodDApmU/8pwt9
         PN0GixmZWGs6hrKeyllDPSF2VGD9db47avovtjiyRozF1n5UyL8LX1mFPUe7VTisPZk1
         ecbnFBFuq6yGd+gHRuWnZNZyhGqqz+5Xd0IPc6SwzWrmMZ23+Xt+HKfYi7Vjg1LxCZQX
         4E5Q==
X-Gm-Message-State: AFqh2kolzzeQ10b3SrKFDivxX/kqxc27igtGLkrixgbSU1ZVfQzWuzey
        8NyH2PpUnmtoK/QcsGmFgBZ9PByZ82h4fWm0eMlbETLXbZfqTBPN3u2appk+8GfDWT+pPVe8U36
        7T8852LOC00p2FsUT55YZOalQ4NRyk2CSGJ0Y06Q6M3YVtNSLvuACmg2F/1/vn2jrK93hNeKKip
        z1UnfuVO78qv4=
X-Google-Smtp-Source: AMrXdXuI5KPIV+1bAjgQ7xtMLOmJeYkGw4nxJcYtu8wp10aKsTdw8pXY00wl8grNtb1i7r3jEL1o+T0AVWCvuDgM2w==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a25:bdce:0:b0:801:88a9:d5f with SMTP
 id g14-20020a25bdce000000b0080188a90d5fmr446952ybk.71.1674260299258; Fri, 20
 Jan 2023 16:18:19 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:40 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-30-ackerleytng@google.com>
Subject: [RFC PATCH v3 29/31] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 21 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index c8e4b9ce795ea..2dfb9432c32f9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
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
index 2ebc47e268779..11a19832758bb 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -210,3 +210,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
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
2.39.0.246.g2a6d74b583-goog

