Return-Path: <linux-kselftest+bounces-37631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04CB0AFFC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE43B4A0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAC2877CD;
	Sat, 19 Jul 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK/GsN5d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E32874EA;
	Sat, 19 Jul 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928894; cv=none; b=VXn+xcKQ5vdMGD3eEPWhYxyicuU1YcZCuj8nzbJ9NvWe6cGXljI1KPujAKtKesbd8oBojCBqhT5mMcSsW7UG82MOa0OjKRDL3U97Tm/bUxAynf1lSht1cFkHS/uNWOkEnpwoqpNhoiZgCo8zeg0FoJssNRV55okoflEjYgz8WtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928894; c=relaxed/simple;
	bh=qO3QxPss+Ez6xIoDiDgrczAiXZ6fDnwcU1lYnvb8G1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnHMa7v3JWhEXWIbsaYCfp0l039b/uaZpMMAefaet47dr1xQvBLIFPxIKOeogy86TMPc6w3nhFnRaj+K3PPj54I1O7aeCl6jlT1o4eb2h8jEHXrqMSx4reia1XrybmmD1hTl11GVZ2qZuUOqoCLFFUxK1mVsznwvMV1GMKT+Ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK/GsN5d; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1906437a12.2;
        Sat, 19 Jul 2025 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928891; x=1753533691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryY05QWgY0BpbA6XnF96jvKEPsrBSeX6x+oxWgmAkOs=;
        b=CK/GsN5dfRi8S3QgEP/jc0hOLogfqxK2uDqb9fVbFAtmDb6WevUetfVAq805PWPw3I
         RZCD1ry8/rL2m8YYltFRuX/822geatSVBzrFkJH1SsTQMxzcsLWTcw7+GC7PyARe3sNA
         16kvR8QlaE6+Leyl5O0LYwR+1A/HuiuUD7J/4W+NcXyBxYKzVmWsCQy4nMdSat7bsAfA
         eS102F48vBITCcB3BseQf0rYx9GVNaGRBFPbcijOihOT/tCAZ/8QM5lgspoG/+tAtzrc
         sXjDxSEaEZ8rhL1/gskmMUkHDcbiBYMFskOMoCblFc323vQiPcyNarH6GpzggZCGjh06
         cxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928891; x=1753533691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryY05QWgY0BpbA6XnF96jvKEPsrBSeX6x+oxWgmAkOs=;
        b=hIoAYdNDRHCSBRdw/apTIlQ1HbT5dJKNDTf5qYkilfbxze9fn+qSUgxq2NxFSXaT5o
         1Q0EnohO15mcUNZVhithOJ8DFbUJkxFt4Bv4AMw8eHJCaUHqoB/bACQTFyDTUV19ogED
         faAPIdCglttYN4PdbE+ZjAkA2ODjxpv/CDaREr8uzeP69R1RjWpfaUZzDIDZSOsArOue
         vDcoqPFRnBKuxFQAaVz4fAx2+l9P/outciGpSAd7C+k4JJtVNlaCv7uKXclZ29aIbGvS
         QVqq3KZhj482umihDsWkBLiiEhGN3WR1ne8s2zBIpX+5DWfrNOM2QkJVDhHSgtKYcTbw
         PDMw==
X-Forwarded-Encrypted: i=1; AJvYcCVLbp66y1sH+N7GxgPe1YClCPTFrHGj8JkRnaMcECDoUhfm7km/guLlbR7xf929ZKThypRRQzVypR2qdKo=@vger.kernel.org, AJvYcCW/VRHGmWtNKonv4BsqAEnuGtI3OC9Y2T3wSQcrvIsDIaLBcWB8lsxtjeXRyLL4GoBdtRjUpfdsytLr6LLXmA2k@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuzGyv79b0Di4Uu4iZQ/Z94q59WEbRWc+nHx1335pMaOF03Tn
	UYeShWs2TqbmRI9LcHjky4aiZLbC7Z9Z5kKIl7KR2/YkKPLX8UO7JA1qMGDebWYKoK0=
