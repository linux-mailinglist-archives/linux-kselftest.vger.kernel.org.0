Return-Path: <linux-kselftest+bounces-10993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A68D5EAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714D3286518
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D977136657;
	Fri, 31 May 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RciYkpdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA9133993;
	Fri, 31 May 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148622; cv=none; b=n3l+ffv4D9fs9LDZ3OxE7046s+82LaIBMA2f1cxiIHapgeEI2CRR9KEujRp2SA974N+ajTEJ6tNxfzYkVkpQZyUx89Uj/f9GrVbStyQe2Iz7LplS5IOUXJjWc+ckBFwCk/ML9XBVooWZGmR9913JwN+7vRWTYpLcpOZayR0M3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148622; c=relaxed/simple;
	bh=KIRMeRLfAg2SfzPVmF2jfjZK9BOA5aUG46aIO9jkl5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikCayL9KJ0WUWotOIleaxnO4GolOfUFtqdXUc2k11Zled3KH+WaUSXTSzPFWpx1mLln4Kpcid9IuDD2bE7K75j4JyzkSGEN/IE9h/mH2v+uwM9lI/PKm2ez9Rm3ZY+k9PMUPfKCXHtYi6Sl9KLJD5cD8DRLooxJwqdJOkvoDEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RciYkpdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D226C116B1;
	Fri, 31 May 2024 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148621;
	bh=KIRMeRLfAg2SfzPVmF2jfjZK9BOA5aUG46aIO9jkl5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RciYkpdXpJWT8QaHFwbj1Bh82LBXeCOws7iQk1BBlY5vhqpXkNIxnO9Fq7XI/FPU6
	 vShzrLPHJ+6E88TEMoA69hJhGQ0BFgpQTLE7hnWS5ktoD0dU8NPvBi9wH53e3j4uG8
	 IX1grK6gn6heXUxnlA5Lo/lJa3iFXdwVh4W4ZjhCynS0j2t8z5SmjdxSby2d3Sszvm
	 0BvZ7mNoXzNy2sbJrx7S6TJNwoMHFuW5FJPq4aWzc53f44bnyECT9/aCcjWhDJk0dO
	 0ChA6G8XozeDGgGvZP6glJP2vXWXvMNHibdLHL/X/J6JTHrhOQAVPyR/TAEUEF0AcI
	 ZEk3EA6oeTF6A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests/tracing: Fix event filter test to retry up to 10 times
Date: Fri, 31 May 2024 18:43:37 +0900
Message-Id: <171714861780.198407.16488694516653649947.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171714860864.198407.18416314586430149538.stgit@devnote2>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
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

Commit eb50d0f250e9 ("selftests/ftrace: Choose target function for filter
test from samples") choose the target function from samples, but sometimes
this test failes randomly because the target function does not hit at the
next time. So retry getting samples up to 10 times.

Fixes: eb50d0f250e9 ("selftests/ftrace: Choose target function for filter test from samples")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/filter/event-filter-function.tc  |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index 3f74c09c56b6..118247b8dd84 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -10,7 +10,6 @@ fail() { #msg
 }
 
 sample_events() {
-    echo > trace
     echo 1 > events/kmem/kmem_cache_free/enable
     echo 1 > tracing_on
     ls > /dev/null
@@ -22,6 +21,7 @@ echo 0 > tracing_on
 echo 0 > events/enable
 
 echo "Get the most frequently calling function"
+echo > trace
 sample_events
 
 target_func=`cat trace | grep -o 'call_site=\([^+]*\)' | sed 's/call_site=//' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
@@ -32,7 +32,16 @@ echo > trace
 
 echo "Test event filter function name"
 echo "call_site.function == $target_func" > events/kmem/kmem_cache_free/filter
+
+sample_events
+max_retry=10
+while [ `grep kmem_cache_free trace| wc -l` -eq 0 ]; do
 sample_events
+max_retry=$((max_retry - 1))
+if [ $max_retry -eq 0 ]; then
+	exit_fail
+fi
+done
 
 hitcnt=`grep kmem_cache_free trace| grep $target_func | wc -l`
 misscnt=`grep kmem_cache_free trace| grep -v $target_func | wc -l`
@@ -49,7 +58,16 @@ address=`grep " ${target_func}\$" /proc/kallsyms | cut -d' ' -f1`
 
 echo "Test event filter function address"
 echo "call_site.function == 0x$address" > events/kmem/kmem_cache_free/filter
+echo > trace
+sample_events
+max_retry=10
+while [ `grep kmem_cache_free trace| wc -l` -eq 0 ]; do
 sample_events
+max_retry=$((max_retry - 1))
+if [ $max_retry -eq 0 ]; then
+	exit_fail
+fi
+done
 
 hitcnt=`grep kmem_cache_free trace| grep $target_func | wc -l`
 misscnt=`grep kmem_cache_free trace| grep -v $target_func | wc -l`


