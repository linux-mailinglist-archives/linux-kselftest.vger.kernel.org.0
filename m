Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6167B8628
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbjJDRMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbjJDRMN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 13:12:13 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2395;
        Wed,  4 Oct 2023 10:12:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso9467166b.2;
        Wed, 04 Oct 2023 10:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439527; x=1697044327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXe2b1SQetsxvQIMHBxAgfGGNR39eEXqqOWXi1pgTdY=;
        b=dIBrDsv/omajYDcjt1S5VMcxAxF4ASg9WRLTFh/+Py2WjDs5Icqm2AeLklLYUJh1O8
         OX+siDAx/6jYsJw4zOhsVPopKGaL3jzX90IEN9LIUIzJkXVqr4fS80l2gkXi3KIAiDoz
         U7UKYlxZRhcuqeS8jNLAUgWLvwtNSBc+D9Pop29+x00Ys4M306b3dXRn2Dv9tycxEnr2
         Y/CdeNtWF6kCzihYNqnPlBmInZ6lSTWLTnYeowS/uL0aowYKrYJpHS/krP9koy+YgZW9
         VINY4byV0dbQea91wMtJ+VASfFjlS0qWyldYmnWHRtWPf4PDY5ozfWEkZwOl0uRb/7M7
         oLkA==
X-Gm-Message-State: AOJu0Yynvpmr7y/ZV5NlusQqLY8AJKQrgf6VITN2SaS+B4AOAlXcRKoY
        KX9pbut6iGAQwp5BeWj9P04ZaoiqxXo=
X-Google-Smtp-Source: AGHT+IFSa2P2Gwxf/j1Dt3ypULeuCrhYVFeB7pwFaxDrjEa6p1Xue5WukYkOwB88lN0rbcYG+AQzYw==
X-Received: by 2002:a17:906:5357:b0:9ae:7681:f62a with SMTP id j23-20020a170906535700b009ae7681f62amr3072085ejo.44.1696439527012;
        Wed, 04 Oct 2023 10:12:07 -0700 (PDT)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709067e5900b0099bccb03eadsm3064093ejr.205.2023.10.04.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:12:06 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, riel@surriel.com,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] selftests/mm: export get_free_hugepages()
Date:   Wed,  4 Oct 2023 10:11:25 -0700
Message-Id: <20231004171127.106056-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get_free_hugepages() is helpful for other hugepage tests. Export it to
the common file (vm_util.c) to be reused.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 19 -------------------
 tools/testing/selftests/mm/vm_util.c         | 19 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h         |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index d55322df4b73..f32d99565c5e 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -36,25 +36,6 @@
 unsigned long huge_page_size;
 unsigned long base_page_size;
 
-unsigned long get_free_hugepages(void)
-{
-	unsigned long fhp = 0;
-	char *line = NULL;
-	size_t linelen = 0;
-	FILE *f = fopen("/proc/meminfo", "r");
-
-	if (!f)
-		return fhp;
-	while (getline(&line, &linelen, f) > 0) {
-		if (sscanf(line, "HugePages_Free:      %lu", &fhp) == 1)
-			break;
-	}
-
-	free(line);
-	fclose(f);
-	return fhp;
-}
-
 void write_fault_pages(void *addr, unsigned long nr_pages)
 {
 	unsigned long i;
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 558c9cd8901c..3082b40492dd 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -269,3 +269,22 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
 
 	return ret;
 }
+
+unsigned long get_free_hugepages(void)
+{
+	unsigned long fhp = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return fhp;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "HugePages_Free:      %lu", &fhp) == 1)
+			break;
+	}
+
+	free(line);
+	fclose(f);
+	return fhp;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index c7fa61f0dff8..c02990bbd56f 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -51,6 +51,7 @@ int uffd_register(int uffd, void *addr, uint64_t len,
 int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
+unsigned long get_free_hugepages(void);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.34.1

