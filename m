Return-Path: <linux-kselftest+bounces-7362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38989B1B5
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8497AB20D36
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B165127B78;
	Sun,  7 Apr 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txeyr+V2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E759127B61;
	Sun,  7 Apr 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495589; cv=none; b=MX3JDA84FRsf3rpaR/N9E4vWdHZqnYZOSXPWNqj1F/rwNxJqGI/8TnRnI/9FfxspxJoRx1poRMAsdP4tUm+wfSBNsWEvF5Rp4vtIlOPYMnOFheS94gO4gvZrBZj5ICZ0z/YQHJ2PBHz12jgVcI9ajWiglBvHyseu6xtiTPRSxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495589; c=relaxed/simple;
	bh=qfumTN75Biop/xeKFRs0/EeNWjogEzXi25BSL9mRoAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuyMsFUQPmPGU5k4QVd4wrMFq8iV3bT8IMxDhwW77J74cjNPL6eD/93rt5M3GmQ9D9Djf9+9tQ8P0lZawV+5V7dOdC011BcJZNphSZTfjA2/FfwHoE9W5UNKMt5cLNaJJmd66+qhe4GhfplffXrHjhaoxEMdo9ajUQ1CDNuTTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txeyr+V2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1294DC43394;
	Sun,  7 Apr 2024 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495589;
	bh=qfumTN75Biop/xeKFRs0/EeNWjogEzXi25BSL9mRoAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txeyr+V23QNHtLZIpTm7lQODmn/g36K+nS8/b6Lcylz2kzxHPYeM8VJdDK8Imc8rF
	 GtBHKQVO3wZQeWp9q5kRaAjU3QAAopkhSx1ntda3/advyPKVIzSxa1z0zkub3jomIx
	 Ri5wTKPU21BOUpzA85xr5/uiMYpG4/hEC8+S3nr2KJ0adnQonISJGZHVPQgFYh2+G6
	 AR21gj50eHWMQgbmNDml8MOpn2oVWPuUfTrSa/ctKZCVLsoVfyHAWPGxk9NUs1ywYl
	 tQhUBU0SUDi7t3TLNyahwExUCt9fL5mWSBZqBUgFvbswPZ/nHcfG99xvPnafXu8M60
	 2ZXYCUH8G16fg==
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
Subject: [PATCH AUTOSEL 6.6 21/22] selftests/ftrace: Fix event filter target_func selection
Date: Sun,  7 Apr 2024 09:12:20 -0400
Message-ID: <20240407131231.1051652-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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


