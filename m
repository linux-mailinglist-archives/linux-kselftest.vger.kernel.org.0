Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0771F76796C
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjG2AYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjG2AYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 20:24:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B182D61
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:24:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-780c89d1998so36572139f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690590244; x=1691195044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIeU+TWEJ9SHiH0PuMDlq+ijy5jWckAGkZXhCnVsnVY=;
        b=WOgKTJT75jB4KqOF6kEnfq0vx2OflxgDsz+zH43o8dD+xHb4h3OFWUiB0EoxBuqsSz
         poQX4LS/5mBeGowuzSOicZJ+aoc8o7CPNY1dBd+pgAi4t1Z+u9wi0/CdyrIWzv+oTiu+
         lTcIgyEZ8PKn3xtZbbvRkJmudW9J0CSq6LsaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590244; x=1691195044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIeU+TWEJ9SHiH0PuMDlq+ijy5jWckAGkZXhCnVsnVY=;
        b=RBDZIlkq9hacR05kMOJX7mGE6HFWrjqT5dN8ka+0io10go/W1Z/OvExuHl+4dMTjCC
         bMDGHin+2JCMweWN97Rsnhcm6tvFeCs8h8fIavI6U5f0nddIU9Bfuo1UAKTnlfLgXR14
         6Kql2lBw+eX+j4ohEjr5yukmXM9YYwd//iInaXUTbLuO9aU4c49VH35AxzmFlW3PH1SL
         pmgdlYsrQUfHiStuDDok1LZZ0rDvp+uBrOJeNzDXZ8hxcPILU6AG4CpYvVtLMv5YiISA
         fawQw4uFMVvGYM3qXOibQq1TtIHEAQlD8CSZP+t0frsvK4A2G5HxhzDhWY1CBrbWrBpE
         nt6A==
X-Gm-Message-State: ABy/qLahOdtpOMf3sm8Rysg/8daWjiFnyQWLfuQzz79nIOs1wjtljluP
        sabpmIkK9b7qgP0/Uv62DxaIcA==
X-Google-Smtp-Source: APBJJlFxzLDh4U/zUNgrcQ2hxtYq7pJ++OjUt0NgiNKY77A+Y8REpbsUiZgaUS+PiXRaDKHdpKlpUw==
X-Received: by 2002:a92:dc51:0:b0:346:1919:7cb1 with SMTP id x17-20020a92dc51000000b0034619197cb1mr788138ilq.2.1690590244776;
        Fri, 28 Jul 2023 17:24:04 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k25-20020a02a719000000b0042b4437d857sm1460925jam.106.2023.07.28.17.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:24:04 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] selftests:connector: Fix input argument error paths to skip
Date:   Fri, 28 Jul 2023 18:24:03 -0600
Message-Id: <20230729002403.4278-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix input argument parsing paths to skip from their error legs.
This fix helps to avoid false test failure reports without running
the test.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2: Removed root check based on Anjali's review comments.
Add netdev to RESEND

 tools/testing/selftests/connector/proc_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4fe8c6763fd8..4a825b997666 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 
 	if (argc > 2) {
 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
-		exit(1);
+		exit(KSFT_SKIP);
 	}
 
 	if (argc == 2) {
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 			filter = 1;
 		} else {
 			printf("Valid option : -f (for filter feature)\n");
-			exit(1);
+			exit(KSFT_SKIP);
 		}
 	}
 
-- 
2.39.2

