Return-Path: <linux-kselftest+bounces-5420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF4866900
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5291C2346E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10019BCA;
	Mon, 26 Feb 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUmeRj/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51317BB9;
	Mon, 26 Feb 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919908; cv=none; b=IoYkQY0Xo8/mowOZEx/hfYQl6G1xde/56DUiIrRBpiAX3zyrpLDOcmmQV1EFWZd/R4tfwTx95uck1UH+eK2aO2OoksS8vCMJn53SXWf7o2jZP4QSn53uFaVs3naZpP4yib7qaia7/qK1ETrF4ZwPbnz4NAz4LlJYF3z2SliEpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919908; c=relaxed/simple;
	bh=63h5hWEAUrjyKuKg98EUt1dzdDxGAgC9zxmqReDr5CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHH90OxDFKTfmsRCf6wESONIDM8nyuwDF9fo1JHMNeCzsDysZ0BSLB2ie5+OCWaFVTV3QCTgj2TgqtHU13Id4YtLawRcFe47q9dg1YVLF+6fkU/BDkOVDGu8vq72bZCL/rxAgQO5P9EDUOSqedGo1TjI33CtaIXn+4luYMwKmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUmeRj/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349ACC433C7;
	Mon, 26 Feb 2024 03:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919908;
	bh=63h5hWEAUrjyKuKg98EUt1dzdDxGAgC9zxmqReDr5CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUmeRj/hqT4T0rF6Y5RcGUyKDDCPS16On2WXkCBYFQahY/43lqhh4GdUjBUr/xWcm
	 J27zl9kdvNf0yLQLGdKbPF0/UeXU/5SQqznnQe8RtooBWd8lAYEpsuV2D4wfvrAlaA
	 wqs4o3VGIsCVyngquuhGs7ExqRQiyABs8TLHkA0Zu2HmV8quIPrDDMs7bekBhyBXBF
	 Evobr/V9WU1PENUojeeiX69rNHihidbdHKgh09riXFt64+vQPIOAOzCQJtPCRWgNyn
	 szhgx6d31Mjlb5bTA+1Zc/uIzGNgq8afWKjBZScRnmi9PxRqOk8jgMG8Daz2+bzTtD
	 4cHCDpyWvXmUw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/7] tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
Date: Mon, 26 Feb 2024 12:58:23 +0900
Message-Id: <170891990355.609861.2805086066595778818.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170891987362.609861.6767830614537418260.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
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

Instead of incrementing the trace_probe::nr_args, init it at trace_probe_init().
This is a cleanup, so the behavior is not changed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    2 +-
 kernel/trace/trace_probe.c  |   10 ++++++----
 kernel/trace/trace_probe.h  |    2 +-
 kernel/trace/trace_uprobe.c |    2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 03c851f57969..eb72def7410f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -220,7 +220,7 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 	if (!ep->event_system)
 		goto error;
 
-	ret = trace_probe_init(&ep->tp, this_event, group, false);
+	ret = trace_probe_init(&ep->tp, this_event, group, false, nargs);
 	if (ret < 0)
 		goto error;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 67a0b9cbb648..93f36f8a108e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1423,9 +1423,6 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 	struct probe_arg *parg = &tp->args[i];
 	const char *body;
 
-	/* Increment count for freeing args in error case */
-	tp->nr_args++;
-
 	body = strchr(arg, '=');
 	if (body) {
 		if (body - arg > MAX_ARG_NAME_LEN) {
@@ -1810,7 +1807,7 @@ void trace_probe_cleanup(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, bool alloc_filter)
+		     const char *group, bool alloc_filter, int nargs)
 {
 	struct trace_event_call *call;
 	size_t size = sizeof(struct trace_probe_event);
@@ -1846,6 +1843,11 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 		goto error;
 	}
 
+	tp->nr_args = nargs;
+	/* Make sure pointers in args[] are NULL */
+	if (nargs)
+		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
+
 	return 0;
 
 error:
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index c1877d018269..ed8d1052f8a7 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -338,7 +338,7 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, bool alloc_filter);
+		     const char *group, bool alloc_filter, int nargs);
 void trace_probe_cleanup(struct trace_probe *tp);
 int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
 void trace_probe_unlink(struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a84b85d8aac1..796ebcae9b38 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -337,7 +337,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
-	ret = trace_probe_init(&tu->tp, event, group, true);
+	ret = trace_probe_init(&tu->tp, event, group, true, nargs);
 	if (ret < 0)
 		goto error;
 


