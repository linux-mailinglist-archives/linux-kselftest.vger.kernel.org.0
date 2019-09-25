Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432D8BE8C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfIYXFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 19:05:19 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:34435 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbfIYXFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 19:05:10 -0400
Received: by mail-io1-f49.google.com with SMTP id q1so1430122ion.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2019 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YMz9ksrdQ7cPPABsA09urm67yr9R6IZjmvoUPzxwJQ=;
        b=iXN5gYJ5HULpGN4jiBNeGuKrRsjjPCDh0f9k1OxW4Nd2WYGpXycEP3lfZM7IOa5V7u
         zt9TqVjh2B9U+yS6H3EZEzn/YQrfGuLWwf5fAhfYC+MY1xW744IuTr1tyfLVi9r881CN
         Mv+6lnH86+wahkV4TiXZQFpSCgltvSkdS2irA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YMz9ksrdQ7cPPABsA09urm67yr9R6IZjmvoUPzxwJQ=;
        b=diQfRh8/ZQuSDsnqTLHcC+nZYc4/EQRVqxHjobiYUxhcpwWr72r37cQ9BM9ALZBI+f
         gJoXdAqrpRGgSEojSET/swNItbrYGGcEAurtQfHsp1DDVILWulnPSx8g1+X7OX+ibzyV
         YWRqKO7B1DVVoz7mXD/5tJu/lfdIxMUil5C60n1VQkvs/lxp5OxZ/nMw5LE5/7faCZPZ
         Ms9oRctBVPCbVltu43LBRKQXxxhmqWWqYEAtMTTYEYEaaTWEQ+d06FQM9b61/THVInSP
         HP1t/+DRGh0vnqxdU3pPev5aFtCg3FRG+VbGxstwfN2hlXXSzmcZJUS05RnFtzyJaw39
         gmUg==
X-Gm-Message-State: APjAAAUBhzUTi5OQfDFWwhe7bAmeNgS6uG8RgaMZ2BKZqQIEW4Kvc0Cm
        NvEZWzegqEbytNf1BodgR4gsuw==
X-Google-Smtp-Source: APXvYqxI6iUzKkSoQdTbZKd/TguAGEr6qe3KDzCOI+oNx8oHTnXanpvdTBRS99Rbw71WZEkv3zpnmg==
X-Received: by 2002:a5d:9a16:: with SMTP id s22mr521750iol.79.1569452709196;
        Wed, 25 Sep 2019 16:05:09 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f23sm70767ioc.36.2019.09.25.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:05:08 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: Add kselftest_install target to main Makefile
Date:   Wed, 25 Sep 2019 17:04:35 -0600
Message-Id: <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1569452305.git.skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kselftest_install target to install tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

This change addresses requests from developers and testers to add
support for installing kselftest from the main Makefile.

In addition, make the install directory the same when install is
run using "make kselftest_install" or by running kselftest_install.sh.
Also fix the INSTALL_PATH variable conflict between main Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile                                     | 4 ++++
 tools/testing/selftests/Makefile             | 8 ++++++--
 tools/testing/selftests/kselftest_install.sh | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ac4af6fc4b50..65c62af6b6fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1241,6 +1241,10 @@ PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
+PHONY += kselftest_install
+kselftest_install:
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests install
+
 PHONY += kselftest-clean
 kselftest-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..bad18145ed1a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -171,9 +171,12 @@ run_pstore_crash:
 # 1. output_dir=kernel_src
 # 2. a separate output directory is specified using O= KBUILD_OUTPUT
 # 3. a separate output directory is specified using KBUILD_OUTPUT
+# Avoid conflict with INSTALL_PATH set by the main Makefile
 #
-INSTALL_PATH ?= $(BUILD)/install
-INSTALL_PATH := $(abspath $(INSTALL_PATH))
+KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
+KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
+# Avoid changing the rest of the logic here and lib.mk.
+INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 
 install: all
@@ -203,6 +206,7 @@ ifdef INSTALL_PATH
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
+		echo -n "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
index ec304463883c..e2e1911d62d5 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -24,12 +24,12 @@ main()
 		echo "$0: Installing in specified location - $install_loc ..."
 	fi
 
-	install_dir=$install_loc/kselftest
+	install_dir=$install_loc/kselftest_install
 
 # Create install directory
 	mkdir -p $install_dir
 # Build tests
-	INSTALL_PATH=$install_dir make install
+	KSFT_INSTALL_PATH=$install_dir make install
 }
 
 main "$@"
-- 
2.20.1

