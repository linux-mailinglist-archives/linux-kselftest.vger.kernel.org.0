Return-Path: <linux-kselftest+bounces-27565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4261DA45580
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5148F17BBB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5526A08B;
	Wed, 26 Feb 2025 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfd2uNRO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8A25D537;
	Wed, 26 Feb 2025 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550787; cv=none; b=n9T5lQOt9NhS6lONrW2CJwA0KhUuO2SKmYiEg8XqIAbhaUGrRbGtk3BqXXDp/ECE1goO09zQYAaUyRbg8gT9snrFj/9+qn7w2XMAv8HPfVYzq9UQjtFGof1YaOjaDD3TLsQkXIy84E+u/un98mi2wOzg7rbudBV6tiKDFn7KDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550787; c=relaxed/simple;
	bh=CDnh/F6yJJZro6R0MIKigGgnvX9Ri5GL0GCDeg3C3l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILD0zelmcq7bSg8dDpfw2bIGeu+eGDLePsacUUljTRnC7dYPFRi5+8EwhvsfiRsrduinxJNgOPchshyJOlC0HPJFjUZ6zHIUl1TLR5CpGcVZetMf9dL3O4YdTEiEsP7H/H9g2fnzd9tXZQlNrbafnaIRqQiGZ5APcIT/LsMggCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfd2uNRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D828C4CEE2;
	Wed, 26 Feb 2025 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550786;
	bh=CDnh/F6yJJZro6R0MIKigGgnvX9Ri5GL0GCDeg3C3l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wfd2uNROPQwZgTHXi+QlKkAae7QnvEoW1s0Clv3rWUBZvFJW/kUG+YaI4Qwd50rl0
	 9zZvTyEIh3mImIeqGTbfhyE4NfIPh8SJWO84W/Ki9ToargIrI1IeBF+F1QWKyw5tMR
	 xcSikvVaV2blHkItD9JNF+zBTfYNtAh/cdeqi6XsUZahm2TKqoVi5rIaLp4xLaU5zC
	 QhpGptj++qMBQfbqJy5+5pJ+cwCatN8o315HVstCxIdpzjm8Y2hwIeXlVl3KBgui3C
	 VkghvqTzO/8uokKTP50+9Rs5ah1nejHhfFFQqSclhxFEZtsSkjNOQmRGvVOzzQkgi0
	 eKzWcVnz39DtQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 8/8] selftests/ftrace: Add dynamic events argument limitation test case
Date: Wed, 26 Feb 2025 15:19:43 +0900
Message-ID:  <174055078295.4079315.14702008939511417359.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
References:  <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
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

Add argument limitation test case for dynamic events.
This is a boudary check for the maximum number of the probe
event arguments.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/dynevent_limitations.tc |   42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
new file mode 100644
index 000000000000..6b94b678741a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Checking dynamic events limitations
+# requires: dynamic_events "imm-value":README
+
+# Max arguments limitation
+MAX_ARGS=128
+EXCEED_ARGS=$((MAX_ARGS + 1))
+
+check_max_args() { # event_header
+  TEST_STRING=$1
+  # Acceptable
+  for i in `seq 1 $MAX_ARGS`; do
+    TEST_STRING="$TEST_STRING \\$i"
+  done
+  echo "$TEST_STRING" >> dynamic_events
+  echo > dynamic_events
+  # Error
+  TEST_STRING="$TEST_STRING \\$EXCEED_ARGS"
+  ! echo "$TEST_STRING" >> dynamic_events
+  return 0
+}
+
+# Kprobe max args limitation
+if grep -q "kprobe_events" README; then
+  check_max_args "p vfs_read"
+fi
+
+# Fprobe max args limitation
+if grep -q "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+  check_max_args "f vfs_read"
+fi
+
+# Tprobe max args limitation
+if grep -q "t[:[<group>/][<event>]] <tracepoint> [<args>]" README; then
+  check_max_args "t kfree"
+fi
+
+# Uprobe max args limitation
+if grep -q "uprobe_events" README; then
+  check_max_args "p /bin/sh:10"
+fi


