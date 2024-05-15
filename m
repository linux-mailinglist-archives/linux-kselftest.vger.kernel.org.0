Return-Path: <linux-kselftest+bounces-10231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC08C6030
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 07:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A681C20CD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0E3A1DC;
	Wed, 15 May 2024 05:36:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4013A1B0;
	Wed, 15 May 2024 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751388; cv=none; b=LY4fQZoJIIlUVDi/apEmEwo9ecQuOwh943GzTjdpXI0KXzRzQqlIaAuY2wcGnnhEwwR3psJAYsdXs3NsUJTFNeB3Ewh4UNwt7AKS/Gu9lKmpZBBnrOMLKd1oSBlS9diWgjnjBLN4UfPv+sZQRSV07emm2BssSugQyAoYzMs1Awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751388; c=relaxed/simple;
	bh=c94//jp1PE5EDDwmY7Ielx198lHnxvyElpsaJQ+yI+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YAesdkDnf+LudqI901xPrHeTZVtCtg2AMjPl6TTlvuddbauFmRifTW4EILN5EMqX9CiqBX2TMG6T+t29pdbAMKMtttosxrVEsyLV1MMKdFHFpxm2SZmsz3TiU2Wx8IvrYZsbOe9t+y3KQcwuZsV9WZTa076V8VtpTr2qbA5nixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B008C116B1;
	Wed, 15 May 2024 05:36:27 +0000 (UTC)
Date: Wed, 15 May 2024 01:36:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Shuah
 Khan <shuahkhan@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix test to handle both old and new
 kernels
Message-ID: <20240515013620.098cb37a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function "scheduler_tick" was renamed to "sched_tick" and a selftest
that used that function for testing function trace filtering used that
function as part of the test.

But the change causes it to fail when run on older kernels. As tests
should not fail on older kernels, add a check to see which name is
available before testing.

Fixes: 86dd6c04ef9f2 ("sched/balancing: Rename scheduler_tick() => sched_tick()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 073a748b9380..263f6b798c85 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,14 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="sched_tick"
+if grep '^sched_tick\b' available_filter_functions; then
+    FUNC2="sched_tick"
+elif grep '^scheduler_tick\b' available_filter_functions; then
+    FUNC2="scheduler_tick"
+else
+    exit_unresolved
+fi
+
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.43.0


