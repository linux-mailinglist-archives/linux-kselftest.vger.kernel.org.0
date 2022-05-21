Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C014152FA15
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351049AbiEUIjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352926AbiEUIjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 04:39:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4A0F7480;
        Sat, 21 May 2022 01:39:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so13327536pjr.1;
        Sat, 21 May 2022 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKgtsXuVOi1QNn+QUr5+/f8fxa0uMqPOrJbyR3xVqo0=;
        b=PcvLX+AA42K/25xPIdhOA63RFpR1f19sOBPb+tpMTk/vYfdDylBmA3zvj1V8AfdyJM
         yH2L6Ycg8fzsqKZYGZy3W1WmmJyUvjUreM2B7YgteISXqtRn33ZkiYs7IAogmCJsZX68
         vKn3m2gVPb81kEZi54ovkwYjYA1Dqfoy4GIOi8hlBGkcjvrsp7/djrqCsTMRmeXRV8ib
         k7DEreDnAjqZiZgG+sgYXs3Z/cbW+JA+85GdcAIIwpbCGbnPg7yE5tG336p8tBl2/4/T
         AP3S6juCJNIPRar4Ag5g7t1kKZUKUEciK8Lq6ffCOz0WzQm9ErbrYVdjrF2FnKLwhzMv
         YY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKgtsXuVOi1QNn+QUr5+/f8fxa0uMqPOrJbyR3xVqo0=;
        b=bWJMw33Qck46W5h+MJRgYFxHbwTeoOi0VQlRDZDy6a/rkIiUhfbRsmeZZz4RIrUNiE
         P2W7qb30OIOuPMOzix7V6n9fVveGT/b1z/Ly5as4VSBi3EDpwKSenaX93s1F0ioy6ymk
         GmMP3L/H6sQ39QfaM1XO+3E8dzcZkFJzrfkNMlgIQ5EZvoOQy6EX8NtHe7k64hLPhNQn
         jLJRon+BVsn4fFq5icuWaWWRaalMPHQb5pReFiTYf5SCwyk7S7scuDg7bVJiWhF7i2L8
         peBChDg0tPE187xpzfbhudK15iRYSgkye235CnQB9rwvNDgJKqEQOQJwF0WkD705m+uU
         ZDSA==
X-Gm-Message-State: AOAM531vy2n69tV5kPYMWFsCHxxRZJQyutr8Ty4icczIikgmrBnVNNH7
        Wr5r/0Ma9czeCldv0nAOmAM=
X-Google-Smtp-Source: ABdhPJzW5Zypglg3GnAusYqT8bGachbUQvrGnVuNFpQOSI9vw8LS83RB6jAV5DSZjw2EJNt+HsBD2Q==
X-Received: by 2002:a17:90a:ec01:b0:1df:56aa:6b7b with SMTP id l1-20020a17090aec0100b001df56aa6b7bmr15213129pjy.230.1653122340763;
        Sat, 21 May 2022 01:39:00 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b0015e8d4eb260sm1031755plx.170.2022.05.21.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 01:39:00 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick.wang.shcn@gmail.com
Subject: [PATCH 3/3] selftests: vm: add the "settings" file with timeout variable
Date:   Sat, 21 May 2022 16:38:25 +0800
Message-Id: <20220521083825.319654-4-patrick.wang.shcn@gmail.com>
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

The default "timeout" for one kselftest is 45 seconds, while some
cases in run_vmtests.sh require more time. This will cause testing
timeout like:

  not ok 4 selftests: vm: run_vmtests.sh # TIMEOUT 45 seconds

Therefore, add the "settings" file with timeout variable so users can
set the "timeout" value.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 tools/testing/selftests/vm/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/vm/settings

diff --git a/tools/testing/selftests/vm/settings b/tools/testing/selftests/vm/settings
new file mode 100644
index 000000000000..9abfc60e9e6f
--- /dev/null
+++ b/tools/testing/selftests/vm/settings
@@ -0,0 +1 @@
+timeout=45
-- 
2.25.1

