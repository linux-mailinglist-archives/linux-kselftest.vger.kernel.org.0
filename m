Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A63B6BC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jun 2021 02:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhF2Alo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 20:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhF2Alo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 20:41:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78C9C061760
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 17:39:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l16-20020a25cc100000b0290558245b7eabso6587610ybf.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 17:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ErXbW4kB5vis3JG9x6sbxAOmYtyXBZy8W86kw16tbmI=;
        b=WgX7wxhJwSBDTQCu8F9t7asAkjuBaVwiPI/jD8di+K0yMvaaDWERtQT5L1HmRyKtBc
         2BffaNKaGsLLDeFPPIHVosSOuKtkPWmBwjwF7OfvkTgTx/k59VXsrocZMfPVSRl4ZvhU
         w462kyqNSYAGlkOasKgJwp7IHLG+YgACgys7aQQfElBEkZeIrni7ToVmgVxR/VjlO0NU
         CJYGHIL3E+yLSG/MiH7BMDjEsERKlzHKaVCLJjzYC741muqyTrxq6++kluHP640hlxAs
         t/926NdnqaBQ2rfxgYf11+J7q4aneBilbasuxhj70QlqwcAij19PeiFRSwRe+J0HsC+C
         6rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ErXbW4kB5vis3JG9x6sbxAOmYtyXBZy8W86kw16tbmI=;
        b=r8WPRiyxjiwd3cT1dZmtmqZZnMEP5olbR+N4DDin1c60S+Q6RROBo/S4Wk7vtuQLoq
         4I5GJAAeYoIXvEsjkEObZXzjufxUEuV7knMub8mGMolzMLxwVE1Zxne8ahpA6HYQEtQV
         kRfnqlBJUxwM53yeTe86PXDggLYtY+1j2P27NImZOobgA1g5osM/2vXmDqwljBhbksEN
         qyzNzlIYAlYuqEOvPbRiMNex0CG0jqX4hew1wVfWKN8qvUVUNsD/V62UQxtc5t0WDVDC
         2iOvUXUDaSHfiB8dLTR8WtI6nOD957lDGtjzNbrJvU0PnFugsVpOKosBoQGOvynsVoyj
         MKLg==
X-Gm-Message-State: AOAM533l+yTgwzUqKBKadk2t9L0maMDBLfjNK4mk+WlLG4E/2OAWuaoT
        63Ua2UoM9lgiuodA0Vkdz+DO7l9kJ/Akzw==
X-Google-Smtp-Source: ABdhPJxr2X2R0XQhfO9qiqp9FUNGr7U3VdSeJ1hPG6jj4F+OJ+ZqAG168XWd7aeb2P78V1lW+8CcLSDcc3d0vQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a805:ee32:b96e:716e])
 (user=dlatypov job=sendgmr) by 2002:a25:1455:: with SMTP id
 82mr34670239ybu.403.1624927156815; Mon, 28 Jun 2021 17:39:16 -0700 (PDT)
Date:   Mon, 28 Jun 2021 17:39:08 -0700
Message-Id: <20210629003908.1848782-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] kunit: tool: remove unnecessary "annotations" import
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The import was working around the fact "tuple[T]" was used instead of
typing.Tuple[T].

Convert it to use typing.Tuple to be consistent with how the rest of the
code is annotated.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: fix typos in commit message.
---
 tools/testing/kunit/kunit_kernel.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 90bc007f1f93..2c6f916ccbaf 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,15 +6,13 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-from __future__ import annotations
 import importlib.util
 import logging
 import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator
-from typing import Optional
+from typing import Iterator, Optional, Tuple
 
 from contextlib import ExitStack
 
@@ -208,7 +206,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		raise ConfigError(arch + ' is not a valid arch')
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
-					 cross_compile: Optional[str]) -> tuple[
+					 cross_compile: Optional[str]) -> Tuple[
 							 str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it

base-commit: 1d71307a6f94df3750f8f884545a769e227172fe
-- 
2.32.0.93.g670b81a890-goog

