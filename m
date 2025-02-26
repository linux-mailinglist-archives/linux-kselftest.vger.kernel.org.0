Return-Path: <linux-kselftest+bounces-27558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC3A4556F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A1174E5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2E25D55B;
	Wed, 26 Feb 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6bA4kPb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6616DEB1;
	Wed, 26 Feb 2025 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550730; cv=none; b=bowyyKRuldU7mEw8qTtR3dOg8m95AE+Pm02i5xgWEJzjYDYuf25+Wva2zBpJK3J2OaxOtv0ePx6GRDiZPVMR4pG21cBxBSNDBVC/eI5A4UeczMmJhvk1CLuVOcOtwQ0m3rQAugZ1/c3OGzFSsVsosZ79h5OrovLal3EsQx9PlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550730; c=relaxed/simple;
	bh=+bFB+UIXTzShMgtc9dzzTezRum4ZGFk351/mwu8Mh0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB02nCtyOI1N3vDmXJQMRJ+6Lbnb1VFAxb+4sjXyZiwWSUQI3m558SFwZ1WcSD0BDyK2t3HKIYTBjadWi2pa/52bXCxyV9yABl7cHJduOrHeOogtRh3fDVY19bcBhH/b2upgp/ix7fVMXvy6yQmdpbRjulZLL5eBzLjvAcAO7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6bA4kPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FDEC4CED6;
	Wed, 26 Feb 2025 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550729;
	bh=+bFB+UIXTzShMgtc9dzzTezRum4ZGFk351/mwu8Mh0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6bA4kPbQSHFPdwwfPe9oiGcgJW9ldf26wrGzFXYaBpWYCTRu0yjVe9/s9PuJoDxc
	 pSukI92q5INSKqXbybhANoBdOnsgA3poZjfmjfvi1CatCDkOZ6RcjFnCtFbq+aSD3s
	 2eugAHFeHi7ojcAYRRP7jbqIWOhANc4p9Cxsy9CERE0BrsBNoJ872VfuDWHuxEQyG+
	 xDOiA9aAeDAdmEDugyuCP19TCvxeq7+1oJHEmJOeNFIWHpR3/n2zv2aX8ENFGWMw/Y
	 XmAPBIXAhCVXBM2O6vHrhdbYx158LKxcaTJvKnjUD17GPizs1VY/6pII7c0Jjaad0G
	 P13HM/jQ2QMnA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/8] tracing: tprobe-events: Fix a memory leak when tprobe with $retval
Date: Wed, 26 Feb 2025 15:18:46 +0900
Message-ID:  <174055072650.4079315.3063014346697447838.stgit@mhiramat.tok.corp.google.com>
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

Fix a memory leak when a tprobe is defined with $retval. This
combination is not allowed, but the parse_symbol_and_return() does
not free the *symbol which should not be used if it returns the error.
Thus, it leaks the *symbol memory in that error path.

Fixes: ce51e6153f77 ("tracing: fprobe-event: Fix to check tracepoint event and return")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_fprobe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b8f3c4ba309b..8826f44f69a4 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1056,6 +1056,8 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 			if (is_tracepoint) {
 				trace_probe_log_set_index(i);
 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				kfree(*symbol);
+				*symbol = NULL;
 				return -EINVAL;
 			}
 			*is_return = true;


