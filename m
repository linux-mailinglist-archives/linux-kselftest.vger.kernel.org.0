Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399226072BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJUIqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJUIpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 04:45:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972511CB71;
        Fri, 21 Oct 2022 01:45:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so3670720wrb.13;
        Fri, 21 Oct 2022 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxsO3aS7NjLpZUBDpCGoh/+bxorngRfIVIYvqLMlg2w=;
        b=BySkZbgUWMqqHNxMGo1gF6+KBubryJBs8Bou3znSPFC6nKDtO3lj2HdgvK++atrWvF
         KLvM06m+uoiRSbqpF97+wMG7+ksLIGtMuM4iLu0OHcwD3VG6WEwDLWpU7BPOXpvmcQcz
         tPTJizRnZRsT+oPZ8smNdDYr8UPjWZuIwSaJ2EF/8lpGe7U7rqzyJzfRQQHAAMWRKyGK
         AW9XiBX1UdY1GpjABdJRMwzWO+4h2tza1t5i/WpsGDt22rXziAge/rsTIy9mKOFflJQA
         u3mVq0TKWU47iODMmAS7DU74odTQGEZZDzuJ+ZFu7DklJsrJA13x/0Ys4NVoC/oPR2yJ
         gVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxsO3aS7NjLpZUBDpCGoh/+bxorngRfIVIYvqLMlg2w=;
        b=Vjj498ntJ5nLUboOqkRLtUPYaQoo6CJ9mGG09C83dNTZ6sMM1t762+ymdafplhhBUU
         Pu0B+eATI1nYvb3wlduBOV0vGvFqKSq3Idq/uRh8YILJBw1bIMFcFGbejx7cvjjzG4a2
         4PKUnEK0VIoSfEYgm0L9OX3XT1vcO9iLptuUkm/+1Yf3ISKLOxRePDeQK2H9YUmRSOFu
         UNbUk5VRwoortAl7rI9AGyfsZGjaGSZ3/9h+qzxhL/Uid/76PikykR7KhQXEmHvMFBn0
         PR5M+B4PJ5Z7A6ph/IhVPAeDJZcp6gSqYs9Cz8DyhhqsrCWk2xJSOctrHoE3s6Q+Qj6y
         2O6Q==
X-Gm-Message-State: ACrzQf0fq7cI+iTftY0oL4dX50MbdQ6XBtDSqa+DQzn8kSDZGnD7E2/8
        MnPkaJt2KEIM5T+Y/f2a2YPGSsnwT7Zb87tp
X-Google-Smtp-Source: AMsMyM6XDUT6X/iWNzzTZNVgmPGxFjL4tJSmQ3m8l/mUiVDpjEDHPQrOqLtNM95ZeM+p6vHgNuqcUQ==
X-Received: by 2002:adf:d23a:0:b0:236:467e:a3bc with SMTP id k26-20020adfd23a000000b00236467ea3bcmr4323041wrh.542.1666341946452;
        Fri, 21 Oct 2022 01:45:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003c6c1686b10sm2352593wmq.7.2022.10.21.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:45:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Fix spelling mistake "mmaping" -> "mmapping"
Date:   Fri, 21 Oct 2022 09:45:45 +0100
Message-Id: <20221021084545.65973-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a perror message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/core-pkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index bbc05ffc5860..1a70a96f0bfe 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -329,7 +329,7 @@ static int parent(struct shared_info *info, pid_t pid)
 
 	core = mmap(NULL, core_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (core == (void *) -1) {
-		perror("Error mmaping core file");
+		perror("Error mmapping core file");
 		ret = TEST_FAIL;
 		goto out;
 	}
-- 
2.37.3

