Return-Path: <linux-kselftest+bounces-19841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D159A9A07C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 12:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886C5287163
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437D2076A1;
	Wed, 16 Oct 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXciUSkg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A271207213;
	Wed, 16 Oct 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075777; cv=none; b=pFvt0Meu7Stleybs4LB8IUhWHjkJaQCuVoMyNK+ffd1ZUE/VqFbr8rPXu2uAcOOYXsNX4EoaPPPIQYd3PtdOpBjLsqyHWKBVDvkb7Xu+5gBa4LzbcnoD86esi+Fd2Te2NIaAaYqDIQ/Hx3bEizvFN2syUHTD/ECFohFY6zuMgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075777; c=relaxed/simple;
	bh=dXXEJ1CQa20I+ilEYAbWxf0KdobQfCvDGGlCEBYzd7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjXmJGn8us4hLQQMwHAAUFYLZFdiZS9NWGIMCc4YI2fb+mZJnSCs8lcfGFrrR3yCo78qcHF0U7xs2bBZD2ievNy4Foqlz2XVy57JckzHPO+u6LrOBWOGo1PYwFLwdBrX3mgBaQ68Gf79KvMZGRxPv9NsXDpdo3lIfkHJvAbDhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXciUSkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E84C4CED0;
	Wed, 16 Oct 2024 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729075776;
	bh=dXXEJ1CQa20I+ilEYAbWxf0KdobQfCvDGGlCEBYzd7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXciUSkgnoSwjoP6bqZnBXB80ITHp8p507gbapxbzGdzjMom9IAp8JAPUPldrqzLF
	 Mvbp3/C0zjtKx4fxLkAh5NBRdTkIAQ0xhnLY+XSsaQ5dAUSNdx55Pw3n+SlFA2Drg+
	 y1FCZbzWXBoKqoEmE0gqjthz8TvAPY+JNdRhjwTk4NZ/p69eJr2n9khtvPK6KPCGFw
	 P6/LRJartBtlCn5IxJwGd5prJM9F1wcjvc1zrQlrDeSIllNvEQAaFUSR/gLBtJh+Ud
	 HRTClN5bc8wyREr94Uukpo7m8a9eUjME4Mt/N2efXwIkR1sf+jf/2QhIfT3jG8JX25
	 ID7wFQMuzyo/Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/3] tracing/hist: Support POLLPRI event for poll on histogram
Date: Wed, 16 Oct 2024 19:49:33 +0900
Message-ID:  <172907577331.470540.11394819971376123947.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
References:  <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
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
index 107eaa0f40f1..8819a8cc4d53 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5598,6 +5598,7 @@ static void hist_trigger_show(struct seq_file *m,
 struct hist_file_data {
 	struct file *file;
 	u64 last_read;
+	u64 last_act;
 };
 
 static u64 get_hist_hit_count(struct trace_event_file *event_file)
@@ -5635,6 +5636,11 @@ static int hist_show(struct seq_file *m, void *v)
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
@@ -5648,6 +5654,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 	struct seq_file *m = file->private_data;
 	struct hist_file_data *hist_file = m->private;
 	__poll_t ret = 0;
+	u64 cnt;
 
 	mutex_lock(&event_mutex);
 
@@ -5659,8 +5666,13 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	hist_poll_wait(file, wait);
 
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
@@ -5679,6 +5691,7 @@ static int event_hist_release(struct inode *inode, struct file *file)
 
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct trace_event_file *event_file;
 	struct hist_file_data *hist_file;
 	int ret;
 
@@ -5689,13 +5702,25 @@ static int event_hist_open(struct inode *inode, struct file *file)
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
 


