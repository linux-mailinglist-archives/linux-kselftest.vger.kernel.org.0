Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3D1DA1F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESUBR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 16:01:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728747AbgESUBP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 16:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589918474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lobCprb1Uzups2pNSKNnU1k/tJEdIn3hBgloHgGOEt0=;
        b=VcRiC6yUqFyIKu9+yi0x1CEPN9NBvuzcuAglLIcXteWqIDUe0FVkX7cuP4fI1XRt+E+glY
        XKQjptzC+KcegHQQWKoD7uhYC96l3VtYd+JZcK5TN86ExID9UTPbZ08NujXXvQXbZcmF74
        Q5IWpryzrmhlZm+waDzq3CihtAmKY6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-MdULUFXMNpKc-7G5IWsOPA-1; Tue, 19 May 2020 16:00:59 -0400
X-MC-Unique: MdULUFXMNpKc-7G5IWsOPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57850EC1A0;
        Tue, 19 May 2020 20:00:58 +0000 (UTC)
Received: from steamlocomotive.redhat.com (unknown [10.40.196.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCE426E716;
        Tue, 19 May 2020 20:00:56 +0000 (UTC)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     sbrivio@redhat.com, Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH v2] selftests: introduce gen_tar Makefile target
Date:   Tue, 19 May 2020 22:00:45 +0200
Message-Id: <20200519200045.317516-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
---
v2: overriden -> overridden, sent from the matching email address

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
+default, `.gz` format is used. The tar format can be overridden by specifying
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

