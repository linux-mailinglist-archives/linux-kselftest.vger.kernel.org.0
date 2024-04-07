Return-Path: <linux-kselftest+bounces-7360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6889B170
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2861F20FBC
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE276058;
	Sun,  7 Apr 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkigIZh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105D71727;
	Sun,  7 Apr 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495539; cv=none; b=lFP/IC4RLbfS0kaE1AUPAPclr2JIZ1RXgQRH6wVhNEqAApGS3vQzdlZ/L7oL8bYp/f9ZwVAiQDCZ3na3sg1XUP/NnOZRLev01KFRG0/QPL7inSpIV2DHi+LpC6cTQinBjscuQqM1vprerbwcIc0Y+4ObXTCZb/hmZHJqHnU69Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495539; c=relaxed/simple;
	bh=qfumTN75Biop/xeKFRs0/EeNWjogEzXi25BSL9mRoAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1eIfKBuGnTY085uvOaOKgPcE2e7pjTPuxbbeeGbtg32mUePzg5D6WCwtqyB52zrGvH2SmvKAi6CMppYGwiLnKaC+F4rR7MCzCgvzs+Hq/oxuHC/3hZT9zP86dty1SXzoJzwfl5INojMNha/5r7ft9iODTOad91+eD9V2STw69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkigIZh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35651C433C7;
	Sun,  7 Apr 2024 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495538;
	bh=qfumTN75Biop/xeKFRs0/EeNWjogEzXi25BSL9mRoAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkigIZh0KBwBxqsOmdmTQ25ClH+PGg2QhyltZZvOF6AhrB5PGrCsxsIoc9zmql83y
	 359nGpTRBdZV0vQkTQWV/240LH5PL3fIf+ZB55nmuWNYppqkeHToOIXdpcRwPmSn2F
	 0a9aPtnWcQK438dwLHvdz0aop3O8uqDt6oNsSgCVJiigYT26UQUlh1+cuLg6XVax8d
	 lXiFVRCcBIzJJBgCKmwDBiY43Y7Nv1xME/CMdsZdPMp5hMWXAhYKaulMDAwy97ybhf
	 PGLN9XpM0qP5Rx8V8BsNb92nJCbpVtbQMJLzOdSX9mjqXzi+5zdQIPEt3cWkLcuoGP
	 ewOWxLYbJDc2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 24/25] selftests/ftrace: Fix event filter target_func selection
Date: Sun,  7 Apr 2024 09:11:12 -0400
Message-ID: <20240407131130.1050321-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

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


