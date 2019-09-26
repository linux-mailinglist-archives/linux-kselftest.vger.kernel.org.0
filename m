Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F16BFB5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfIZWkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 18:40:18 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:35870 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfIZWkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 18:40:18 -0400
Received: by mail-io1-f52.google.com with SMTP id b136so10932371iof.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRBrES6OXe6mAupynRdyMTCoPmyYs41wvldB7LkXBu4=;
        b=XCmr6puVVPyEobymUL0+RsE2FErfwLgMhiaP74snpgl4A64MMTQyo7Cx2pzlG+cNTd
         Jf/8eypsox0EwAIyZdYVklRt+WrBcomgxkkwrN4/dMGUNCmPpKKGGRrKsnZ5Bvnvs8xN
         ZV4zbHHR2cO4bMLzupuC3HFxaobP14yDlguy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRBrES6OXe6mAupynRdyMTCoPmyYs41wvldB7LkXBu4=;
        b=BsMykewyFqbc0GV2sx/fNDzkx94G3IR4tAUiHlLN44BLJwdpWW8EAEppcf7ycbgRvL
         fJNxoBLMqjK48/rjz1VM3s6WFTDBYS6EU+bwcGEhCyjdJxBByosClpDCplNo8k5cXNv9
         JzmAiJjKE2bckgBH5utXi5fDV51IejCzJCyZWDWmbCXsu1pfQTGDIRLYT4gwFxp+i/Qr
         gz77aOzO0kr3/vhISO6DyJLIGT3ChA0CBg93JwoFLBmTfceZFbJp0RKuk/1BYGE+0aFk
         mDLTIZQ5p1zx7AjSoqbp54FntabkHF0HTM2AX5/1ogds0vtO6M5tPnSaqTx3aWCI8dQ7
         dYCQ==
X-Gm-Message-State: APjAAAXFkdvMKKNvsNI8lDcZqyDIEvpBECcGfH10RhtcdoOX3pvGP9uz
        RJ3JURmsDYRB7P9AAH9/imkn6g==
X-Google-Smtp-Source: APXvYqyV8/rLOlYVMt0omstgu3VSz3zBvI5/Ju/jqPZtz3uWdB6tPAczH0I34DB8A1coHZRONv5DYg==
X-Received: by 2002:a02:a999:: with SMTP id q25mr5932710jam.27.1569537617222;
        Thu, 26 Sep 2019 15:40:17 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o16sm301303ilf.80.2019.09.26.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 15:40:16 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: Add kselftest-all and kselftest-install targets
Date:   Thu, 26 Sep 2019 16:40:14 -0600
Message-Id: <20190926224014.28910-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kselftest-all target to build tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

Current kselftest target builds and runs tests on a development
system which is a developer use-case.

Add kselftest-install target to install tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

This change addresses requests from developers and testers to add
support for installing kselftest from the main Makefile.

In addition, make the install directory the same when install is
run using "make kselftest-install" or by running kselftest_install.sh.
Also fix the INSTALL_PATH variable conflict between main Makefile and
selftests Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
- Collpased two patches that added separate targets to
  build and install into one patch using pattern rule to
  invoke all, install, and clean targets from main Makefile.

 Makefile                                     | 5 ++---
 tools/testing/selftests/Makefile             | 8 ++++++--
 tools/testing/selftests/kselftest_install.sh | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index d456746da347..ec296c60c1af 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,9 +1237,8 @@ PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-PHONY += kselftest-clean
-kselftest-clean:
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
+kselftest-%: FORCE
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
 kselftest-merge:
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

