Return-Path: <linux-kselftest+bounces-4847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E88579E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 11:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A688F1C209EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A81BC4B;
	Fri, 16 Feb 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TowStlj9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A71C282
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077947; cv=none; b=JjB2Cenu7CGe8LyPDcajPxXn2ClRtg0DtPTMD8+VreiUF9/UY2qlZkzzQoD03aaqmkGrR7chTUJ1/yTvRETL6ZtJxqEE9n+NZ/ENZGvPbETH5Dy453nDNtiRA4YQO/M+tHyAyUckhhLpIb4nemwLSnWiUOUUfVTJUjDwNbzrQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077947; c=relaxed/simple;
	bh=2OfrWvDY1AJyIDPSebrdawxRKqS9Bsc98oNPwj7uwcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLO7joP17skIW/WRMmJuD1N82tDraHWR5WRtfg9jY5qAxCwNaX7nBI4s9x5eYJPUAbv8Q6FXp88RzS/sIrdOMfVsN6LuB5ch6t5sPsj6YEAtuDSk4WVr1CSpWtX2TvwagnRllFIXt6qc9dFO3T/37MCCMlZPwWKiZvbzLg7GPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TowStlj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68090C433F1;
	Fri, 16 Feb 2024 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077947;
	bh=2OfrWvDY1AJyIDPSebrdawxRKqS9Bsc98oNPwj7uwcE=;
	h=From:To:Cc:Subject:Date:From;
	b=TowStlj9RRE9YneGcJa7BgpLwqfN5D0oerI1vuuSMXGDV6thM8Dr+r7srSZA8JEj4
	 7VUSStPf14fr/VMGPu3DnMo1zSWe+KyqBBAJHTbS+XEAf5y22AtkmuGcgkPF8T3zhF
	 xYXUgy548kiPbcR78IhnUZnnEHrcuTv+JReN5Q7AlMgD4ka8ZRWhbPL1Sw55d52TNm
	 uYk9DrMlK/I0ww22yfTF4yabsTj1JBLRVpz1ZHs6vqrcydl8vESvCsYiTJtPBmt0U3
	 1gXUzzx57Bz0jWdnRAyqiMVbvFJ8PVMg/OrKatPXgDJ6IBR1Te5GbXug5M1wkSLwDK
	 aIN5qmm/0jsXA==
From: Naveen N Rao <naveen@kernel.org>
To: <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH RESEND] selftests/ftrace: Add test to exercize function tracer across cpu hotplug
Date: Fri, 16 Feb 2024 15:26:26 +0530
Message-ID: <20240216095626.1234309-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to exercize cpu hotplug with the function tracer active to
ensure that sensitive functions in idle path are excluded from being
traced. This helps catch issues such as the one fixed by commit
4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").

Signed-off-by: Naveen N Rao <naveen@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func_hotplug.tc      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
new file mode 100644
index 000000000000..ccfbfde3d942
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: ftrace - function trace across cpu hotplug
+# requires: function:tracer
+
+if ! which nproc ; then
+  nproc() {
+    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
+  }
+fi
+
+NP=`nproc`
+
+if [ $NP -eq 1 ] ;then
+  echo "We cannot test cpu hotplug in UP environment"
+  exit_unresolved
+fi
+
+# Find online cpu
+for i in /sys/devices/system/cpu/cpu[1-9]*; do
+	if [ -f $i/online ] && [ "$(cat $i/online)" = "1" ]; then
+		cpu=$i
+		break
+	fi
+done
+
+if [ -z "$cpu" ]; then
+	echo "We cannot test cpu hotplug with a single cpu online"
+	exit_unresolved
+fi
+
+echo 0 > tracing_on
+echo > trace
+
+: "Set $(basename $cpu) offline/online with function tracer enabled"
+echo function > current_tracer
+echo 1 > tracing_on
+(echo 0 > $cpu/online)
+(echo "forked"; sleep 1)
+(echo 1 > $cpu/online)
+echo 0 > tracing_on
+echo nop > current_tracer

base-commit: 130a83879954a9fed35cf4474d223b4fcfd479fa
-- 
2.43.0


