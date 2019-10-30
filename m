Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17649EA45F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfJ3Tpk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:45:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43523 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3Tpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:45:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so2309677pfb.10
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ecEFNwt5xPuwITAtTejJ0X5tM716GMmwbwC2dfiZh24=;
        b=MIrjMvo4u9InYKJTysSQ4H4hlW9oSNtKSJwWcuUnG9O9ydVw8+wCy5EE2iqN1qMLjw
         i/gGPcGSIbtJyjZgCtunv3Hsb3iUHehe4sUcxpdqDvWh1ZM6ahgyGMrxgneayUZjNozx
         JI0Ahle/4EVd+ySOdvsXBKMrJlJn5VnKsriPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ecEFNwt5xPuwITAtTejJ0X5tM716GMmwbwC2dfiZh24=;
        b=nlY47W9adVBNT1mpBcJtmTVLiQBoBck98/+qu7UpGMcnZXoeD99vZuehBTGuQv21E0
         PCYdvpSu4OkYpqothG7TdRAexLEppBIXQfgDF0ikWutiXVeWNszNfm7do7MuXyyQzHbZ
         HRrrPSATC3vXD5urpuUBnwXstgfV0TQm2szKx6dheP2+d6pvVPswe8ibXm2O6wiZLG+g
         sIigrQyypot1zNQQ0OsHBWpUb8cBtgjXT3l+BvMZuVmBnSn9XMnYMb5nml/OwsbK5daR
         IgkHTsH12Ii3OO/+P/t8u0HGWJ3YqLYEaGQF5BRgSa8NEdd73nldyKU5CmapWiZ1b6DL
         BqXQ==
X-Gm-Message-State: APjAAAXYi3aDw1KxsRYCskHj7MTsaR8OIzYtCTrbsNSOCVjmuJDAT+eB
        XuorOQNPE1ZxCXihvt8439CsXw==
X-Google-Smtp-Source: APXvYqwQwIOOAwbO7wqCPgQ0DuL1rXe7sUOljeIAB+l6bc7EcLz2bFf7Vk0k9/6ldUGgPBK3Reb65g==
X-Received: by 2002:a17:90a:8a0a:: with SMTP id w10mr1230293pjn.68.1572464738493;
        Wed, 30 Oct 2019 12:45:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14sm783122pfh.36.2019.10.30.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:45:37 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:45:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Move kselftest_module.sh into kselftest/
Message-ID: <201910301244.9C3CABCA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kselftest_module.sh file was not being installed by the Makefile
"install" target, rendering the lib/*.sh tests nonfunction. This fixes
that and takes the opportunity to move it into the kselftest/ subdirectory
which is where the kselftest infrastructure bits are collecting.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/lkml/CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com
Fixes: d3460527706e ("kselftest: Add test runner creation script")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile                                | 1 +
 .../selftests/{kselftest_module.sh => kselftest/module.sh}      | 0
 tools/testing/selftests/lib/bitmap.sh                           | 2 +-
 tools/testing/selftests/lib/prime_numbers.sh                    | 2 +-
 tools/testing/selftests/lib/printf.sh                           | 2 +-
 tools/testing/selftests/lib/strscpy.sh                          | 2 +-
 6 files changed, 5 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/{kselftest_module.sh => kselftest/module.sh} (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d65f59669f7c..9ff31ec4277a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -193,6 +193,7 @@ install: all
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
 	mkdir -p $(INSTALL_PATH)/kselftest
+	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest/module.sh
similarity index 100%
rename from tools/testing/selftests/kselftest_module.sh
rename to tools/testing/selftests/kselftest/module.sh
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index 5511dddc5c2d..00a416fbc0ef 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,3 +1,3 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-$(dirname $0)/../kselftest_module.sh "bitmap" test_bitmap
+$(dirname $0)/../kselftest/module.sh "bitmap" test_bitmap
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 43b28f24e453..370b79a9cb2e 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
-$(dirname $0)/../kselftest_module.sh "prime numbers" prime_numbers selftest=65536
+$(dirname $0)/../kselftest/module.sh "prime numbers" prime_numbers selftest=65536
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 2ffa61da0296..05f4544e87f9 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Tests the printf infrastructure using test_printf kernel module.
-$(dirname $0)/../kselftest_module.sh "printf" test_printf
+$(dirname $0)/../kselftest/module.sh "printf" test_printf
diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
index 71f2be6afba6..be60ef6e1a7f 100755
--- a/tools/testing/selftests/lib/strscpy.sh
+++ b/tools/testing/selftests/lib/strscpy.sh
@@ -1,3 +1,3 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
-$(dirname $0)/../kselftest_module.sh "strscpy*" test_strscpy
+$(dirname $0)/../kselftest/module.sh "strscpy*" test_strscpy
-- 
2.17.1


-- 
Kees Cook
