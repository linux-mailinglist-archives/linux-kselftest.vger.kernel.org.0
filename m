Return-Path: <linux-kselftest+bounces-10454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF38CA54B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DFD1F216DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805347A5C;
	Tue, 21 May 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W30O/G2f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BF1CA80;
	Tue, 21 May 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249636; cv=none; b=QfwcjH6L9+kK5hybIwCjVfZRMhx1fdMAKaeMp3EjBzLNdk7I43b4a4MUxcXhMm8rH+Wx99zc5VzoOfCr/P4Z2YFqLT0/af/fJPWsclif2X6S0l3gW97Cie9IHykLlqesMBEtybDMXIHM2IZW67CghYjdcbxkf8GgSDUYv+/oldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249636; c=relaxed/simple;
	bh=zLkWSjlPxW/hZZcGzKZyW1un4mXdBq570gMuSM2iiEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDiB53d/ejMMiN3Vb2mMVrIoI/+0dMscf42rxC/AFJgvCTNYjTx+J1C74Ksw3af7d/FV6vE5S27jp2lnmdyeHKSZBhi9REeMctjWhp62a5f0S2bnMpwUt/51vsMPRLpYHijcujOItRlJa8ze8sZ+SJ7Vf/0spi0QZPqABs4M6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W30O/G2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80110C2BD10;
	Tue, 21 May 2024 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716249636;
	bh=zLkWSjlPxW/hZZcGzKZyW1un4mXdBq570gMuSM2iiEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W30O/G2fCRUglUH76Q16mhIHHjRDe4v7wIUX3i0aS+yTSJ4IoeJn8MzxHK9iz7VzB
	 7US3RroA5o5CUSKGUM3WgHeUJW4px/oOqPFDELaAonvvD/mgAS2DMk3+h75WFufR3+
	 2637l2+PKEN4q115gJs4e9c6kdJejZtp8e9FQaClg1BfCIIRr8yoIB05ywKAubIdlD
	 hyyDRJPqRdKzHfywQHWzSyAQGSY707ka6upqCr9n94bKAVxoRQ8hwT+zBLITXErh6f
	 bTfj6EUVjchRPvSrgtrc8g3SgVK5mf1ZPgSpsGqVHte+h9a2JOvSaVTXXLRL9iovNW
	 lh0uMZ4PL+vEQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Update required config
Date: Tue, 21 May 2024 09:00:32 +0900
Message-Id: <171624963215.252417.12572658025062192987.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171624961322.252417.15852003285637286674.stgit@devnote2>
References: <171624961322.252417.15852003285637286674.stgit@devnote2>
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

Update required config options for running all tests.
This also sorts the config entries alphabetically.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/config |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index e59d985eeff0..048a312abf40 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -1,16 +1,28 @@
-CONFIG_KPROBES=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_EPROBE_EVENTS=y
+CONFIG_FPROBE=y
+CONFIG_FPROBE_EVENTS=y
 CONFIG_FTRACE=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_GRAPH_RETVAL=y
 CONFIG_FUNCTION_PROFILER=y
-CONFIG_TRACER_SNAPSHOT=y
-CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
-CONFIG_SCHED_TRACER=y
-CONFIG_PREEMPT_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
-CONFIG_PREEMPTIRQ_DELAY_TEST=m
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_PREEMPTIRQ_DELAY_TEST=m
+CONFIG_PREEMPT_TRACER=y
+CONFIG_PROBE_EVENTS_BTF_ARGS=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_FTRACE_DIRECT=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
-CONFIG_KALLSYMS_ALL=y
+CONFIG_SCHED_TRACER=y
+CONFIG_STACK_TRACER=y
+CONFIG_TRACER_SNAPSHOT=y
+CONFIG_UPROBES=y
+CONFIG_UPROBE_EVENTS=y


