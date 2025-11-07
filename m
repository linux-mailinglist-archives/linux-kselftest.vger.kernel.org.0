Return-Path: <linux-kselftest+bounces-45106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E196C40668
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8CC3A5D40
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140382E0406;
	Fri,  7 Nov 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ6HY9oW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868B1F5437;
	Fri,  7 Nov 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526107; cv=none; b=gQ8wWtc6cShwMhi4CqpTUyrZK/NHaAzzHObMjPhMWEgfdYZ1710jf2c32K11cpHgU8t8JLrDeowxyCr9lN+dwK0csyWOLlDdOfzh5ko10LQ2/Ay67mk7VgR8hj5oKywJuTbcnksVWROsZSPn6FYLuxf5uwWsAgO2ST8GqKwzGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526107; c=relaxed/simple;
	bh=4WxZ3LELg5mcq0Cf6czbnjewj3p8Wpjhfzv3KyuE0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJxVvLReK+es4FiSM1T4gsKkkEavcfR0dobAwiP00pWUewW8t0wg1Kmw4eAKO/C1QuJVznxtolW7f6VJC9NYQhD9NKt/YpiqnwNVSizo3lfZPfyPOd3+hCZqgldt8meZ+qgypmd9y9E32pVyRwvBUTshzXC9N8iTHN45BLcn4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ6HY9oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C3EC4CEF7;
	Fri,  7 Nov 2025 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762526106;
	bh=4WxZ3LELg5mcq0Cf6czbnjewj3p8Wpjhfzv3KyuE0Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=rZ6HY9oWMDLs4sKC636BgUJ3shrDAORr4y9nl8IEHEFQUkjYIbl1usP7n5DMkq/yX
	 piXUq9g5Q8BUx1wtNC5Cfc9GTCPBfOOrEk/gpTtqFr3fwSSEY9XLOIimUkgexO74HT
	 vMPS07UJyPSl7y8vopWbM2cTA0ZkPey34HfYrVfTWTC1jNuR4TkmJKnna92hvoTQ5L
	 r6kLfMD8sy7tW2LG5bE37smpRTI+85Av235q9sjcQWk9E3VdFIbISxSaIUQubsnycI
	 MpObhyawtyI9Mys/rqKmROaFpQxa63j0FezQKZtZp8SlAS5QvSJrjhFiqDXQpoKVDr
	 XNXLVClpoPHOQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
Date: Fri,  7 Nov 2025 23:35:01 +0900
Message-ID: <176252610176.214996.3978515319000806265.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
enable tprobe event") caused regression bug and tprobe did not work.
To prevent similar problems, add a testcase which enables/disables a
tprobe and check the results.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/enable_disable_tprobe.tc       |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/enable_disable_tprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/enable_disable_tprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/enable_disable_tprobe.tc
new file mode 100644
index 000000000000..c1f1cafa30f3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/enable_disable_tprobe.tc
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - enable/disable tracepoint probe events
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TRACEPOINT=sched_switch
+ENABLEFILE=events/tracepoints/myprobe/enable
+
+:;: "Add tracepoint event on $TRACEPOINT" ;:
+
+echo "t:myprobe ${TRACEPOINT}" >> dynamic_events
+
+:;: "Check enable/disable to ensure it works" ;:
+
+echo 1 > $ENABLEFILE
+
+grep -q $TRACEPOINT trace
+
+echo 0 > $ENABLEFILE
+
+echo > trace
+
+! grep -q $TRACEPOINT trace
+
+:;: "Repeat enable/disable to ensure it works" ;:
+
+echo 1 > $ENABLEFILE
+
+grep -q $TRACEPOINT trace
+
+echo 0 > $ENABLEFILE
+
+echo > trace
+
+! grep -q $TRACEPOINT trace
+
+exit 0


