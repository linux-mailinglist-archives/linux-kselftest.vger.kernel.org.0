Return-Path: <linux-kselftest+bounces-46876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C8C9B61D
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217E94E4180
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED83148B3;
	Tue,  2 Dec 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QQyT8RlG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24E313551
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676352; cv=none; b=BMCp8k+yxbcOJD90Nth6ai6FZi6GE4UwFGHuErHLaQYWsQbkC1KIoHOWvQjpp1y+TGt+2Tz+SGLPKTYlmtEs9YWoUczihIjMaYeKmtxiPK/lZ+6I7Pv+KO4FHTvpxNCAcPdUlve0y5iEncbLWnpa8GLtAIOA88KvgOqrA3Chal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676352; c=relaxed/simple;
	bh=8zxbYHTC/vFoDDVlLNN1L+clSwYxFA+WMrxYCr2Ewcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmOTjQvpMjXEZwvt6qhC/AcWnt82puLXZhMbZ+O0rN+3M4nsBV2Xgu85wUX9w4Daf/ENC2FTciWUnk2GYWe1HIk2dwouLP489tow9S96ujB5uxsgtepyB2ByThaPWyFO9+W3K4egY5fsDn6FVHLRZK8C4JTNIQtNZvgx3ex8iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QQyT8RlG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F34FD4031F
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676346;
	bh=cwVszfkAi2lPLgwK1Qc8I2xQFtjDa28JTJArXKCEz6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=QQyT8RlG/aPz27wFa1hRr+84Mfd5ckdR5J5z0NYcPfgoaNtMSeOeM4xddpvdvVpS8
	 M5Ckx5j07ycmyep86WRj13oluAmm28i4t8gREJevjCTdZDQ90CLdBRyG87iIX9JFxY
	 zVS3UjpcYPvFDcnvKcSvKX7rdu5Ijg6E4RfyQtyaPKTZ4uxHrEiRtPQN5J7qQVCgOJ
	 MnBS+9hpyz1rxmtOaZUgo7HUKz0IcKBtzFFXnDSFp2IAFLa8RHXTsT8bKIJRW+V0T9
	 GipMunUanHdd2KpPbws8/RhUadfgZec+G/ghiFTT51tMY1O531KEEwKeAvISojn8K6
	 /W7fVgEy5Rxds25oZtHGzGBNk0UtoZSvrOOWnvIIFIMPjcP2h7YUlk1Xb/CkGU1rWO
	 A9pdnaQoHp96uA9NC2vPF40zGE55OL+/ARafkr4dYOQdXJgcI1EkMmQ6u7UwZFG/yb
	 16w9wXI/luOLLZAywpZpV+KoYSI3xNBrDgJUoj1XxxLot6R3ggnLBAnHjsoORbIt7w
	 oGBslycNSoYeouANEVI8g+Piyqe3p74yZcKpBwUsNYDgvgq/WtItLtO18LaxlMHfR+
	 t1I6G0HtQkTkZrdNfsik+R6jaqI4cVkLoR5oKXlixksr0EU53+K7MQyTbz6nsQR0Zg
	 QV6OzyqxvQCLdd9MKhHJbBB0=
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6409f6d6800so8621606a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 03:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676341; x=1765281141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwVszfkAi2lPLgwK1Qc8I2xQFtjDa28JTJArXKCEz6A=;
        b=EuMydoQOFoPpDl9IgwZaBxysQi0eSJA+A/QMU06vvpnOgaE3FfzEC9hfaKWy+sZkbg
         5Dxr1uYl7Rp/3o5Mcom9Oh2Jh0N5+1u9ifafL3S5lNfdgZvn5aN1Hj74LQArSUAXGoBn
         5qOq7h7Y75DHJ1VyVE0zXjCuDYG9l7+OqZ0SYSC55lWlDYdocVVuXWonMyUXu9miZBLl
         avW3iSDSJDIAYoKNI4iGv5U6bqj6VIgvr4driKmxvjI0vy3kmyhpGcNq96k+y4/CNUnW
         emGrk3an2c9e9smexnZ8cbNZ16LTKph5d8N79GjTee8nAwYJdWSU0ejROJWnXHJOVXIt
         g8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUdbY8R/s/4JgNFxCdl7jH03omeZhpFhqWWgOGu1aup8/5z1xTbpZAI6Z/Vsh/zeAQM8mRqs6hRZynu2ANoY6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxemw3OexANn4GKpllOLtRThb33mlfSyV2Bp1vb8p7jIDu0yTOH
	tuEeoVfisRjX6v+Lbn4leFACd67gN9L8dh6o3HOlaIxbeGnekErh7r/NqFHqchvIrUYA53prmgp
	3iiOvqPa8Y05EqjiQUjGhDdmxSz9wdodUndBgi+8+H4hRZhuoWAbRvXyyUo/auQqQWmJzF+ZUiz
	LOKYeKgLwNWQ==
