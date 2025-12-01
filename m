Return-Path: <linux-kselftest+bounces-46800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06844C973D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B1343C7E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677C30C36C;
	Mon,  1 Dec 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="BqfEk6CM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5A30C361
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591879; cv=none; b=aUDw3N9NiJuC04/oOTaKJdvUXOWPeMSB19TUxjkfPetjXZ13xluRXwBKcSv5A7MSkWiTdjZjp84ziXTuEzXr8n+BLioyFPWzqPevjI1Lv3yo6hIWO0bqlM5VMxRB9LCx2QmLGps1sR2A2IMWFLIuornD9lpCLkT0KEL9ZBNW214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591879; c=relaxed/simple;
	bh=Egmsxd6WhuG+1aHGJA9zA7ap31AaU5FP48jyqfW36E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXDK9aw6PN2ihEmxz/LXU3BAG+RiM8cSv4hWR+uyiFvW0vKmKM4CeToUhuHitxI4vLCTGSeaGqnj0hOyiDXyUVTgNY/Y2CWkt5LXtVUlQOjAHPP5AdQpveHcj2RfeZNLcFHLSFFGUpQ1/5p3Slvm528GX1e13UceMUZkOk6DGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=BqfEk6CM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BCC03F2BB
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591873;
	bh=jXkgsidXiBaEN+Xes2JcR3minQELMlukrfJCybCFbvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=BqfEk6CMt6hTFO4CFIKt5G9iJLJKJtI84QQwa9rN7P4lGSg9UpGbiN2KTeB8ufvyg
	 heEja8gOv8MMV7/ObLWYluvWl3iu8bzzycGBjVcgwWJZf2S2/E1xtTM6B+XLoTXidX
	 E/9fdKWBTlK1blRRc7p09GrjdvnoFbvSEHY6VM9cJ5/AjITyKE1XnU+ADgDUQ00AcS
	 RVXKdXn2fXppY96OrVjLBOGx1DO+aN4yQerroP6rwbUMtl/PKhU6NPFB0LLwRQIYYs
	 alK3vDjhgEtjQFPGhN8k+IpwhTSBwHfE7Ja1RjKKAJRQPhDQg252FqreGsbSnWGU2d
	 adIcvM+Z1wedy3H5Rs68zDTIJHhm4PHDFqzBbaPKkYR9LXZLBrWH0kFsQ/GnMcpu0a
	 Fr3RvmymRlC3jV+n3aR9PtwDg1QN0AwVXzfp2af5qft+kiC5k6nR1ru3T7P2Ku54QI
	 Zf+kzFCwD6OySHNRG/FAz4baRF1uh5usvIOn7yDu6LYQoU0JCGNmbhHWFha2YQKrth
	 eQfa4z5ZitCWDSpLnEsQZ4MDInOeoEhJalQRPJGgrnwPUIHu/Q5iSx8gHmrpscFrPm
	 jhlDmaN14NBNtEswNjlAW9ppgurMxO959NtuBpjjsoNRiX9rMIvr4Ry2VylKZ9EDzH
	 EeQzgZPRE+H1ZiZfREH1eDVc=
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6409cea8137so9825127a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 04:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591869; x=1765196669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXkgsidXiBaEN+Xes2JcR3minQELMlukrfJCybCFbvk=;
        b=U8+peo8QkdF8Mo04ITPjKaJS4qF+wnRA7343mYRrqBp8pDVR8rlNQqKpGpUBCwqvI8
         y/ifp1VqQjkKuXuYuHnapdMqGs2nZCYG8INTrKb4uvXASlOF2TvPu+jZw5JJGzzprfnm
         pgGy7VAwj8dTJpxEl/HCJ1xJQaa0bSFT3MNO5sGcECpLV53hbxi9L64aBzHhH+Ihuhp4
         Oxbz+j2ayWSdP/JotptGh4Z6s/UebfJOI63jLhYoNKqIezFqNFUJVwOLUuOAzkFKk10h
         eJWTbA7hF7CbGmhmbpcsEPWwbzxWc8cRcleOsKjEPfi4bwdFbjkXyS8NBPqc9Gbp0zdc
         desQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+pHLlyNXlx66s833eiR7jtOX1ciu8OnZcfO+ECVvWxZ2FYm3hA1uhkJuPiudELHUKSdhv9zWHFrrE/ye+ONg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznScbVCuMmAf9hzczZlJIfbJ/kKXizNgYHv2T+E7CNlWZCG8sN
	cWLSm/Rrg95E3v/E4XuQBe90WXlfSa7oEllIIBt6l2yqwFZFkNs2IWpFqr1B1djLPxJshRjFVfA
	KLzk+670I77W4S95N8KSZ77PSUkOBhBksjlQPISLPj7a5Z0L8WQ2f8/DPUNeZtyHi3KE8T++1WO
	OMkeEzk/yplw==
X-Gm-Gg: ASbGncuQyOENirwfHBoXSh8eN8l+8ZJGF0lleYRG5gbyqMYlwVUxb8e/jFDPpHcTLGl
	OkrFUQ7xSi+jC9jKdkUlPFLSjUvbYCQkypKVxYM0aCwBPrEYHp04Em9++s+ktql181qpvIpSH6u
	GdCdpOXQmrNhQM4/ueH2unyxESkt8Iwq9WEMQz+cjMhkqF8hdtxEbg0J6+XUzbKLgVu79B2zKX/
	pBHAC3wXEaRHP1zDbFery8QW8FJYJlZvTnhCSjFQOzIhkNmSs0kdppa0T7FiE6FR9cNJEhg8jrw
	C8uq4l9IiaMFKMjGEYNTFUiG+e4F0x8lf0ZFgHQ3ODZlkn44mZ9cd6GfqPFaTm+PjcdbZKeiA8p
	tgCAUb+Ar0kOfHXQ+P1/FAfoY6rHrFfyIo8LeCsMQllbQYvaNhO5qziOo+V2mLtSlR/9vxrXwBo
	tJzbYVhLdgPeKYlY5BWUBbLTvi
X-Received: by 2002:a05:6402:1d99:b0:641:9fdf:db43 with SMTP id 4fb4d7f45d1cf-6453962404bmr25196726a12.1.1764591868640;
        Mon, 01 Dec 2025 04:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdhwkAnp1agnhNL0XBFl1gCYXlLEElnXUghnsShlPPM9wQcvadSq0QTq7MjxtDqhOFO0U7dQ==
X-Received: by 2002:a05:6402:1d99:b0:641:9fdf:db43 with SMTP id 4fb4d7f45d1cf-6453962404bmr25196706a12.1.1764591868199;
        Mon, 01 Dec 2025 04:24:28 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:27 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 6/6] tools/testing/selftests/seccomp: test nested listeners
Date: Mon,  1 Dec 2025 13:24:03 +0100
Message-ID: <20251201122406.105045-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
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


