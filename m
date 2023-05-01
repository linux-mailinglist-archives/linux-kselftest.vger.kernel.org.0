Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68B66F35BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjEASQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 14:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEASQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 14:16:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B0C1986
        for <linux-kselftest@vger.kernel.org>; Mon,  1 May 2023 11:16:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e116d1a05so818267a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 May 2023 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682964983; x=1685556983;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTDCHDt1fJfJYcxlD44zwYcY/Rj9XwKQhtn/YVRrmp8=;
        b=Q4NwHl8ELgu+CuHSTm7rZOpj3G8dviomnxGEfuFBa1UQKO8PSd5tDzYzI8T9MWxmY3
         lQAnl451Gu+4BiAhZ3d0QeHcmrO5/GzQEa44522lgvpUzLFBdc7uAsFWXO3/oj3FEU7n
         CVuFog1n/l4MarxjDjp3jLP7ciXJX9V358SF9QquYOt0ZfHQ7uEq4EToiUnz1d4eEcV4
         ouFHh7cP3o5BfTEZAEgh3pRnDLyLSaTaYp2droGOyfV58T1i1XJoy3aQJNO3YHIy4ZFy
         /3gWh07x7xVZKvMmMPhlkzI1qtJ/aRIEneLaR7S5+ZXsMov0kTiNFeORvLOVDtUNvun5
         m/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682964983; x=1685556983;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTDCHDt1fJfJYcxlD44zwYcY/Rj9XwKQhtn/YVRrmp8=;
        b=adDcrwutXrA9f4X3cIHybXdIy/lgO3OEZC7oVFFteWZOwPyV2AjOrR84Jz9uqZKsWS
         UeEGLQMf+aDfsKOLY/RwpW36BQ68pxQOmVYnZ3c+MIl7SmEGRYAQzso6yByoBMbAXL7V
         8S+QdYcvPJivmiCilSmwy9rw6GglVDG6p14UA4dN+1bZifhKh3H32ADV+9IrZ9yJ3R15
         fAL0I1GypG6gWB5ulhZjZk59XdisskuPdLSDzPlA8O4RSWZug5Oq4T8i3fbA/ABEtpOg
         N+bXuoVETT6s+y0HHBjW2aOhed4mq8R/Vb4DqIEzyhlOeeTbT/knwb8dWy1Xjhlk4DS9
         ofWA==
X-Gm-Message-State: AC+VfDy/fb/guxKPjRQWAMDPS21acrdT5IHlTTlnKY8b5dQcJEOrqOJK
        WJFX5ft6dO8oASI18pWGM1GMSZ66uTD9gw==
X-Google-Smtp-Source: ACHHUZ4gt6gAfJ8ZekFSXr2ZlYARKSLciEnvONUdw/tvJS7eR3UFGI7l6YI86YxLlC2ypoF9TW290dZ70wXckA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:644a:b0:24e:1915:5ba3 with SMTP
 id y10-20020a17090a644a00b0024e19155ba3mr374293pjm.5.1682964983512; Mon, 01
 May 2023 11:16:23 -0700 (PDT)
Date:   Mon,  1 May 2023 11:16:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501181610.2617032-1-dlatypov@google.com>
Subject: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net,
        Daniel Latypov <dlatypov@google.com>,
        SeongJae Park <sj@kernel.org>
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

Writing `subprocess.Popen[str]` requires python 3.9+.
kunit.py has an assertion that the python version is 3.7+, so we should
try to stay backwards compatible.

This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
pre-existing `mypy --strict` errors and update run_checks.py"), since
mypy complains like so
> kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]

Note: `mypy --strict --python-version 3.7` does not work.

We could annotate each file with comments like
  `# mypy: disable-error-code="type-arg"
but then we might still get nudged to break back-compat in other files.

This patch adds a `mypy.ini` file since it seems like the only way to
disable specific error codes for all our files.

Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
but I think being explicit is better, particularly since most kernel
devs won't be familiar with how mypy works.

Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
Reported-by: SeongJae Park <sj@kernel.org>
Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 6 +++---
 tools/testing/kunit/mypy.ini        | 6 ++++++
 tools/testing/kunit/run_checks.py   | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/kunit/mypy.ini

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f01f94106129..7f648802caf6 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		raise RuntimeError('not implemented!')
 
 
@@ -113,7 +113,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
 		qemu_command = ['qemu-system-' + self._qemu_arch,
 				'-nodefaults',
@@ -142,7 +142,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
 		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
diff --git a/tools/testing/kunit/mypy.ini b/tools/testing/kunit/mypy.ini
new file mode 100644
index 000000000000..ddd288309efa
--- /dev/null
+++ b/tools/testing/kunit/mypy.ini
@@ -0,0 +1,6 @@
+[mypy]
+strict = True
+
+# E.g. we can't write subprocess.Popen[str] until Python 3.9+.
+# But kunit.py tries to support Python 3.7+, so let's disable it.
+disable_error_code = type-arg
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 8208c3b3135e..c6d494ea3373 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -23,7 +23,7 @@ commands: Dict[str, Sequence[str]] = {
 	'kunit_tool_test.py': ['./kunit_tool_test.py'],
 	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
 	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
-	'mypy': ['mypy', '--strict', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
+	'mypy': ['mypy', '--config-file', 'mypy.ini', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
 }
 
 # The user might not have mypy or pytype installed, skip them if so.

base-commit: a42077b787680cbc365a96446b30f32399fa3f6f
-- 
2.40.1.495.gc816e09b53d-goog

