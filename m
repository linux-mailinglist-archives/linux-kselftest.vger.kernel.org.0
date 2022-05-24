Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED02053242E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiEXHge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 03:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiEXHgc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A1EE4D273
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653377789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9L11SjTsj62SbwNjoc/BXEoQMgxev81E9+gPbEhuK8=;
        b=d5Z/UNxW0aw0CEu/XGBFd1/XOuxm+HghQH//fnQOoU07xseIO6ow791R0lMhGheld87uUg
        mlbAKOYHYQw02oNsfC7ib2rZf5rRIqcOLsvm9UD7JB3NcNxWmkmLxbBnYB0MgTM3U6j72W
        Y1h2kzy5YksAwWbrXvwvnYskTqaV5OM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-BXDzX2WqMTq0b9qfjGAeBg-1; Tue, 24 May 2022 03:36:28 -0400
X-MC-Unique: BXDzX2WqMTq0b9qfjGAeBg-1
Received: by mail-wm1-f69.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso908009wme.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 00:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9L11SjTsj62SbwNjoc/BXEoQMgxev81E9+gPbEhuK8=;
        b=QG5152Bgas+D0EtaAXgin3HTVfPpVFSz7pAVtQ6ER+Z5OqgBqpTNJXDBaXgGt4gWPA
         vUdTUptCna5fSJ6TDDHroM/Js3KPlQdRKxCokZzKPSxMg6VB9UiRaW7O12OFSDhPn/06
         zJoVE1BUbwLL5bBKTRI9R8i+DapOnc7w5Mah7n+HTw0Og87KvVZmRGM/QoWyBEUEoypP
         F1zxmFP5RQxlAWFTc3+WlEqJj/6OJjs79urPQaX3iq7/U6BmTmXqxvXK7SokRG2Sia44
         fNHYN8txCv8NwnOry/Dj8qhO1adSdu0mI7mrjiwiagqGDC8a8a48vRHmGrbinqj7zvcN
         b1ZA==
X-Gm-Message-State: AOAM530vG3hFocF73++GMupshOppbRjop4QkfPdwFXrYbSzN0gtCkLSV
        h3ol7TrKFnqT5I2l3Prv5E4ftsiYz6qW2ZZYNqutulylSFCR69SVqtxbbG4caCUTDevYD8Gyj0W
        HctKIYrdp8bdelHiV8Jj2DzCEFWtv
X-Received: by 2002:a7b:cd95:0:b0:397:3c5e:9639 with SMTP id y21-20020a7bcd95000000b003973c5e9639mr2486009wmj.12.1653377786910;
        Tue, 24 May 2022 00:36:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLdafaAxTC7fiyyLNOo5Eud6DnInNC5/4SszhjaKLVsKC0JaDcFNsdPy3iOf0SgAltaEI6bg==
X-Received: by 2002:a7b:cd95:0:b0:397:3c5e:9639 with SMTP id y21-20020a7bcd95000000b003973c5e9639mr2485991wmj.12.1653377786670;
        Tue, 24 May 2022 00:36:26 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f2-20020adfc982000000b0020c5253d927sm12202174wrh.115.2022.05.24.00.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:36:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE test
Date:   Tue, 24 May 2022 09:36:04 +0200
Message-Id: <20220524073604.247790-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524073604.247790-1-javierm@redhat.com>
References: <20220524073604.247790-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test for the renameat2 RENAME_EXCHANGE support in vfat, but split it
in a tool that just does the rename exchange and a script that is run by
the kselftests framework on `make TARGETS="filesystems/fat" kselftest`.

That way the script can be easily extended to test other file operations.

The script creates a 1 MiB disk image, that is then formated with a vfat
filesystem and mounted using a loop device. That way all file operations
are done on an ephemeral filesystem.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Call sync to flush the page cache before checking the file contents
  (Alex Larsson).

 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 .../selftests/filesystems/fat/Makefile        |  7 ++
 .../testing/selftests/filesystems/fat/config  |  2 +
 .../filesystems/fat/rename_exchange.c         | 37 +++++++++
 .../filesystems/fat/run_fat_tests.sh          | 82 +++++++++++++++++++
 6 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fdbbd6c1984..158771bb7755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20841,6 +20841,7 @@ M:	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
 S:	Maintained
 F:	Documentation/filesystems/vfat.rst
 F:	fs/fat/
