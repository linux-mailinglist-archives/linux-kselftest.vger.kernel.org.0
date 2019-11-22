Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D11107817
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2019 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVTmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Nov 2019 14:42:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVTmA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Nov 2019 14:42:00 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so9398086iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2019 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=XqUie1OerNL9yF1ZB5SjY+WlRxx8i6Gi295CctjMKck=;
        b=N+ligg6GjAfFKrsX8bbvZwqG4rV9gRNg8dP9haHYDSAtMVUsZUYl66Dq8yP757EMup
         zmlheNGOxBYxuEee3L2IONb60tadxTFMPeFhkB6iN2qsImPqOellLXbvI9Tlg3bTOo0y
         BJ/8L8rTcZisW1OAfuUORd1IbEfFdpzJT2XIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=XqUie1OerNL9yF1ZB5SjY+WlRxx8i6Gi295CctjMKck=;
        b=R0DBSqjgCprd2HqztTnhEsbuoVgbLxgoYR4AgvcgdsTe0+9nz4QNT8BzTzLLIfyBuQ
         juAE3+IJ2S5xrsvyzQOHSx6gQOZ5pS9r7quQtjvrmf+YFUeotVLOFmX69XkQkWx2fWSR
         BdcNLZ0XbmUhOjT0GrMlXCk8ZDzNwP8Ha2asLHsJnCOGwJdxTvPqWtjLZHAedQFYFjNJ
         8SFueFpaiFIOmCWLm65EDxx+dqbTeQJRRrJlFcYfUan1MzrL3vksbhKLS3McOuxdKULU
         ylO5itsUbGm/ZhrxrkrPF9JqMd9cty4EbKMdwtxfd4kLRwiRQ+ki2SdNrKOYwiTO1bB6
         jhyw==
X-Gm-Message-State: APjAAAWh98OjgeyCOISmVV7wIkhJ6QVA1TAuo+s//YzO/l+7C+RUVumP
        jEAPLjQXo2vW4YA8BR1HjE/DRw==
X-Google-Smtp-Source: APXvYqzU+ibgjLoB7aM+fQn/cec3zYlNupIxekZrzjTAnF0ua3n/yR5FvWfH4eF6sC2Oz0zWizxSHw==
X-Received: by 2002:a5d:9ad5:: with SMTP id x21mr6589387ion.43.1574451718771;
        Fri, 22 Nov 2019 11:41:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c22sm2510654ioa.23.2019.11.22.11.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:41:57 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.5.rc1
Message-ID: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
Date:   Fri, 22 Nov 2019 12:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DF26FA52ED4CE9BE32D2273C"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF26FA52ED4CE9BE32D2273C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 5.5-rc1.

This kselftest fixes update for Linux 5.5-rc1 consists of several
fixes to tests and framework. Masami Hiramatsu fixed several tests
to build and run correctly on arm and other 32bit architectures.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ce3a677802121e038d2f062e90f96f84e7351da0:

   selftests: watchdog: Add command line option to show watchdog_info 
