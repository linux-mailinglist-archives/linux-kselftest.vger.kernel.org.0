Return-Path: <linux-kselftest+bounces-10172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E48C51BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 13:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A508D1C203BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5C13B58E;
	Tue, 14 May 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBFdNruK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96113B287;
	Tue, 14 May 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684979; cv=none; b=Ldm7auyCKDdrARj5AgkzoXGsHVFYvkYta+TYXUuyPraVhadBjY6PD2vX0df4HtZSt0B2W20yNJTfdE2GxDiv/xogRfvqgD0YaS3VTSlUx601NCcUBOC+0ZoWrGELTjRIamxIwVr7A18DfGe2kqBfCzPbsMdDhq1oiH7GKV0cUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684979; c=relaxed/simple;
	bh=Eb4+G+aHG2Vm3e3joQm1/LUC2P6jFfU1JpRJhMDV0UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjUtHb79eAwwM2yn+8q0MehlhnHMCaxTEkWObUGnGMV3dRvae8KgIkwy7IYddiZaJb5bGYMoTpQd5gttxVLHT0/RgVllIqSFCuTmTMrJW9X9FO1llAei2ooiXpaEQcASGKJvcoUEwQbdSGunFCkLQcBt5BVFeRBc9gI3ECBIznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBFdNruK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E00C2BD10;
	Tue, 14 May 2024 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684979;
	bh=Eb4+G+aHG2Vm3e3joQm1/LUC2P6jFfU1JpRJhMDV0UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zBFdNruKfagjLlrNQIjHDwJW8akndQYTS7s2XRDE0sKBz+TH42qeTn6v/zlqqtp/n
	 BuoGUq6cAxV4bEA8EBiZxUKT0ekM5G8k/2wZZBM+P4yiTKSUecFcC2YXMAmu5Sthip
	 Oo3FbofbC3kT3aUxwOWhn3Pe6DpAAA9TMSX781JA=
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
Subject: [PATCH 6.6 116/301] selftests/ftrace: Fix event filter target_func selection
Date: Tue, 14 May 2024 12:16:27 +0200
Message-ID: <20240514101036.629901920@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




