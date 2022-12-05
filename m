Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6014643972
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLEXYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiLEXYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:24:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5961EEC7
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u10-20020a17090341ca00b001897a151311so14586956ple.8
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jg7SSIwRQlr/a+rDYgH4gnZh0/TsI1GGL08PrcPRnas=;
        b=Ni0R2xMb56lYAf5vQja9sV9L8AwOKgADJq87s9XZWVfV1gKq9ckApzI4Mu1uUeQA+Q
         PoLaDv6B1InjcwJsMYV3O5eRL2N6YcHsqYbnDoTB/H1OoQtjxsTr0Zt8xU7c5fQa+3tp
         Q2VYmsyCFd1k2Z/S9n0QftPcuRfNJ1fkTOsOeTQ5Z8u0jL+ypLbciIG8wySleSMEs+7p
         I44DHEmbXM2gSc99hTvhcleXZfEIPbRxW89Wr0Rr/3aoi8wJqCZrDL/qOG3YZj23La96
         x4ht4Bo1LJTOiYA0kAv87k0QIoOTKH5ZASPIr3uSE78qJb+RJOdO0K2dCNwTN7AmJu+O
         gs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg7SSIwRQlr/a+rDYgH4gnZh0/TsI1GGL08PrcPRnas=;
        b=5aSkHZBl38hvarqhb+hmLKKgYZAPtselYj5zuLWd7GC0KuxE/XlUAqDmLTuP/8ey5K
         GTQjVYqP+PbRWGureGQeAsSNe5TH0l2Y7aNBfmzlLmW9x+XkrEXqq1R6Wp8+TNbK0Y9r
         s1MyN5+06JQ8VDQTt18c4GNaV19m7kqeFAHnU8D3fycgLOZXh4suZXKoBBB0sXTwDxUm
         VftwWX6WRExarWroGvbZlZCf04WSIequu5aOrxdO2NiMK4gSu2VVTP4pgwFrTgJkk/vM
         zLpW4gl2a0k9HHXr3uSxkKIw3cljQZX3uElkMGmXRj566cLhGWSiiXxoEeFu7x5zXMkK
         2rzw==
X-Gm-Message-State: ANoB5pm0qtg/d5evCvBELMYLdKV0l7A/uOP1v2lg56EycgeEufX5Tjll
        k2s/BLZ03ACQKXLtdekg+Tt5Xz9UCoo069jw
X-Google-Smtp-Source: AA0mqf5j+PyBlvwwMbJ+KA9NFMLxrpDat/KWkPA44zk6VIVrnuSr/5QtAUf0dhv+0TQLcWERel7T260md/DBb00+
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a62:384e:0:b0:576:4dfb:1098 with SMTP
 id f75-20020a62384e000000b005764dfb1098mr18576480pfa.56.1670282638805; Mon,
 05 Dec 2022 15:23:58 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:40 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-6-vannapurve@google.com>
Subject: [V2 PATCH 5/6] KVM: selftests: Add get_free_huge_2m_pages
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
index aea80071f2b8..3d1cc215940a 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -122,6 +122,7 @@ struct vm_mem_backing_src_alias {
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
+size_t get_free_huge_2mb_pages(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index d33b98bfe8a3..745573023b57 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -162,6 +162,24 @@ size_t get_trans_hugepagesz(void)
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
2.39.0.rc0.267.gcb52ba06e7-goog

