Return-Path: <linux-kselftest+bounces-23767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9F9FD000
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 05:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FA918835BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC7278C76;
	Fri, 27 Dec 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3kG7Btm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D4524B4;
	Fri, 27 Dec 2024 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272493; cv=none; b=LUYuKQCsdYioG2+aAqs9QJhRrw85JC7B6Imjn3PPh7CGACw3jk1wSKfcF3KB8Li2DHN3IHuZoFYHgW+EyUg0IgIW/g0cCBycJkVej4Ioco3iLzDOzVEQ8iQyX8nD8fpYduKR3L3NEXTXdmEp06d/zVum/dN4K4lvuq05X5nwo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272493; c=relaxed/simple;
	bh=1o3QZz/u4OLqgGCv2X2q5J2aE3A5JYecgIy0yAal9S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1RRxohSxPJIgwdc00Rqyy6oVzK/zOBluozYnaayo+a/YhgvX8ccyBgtndb9Zfms49ebqIyXB5HV2Eno4pPtEUmzWryg9X2RVb15Vac9MPtRI04ZDRJJNcswX/6rDijcI3bXs7tinTvePk0MP+qfwtYKz9dJ1buKg15eWf7x5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3kG7Btm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74817C4CED0;
	Fri, 27 Dec 2024 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735272492;
	bh=1o3QZz/u4OLqgGCv2X2q5J2aE3A5JYecgIy0yAal9S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3kG7BtmBrhHQLumSMXptCf+wceq3uyQdD15RT5nkKVVBXjUobhUzaZtjwBkOlY/O
	 GDZ6NDwYHGRb9fjpXsgPAryFPyAOaWQw5NYLdENDdAEpnzA+ptHJvB46PhshXEB4fl
	 xnSWRHVAscNjEZwCVEQyNtDT16YTtLx23Hfa2fFbDA3adPAmew/Lh9akcIW+CZ2tOs
	 1if0CuiGNiuFyf986n00Hbp6AzEnFhP03P/TLg+c8dymHWaKHhrqAOwRPusroSuDce
	 nax8il+gaTRyxxzM0DmUj3NF8oZyJTHRjmrRhUHKPhIUf/keubZuwZR2U6YRn2Dek+
	 T5WPboYtE6r8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 2/3] tracing/hist: Support POLLPRI event for poll on histogram
Date: Fri, 27 Dec 2024 13:08:07 +0900
Message-ID: <173527248770.464571.2536902137325258133.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173527246726.464571.11533527581374142406.stgit@devnote2>
References: <173527246726.464571.11533527581374142406.stgit@devnote2>
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

Since POLLIN will not be flushed until the hist file is read, the user
needs to repeatedly read() and poll() on the hist file for monitoring the
event continuously. But the read() is somewhat redundant when the user is
only monitoring for event updates.

Add POLLPRI poll event on the hist file so the event returns when a
histogram is updated after open(), poll() or read(). Thus it is possible
to wait for the next event without having to issue a read().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 Changes in v7:
  - Reword description according to Steve's comment.
  - Use guard() in hist_poll_open().
---
 kernel/trace/trace_events_hist.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e169f67c6088..15f76c681c6c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5595,6 +5595,7 @@ static void hist_trigger_show(struct seq_file *m,
 struct hist_file_data {
 	struct file *file;
 	u64 last_read;
+	u64 last_act;
 };
 
 static u64 get_hist_hit_count(struct trace_event_file *event_file)
@@ -5632,6 +5633,11 @@ static int hist_show(struct seq_file *m, void *v)
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
@@ -5644,6 +5650,8 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 	struct trace_event_file *event_file;
 	struct seq_file *m = file->private_data;
 	struct hist_file_data *hist_file = m->private;
+	__poll_t ret = 0;
+	u64 cnt;
 
 	guard(mutex)(&event_mutex);
 
@@ -5653,10 +5661,15 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	hist_poll_wait(file, wait);
 
-	if (hist_file->last_read != get_hist_hit_count(event_file))
-		return EPOLLIN | EPOLLRDNORM;
+	cnt = get_hist_hit_count(event_file);
+	if (hist_file->last_read != cnt)
+		ret |= EPOLLIN | EPOLLRDNORM;
+	if (hist_file->last_act != cnt) {
+		hist_file->last_act = cnt;
+		ret |= EPOLLPRI;
+	}
 
-	return 0;
+	return ret;
 }
 
 static int event_hist_release(struct inode *inode, struct file *file)
@@ -5670,6 +5683,7 @@ static int event_hist_release(struct inode *inode, struct file *file)
 
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct trace_event_file *event_file;
 	struct hist_file_data *hist_file;
 	int ret;
 
@@ -5677,16 +5691,25 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
+	guard(mutex)(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file)
+		return -ENODEV;
+
 	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
 	if (!hist_file)
 		return -ENOMEM;
+
 	hist_file->file = file;
+	hist_file->last_act = get_hist_hit_count(event_file);
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
 	if (ret)
 		kfree(hist_file);
+
 	return ret;
 }
 