+F:	tools/testing/selftests/filesystems/fat/
 
 VFIO DRIVER
 M:	Alex Williamson <alex.williamson@redhat.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 0aedcd76cf0f..fc59ad849a90 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -16,6 +16,7 @@ TARGETS += exec
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
+TARGETS += filesystems/fat
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
new file mode 100644
index 000000000000..93ee73c16828
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_fat_tests.sh
+TEST_GEN_PROGS_EXTENDED := rename_exchange
+CFLAGS += -O2 -g -Wall -I../../../../usr/include/
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fat/config b/tools/testing/selftests/filesystems/fat/config
new file mode 100644
index 000000000000..6cf95e787a17
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/config
@@ -0,0 +1,2 @@
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_VFAT_FS=y
diff --git a/tools/testing/selftests/filesystems/fat/rename_exchange.c b/tools/testing/selftests/filesystems/fat/rename_exchange.c
new file mode 100644
index 000000000000..e488ad354fce
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/rename_exchange.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Program that atomically exchanges two paths using
+ * the renameat2() system call RENAME_EXCHANGE flag.
+ *
+ * Copyright 2022 Red Hat Inc.
+ * Author: Javier Martinez Canillas <javierm@redhat.com>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+void print_usage(const char *program)
+{
+	printf("Usage: %s [oldpath] [newpath]\n", program);
+	printf("Atomically exchange oldpath and newpath\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	if (argc != 3) {
+		print_usage(argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = renameat2(AT_FDCWD, argv[1], AT_FDCWD, argv[2], RENAME_EXCHANGE);
+	if (ret) {
+		perror("rename exchange failed");
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
new file mode 100755
index 000000000000..7f35dc3d15df
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run filesystem operations tests on an 1 MiB disk image that is formatted with
+# a vfat filesystem and mounted in a temporary directory using a loop device.
+#
+# Copyright 2022 Red Hat Inc.
+# Author: Javier Martinez Canillas <javierm@redhat.com>
+
+set -e
+set -u
+set -o pipefail
+
+BASE_DIR="$(dirname $0)"
+TMP_DIR="$(mktemp -d /tmp/fat_tests_tmp.XXXX)"
+IMG_PATH="${TMP_DIR}/fat.img"
+MNT_PATH="${TMP_DIR}/mnt"
+
+cleanup()
+{
+    mountpoint -q "${MNT_PATH}" && unmount_image
+    rm -rf "${TMP_DIR}"
+}
+trap cleanup SIGINT SIGTERM EXIT
+
+create_loopback()
+{
+    touch "${IMG_PATH}"
+    chattr +C "${IMG_PATH}" >/dev/null 2>&1 || true
+
+    truncate -s 1M "${IMG_PATH}"
+    mkfs.vfat "${IMG_PATH}" >/dev/null 2>&1
+}
+
+mount_image()
+{
+    mkdir -p "${MNT_PATH}"
+    sudo mount -o loop "${IMG_PATH}" "${MNT_PATH}"
+}
+
+rename_exchange_test()
+{
+    local rename_exchange="${BASE_DIR}/rename_exchange"
+    local old_path="${MNT_PATH}/old_file"
+    local new_path="${MNT_PATH}/new_file"
+
+    echo old | sudo tee "${old_path}" >/dev/null 2>&1
+    echo new | sudo tee "${new_path}" >/dev/null 2>&1
+    sudo "${rename_exchange}" "${old_path}" "${new_path}" >/dev/null 2>&1
+    sudo sync -f "${MNT_PATH}"
+    grep new "${old_path}" >/dev/null 2>&1
+    grep old "${new_path}" >/dev/null 2>&1
+}
+
+rename_exchange_subdir_test()
+{
+    local rename_exchange="${BASE_DIR}/rename_exchange"
+    local dir_path="${MNT_PATH}/subdir"
+    local old_path="${MNT_PATH}/old_file"
+    local new_path="${dir_path}/new_file"
+
+    sudo mkdir -p "${dir_path}"
+    echo old | sudo tee "${old_path}" >/dev/null 2>&1
+    echo new | sudo tee "${new_path}" >/dev/null 2>&1
+    sudo "${rename_exchange}" "${old_path}" "${new_path}" >/dev/null 2>&1
+    sudo sync -f "${MNT_PATH}"
+    grep new "${old_path}" >/dev/null 2>&1
+    grep old "${new_path}" >/dev/null 2>&1
+}
+
+unmount_image()
+{
+    sudo umount "${MNT_PATH}" &> /dev/null
+}
+
+create_loopback
+mount_image
+rename_exchange_test
+rename_exchange_subdir_test
+unmount_image
+
+exit 0
-- 
2.36.1

