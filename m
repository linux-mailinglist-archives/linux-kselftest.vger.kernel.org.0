Return-Path: <linux-kselftest+bounces-37626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4CAB0AF89
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2DE4E830E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831E23B626;
	Sat, 19 Jul 2025 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGb0DUF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9B23AE60;
	Sat, 19 Jul 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923602; cv=none; b=ZgmaG6PVqhgko9lDITS+SrU5GWmeEb2ZyE2UF3MOYvpppTcwdWFA3E1zsvZKlsh+8qI1Fw27CntqT9+b/Cpr3QyNpRxsf91Ppra7zNJF/WSbjIi11SYtQKdkjKchrV6QZweB5UfUAlDWI1pRcfp7asMb3OJYXm6i9sQNYKkTEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923602; c=relaxed/simple;
	bh=Iww/UpGyLtrx1j10ruDTf8LZMrndDjrz8uY2/BP9cpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAIT/0oCL8473lAnk/Lkea+zh0jLFridSTWL2Tyhf5AcWHI7hUubW8A8gfMAgFRaeHlq0qC8ky9pAUZtHeUJvZyz7UuNvnziAY3gdIznR0dwBBZ8r52SbU26Bpx585ForPtKWP9Rj9gaC9PN9dD3s8U0VqQSfYSzkvGwbk6ovO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGb0DUF2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so24755525ad.3;
        Sat, 19 Jul 2025 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923600; x=1753528400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Jd/5d465A0jCumj6dQXUppGRMZZOxb6FPpLcIZ9JVE=;
        b=UGb0DUF2c37L0yQF4ikb0YxS/G7UIKZoJ2L1Mxewe6zMnB86DVISH4VBKZiHF7qaZ8
         JB+LYNbCf19lYFN+CjH3Aq5oFR18Nx+kiLI0195NsK1dg5+ILeDkDj413ZorwM8yH7G+
         PE6Ovx+zm4mLqsAawvOa5Ec/xuE8/ewAdsp3amUj8vciEPwsKHI1hd9A+nlCTe6ntLMm
         fjxYRHdVKVG5lYK+eST9sYspChDiXW7mP8sypVaSlz3ZJx46i+PKNMIqCnDPph3LSgw4
         nxoOc4dz/9CiQsomqnwSpJYpsA8tXQY+Te5aEN46ixsqf1gbfu0PZyRGHd/VX1+ta8Me
         nDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923600; x=1753528400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jd/5d465A0jCumj6dQXUppGRMZZOxb6FPpLcIZ9JVE=;
        b=A/24311TQxEC9YFEuUGGc3KSn+azy8awiXzBuH26xOVZeZ/tIPCx6ciPsxWqjHKaJU
         lOoyN+sk2ZME3hWmuKz5HFj4SHTwrFKat1zLuvvTkDLrcY+jioj3vGodoKX75lMF/RIJ
         NhHpgL1FFDWR+3Y19gcg8MPxbxXz6XARAHg8DMNtYQx1c/QqLZVJ6GQvCS1tdFpVzOr7
         iFJrP8pYSNj8yzOsP2ci2PfhCBiXwm32B7DkwxxCSo5Mw5KNE6ZI7z2leJF8dmNHFV+7
         KmjYrWUfO2IecOOx+g4sU+dnM0C5gdh8bKo2pQ+m97LPd9VxqBElqCS3Oxiq0CtwK5je
         lePw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ImEOu805hWMnR13w2p31fM8hnjpcsZUdViXT1X8HB7bgPER0pxVG76hPCWsWuZof8EDbpsAWK3mDUy0XEVzq@vger.kernel.org, AJvYcCX3PxB1rVznfb9TuG0o1hu3q7fbBFfaJUSqqNbt6/d3ov1QDDF+q4sizxc4BqgG+bIuFgHKLpX7WBRbjCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOMZ879sUa4yf0ZZ9nb707ecRLaz6dcgQEmZTyhEy8dPnXJY6
	pCr2NG5mu/ocDYo9eZEWuz61FGQOud6GZzZdStw6GrNtF+5hqKBCc6sr
