Return-Path: <linux-kselftest+bounces-15596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880F955CBC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DF32818EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08C44C8C;
	Sun, 18 Aug 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7AZmTLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E977113;
	Sun, 18 Aug 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723987127; cv=none; b=pKm+3rTcNY+BfP22piXxNfkXpXxfVzJxunMZWh1wQX21xBWzWoUAhCR9W0Zl78R97LE9bj2xsH6eGTcJxJ2nHxonS5oPpYQh0ivDCI0yX6eTFMMT2aO9G9h+/5EMj98aat0ew6UmYhn0DNOVcqpoAJcuWFOqVHhnw9mQCHaO1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723987127; c=relaxed/simple;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNybJUG6C9gCQvBNOAkc8dqcV6NtYTKJWrKkKgPsIeELyi3SVQcSqpZbnIbUZMTBSVe4vicLcaZQ57STGQ3ZlyrjjG9Y//vcGIefhwzDK/xa0NswHogokgDwnygag1GosZ8TFPM8kKqFz4/o9bvqZqZSZTexxYz98oLJl7dH5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7AZmTLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF8C32786;
	Sun, 18 Aug 2024 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723987127;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7AZmTLmnRGlDFxYk+/jMEkQxUbI3xnr5nkV7Q5Abes34BJaGuY8s3eU7pXdEKIAB
	 5l9Q05hbBReBM7OKWBQOAp2zF8Zwb0BwzO7i4jrIxrjJrvuR1xmhCnTGr7D/iI4gzd
	 FP35dIrBV2uX6CnrjbJ82RFP42X26n0uofSR8FxsBP4Z2vUcdCJYsfu7UO04kknGbr
	 atJf6TGWCVeRODLi+4UtVj+Jy6CbQruy2QFiL055rdyey5g7UtnyG0dH6lsu9dRpwn
	 opIOaPcwbxmTgB/PV2cucmDLP/kaaOOhJ5jtbjzkORqEZP01dnXmYR3d6JxO9ugvWJ
	 ikyk2svJoC/sA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/3] tracing/hist: Support POLLPRI event for poll on histogram
Date: Sun, 18 Aug 2024 22:18:43 +0900
Message-Id: <172398712354.295714.14480056153369400862.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398710447.295714.4489282566285719918.stgit@devnote2>
References: <172398710447.295714.4489282566285719918.stgit@devnote2>
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

Since POLLIN will not be flashed until read the hist file, user needs
to repeat read() and poll() on hist for monitoring the event
continuously. But the read() is somewhat redundant only for monitoring
events.

This add POLLPRI poll event on hist, this event returns when a histogram
is updated after open(), poll() or read(). Thus it is possible to wait
next event without read().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d27b60f54f68..d64aa34892e7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5599,6 +5599,7 @@ static void hist_trigger_show(struct seq_file *m,
 struct hist_file_data {
 	struct file *file;
 	u64 last_read;
+	u64 last_act;
 };
 
 static u64 get_hist_hit_count(struct trace_event_file *event_file)
@@ -5636,6 +5637,11 @@ static int hist_show(struct seq_file *m, void *v)
 			hist_trigger_show(m, data, n++);
 	}
 	hist_file->last_read = get_hist_hit_count(event_file);
+	/*
+	 * Update last_act too so that poll()/POLLPRI can wait for the next
+	 * event after any syscall on hist file.
+	 */
+	hist_file->last_act = hist_file->last_read;
 
  out_unlock:
 	mutex_unlock(&event_mutex);
@@ -5649,6 +5655,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 	struct seq_file *m = file->private_data;
 	struct hist_file_data *hist_file = m->private;
 	__poll_t ret = 0;
+	u64 cnt;
 
 	mutex_lock(&event_mutex);
 
@@ -5660,8 +5667,13 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	poll_wait(file, &event_file->hist_wq, wait);
 
-	if (hist_file->last_read != get_hist_hit_count(event_file))
-		ret = EPOLLIN | EPOLLRDNORM;
+	cnt = get_hist_hit_count(event_file);
+	if (hist_file->last_read != cnt)
+		ret |= EPOLLIN | EPOLLRDNORM;
+	if (hist_file->last_act != cnt) {
+		hist_file->last_act = cnt;
+		ret |= EPOLLPRI;
+	}
 
 out_unlock:
 	mutex_unlock(&event_mutex);
@@ -5680,6 +5692,7 @@ static int event_hist_release(struct inode *inode, struct file *file)
 
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct trace_event_file *event_file;
 	struct hist_file_data *hist_file;
 	int ret;
 
@@ -5690,13 +5703,25 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
 	if (!hist_file)
 		return -ENOMEM;
+
+	mutex_lock(&event_mutex);
+	event_file = event_file_data(file);
+	if (!event_file) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	hist_file->file = file;
+	hist_file->last_act = get_hist_hit_count(event_file);
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
+
+out_unlock:
 	if (ret)
 		kfree(hist_file);
+	mutex_unlock(&event_mutex);
 	return ret;
 }
 