X-Gm-Gg: ASbGncv/Yi0emMOF8rK8SGcn6FB8wrKPevM4f0e75QGjOyhRCqG3o344MvUK31SK02v
	Dj5zIjRFE9fE5YQgEjwm8yjROsPlHPThe4BFX/yLmuGMQQavSqJ/esxgZ++/eVg30mb7kG+f/qC
	o3w6lrTPT0T2Lr/dxbtpk+r6A4kWlN5rAVVJgvR73NLIVaI+t6OAJRM8/qowztKXIwm2r0qoGw2
	LKl7fq0HHnzwi+LkWshn5TpzjDT/PehGkdPe+aXkYtjbQzEOQ0QNeQBWxQME39iWGz8RqdTq3O1
	4DeWuSalYAGDg2IvLaQCQyTkAWNE8/ji+8buENZb4QqaiEfRaYBQ5t0tCqaPQfg5EjgcoJS1qam
	l4aV7agM+O05LhdZ6vGtE
X-Google-Smtp-Source: AGHT+IHYuAxOrMgO/Wpm79sqhhVsbWC416DCFuuEjxJq8fq/Lg1VX5N6WHG0lsCXCnA1XfV2hDtCwg==
X-Received: by 2002:a17:903:3b8b:b0:234:d679:72e3 with SMTP id d9443c01a7336-23e24f59dbfmr194060805ad.42.1752928891045;
        Sat, 19 Jul 2025 05:41:31 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b36sm28630285ad.92.2025.07.19.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:41:30 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 06:41:26 -0600
Subject: [PATCH RFC 3/3] selftests/landlock: add cross-domain signal tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-landlock_abstractions-v1-3-2c4fd61f8973@gmail.com>
References: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
In-Reply-To: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752928886; l=8891;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=qO3QxPss+Ez6xIoDiDgrczAiXZ6fDnwcU1lYnvb8G1k=;
 b=+RxX9CTwk3BxNj4tjinZT8HNGYy8ZuS4HWwl/bwj7taZWoKrYxZdzmloBZhokScfRz/hwGmn8
 W6fRce7JUCrB9lhK2Ze+fdsKfvUlKNfZRmkTizVkFGC9XobrXWBOZRA
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add cross_domain_signal test using the new cross-domain variants to
validate signal delivery between independent peer domains. This fills
a gap in current test coverage which only exercises hierarchical
domain relationships.

The test creates a fork tree where both children call
landlock_restrict_self() for the first time, ensuring their
domain->parent pointers are NULL and creating true peer domains:

    coordinator (no domain)
    |
    +-- resource_proc (Domain X) /* owns the resource */
    |
    +-- accessor_proc (Domain Y) /* tries to access */

Tests verify that kill(SIGUSR1) behaves correctly across all four
domain combinations, with scoped accessors properly denied (-EPERM)
when attempting cross-domain signal delivery.

