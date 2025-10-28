Return-Path: <linux-kselftest+bounces-44171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED3C12AF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 03:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F7D1AA2FFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 02:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848925FA29;
	Tue, 28 Oct 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgeg/ez6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6E20F08C
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619436; cv=none; b=RDouSWayfzbnFvq0OXzIeHZDkslBXG1QuJeyYlVQ6oGTQpUlae9fNLaWHUEffGElyqlAz0SdPUuAVlgyTGqWIseym22rA3s9j7ANyHlwdvlLG3sIb51jdJLqdXRBqf8ScK4Lb9fqHK6BVhHLEfeUaYlPmsuhSyggLZRO5K+hoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619436; c=relaxed/simple;
	bh=tghMfSE3EHspX9+jNAYWs92wXN0zAH7O2jSRkAxbNN8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R/dORM2T0bS+nFamdcK+RHfBj9hO6IlejTa1mRlKcUZ+KvVK4Ltwfd5ciN4wssqoFQBgHQkT7FwhRfAVvW5AAYhfS9mT6LalpY+vI3ysMvmGqMDeFnF4UH1c5kRa4HY3JjU4jngc5ZpgQ7x2/KH3FJECuNPeauhT2Jv6haEFE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgeg/ez6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a440d38452so1240820b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761619434; x=1762224234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWt3MOdMZIZJhK7UKwqURBiqMY11Trzd8HN9uFL+aNc=;
        b=fgeg/ez6GCG47PWdBf5vh4jKLCeOA7T0J7r6rPvBp4cVKy3TRPzBQxrjQYQ/CoiucH
         tVRWT0R9wdDWauPu/ujTjemEwYxqvMBIzb9N6P+CUaf7rxZkUORc1yIxy2vdg4Bux0ky
         kEhZ2GQgyHbUotfgFg9Yisy+mweYkggWoV+gtg/uiHdRwTzFGo3jwaUYwk0GTlIswlD3
         F6d+0VeviKIkj39X0xj6FuxzIh/e+9wWPNvtDX7pNtt/WedMKNu27sQOk7SuW8aghufc
         wSQdxJdq7M9ZjPLuuR5PUuT+Qe42IO1q1oJY8+sehwTwf5AqRN/gynypcnnq3YB9HZ2R
         e1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761619434; x=1762224234;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWt3MOdMZIZJhK7UKwqURBiqMY11Trzd8HN9uFL+aNc=;
        b=YwdlOJD3iLNOgoeACoprKoXZZ++4iEj5sihu91lM76VB8Vi1ef6nOC9hOHsnmzzwWe
         uzWdCd/yMR9gt7VtLitRhbwAyXYES7f5bNCJ4iX7TvhPJzTd+Omz9pJYdo+viW55FoIp
         W2QZnu4K5BUAAnDLkeWSdZIEJ3SOJrKllakSKn5T3Wymaa+wAetKCrX3BLZvvyXBEkbK
         ghZz9w/8EvazqeIDzCQC7hLHz/j5DIVTq0BoIpNn3HeKP1+OcJFS34pVRPwXalc7VM9S
         fo1ppNANEHoMnmANas3jIZ9ImqkV7eCMOKLZJ+1BUA9yLgCp9n33Rn7J8nHiTuVyMbdx
         Q3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMFevMKSIKW0kqO4OPfsB4Jze5VHt4ZstfoWKTQmfPk2C1YT1kqdPtKB2K109WCVddT/wDMYLbIhD3eOzeWco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVf/fPTma2TyUufgcaxcH9o1tM/WJopdltXbs0baHY2EV9c8qn
	HLhQRp0cx6v3vvL8wMXm16N6NXcDkNnsIwUal6YbwHkLRuuA9Hj1sPYuRojxZ9aOkcsVrYi523w
	/19uFdQ==
