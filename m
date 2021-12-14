Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3B474C4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhLNTwN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhLNTwM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:52:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132AC06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:52:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso38067909ybg.6
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L86jfhQydnQXL6CamLYct86bySYxzVKAkcuD/e27KRQ=;
        b=aMJ9Kzugd7pZU8r6r6E7GF9dNicFjDFEUyWh8T291/4qwmpNg9RHCPTrhY61fakNTK
         CkoLXML5fIEWHR3zF8dXH1NNI+20G9BjewaD96LAqiNp/syyssY8li2AcEPTciqKahLy
         28QXHVPTPl0iMizHy6T1oAzZ/GmISGCDVvQuiG69Ea2nPjojHuMx6Qxrb5Cz98k60XYb
         tt6VCUFs7ompA298s84PNh2CVirOG5+RvwvFNW2gtibnN3505P8CMEGmMTx+qsQFiY0p
         nCS+1gCC6x3eNKQz8kiDraPyu7efp/N8SowM8twmog/JoQbv62Qr24Gmgj/LX9k3M48B
         N5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L86jfhQydnQXL6CamLYct86bySYxzVKAkcuD/e27KRQ=;
        b=sT1YA4deVKds66K0yooHuqgo8jSwI50lzbkOXuyfhZb+WRSx/kaOaeGJCTGiHD+hqz
         MnnAK4/tQL7DAJozzdqn52GBiYiI/I8lTBI9cLFCKOFP6tbRpRmlAzs0mmTGzsHc5fHx
         yY6mH/HFZ9D2wVZf1281rfsOOun2U3Eo42bn+9TcXwOfyYzU8PeP9xK+lv6lgjz8On4D
         wXRkNMWODxaa8osGcR4JILuSD6EqgJqEmpxXXnb6ETeuhUvPT8D6/E7kfegB141Bg63s
         /qOE66FmBF/FbRS1D2jBug8oZjDtDIRyS1b1paA7/06qrm7/1GyLdvdVZ5A0EPgIcKBb
         QnOQ==
X-Gm-Message-State: AOAM531sYoirT2BzaQukXl2wASmuNW9pZLtngBCKsHMF7y9eitkRho+U
        h8YmkY7K4B/pEBb58Vg8u0XVchUUx/BPXg==
X-Google-Smtp-Source: ABdhPJz2TXX8k/Y6k9WtYGdCPIeNQCnoE0BPOHAaJTGJoCgfPMW6df4b0jc7OpWR0nUTDEPM26RStVbtUvAoAQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a10:bb1b:63e:864a])
 (user=dlatypov job=sendgmr) by 2002:a25:348b:: with SMTP id
 b133mr1160287yba.251.1639511531784; Tue, 14 Dec 2021 11:52:11 -0800 (PST)
Date:   Tue, 14 Dec 2021 11:52:03 -0800
Message-Id: <20211214195203.174080-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] kunit: tool: fix newly introduced typechecker errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After upgrading mypy and pytype from pip, we see 2 new errors when
running ./tools/testing/kunit/run_checks.py.

Error #1: mypy and pytype
They now deduce that importlib.util.spec_from_file_location() can return
None and note that we're not checking for this.

We validate that the arch is valid (i.e. the file exists) beforehand.
Add in an `asssert spec is not None` to appease the checkers.

Error #2: pytype bug https://github.com/google/pytype/issues/1057
It doesn't like `from datetime import datetime`, specifically that a
type shares a name with a module.

We can workaround this by either
* renaming the import or just using `import datetime`
* passing the new `--fix-module-collisions` flag to pytype.

We pick the first option for now because
* the flag is quite new, only in the 2021.11.29 release.
* I'd prefer if people can just run `pytype <file>`

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 1 +
 tools/testing/kunit/kunit_parser.py | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 12085e04a80c..44bbe54f25f1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -209,6 +209,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	# exists as a file.
 	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
 	spec = importlib.util.spec_from_file_location(module_path, config_path)
+	assert spec is not None
 	config = importlib.util.module_from_spec(spec)
 	# See https://github.com/python/typeshed/pull/2626 for context.
 	assert isinstance(spec.loader, importlib.abc.Loader)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8e42b6ef3fe3..0850cb4bce89 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -13,7 +13,7 @@ from __future__ import annotations
 import re
 
 from collections import namedtuple
-from datetime import datetime
+import datetime
 from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
@@ -520,7 +520,7 @@ ANSI_LEN = len(red(''))
 
 def print_with_timestamp(message: str) -> None:
 	"""Prints message with timestamp at beginning."""
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+	print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
 
 def format_test_divider(message: str, len_message: int) -> str:
 	"""

base-commit: 7fa7ffcf9babaea2f0a81681b4ef460ee4b93278
-- 
2.34.1.173.g76aa8bc2d0-goog