(2019-10-02 13:44:43 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.5-rc1-fixes

for you to fetch changes up to ed2d8fa734e7759ac3788a19f308d3243d0eb164:

   selftests: sync: Fix cast warnings on arm (2019-11-07 14:54:37 -0700)

----------------------------------------------------------------
linux-kselftest-5.5-rc1-fixes

This kselftest fixes update for Linux 5.5-rc1 consists of several
fixes to tests and framework. Masami Hiramatsu fixed several tests
to build and run correctly on arm and other 32bit architectures.

----------------------------------------------------------------
Kees Cook (2):
       selftests: gen_kselftest_tar.sh: Do not clobber kselftest/
       selftests: Move kselftest_module.sh into kselftest/

Masami Hiramatsu (6):
       selftests: breakpoints: Fix a typo of function name
       selftests: proc: Make va_max 1MB
       selftests: vm: Build/Run 64bit tests only on 64bit arch
       selftests: net: Use size_t and ssize_t for counting file size
       selftests: net: Fix printf format warnings on arm
       selftests: sync: Fix cast warnings on arm

Prabhakar Kushwaha (1):
       kselftest: Fix NULL INSTALL_PATH for TARGETS runlist

Shuah Khan (1):
       selftests: Fix O= and KBUILD_OUTPUT handling for relative paths

  tools/testing/selftests/Makefile                   |  8 +++++---
  .../selftests/breakpoints/breakpoint_test_arm64.c  |  2 +-
  tools/testing/selftests/gen_kselftest_tar.sh       | 21 
+++++++++++--------
  .../{kselftest_module.sh => kselftest/module.sh}   |  0
  tools/testing/selftests/kselftest_install.sh       | 24 
+++++++++++-----------
  tools/testing/selftests/lib/bitmap.sh              |  2 +-
  tools/testing/selftests/lib/prime_numbers.sh       |  2 +-
  tools/testing/selftests/lib/printf.sh              |  2 +-
  tools/testing/selftests/lib/strscpy.sh             |  2 +-
  tools/testing/selftests/net/so_txtime.c            |  4 ++--
  tools/testing/selftests/net/tcp_mmap.c             |  8 ++++----
  tools/testing/selftests/net/udpgso.c               |  3 ++-
  tools/testing/selftests/net/udpgso_bench_tx.c      |  3 ++-
  .../selftests/proc/proc-self-map-files-002.c       |  6 +++++-
  tools/testing/selftests/sync/sync.c                |  6 +++---
  tools/testing/selftests/vm/Makefile                |  5 +++++
  tools/testing/selftests/vm/run_vmtests             | 10 +++++++++
  17 files changed, 68 insertions(+), 40 deletions(-)
  rename tools/testing/selftests/{kselftest_module.sh => 
kselftest/module.sh} (100%)
----------------------------------------------------------------

--------------DF26FA52ED4CE9BE32D2273C
Content-Type: text/x-patch;
 name="linux-kselftest-5.5-rc1-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.5-rc1-fixes.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..6e762c42d758 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,10 +86,10 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(abs_objtree)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)/kselftest
+		BUILD := $(abs_objtree)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
@@ -102,6 +102,7 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
+#$(info abd_objtree = $(abs_objtree) BUILD = $(BUILD))
 
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio
@@ -190,6 +191,7 @@ install: all
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
 	mkdir -p $(INSTALL_PATH)/kselftest
+	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
@@ -213,7 +215,7 @@ ifdef INSTALL_PATH
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 58ed5eeab709..ad41ea69001b 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool arun_test(int wr_size, int wp_size, int wr, int wp)
+static bool run_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;
diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing/selftests/gen_kselftest_tar.sh
index a27e2eec3586..8b2b6088540d 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -38,16 +38,21 @@ main()
 	esac
 	fi
 
-	install_dir=./kselftest
+	# Create working directory.
+	dest=`pwd`
+	install_work="$dest"/kselftest_install
+	install_name=kselftest
+	install_dir="$install_work"/"$install_name"
+	mkdir -p "$install_dir"
 
-# Run install using INSTALL_KSFT_PATH override to generate install
-# directory
-./kselftest_install.sh
-tar $copts kselftest${ext} $install_dir
-echo "Kselftest archive kselftest${ext} created!"
+	# Run install using INSTALL_KSFT_PATH override to generate install
+	# directory
+	./kselftest_install.sh "$install_dir"
+	(cd "$install_work"; tar $copts "$dest"/kselftest${ext} $install_name)
+	echo "Kselftest archive kselftest${ext} created!"
 
-# clean up install directory
-rm -rf kselftest
+	# clean up top-level install work directory
+	rm -rf "$install_work"
 }
 
 main "$@"
diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest/module.sh
similarity index 100%
rename from tools/testing/selftests/kselftest_module.sh
rename to tools/testing/selftests/kselftest/module.sh
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
index e2e1911d62d5..407af7da7037 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -6,30 +6,30 @@
 # Author: Shuah Khan <shuahkh@osg.samsung.com>
 # Copyright (C) 2015 Samsung Electronics Co., Ltd.
 
-install_loc=`pwd`
-
 main()
 {
-	if [ $(basename $install_loc) !=  "selftests" ]; then
+	base_dir=`pwd`
+	install_dir="$base_dir"/kselftest_install
+
+	# Make sure we're in the selftests top-level directory.
+	if [ $(basename "$base_dir") !=  "selftests" ]; then
 		echo "$0: Please run it in selftests directory ..."
 		exit 1;
 	fi
+
+	# Only allow installation into an existing location.
 	if [ "$#" -eq 0 ]; then
-		echo "$0: Installing in default location - $install_loc ..."
+		echo "$0: Installing in default location - $install_dir ..."
 	elif [ ! -d "$1" ]; then
 		echo "$0: $1 doesn't exist!!"
 		exit 1;
 	else
-		install_loc=$1
-		echo "$0: Installing in specified location - $install_loc ..."
+		install_dir="$1"
+		echo "$0: Installing in specified location - $install_dir ..."
 	fi
 
-	install_dir=$install_loc/kselftest_install
-
-# Create install directory
-	mkdir -p $install_dir
-# Build tests
-	KSFT_INSTALL_PATH=$install_dir make install
+	# Build tests
+	KSFT_INSTALL_PATH="$install_dir" make install
 }
 
 main "$@"
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
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 53f598f06647..34df4c8882af 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -105,8 +105,8 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 	tstop = (gettime_ns() - glob_tstart) / 1000;
 	texpect = ts->delay_us >= 0 ? ts->delay_us : 0;
 
-	fprintf(stderr, "payload:%c delay:%ld expected:%ld (us)\n",
-			rbuf[0], tstop, texpect);
+	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
+			rbuf[0], (long long)tstop, (long long)texpect);
 
 	if (rbuf[0] != ts->data)
 		error(1, 0, "payload mismatch. expected %c", ts->data);
diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 31ced79f4f25..33035d1b3f6d 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -71,7 +71,7 @@
 #define MSG_ZEROCOPY    0x4000000
 #endif
 