X-Google-Smtp-Source: AGHT+IHn8JQMCx39XhUTdMUj0uxdX6P7u2GBTaflD6TfH1hjthj57ev/5FIOeWI3U4dnGHxRViGJ2Qr+Ihw=
X-Received: from pfcs17.prod.google.com ([2002:a05:6a00:6fd1:b0:793:b157:af42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cca:b0:7a2:8111:7807
 with SMTP id d2e1a72fcca58-7a441b8fc81mr2315020b3a.5.1761619433991; Mon, 27
 Oct 2025 19:43:53 -0700 (PDT)
Date: Tue, 28 Oct 2025 02:42:56 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028024339.2028774-1-kuniyu@google.com>
Subject: [PATCH v2] selftests: harness: Support KCOV.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While writing a selftest with kselftest_harness.h, I often want to
check which paths are actually exercised.

Let's support generating KCOV coverage data.

We can specify the output directory via the KCOV_OUTPUT environment
variable, and the number of instructions to collect via the KCOV_SLOTS
environment variable.

  # KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 2)) \
    ./tools/testing/selftests/net/af_unix/scm_inq

Both variables can also be specified as the make variable.

  # make -C tools/testing/selftests/ \
    KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 4)) \
    kselftest_override_timeout=3D60 TARGETS=3Dnet/af_unix run_tests

The coverage data can be simply decoded with addr2line:

  $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
  net/unix/af_unix.c:1056
  net/unix/af_unix.c:3138
  net/unix/af_unix.c:3834
  net/unix/af_unix.c:3838
  net/unix/af_unix.c:311 (discriminator 2)
  ...

