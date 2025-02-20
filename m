Return-Path: <linux-kselftest+bounces-27103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C46A3E461
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EEA3A1CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974826462E;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1312641C2;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077899; cv=none; b=eY8xpdNhv8T7N52O6xLf+TsQl3hic6vhwiTRJQOjhA5iGsmYHcejml0eSwaKkv6q16IHjJrlhEYrvGQ4osikWUkNyP7ZOTylSEdUn4hCNB6JBmk5P3NgFaW1Zm0zWrQdLWB07ghV8wvROyKcSxKzAZWdq0agjDkP69mzhKCnFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077899; c=relaxed/simple;
	bh=JIeJKv1D9tRmGCPxA3yF5nAK/eVKLIsMo8diAYkiolc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=I3/D44eRBzUlZZhZes4j6KuWreYTrVfiwx1vj3gbcQzNX1gQzo6dtt/CmlJ5PjfPCgvp9AtB+1KDMu0eXSOR49y6h1oMYVvTDHOmmf0NIjXm1lhkey/blN5tN1mfTFrS+jE7eE+Ia9zLPM/o2N3Z0c3/2OxO2wtLPtin3FLrluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA2CC4CEE9;
	Thu, 20 Feb 2025 18:58:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlBl0-00000005cRt-1o54;
	Thu, 20 Feb 2025 13:58:46 -0500
Message-ID: <20250220185846.291817731@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 13:58:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [RESEND][PATCH 2/3] selftests/ftrace: Clean up triggers after setting them
References: <20250220185759.811830333@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The triggers set in trigger-onchange-action-hist.tc and
trigger-snapshot-action-hist.tc are not cleaned up at the end. These tests
can also be done in instances and without cleaning up the triggers, the
instances can not be removed as they are still "busy".

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc  | 2 ++
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 91339c130832..2430f541cd5d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -19,4 +19,6 @@ if ! grep -q "changed:" events/sched/sched_waking/hist; then
     fail "Failed to create onchange action inter-event histogram"
 fi
 
+echo '!hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 147967e86584..334595daa9f4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -27,4 +27,6 @@ if ! grep -q "comm=ping" snapshot; then
     fail "Failed to create snapshot action inter-event histogram"
 fi
 
+echo '!hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> events/sched/sched_waking/trigger
+
 exit 0
-- 
2.47.2



