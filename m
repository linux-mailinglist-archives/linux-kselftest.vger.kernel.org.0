Return-Path: <linux-kselftest+bounces-27562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55540A45576
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8683A188C8E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BB267F56;
	Wed, 26 Feb 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERR1doFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7C266F07;
	Wed, 26 Feb 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550761; cv=none; b=BWUy1HEje6aDqlKxsoh08oJA1OiGNU+qoMiYY3M8VBHEuj6wnvqdbM6YtZ0kKd00MR4ZQQhm0cftj8gDFSmw/6/m2l3yoy2f1D4xqd6aFlTJ8fSIJ7pxQbAZ+ly2LWFSptOKwgvOXyMg1HMpbdwJOsr/o4aBaqAflluYdlhjUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550761; c=relaxed/simple;
	bh=A3IrqD3/pDT6M/w+w7YSAeLSdPShreoTsKFR3QXVzBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkQP1dSnpzoxLR273UkYrpE6icZDe35hDdcjNMZdUhJTAKdYW8j96LwvgtKlHedDTeGtazBeEg8V0vOEb1i2jTXng3wkgKksHmErWhozm000YhcW5F6JbCr4nOgajPvpLlE4OGhrBv1Ut0traA39l07Xse0r6b3f/Xdtp1gNl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERR1doFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C07C4CED6;
	Wed, 26 Feb 2025 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550761;
	bh=A3IrqD3/pDT6M/w+w7YSAeLSdPShreoTsKFR3QXVzBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERR1doFUFIJE93Hx//c9t6RYC5uo+pxk/l2U4ZvsSaErsVJoUGbQmRCmg1Y2UX1Fl
	 8+c7f8mT0RzYXtZbDATl7uQw4kdk8hIGRuvtu6ch+qyLyPGlZs5TVUqZTZsUMGbSrs
	 UTFtLCXAgcJXgzQEabXim3q9kyKYl6xoNGMm+CXoZbL+Tar6HdYvdjh0mx9VxJ1ZpS
	 tKRR+MrEtx11vSSoGgIVC/TcN4txD5cqtSRPVrRPfqfT0xjA/zWXB+ab3MMOPei4Zc
	 diwCsk2Lm4vsLrY2JNPZ/HSLUoTT/Ebrh5mFmSs4p0g2PxYwGtMesLZvwsrOzrVj1a
	 m+CA4ZzeKo6lw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/8] tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro
Date: Wed, 26 Feb 2025 15:19:18 +0900
Message-ID:  <174055075876.4079315.8805416872155957588.stgit@mhiramat.tok.corp.google.com>
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

Commit 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all
function args") introduced MAX_ARG_BUF_LEN but it is not used.
Remove it.

Fixes: 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all function args")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 6075afc8ea67..854e5668f5ee 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -36,7 +36,6 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
-#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"


