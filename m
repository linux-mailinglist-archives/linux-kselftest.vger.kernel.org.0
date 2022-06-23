Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6344455721A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiFWEqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 00:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiFWDsj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 23:48:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E423DA6B;
        Wed, 22 Jun 2022 20:48:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id go6so12849263pjb.0;
        Wed, 22 Jun 2022 20:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsyht3sgmYYULn2BwalrpicmmuWuVQoiTQ1cDnovyZI=;
        b=Fh9rVrgBgg+fJ064ccHdE04iqsy9AnKCfC82feNgD1xky08kEXIghlSvol19Zcn3zY
         MT+AtuBjcHcBeXwAD5Mm69HjR/3mGQridJzrwikZX3v209h1zNGJA2w47JyJRFKZ3CKr
         HDLGGYa+37TM2noPWQT6DPb8uRDRclJO94g2fjYZqDzIxYJsEQw0vMfdvNHyGMhaVePw
         8JkNHOkcbpn6OYdbaj1jWZOYhdB6b89tdzDH2tUALF9/XEdisgpYjBUYUzeScqbfK0eF
         qx+rLNRVy35BNSfLQYs3du6oruMoG0FzM0UZrIX+oweCxo66H01INSJ1eImBU8zf6FHK
         AGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsyht3sgmYYULn2BwalrpicmmuWuVQoiTQ1cDnovyZI=;
        b=BpYm3KpXiK+elhBhATzLEur2+xUJennhg5z7rZSerVKuk4eCiy6UlScqIs5v7cmhCL
         TR4/+9vwMdoFQYeP82KQJDXI5ZkOp1mMfdj/WE5G7HQA3+j0UJtaUB8xxYmPbio2Qy+3
         uTScHuvQ8b4EsTasuoG+4rOvJzYgo/SDxpW3oL6WN1b06uwN5rPQsQ62FWkWrkXf/bhp
         GhQ42DE5UnabubcRjI6Qur2nwYYcdNjLj7T53CUj2RmF91OshYpoEHzANNSwcwU/RbMw
         t9TMisahAIdxQ53pEPot+1jMZfyWo5A/hwRaD/nIAjtKqx27FU9Ov3TiRlOaq3zHoZ5S
         mEUA==
X-Gm-Message-State: AJIora8RahRR7QkeFtvHO2q9J7CnkI6NFXKFYyBSw2HZyAqC589rQt5l
        WBQMLVBSxBlCB07L5ADN9DY/CjhHWwXuyeLL
X-Google-Smtp-Source: AGRyM1vCa2ak1o1+dGrzb37ts8dOOOUuZPW8cwpz/w3NQQzFy5XARr/g9vaGJ+/GjmtfnnhQV4nytg==
X-Received: by 2002:a17:90b:3a87:b0:1e8:8740:43e7 with SMTP id om7-20020a17090b3a8700b001e8874043e7mr1806964pjb.41.1655956118036;
        Wed, 22 Jun 2022 20:48:38 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id ga23-20020a17090b039700b001ec92575e83sm609865pjb.4.2022.06.22.20.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:48:37 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Make the usage formatting consistent in kselftest_deps.sh
Date:   Thu, 23 Jun 2022 09:18:32 +0530
Message-Id: <20220623034832.172505-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a colon in the "Optional" test usage message to ensure consistency
with the "Default" test usage message.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/kselftest_deps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 00e60d6eb16b..708cb5429633 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -26,7 +26,7 @@ echo "  main Makefile when optional -p is specified."
 echo "- Prints pass/fail dependency check for each tests/sub-test."
 echo "- Prints pass/fail targets and libraries."
 echo "- Default: runs dependency checks on all tests."
-echo "- Optional test name can be specified to check dependencies for it."
+echo "- Optional: test name can be specified to check dependencies for it."
 exit 1
 
 }
-- 
2.34.1

