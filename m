Return-Path: <linux-kselftest+bounces-15477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D8953FAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08452285361
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996E52F62;
	Fri, 16 Aug 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGlDJ1+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189F4EB45;
	Fri, 16 Aug 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775467; cv=none; b=ZY2N0s4vXAdJBwUS0GHlqFUzJ2k9/45w9sv32J0AeUW+Z5sBdXF+IfFGZTwJCid8pa/pX101D54bqqYMIBWZaBbtE5cQPpN/fFqa83TZo+yuQHywXIT/wifggYYdxEjZ8H05XI9nZ/aUgST3JXKBBq8ZchaF1rbvCg8TzHTbA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775467; c=relaxed/simple;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm0cLOX6Fx+/6E5rCG8VBw5y1lWnBvzzzRYecqVvboyceIV+OHb1U4Wre92HBHbIzg8eYmg/uV2IGP9b5ZskDWQvqXXNrpu86y6z856h3pC0CncDTu2SrT17RlBSXUgVlRPEXsAxBJFC092YLusYtqIdLUYzF52JrmITuh8++2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGlDJ1+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE88CC32786;
	Fri, 16 Aug 2024 02:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723775466;
	bh=Jur8XeuZlryZD5nLURpFedzGOoXyD7Nm8ATeE/V8NpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGlDJ1+Cg4gN6XQQH5zqKRQjexUvaBNEzaseDRQzSOS7qvBbYxIoQwL8IN2976/qr
	 6qbq+87LWNizZfkmG6bHYYNw+TdtZvVLJ3JlYRaLqf67kb81CVFAGyQaR4hhL9ed1j
	 5eeuJTsBfbWbeKtBR39dxPptLlAe/aZzFT8N2vNBV6b5Rs8PUHNROHm1ORNnMe669M
	 7EiA/M5mtUtv5sTqSsoEVtiUalFoxUu3mGGux+JrSvWV32R7/BgWPwTFZHaJsDFfPg
	 dAR6SCkpjAJzvc0OVhG7HetjW4UV5G5THYXgVOzTsV4c/SUdJ9JQTOvR2Kx9xtI4dN
	 u4wPd+SDTH0iA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/3] tracing/hist: Support POLLPRI event for poll on histogram
Date: Fri, 16 Aug 2024 11:31:02 +0900
Message-Id: <172377546253.67914.2712199451353378352.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172377544331.67914.7474878424159759789.stgit@devnote2>
References: <172377544331.67914.7474878424159759789.stgit@devnote2>
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
 


