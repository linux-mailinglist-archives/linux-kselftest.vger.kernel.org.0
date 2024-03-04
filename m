Return-Path: <linux-kselftest+bounces-5809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9EA86F8FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5850DB20BD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5684539A;
	Mon,  4 Mar 2024 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaHIctQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816134A3E;
	Mon,  4 Mar 2024 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523640; cv=none; b=Xk2bveyiKWtQkexjAt8c2nuS2ILnrPwcqWBtyvcfN435dJMVGe21NK6su+TRF7Z8eUN+L2O1uX5Vql9N6l/wGRehxM4uOo3OLXuldGv0b9B4Xd4cpg3sw8n1D0sX4+DjsFpcPtFhSVk8fhDdxyxyfuVEKwNKWJKqOyFE+uFU30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523640; c=relaxed/simple;
	bh=1Hey3CwK05YwZTBeLUkTieaMt+Bw603JtB4gBPGwNVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvGmyqOc2Bc1hIgjrsZTxXi9RZTnto9flUoY9p91C9ExXc208155vY4RItPTHVXfJQ1nYX/Jh/qrKZX18SKzFNFSufyhw195L4h+3h0NrJUoRxrVKzmJs0RIyi4pkCPO4uaZM+jJKquXkNewLAVfC+i+AylzwvAljgPtbTc60fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaHIctQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7A5C433C7;
	Mon,  4 Mar 2024 03:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523640;
	bh=1Hey3CwK05YwZTBeLUkTieaMt+Bw603JtB4gBPGwNVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaHIctQhHtpyjMJXYj9gt6Lyd5xUZNW7l9YosYBvcmDxl9j7+nRA1dkrEF9jIHsoH
	 cleeBdVrsBqKws+w8m6irkbRqpYi88wToWpAVnYmLn2JGzecDlwfi0hbKW7GOIxIZx
	 LQrXk/BZRTIRyryW2SyJtaPFxHDhJ+3vwI8HMSNbh1iP0DPx7CxB6UE/tIOAtjQZAZ
	 P2crVQr9Baken/GG1iyCdCpQ+at0SM9EPPZ6LG7vh4GUbRX8JZkEuxQ84IuWgyuDAL
	 VW9VOGD7nVAb8FlJrprdPTftatNOj5FmXcusCfQLvj2fzx/zQIWiVozqV+AOCFYTc3
	 s0/colTYgkk0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/8] tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
Date: Mon,  4 Mar 2024 12:40:36 +0900
Message-Id: <170952363585.229804.13060759900346411951.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170952359657.229804.14867636035660590574.stgit@devnote2>
References: <170952359657.229804.14867636035660590574.stgit@devnote2>
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

Instead of incrementing the trace_probe::nr_args, init it at
trace_probe_init(). Without this change, there is no way to get the number
of trace_probe arguments while parsing it.
This is a cleanup, so the behavior is not changed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix build error in trace_{kprobe,fprobe}.c.
  - Update changelog.
---
 kernel/trace/trace_eprobe.c |    2 +-
 kernel/trace/trace_fprobe.c |    2 +-
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.c  |   10 ++++++----
 kernel/trace/trace_probe.h  |    2 +-
 kernel/trace/trace_uprobe.c |    2 +-
 6 files changed, 11 insertions(+), 9 deletions(-)

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
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 3ccef4d82235..5109650b0d82 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -389,7 +389,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 	tf->tpoint = tpoint;
 	tf->fp.nr_maxactive = maxactive;
 
-	ret = trace_probe_init(&tf->tp, event, group, false);
+	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
 		goto error;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..843f13f839df 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -290,7 +290,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	INIT_HLIST_NODE(&tk->rp.kp.hlist);
 	INIT_LIST_HEAD(&tk->rp.kp.list);
 
-	ret = trace_probe_init(&tk->tp, event, group, false);
+	ret = trace_probe_init(&tk->tp, event, group, false, nargs);
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
 


