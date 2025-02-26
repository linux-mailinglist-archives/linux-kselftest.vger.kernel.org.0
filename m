Return-Path: <linux-kselftest+bounces-27559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A702DA45572
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B710117BDCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABE268FD2;
	Wed, 26 Feb 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLNMeZQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BE267AFA;
	Wed, 26 Feb 2025 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550738; cv=none; b=HThjXm6QMooO91yZ11MGBn5i35ojzwxvEFghW0Ew/ksc2c0LBPh4yoLABTCg6jJjlpQ5eetfNsb0R2uHyypbwxEzckDsHKFdmKFoW0oLPJbS98gkEStWqbVb2tAbNBaa8wVKETgeNRJRku/oSoxlXOoM6GiBXOMdjdkAxOgp66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550738; c=relaxed/simple;
	bh=3A/uAbVPL2SDGbn5Bzb+/MWog9HnommDHmQhGEpBL90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2qO4qt1IYMOiDXdGets+wMlxud3R80ILpeJUJPzHGuELajEeUcMdl+nfMAQ10ZQpfq1MUi4NMjInKUxvdcBLqqpRu6GhKZERtnagWh2RBdsWkJzDiIgIotKCIS/XXAVIRJ5Phq+MUw0VUOU/kPOH2JeELYICj00Lb/ggKJlgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLNMeZQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B14CC4CEE2;
	Wed, 26 Feb 2025 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550737;
	bh=3A/uAbVPL2SDGbn5Bzb+/MWog9HnommDHmQhGEpBL90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLNMeZQEmjWeGIqJycHNaBGppBV7lbjGeKJBL7GA+cagWvGSF/BMjCsdpCDGTDIMA
	 3ZR07xV5tgCj/IK5WDf7pllRtL0mgf8147oSYuNKs88F32B9x2lK7MYTdQQK81Fc4s
	 RP5S8MaAS/gzvIVZ4HVIVxyvKt+wrRilhvppRPcm7TLDM/lsErkXgG3WxEKSxNntjL
	 ZZFgPubWJezlqOoEtZhlmHF00dCNFT6WfbxEuc4JBEhaR7hQVd/1dndsI3M5adZOHv
	 q8517qwAVuMcyIGsrxHdt7Wo00rDCFxGJjJwFNShT2V+BOCVt469AdrzUO9sikzgDF
	 Mr9364851UC5w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/8] tracing: tprobe-events: Reject invalid tracepoint name
Date: Wed, 26 Feb 2025 15:18:54 +0900
Message-ID:  <174055073461.4079315.15875502830565214255.stgit@mhiramat.tok.corp.google.com>
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

Commit 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on
future loaded modules") allows user to set a tprobe on non-exist
tracepoint but it does not check the tracepoint name is acceptable.
So it leads tprobe has a wrong character for events (e.g. with
subsystem prefix). In this case, the event is not shown in the
events directory.

Reject such invalid tracepoint name.

The tracepoint name must consist of alphabet or digit or '_'.

Fixes: 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on future loaded modules")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_fprobe.c |   13 +++++++++++++
 kernel/trace/trace_probe.h  |    1 +
 2 files changed, 14 insertions(+)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 8826f44f69a4..85f037dc1462 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1049,6 +1049,19 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	if (*is_return)
 		return 0;
 
+	if (is_tracepoint) {
+		tmp = *symbol;
+		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
+			tmp++;
+		if (*tmp) {
+			/* find a wrong character. */
+			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
+			kfree(*symbol);
+			*symbol = NULL;
+			return -EINVAL;
+		}
+	}
+
 	/* If there is $retval, this should be a return fprobe. */
 	for (i = 2; i < argc; i++) {
 		tmp = strstr(argv[i], "$retval");
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5803e6a41570..fba3ede87054 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -481,6 +481,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
+	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\


