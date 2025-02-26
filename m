Return-Path: <linux-kselftest+bounces-27561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24401A45577
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1BE3ADD3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE7268FC8;
	Wed, 26 Feb 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOMm0TxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99417266F07;
	Wed, 26 Feb 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550753; cv=none; b=G56dLtjA4B0L/QMF66aKrWA6UWB52bUfmo/2n5vEzIDngi9zNsQOplsJc3MNC8sfqMc8wGJZRrKvzxovixUpZQaMyErwtvFS7iHNQNhJsJznsmubaHZ/ByeY8QexLeeLvwYBbTnK33ceJWnc4JFG76PC590BlJCT9/Ub6d1ljss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550753; c=relaxed/simple;
	bh=yIj1pQj0C3AN7gwtkMH3z56V1irEizXLsEKGmF8Vx60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExCEoh1+/hXkvWU7MkYqq3LnRji+vCk1JJWNTvpe+cgxK3O6zZtuudGcEiHyneetV4uCJPF1Gg/hZGP9NpgFStBeaay3i8vRFZZNJeLPmyM4kI52vHGD+agZjmOxin1yJplV2/QvRnlNLGJewsaISIRLDsKrD1ru9Uy09n94NpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOMm0TxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D6C4CED6;
	Wed, 26 Feb 2025 06:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550753;
	bh=yIj1pQj0C3AN7gwtkMH3z56V1irEizXLsEKGmF8Vx60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOMm0TxGnl1PdY8iEYhNAvpsm0KO60mG+sQYqMKeFRT9NfJvCLU6ElhjBNiaw+Sv5
	 P5XlcZHAN4DDnLr1eY1npddfQ+aVqGXcSSSay0Jf6uLwtJ4CoTujVQkfZPhmFUOmbV
	 i6WC7p1dVzhln4DeJpOFfG7fdZyz6j86wPlAd8zRcZ1FD/GngRMh5z95LA+miNIEKi
	 T9o92Ul1xstabFgausqlfSWtGEujrq8GGa+jeFifwpLtSplsSn5DKmNBCFkyA4idPC
	 lZKwztFjzqf90HkxfGKMQ5bByJW8NHSf2Hrq2NijiTiS1r6kUaD2BVM7UW8adKHQsG
	 rKf7lu7f0iThw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/8] tracing: probe-events: Log errro for exceeding the number of arguments
Date: Wed, 26 Feb 2025 15:19:10 +0900
Message-ID:  <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
References:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add error message when the number of arguments exceeeds the limitation.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    2 ++
 kernel/trace/trace_fprobe.c |    5 ++++-
 kernel/trace/trace_kprobe.c |    5 ++++-
 kernel/trace/trace_probe.h  |    1 +
 kernel/trace/trace_uprobe.c |    9 +++++++--
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 82fd637cfc19..af9fa0632b57 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -913,6 +913,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (argc - 2 > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		ret = -E2BIG;
 		goto error;
 	}
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index e27305d31fc5..372936163c21 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1201,8 +1201,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS)
+	if (argc > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d8d5f18a141a..8287b175667f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1007,8 +1007,11 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS)
+	if (argc > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c47ca002347a..6075afc8ea67 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -546,6 +546,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
+	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
 
 #undef C
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ccc762fbb69c..3386439ec9f6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -562,8 +562,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	if (argc < 2)
 		return -ECANCELED;
-	if (argc - 2 > MAX_TRACE_ARGS)
+
+	trace_probe_log_init("trace_uprobe", argc, argv);
+
+	if (argc - 2 > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	if (argv[0][1] == ':')
 		event = &argv[0][2];
@@ -582,7 +588,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		return -ECANCELED;
 	}
 
-	trace_probe_log_init("trace_uprobe", argc, argv);
 	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
 
 	*arg++ = '\0';


