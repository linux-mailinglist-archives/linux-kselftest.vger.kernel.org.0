Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985452FA10
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349005AbiEUIiv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347413AbiEUIiu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 04:38:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC92FD35B;
        Sat, 21 May 2022 01:38:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n10so9850656pjh.5;
        Sat, 21 May 2022 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JifwYnD6JO0kOV61Ln5I93dJxrKHSoYK3bTtvWqPo9s=;
        b=IfwIadc/gfqz1l+D/XvQVz8sUI7LNyNig02LUX7Nx3A5oAwQEGtseWjwXl8Lz1UMom
         DTSx8BK/FYzL8VGeFiFiJp/YiaZNGzpBy6lReK2S1DachCgSJzGAw1hwdGWWUGpzK8gX
         gs2FaVMwoY2TjWX2YHomgmB4VSXIQ2b4SzbtumQcnPciIz6JA0pFaMpmC86Fefus8faX
         hJz0NTz7bIKCh4J6W78D2WGm4v4udFFEcuvGer39liOUHFAzIbmA2gWPiEOCiiAxVZ/Z
         wW9RrNse4ZjNDu91f9YmBg5Fb3uyXhFTDCD7kAdV85aaN2a2R+ektUEQbV91ekKCkYUy
         +8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JifwYnD6JO0kOV61Ln5I93dJxrKHSoYK3bTtvWqPo9s=;
        b=lXULzuq5Lzc7n9Qow9H9bk1Sgkj4no4k/7OaDcWT9sJdCbzOsBCPOPpXBrhe3jwAev
         +P7mp1PvgeS4YmiOp+S0xbl/QRte9xHsUjIgbs3DL3evkkdCRs7uYm7BvH4qez5ALzdR
         1K8lQ+W2VmmA0g5hSqRahtZsPCIfCNcJi2xnN3tDoPsXDTkCtMPIc5+M4OE6rv+4vDmo
         fKM10SmKBKW9ZSq9RP81y4ZeSjo1vgK32pz2N1QiG2uL899NJkDM9546/iF0v3wHgazr
         r3IWZSl1t21WMOAE8ZWqY2Z9UeJUaEQj8i5+qI22QlePpibPimO4/3EVprxne4W1OgR/
         ldKA==
X-Gm-Message-State: AOAM533fBCDqtmFQzFrbchkR25jKZ8RMQL6NLlFye+tiKUHwsyfbq2/M
        YMOnHLB6ZZM/KJAxk/Z/nnekDiOHOeyNZg==
X-Google-Smtp-Source: ABdhPJyHSwmxq/BUcPtiGeaOIa9ApUD2tKNORjgg1PkOAZaXH5D5ZoCezl2qk2NGuxpmDgjR8LruuQ==
X-Received: by 2002:a17:90a:4615:b0:1df:40e6:6474 with SMTP id w21-20020a17090a461500b001df40e66474mr15500678pjg.194.1653122329370;
        Sat, 21 May 2022 01:38:49 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id f7-20020a6547c7000000b003db8691008esm1022381pgs.12.2022.05.21.01.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 01:38:49 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick.wang.shcn@gmail.com
Subject: [PATCH 1/3] selftests: vm: check numa_available() before operating "merge_across_nodes" in ksm_tests
Date:   Sat, 21 May 2022 16:38:23 +0800
Message-Id: <20220521083825.319654-2-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220521083825.319654-1-patrick.wang.shcn@gmail.com>
References: <20220521083825.319654-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, ksm_tests operates "merge_across_nodes" with NUMA either
enabled or disabled. In a system with NUMA disabled, these operations
will fail and output a misleading report given "merge_across_nodes" does
not exist in sysfs:

  ----------------------------
  running ./ksm_tests -M -p 10
  ----------------------------
  f /sys/kernel/mm/ksm/merge_across_nodes
  fopen: No such file or directory
  Cannot save default tunables
  [FAIL]
  ----------------------

So check numa_available() before those operations to skip them if NUMA
is disabled.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index fd85f15869d1..2fcf24312da8 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -221,7 +221,8 @@ static bool assert_ksm_pages_count(long dupl_page_count)
 static int ksm_save_def(struct ksm_sysfs *ksm_sysfs)
 {
 	if (ksm_read_sysfs(KSM_FP("max_page_sharing"), &ksm_sysfs->max_page_sharing) ||
-	    ksm_read_sysfs(KSM_FP("merge_across_nodes"), &ksm_sysfs->merge_across_nodes) ||
+	    numa_available() ? 0 :
+		ksm_read_sysfs(KSM_FP("merge_across_nodes"), &ksm_sysfs->merge_across_nodes) ||
 	    ksm_read_sysfs(KSM_FP("sleep_millisecs"), &ksm_sysfs->sleep_millisecs) ||
 	    ksm_read_sysfs(KSM_FP("pages_to_scan"), &ksm_sysfs->pages_to_scan) ||
 	    ksm_read_sysfs(KSM_FP("run"), &ksm_sysfs->run) ||
@@ -236,7 +237,8 @@ static int ksm_save_def(struct ksm_sysfs *ksm_sysfs)
 static int ksm_restore(struct ksm_sysfs *ksm_sysfs)
 {
 	if (ksm_write_sysfs(KSM_FP("max_page_sharing"), ksm_sysfs->max_page_sharing) ||
-	    ksm_write_sysfs(KSM_FP("merge_across_nodes"), ksm_sysfs->merge_across_nodes) ||
+	    numa_available() ? 0 :
+		ksm_write_sysfs(KSM_FP("merge_across_nodes"), ksm_sysfs->merge_across_nodes) ||
 	    ksm_write_sysfs(KSM_FP("pages_to_scan"), ksm_sysfs->pages_to_scan) ||
 	    ksm_write_sysfs(KSM_FP("run"), ksm_sysfs->run) ||
 	    ksm_write_sysfs(KSM_FP("sleep_millisecs"), ksm_sysfs->sleep_millisecs) ||
@@ -720,7 +722,8 @@ int main(int argc, char *argv[])
 
 	if (ksm_write_sysfs(KSM_FP("run"), 2) ||
 	    ksm_write_sysfs(KSM_FP("sleep_millisecs"), 0) ||
-	    ksm_write_sysfs(KSM_FP("merge_across_nodes"), 1) ||
+	    numa_available() ? 0 :
+		ksm_write_sysfs(KSM_FP("merge_across_nodes"), 1) ||
 	    ksm_write_sysfs(KSM_FP("pages_to_scan"), page_count))
 		return KSFT_FAIL;
 
-- 
2.25.1

