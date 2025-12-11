Return-Path: <linux-kselftest+bounces-47411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D875FCB5EEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049313058463
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA2311C05;
	Thu, 11 Dec 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="otMlMM+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E1303A30
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457249; cv=none; b=D1FercSiFlY4rwo6jygRKLHIbBuGN5tTNqO0yNU2IJrQkyRcVU8eOOClcEWbYs04fJu1Kg7xdAD1pAaxV6A1GWLsQNelLP9WQtTLGOaSsR6EPlzhcW5RbwUrm/pAdvu8i4qq5/TVgEFl6krbHKlUFpoA11+IEnBCYIR6LpKhLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457249; c=relaxed/simple;
	bh=b+UeohnzvJw40pZRvhPeSZT8bb9n/7OIH7LnvbfILaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUyNVVFbFCmXSOfE195VD5jpBxv46HIWh+rRYyIXcH+oiPhsj8WNBex4SWCUa53ir+a+WZoBOEZaVcsc8eJS26/A6CnfeIl+cyv4L9b6CXU/S58hZeb/zFe1mOvd0DmbR+K4aUJ9aH0HkOWeHyR2bTkRZqa66dGOkiRtjlG1zLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=otMlMM+/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5C793FCA1
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765457222;
	bh=V8hzy0OifNSQ9pCWZiF7fYz+AMk1VUw+02NG8nsswDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=otMlMM+/+1MMLFY/m8HFwmwVetK7ylzwycGz7xvvYvnanZvjJObjb5EX0PDxuQPDt
	 BNc9Exepa5HRRHXpg3JHFAfh2F8hJ5AUVjJ47j6vxFt7cXlUFwvPlQ2PX4FsXyrKsZ
	 6ft20O/7SI3CCb0KOefnWdHMtinmEYqXZUaNjn30uNe9MLGyhhEc7P1HOJel9lKz1O
	 M0l4BkI/2y96dWZQDaThDn0SSBNERRTr/KsTRqeu9CZBzJLQoj4f75mpKa94OtsxmQ
	 wTtNPi9qFKU6yiY1nW0k2UxSvXwOhedklhavhPQhuP6ZVgdWkC6+TL1iHtkVXVU3vb
	 HGrVzyxBrwXkW3aM7QW+O83N3KBja0XyUXjO6aKyA8PqWFhGbfXqnPBJiaCi0RV2EG
	 DHGbdSlWhl/mlGmOM6yYk/l9s7lv60ptoj6Uyo4QtEwllKCM7yz7orlGoipDa9A+oE
	 /dskCqqviKByrhsCLmG3FSiy2rvbtI7k9WzSRapHkzcQacGUq2Q1wFDEQNN88H4B9l
	 8w3LzpI0EV+HdJJNQG0i+s0NJwCh/vj0dMEh6AmbzCGEKbctMbfAFuaD1gDrODt7pR
	 KqO3yXr/dp2NWHCpAjsYyrsVpSEI9vukNOnKTOm0ewcx8/kboiHOVsD+xRWUFadvDb
	 eJZQZ7Qj6UA0JNZIdgBFClz8=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so468655e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 04:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457203; x=1766062003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8hzy0OifNSQ9pCWZiF7fYz+AMk1VUw+02NG8nsswDQ=;
        b=rpXEHju7G3eWlItbFEgGoje3FBKbaV/SZiuq720ZpWcTjEIIJFeR6KjmvAPnzY6Kum
         2XjSGwPkyd1vYNDbS4UbgOXgsB2hh1oFqYYBgKVQppH7MpojTA5/n6kz+TBIn6YxkyAf
         SLpfPhQZFDUPevoMWUFFCbkgN+740eel71ryMlXAM7r/BK8lU/VdRew+kP5aeFjdPYZZ
         86OwBVCOhHx/f+8e9Hcddecyi78U+D3qu9AIZWIpYOw+PsWaDAlkfkzx27VHc5X2Eq0C
         i6H+MvK3czJdX0PPqb+oDvqEqrub0v0eUe5dhitcvXskmLmZsZaSGOhadZG7Gair0uPd
         RzOw==
