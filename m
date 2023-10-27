Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE27D9267
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjJ0IoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjJ0Int (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 04:43:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C071BC7;
        Fri, 27 Oct 2023 01:42:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f613275so13584245e9.2;
        Fri, 27 Oct 2023 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396173; x=1699000973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Su06d3g/RWBb4+DMAaq/G++oBj/S2Aap11dmZjGAwP8=;
        b=RdsrMVyg//jvHjw79oeZmSAyDA5wKAUt5+Ijt4FC/RgcjWZB3Hk7TxI+cQdab3xIAL
         tw03Uj2tig02zfAsnZMVXkOPGdiZhOVeOdlgktrsIRGhprwv+5SUtwaqOGg2oV1deAVX
         O4HwMO8FeVWIMuzdcC/wyYOOw5SZ8B05kV65U+g5c5224GzQ9DlYnfDfyTodV6rxBjsD
         0GIPWuAe4J2b7npCyYCCRiLkhWh+o/+SbNeORNK9pKHZy9Uzf4/ruU1eR1V77qmwXNU9
         AQfgepP6BsMpxlFKjDmS4wcp+Z99Ta2nGE0PaJ6UqGwRLSq7VOOo3yF8AgHxq3Ks5YnU
         l06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396173; x=1699000973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su06d3g/RWBb4+DMAaq/G++oBj/S2Aap11dmZjGAwP8=;
        b=JY9h9vaHcTuFdGEo8bemUVv7xfyykJYuwCAHfX/PB1ykZVKGE97vO6n5BJdLEPNJpW
         tu+ALAxFpxXIdceungbrbcCXGY2e6b0/J9gT0KtkmmxrufB6aOZHAaWs7L0ihtw5Q0hu
         pQn9+cTYHfSDjpwDJiIgCwAcny8mO8ZvVO0ZB0VUnr8pPoMkD/D+eg0Ehrz46WTmFnjr
         NJte8Hn9bLxjW+EinvxRY49jMKFVdY2impq2Kz56TviUAtT6kEY/qdqEvRqsVSRj3dpv
         irXLkE3/3lWrnV10jcf3EjN6wP/OKSxd31SZ5iEC5JaBYh0F8IJ4sSjEUPx9T4OEURRA
         mxcg==
X-Gm-Message-State: AOJu0YyRnozUGL6qOAVWgx21hfmfkl9uUBY8ixuiVbgEeYkMBkos2vXp
        TVLyttrydJvkvNHd1IVq49Q=
X-Google-Smtp-Source: AGHT+IFlmOUMQ18Ip8AZhoad16ZwRRPgBiQp4M5mitaE98hQyDeoFF/1lDQspl//lmsJ6KMwkUz6Rw==
X-Received: by 2002:a05:600c:524f:b0:406:5463:3f51 with SMTP id fc15-20020a05600c524f00b0040654633f51mr1707855wmb.25.1698396172872;
        Fri, 27 Oct 2023 01:42:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c378200b004083a105f27sm4459448wmr.26.2023.10.27.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:42:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: sched: Fix spelling mistake "hiearchy" -> "hierarchy"
Date:   Fri, 27 Oct 2023 09:42:51 +0100
Message-Id: <20231027084251.1167279-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a printf message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 3e1619b6bf2d..7b4fc02a0d05 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -276,7 +276,7 @@ int main(int argc, char *argv[])
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
 
-	printf("\n## Create a thread/process/process group hiearchy\n");
+	printf("\n## Create a thread/process/process group hierarchy\n");
 	create_processes(num_processes, num_threads, procs);
 	need_cleanup = 1;
 	disp_processes(num_processes, procs);
-- 
2.39.2

