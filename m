Return-Path: <linux-kselftest+bounces-5812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6C86F907
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 04:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4747928157C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2541611A;
	Mon,  4 Mar 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJI13pja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2DBA3F;
	Mon,  4 Mar 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523670; cv=none; b=PfXluefsJOsibcSfcNqzqxehoGQVjgKHd/oUhtE5Ut5L71bitjj9jMryRkNYMNZp0udDngtEaq9VZXZBImnE6jQIcL9KBUkjimBvwAIb12bdTg9GSnIERCsEzsjzQ5D8SVjfXThmavuQvBm3MUJ+RM+a23y2hfqpgkk+TerxzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523670; c=relaxed/simple;
	bh=1MG502dBW5ZFZkOGMGA4VMms5Lg9q3jfUg4fYOgVv58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7KuUJSXElrSPbd0lVx+cU2c1neS+3rfJx9+Ozr7Z9RDthWnb0RjJZv4P7mFRG7cyn280OTIhfQ42UsvpSkVuIJJxOWedYTPFIsEocIvkzwD/cn8FRMHGvKfzJ7h7SY9q7xprU4lmWqr7Wj2VKkxLqWP50x7v7CnNOxPxxgtspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJI13pja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4AC433C7;
	Mon,  4 Mar 2024 03:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709523670;
	bh=1MG502dBW5ZFZkOGMGA4VMms5Lg9q3jfUg4fYOgVv58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJI13pjan5FUMoibjtrvdcfTljbNLUhUSCrCjdf1lCfCbaUlq5bQEiMGiDZrqMVWV
	 DFxLtGGzL/8Ac9mb8ylzh0LSA7PibAd/NLXOKdqVmi/3lJQ2l6OFNe1CzfGVYv1dN4
	 mhnCCqliAYJ+OFf8nN56ep4EizxlRnRAuflG+Xav4XDFCOFxCBTV+VaxB6sJTCL95G
	 1+QjQQunf+LXndKMQjSnntPki9KeE812L8eljM7E2rQNLWdpMwhy7O93jbldc0YSt5
	 TNdOJyf39ojdGAV58dnVI8zBfEzAj9ZU5MaQmTNpJp12ILXyqDbC9VTcT+tDYrFcfl
	 oAuOjE2lHw7eA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 7/8] selftests/ftrace: Add test cases for entry args at function exit
Date: Mon,  4 Mar 2024 12:41:05 +0900
Message-Id: <170952366504.229804.11605173085475141091.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170952359657.229804.14867636035660590574.stgit@devnote2>
References: <170952359657.229804.14867636035660590574.stgit@devnote2>
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

Add kretprobe and function exit probe test cases for checking whether
those can access entry arguments at function exit correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |   18 ++++++++++++++++++
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |   18 ++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
new file mode 100644
index 000000000000..d183b8a8ecf8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Function return probe entry argument access
+# requires: dynamic_events 'f[:[<group>/][<event>]] <func-name>':README 'kernel return probes support:':README
+
+echo 'f:tests/myevent1 vfs_open arg=$arg1' >> dynamic_events
+echo 'f:tests/myevent2 vfs_open%return arg=$arg1' >> dynamic_events
+
+echo 1 > events/tests/enable
+
+echo > trace
+cat trace > /dev/null
+
+function streq() {
+	test $1 = $2
+}
+
+streq `grep -A 1 -m 1 myevent1 trace | sed -r 's/^.*(arg=.*)/\1/' `
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc
new file mode 100644
index 000000000000..53b82f36a1d0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kretprobe entry argument access
+# requires: kprobe_events 'kernel return probes support:':README
+
+echo 'p:myevent1 vfs_open arg=$arg1' >> kprobe_events
+echo 'r:myevent2 vfs_open arg=$arg1' >> kprobe_events
+
+echo 1 > events/kprobes/enable
+
+echo > trace
+cat trace > /dev/null
+
+function streq() {
+	test $1 = $2
+}
+
+streq `grep -A 1 -m 1 myevent1 trace | sed -r 's/^.*(arg=.*)/\1/' `