This establishes the resource-accessor test pattern for future scope
types where Landlock restrictions apply only to the accessor side.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../selftests/landlock/scoped_signal_test.c        | 237 +++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..b52eaf1f3c0a 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -559,4 +559,241 @@ TEST_F(fown, sigurg_socket)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+FIXTURE(cross_domain_scope)
+{
+	int coordinator_to_resource_pipe[2]; /* coordinator -> resource sync */
+	int coordinator_to_accessor_pipe[2]; /* coordinator -> accessor sync */
+	int result_pipe[2]; /* accessor -> coordinator result */
+	pid_t resource_pid; /* Domain X process */
+	pid_t accessor_pid; /* Domain Y process */
+};
+
+/* Include the cross-domain variants */
+#include "scoped_cross_domain_variants.h"
+
+FIXTURE_SETUP(cross_domain_scope)
+{
+	drop_caps(_metadata);
+	/* Create communication channels */
+	ASSERT_EQ(0, pipe2(self->coordinator_to_resource_pipe, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(self->coordinator_to_accessor_pipe, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(self->result_pipe, O_CLOEXEC));
+
+	signal_received = 0; /* Reset for each test */
+	self->resource_pid = -1;
+	self->accessor_pid = -1;
+}
+
+FIXTURE_TEARDOWN(cross_domain_scope)
+{
+	close(self->coordinator_to_resource_pipe[0]);
+	close(self->coordinator_to_resource_pipe[1]);
+	close(self->coordinator_to_accessor_pipe[0]);
+	close(self->coordinator_to_accessor_pipe[1]);
+	close(self->result_pipe[0]);
+	close(self->result_pipe[1]);
+}
+
+static void cross_domain_signal_handler(int sig)
+{
+	if (sig == SIGUSR1 || sig == SIGURG)
+		signal_received = 1;
+	else if (sig == SIGALRM)
+		signal_received = 2; /* Alarm timeout */
+}
+
+/*
+ * Maybe this should go into common.h or scoped_common.h so that
+ * we can perhaps test interactions b/w different types of sanboxes
+ */
+static void create_independent_domain(struct __test_metadata *_metadata,
+				      enum sandbox_type domain_type,
+				      const char *process_role)
+{
+	if (domain_type == SCOPE_SANDBOX) {
+		/*
+		 * This is the critical call - first landlock_restrict_self()
+		 * ensures domain->parent == NULL, creating true peer domains
+		 */
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+	}
+}
+
+TEST_F(cross_domain_scope, cross_domain_signal)
+{
+	enum sandbox_type resource_domain = variant->resource_domain;
+	enum sandbox_type accessor_domain = variant->accessor_domain;
+
+	TH_LOG("Resource domain: %s",
+	       resource_domain == NO_SANDBOX ? "unrestricted" : "scoped");
+	TH_LOG("Accessor domain: %s",
+	       accessor_domain == NO_SANDBOX ? "unrestricted" : "scoped");
+	/*
+	 * Fork tree:
+	 * coordinator (no domain)
+	 * ├── resource_proc (Domain X)
+	 * └── accessor_proc (Domain Y)
+	 */
+
+	/* === RESOURCE PROCESS (Domain X) === */
+	self->resource_pid = fork();
+	ASSERT_GE(self->resource_pid, 0);
+
+	if (self->resource_pid == 0) {
+		/* Close unused pipe ends */
+
+		/* Don't write to coordinator */
+		close(self->coordinator_to_resource_pipe[1]);
+		/* Don't read accessor pipe */
+		close(self->coordinator_to_accessor_pipe[0]);
+		/* Don't write accessor pipe */
+		close(self->coordinator_to_accessor_pipe[1]);
+		close(self->result_pipe[0]); /* Don't read results */
+		close(self->result_pipe[1]); /* Don't write results */
+
+		/* Create independent domain */
+		create_independent_domain(_metadata, resource_domain,
+					  "RESOURCE");
+
+		/* Install signal handler */
+		struct sigaction sa = {
+			.sa_handler = cross_domain_signal_handler,
+			.sa_flags = SA_RESTART
+		};
+
+		sigemptyset(&sa.sa_mask);
+		ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
+		ASSERT_EQ(0, sigaction(SIGALRM, &sa, NULL));
+
+		/* Wait for coordinator signal to start */
+		char sync_byte;
+		ssize_t ret = read(self->coordinator_to_resource_pipe[0],
+				   &sync_byte, 1);
+		ASSERT_EQ(1, ret);
+		close(self->coordinator_to_resource_pipe[0]);
+
+		/* Set timeout and wait for signal */
+		alarm(3);
+		pause();
+
+		/*
+		 * Exit based on what signal was received
+		 * 0=success, 1=timeout/failure
+		 */
+		_exit(signal_received == 1 ? 0 : 1);
+	}
+
+	/* === ACCESSOR PROCESS (Domain Y) === */
+	self->accessor_pid = fork();
+	ASSERT_GE(self->accessor_pid, 0);
+
+	if (self->accessor_pid == 0) {
+		/* Close unused pipe ends */
+
+		/* Don't read resource pipe */
+		close(self->coordinator_to_resource_pipe[0]);
+		/* Don't write resource pipe */
+		close(self->coordinator_to_resource_pipe[1]);
+		/* Don't write to coordinator */
+		close(self->coordinator_to_accessor_pipe[1]);
+		close(self->result_pipe[0]); /* Don't read results */
+
+		create_independent_domain(_metadata, accessor_domain,
+					  "ACCESSOR");
+
+		/* Wait for coordinator to signal start */
+		char sync_byte;
+		ssize_t ret = read(self->coordinator_to_accessor_pipe[0],
+				   &sync_byte, 1);
+		ASSERT_EQ(1, ret);
+		close(self->coordinator_to_accessor_pipe[0]);
+
+		/* 200ms delay to ensure resource is in pause() */
+		usleep(200000);
+
+		/* Attempt cross-domain signal - this is the core test */
+		int kill_result = kill(self->resource_pid, SIGUSR1);
+		int kill_errno = errno;
+
+		/* Send results back to coordinator */
+		struct {
+			int result;
+			int error;
+		} test_result = { kill_result, kill_errno };
+
+		ret = write(self->result_pipe[1], &test_result,
+			    sizeof(test_result));
+		ASSERT_EQ(sizeof(test_result), ret);
+		close(self->result_pipe[1]);
+
+		_exit(0);
+	}
+
+	/* === COORDINATOR PROCESS (No domain) === */
+
+	/* Close unused pipe ends */
+	close(self->coordinator_to_resource_pipe[0]); /* Don't read from resource */
+	close(self->coordinator_to_accessor_pipe[0]); /* Don't read from accessor */
+	close(self->result_pipe[1]); /* Don't write results */
+
+	/* Give processes time to set up domains */
+	usleep(100000); /* 100ms */
+
+	/* Signal both processes to start the test */
+	char go_signal = '1';
+
+	ASSERT_EQ(1,
+		  write(self->coordinator_to_resource_pipe[1], &go_signal, 1));
+
+	ASSERT_EQ(1,
+		  write(self->coordinator_to_accessor_pipe[1], &go_signal, 1));
+
+	close(self->coordinator_to_resource_pipe[1]);
+	close(self->coordinator_to_accessor_pipe[1]);
+
+	/* Collect accessor results */
+	struct {
+		int result;
+		int error;
+	} test_result;
+
+	ssize_t ret =
+		read(self->result_pipe[0], &test_result, sizeof(test_result));
+	ASSERT_EQ(sizeof(test_result), ret);
+	close(self->result_pipe[0]);
+
+	/* Wait for both processes to complete */
+	int accessor_status, resource_status;
+
+	/* Accessor should always exit cleanly */
+	ASSERT_EQ(self->accessor_pid,
+		  waitpid(self->accessor_pid, &accessor_status, 0));
+
+	ASSERT_EQ(self->resource_pid,
+		  waitpid(self->resource_pid, &resource_status, 0));
+
+	EXPECT_EQ(0, WEXITSTATUS(accessor_status));
+	/* Determine expected behavior based on your table */
+	bool should_succeed = (accessor_domain == NO_SANDBOX);
+
+	if (should_succeed) {
+		/* Signal should succeed across domains */
+		EXPECT_EQ(0, test_result.result); /* kill() succeeds */
+		/* resource receives signal */
+		EXPECT_EQ(0, WEXITSTATUS(resource_status));
+	} else {
+		/* Signal should be blocked by cross-domain isolation */
+		EXPECT_EQ(-1, test_result.result); /* kill() fails */
+		EXPECT_EQ(EPERM, test_result.error); /* with EPERM */
+		/* resource times out */
+		EXPECT_NE(0, WEXITSTATUS(resource_status));
+	}
+}
+
+/* Test for socket-based signals (SIGURG) across independent domains */
+TEST_F(cross_domain_scope, DISABLED_file_signal_cross_domain)
+{
+	SKIP(return, "Skip for now");
+}
+
 TEST_HARNESS_MAIN

-- 
2.43.0


