Return-Path: <linux-kselftest+bounces-10453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B68CA549
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 02:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30C81C2171D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6D1BF47;
	Tue, 21 May 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ckmqNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81A47A5C;
	Tue, 21 May 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249627; cv=none; b=t/c0Qa1LLQ3C7WZelLSzE0Pj/KnhYgDRRWSVJsnr/PmLfM5T4ZZBfzjwN5QZ2yrVi3oZ5OJiNY/1aUqaxZikaxPqtRXEE6OdvTjtjbwDsYFy46V+z0Fb++zQ7NNO+qnZ85/njCMxPBmvX0f81QUI59oakbYUS/rCP0JPW2U3DbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249627; c=relaxed/simple;
	bh=jj4W3Jmky7jkPSrRSpX/SZosaWUJN4HwRGmt9HwlUMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9aajg5EIhHkowIOGe/TLoaOMyhQ37xtGoQN5uTUCE3EUno3Prv11/ZOtJXMM+GDBNm/HxgcVEKEyLYLNYLqiqTkWXYujHh5C20hu7zFfTJ5eL5Z8YzArnbYiiI/CKmCanxxpK9WKY6qbdxtWCAjuCdCbsTYlH5pbED90l4XW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1ckmqNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A330C2BD10;
	Tue, 21 May 2024 00:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716249626;
	bh=jj4W3Jmky7jkPSrRSpX/SZosaWUJN4HwRGmt9HwlUMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1ckmqNPaFfzKwJC7Hfs5lWAvpS2godiHKcBZZhAjHJMsWCz9POMEzVkBzE8ZFBmt
	 x2w6KCfb0wDHmctkvs6Bp+FnME18lEmOcjNLHTN2GT2V/KAFypmzc8ATvi3BVtxNVs
	 hpVK5EMW+kOxhIWSM7SXAnJe4ti+BhIbTj06aE+7k/PKlE0EJXps8JpCmKnXDVAynV
	 mXEY43WrWNcFJLwNzfC74ZYGfxzaNRstljQJ2hpAW+tD/eTz6MK5gSkuBnqbML/m+Y
	 dVwtFkKQ+ASHJE9ROht4SKaygdTI1CmsVTBZ576BAc6Dvj21jo1Vmr9m2wnLEc1jCY
	 o9qd2VFmbkeJw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests/ftrace: Fix to check required event file
Date: Tue, 21 May 2024 09:00:22 +0900
Message-Id: <171624962273.252417.2474046620369030292.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171624961322.252417.15852003285637286674.stgit@devnote2>
References: <171624961322.252417.15852003285637286674.stgit@devnote2>
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

The dynevent/test_duplicates.tc test case uses `syscalls/sys_enter_openat`
event for defining eprobe on it. Since this `syscalls` events depend on
CONFIG_FTRACE_SYSCALLS=y, if it is not set, the test will fail.

Add the event file to `required` line so that the test will return
`unsupported` result.

Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
index d3a79da215c8..5f72abe6fa79 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - check if duplicate events are caught
-# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
 
 echo 0 > events/enable
 


