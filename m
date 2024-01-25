Return-Path: <linux-kselftest+bounces-3574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6483C6C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1C91C22465
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21E6EB71;
	Thu, 25 Jan 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="N/OuX3Fw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40073167
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196767; cv=none; b=osqMPEWb/39WUFXnH40jmsDfG/twGhR7l598IvqyUGa1URbq4ft0pHiOWqrGh3TsLCSghmR6skbZ9IN2HAJi5KjGDEXz1FhxkyMKaCcQ5uPq9R7Z6KNY5Y7VKeU1g9Nd+MzIdHyjWbNvW+qNBFQct5FuTO5WsBBzAFB2xbVuuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196767; c=relaxed/simple;
	bh=VWtHQ59lxyMB61zLeDy+W1fVCMA/aB330CRifBk6QM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUPf3UOZk4PuF54cMHr0UAhHGzAvJKBBUqBgoP9Bn1nARXpwWx7fLS2FRwY+uyz04dcn7LLmH3DsUO4EO7z9LXeDuveSIef+RFgtqc+oHjJfQbKNcIZ7X2o4CMZtv4aLDQ68VureGqvL3K1Bew8sEI8L0qU7ZGgtznRTiSrBfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=N/OuX3Fw; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLPw44rddzMqJX8;
	Thu, 25 Jan 2024 16:32:36 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLPw41mRkzMppDN;
	Thu, 25 Jan 2024 16:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706196756;
	bh=VWtHQ59lxyMB61zLeDy+W1fVCMA/aB330CRifBk6QM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/OuX3Fwcm5MfwDjB2F0XvNP/aIAvIk7bxzm5JmTX4pA2tbJ2zk8n7JDQMGmIOM/j
	 ODB/TnzLTXdMkfDTsGzYkSjdgFm7LKZwQ5Q0QxLchanKXq845RyQ/XVO0rYnFpLZAp
	 5z/exeD+9VilMuVVX1rBzI6oPJ6bSh16IW6be9qY=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] selftests/landlock: Fix capability for net_test
Date: Thu, 25 Jan 2024 16:32:29 +0100
Message-ID: <20240125153230.3817165-2-mic@digikod.net>
In-Reply-To: <20240125153230.3817165-1-mic@digikod.net>
References: <20240125153230.3817165-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

CAP_NET_ADMIN allows to configure network interfaces, not CAP_SYS_ADMIN
which only allows to call unshare(2).  Without this change, running
network tests as a non-root user but with all capabilities would fail at
the setup_loopback() step with "RTNETLINK answers: Operation not
permitted".

The issue is only visible when running tests with non-root users (i.e.
only relying on ambient capabilities).  Indeed, when configuring the
network interface, the "ip" command is called, which may lead to the
special handling of capabilities for the root user by execve(2).  If
root is the caller, then the inherited, permitted and effective
capabilities are all reset, which then includes CAP_NET_ADMIN.  However,
if a non-root user is the caller, then ambient capabilities are masked
by the inherited ones, which were explicitly dropped.

To make execution deterministic whatever users are running the tests,
set the noroot secure bit for each test, and set the inheritable and
ambient capabilities to CAP_NET_ADMIN, the only capability that may be
required after an execve(2).

Factor out _effective_cap() into _change_cap(), and use it to manage
ambient capabilities with the new set_ambient_cap() and
clear_ambient_cap() helpers.

This makes it possible to run all Landlock tests (including net_test)
with uml-run.sh from https://github.com/landlock-lsm/landlock-test-tools

Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/common.h   | 51 +++++++++++++++++----
 tools/testing/selftests/landlock/net_test.c |  5 +-
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 5b79758cae62..13597ebd3a64 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <linux/landlock.h>
+#include <linux/securebits.h>
 #include <sys/capability.h>
 #include <sys/socket.h>
 #include <sys/syscall.h>
@@ -115,12 +116,20 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		/* clang-format off */
 		CAP_DAC_OVERRIDE,
 		CAP_MKNOD,
