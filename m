Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA81BBDB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgD1Mix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726361AbgD1Mix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 08:38:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B01C03C1A9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 05:38:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u127so2688447wmg.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOMqC+ChmjG1hOQvFzfugQDf6EqBDj2J7aBYHiMkkmo=;
        b=kJIUJa6pbhwzCB+6c2VikaUgtRuuCk4570aKggWOQUDSAbdKYcYMVnVxngNDzAaugC
         YTMDAMQUAI1tCGrADk1EqIULr826+DT8M3zf5X2gWuToTNjBz/Cb2eeizx8833yHutPa
         6Bouvuh7cSqmuDwDSrfp4t5boNm8A1KnhOco0WbP9MUFgoojtcosot4DNqoVX2vClAO6
         Srv0qDl0mFpOU8+ShIQ6qjQUGKzvkc2/d161BQGX50rYLTePm2SsbkEIc+ceXFJfyPuu
         JYRk+14Mv5DDTbgfvGoN5DsiR4Q0d32YrndjM5DrIYDHp8JUDJvNHxt5C9tdgUwZS3B6
         WRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOMqC+ChmjG1hOQvFzfugQDf6EqBDj2J7aBYHiMkkmo=;
        b=nD9kaYtUe6wb8H4ydNnadBf/uH8X8gWx+/kwz2oMjkKsPrsGeIOMNozqW+4Kr9pgzP
         GPzRao7ox9Y/g7DHBAuPOXgCMQJ30a1AwWtG1+A0U2GVtGwDfW6a2/DY9HyXN2GUuyoM
         xMuTGNtYQ+MH8VRX9ui0OlQnel3wtEbfNyiTr+W4hUUznjK4Pr/YGMqJtx1Dee7Ux05w
         FfP1xrvIBP2D0n2X1A/zEOIRGypNdaTQtS/EqTKSxNz+OxvDTP5Y4cVoYwsBBbyt5Lvj
         dDTO4+ELcVXpwtYC4HhYRGz1Lr6TUi0v6Q+CC8nE219pnioYTYdTCAKpusep5CAKhrez
         cH2g==
X-Gm-Message-State: AGi0Pubnkw3Ic5MAAehnTYacbj06fGJTf1Kj2T+ie3z06uFFWuHKVpiO
        xtUDKvIYKxla1xdvbU6e/JI=
X-Google-Smtp-Source: APiQypLqTkk9WhiHQ6mGCdNs7A9Pc7BdvO6VSqEUFRvsaObPUO39cUJdPFkGoUfeOBALKI9E1cyNCg==
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr4291690wmi.78.1588077531732;
        Tue, 28 Apr 2020 05:38:51 -0700 (PDT)
Received: from steamlocomotive (176-74-128-122.netdatacomm.cz. [176.74.128.122])
        by smtp.gmail.com with ESMTPSA id k3sm28091677wru.90.2020.04.28.05.38.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 28 Apr 2020 05:38:51 -0700 (PDT)
From:   Veronika Kabatova <veronicca114@gmail.com>
X-Google-Original-From: Veronika Kabatova <vkabatov@redhat.com>
To:     shuah@kernel.org
Cc:     sbrivio@redhat.com, linux-kselftest@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH] selftests: introduce gen_tar Makefile target
Date:   Tue, 28 Apr 2020 14:34:48 +0200
Message-Id: <20200428123448.2950976-1-vkabatov@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The gen_kselftest_tar.sh always packages *all* selftests and doesn't
pass along any variables to `make install` to influence what should be
built. This can result in an early error on the command line ("Unknown
tarball format TARGETS=XXX"), or unexpected test failures as the
tarball contains tests people wanted to skip on purpose.

Since the makefile already contains all the logic, we can add a target
for packaging. Keep the default .gz target the script uses, and actually
extend the supported formats by using tar's autodetection.

To not break current workflows, keep the gen_kselftest_tar.sh script as
it is, with an added suggestion to use the makefile target instead.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
---
 Documentation/dev-tools/kselftest.rst        | 23 ++++++++++++++++++++
 tools/testing/selftests/Makefile             |  9 +++++++-
 tools/testing/selftests/gen_kselftest_tar.sh |  5 +++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 61ae13c44f91..3fc559bcb597 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,29 @@ note some tests will require root privileges::
    $ cd kselftest
    $ ./run_kselftest.sh
 
+Packaging selftests
+===================
+
+In some cases packaging is desired, such as when tests need to run on a
+different system. To package selftests, run::
+
+   $ make -C tools/testing/selftests gen_tar
+
+This generates a tarball in the `INSTALL_PATH/kselftest-packages` directory. By
+default, `.gz` format is used. The tar format can be overriden by specifying
+a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_ option
+is supported, such as::
+
+    $ make -C tools/testing/selftests gen_tar FORMAT=.xz
+
+`make gen_tar` invokes `make install` so you can use it to package a subset of
+tests by using variables specified in `Running a subset of selftests`_
+section::
+
+    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
+
+.. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
+
 Contributing new tests
 ======================
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2ff68702fd41..1195bd85af38 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -249,10 +249,17 @@ else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
+FORMAT ?= .gz
+TAR_PATH = $(abspath ${INSTALL_PATH}/kselftest-packages/kselftest.tar${FORMAT})
+gen_tar: install
+	@mkdir -p ${INSTALL_PATH}/kselftest-packages/
+	@tar caf ${TAR_PATH} --exclude=kselftest-packages -C ${INSTALL_PATH} .
+	@echo "Created ${TAR_PATH}"
+
 clean:
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
+.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing/selftests/gen_kselftest_tar.sh
index 8b2b6088540d..4a974bc03385 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -49,6 +49,11 @@ main()
 	# directory
 	./kselftest_install.sh "$install_dir"
 	(cd "$install_work"; tar $copts "$dest"/kselftest${ext} $install_name)
+
+	# Don't put the message at the actual end as people may be parsing the
+	# "archive created" line in their scripts.
+	echo -e "\nConsider using 'make gen_tar' instead of this script\n"
+
 	echo "Kselftest archive kselftest${ext} created!"
 
 	# clean up top-level install work directory
-- 
2.25.1

