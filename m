Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085FB4C59C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Feb 2022 06:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiB0FyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Feb 2022 00:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiB0FyY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Feb 2022 00:54:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F31B0B
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 21:53:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c9so8164104pll.0
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 21:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBvazhbiMSJHiFRR8rtsztnvbns4XgMHNyrmX4NjfhY=;
        b=JS6dGDwtp+g07D0ANKPKJloW3mTpltjYKKF/C4VxIAMQNqjXMU/DzJXXFiml4noxZl
         YHuS0iHlT3Dw+BzkgR4x//1nRwt4l7Io+GX3Fz/ZAsMy2Z5t31/beYFSlaSftJsoisRt
         DTeOEdZHWvV+DuLOVOVXg5x01+p5ToBEsq2Oyi+NRCPpTXSAqmcJ11aCtQHsqcr6laO/
         ZP/lndswMYzxN2FYKU1Ha8tiV7QW51mloOdszdoklbhq4BnC14o0qWBd6/wtz5kPygxz
         0fsrdH2xg9G/zWjugpIu4+V5vfNXilxqI7dFAQYM41dlKhKadhHu8ORXvoxAOPEBHoMX
         pCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBvazhbiMSJHiFRR8rtsztnvbns4XgMHNyrmX4NjfhY=;
        b=ID8aUtt8TfScEIkTeVU1EuB53359Jp9Eydds/wLwJTNENtDaug2bXI6Gj+Anmn0GoB
         kaXFbQVwY9JsGDRPIdeDDc/zEZcrhowNneOtn/4m64+HL/tFP/fxTlJV4jzSg7ynbOXf
         8w+YGDVwxBY1brNoQO8/F0Ne/cxuMdIINDdK5bZiOC4UiyG7WnQTBERBNcgtdtporWlX
         LHXmH5MOe1YXnCQ5+GZLAt5AFyIcpWCKtOGYgOW0hBvZSwioI1mWQwW5Hh3lDrz9fvY8
         TM2GrUlyRYQbymUyfviPsuGS6sjDF6ppq+F1x6JLnmzuKmVmLmUdddIxQV9F1ucFDkIz
         2fAA==
X-Gm-Message-State: AOAM5305CtmTju49RrKkv0VxmMnsUDnHXiveQN2SGjgHp2XYLbjEI5Cm
        oJFtoSRvtH/xE3UiWZN8vZvQLQ==
X-Google-Smtp-Source: ABdhPJwApFx8t+Bs5NDGGq+radi7MKoxi719NQVN5s+mt2a3EiPcLw4wD1OW5kBIeQ685vC1I4Pf4A==
X-Received: by 2002:a17:90a:bb8d:b0:1bc:72a9:a07d with SMTP id v13-20020a17090abb8d00b001bc72a9a07dmr10705858pjr.9.1645941228842;
        Sat, 26 Feb 2022 21:53:48 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6f:a720:d522:416f:1b2a:d253])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f3b1c23497sm8547647pfj.101.2022.02.26.21.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 21:53:48 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] kselftest/vm: fix tests build with old libc
Date:   Sun, 27 Feb 2022 13:53:30 +0800
Message-Id: <20220227055330.43087-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227055330.43087-1-zhouchengming@bytedance.com>
References: <20220227055330.43087-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The error message when I build vm tests on debian10 (GLIBC 2.28):

userfaultfd.c: In function ‘userfaultfd_pagemap_test’:
userfaultfd.c:1393:37: error: ‘MADV_PAGEOUT’ undeclared (first use
in this function); did you mean ‘MADV_RANDOM’?
  if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
                                     ^~~~~~~~~~~~
                                     MADV_RANDOM

This patch includes these newer definitions from UAPI linux/mman.h,
is useful to fix tests build on systems without these definitions in
glibc sys/mman.h.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2f49c9af1b58..3fc1d2ee2948 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -46,6 +46,7 @@
 #include <signal.h>
 #include <poll.h>
 #include <string.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
-- 
2.20.1

