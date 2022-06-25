Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35DD55AC35
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiFYTw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFYTw6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 15:52:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEDEDA9;
        Sat, 25 Jun 2022 12:52:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so8700516pjg.3;
        Sat, 25 Jun 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBICSrZ7ZTWE0aGK5zqnffAevM2FyYaErZq8jVNzZXA=;
        b=QMQzLC22KyQXzmmmmZz6u5dIeDl23a/ENie1aFh9995ukEC0MzKuKszLQl+8mcAwh7
         YPKbC09oROeAK125AYXWnHmXsgWRoXfx+hOnTgmX8IlzsG8fzyxSysbZDzzzIi7PNqlE
         ZMtA6mW04ey2gLGM024Tb1B3yrV0jH6nb1RWXbSzfyPvEN7V2fkwrVYgLJk82PjCmMSe
         fynTwVvBKtSrzi+F4ReP+VRyL1jzCvXsVAPVWKBkPB/nJskPURhNwm+WaM3WuhXNfECo
         M/PaGWCraxwncSPxHxZyoFxMQ0wpSdqvjl27d7uUiF3ZZHK0dh5oEHkOpuNkhzzjRdYa
         +u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBICSrZ7ZTWE0aGK5zqnffAevM2FyYaErZq8jVNzZXA=;
        b=wD/AoMr2RVaIsVlBLjLZ3kUC+1XiLDSKfNqjQQeUhMEpkcoaEW6h35h6G1uYdF3NK3
         iOfiyuTyfK08jpjXqAaVTzGbj4hLQoGTLuaQFMxMAYc8B+CyuoAqfpMlzPftVGrP3nYe
         BRMeRfHpfGMcM0xSNlofj9ae7g5Dj6qAGK7J8Z6GnWdLbiSF0HOpKbnmjY6FAfoZ2nG+
         xCO6xDqAU3336ycy3PgZOEcDe43NmSw9CHQTuRZb6b73oGhA+kF4KsA+dz1406DOyXki
         uf+Sq7i2tyEKG3PhxJ2fUiL0kGSLZ09laqOYOYMokK2+qsxO52/MfpBPrfkfnnPrni4m
         FLdQ==
X-Gm-Message-State: AJIora/A47Wx8Tf/UBp3vclys9ZtFjyR6R8/KrPoMEj9Zq41WXisXdPm
        x5+W+57dTE7EYHFyFsvnsMk=
X-Google-Smtp-Source: AGRyM1syOXb9wi5OVYdsvYAFPIYyai2W+N5NrJh+uFS3ivN1hfO6l7MW6BEDR/COeMHTur99obiNcQ==
X-Received: by 2002:a17:902:b083:b0:16a:2ce3:ffe6 with SMTP id p3-20020a170902b08300b0016a2ce3ffe6mr5703160plr.151.1656186776808;
        Sat, 25 Jun 2022 12:52:56 -0700 (PDT)
Received: from fedora.. ([2409:4042:261d:8029:35f0:415b:b9b4:3fcb])
        by smtp.gmail.com with ESMTPSA id c12-20020a624e0c000000b005258df61ceesm1335163pfb.90.2022.06.25.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 12:52:55 -0700 (PDT)
From:   Gautam <gautammenghani201@gmail.com>
To:     sj@kernel.org, shuah@kernel.org
Cc:     Gautam <gautammenghani201@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Sun, 26 Jun 2022 01:22:45 +0530
Message-Id: <20220625195245.4368-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625185501.85168-1-sj@kernel.org>
References: <20220625185501.85168-1-sj@kernel.org>
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

The kernel is in lockdown mode when secureboot is enabled and hence
debugfs cannot be used. Add support for this and other general cases 
where debugfs cannot be read and communicate the same to the user before
running tests.

Signed-off-by: Gautam <gautammenghani201@gmail.com>
---
Changes in v2:
1. Modify the error message to account for general cases.
2. Change the return code so that the test is skipped.

Changes in v3:
1. Change the name of variable holding the error message.

Changes in v4:
1. Correct the mode of the source file.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 0189db81550b..0328ac0b5a5e 100644
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+permission_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$permission_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
-- 
2.36.1

