Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B130866B40B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAOVFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjAOVFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 16:05:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34F14485;
        Sun, 15 Jan 2023 13:05:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id br9so4947972lfb.4;
        Sun, 15 Jan 2023 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwWFD9Hfw3we2dLRn1IrxJw5h5Z4boQvnY3aEPbTVow=;
        b=mjpWAGgXpDlKZFtqsPBnCdvUwlIBC3uC9bANdU6xh9qK76er4wGJT5BSbF+ad9kS+E
         lDh8p+qqq3cTAJrDriY/385hCH0qXKbn2Ll3Omr8KwHPYBj4BVyYwVWavBZT5tV5zvO9
         BbuHKDj2eBHbINyHXyGotMAl70YO4rZqmHqRDyHGTXq/fwKITpUDMGUNvW9PGz6fHTwy
         WdbzIOL6uGItmAIxKkDpvAuIpX7Ke2vUP6TCdLfgHvLsPORu68zZvSkZlMrYP/RsgIYF
         5LEQ34vLhQeeXgFCS8f0tCwT8rukKIgwFfF6br8IQVHGpBei+5NQWaluszpWw3flgm5I
         wI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwWFD9Hfw3we2dLRn1IrxJw5h5Z4boQvnY3aEPbTVow=;
        b=zYvinwZ+mx0490J0fsCUpPxeShxANDL+eBTMpyo2WkwThzPa7oN2TnjukigoopdUtp
         k8j65sdTpyN3FPNKjSNuN0SU+BVUJ4eTGSB8shITZp8f3WuHUHRZ3Uiz2Cp+xTDPqBft
         1Flwo8NHCKU9yNIUDjBpY5t4ZOW2VyKQViP0wP/juIc07xRStdvuZ/o74pitZHzDxeGK
         dGZWaFpaEfgR0C4NGurlIhJxZ7bZNXYBWwCAHlxQqyfsYAk8JgaLAZv3r+dCL/Dym7d6
         KMiYaf3kv23+7nRS+CnrJ2krh/NHqOh6oQ7V5fAyZa2sIsiQHrjwR6j/qJ8E2K/vvKMY
         tU9g==
X-Gm-Message-State: AFqh2kqtsUPfxOcB3E0sBuvkRhq9GjMKSFzUX1DQp8nyDqeBMvRjjpim
        7AhJnohKy+iuZCM5X4yT9lo=
X-Google-Smtp-Source: AMrXdXsQ51EvNCYWXrJUR6xjGhzKCaHk8GDYx8C1fSQgimX7gCa38NVHVzY5VgHhIq0+Zg4JL5pD9Q==
X-Received: by 2002:a05:6512:21c6:b0:4af:e55a:dc69 with SMTP id d6-20020a05651221c600b004afe55adc69mr28892520lft.4.1673816740776;
        Sun, 15 Jan 2023 13:05:40 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651220c400b004b4b600c093sm4795141lfr.92.2023.01.15.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:05:40 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     brendan.higgins@linux.dev
Cc:     davidgow@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
Date:   Mon, 16 Jan 2023 02:05:35 +0500
Message-Id: <20230115210535.4085-1-apantykhin@gmail.com>
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

The build_tests function contained the doulbe checking for not success
result. It is fixed in the current patch. Additional small
simplifications of code like useing ternary if were applied (avoid use
the same operation by calculation times differ in two places).

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/testing/kunit/kunit.py | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 43fbe96318fe..481c213818bd 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -77,10 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
-	if not success:
-		return KunitResult(KunitStatus.CONFIG_FAILURE,
-				   config_end - config_start)
-	return KunitResult(KunitStatus.SUCCESS,
+	status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
+	return KunitResult(status,
 			   config_end - config_start)
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -92,13 +90,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
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
+	status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
+	return KunitResult(status,
 			   build_end - build_start)
 
 def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -145,7 +138,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
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

