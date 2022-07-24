Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40D57F597
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jul 2022 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiGXO75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jul 2022 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGXO74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jul 2022 10:59:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCB1115E;
        Sun, 24 Jul 2022 07:59:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so12140414pjq.4;
        Sun, 24 Jul 2022 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk8QcPITCD7zASInOLa1R0RXzqRXOUwelC1gE/1VxyQ=;
        b=fAiepUxK9sA5DHnLfCj/TTTTGGSmd2m9+OxyFBa/JXmjDXjvRJRTkIHYf8+IyXU2s7
         W1mFhcDj9aed4LSxZ1TmZ+0vZcBGb86C0PT0HZ6IgDBXz2VULXSLqSvYIsLHyE6y4xOq
         /JKdESHnpNg+eRJ2VqzkVs6RjmJUGmcmdVyOUE3MYSiowchwAuY9inpmGVB5hMW9zz8u
         ChzTN0f1d1pFHdsRu6LdBJT4eTrFSUZCMkv6HmDupDcU9Wqd+w/0uymEbFZOnL12YEDb
         5Ozki9IMj0emcV6pQu8vQt95nCbIJgIFXRFwA9BmRaWPPZ+EzltBXdSvBU/1aYxaIUMa
         XFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk8QcPITCD7zASInOLa1R0RXzqRXOUwelC1gE/1VxyQ=;
        b=LdhtHJwqvLs0NqSSQqbvvE7oC7oUbJMIXsGGeaKWE9ewi3zoQ3e800FMxEkRgPwekQ
         bagserZ1b90EnwCpAQx/m53SHIJuIZfyG4TjK0uPC6VL9BqQYSm8XkyA+qo88u29afyo
         DEDAi+1iHfKuzKmoKeomPQ86AeUQ8EJqjrRqss1OpbzfTrsD6o+ZKQ0fk14U+p86UHB3
         3SNWaA4dZWF31RUwNuWHvGU2OYp5clz81KBKK+nmyYgIs3uftprfpFdRUgiHUhbeBTSf
         iRc72DaXdTDgcrRU6tLfzNBvvIFUfT22qeAZUQy5xsZu+TBrf+/M79UAUScuPc3VIXsR
         44tg==
X-Gm-Message-State: AJIora8OcrAN3NFbDUQ7AB5ir7TmPU4eQtbKLimrljjZdvr/fSg3NW5x
        /Mt8CC4J0oGmYHr2WNO7uHA=
X-Google-Smtp-Source: AGRyM1vihI8jIMhLCAgyF58n4D21NvM8f0l7z09f9iCuH5Q7OA5NkCQZV6bc80jT4wquK62eNbfPcw==
X-Received: by 2002:a17:903:3283:b0:16d:43f8:d971 with SMTP id jh3-20020a170903328300b0016d43f8d971mr7791901plb.171.1658674790006;
        Sun, 24 Jul 2022 07:59:50 -0700 (PDT)
Received: from biggie.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c500fb7bcsm7360900plg.140.2022.07.24.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 07:59:49 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     chenxiang66@hisilicon.com, shuah@kernel.org, liaoyu15@huawei.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/dma: Add a .gitignore file containing name of executable
Date:   Sun, 24 Jul 2022 20:29:31 +0530
Message-Id: <20220724145931.32556-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The dma tests in kselftests are missing a .gitignore file, which leads
to the dma_map_benchmark executable file showing up in "git status".
This patch adds a .gitignore file containing the executable name.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/dma/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/dma/.gitignore

diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
new file mode 100644
index 000000000000..668e2f8be2f7
--- /dev/null
+++ b/tools/testing/selftests/dma/.gitignore
@@ -0,0 +1 @@
+dma_map_benchmark
-- 
2.34.1

