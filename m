Return-Path: <linux-kselftest+bounces-27560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F0A45579
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5117B434
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772A269CE1;
	Wed, 26 Feb 2025 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gruQOPyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45C2686AA;
	Wed, 26 Feb 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550746; cv=none; b=io+gTrtkbgIhtd+V+mo1joHIyYmRJUNlgJ24O3JcaMTxlm5krC2nnNV9QUC0+ucL8+fJZ9B32pDXby089zsuc2SZ27V/UCzwmP0NmXMqx3HLbUlZaKVb0ulyIvDge2IntZN82YLzF4to9wU+u5aKqBxU+0ENOpcZq2+FTi8cYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550746; c=relaxed/simple;
	bh=Mick79tYMJKn2WZb30ArjcexzndxTXd6buHYPReNwpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSEaC04AG8SvY+PpIlnDUVAXH42Ndeh815V6teZ+SoaS34UhxKVIY1R7+PvDB6jM8XZ7ZK8FSnAyJFZVe4TNYCOyzV6pCgAefgsmS6NsR5ZWOGHHyTHJ2KdaNgbrHu5QCuZU8yi1bITcq+LVqN7jw4LjZFjrbzh0ERLwqwywSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gruQOPyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFD8C4CEE9;
	Wed, 26 Feb 2025 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550745;
	bh=Mick79tYMJKn2WZb30ArjcexzndxTXd6buHYPReNwpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gruQOPyXb22FsgPGyKVmUkm4Sk5xU3HvgrGCXuOi7v5l5cXDtRir4HyorFZgorN3/
	 S+H4Ob9zqziNFWCIdvOb8X7wKbmVytGHuZyYFpsC+GB68zLXF8VkInlr9jIPMAuK/X
	 Kqfyl8PZvhJu6ir6J2LkW2o+MNRxaAdZxvbPlwEIfKYjF0QAVFVJD7feWwa4ZKCs1I
	 Rg4lp/g/rhS9CrKcy9RfThuA5NpxDv1JHNzE58RE/Xt49AqHoyKqQoGdYxLJ41PU1l
	 Ir+4Ofjt2KIL62QYbqKqKiCMX4TN2wjO6ArBs28dL71iba4C1Qk0LiqgyXzZza02yo
	 vQAFcnLS+r3UQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/8] tracing: fprobe-events: Log error for exceeding the number of entry args
Date: Wed, 26 Feb 2025 15:19:02 +0900
Message-ID:  <174055074269.4079315.17809232650360988538.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
References:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
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

Add error message when the number of entry argument exceeds the
maximum size of entry data.
This is currently checked when registering fprobe, but in this case
no error message is shown in the error_log file.

Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    5 +++++
 kernel/trace/trace_probe.h  |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 85f037dc1462..e27305d31fc5 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1230,6 +1230,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (is_return && tf->tp.entry_arg) {
 		tf->fp.entry_handler = trace_fprobe_entry_handler;
 		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
+		if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
+			trace_probe_log_set_index(2);
+			trace_probe_log_err(0, TOO_MANY_EARGS);
+			return -E2BIG;
+		}
 	}
 
 	ret = traceprobe_set_print_fmt(&tf->tp,
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index fba3ede87054..c47ca002347a 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -545,7 +545,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_BTF_FIELD,		"This field is not found."),	\
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
-	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),
+	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


