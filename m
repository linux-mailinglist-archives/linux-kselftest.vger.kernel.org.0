Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA37BA700
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJEQpm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjJEQpD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:45:03 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0D30F3;
        Thu,  5 Oct 2023 09:39:33 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1987895a12.2;
        Thu, 05 Oct 2023 09:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523972; x=1697128772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXe2b1SQetsxvQIMHBxAgfGGNR39eEXqqOWXi1pgTdY=;
        b=BEupe08wG2NSjwr/AnTOaNHKobTDgcxq6lOvdHG5r1Q5VNgRLIyeUwbrWuFwJsTZMd
         VxHwQKOAcOpZb3/Rhkyq3NbukwXxZMP+z2xK+9oXHoQaojPIxR5qVpMH9Eq9O71cJ4Hu
         IG0gXrTtgyaJEJeSx7HS0mCelvvGNSwEqtHeeJYTrQv7E1mvDS7wehNM3w8MHpugj9jc
         7z0smVv06CvxNG6Rwx2jHZBA82oQDuzvF+22I5OB3MaPLaXhmmqy5L76bv5dpNIXD3yi
         Og1UR8H9bmsKXMRat4xmlcbM/iYg/FCoExkBw3yNqSjrpdP1tt0GJLcDCUDzFTjVJ+Qo
         LOFg==
X-Gm-Message-State: AOJu0YzrZKTbu+XBURvkMuQxsTcF4QXP4OxfI63USZtRjpJqFaQIPxxt
        Fya7G31WlNrr+Z1VpguUZNM=
X-Google-Smtp-Source: AGHT+IGYDnp74cV0Byj3XwLIm6spdtkEqH5f+zeVjCF1kcvzcQHqph+sJjv4ryOmfqgXWAqfOPwhPg==
X-Received: by 2002:a17:906:2191:b0:9ae:5246:233a with SMTP id 17-20020a170906219100b009ae5246233amr4855817eju.20.1696523971836;
        Thu, 05 Oct 2023 09:39:31 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709067d9800b009b2c5363ebasm1441273ejo.26.2023.10.05.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:39:31 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, riel@surriel.com,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] selftests/mm: export get_free_hugepages()
Date:   Thu,  5 Oct 2023 09:39:21 -0700
Message-Id: <20231005163922.87568-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005163922.87568-1-leitao@debian.org>
References: <20231005163922.87568-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

