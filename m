Return-Path: <linux-kselftest+bounces-36369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE08AF691D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA253AD385
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249028D8E8;
	Thu,  3 Jul 2025 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMa1bckc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3E28D8CD;
	Thu,  3 Jul 2025 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516799; cv=none; b=rd9QGPzghwU/I00YraF0EVzCCnuokNUgdfdOPCmPpysSyOl9WsWKkGuNUk+6aMGn+zUaao1xU+FiR58DeNH+uIydG9Lxb0LTUsV5mdxMGHMFP0ouStzxIzp9+4gkY3pPf3cwupheVKy+aqqgrXAQDIDGfHpTWCqpHZmEpzH0CYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516799; c=relaxed/simple;
	bh=ud3jbqpPAFs8XFMfTuppk4oboUathRxwfWwTzzIxV74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfznYRd1rPlOSrps5WSnYx5hBXdHOZ8bj5SflJuyvqpM6TnTGVY9YokLHNorF0GlnCTsCz5Iis4XKJMdF98tXybd18hXtf7CpkLlEp98uLvc4pvs4tzrtEV0bwzZexR0sayB8/Ppw2kbOv+hlAbGkSN9stgX+0RnWW2y7uZBOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMa1bckc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC40EC4CEE3;
	Thu,  3 Jul 2025 04:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751516797;
	bh=ud3jbqpPAFs8XFMfTuppk4oboUathRxwfWwTzzIxV74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMa1bckcXAKLy4mpP8qTFSqg7ic9NkkYaSOJ4oVEHUdUP7m51upqLiNUbz7v3zoR2
	 sHMa1d/0tFQYaV2g/RaY88qOpo6UwmvN1/rk2MvGkv5jAV6bkAFJLIEvat0AKe+9lu
	 LUG/ey6ajFH6XCER9G13gcHCtAhBG3pji/A1h1oYbwNaQYeH3x9S8bxdqDtLeQlxQG
	 BE0PCoWy0rmy5uVKsVl8Fs5qkHDBlOwPnlh2lK7osZsNtC2FPqvuV9lLwpOQuU0916
	 2Kej5lgSye4RaId3sC3mxfMuAjZ68Q3Bh5FmVDX9DmtwsSksZmcMyCTf4Ebz2n3D7C
	 MGXUm8Lju447w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] tracing: Handle "(const) char __attribute() *" as string ptr type
Date: Thu,  3 Jul 2025 13:26:35 +0900
Message-ID:  <175151679513.2149615.16646841903099858271.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
References:  <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
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

With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
converted to `__attribute((btf_type_tag("user")))`. In this case,
some syscall events have `const char __attribute(...) *` for __user
string, like below;

/sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
name: sys_enter_openat
ID: 720
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:int dfd;	offset:16;	size:8;	signed:0;
	field:const char __attribute__((btf_type_tag("user"))) * filename;	offset:24;	size:8;	signed:0;
	field:int flags;	offset:32;	size:8;	signed:0;
	field:umode_t mode;	offset:40;	size:8;	signed:0;


Then the trace event filter failes to set string acceptable flag
(FILTER_PTR_STRING) and rejects setting string filter;

# echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' >> events/syscalls/sys_enter_openat/filter
sh: write error: Invalid argument
 # cat error_log
[  723.743637] event filter parse error: error: Expecting numeric field
  Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"

Handle "(const) char __attribute() *" also as string ptr type.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3885aadc434d..5e27190a0377 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1488,6 +1488,11 @@ int filter_assign_type(const char *type)
 	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
 		return FILTER_PTR_STRING;
 
+	/* Ignore attributes */
+	if (glob_match("char __attribute(*) \\*", type) ||
+	    glob_match("const char __attribute(*) \\*", type))
+		return FILTER_PTR_STRING;
+
 	return FILTER_OTHER;
 }
 