+		CAP_NET_ADMIN,
+		CAP_NET_BIND_SERVICE,
 		CAP_SYS_ADMIN,
 		CAP_SYS_CHROOT,
-		CAP_NET_BIND_SERVICE,
 		/* clang-format on */
 	};
 
+	/*
+	 * As a safety guard, this should be called each time, but it will fail
+	 * the second time when called by the same task (e.g.
+	 * fs_test.c:layout0.unpriv), which is OK.
+	 */
+	cap_set_secbits(SECBIT_NOROOT);
+
 	cap_p = cap_get_proc();
 	EXPECT_NE(NULL, cap_p)
 	{
@@ -137,6 +146,8 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 			TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
 		}
 	}
+
+	/* Automatically resets ambient capabilities. */
 	EXPECT_NE(-1, cap_set_proc(cap_p))
 	{
 		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
@@ -145,6 +156,9 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 	{
 		TH_LOG("Failed to cap_free: %s", strerror(errno));
 	}
+
+	/* Quickly checks that ambient capabilities are cleared. */
+	EXPECT_NE(-1, cap_get_ambient(caps[0]));
 }
 
 /* We cannot put such helpers in a library because of kselftest_harness.h . */
@@ -158,8 +172,9 @@ static void __maybe_unused drop_caps(struct __test_metadata *const _metadata)
 	_init_caps(_metadata, true);
 }
 
-static void _effective_cap(struct __test_metadata *const _metadata,
-			   const cap_value_t caps, const cap_flag_value_t value)
+static void _change_cap(struct __test_metadata *const _metadata,
+			const cap_flag_t flag, const cap_value_t cap,
+			const cap_flag_value_t value)
 {
 	cap_t cap_p;
 
@@ -168,7 +183,7 @@ static void _effective_cap(struct __test_metadata *const _metadata,
 	{
 		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
 	}
-	EXPECT_NE(-1, cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &caps, value))
+	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value))
 	{
 		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
 	}
@@ -183,15 +198,35 @@ static void _effective_cap(struct __test_metadata *const _metadata,
 }
 
 static void __maybe_unused set_cap(struct __test_metadata *const _metadata,
-				   const cap_value_t caps)
+				   const cap_value_t cap)
 {
-	_effective_cap(_metadata, caps, CAP_SET);
+	_change_cap(_metadata, CAP_EFFECTIVE, cap, CAP_SET);
 }
 
 static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
-				     const cap_value_t caps)
+				     const cap_value_t cap)
+{
+	_change_cap(_metadata, CAP_EFFECTIVE, cap, CAP_CLEAR);
+}
+
+static void __maybe_unused
+set_ambient_cap(struct __test_metadata *const _metadata, const cap_value_t cap)
+{
+	_change_cap(_metadata, CAP_INHERITABLE, cap, CAP_SET);
+
+	EXPECT_NE(-1, cap_set_ambient(cap, CAP_SET))
+	{
+		TH_LOG("Failed to set ambient capability %d: %s", cap,
+		       strerror(errno));
+	}
+}
+
+static void __maybe_unused clear_ambient_cap(
+	struct __test_metadata *const _metadata, const cap_value_t cap)
 {
-	_effective_cap(_metadata, caps, CAP_CLEAR);
+	EXPECT_EQ(1, cap_get_ambient(cap));
+	_change_cap(_metadata, CAP_INHERITABLE, cap, CAP_CLEAR);
+	EXPECT_EQ(0, cap_get_ambient(cap));
 }
 
 /* Receives an FD from a UNIX socket. Returns the received FD, or -errno. */
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index efcde123af1f..936cfc879f1d 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -107,8 +107,11 @@ static void setup_loopback(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, unshare(CLONE_NEWNET));
-	ASSERT_EQ(0, system("ip link set dev lo up"));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	set_ambient_cap(_metadata, CAP_NET_ADMIN);
+	ASSERT_EQ(0, system("ip link set dev lo up"));
+	clear_ambient_cap(_metadata, CAP_NET_ADMIN);
 }
 
 static bool is_restricted(const struct protocol_variant *const prot,
-- 
2.43.0


