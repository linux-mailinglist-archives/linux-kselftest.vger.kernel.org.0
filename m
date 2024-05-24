Return-Path: <linux-kselftest+bounces-10640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BA8CDF01
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 02:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536F51C211DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542F53AC;
	Fri, 24 May 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9RpxoVD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF881F;
	Fri, 24 May 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511800; cv=none; b=cWbxXdm5pwKnYv9Gm8DrrCtd01Dt/Yeg2tR3UBjFCKN1nnTnUqRuK8mKLRF3aRPeW5yh1uZxQMR4yNlw5YZBhdFV/vrcXweHsYMySDpTkman8OrkGNUWMYckyY9N9vTZAPcUBUULn1t0486hWv3Q9UdBWk2FL8gqibRhEufMiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511800; c=relaxed/simple;
	bh=DruTHJyj0udcvCsGY6ote/v3/C47/j6EtDcf/pbii1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tsIvdV1wayT42lL51n//x3QkRcbTFMG+phrlmdXsy8PV7a6Ndj0fAzE/jPiVg0TJGLfKfST16qicuA0QjHbmCbc5pdNNPEuGorZTBt1NpgMdBYiGHSyV5vydZm9BAkOcnA8Be+zLZqEh1/KLMJEMdCUm5jDDAj9x5agy6ISqVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9RpxoVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA0C2BD10;
	Fri, 24 May 2024 00:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716511800;
	bh=DruTHJyj0udcvCsGY6ote/v3/C47/j6EtDcf/pbii1E=;
	h=From:To:Cc:Subject:Date:From;
	b=E9RpxoVDTZT8VUAfzxM0vIdFsCXwP7cQpV9Isb3qL9yXRJd52kbzg4yQ5cBH9D56d
	 vNcTzXTsoGta450Wou4eObbYEs7M5hT0TfnJuj7fQmqyFaG/lhRFs2zn3bosniAC9H
	 2lomszHSAN4cFyiglE/RKpGo4Ti8oWULMVf6bPSCypP4eMJKppVZqj0bbcP3+iNCha
	 uJTSGBFylKIye+VCNYRinJioJbnAi50ZYNQn9Vk3/bU7fW4K9KLAiyxJYID3YzmdSA
	 sFR3Kv0qynewXPCoer94pj+1qw0XKv/Vxga+PHZdBueIKjs8yyaMXDkLBJTcCKK5eQ
	 h6kk9/+2vJ46w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	oleg@redhat.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/uprobes: Add a basic uprobe testcase
Date: Fri, 24 May 2024 09:49:55 +0900
Message-Id: <171651179523.161068.3164659198838770307.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Add a basic uprobe testcase which checks whether add/remove/trace
operations works on /bin/sh.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
new file mode 100644
index 000000000000..a275decdc880
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove/test uprobe events
+# requires: uprobe_events
+
+echo 0 > events/enable
+echo > dynamic_events
+
+echo 'cat /proc/$$/maps' | /bin/sh | \
+	grep "r-xp .*/bin/.*sh$" | \
+	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events
+
+grep -q myevent uprobe_events
+test -d events/uprobes/myevent
+
+echo 1 > events/uprobes/myevent/enable
+echo 'ls' | /bin/sh > /dev/null
+echo 0 > events/uprobes/myevent/enable
+grep -q myevent trace
+
+echo "-:myevent" >> uprobe_events
+! grep -q myevent uprobe_events
+
+echo > uprobe_events
+
+clear_trace


