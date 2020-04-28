Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2E1BBDB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD1Mix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726361AbgD1Miw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 08:38:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D15C03C1A9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 05:38:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so2577124wmc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOMqC+ChmjG1hOQvFzfugQDf6EqBDj2J7aBYHiMkkmo=;
        b=HDCLLdPR0t1hqa8N4GTYksD1oiI/2VjJ0Ti87hZP0Yfc+pbh6IWmioqu+jQgkBV8gj
         mvzDrybUImmmZpXZjOYeAHj3GYh7IVoJ4xeOAca0IXSi0TYxv+uPhE04jqRPbhGLiNA6
         2jBiSfgssvBJQmJwN/ffBL1o4Z28y2bIT9WrFmCwsigfKEulsn03ZUJvleUyouJFhBla
         uRLtwiIRKxlif9EeFExO7Du3ykyrywFX12E5JGPlZsEmIBkhcCRQthxyB6Hdqbj6nZSP
         Y0R59sQDC508HdTeHRk+z/b5Jj0QhDfGA7CpJ4ZZ4ByW6K8OG8wBbCGWmXVOqEb1n8K5
         aNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOMqC+ChmjG1hOQvFzfugQDf6EqBDj2J7aBYHiMkkmo=;
        b=eytBsQd8rl4iY8OTefEu+DUo4UoUVRr6LcQyHz97xS7wn+LT15bFPcFaL1CVy0lffg
         BvO6bv6lSB7qVIKhPNYASdlzTNpE9JkzHP2Ti5lCN08xVOBA8B31RKWKFJG4+oeXYHpD
         avt8Et0ZIkrBWIEB/N8A2MX0NTWsKX/MuM2PjPnX0wLZb7lrqG9K0fjWiadeGJrJpGrl
         C+vQWBb+J1uL7zR2OaDmNYlosBVHxtMJLCeGtPbxWlEaNgAWJM7XWyRa5TFtYsTFyOnh
         QaJe7lDBRph5pBvQKv76+0oCQ1/M/KtbELM/faP9AH6h49qIg+1cC3fJd7jXAJV+gISA
         iPjA==
X-Gm-Message-State: AGi0PualKezJwT1oDg1W/dm+nYOgKgJR8pUhvb/SpYG4ZBIj+Ae+/POB
        tUn5bWncrVBHgSKhSUEzG1I=
X-Google-Smtp-Source: APiQypK8vuaxdForD/GcrcImU+cZn2hQZNlN7gxYz/2CsGa0JJ8vMn8hwK3jWIvT/Przg6xH/Dj3Dg==
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr4912466wmd.16.1588077529931;
        Tue, 28 Apr 2020 05:38:49 -0700 (PDT)
Received: from steamlocomotive (176-74-128-122.netdatacomm.cz. [176.74.128.122])
        by smtp.gmail.com with ESMTPSA id m1sm24641444wro.64.2020.04.28.05.38.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 28 Apr 2020 05:38:49 -0700 (PDT)
From:   Veronika Kabatova <veronicca114@gmail.com>
X-Google-Original-From: Veronika Kabatova <vkabatov@redhat.com>
To:     shuah@kernel.org
Cc:     sbrivio@redhat.com, linux-kselftest@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH] selftests: introduce gen_tar Makefile target
Date:   Tue, 28 Apr 2020 14:38:41 +0200
Message-Id: <20200428123841.2953099-1-vkabatov@redhat.com>
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

