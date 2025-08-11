Return-Path: <linux-kselftest+bounces-38668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70402B201CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA8189F035
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B873C2DCC06;
	Mon, 11 Aug 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+xamGjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5832DC33B;
	Mon, 11 Aug 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900737; cv=none; b=cyHVlZk8YBXl9DNZh9Js6iOj+m0RLzLGLqcL9ZpT9KAlDsP3/LHuEW/8wRgd3Cs8TH1Yp/eho5zJK2dZRD+U+pGxSrdrTaIIlTseDTXIGx8v7pMfX4L9whfBB/M8OdLtR4pukOAXs4uG3ZnSwMUDo5QwtVKeLQok0d4Nc9TWdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900737; c=relaxed/simple;
	bh=x9yDF0ETg1DZV483jmCAS7zdZyJxfX8QtrhsIOYLE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PICFhfeTCy1Ln0bqEFCLyR5h/RFstlNi6GvmL5aATvsgCzVTTjiJ6jI9pKOPs2lCqlLCZELi+j5xrXLcioajcr2/gRYK4lP/4sgsycEokoxp0xjJOll2WPSqXxa4AsSjcf+LRVJ8y5tAWTd5PtUJG3lXmlaZYrFPeZoTR5C91Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+xamGjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AADC4CEF8;
	Mon, 11 Aug 2025 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900737;
	bh=x9yDF0ETg1DZV483jmCAS7zdZyJxfX8QtrhsIOYLE3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+xamGjRj0qBZ8f+MKHSAySNijepwnYwt5H+o27/gEbgnXE3KQltdcbB0iHOqwdja
	 e3uxwJ+w5yxH41yVobpeGbK+tifeiohOed1kRfcIgZnRmaI0/zJph8jQ5jZVoQmEeA
	 SF8HdzQuD9/keUQlz5XLJhcPyyioXMA19Oobp3ATZm0iBRUf4g+5zifCSJpt16V6ae
	 aZW1oBggKLDmPu7m2OsuFxhT2HtyISgt7vOI/0pde2gNl2gwyV7EtRwVfP6dGR1CnN
	 VBZIFHyuTocPG+JYnv9+2PApCwJFsdR/g/PfEDfrLK1MTZdRF9ha1opuD5ix9iZ9en
	 HgZmIqifpPCkg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] selftest/kho: update generation of initrd
Date: Mon, 11 Aug 2025 11:25:10 +0300
Message-ID: <20250811082510.4154080-4-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Use nolibc include directory rather than include a cumulative nolibc.h
on the compiler command line and replace use of 'sudo cpio' with
usr/gen_init_cpio.

While on it fix spelling of KHO_FINALIZE

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 tools/testing/selftests/kho/init.c    | 13 ++++---------
 tools/testing/selftests/kho/vmtest.sh | 28 ++++++++++++++-------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 8034e24c6bf6..6d9e91d55d68 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -1,22 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifndef NOLIBC
-#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <syscall.h>
+#include <sys/syscall.h>
 #include <sys/mount.h>
 #include <sys/reboot.h>
-#endif
+#include <linux/kexec.h>
 
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-/* from include/linux/kexex.h */
-#define KEXEC_FILE_NO_INITRAMFS	0x00000004
-
-#define KHO_FINILIZE "/debugfs/kho/out/finalize"
+#define KHO_FINALIZE "/debugfs/kho/out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
@@ -32,7 +27,7 @@ static int kho_enable(void)
 	const char enable[] = "1";
 	int fd;
 
-	fd = open(KHO_FINILIZE, O_RDWR);
+	fd = open(KHO_FINALIZE, O_RDWR);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index ec70a17bd476..3f6c17166846 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -10,7 +10,6 @@ kernel_dir=$(realpath "$test_dir/../../../..")
 
 tmp_dir=$(mktemp -d /tmp/kho-test.XXXXXXXX)
 headers_dir="$tmp_dir/usr"
-initrd_dir="$tmp_dir/initrd"
 initrd="$tmp_dir/initrd.cpio"
 
 source "$test_dir/../kselftest/ktap_helpers.sh"
@@ -81,19 +80,22 @@ EOF
 function mkinitrd() {
 	local kernel=$1
 
-	mkdir -p "$initrd_dir"/{dev,debugfs,proc}
-	sudo mknod "$initrd_dir/dev/console" c 5 1
-
-	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -I"$headers_dir/include" \
-			-fno-asynchronous-unwind-tables -fno-ident -nostdlib \
-			-include "$test_dir/../../../include/nolibc/nolibc.h" \
-			-o "$initrd_dir/init" "$test_dir/init.c" \
-
-	cp "$kernel" "$initrd_dir/kernel"
+	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib \
+			-fno-asynchronous-unwind-tables -fno-ident \
+			-I "$headers_dir/include" \
+			-I "$kernel_dir/tools/include/nolibc" \
+			-o "$tmp_dir/init" "$test_dir/init.c"
+
+	cat > "$tmp_dir/cpio_list" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $tmp_dir/init 0755 0 0
+file /kernel $kernel 0644 0 0
+EOF
 
-	pushd "$initrd_dir" &>/dev/null
-	find . | cpio -H newc --create > "$initrd" 2>/dev/null
-	popd &>/dev/null
+	"$build_dir/usr/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"
 }
 
 function run_qemu() {
-- 
2.47.2