or more nicely with a script embedded in vock [0]:

  $ cat kcov/* | sort | uniq > local.log
  $ python3 ~/kernel/tools/vock/report.py \
    --kernel-src ./ --vmlinux ./vmlinux \
    --mode local --local-log local.log --filter unix
  ...
  ------------------------------- Coverage Report -------------------------=
-------
  =F0=9F=93=84 net/unix/af_unix.c (276 lines)
   ...
  942 | static int unix_setsockopt(struct socket *sock, int level, int optn=
ame,
  943 | 			   sockptr_t optval, unsigned int optlen)
  944 | {
   ...
  961 | 	switch (optname) {
  962 | 	case SO_INQ:
  963 > 		if (sk->sk_type !=3D SOCK_STREAM)
  964 | 			return -EINVAL;
  965 |
  966 > 		if (val > 1 || val < 0)
  967 | 			return -EINVAL;
  968 |
  969 > 		WRITE_ONCE(u->recvmsg_inq, val);
  970 | 		break;

Link: https://github.com/kzall0c/vock/blob/f3d97de9954f9df758c0ab287ca7e24e=
654288c7/report.py #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Support TEST()
v1: https://lore.kernel.org/linux-kselftest/20251017084022.3721950-1-kuniyu=
@google.com/
---
 Documentation/dev-tools/kselftest.rst       |  41 ++++++
 tools/testing/selftests/Makefile            |  14 ++-
 tools/testing/selftests/kselftest_harness.h | 133 +++++++++++++++++++-
 3 files changed, 178 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tool=
s/kselftest.rst
index 18c2da67fae4..5c2b92ac4a30 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -200,6 +200,47 @@ You can look at the TAP output to see if you ran into =
the timeout. Test
 runners which know a test must run under a specific time can then optional=
ly
 treat these timeouts then as fatal.
=20
+KCOV for selftests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Selftests built with `kselftest_harness.h` natively support generating
+KCOV coverage data.  See :doc:`KCOV: code coverage for fuzzing </dev-tools=
/kcov>`
+for prerequisites.
+
+You can specify the output directory with the `KCOV_OUTPUT` environment
+variable.  Additionally, you can specify the number of instructions to
+collect with the `KCOV_SLOTS` environment variable ::
+
+  # KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 2)) \
+        ./tools/testing/selftests/net/af_unix/scm_inq
+
+In the output directory, a coverage file is generated for each test
+case in the selftest ::
+
+  $ ls kcov/
+  scm_inq.dgram.basic  scm_inq.seqpacket.basic  scm_inq.stream.basic
+
+The default value of `KCOV_SLOTS` is `4096`, and `KCOV_SLOTS` multiplied
+by `sizeof(unsigned long)` must be multiple of `4096`, so the smallest
+value is `512`.
+
+Both `KCOV_OUTPUT` and `KCOV_SLOTS` can be specified as the variables
+on the `make` command line ::
+
+  # make -C tools/testing/selftests/ \
+        kselftest_override_timeout=3D60 \
+        KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 4)) \
+        TARGETS=3Dnet/af_unix run_tests
+
+The collected data can be decoded with `addr2line` ::
+
+  $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
+  net/unix/af_unix.c:1056
+  net/unix/af_unix.c:3138
+  net/unix/af_unix.c:3834
+  net/unix/af_unix.c:3838
+  ...
+
 Packaging selftests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index c46ebdb9b8ef..40e70fb1a347 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -218,12 +218,14 @@ all:
 	done; exit $$ret;
=20
 run_tests: all
-	@for TARGET in $(TARGETS); do \
-		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=3D$$BUILD_TARGET -C $$TARGET run_tests \
-				SRC_PATH=3D$(shell readlink -e $$(pwd)) \
-				OBJ_PATH=3D$(BUILD)                   \
-				O=3D$(abs_objtree);		    \
+	@for TARGET in $(TARGETS); do				\
+		BUILD_TARGET=3D$$BUILD/$$TARGET;			\
+		$(MAKE) OUTPUT=3D$$BUILD_TARGET			\
+			KCOV_OUTPUT=3D$(abspath $(KCOV_OUTPUT))	\
+			-C $$TARGET run_tests			\
+			SRC_PATH=3D$(shell readlink -e $$(pwd))	\
+			OBJ_PATH=3D$(BUILD)			\
+			O=3D$(abs_objtree);			\
 	done;
=20
 hotplug:
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/se=
lftests/kselftest_harness.h
index 3f66e862e83e..5b7a01722981 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,8 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <linux/kcov.h>
 #include <linux/unistd.h>
 #include <poll.h>
 #include <stdbool.h>
@@ -63,7 +65,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -175,9 +179,12 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
+		struct __fixture_variant_metadata __attribute__((unused)) *variant, \
+		char *test_full_name) \
 	{ \
+		enable_kcov(_metadata); \
 		test_name(_metadata); \
+		disable_kcov(_metadata, test_full_name); \
 	} \
 	static struct __test_metadata _##test_name##_object =3D \
 		{ .name =3D #test_name, \
@@ -401,7 +408,8 @@
 		const FIXTURE_VARIANT(fixture_name) *variant); \
 	static void wrapper_##fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata *variant) \
+		struct __fixture_variant_metadata *variant, \
+		char *test_full_name) \
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self_private, *self =3D NULL; \
@@ -430,7 +438,9 @@
 			if (_metadata->exit_code) \
 				_exit(0); \
 			*_metadata->no_teardown =3D false; \
+			enable_kcov(_metadata); \
 			fixture_name##_##test_name(_metadata, self, variant->data); \
+			disable_kcov(_metadata, test_full_name); \
 			_metadata->teardown_fn(false, _metadata, self, variant->data); \
 			_exit(0); \
 		} else if (child < 0 || child !=3D waitpid(child, &status, 0)) { \
@@ -470,6 +480,8 @@
 		object->teardown_fn =3D &wrapper_##fixture_name##_##test_name##_teardown=
; \
 		object->termsig =3D signal; \
 		object->timeout =3D tmout; \
+		object->kcov_fd =3D -1; \
+		object->kcov_slots =3D -1; \
 		_##fixture_name##_##test_name##_object =3D object; \
 		__register_test(object); \
 	} \
@@ -908,7 +920,8 @@ __register_fixture_variant(struct __fixture_metadata *f=
,
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *,
-		   struct __fixture_variant_metadata *);
+		   struct __fixture_variant_metadata *,
+		   char *test_name);
 	pid_t pid;	/* pid of test when being run */
 	struct __fixture_metadata *fixture;
 	void (*teardown_fn)(bool in_parent, struct __test_metadata *_metadata,
@@ -923,6 +936,10 @@ struct __test_metadata {
 	const void *variant;
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
+	int kcov_fd;
+	int kcov_slots;
+	char *kcov_dir;
+	unsigned long *kcov_mem;
 };
=20
 static inline bool __test_passed(struct __test_metadata *metadata)
@@ -1185,6 +1202,114 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
=20
+#define KCOV_SLOTS 4096
+
+static void enable_kcov(struct __test_metadata *t)
+{
+	char *slots;
+	int err;
+
+	t->kcov_dir =3D getenv("KCOV_OUTPUT");
+	if (!t->kcov_dir || *t->kcov_dir =3D=3D '\0')
+		return;
+
+	slots =3D getenv("KCOV_SLOTS");
+	if (slots && *slots !=3D '\0')
+		sscanf(slots, "%d", &t->kcov_slots);
+	if (t->kcov_slots <=3D 0)
+		t->kcov_slots =3D KCOV_SLOTS;
+
+	t->kcov_fd =3D open("/sys/kernel/debug/kcov", O_RDWR);
+	if (t->kcov_fd < 0) {
+		ksft_print_msg("ERROR OPENING KCOV FD\n");
+		goto err;
+	}
+
+	err =3D ioctl(t->kcov_fd, KCOV_INIT_TRACE, t->kcov_slots);
+	if (err) {
+		ksft_print_msg("ERROR INITIALISING KCOV\n");
+		goto err;
+	}
+
+	t->kcov_mem =3D mmap(NULL, sizeof(unsigned long) * t->kcov_slots,
+			   PROT_READ | PROT_WRITE, MAP_SHARED, t->kcov_fd, 0);
+	if ((void *)t->kcov_mem =3D=3D MAP_FAILED) {
+		ksft_print_msg("ERROR ALLOCATING MEMORY FOR KCOV\n");
+		goto err;
+	}
+
+	err =3D ioctl(t->kcov_fd, KCOV_ENABLE, KCOV_TRACE_PC);
+	if (err) {
+		ksft_print_msg("ERROR ENABLING KCOV\n");
+		goto err;
+	}
+
+	__atomic_store_n(&t->kcov_mem[0], 0, __ATOMIC_RELAXED);
+	return;
+err:
+	t->exit_code =3D KSFT_FAIL;
+	_exit(KSFT_FAIL);
+}
+
+static void disable_kcov(struct __test_metadata *t, char *test_name)
+{
+	int slots, err, dir, fd, i;
+
+	if (t->kcov_fd =3D=3D -1)
+		return;
+
+	slots =3D __atomic_load_n(&t->kcov_mem[0], __ATOMIC_RELAXED);
+	if (slots =3D=3D t->kcov_slots - 1)
+		ksft_print_msg("Set KCOV_SLOTS to a value greater than %d\n", t->kcov_sl=
ots);
+
+	err =3D ioctl(t->kcov_fd, KCOV_DISABLE, 0);
+	if (err) {
+		ksft_print_msg("ERROR DISABLING KCOV\n");
+		goto out;
+	}
+
+	err =3D mkdir(t->kcov_dir, 0755);
+	if (err =3D=3D -1 && errno !=3D EEXIST) {
+		ksft_print_msg("ERROR CREATING '%s'\n", t->kcov_dir);
+		goto out;
+	}
+	err =3D 0;
+
+	dir =3D open(t->kcov_dir, O_DIRECTORY);
+	if (dir < 0) {
+		ksft_print_msg("ERROR OPENING %s\n", t->kcov_dir);
+		err =3D dir;
+		goto out;
+	}
+
+	fd =3D openat(dir, test_name, O_RDWR | O_CREAT | O_TRUNC);
+
+	close(dir);
+
+	if (fd =3D=3D -1) {
+		ksft_print_msg("ERROR CREATING '%s' at '%s'\n", test_name, t->kcov_dir);
+		err =3D fd;
+		goto out;
+	}
+
+	for (i =3D 0; i < slots; i++) {
+		char buf[64];
+		int size;
+
+		size =3D snprintf(buf, 64, "0x%lx\n", t->kcov_mem[i + 1]);
+		write(fd, buf, size);
+	}
+
+out:
+	munmap(t->kcov_mem, sizeof(t->kcov_mem[0]) * t->kcov_slots);
+	close(t->kcov_fd);
+
+	if (err) {
+		t->exit_code =3D KSFT_FAIL;
+		_exit(KSFT_FAIL);
+	}
+}
+
 static void __run_test(struct __fixture_metadata *f,
 		       struct __fixture_variant_metadata *variant,
 		       struct __test_metadata *t)
@@ -1216,7 +1341,7 @@ static void __run_test(struct __fixture_metadata *f,
 		t->exit_code =3D KSFT_FAIL;
 	} else if (child =3D=3D 0) {
 		setpgrp();
-		t->fn(t, variant);
+		t->fn(t, variant, test_name);
 		_exit(t->exit_code);
 	} else {
 		t->pid =3D child;
--=20
2.51.1.838.g19442a804e-goog


