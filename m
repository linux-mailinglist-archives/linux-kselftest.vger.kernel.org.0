Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2755852FA13
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352810AbiEUIi7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350269AbiEUIiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 04:38:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34A5BD19;
        Sat, 21 May 2022 01:38:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c14so9558225pfn.2;
        Sat, 21 May 2022 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HhP/+Tz7HqPlFeIBm2iprd3q70O4euGT7YcNpr3mWc=;
        b=hXMeES/xeQKEcJ1ukUWTmAZjW/Yn5h3NdUtnltYTBkiZXKmfFWoC7gAoDy7oVdncMR
         29DRdkRNIyU6VWLVP73s28B20gf+P9k2yMe85iZQAQUN223ezp5fz7STGxtQK8zRkJAU
         2Dwh2JxeLvAWvUbsOccpTvzHws4oEpsgq87hp++uPDpMNod496bkgX9pWTA/J5TiXZG0
         O+BZ1aGqXKhMVhK3lyi4/WTziqlmuC5aqMTju2tEc4x+gQWDOGWEGMm0GnWUHpCv8qOP
         6/wQfZ6BPfBJLuA6qTBn1ZtqCwz8vkrZLLZYVU5ewIUP/1CZT6hZl+LsRaVMEJhATP9a
         wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HhP/+Tz7HqPlFeIBm2iprd3q70O4euGT7YcNpr3mWc=;
        b=1yZTFS+0uNm6hiqPsPo8nqQAW3ebVHd/gLda+1iCY/WDQyPscChOqDn1+TO/fLqEXE
         7T6cMTs2Mp2Pfjo1+VS22lHyBVRGNcEAqi6QVBqXHXYY5eyWEYpctHNoYxvv2e1fhFil
         Q/NSmtoucPdFeM8PrncHcrEjTnp6wLqJ1rk/WQ/KIgAqkL2SJ4RhQ5AFxPBasZ2JwEWO
         QIB+QHO5AbTzOBCZdUFla8B/sqbjbzWUsDaxD1pvaiFxaFLLE7f+UAyy94vIBxpY1Exm
         VFBosI6dcU4Nsd1NeOa57Sf3g4poNa0HYu8Matep1dM8I2VUI5zhnpdjgvcIlQUhyI4h
         vzYA==
X-Gm-Message-State: AOAM533aJ/qBmNFMHOl6RriOUSUjG9q78ZE3nx9aXB3AUtLA1mOblrBM
        GgyLd+9BgZ9ykJjSSXq9YlWwF5FjgjSUlA==
X-Google-Smtp-Source: ABdhPJxmNzwbbOgrYwN/RywNuxBQ+XVH+IqftKjcwTFeAmYDx0XD7ictM0eR1P3h//ybjX72vvr7oQ==
X-Received: by 2002:a65:6a15:0:b0:3f6:13ea:1cfb with SMTP id m21-20020a656a15000000b003f613ea1cfbmr12070450pgu.495.1653122334280;
        Sat, 21 May 2022 01:38:54 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090ada0500b001d81a30c437sm3104182pjv.50.2022.05.21.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 01:38:53 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick.wang.shcn@gmail.com
Subject: [PATCH 2/3] selftests: vm: add "test_hmm.sh" to TEST_FILES
Date:   Sat, 21 May 2022 16:38:24 +0800
Message-Id: <20220521083825.319654-3-patrick.wang.shcn@gmail.com>
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

The "test_hmm.sh" file used by run_vmtests.sh dose not be installed
into INSTALL_PATH. Thus run_vmtests.sh can not call it in INSTALL_PATH:

  ---------------------------
  running ./test_hmm.sh smoke
  ---------------------------
  ./run_vmtests.sh: line 74: ./test_hmm.sh: No such file or directory
  [FAIL]
  -----------------------

Add "test_hmm.sh" to TEST_FILES so that it will be installed.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 tools/testing/selftests/vm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 12897927311e..44f25acfbeca 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -92,6 +92,7 @@ endif
 TEST_PROGS := run_vmtests.sh
 
 TEST_FILES := test_vmalloc.sh
+TEST_FILES += test_hmm.sh
 
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
-- 
2.25.1