-#define FILE_SZ (1UL << 35)
+#define FILE_SZ (1ULL << 35)
 static int cfg_family = AF_INET6;
 static socklen_t cfg_alen = sizeof(struct sockaddr_in6);
 static int cfg_port = 8787;
@@ -155,7 +155,7 @@ void *child_thread(void *arg)
 			socklen_t zc_len = sizeof(zc);
 			int res;
 
-			zc.address = (__u64)addr;
+			zc.address = (__u64)((unsigned long)addr);
 			zc.length = chunk_size;
 			zc.recv_skip_hint = 0;
 			res = getsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
@@ -302,7 +302,7 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage listenaddr, addr;
 	unsigned int max_pacing_rate = 0;
-	unsigned long total = 0;
+	size_t total = 0;
 	char *host = NULL;
 	int fd, c, on = 1;
 	char *buffer;
@@ -417,7 +417,7 @@ int main(int argc, char *argv[])
 		zflg = 0;
 	}
 	while (total < FILE_SZ) {
-		long wr = FILE_SZ - total;
+		ssize_t wr = FILE_SZ - total;
 
 		if (wr > chunk_size)
 			wr = chunk_size;
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index b8265ee9923f..cab334e51ac1 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -448,7 +448,8 @@ static bool __send_one(int fd, struct msghdr *msg, int flags)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != msg->msg_iov->iov_len)
-		error(1, 0, "sendto: %d != %lu", ret, msg->msg_iov->iov_len);
+		error(1, 0, "sendto: %d != %llu", ret,
+			(unsigned long long)msg->msg_iov->iov_len);
 	if (msg->msg_flags)
 		error(1, 0, "sendmsg: return flags 0x%x\n", msg->msg_flags);
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index ada99496634a..17512a43885e 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -405,7 +405,8 @@ static int send_udp_segment(int fd, char *data)
 	if (ret == -1)
 		error(1, errno, "sendmsg");
 	if (ret != iov.iov_len)
-		error(1, 0, "sendmsg: %u != %lu\n", ret, iov.iov_len);
+		error(1, 0, "sendmsg: %u != %llu\n", ret,
+			(unsigned long long)iov.iov_len);
 
 	return 1;
 }
diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 47b7473dedef..e6aa00a183bc 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -47,7 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	const unsigned long va_max = 1UL << 32;
+	/*
+	 * va_max must be enough bigger than vm.mmap_min_addr, which is
+	 * 64KB/32KB by default. (depends on CONFIG_LSM_MMAP_MIN_ADDR)
+	 */
+	const unsigned long va_max = 1UL << 20;
 	unsigned long va;
 	void *p;
 	int fd;
diff --git a/tools/testing/selftests/sync/sync.c b/tools/testing/selftests/sync/sync.c
index f3d599f249b9..7741c0518d18 100644
--- a/tools/testing/selftests/sync/sync.c
+++ b/tools/testing/selftests/sync/sync.c
@@ -109,7 +109,7 @@ static struct sync_file_info *sync_file_info(int fd)
 			return NULL;
 		}
 
-		info->sync_fence_info = (uint64_t)fence_info;
+		info->sync_fence_info = (uint64_t)(unsigned long)fence_info;
 
 		err = ioctl(fd, SYNC_IOC_FILE_INFO, info);
 		if (err < 0) {
@@ -124,7 +124,7 @@ static struct sync_file_info *sync_file_info(int fd)
 
 static void sync_file_info_free(struct sync_file_info *info)
 {
-	free((void *)info->sync_fence_info);
+	free((void *)(unsigned long)info->sync_fence_info);
 	free(info);
 }
 
@@ -152,7 +152,7 @@ int sync_fence_count_with_status(int fd, int status)
 	if (!info)
 		return -1;
 
-	fence_info = (struct sync_fence_info *)info->sync_fence_info;
+	fence_info = (struct sync_fence_info *)(unsigned long)info->sync_fence_info;
 	for (i = 0 ; i < info->num_fences ; i++) {
 		if (fence_info[i].status == status)
 			count++;
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9534dc2bc929..7f9a8a8c31da 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
@@ -16,8 +18,11 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
+endif
 
 TEST_PROGS := run_vmtests
 
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 951c507a27f7..a692ea828317 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -58,6 +58,14 @@ else
 	exit 1
 fi
 
+#filter 64bit architectures
+ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64"
+if [ -z $ARCH ]; then
+  ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
+fi
+VADDR64=0
+echo "$ARCH64STR" | grep $ARCH && VADDR64=1
+
 mkdir $mnt
 mount -t hugetlbfs none $mnt
 
@@ -189,6 +197,7 @@ else
 	echo "[PASS]"
 fi
 
+if [ $VADDR64 -ne 0 ]; then
 echo "-----------------------------"
 echo "running virtual_address_range"
 echo "-----------------------------"
@@ -210,6 +219,7 @@ if [ $? -ne 0 ]; then
 else
     echo "[PASS]"
 fi
+fi # VADDR64
 
 echo "------------------------------------"
 echo "running vmalloc stability smoke test"

--------------DF26FA52ED4CE9BE32D2273C--
