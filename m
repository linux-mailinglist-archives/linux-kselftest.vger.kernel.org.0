Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0169B091
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBQQUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBQQUF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509971492
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMDV2EKl8tvcx5W+PSppav1j+1VABqtQOAoV76jWk4k=;
        b=NR0ZkMPRWUwtJLIctjqii7Abct7GcWu/blQZzG8usqojhfjFKLkD0dpvXgihN99OTeo0Sy
        QcJcjYy+apQOVyzQKva7J95pIjAEAxOnehGAQYTb1N1ll9XhTPFP9l0XVecS5YdRN2qwjp
        z6jtVtWUEBhFkoZbdO1TymOa1FYn410=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-M-AN_mGbPmigN4-vv5GaGQ-1; Fri, 17 Feb 2023 11:18:42 -0500
X-MC-Unique: M-AN_mGbPmigN4-vv5GaGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B49F0830F81;
        Fri, 17 Feb 2023 16:18:41 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87764C15BA0;
        Fri, 17 Feb 2023 16:18:40 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:17:55 +0100
Subject: [PATCH 01/11] selftests: hid: make vmtest rely on make
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-1-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=3140;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=UcWZqRNXA4+z94g+BQqS902c8ut3vW6xhsKsnErfSc8=;
 b=nhPWBKXiBqZfd7/ArnvuPWYoIu8p3HJUbFDngVQTJj3K8jK7tDjQXoI2HXYz9FwkLFEiYneAF
 baZA9UqZabODnN8t5DVQkLprp7RDyaX5U+M1QJ7fhHrWmF4jiyaLW9h
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Having a default binary is simple enough, but this also means that
we need to keep the targets in sync as we are adding them in the Makefile.

So instead of doing that manual work, make vmtest.sh generic enough to
actually be capable of running 'make -C tools/testing/selftests/hid'.

The new image we use has make installed, which the base fedora image
doesn't.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/vmtest.sh | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 90f34150f257..6346b0620dba 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -16,7 +16,6 @@ x86_64)
 	exit 1
 	;;
 esac
-DEFAULT_COMMAND="./hid_bpf"
 SCRIPT_DIR="$(dirname $(realpath $0))"
 OUTPUT_DIR="$SCRIPT_DIR/results"
 KCONFIG_REL_PATHS=("${SCRIPT_DIR}/config" "${SCRIPT_DIR}/config.common" "${SCRIPT_DIR}/config.${ARCH}")
@@ -25,7 +24,10 @@ NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"hid_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
-CONTAINER_IMAGE="registry.fedoraproject.org/fedora:36"
+CONTAINER_IMAGE="registry.freedesktop.org/libevdev/hid-tools/fedora/37:2023-02-17.1"
+
+TARGETS="${TARGETS:=$(basename ${SCRIPT_DIR})}"
+DEFAULT_COMMAND="make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"
 
 usage()
 {
@@ -33,9 +35,9 @@ usage()
 Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
-tools/testing/selftests/bpf. e.g:
+the source kernel direcory. e.g:
 
-	$0 -- ./hid_bpf
+	$0 -- ./tools/testing/selftests/hid/hid_bpf
 
 If no command is specified and a debug shell (-s) is not requested,
 "${DEFAULT_COMMAND}" will be run by default.
@@ -43,11 +45,11 @@ If no command is specified and a debug shell (-s) is not requested,
 If you build your kernel using KBUILD_OUTPUT= or O= options, these
 can be passed as environment variables to the script:
 
-  O=<kernel_build_path> $0 -- ./hid_bpf
+  O=<kernel_build_path> $0 -- ./tools/testing/selftests/hid/hid_bpf
 
 or
 
-  KBUILD_OUTPUT=<kernel_build_path> $0 -- ./hid_bpf
+  KBUILD_OUTPUT=<kernel_build_path> $0 -- ./tools/testing/selftests/hid/hid_bpf
 
 Options:
 
@@ -91,11 +93,14 @@ update_selftests()
 
 run_vm()
 {
-	local b2c="$1"
-	local kernel_bzimage="$2"
-	local command="$3"
+	local run_dir="$1"
+	local b2c="$2"
+	local kernel_bzimage="$3"
+	local command="$4"
 	local post_command=""
 
+	cd "${run_dir}"
+
 	if ! which "${QEMU_BINARY}" &> /dev/null; then
 		cat <<EOF
 Could not find ${QEMU_BINARY}
@@ -273,7 +278,7 @@ main()
 	fi
 
 	update_selftests "${kernel_checkout}" "${make_command}"
-	run_vm $b2c "${kernel_bzimage}" "${command}"
+	run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
 	if [[ "${debug_shell}" != "yes" ]]; then
 		echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
 	fi

-- 
2.39.1

