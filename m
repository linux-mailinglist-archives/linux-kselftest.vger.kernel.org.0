Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889FC7E2BB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjKFSKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKFSKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:10:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8BD69;
        Mon,  6 Nov 2023 10:10:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc1e1e74beso43210235ad.1;
        Mon, 06 Nov 2023 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294241; x=1699899041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeaOI8MbYrugaPJQaJX+2xkIjaYuj35oOxvaZJrJ1M=;
        b=AocWBtufpEGONulTPtfyxORMMyVf53nZku/owOleGGbP32u4pZChHoVjQ/XbHgQjdl
         r60TkqnESc70VpHXayaYbemMih0SEUDyafkKIX8feJNMGJ2LSQYLR7zuRBNqTYzylV2m
         7xPQSZ9EpAmRNaPA01341n5NfD9Tv48MKjcYcRf0XM9LvqP/+AzucJA/Ip+L8QtyBH70
         f/YNqzgb7saz1/1d4kttN28faD3uLCaRRDGfOGTabsJ05A138GCLre4zZGwCfbw9vWfv
         HGRU44Uq2HsGqguxqQI4u/kreOrvxZPRFuvluaKRrFFYXzV23MmeYjdMpFyXRyiSpxE9
         QGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294241; x=1699899041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeaOI8MbYrugaPJQaJX+2xkIjaYuj35oOxvaZJrJ1M=;
        b=YWy6WaMwhQPknC8Uyjg4kjS+Ojy8xU1jQAhm0aUKRAV2kvWitm8FvHNxurGkrsTWBG
         Rpn+GH/2wccV2Hu3soHR+UGaXAeP3pH33D2pNIYzUVr3HPywKIuUGH1P6JcVArmJh2iX
         SMbC7rkFbQlo7lHJRUKqiZDn5OvDKQN41ffj6NN+n4HqPEt+rk5vV/piRGeiNWxM+DKx
         Qojzwj0zba3SOtejI8cmYNinbwW2TeSIbamPBIqY+xB+DsHf2+T5WOa6KgP3NcCGFeFE
         pffAluGeeQP7Wzhj1CTzdYb/PEhhTzIURgZBFIqgyj+ln8yZqKzYzDz0z3evB4n1F/EO
         Hcdg==
X-Gm-Message-State: AOJu0YygDCE/gVFoiu99rIdAfGjONPwc2h9RgoYOFQOe8XSfN26vuGMP
        pZZosI85EQ3zqz4SsnM6ci0=
X-Google-Smtp-Source: AGHT+IGPxAyjEIGTW0SVOf1c4n9pmp4SZmAl1KUT4gerqyFGpmwdD+PCMRj2sgL+m38KjWxF0YGP4w==
X-Received: by 2002:a17:902:f686:b0:1cc:510c:a0b9 with SMTP id l6-20020a170902f68600b001cc510ca0b9mr28510882plg.34.1699294241376;
        Mon, 06 Nov 2023 10:10:41 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6815:d829:2ad7:8520:6556:6c40])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b001bb3beb2bc6sm6167173plg.65.2023.11.06.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:10:40 -0800 (PST)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests: cgroup: Fixes a typo in a comment
Date:   Mon,  6 Nov 2023 23:40:34 +0530
Message-Id: <20231106181034.117120-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index ff519029f6f4..8845353aca53 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -740,7 +740,7 @@ static int test_cgfreezer_ptraced(const char *root)
 
 	/*
 	 * cg_check_frozen(cgroup, true) will fail here,
-	 * because the task in in the TRACEd state.
+	 * because the task is in the TRACEd state.
 	 */
 	if (cg_freeze_wait(cgroup, false))
 		goto cleanup;
-- 
2.25.1