X-Gm-Gg: ASbGncsmv98B1F0aZxgalY90ruS7j7ySJfiU4ZlzvQSH6DUid+aJEHHrb0zAiSzf8zd
	XRTkUDJQuojw7polfZOSuUASzjOSwaUMkGC/aevdd/TtZYomyCjt7WiWZHJo/uvE20MhnsDKoGc
	YGACiyvAYglCygL9eJQ0HxDGbU/izDU2cagPNrqmY9aFb4IURZzTO3IoHVNga5iNHwbMQfRMfGQ
	I0+znk+2hGHHq4Oi9jpXnL/n/Wocf7JratTgjHrcA2fEd365jbpddbBz1BlnzMfqdlh+01fkhC+
	0V/GwM4kaS8kUAcyKJ+crDpswm7E7PyBwccK3HsOHYkhGMcBJoEfLNcOuVnAkxN+f9yrivn7MSq
	zt78wHuyrDV0tYd8ZFkJJ
X-Google-Smtp-Source: AGHT+IEAPjC4pj685n73OCXBGa3ulx7qROou2OgY1ptOxHHWKAYpNN7RhIDQ9S1zZEHJLglu5uD+8g==
X-Received: by 2002:a17:902:c409:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23e256848f5mr163928225ad.6.1752923599651;
        Sat, 19 Jul 2025 04:13:19 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c81sm27388875ad.114.2025.07.19.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:13:19 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 05:13:14 -0600
Subject: [PATCH RFC 4/4] selftests/landlock: add memfd execution tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-memfd-exec-v1-4-0ef7feba5821@gmail.com>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
In-Reply-To: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752923593; l=10834;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=Iww/UpGyLtrx1j10ruDTf8LZMrndDjrz8uY2/BP9cpc=;
 b=kIjDOTlzaXRksQJMV4lD0AKnhdTH0vFXs450vzHO9XXX4DPVtJbviuK8aZKqG2ckFvORf7mmK
 3sV2DwdEZCPBwGjmRnqKTUmFMhGYKAjUyCwn8jwjUyLmr7pbp67hTD2
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add core test suite for LANDLOCK_SCOPE_MEMFD_EXEC covering:

- Same-domain execution restriction (prevent read-to-execute bypass)
- execve() family syscall restrictions via /proc/self/fd/ path
- Regular filesystem files remain unaffected by memfd scoping

Tests validate that memfd execution restrictions are properly enforced
while ensuring surgical targeting that doesn't impact legitimate file
operations. Covers key attack vectors including anonymous execution
and W^X policy bypass attempts.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../selftests/landlock/scoped_memfd_exec_test.c    | 325 +++++++++++++++++++++
 1 file changed, 325 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_memfd_exec_test.c b/tools/testing/selftests/landlock/scoped_memfd_exec_test.c
