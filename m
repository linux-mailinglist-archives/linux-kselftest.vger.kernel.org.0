Return-Path: <linux-kselftest+bounces-17141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7F96C26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A2F1F2602E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DE1DEFE6;
	Wed,  4 Sep 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7MQB1HV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299021DCB09;
	Wed,  4 Sep 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463826; cv=none; b=Z/lvIAJo2Hy0jK/fq20qP/ChZp+dbjWdcbDtRJzN+5oEvzedxaWcNiPN0ruSnbcRGPM6JZt0tYKujSAvlT7RDnFfM22sITC4BcpBP2okQbbOrg2yRR0mlieqWBQ2dU6QQJcSIymGXVFEmReyy+A6fd8QGFyzjAt84pHTTvRC8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463826; c=relaxed/simple;
	bh=hxOmlbtgXKR/p3D2sjwDnE4b4AheFtwuaWlkiEGCQdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f9yzIMK54X8G9H+Jey2ejhbzyNbAa7iRrvr3Lpv2ykluhauZOirRYf4f5jrdGtb8CcRTY8MHxqWZH4onAg5lTG+snDFYfvdtmjw/z2RAiAPBEoEAncNsfzLclz8GHRyoFaN4ytJ+t+KXfTAJZxaMbNMXa4390mqv/AwBS0dEc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7MQB1HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C04C4CEC2;
	Wed,  4 Sep 2024 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463825;
	bh=hxOmlbtgXKR/p3D2sjwDnE4b4AheFtwuaWlkiEGCQdg=;
	h=From:To:Cc:Subject:Date:From;
	b=P7MQB1HVD6P8Wbff5uJj5185RVRInxHOtA1PJ83DkBsaac26Z8xmWybj9qTVCHoVA
	 Pu0iNdULbzqZeYcNNT0KEowTSiui7uCwN/MXplgJWHlXbNHIyz+plSN9VsfqqaddCR
	 GiycK0I6SUl2MlqiGINsnH8oZoh5CJLLTs4d7FXPpP3yPW6BOloYvJi0G+GfIP6AJR
	 Ws+GSp0XC1b4zn9Y4ZMh7FglZuRs6dQhzF86U7RhZP1af9pofhmMBUoXlUriwSqCQx
	 KrKPAigVBfkQEgqioDVuYIDE+QnfSEFe8npSHJ5A2GH1dWIZ+wTwBrOgBo7EUaCY8N
	 +o36A2rG9Z+LQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix eventfs ownership testcase to find mount point
Date: Thu,  5 Sep 2024 00:30:21 +0900
Message-Id: <172546382097.224182.6471842111781551515.stgit@devnote2>
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

Fix eventfs ownership testcase to find mount point if stat -c "%m" failed.
This can happen on the system based on busybox. In this case, this will
try to use the current working directory, which should be a tracefs top
directory (and eventfs is mounted as a part of tracefs.)
If it does not work, the test is skipped as UNRESOLVED because of
the environmental problem.

Fixes: ee9793be08b1 ("tracing/selftests: Add ownership modification tests for eventfs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/00basic/test_ownership.tc        |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index c45094d1e1d2..803efd7b56c7 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -6,6 +6,18 @@ original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
 
 mount_point=`stat -c '%m' .`
+
+# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
+# current working directory (which should be a tracefs) as the mount point.
+if [ ! -d "$mount_point" ]; then
+	if mount | grep -qw $PWD ; then
+		mount_point=$PWD
+	else
+		# If PWD doesn't work, that is an environmental problem.
+		exit_unresolved
+	fi
+fi
+
 mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
 
 # find another owner and group that is not the original


