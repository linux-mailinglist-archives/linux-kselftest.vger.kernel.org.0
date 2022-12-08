Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6F64710B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLHNxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 08:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLHNxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 08:53:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC83204C;
        Thu,  8 Dec 2022 05:53:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1050719wmi.3;
        Thu, 08 Dec 2022 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2v8l5THJ19GAjS4O893x/pYLkkbHLYw6NG1nL55YPFc=;
        b=AL19aAA79DEHlxU2LBDbITcgE09dwsxmvXgb6m3ikkCGqlcqc7LNc1YT+vU0WEdmMU
         IXdkiJEFU3UWYfJSx6oxzZbgiozELKNpcbq7iG+o2g1Q31ou0UX65S8nkCwoRwLKH7IS
         J0lhIkXCny3lTS7iU/t7yAPz7F89klF3sgBJMCEt0LaTeAkSKduMCXW3nBYjl0Gg2G59
         +1RvMbKeKU6j3xBBpv63Ax2oQpK/2ExCIylx3H1Ub6tmkxyZBzzQ2+VPt4V/Acxzgr2H
         z6iNrBMHcrwuJjguz+Ykd96gUCrIphHYoeu6TrtoBEqwK6a8fkmIqZ/BUE2GJQxiY3Wm
         mj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v8l5THJ19GAjS4O893x/pYLkkbHLYw6NG1nL55YPFc=;
        b=Vx/H7ltFBu8yPSD5xPNCwF499RSdsvv7wtWmnwp1CNF5sWJOs56Z6kZLZPVyem1dYa
         eeRp41wpZSOluIsbsgbERwB8N6Qh6ZbKhhHOHsP4y2trxVwFR4g9RcKEWfaPUduRsuJq
         Orx5TeDryltoH7agp49neXQJwGOjK4xcyVEf+8oF6Y6+ecFABRDLJ3F1Or0QvV9jCXz9
         b7LdN8uZWWwgu5xYihHQFM8SZhVf3WxE9aVC2A4ba0bkXF5hzXxhXKVvCHOEh13aMp9q
         QGtZURXCUGcGSZXJnfgMgXwbGGz0r7Yqqwv3h0+nBPpHOxnthojghfuMLPhVOt2Q+hwR
         N6yQ==
X-Gm-Message-State: ANoB5pnFfXMyor+cb9mAGnhoDLqttslKVk0sUjpAs6+Oz12uFjGFLI8D
        N4kzuidAiEocAoqsH1UgR0F0ZN06ooCCbcvOOf4=
X-Google-Smtp-Source: AA0mqf6Bi3YvmAgQHC3Yt6sL/8Ifia4RSL0RqODEeiOHDgXMgNNldxonwBXOgCAjtOx5rpss4/Fs1Q==
X-Received: by 2002:a05:600c:1e08:b0:3c6:e63d:b89c with SMTP id ay8-20020a05600c1e0800b003c6e63db89cmr1974812wmb.11.1670507587793;
        Thu, 08 Dec 2022 05:53:07 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003cfa622a18asm4994319wma.3.2022.12.08.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:53:07 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: Fix spelling mistake "eith" -> "with"
Date:   Thu,  8 Dec 2022 13:53:05 +0000
Message-Id: <20221208135305.2445846-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

There is a spelling mistake in a ksft_test_result_fail message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index df0ef02b4036..5cc2481507a6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -288,7 +288,7 @@ static int do_tests(int uid, const char *our_path)
 				"PR_CAP_AMBIENT_RAISE isn't supported\n");
 		else
 			ksft_test_result_fail(
-				"PR_CAP_AMBIENT_RAISE should have failed eith EPERM on a non-inheritable cap\n");
+				"PR_CAP_AMBIENT_RAISE should have failed with EPERM on a non-inheritable cap\n");
 		return 1;
 	}
 	ksft_test_result_pass(
-- 
2.38.1