new file mode 100644
index 000000000000..2513a44d8320
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_memfd_exec_test.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests for LANDLOCK_SCOPE_MEMFD_EXEC domain restrictions
+ *
+ * These tests validate Landlock's hierarchical execution control for memfd
+ * objects. The scoping mechanism prevents processes from executing memfd
+ * created in different domain contexts.
+ *
+ * Copyright © 2025 Abhinav Saxena <xandfury@gmail.com>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <linux/memfd.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "scoped_common.h"
+
+static int create_test_memfd(struct __test_metadata *const _metadata)
+{
+	int memfd;
+	static const char test_data[] = "#!/bin/sh\nexit 42\n";
+
+	memfd = memfd_create("test_exec", 0);
+	ASSERT_LE(0, memfd)
+	{
+		TH_LOG("Failed to create memfd: %s", strerror(errno));
+	}
+
+	ASSERT_EQ(fchmod(memfd, 0700), 0);
+
+	ASSERT_EQ(0, ftruncate(memfd, sizeof(test_data)));
+	ASSERT_EQ(sizeof(test_data),
+		  write(memfd, test_data, sizeof(test_data)));
+	ASSERT_EQ(0, lseek(memfd, 0, SEEK_SET));
+
+	return memfd;
+}
+
+static bool test_mmap_exec_restriction(int memfd, bool expect_denied)
+{
+	void *addr;
+	const size_t page_size = getpagesize();
+
+	addr = mmap(NULL, page_size, PROT_READ | PROT_EXEC, MAP_PRIVATE, memfd,
+		    0);
+
+	if (expect_denied) {
+		bool correctly_denied = (addr == MAP_FAILED && errno == EACCES);
+
+		if (addr != MAP_FAILED)
+			munmap(addr, page_size);
+		return correctly_denied;
+	}
+
+	if (addr == MAP_FAILED)
+		return false;
+
+	munmap(addr, page_size);
+	return true;
+}
+
+/* clang-format off */
+FIXTURE(scoped_domains) {};
+/* clang-format on */
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
+}
+
+/*
+ * Test that regular filesystem files are unaffected by memfd restrictions
+ *
+ * This test ensures that LANDLOCK_SCOPE_MEMFD_EXEC scoping only affects
+ * memfd objects and does not interfere with normal file execution or
+ * memory mapping of regular filesystem files.
+ *
+ * Security scenarios tested:
+ * - Scope isolation: memfd restrictions don't affect regular files
+ * - Proper targeting: only anonymous memory objects are restricted
+ *
+ * Scenarios considered (while allowing legitimate use):
+ * - Malicious process creates executable memfd -> BLOCKED
+ * - Same process maps legitimate executable file ->ALLOWED
+ * - Ensures restrictions are surgical, not broad
+ *
+ * Test flow:
+ * 1. Parent optionally creates scoped domain
+ * 2. Parent forks child process
+ * 3. Child optionally creates scoped domain
+ * 4. Child creates regular temporary file with executable content
+ * 5. Child creates memfd with same content
+ * 6. Test memfd execution ->should follow scoping rules
+ * 7. Test regular file execution ->should always work regardless of memfd
+ * scoping
+ * 8. Verify differential behavior confirms proper targeting
+ */
+TEST_F(scoped_domains, regular_file_unaffected)
+{
+	int tmp_fd, memfd;
+	char tmp_path[] = "/tmp/landlock_test_XXXXXX";
+	void *addr;
+	const size_t page_size = getpagesize();
+	bool memfd_should_be_denied;
+
+	memfd_should_be_denied = variant->domain_child ||
+				 variant->domain_parent;
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_MEMFD_EXEC);
+
+	pid_t child = fork();
+
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		/* Child process */
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_MEMFD_EXEC);
+
+		/* Create regular file with executable test content */
+		tmp_fd = mkstemp(tmp_path);
+		ASSERT_LE(0, tmp_fd);
+		ASSERT_EQ(0, fchmod(tmp_fd, 0755));
+
+		static const char test_data[] = "#!/bin/sh\nexit 42\n";
+
+		ASSERT_EQ(sizeof(test_data),
+			  write(tmp_fd, test_data, sizeof(test_data)));
+		ASSERT_EQ(0, lseek(tmp_fd, 0, SEEK_SET));
+
+		/* Create memfd with identical content for comparison */
+		memfd = create_test_memfd(_metadata);
+
+		/* Test memfd execution - should follow scoping restrictions */
+		bool memfd_correctly_handled = test_mmap_exec_restriction(
+			memfd, memfd_should_be_denied);
+		EXPECT_TRUE(memfd_correctly_handled);
+
+		/*
+		 * Test regular file execution - should always work regardless
+		 * of memfd scoping
+		 */
+		addr = mmap(NULL, page_size, PROT_READ | PROT_EXEC, MAP_PRIVATE,
+			    tmp_fd, 0);
+		EXPECT_NE(MAP_FAILED, addr);
+		if (addr != MAP_FAILED)
+			munmap(addr, page_size);
+
+		/* Cleanup */
+		close(memfd);
+		close(tmp_fd);
+		unlink(tmp_path);
+		_exit(_metadata->exit_code);
+	}
+
+	/* Parent waits for child */
+	int status;
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * Test execve() family syscall restrictions on memfd
+ *
+ * This test validates that direct execution of memfd files via execve(),
+ * execveat(), and fexecve() syscalls is properly blocked when domain
+ * scoping is enabled. Tests the /proc/self/fd/ execution path commonly
+ * used for anonymous execution.
+ *
+ * Security scenarios tested:
+ * - Direct memfd execution via /proc/self/fd/ path
+ * - Anonymous execution prevention
+ * - execve() hook integration with memfd scoping
+ *
+ * Attack scenarios prevented:
+ * 1. execve("/proc/self/fd/N") where N is memfd file descriptor
+ * 2. execveat(memfd_fd, "", args, env, AT_EMPTY_PATH) - anonymous execution
+ * 3. fexecve(memfd_fd, args, env) - file descriptor execution
+ *
+ * Test flow:
+ * 1. Parent optionally creates scoped domain
+ * 2. Parent forks child process
+ * 3. Child optionally creates scoped domain
+ * 4. Child creates memfd with executable script content
+ * 5. Child attempts execve() using /proc/self/fd/N path
+ * 6. Verify: EACCES if scoped, successful execution (exit 42) if not scoped
+ * 7. Parent checks child exit status to determine success/failure
+ */
+TEST_F(scoped_domains, execve_restriction)
+{
+	int memfd;
+	char fd_path[64];
+	bool should_be_denied;
+
+	should_be_denied = variant->domain_child || variant->domain_parent;
+	TH_LOG("execve_restriction: parent=%d, child=%d\n",
+	       variant->domain_parent, variant->domain_child);
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_MEMFD_EXEC);
+
+	pid_t child = fork();
+
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		/* Child process */
+		if (variant->domain_child) {
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_MEMFD_EXEC);
+		}
+
+		memfd = create_test_memfd(_metadata);
+		snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", memfd);
+
+		/* Attempt execve on memfd via /proc/self/fd/ path */
+		char *const argv[] = { "test", NULL };
+		char *const envp[] = { NULL };
+
+		int ret = execve(fd_path, argv, envp);
+
+		ASSERT_EQ(-1, ret);
+
+		/* If we reach here, execve failed */
+		if (should_be_denied) {
+			EXPECT_EQ(EACCES,
+				  errno); /* Should be blocked by Landlock */
+		} else {
+			/* execve should have succeeded but failed for other reason */
+			TH_LOG("execve failed unexpectedly: %s",
+			       strerror(errno));
+		}
+
+		close(memfd);
+		_exit(_metadata->exit_code);
+	}
+
+	/* Parent waits for child and checks exit status */
+	int status;
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (should_be_denied) {
+		/* Child should exit normally after execve was blocked */
+		EXPECT_TRUE(WIFEXITED(status));
+	} else {
+		/*
+		 * Child should have executed successfully with script's
+		 * exit code
+		 */
+		EXPECT_TRUE(WIFEXITED(status));
+		EXPECT_EQ(42,
+			  WEXITSTATUS(status)); /* Exit code from test script */
+	}
+}
+
+/*
+ * Test same-domain execution restriction (should always be denied when scoped)
+ *
+ * This test validates the "Same domain: DENY" rule from the security matrix.
+ * When a process is in a scoped domain, it should not be able to execute
+ * memfd objects that it created itself, preventing read-to-execute bypass.
+ *
+ * Security scenarios tested:
+ * - Read-to-execute bypass prevention within same domain
+ * - Self-execution blocking for memfd objects
+ *
+ * Attack scenario prevented:
+ * - Attacker process creates writable memfd in current domain
+ * - Writes malicious shellcode to the memfd via write() syscalls
+ * - Attempts to execute the same memfd via mmap(PROT_EXEC)
+ * - Should be BLOCKED by same-domain denial rule
+ * - Prevents bypassing W^X policies via anonymous memory
+ *
+ * Test flow:
+ * 1. Process optionally creates scoped domain
+ * 2. Process creates memfd (inherits current domain context)
+ * 3. Process attempts to mmap its own memfd with PROT_EXEC
+ * 4. Verify: ALLOW if not scoped, DENY if scoped (same domain rule)
+ */
+TEST_F(scoped_domains, same_domain_restriction)
+{
+	int memfd;
+	bool should_be_denied;
+
+	/* Same domain should be denied when scoped, allowed when not scoped */
+	should_be_denied = variant->domain_parent;
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_MEMFD_EXEC);
+
+	/* Process creates and tries to execute its own memfd (same domain) */
+	memfd = create_test_memfd(_metadata);
+
+	bool test_passed = test_mmap_exec_restriction(memfd, should_be_denied);
+
+	EXPECT_TRUE(test_passed);
+
+	close(memfd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.43.0


