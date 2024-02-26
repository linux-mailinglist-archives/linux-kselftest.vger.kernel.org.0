Return-Path: <linux-kselftest+bounces-5423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C3866909
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B901C2346E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F711C6BE;
	Mon, 26 Feb 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu4gI0sF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DD1CA85;
	Mon, 26 Feb 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919938; cv=none; b=Bdjcgrtiho+tPYXtjR7bg1HMVV2f3UM6lbSdWlV16AxIaqdnnUEsj/NyP3NUpsoNag9K05NcjWDT8YQPZl7ggabvY8CmWmt71nw8OtFcpbu8tdsHHY+XjEmsA+mZu4O8v9P2Wg2A57SQd9LdXH25ZQbph5syE5Mby7p8w32Y3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919938; c=relaxed/simple;
	bh=1MG502dBW5ZFZkOGMGA4VMms5Lg9q3jfUg4fYOgVv58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBH3Gr2p+CKn5x3Fk46zdAbb7nKltnMhE+JoLQuvMsFBDpx5ywOP3uIZ0gGD7cSuRuhNA2Cr37xNHP/FIm+WX+p/I1l3JE21ldcV2V98nPVbKVpM+Pi3AGAzafqKREcQgmLjlTt6QmTzU+ywGtsvQS51NKOa8XaAuq+P75A7yWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu4gI0sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9C8C433F1;
	Mon, 26 Feb 2024 03:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919937;
	bh=1MG502dBW5ZFZkOGMGA4VMms5Lg9q3jfUg4fYOgVv58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uu4gI0sFM0+viQgCOBY+qx/gnkrQrkEJUs2cYPQ95TmIouJXMzORCyEB4U56cnXKC
	 EKkp9JEjPGy9thEmDbrFwTj5X9SmWiMQF/Vzc9DtgNCw58E1pawpFZ1ddg/2mJwQPJ
	 wL1cEsewUSISu4FMsWTc48vr5fEWk5U91Etc/VqfUEiTqBfse5QN+Qlq7mbf4XPPZl
	 bDgrTNRmhC+h4WQ+ZSpyaqkoF/tZcSoXUdBZlwAyGPwwbU2GfUjRGikVAuEKGL50NL
	 KiZi3RDjlwYrCsTi5EEiP2Jjw/u+MudV0nsjS9zjjWYg3c3LHFCd5m1CH/1wvOEeI/
	 MehYUiCqvIVyQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 6/7] selftests/ftrace: Add test cases for entry args at function exit
Date: Mon, 26 Feb 2024 12:58:53 +0900
Message-Id: <170891993315.609861.477644237329143406.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170891987362.609861.6767830614537418260.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
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