X-Gm-Gg: ASbGncuTkzozy6tiM3JOqYumcyZx2aZpF4m2KdKRx7Tk6PG9mu8HLLNrt6i7gonVGny
	FQ05Id7zyK1YvChiE9TmDihhNRTF84INEHbAmOUuHqGngAEg30VaLhq52AoUjRYyXWkP22OuqNT
	dX+73ZYSTq0sQpHlaKFKACHMsP3Wu2kYHJn+bmmt4JdhBJ/HJM856Yrh1aYME1Q24nMEwzcl2iT
	fuZaErFvc0ciHB7kStvWQwQeAGFxpvSrNIGhAJ3i457pdkpaQph7MtXf3y9BZ/5aaVX+IRY0a6L
	uKdKPxi5DNY6WD6Xtupq19Kqf5g70/F4XNrnKalqmIG/wo75bI55MG59yFD+0Rl2g7xCb/aGsiB
	LxLf2IdfgpjEgTsyI2XxJhdok/5TrzXo6aWyw4dP0CqkQ7Gxz3AfPtbklPM7gpvKMKWnS+HOk+L
	ZZ0t9kOMmJ6TASvnWpvupJxV8=
X-Received: by 2002:a05:6402:358b:b0:643:ab7:2e7b with SMTP id 4fb4d7f45d1cf-645559f9dd0mr38694725a12.0.1764676341136;
        Tue, 02 Dec 2025 03:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNMdUcbKmi/gMtf98cLSdMWXvArBVuk0t5kodbo3nTcLBM5sFT8yTGpmgTFvPpZdtsAj5W6Q==
X-Received: by 2002:a05:6402:358b:b0:643:ab7:2e7b with SMTP id 4fb4d7f45d1cf-645559f9dd0mr38694702a12.0.1764676340740;
        Tue, 02 Dec 2025 03:52:20 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:20 -0800 (PST)
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
Subject: [PATCH v2 6/6] tools/testing/selftests/seccomp: test nested listeners
Date: Tue,  2 Dec 2025 12:51:58 +0100
Message-ID: <20251202115200.110646-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index fc4910d35342..0bf02d04fe15 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -293,6 +293,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS
+#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS (1UL << 6)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -4408,6 +4412,164 @@ TEST(user_notification_sync)
 	ASSERT_EQ(status, 0);
 }
 
+/* from kernel/seccomp.c */
+#define MAX_LISTENERS_PER_PATH 8
+
+TEST(user_notification_nested_limits)
+{
+	pid_t pid;
+	long ret;
+	int i, status, listeners[MAX_LISTENERS_PER_PATH];
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
+
+	/* Install more filters with listeners to reach nesting levels limit. */
+	for (; i < MAX_LISTENERS_PER_PATH; i++) {
+		listeners[i] = user_notif_syscall(__NR_getppid,
+						  SECCOMP_FILTER_FLAG_NEW_LISTENER |
+						  SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS);
+		ASSERT_GE(listeners[i], 0);
+
+		/* Add some no-op filters for grins. */
+		EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
+	}
+
+	/* Installing a next listener in the chain should result in ELOOP. */
+	EXPECT_EQ(user_notif_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER),
+		  -1);
+	EXPECT_EQ(errno, ELOOP);
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


