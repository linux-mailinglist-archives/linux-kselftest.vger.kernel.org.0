Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72052BFE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiERRBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbiERRBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 13:01:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F526B7D6
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ff17535eabso23927407b3.20
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4p2OIzyLZf5DSGNOpJEFrH/AUMGocyU2gKg4RrUCI6s=;
        b=o5OhYnQd0/SVCrvlR6BDzl8uSzC29hs7YQvNz7dWRteQ/kcph4lfVshtJMcGVo8NbR
         8oPMuS2Sy3hBVX0NlOaNEA1jYg1VVcAyjjB5W5GCnTurc+o6G6BnalBX94/qqs6hCzLs
         DctERLk5noT2qeLVnzOhKgBlIYCrTVRrvYb9LRF1DFeA5aXdX1vveh0/ZLWm258Bg5QT
         AqtIL3PC+7Dwsphqra6Pf2FpK5aG362O8TacCzJwMfbncnPDgIOlO3qFPVubRSYuK8yT
         mDb8PkHBaX+sR03HvwUcwMLP0EOOi2RoiJjRaOz2RMUvBc/Af3lA3sg/1OMeK5n6OeR3
         sTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4p2OIzyLZf5DSGNOpJEFrH/AUMGocyU2gKg4RrUCI6s=;
        b=oNbbY8Oj4pffliueuxOFLIHZ5G9PxT77VWlKdE2daUKLKXgkQ3waQ+g9oVmgrAO0LR
         c64/JhWhrMIhNfDo/3IcCWYYoMGAmonLQ7zl+6inxlt1iugMM7cMV9ilhIr9nMTojrBp
         Cr1Wlm0Gpdtb9MD7l3bB8QWRrQjfzTxCy6jtwgFiMsx9sgBPxF6wD1LNCSfN40jJcK4z
         jrYtmka+vo9e3oWJdgLZqZyKPYeadb7SlfOhnUYy0zO7OgUjkYH0Kh7NqT5tC6LQAJGy
         KxUDeNfdYssJNwB3rPobfrSj1sSm8NOU0CReZZmSr4lBBwiVgQW+MU7+ejWyKLeWz33A
         yDkg==
X-Gm-Message-State: AOAM533KjU7RQGw2NAe4TfH8rjXDivOsTSTVFPyRBT+HBhORXhuDVkaO
        ZRlq/IGmrUAEGLYuCkZ4UYr0d8wbqVBEhw==
X-Google-Smtp-Source: ABdhPJwzQoL+Dq+U5iIHnbnBF+QHziVBDA7Opsu9u46q835S42QBPgAJVd2R6NkKdXe9e7Mt9HkW5TVwAq+D1Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a94f:2cb3:f298:ec1b])
 (user=dlatypov job=sendgmr) by 2002:a81:bb49:0:b0:2fe:e07b:9a6c with SMTP id
 a9-20020a81bb49000000b002fee07b9a6cmr415296ywl.136.1652893300072; Wed, 18 May
 2022 10:01:40 -0700 (PDT)
Date:   Wed, 18 May 2022 10:01:23 -0700
In-Reply-To: <20220518170124.2849497-1-dlatypov@google.com>
Message-Id: <20220518170124.2849497-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 2/3] kunit: tool: simplify creating LinuxSourceTreeOperations
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop get_source_tree_ops() and just call what used to be
get_source_tree_ops_from_qemu_config() in both cases.

Also rename the functions to have shorter names and add a "_" prefix to
note they're not meant to be used outside this function.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 8bc8305ba817..e93f07ac0af1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -178,19 +178,16 @@ def get_old_kunitconfig_path(build_dir: str) -> str:
 def get_outfile_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OUTFILE_PATH)
 
-def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
+def _default_qemu_config_path(arch: str) -> str:
 	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
-	if arch == 'um':
-		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 	if os.path.isfile(config_path):
-		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
+		return config_path
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
-def get_source_tree_ops_from_qemu_config(config_path: str,
-					 cross_compile: Optional[str]) -> Tuple[
-							 str, LinuxSourceTreeOperations]:
+def _get_qemu_ops(config_path: str,
+		  cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it
 	# anywhere in the Python documentation).
@@ -226,11 +223,14 @@ class LinuxSourceTree:
 	      qemu_config_path=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 		if qemu_config_path:
-			self._arch, self._ops = get_source_tree_ops_from_qemu_config(
-					qemu_config_path, cross_compile)
+			self._arch, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
 		else:
 			self._arch = 'um' if arch is None else arch
-			self._ops = get_source_tree_ops(self._arch, cross_compile)
+			if self._arch == 'um':
+				self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
+			else:
+				qemu_config_path = _default_qemu_config_path(self._arch)
+				_, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
 
 		if kunitconfig_path:
 			if os.path.isdir(kunitconfig_path):
-- 
2.36.1.124.g0e6072fb45-goog

