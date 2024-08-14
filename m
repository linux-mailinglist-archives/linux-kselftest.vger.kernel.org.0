Return-Path: <linux-kselftest+bounces-15286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAC9510EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 02:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887B12849C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44119E;
	Wed, 14 Aug 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/rZEM60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF702594;
	Wed, 14 Aug 2024 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594298; cv=none; b=gzYi9WCELGzWDCrfPFsFsIJMsUnVmmaCkoFqfBX7yI+aElLX8PN/cIsgByNHpH+bO/tqWIh28U7kjaMiX0J5V6vw5jZh0UV5wECFjIPbyW2JQlfu4GFbQZbPgzluSOS6xnxUq6KyLWrjO4unrsXLa0ZbYcGi1jncUVUpyH/rC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594298; c=relaxed/simple;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S991qMHZ2UiDMhh72l2o9aO3DhJnF78BlalZZsw4XglCvKuDHj2qG8G0saSe7oPuBTd4XbCQRuR8sDuRaCpGcfnUEbEuoOGWvmvIxzdPuSx75rAwsSlqHI0CFQpWyhx3EmEw8Q9RUBDKfyBZ4AeS8VIKH7ck0nKi2/ktCAgFXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/rZEM60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CEDC4AF0C;
	Wed, 14 Aug 2024 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723594297;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/rZEM60+o93h9aJhJDoC41rvH6xN+00+lWdrNeaEDHDewuxlaEEJtFov1QltISts
	 J2xbHmkTZ2P60R2ig07lugI03BpBH+ctu4GRCCZlKlaj7dvDNzJdRzXuMji9QkPQQV
	 vrc1fmdIK8VUMhrjgaxYaDSRNKhm3A1vlAsUnZsZf6+73Z42wrCNc/SAXj2wViedBG
	 NA8qb69i/RgXie+SSj2Dv/xnnsaDS5K2SZUCTb4JB+c+o+F0zEpdUYM8DnMJ6QY9Mb
	 oQJ6gd2FTofJNDALVJOUUlKFerJmP//TidJuPj/zV1R4VlTGKsOB7tvUjWaduYOJ9g
	 1UFT4U7DJ8cbA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/3] tracing/hist: Support POLLPRI event for poll on histogram
Date: Wed, 14 Aug 2024 09:11:33 +0900
Message-Id: <172359429363.323666.2642075317101942614.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172359427367.323666.6446548762874507863.stgit@devnote2>
References: <172359427367.323666.6446548762874507863.stgit@devnote2>
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
 