X-Forwarded-Encrypted: i=1; AJvYcCXmGQkNThr1tGxMUF9pZtwHa6j4G5jlVLVcSIRFT+ZtWaEaAw+f7P6+bpK2BPCJE3x5YOKU/UNr8TJwCaBKx1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuakZL716wL0S3QSQgQiKSkM8GUtrRdndzI12X4M1K8sFfwNy
	elr4YXFf19/Z+DrAwLT6Z8k9DHwAOPCA7IHV591D6jI5Li4ZPAmFJo1iPZXwdlDrNFmktRvvf7C
	6RHn9+TiE2EOcoo9rccSyo0gFPAaX3mLb2VEUfEeZ9WX5XFwtcRjZn/EYv1UpqHgHY5ppyVJLB6
	q4FW63jHagJA==
X-Gm-Gg: AY/fxX7euL5a/9vo20rVvo/QzQL5lS+yC/vfb3OkkIbqZwlYhYtBvhfZxy//5lLLWhi
	WcgPXyral9nA+5l7Tfwn5tXtKsyLUoAw9hDPzdhZINakygVmM6QdRtNcRVDemTOw7fx2ngLO8fn
	kbJUWf88d0noFtmLdHO4qQFWmaWrGM0eZNhqkUtzj1/H4MSSWCJ3IrnFoL3zk9GGAMpfEqEHXD9
	V6ADarwJUhBqbQGSVcQphGabrL/ZMbkYCTfsJXmgjhN45f6A3DOzOaBEL5R1QV6l9kMFh46BLjq
	WAbn5evf1O8nJQ3XGokyV89r0YXGSDiwJVBokoI3n1n+rUk+k4bQPXJCPOHkorNlQ0Y4uEaMy2X
	mz1qYvpywLqz+Sasfz5xi7p3roeB+DEdFJRo8GKG/PQ+ouQ1IeqefVrLaCzDzH2zwtrWBK/lYJ8
	vb0t0L2puyv7z7XfKC/DSgyeQ=
X-Received: by 2002:a05:600c:3512:b0:471:21:554a with SMTP id 5b1f17b1804b1-47a83814519mr56357575e9.13.1765457203031;
        Thu, 11 Dec 2025 04:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+YNZ87WlXoAKJkxUjyMWYi8/OgaJF+UVLnKhVQzL+tkHO1XIRTcZi1teyC6sg/WSN/QxzHw==
X-Received: by 2002:a05:600c:3512:b0:471:21:554a with SMTP id 5b1f17b1804b1-47a83814519mr56357355e9.13.1765457202560;
        Thu, 11 Dec 2025 04:46:42 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf57022000e6219d5798620e30.dip0.t-ipconnect.de. [2003:cf:5702:2000:e621:9d57:9862:e30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f0d6f2sm32075905e9.13.2025.12.11.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:46:42 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v3 7/7] tools/testing/selftests/seccomp: test nested listeners
Date: Thu, 11 Dec 2025 13:46:11 +0100
Message-ID: <20251211124614.161900-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add some basic tests for nested listeners.

Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 303 ++++++++++++++++++
 1 file changed, 303 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..bbf3ef58ad07 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -301,6 +301,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS (1UL << 6)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -4416,6 +4420,305 @@ TEST(user_notification_sync)
 	ASSERT_EQ(status, 0);
 }
 
