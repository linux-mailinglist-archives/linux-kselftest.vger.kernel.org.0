Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423F4443C2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 05:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKCEZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 00:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKCEZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 00:25:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F3C061203
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 21:22:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 3-20020a620403000000b0044dbf310032so727707pfe.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0XauQlZsaPUfyum8gatBpe8x8WpyNCmm8SdAdVAZ9Qo=;
        b=DH/50Tu1YmUDH6wSMIfrdQahebDs+g8pBwDxf7xOVKI/RwroMkffOccH2HgZwPuNmX
         Lbt6kJ8e8Ao2YMbgirpGdSlk8+X32EBih0w5+D9PlteoIZGgQP9lURxFcIgQ98+SniVk
         e195YnEcNZqSYWNfmQOLn9wWCwmlNzFKxYWXWBuNSPq94vOna3SNVhsXBJLX/CUJ9RsS
         SdJ/TzLe1zkiSwdMcPwsZD2/SU0Lcu+3XZH/yOergrpIBjWWwHSi2BJihKBeWjMgZxul
         bB/Zl8iwByCbyls2F9afcYkALfZeuEsyE01aaSouD5j3mogNY1MSU5PPM9Fw1N9qG6tA
         RaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0XauQlZsaPUfyum8gatBpe8x8WpyNCmm8SdAdVAZ9Qo=;
        b=C8TA1//SHyZaFvVF9fqlKYLEuzSL3iYfMHP1XqsLe6OGg1Acr5AODqkaBkCUJ0BjhM
         EYVsk77M2+UWluZ1Rx1gje/BcBJAnCp1kH8LP4G4ePSs8RGdqOkqB2uKZgli6tMpE1Cr
         GHUa7GowqA7mZnvn95G3vzMBhDHU15xiOFgJZJL9Eaw4rbKbDkMR/OZFixv7qCnXTKvy
         mRIhmaRGbuFkVu8l+PunRfzv5Pl4MAZ2uA5l/b9gWIGPGzPo6EsfvpiROtR2C4aAFEth
         RSfJMrwQRm26yDj1E3R03QztxpVTCYWez3UY5PwriHf0QuevDEr6A1c+sdbSMmvHjNan
         rl0A==
X-Gm-Message-State: AOAM530v+dW+WYgChNG0B9UWHf0VnXvk4X8UhpS8mVrLS8PIC7a2YPp0
        a3agtyHU+iC8Q/cOaaDfoWiUt674VhglZA==
X-Google-Smtp-Source: ABdhPJy6F6sECljSr8P+CKXCM5bzqTUqG8i1/Lv+sXbzT0r+Ugr2nDhG9i/PiVruwD/smdMXZo7K7KCWuu1RMQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8673:8d2f:d693:6af])
 (user=dlatypov job=sendgmr) by 2002:aa7:8016:0:b0:481:2405:e72b with SMTP id
 j22-20020aa78016000000b004812405e72bmr9625182pfi.54.1635913352981; Tue, 02
 Nov 2021 21:22:32 -0700 (PDT)
Date:   Tue,  2 Nov 2021 21:22:28 -0700
Message-Id: <20211103042228.586967-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2] kunit: add run_checks.py script to validate kunit changes
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This formalizes the checks KUnit maintainers have been running (or in
other cases: forgetting to run).

This script also runs them all in parallel to minimize friction (pytype
can be fairly slow, but not slower than running kunit.py).

Example output:
$ ./tools/testing/kunit/run_checks.py
Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
kunit_tool_test.py: PASSED
mypy: PASSED
pytype: PASSED
kunit smoke test: PASSED

On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
E.g. adding in a type-checking error:
  mypy: FAILED
  > kunit.py:54: error: Name 'nonexistent_function' is not defined
  > Found 1 error in 1 file (checked 8 source files)

mypy and pytype are two Python type-checkers and must be installed.
This file treats them as optional and will mark them as SKIPPED if not
installed.

This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
play nicely together.

It uses --build_dir=kunit_run_checks so as not to clobber the default
build_dir, which helps make it faster by reducing the need to rebuild,
esp. if you're been passing in --arch instead of using UML.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/run_checks.py | 81 +++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 tools/testing/kunit/run_checks.py

diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
new file mode 100755
index 000000000000..4f32133ed77c
--- /dev/null
+++ b/tools/testing/kunit/run_checks.py
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# This file runs some basic checks to verify kunit works.
+# It is only of interest if you're making changes to KUnit itself.
+#
+# Copyright (C) 2021, Google LLC.
+# Author: Daniel Latypov <dlatypov@google.com.com>
+
+from concurrent import futures
+import datetime
+import os
+import shutil
+import subprocess
+import sys
+import textwrap
+from typing import Dict, List, Sequence, Tuple
+
+ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
+TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
+
+commands: Dict[str, Sequence[str]] = {
+	'kunit_tool_test.py': ['./kunit_tool_test.py'],
+	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
+	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
+	'mypy': ['/bin/sh', '-c', 'mypy *.py'],
+}
+
+# The user might not have mypy or pytype installed, skip them if so.
+# Note: you can install both via `$ pip install mypy pytype`
+necessary_deps : Dict[str, str] = {
+	'pytype': 'pytype',
+	'mypy': 'mypy',
+}
+
+def main(argv: Sequence[str]) -> None:
+	if argv:
+		raise RuntimeError('This script takes no arguments')
+
+	future_to_name: Dict[futures.Future, str] = {}
+	executor = futures.ThreadPoolExecutor(max_workers=len(commands))
+	for name, argv in commands.items():
+		if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
+			print(f'{name}: SKIPPED, {necessary_deps[name]} not in $PATH')
+			continue
+		f = executor.submit(run_cmd, argv)
+		future_to_name[f] = name
+
+	has_failures = False
+	print(f'Waiting on {len(future_to_name)} checks ({", ".join(future_to_name.values())})...')
+	for f in  futures.as_completed(future_to_name.keys()):
+		name = future_to_name[f]
+		ex = f.exception()
+		if not ex:
+			print(f'{name}: PASSED')
+			continue
+
+		has_failures = True
+		if isinstance(ex, subprocess.TimeoutExpired):
+			print(f'{name}: TIMED OUT')
+		elif isinstance(ex, subprocess.CalledProcessError):
+			print(f'{name}: FAILED')
+		else:
+			print('{name}: unexpected exception: {ex}')
+			continue
+
+		output = ex.output
+		if output:
+			print(textwrap.indent(output.decode(), '> '))
+	executor.shutdown()
+
+	if has_failures:
+		sys.exit(1)
+
+
+def run_cmd(argv: Sequence[str]):
+	subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=TIMEOUT)
+
+
+if __name__ == '__main__':
+	main(sys.argv[1:])

base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
-- 
2.33.1.1089.g2158813163f-goog

