Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3B492E2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 20:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbiARTJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 14:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348623AbiARTJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 14:09:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE4FC06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 191-20020a2504c8000000b006135c8d0c88so585344ybe.13
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F24wPCt234v4QNUD2Mk9oIJLO93NyHqVoUDE9Wq7Wr4=;
        b=XTL6t+Oh6LYMIGU4nlCiP7CMITJeohBPQAn/P6hY1sKrkqjrLGeY6gTx2C7MujoZ84
         H9QLQC+gLKdeeD/TnAQnnFxqz6xGUun0O4RgkGnvT2wlflyf755CUWHGi0iS37koMsrg
         xXCkdaG3nYt6ueYDSckmfx/59CemPoZHAcwxK+VDEcyyoS37GUIY1qnGC8+KYpHwiAVC
         qX8wQWCiCGC+DF/q9DtmjtoYkjoV8bf5M4Opa7RGJxy+cHxUYX+JPYP3sUqEeQADK2lo
         UvQt1hVr9CkUJEsHgCLC9O0XFn8GNRI6FrvsRCmCAX6gXmdAr1QTd1s1NXvU3JCX3eU5
         QZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F24wPCt234v4QNUD2Mk9oIJLO93NyHqVoUDE9Wq7Wr4=;
        b=2Nqchu2g4XoJPCsblJcj4AYXFCuqWA9mXZBuAM+PwVs3ulMHWTcp9S3jf+7ykvIHLT
         EA62BiWTo9cVi29PH1WS6wOusHX5jjO+4mIY7Kp7to9WphShLOj6Fk8vIrUFEZjxoB3d
         MlkPR8l1XMBZp5k+RQwPmTTjAqSttQrKUSnA33e3kiTBZtMvwVlBlSiSuZgc3QRTHKtj
         1tKWn8Th7GROv6D/39SyNXazIeb5Q8KcbNeUFQ77zt+YSKEAHB1ifXafCYHy3haMFI8A
         840Cbq0d5d8LjQqA1V0G76hkVrbr3Bk7ecTdKXzx6GpXGdQwo1gp8v4QEUwbOfZPHQJS
         UsGg==
X-Gm-Message-State: AOAM531kfaMu2Er6zxtdYGN3AMf4NKF+/wm9mlSxW/XuJhd9q1zQFFP5
        HYEh5unSeTKO/gZzMcbFmLSaBdOSCz95rw==
X-Google-Smtp-Source: ABdhPJwwWracSLEr3Ecw1tn00jf8OsaRYT0dJuDGecTg5kuRfAblZGyNp3ohYxtbXZAfZzSaWs6J2ZlGs+6rFQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a5b:c01:: with SMTP id
 f1mr31692742ybq.593.1642532977230; Tue, 18 Jan 2022 11:09:37 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:09:21 -0800
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
Message-Id: <20220118190922.1557074-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 4/5] kunit: tool: drop last uses of collections.namedtuple
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we formally require python3.7+ since commit df4b0807ca1a
("kunit: tool: Assert the version requirement"), we can just use
@dataclasses.dataclass instead.

In kunit_config.py, we used namedtuple to create a hashable type that
had `name` and `value` fields and had to subclass it to define a custom
`__str__()`.
@datalcass lets us just define one type instead.

In qemu_config.py, we use namedtuple to allow modules to define various
parameters. Using @dataclass, we can add type-annotations for all these
fields, making our code more typesafe and making it easier for users to
figure out how to define new configs.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_config.py |  9 +++++----
 tools/testing/kunit/qemu_config.py  | 17 ++++++++++-------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 677354546156..ca33e4b7bcc5 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -6,16 +6,17 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-import collections
+from dataclasses import dataclass
 import re
 from typing import List, Set
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
-KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
-
-class KconfigEntry(KconfigEntryBase):
+@dataclass(frozen=True)
+class KconfigEntry:
+	name: str
+	value: str
 
 	def __str__(self) -> str:
 		if self.value == 'n':
diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
index 1672f6184e95..0b6a80398ccc 100644
--- a/tools/testing/kunit/qemu_config.py
+++ b/tools/testing/kunit/qemu_config.py
@@ -5,12 +5,15 @@
 # Copyright (C) 2021, Google LLC.
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-from collections import namedtuple
+from dataclasses import dataclass
+from typing import List
 
 
-QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
-					       'kconfig',
-					       'qemu_arch',
-					       'kernel_path',
-					       'kernel_command_line',
-					       'extra_qemu_params'])
+@dataclass(frozen=True)
+class QemuArchParams:
+  linux_arch: str
+  kconfig: str
+  qemu_arch: str
+  kernel_path: str
+  kernel_command_line: str
+  extra_qemu_params: List[str]
-- 
2.34.1.703.g22d0c6ccf7-goog

