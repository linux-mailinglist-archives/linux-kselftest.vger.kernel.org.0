Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6145EE882
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiI1VoG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI1VoF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:44:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D66B1B8E;
        Wed, 28 Sep 2022 14:44:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so21680838wrp.11;
        Wed, 28 Sep 2022 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NEf7j7EJd9P7Df5FtSbX7lR7Htq5MRqRWoMxVQ8r/K0=;
        b=mcMEtCVzb5e/UNPsvKpP/kA3Zv0FHQTnKq8fkvaUTRh/jQ3wOQC/k6TzyV1QQZRr04
         FZetlkE6L2s++NItfZsH5t0EfIL4DeLdPTxWk76J8F0lY0IjrbGm5SV8Eoc1qxlCA2l3
         f4JdRpr7XJqUZ73JRnNyj+t6IDi2DN+uzSWTl1uqfwAMj0JLSNEgymakk7UwgtyiLM9D
         G1wEbrIk9uzbw5D85L3SZLXLkyFW8rLRmFle8+aJO+EVvN1Obs0wBBcNqTVVQaBHLb7D
         QhCCnBabyUDhR1pWzieBQLvGhFKuE1FKrO0mPciZrymEXeCmrJxT0+NJC4MSJXExmykR
         kzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NEf7j7EJd9P7Df5FtSbX7lR7Htq5MRqRWoMxVQ8r/K0=;
        b=FluT1e34t3pXwW27MkswOqgBA5zBD7j+HA5oPRph6zMZ1oZGdYRcrhKU81umnyJWBn
         Ldql1Guo/Q+2fJJ5SdZt2+dMxXPJ0TFP0aSrGAzvIoLHsTR6hx3OUUW8mjtNlZBki4QH
         S4mM5Dk/JQs7qupq2SLJSVMmQqQTI/+SD4+Zkc0xuCwt8XjxStNtGPsQ12Zzmx1ghbo1
         Uw4y3QG8orqDYS5p409RAdbyKKAMuvZqMwfILAu+nuP5t/ddOi3FpdaPGF2bixDsxZ5p
         pp5FlSoW3eAdCU+dDYiQzLe1uxxRSGCMKTdrz54qS4VrAQZ783MeDnJgAObjpCXgo0+V
         g8bw==
X-Gm-Message-State: ACrzQf1XIPJm3X6pBYlFwBduMRBNZkJpzfL5J37IEroJ/J7r4wrABDil
        fH3wHP83kSKEyVV65S2+LOouLF2CHtY0Sg==
X-Google-Smtp-Source: AMsMyM4EHjrO6EmYQnkxuhCygfBZhpQtYATiFRD/Hey0yrkbhfX4F3ekZQea4aSuY22ZKQH0sYevbw==
X-Received: by 2002:a5d:5644:0:b0:22a:6b69:27f0 with SMTP id j4-20020a5d5644000000b0022a6b6927f0mr22600896wrw.650.1664401442018;
        Wed, 28 Sep 2022 14:44:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b003b49ab8ff53sm2766952wmq.8.2022.09.28.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:44:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests/sched: Fix spelling mistake "hiearchy" -> "hierarchy"
Date:   Wed, 28 Sep 2022 22:44:00 +0100
Message-Id: <20220928214400.64970-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in a printed message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 8109b17dc764..62b579b601bf 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -267,7 +267,7 @@ int main(int argc, char *argv[])
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
 
-	printf("\n## Create a thread/process/process group hiearchy\n");
+	printf("\n## Create a thread/process/process group hierarchy\n");
 	create_processes(num_processes, num_threads, procs);
 	need_cleanup = 1;
 	disp_processes(num_processes, procs);
-- 
2.37.1