+/*
+ * This test is here to ensure that seccomp() behavior before
+ * introducing nested listeners is preserved.
+ */
+TEST(user_notification_many_ret_notif_old_behavior)
+{
+	pid_t pid, ppid;
+	long ret;
+	int status, listener;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	/* Install a filter that returns SECCOMP_RET_USER_NOTIF, but has no listener. */
+	ASSERT_GE(user_notif_syscall(__NR_getppid, 0), 0);
+
+	/* Install a filter that returns SECCOMP_RET_USER_NOTIF, and then close listener. */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+	close(listener);
+
+	/*
+	 * Note, that we can install another listener now (without nesting enabled!),
+	 * because notify fd of the previous filter has been closed.
+	 */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	ppid = getpid();
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret != ppid);
+	}
+
+	memset(&req, 0, sizeof(req));
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+	memset(&resp, 0, sizeof(resp));
+	resp.id = req.id;
+
+	/* tell kernel to continue syscall and expect that upper-level filters are ignored */
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
+TEST(user_notification_many_ret_notif_closed_listener_nested)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, closed_listener;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	closed_listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+	ASSERT_GE(closed_listener, 0);
+
+	/*
+	 * Note, that we can install another listener now (without nesting enabled!),
+	 * because notify fd of the previous filter has been closed.
+	 */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Now, once we installed a nested listener, close the previous one. */
+	close(closed_listener);
+
+	/* Add some no-op filters for grins. */
+	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret >= 0 || errno != ENOSYS);
+	}
+
+	memset(&req, 0, sizeof(req));
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+	memset(&resp, 0, sizeof(resp));
+	resp.id = req.id;
+
+	/*
+	 * Tell kernel to continue syscall and expect ENOSYS,
+	 * because upper filter's notify fd has been closed.
+	 */
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
+/*
+ * Ensure that EBUSY is returned on attempt to
+ * install a nested listener without nesting being allowed.
+ */
+TEST(user_notification_nested_limits)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[8];
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Install 6 levels of listeners and allow nesting. */
+	for (i = 0; i < 6; i++) {
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	/* Check behavior when nesting is not allowed. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		/* Install a next listener in the chain without nesting allowed. */
+		listeners[6] = user_notif_syscall(__NR_getppid,
+						 SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listeners[6] < 0)
+			exit(1);
+
+		/* Add some no-op filters for grins. */
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog);
+		if (ret != 0)
+			exit(2);
+
+		ret = user_notif_syscall(__NR_getppid,
+					 SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		/* Installing a next listener in the chain should result in EBUSY. */
+		exit((ret >= 0 || errno != EBUSY) ? 3 : 0);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST(user_notification_nested)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[6];
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Install 6 levels of listeners and allow nesting. */
+	for (i = 0; i < 6; i++) {
+		/*
+		 * Install a filter that returns SECCOMP_RET_USER_NOTIF, but has no listener.
+		 * We expect that these filters are not affecting the end result.
+		 */
+		ASSERT_GE(user_notif_syscall(__NR_getppid, 0), 0);
+
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret != (USER_NOTIF_MAGIC-3));
+	}
+
+	/*
+	 * We want to have the following picture:
+	 *
+	 * | Listener level (i) | Listener decision |
+	 * |--------------------|-------------------|
+	 * |	     0		|      WHATEVER     |
+	 * |	     1		|      WHATEVER     |
+	 * |	     2		|      WHATEVER     |
+	 * |	     3		|       RETURN      | <-- stop here
+	 * |	     4		|  CONTINUE SYSCALL |
+	 * |	     5		|  CONTINUE SYSCALL | <- start here (current->seccomp.filter)
+	 *
+	 * First listener who receives a notification is level 5, then 4,
+	 * then we expect to stop on level 3 and return from syscall with
+	 * (USER_NOTIF_MAGIC - 3) return value.
+	 */
+	for (i = 6 - 1; i >= 3; i--) {
+		memset(&req, 0, sizeof(req));
+		EXPECT_EQ(ioctl(listeners[i], SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+		EXPECT_EQ(req.pid, pid);
+		EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+		memset(&resp, 0, sizeof(resp));
+		resp.id = req.id;
+
+		if (i == 5 || i == 4) {
+			resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+		} else {
+			resp.error = 0;
+			resp.val = USER_NOTIF_MAGIC - i;
+		}
+
+		EXPECT_EQ(ioctl(listeners[i], SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	for (i = 0; i < 6; i++)
+		close(listeners[i]);
+}
 
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
-- 
2.43.0


