Return-Path: <linux-kselftest+bounces-10171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AF8C4FFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DB91F217D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBD7F490;
	Tue, 14 May 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkPugluX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C87D531;
	Tue, 14 May 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682815; cv=none; b=dnHUDkhko0LY6jCCLRyIHdEOtfLlEgCCVRPuP1wph09a/FA3M2OD7nAacYu+IWJERxFrhyNRWB+HflewX9/i224Cdy99fWYJza+h90gAXZSCEfVqP19NYnWcD+vJB9oF0q6/d7P8FpXKOxRiOQcrcnFxWFKFdkdE4frtHFbi7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682815; c=relaxed/simple;
	bh=NCYPld70qYshmpCzGEhpslZFD4dlvSlpfznYMRZF0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN5o0NB/HXk54ZxGbMuomBsdtyjynJT+F/OgGmlLQ+zv8nWW7A30n/4PPJHnh8Jctuijc9niXwg4lOi3US/jkJiifDYS88VlDCRvY2fP4remNufO0j74zGg7o2cGrOZdmjKG87qJBiBvy1RlYONnYRD17pXv+Zav575fc7xMz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkPugluX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01045C2BD10;
	Tue, 14 May 2024 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682814;
	bh=NCYPld70qYshmpCzGEhpslZFD4dlvSlpfznYMRZF0LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkPugluXmDu6jINKTNGmZa2uLAALdZQAZwWg7Y55dEYGsQBYKVgK92c6SYi6aObpV
	 8/7fqN8JddDKK4XpeAseWbnHOUKF8MlYy3WKFT1i6BxjvklOXUGSzkZu7+hr6J4YI4
	 dfa7GR0oKSfgPQ+pBA2NrdYUEk9gPUgCjk17IxqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 118/336] selftests/ftrace: Fix event filter target_func selection
Date: Tue, 14 May 2024 12:15:22 +0200
Message-ID: <20240514101043.058135845@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 8ecab2e64572f1aecdfc5a8feae748abda6e3347 ]

The event filter function test has been failing in our internal test
farm:

| # not ok 33 event filter function - test event filtering on functions

Running the test in verbose mode indicates that this is because the test
erroneously determines that kmem_cache_free() is the most common caller
of kmem_cache_free():

  # # + cut -d: -f3 trace
  # # + sed s/call_site=([^+]*)+0x.*/1/
  # # + sort
  # # + uniq -c
  # # + sort
  # # + tail -n 1
  # # + sed s/^[ 0-9]*//
  # # + target_func=kmem_cache_free

... and as kmem_cache_free() doesn't call itself, setting this as the
filter function for kmem_cache_free() results in no hits, and
consequently the test fails:

  # # + grep kmem_cache_free trace
  # # + grep kmem_cache_free
  # # + wc -l
  # # + hitcnt=0
  # # + grep kmem_cache_free trace
  # # + grep -v kmem_cache_free
  # # + wc -l
  # # + misscnt=0
  # # + [ 0 -eq 0 ]
  # # + exit_fail

This seems to be because the system in question has tasks with ':' in
their name (which a number of kernel worker threads have). These show up
in the trace, e.g.

  test:.sh-1299    [004] .....  2886.040608: kmem_cache_free: call_site=putname+0xa4/0xc8 ptr=000000000f4d22f4 name=names_cache

... and so when we try to extact the call_site with:

  cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/'

... the 'cut' command will extrace the column containing
'kmem_cache_free' rather than the column containing 'call_site=...', and
the 'sed' command will leave this unchanged. Consequently, the test will
decide to use 'kmem_cache_free' as the filter function, resulting in the
failure seen above.

Fix this by matching the 'call_site=<func>' part specifically to extract
the function name.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/ftrace/test.d/filter/event-filter-function.tc     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index 2de7c61d1ae30..3f74c09c56b62 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -24,7 +24,7 @@ echo 0 > events/enable
 echo "Get the most frequently calling function"
 sample_events
 
-target_func=`cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
+target_func=`cat trace | grep -o 'call_site=\([^+]*\)' | sed 's/call_site=//' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
 if [ -z "$target_func" ]; then
     exit_fail
 fi
-- 
2.43.0




