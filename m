Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15E51AD11
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377586AbiEDSje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377184AbiEDSi2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 14:38:28 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF44FC6A
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 11:29:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id ij27-20020a170902ab5b00b0015d41282214so1102072plb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8y34WRUMkXGaI7LiirYCxdfq8R7sMsgfnkBgNzio7vc=;
        b=izXY7EVw92FzDfdevAMJvFOBnGz+CSM6UkMIvsTglpiKteCgoZp6QifGhzq1D4Dl+i
         ca0HEhFdNXai4YsJumOdVHvmxKc8ym0x0dz0St7Q6XoPZTF+NO0x7edWwSQNIZpaq8bk
         kL0iikHDGg++XGlx99/jFSXxot6+qQJ2KhEppwK0hm9hotUM/Sm4GyhPfhts9lB17crq
         i+vOmM8CMAhyBDy0kvP73FtHqit/Rrrc1kCS1017Jwr9Y/cfzWT4ipdkOFYso7UepntB
         qK7LSOsDdboMtlc46i27pL7TUpEow9zhMVfNK7WpB8BonYucl67mrDoXR4Wz55RDwe2T
         CPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8y34WRUMkXGaI7LiirYCxdfq8R7sMsgfnkBgNzio7vc=;
        b=uP+oFwZfJVi67scC/nqZPI8y1quy32Hv1H2gsve24Im/llpNIaFiq2nWpBk2vbOTlv
         2DgmGyC99+NwXKds0FlQbxdvJn9gSydx1L65vfkV843KykLU9bmjL6ppIqS1djXX0iCA
         ajY83E4r7XhHVCkvBqvSCoz+er5s1iGBLebEHCsTbjUDxo2m1Ag1PqWTLlkuLXDJ51cW
         AywNX3cZljFnEsET3LoI+3br8yOcGEnrd+WvnujsuCDA1udgucHCv8aImiLzIpaXWMyL
         QheGYSBRuY/I9X98f2+oB6DZmqjmxpZrmCaFjpFrAIO57J3hB2tK2cBUTr+up5i/6/eg
         HXLg==
X-Gm-Message-State: AOAM530Gh2CLTupJoUeACYw8lDP64/JSgAIfq6GcJBL9JaIjU6h6s5F6
        zqVjJfq4Qma3St5L1C04gdfZdTdOTTl/
X-Google-Smtp-Source: ABdhPJz3R/tzVrU+GfQpvY/EakNRjlgGc3rdRnTdOp7XNw4RRoGUgJkJqCBw4Q5RqkYLf56sAroZKd5Rmhyk
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:aa7:8888:0:b0:50f:2e7a:76b7 with SMTP id
 z8-20020aa78888000000b0050f2e7a76b7mr6455495pfe.48.1651688958824; Wed, 04 May
 2022 11:29:18 -0700 (PDT)
Date:   Wed,  4 May 2022 18:29:08 +0000
In-Reply-To: <20220504001153.119485-1-sj@kernel.org>
Message-Id: <20220504182908.1322874-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20220504001153.119485-1-sj@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
use '__GFP_NOWARN' for user-specified size buffer allocation")
intentionally writes and reads with a large count to cause
allocation failure and check for kernel warnings. We suppress
the compiler warnings for these calls as they work as intended.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index ad7a6b4cf338..91bd80c75cd9 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -2,6 +2,8 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+#pragma GCC diagnostic ignored "-Wstringop-overread"
 
 #include <fcntl.h>
 #include <stdlib.h>
-- 
2.36.0.464.gb9c8b46e94-goog

