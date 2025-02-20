Return-Path: <linux-kselftest+bounces-27104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDE9A3E462
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B613A463F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CA2264637;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67672641CA;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077899; cv=none; b=hQFwv7jFqJPic/4MY2YXEaoR3eSdj2kCZK7upzhZTH7djgeIZH27PBkCQOdPoxPQAFTdX49Bz+TpLC/DnH7rHz+D6pxs54DXZ4pnNi+JbduERdQTXZv5UDCd/uLWMwL6lFTVo0BiZgCbGv07puZdVtbfeVvk53/fpNt1N5ns9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077899; c=relaxed/simple;
	bh=lPuj0ekgwa4nGe2Psfs+Hs0cZVNwWFBLvLFT3XB+EUQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kQUXOj2pEFJOjN577nCCcQiqW7IrnYug9IBGmcyeM6hCCdc5004H4beayhulMf+hcVVxAnZ6ElCuD89JqHwt2O9yvq8JbTWx89C6kDjnwW5pwB4rE3Nv7UCNumutmcNnbUEw8GBncIXV+gsLo2VMY4iL+fvvGursmQYNsgjAWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41139C4CEEB;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlBl0-00000005cSN-2WIK;
	Thu, 20 Feb 2025 13:58:46 -0500
Message-ID: <20250220185846.451234966@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 13:58:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [RESEND][PATCH 3/3] selftests/tracing: Allow some more tests to run in instances
References: <20250220185759.811830333@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The tests:

  trigger-action-hist-xfail.tc
  trigger-onchange-action-hist.tc
  trigger-snapshot-action-hist.tc
  trigger-hist-expressions.tc

can all run in an instance. Test them in an instance as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc      | 1 +
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc   | 1 +
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc   | 1 +
 .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 1590d6bfb857..20a35fea13f8 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger expected fail actions
 # requires: set_event snapshot "snapshot()":README
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 2430f541cd5d..55ab0270e5f7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
 # requires: set_event "onchange(var)":README ping:program
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 334595daa9f4..9eb37c2fa417 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
 # requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
+# flags: instance
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
index 05ffba299dbf..0ebda2068a00 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test histogram expression parsing
 # requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log "<var1>=<field|var_ref|numeric_literal>":README
+# flags: instance
 
 
 fail() { #msg
-- 
2.47.2



