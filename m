Return-Path: <linux-kselftest+bounces-44192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D12C15D3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208301886D31
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25D32D440;
	Tue, 28 Oct 2025 16:26:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CF286415;
	Tue, 28 Oct 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668817; cv=none; b=JsWfhcxgshq0lhuZzIvXmYPvujI04zjmHWmVvFsMKxEKzNPfIB+IJ53tT7XPYZ16TqIdA99RFqLeS7xby3Ibdr9TIdB5VXY1Ek6vpo6K4sNnTNuFHKfiDaCd/fq4dB1y+zPUmxGWbHRGzlUS8zGS2B7hAIV0fndRcKUYTzPppoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668817; c=relaxed/simple;
	bh=LD8MvwssQiWl+d/QuJEg48Vu0A8s87sdWrIEIaRyjDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mgVtVjLy8Yug/yu2oRicQmrJZZmQr9OPVGMCBusoHEGL1nTBN7G6NNsayy7RtE9Q6xx5yi9wqXQ41JUS+7mTqFNKy3e7lFOYNBToGU6+/yT5rOoyKbV9y3LgvI6+Tipf9nFcgdy6+CELpSQbM62ADF854+XFTGpDrEv+PZXqfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DB42C1A04A7;
	Tue, 28 Oct 2025 16:26:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0DBE320029;
	Tue, 28 Oct 2025 16:26:45 +0000 (UTC)
Date: Tue, 28 Oct 2025 12:27:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] selftests/tracing: Run sample events to clear page cache
 events
Message-ID: <20251028122724.4bff9853@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0DBE320029
X-Stat-Signature: b36zitz545bo1f7atp3fc8wgkt9t5493
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18R6uyl0b4N+ahRu51ICAPV7bHwLuirGLs=
X-HE-Tag: 1761668805-879148
X-HE-Meta: U2FsdGVkX19I+UxyGmayQcgJ8Z8VBodmygjMeDUKs3dReRKuwuLxvZMB9zs2N2V9p/JK1ziWs2hGK+WDWcjBqaz9qZ+zEmmvTasVi5jzoA0N2PHLE+c9uuoQXqkDpcFjCba3uE/H7W8HACjxdOjHBoeDNZjsNfVCeufPJd4aTwVmbbeo6+CFHe/H5jBQ+wR5ClUpi5tcCSKPztIy1carw/LY8RqyJUThUWzK0Ay5VQF28OY1JMPkZNVXC5Pi4QuIVJu6k/hTovvRJ2zR+mb9i2GIlWpexUv7Znn3mbvM9S1Y9mzlF3P7S9qBv1ZHoReaOqq821T7dnjqdmBwRGzqf1vaKzLs2Ou2hVPthDigzUcOMf/Dd/IUTWwAF74uZCu5E5QwbLMclSitHAEKZtIqGQ==

From: Steven Rostedt <rostedt@goodmis.org>

The tracing selftest "event-filter-function.tc" was failing because it
first runs the "sample_events" function that triggers the kmem_cache_free
event and it looks at what function was used during a call to "ls".

But the first time it calls this, it could trigger events that are used to
pull pages into the page cache.

The rest of the test uses the function it finds during that call to see if
it will be called in subsequent "sample_events" calls. But if there's no
need to pull pages into the page cache, it will not trigger that function
and the test will fail.

Call the "sample_events" twice to trigger all the page cache work before
it calls it to find a function to use in subsequent checks.

Cc: stable@vger.kernel.org
Fixes: eb50d0f250e96 ("selftests/ftrace: Choose target function for filter test from samples")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/filter/event-filter-function.tc   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index c62165fabd0c..003f612f57b0 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -20,6 +20,10 @@ sample_events() {
 echo 0 > tracing_on
 echo 0 > events/enable
 
+# Clear functions caused by page cache; run sample_events twice
+sample_events
+sample_events
+
 echo "Get the most frequently calling function"
 echo > trace
 sample_events
-- 
2.51.0


