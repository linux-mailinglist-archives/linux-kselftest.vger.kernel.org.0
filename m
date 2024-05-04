Return-Path: <linux-kselftest+bounces-9449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806168BB8D4
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23ED9283C3C
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF4139B;
	Sat,  4 May 2024 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMe2/prL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B8A34;
	Sat,  4 May 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783021; cv=none; b=SpHlFtP8RXjtzFryGl7PUQu27J/aAvEpwbnKR6S5xrdgKYu3oRLFYI7NKrxdRc8+5Nfv27zWLUWD9oFELErWmfoSavQNUZ5f25g9BxR11WQHX+hkcIfXEmKcJHNNGmtStAomUcqF9w5wTGxrP/oSA91pKmjpzu4q3ulBOO4gD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783021; c=relaxed/simple;
	bh=RVhCUb8j6bIvl5Nrd+AUuRpCyrt+Ya63YaRYyLEZCjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mc6I90kVovYJ54so0HH+Wsdu7RQgFot/5g8dYvpLeZI9X2Kp8o95aFW9pru7rxl7lz5S/ObyABHC+9t76nux5C4uGzjiuwj3Jn1um8qfx98UPKWvU1x/oh4C/kllkpby8nzQkOXfevtAq/l9dP2zP6dkP9R+lIKazwGy86hNWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMe2/prL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1768EC116B1;
	Sat,  4 May 2024 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714783020;
	bh=RVhCUb8j6bIvl5Nrd+AUuRpCyrt+Ya63YaRYyLEZCjY=;
	h=From:To:Cc:Subject:Date:From;
	b=sMe2/prLxeKpiEOOIQ1hnal/SmAhWd8kLVcREHrf16p57BJtrCdtL1dQoB6wxaxOD
	 xzm8EdzxbAlx84/zT78D138SXBoqt38Jxc6D3I/HSHELpUglXBfZfHbZ9m9/EgL2Gw
	 b3C/uKUqjo6g2iJiy8undxT2+dOZX4cARq44ATlnj2w5/RTDK2sdarLUwARqIqWX4k
	 v3SLEOmyB29RuAsNiuhCLE2BnlmK7hWdgEIv269tIqqV6Eunu8Y6iHODD5N7GmwaGZ
	 iIdkg21WNr416PWQrpBRzK2d+ls5bgZdWsQNg/X91m/imjarKiw6wJ4qQ3HuSP0Zfm
	 8ntlFGn9kozLA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH for-next] selftests/ftrace: Fix required features for VFS type test case
Date: Sat,  4 May 2024 09:36:56 +0900
Message-Id: <171478301645.110267.464634740467398506.stgit@devnote2>
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

Since the VFS type argument test case uses fprobe events, it must
check the availablity of dynamic_events file and fprobe events syntax
in README. Without this fix, the test fails if CONFIG_FPROBE_EVENTS=n.

Fixes: ee97e5e135c6 ("selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_args_vfs.tc      |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
index 49a833bf334c..c6a9d2466a71 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
@@ -1,7 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event VFS type argument
-# requires: kprobe_events "%pd/%pD":README
+# requires: dynamic_events "%pd/%pD":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+
 
 : "Test argument %pd with name for fprobe"
 echo 'f:testprobe dput name=$arg1:%pd' > dynamic_events


