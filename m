Return-Path: <linux-kselftest+bounces-5424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0A86690D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D289FB2387B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569A1CD01;
	Mon, 26 Feb 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbazXW/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593D1CA85;
	Mon, 26 Feb 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919948; cv=none; b=dKMmmJQnXDs59hzEghivmf2c9gTbDuYAtXjZmIxit9LZ6Y5Vb5UsgO4F713dR1dZIrunJHsGo18HTvWQy98XnroYHk111GA4+y5ShJneIv3JtlHb0InXTm0cNtI6UQxC2uxe6b5Lag1JtCV1udy4s6d498nJ5bXhi6R50iveX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919948; c=relaxed/simple;
	bh=+bUIR3Sr3KLkcoy88QRFGtdrGix9yzfmI6AvbnJxv5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sg5/cTNYSQAIkGARZmNXS7LC7phiIGCQ73XSPK9+fHtZNr9f1aPzLydTSlcNGMfb29dNH86Kp+J2WzHhS8Lphc9BEEhcLQOy4G6SH+0K2Ln5wJspv17NSxr7kmhyHbv61zzgISnIXpzOKPO4axav/b2KPK34TPuuY4F/lOQWTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbazXW/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26456C433F1;
	Mon, 26 Feb 2024 03:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919947;
	bh=+bUIR3Sr3KLkcoy88QRFGtdrGix9yzfmI6AvbnJxv5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbazXW/nYFyjtKHvoC+N5XOy84OIILjSUms/qyKqD3pgrhQb323DtqyYbVjIj80qH
	 zFhwQu/yijQ17SmtTzGC2nSFVhCG/EvRgzsBIUlw1CQnrjnatKGo/0Mq/Rl94mNjTw
	 uV37Fl4NXDg7EbYeIUPFVYHz4fcJZ/J0lJFwX1eVlj+gwpnhY0Kl1opVGZEUVdkHDg
	 3V1e1w9mhWcc7Ax8IT9cl4M1xqbVdw7JQCrj7D97WOcWWpFbs1GU4ziKKX3oMeBMVC
	 qrcalUf/Bx8GCwXl5m9dShcL9JEXJZhd5kDei5sNpwYFnbiIzootb+35alNXp4kAyh
	 AFZRrA13v0Nsw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 7/7] Documentation: tracing: Add entry argument access at function exit
Date: Mon, 26 Feb 2024 12:59:03 +0900
Message-Id: <170891994330.609861.9109792572425248438.stgit@devnote2>
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

Add a notes about the entry argument access at function exit probes for
kprobes and fprobe trace event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    7 +++++++
 Documentation/trace/kprobetrace.rst |    7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index e35e6b18df40..ab71ebf178cb 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -70,6 +70,13 @@ Synopsis of fprobe-events
 
 For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
 
+Function arguments at exit
+--------------------------
+Function arguments can be accessed at exit probe using $arg<N> fetcharg. This
+is useful to record the function parameter and return value at once, and
+trace the difference of structure fields (for debuging a function whether it
+correctly updates the given data structure or not)
+
 BTF arguments
 -------------
 BTF (BPF Type Format) argument allows user to trace function and tracepoint
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index bf9cecb69fc9..35a383f95746 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -70,6 +70,13 @@ Synopsis of kprobe_events
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 
+Function arguments at kretprobe
+-------------------------------
+Function arguments can be accessed at kretprobe using $arg<N> fetcharg. This
+is useful to record the function parameter and return value at once, and
+trace the difference of structure fields (for debuging a function whether it
+correctly updates the given data structure or not)
+
 .. _kprobetrace_types:
 
 Types


