Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22864687DFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 13:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBBM40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 07:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBM4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 07:56:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E3402F6;
        Thu,  2 Feb 2023 04:56:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q8so1308709wmo.5;
        Thu, 02 Feb 2023 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dViUpgOu7xLc5fDN/SMu/8eP28LlUDsFZqiXHAAyROM=;
        b=SNifHJ85O3o385JpXqVafvUJVG+BYvek0CVN/K+YRGWQtdvZYNHiq3r6wKYLW7Ujoh
         vlQYrWILrjOLnc59cG6PaEf3yD+nuPRdum0niG99F9n3Y6JG5eLHaH3fY/WbpXyjTuIf
         6gQo+432AmXXW6Ir8moAj/UPNUAo7Hqy7h8O2XV2qyZrs9e1fxdPTEJ5z3M2fHfbevaG
         8aFO8Vungf6AUTjFrl4pi7CKk9912YgpsrZuf6T3eMKFnOvQFDHQ3ZtdbIStMkx7jrPJ
         QIqQyaAdq4rkZfRMnTAS4D42/LC08AwVuDfD+ImOnNH8hCLvbwJ+opfR6ftYQCrQZuc1
         c23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dViUpgOu7xLc5fDN/SMu/8eP28LlUDsFZqiXHAAyROM=;
        b=bHC/pkW3ac76/UY7q2uRJAplL0Pe9yjy6HRSzx2sI4ASKKA3E94tUJrJsI8heBGrgK
         D3hR/XVt4f1hQzCtHwzYm0y4pTiMcSgdIvoWnIPbKMDmZ7lBgg01n4xdi4+uHrb/ijqU
         MRyGd8DPRjEiby0Yg1jr3ACPN7AgJPaDr5BTcF4FbWNH2TjAE0i9eHemGRaC5+mYh8Fg
         lcF1UFG43qRVrHMbbsUkECQmiLqfpj1G1iJLR5bf8WwzJ7wdQNJNtqlI7WeaSAy3XM6c
         zq9Nb7XO38YpK7N2GLaaeZjzCpzvZXKH2typIUBPdzY1i7EAHBLjpjf0pL+8+XgHZ9Xh
         mapg==
X-Gm-Message-State: AO0yUKWTlx/YVd/8Omyi7l2urnWJrzKguGWenTdHA9ILNIDOM67urysH
        wig4VeuX27Es6Cw6rIMVJD8=
X-Google-Smtp-Source: AK7set8TAyJmdcKU6pdmjsbdBHTK1M0kLQCgk3huo6MozWoV82H68n6cv/0c5RkdqWG5nHaeL8nyFQ==
X-Received: by 2002:a1c:7c0e:0:b0:3dc:4548:abe6 with SMTP id x14-20020a1c7c0e000000b003dc4548abe6mr5671531wmc.12.1675342582679;
        Thu, 02 Feb 2023 04:56:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003db012d49b7sm8172691wmr.2.2023.02.02.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:56:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: Fix spelling mistake "allright" -> "all right"
Date:   Thu,  2 Feb 2023 12:56:21 +0000
Message-Id: <20230202125621.286309-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There are two spelling mistakes in the test messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c | 2 +-
 tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c b/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
index 62a93cc61b7c..6d1a5ee8eb28 100644
--- a/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
+++ b/tools/testing/selftests/prctl/disable-tsc-ctxt-sw-stress-test.c
@@ -79,7 +79,7 @@ int main(void)
 {
 	int n_tasks = 100, i;
 
-	fprintf(stderr, "[No further output means we're allright]\n");
+	fprintf(stderr, "[No further output means we're all right]\n");
 
 	for (i=0; i<n_tasks; i++)
 		if (fork() == 0)
diff --git a/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c b/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
index 79950f9a26fd..d39511eb9b01 100644
--- a/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
+++ b/tools/testing/selftests/prctl/disable-tsc-on-off-stress-test.c
@@ -83,7 +83,7 @@ int main(void)
 {
 	int n_tasks = 100, i;
 
-	fprintf(stderr, "[No further output means we're allright]\n");
+	fprintf(stderr, "[No further output means we're all right]\n");
 
 	for (i=0; i<n_tasks; i++)
 		if (fork() == 0)
-- 
2.30.2

