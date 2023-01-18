Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7276715E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjARINj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 03:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjARIMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 03:12:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE394C6D8;
        Tue, 17 Jan 2023 23:42:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g13so50519858lfv.7;
        Tue, 17 Jan 2023 23:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WogcXw5V1dMUk2yAmcSaqUx3fjFKGGjC2OchSCFaRqI=;
        b=W1vKNzXcW4o7IgdoAL+E9UDjAPHxmJQ9sTOucXTBt9P7tTTRkfvNaK2uKALGjWEqkV
         P30POXU33GsV+zVFKLvSVc08Nn1ozsS7uyQdCzunMCqjJCwWdi5jo13qsVQjqSKsemZv
         +DEDaxw1/38djQa9aKIe/l041tjx7fxCH45m6Yo1ymPeToGZ0Eg/xggLs1mnCc8qtXp5
         fQRViXuU5XPr8dXypHCsYw4swi76ByhxTI0GXW+jV7iMrPQXUfUxjkRL4DHj4XkTQGQT
         UCTd8iQL47QPXGe7pyYvh+6hboJ9JFlKGOKJwaZk/GPcUV+OdueEahid+LHRjg0s+/GF
         8wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WogcXw5V1dMUk2yAmcSaqUx3fjFKGGjC2OchSCFaRqI=;
        b=Kyqq9keluFRVMfhk9uCOCJESDf7Gi0lInOGBieBVYeiwEFZhVevjFffOmZ8nHZ5RAN
         eAyhkWr36g8X5oa2aLXP8SYpMvYa7htEOF92D0KA1dANKwevJ5PLzkhJW0eiALRh6xoU
         buKb8XydFF87dDDh6KRRFfvu4WHix5T8KaHOtxPy+JkG5Ymtb0S3EjoCKbv9NvRyxZ29
         dOSsW4QRVAwTGk/aITIHy8nhwie/8mRYC/C7sx/fmFxDXgy4naptNF7xHea5uH8k0IuI
         MJ+oXtGl2VXYEA5vD90aHufiBtxg4h4S0vflG/SRGTb3XZVD8kDwx5KgA/dbtekq81rQ
         wgxw==
X-Gm-Message-State: AFqh2kojd0Es33cY5eFqAw5MCgtPn7T5DodB/EXkPn8Cys4TDzkc28E/
        IgwCxY3WKC0VhqpElt097No=
X-Google-Smtp-Source: AMrXdXue+OGDgorAqaEOtatXxZXkTPdQ1/cJFe/pnQXlzV0Bu/t8n4gQWL68XKAFQx06ucpwca+Cmg==
X-Received: by 2002:a19:ac0c:0:b0:4c8:ae6b:ea8d with SMTP id g12-20020a19ac0c000000b004c8ae6bea8dmr1321742lfc.8.1674027744171;
        Tue, 17 Jan 2023 23:42:24 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id z17-20020a056512371100b004cc898ce1c5sm3831792lfr.163.2023.01.17.23.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:42:23 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     davidgow@google.com
Cc:     dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH V2] tools/testing/kunit/kunit.py: remove redundant double check
Date:   Wed, 18 Jan 2023 12:42:19 +0500
Message-Id: <20230118074219.3921-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The build_tests function contained double checking for not success
result. It is fixed in the current patch. Additional small
simplifications of code like using ternary if were applied (avoid using
the same operation by calculation times differ in two places).

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/testing/kunit/kunit.py | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 43fbe96318fe..0e3e08cc0204 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -77,11 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
-	if not success:
-		return KunitResult(KunitStatus.CONFIG_FAILURE,
-				   config_end - config_start)
-	return KunitResult(KunitStatus.SUCCESS,
-			   config_end - config_start)
+	status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
+	return KunitResult(status, config_end - config_start)
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
 		request: KunitBuildRequest) -> KunitResult:
@@ -92,14 +89,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 				     request.build_dir,
 				     request.make_options)
 	build_end = time.time()
-	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   build_end - build_start)
-	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   build_end - build_start)
-	return KunitResult(KunitStatus.SUCCESS,
-			   build_end - build_start)
+	status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
+	return KunitResult(status, build_end - build_start)
 
 def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   request: KunitBuildRequest) -> KunitResult:
@@ -145,7 +136,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 		tests = _list_tests(linux, request)
 		if request.run_isolated == 'test':
 			filter_globs = tests
-		if request.run_isolated == 'suite':
+		elif request.run_isolated == 'suite':
 			filter_globs = _suites_from_test_list(tests)
 			# Apply the test-part of the user's glob, if present.
 			if '.' in request.filter_glob:
-- 
2.25.1

