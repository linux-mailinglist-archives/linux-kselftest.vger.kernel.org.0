Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85484624FD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiKKBnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiKKBnO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1863CC2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:43:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso1923589pfu.14
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4x/ZOtSpWk9/3ogowMPSnEkswUrYlJBht55aGP6vlw=;
        b=TJGAJEvpGOatam2eQMAYKoLHifGaCKcgJ8RPGSg+GXW2tqhAlddReaZHE/EKUpB/tx
         wjBR+3fkVuz5yXDC3v0NzMfaMkv2C+uXqhDrFlw9iL37AzlIQdssxZgqr4y5+ezJy9KR
         IGL9cS+FdQPPMmyeCQT+IIERkTkpC7c6Z2i51BEsaPh+mKQ8ctl+6nfK3X4QpbWqHbE3
         WwUKGXkYBcRy+rkkT9p+dt2ShAwGDdwHm6+sZD0REr1/vQfkXzc/5f9Yb9cOYN+KQikL
         7M1RLkXjbhCoOocrZWjPma3UEXdsVvYchcMh+jKKc7dzFmX2/imWhcLvUEsJdE4IXiAg
         YiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4x/ZOtSpWk9/3ogowMPSnEkswUrYlJBht55aGP6vlw=;
        b=b/9eIw6LSFTdbhjhtUfCA24IztF1glkw/efgtY/XOjRQn60jhBjEVsoMJ4Kopp/w8C
         rJAnW7sP15Eoy6eQrYggsA1T52rZm/rKVMxsrlvAgpSM+vfkmj3P0HHf76dAAbwI9A7O
         ysdeeern5na36Uzs6xpepi7tLm/o0IjkyMqlZdXlyCcAfqCTeLL5F9xeoTR7p9bghHyN
         uukKNHvYj1hHgym4DfMTn9Is1r5VXMHcYGgUJnHrZgtixn2gZ+S82flcl0uqGGsf3xAj
         /ZytrObldRuBSmuEZjlt5p5ylrrvGKxnAcUo/3TWMn36a02YDyxObX5bK9hCMBAyPKMT
         WKNw==
X-Gm-Message-State: ANoB5pllik0pxLcLpSnQmsCz5MaA4DMSiRsxCMrHYz6adHCDACjGhHeg
        mp3U/o/WrpVMpBPz7JAdJjmnNGxSIBEGUEaN
X-Google-Smtp-Source: AA0mqf467VSoly0Pym2TsVrqMJzRUABw5L6WkuXLvTk+pZVpwyNu+Jak6Hp2K4udCnAfjs2qiA538m2BwRv5AKP+
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:3022:b0:560:e4d1:8df5 with
 SMTP id ay34-20020a056a00302200b00560e4d18df5mr337333pfb.39.1668130983874;
 Thu, 10 Nov 2022 17:43:03 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:43 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-6-vannapurve@google.com>
Subject: [V1 PATCH 5/6] KVM: selftests: Add get_free_huge_2m_pages
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add an API to query free 2MB hugepages in the system.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../testing/selftests/kvm/include/test_util.h  |  1 +
 tools/testing/selftests/kvm/lib/test_util.c    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 140a61f68fe5..f4df49c8b5ba 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -115,6 +115,7 @@ struct vm_mem_backing_src_alias {
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
+size_t get_free_huge_2mb_pages(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index ebbac8246016..4f28ae73f150 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -145,6 +145,24 @@ size_t get_trans_hugepagesz(void)
 	return size;
 }
 
+size_t get_free_huge_2mb_pages(void)
+{
+	size_t free_pages;
+	FILE *f;
+	int ret;
+
+	f = fopen("/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages", "r");
+	TEST_ASSERT(f != NULL, "Error in opening hugepages-2048kB/free_hugepages");
+
+	do {
+		ret = fscanf(f, "%ld", &free_pages);
+	} while (errno == EINTR);
+	TEST_ASSERT(ret < 1, "Error reading hugepages-2048kB/free_hugepages");
+	fclose(f);
+
+	return free_pages;
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.38.1.431.g37b22c650d-goog

