Return-Path: <linux-kselftest+bounces-5807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92586F8F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560361F20F6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90E5398;
	Mon,  4 Mar 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF/QoMlN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F64C6B;
	Mon,  4 Mar 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523621; cv=none; b=R/WYOarwYpMZhkzXEEAdzQX/LATMuD4de5u9himM+90qzPnzZQA5L8jVWU7RR4QP2sHDg6WLdFsB5w9GFLyGTO1rLOCIAQ5AUPYNSiQWwssG4bq/AMCwfw5oVe9N/cmijpoEJnOa4tVkbpoiUcyTff2InvK92IyVPSB2S7GqZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523621; c=relaxed/simple;
	bh=/dyCFA6euqljnFjmQrQ+oafm97nJtVOUz8aX5A22W/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAWWJR8WVRpSLP9rCmkSug+m/qElNGYZlmz3HddS7Kh4CE04esXkjDu1aZUFkA2A/YohRWtLW+3CW4CL8Iq3YZGo3WPXYhccGu1+VAxWE+ERqHIfpKbEqweLxrgCRfVL1FVM0YL5KTIwPC5PQ1oLz2JkHghTxyUujlKGtFQ9Tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF/QoMlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A4FC433F1;
	Mon,  4 Mar 2024 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523620;
	bh=/dyCFA6euqljnFjmQrQ+oafm97nJtVOUz8aX5A22W/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF/QoMlNRXrDJEYBArP5rVYtONQ/MDAnwmWXMjnSsy6T1mdCtsG56hdvm9olasW0f
	 Cq7ttZGrHeD5EtO1i7E4WM8o+KpVAiD5xZIgYwLFSauhEe8QhnuoXiODJbX/0ISkD2
	 jZi0VDdXmtIMf/TcbBGVaLVpwAAGLSe5j8INAx41pMNgvd6+RyMdw9/FYMGOwDry0+
	 7Wf/HD/WL5VmTIN2dxmJ2HHudNngFDfWDS00QIEv4ggROLwX3n/YgyOEPrHYpgr4ro
	 JZzdSCeSM8IYyV657LQIpQ+heVROkomQ+CHLxf0dLSnpbToYaCk5gbH/4rjEhhvhgF
	 Y5aT4r4NwiM6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/8] tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
Date: Mon,  4 Mar 2024 12:40:16 +0900
Message-Id: <170952361630.229804.10832200172327797860.stgit@devnote2>
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

Despite the fprobe event,  "Kretprobe" was commented. So fix it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 7d2ddbcfa377..3ccef4d82235 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -210,7 +210,7 @@ fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 }
 NOKPROBE_SYMBOL(fentry_trace_func);
 
-/* Kretprobe handler */
+/* function exit handler */
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 		   unsigned long ret_ip, struct pt_regs *regs,


