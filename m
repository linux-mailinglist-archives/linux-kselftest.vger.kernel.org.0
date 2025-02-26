Return-Path: <linux-kselftest+bounces-27563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F71A4557A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE8188C1D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF753269AE6;
	Wed, 26 Feb 2025 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ObwY1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C1267AFA;
	Wed, 26 Feb 2025 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550769; cv=none; b=AG9x22qyxsnseAAYPQF889d50UO7NWTCUOOMZxJsMGvvMT/fzIJRkybFctIF8fb6APRaB/qbbL9azmyhWtMaS8Q8ZmdoIf6l06piP104xmoIm+xdz/2bZqQfVD6j/G8ukpatghrKWtX5NMQ/qAYdowhl2e7LjuzPGgoYyFNlll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550769; c=relaxed/simple;
	bh=1Ffr/p7PmfPrfKjUIW3MrhT7Kx5dqB1g0DewxTnlqlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7yPS7ejdAz3Avye4xTPVv/va1BHjw5i6xaEQSMIW1Ag0/MIDp6E61r9daBm1gdCuoMiM4HysYpuCn5CY29zuWRu9F+O8Uhh4xuLX5NWftlpvK+TbPzgPXF66bkMg8e3HSxxT9JzTfrT1Qp6eF0ky9NrF3wBxTmFDMGvk207OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ObwY1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867DDC4CED6;
	Wed, 26 Feb 2025 06:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740550769;
	bh=1Ffr/p7PmfPrfKjUIW3MrhT7Kx5dqB1g0DewxTnlqlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1ObwY1rKJE/plerVVpkb3ghF1HQ33LGi/Q5L5tsIRoEZ/sf6GuGEO8OG9Rk2F/6Y
	 x2IICWIg7blK6hLueyOH509P3ZXv84muSbYKaG8N0cuhNHmtqBbhpNuG1UCMsXYZFA
	 zcStTAImaz5cwAYOERllTOH3Sns9XSKAG5NNN7yr34HwMNmpsEZlxtKwAaxwuNJKfE
	 JqJAmvMAC9/MWt1bRhBiipwT+nEWQaVs31PW+d3HLPcYm3DxYq2taWOQQRzfOaHb1+
	 Iu4FzZ5QUJ5NhAC4gcSd/j0MrH9H4Sk4Bajl00Vbaq+bpP4C5KgJ+atpLlwMWsWnFY
	 TH8eubKv952CA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 6/8] selftests/ftrace: Expand the tprobe event test to check wrong format
Date: Wed, 26 Feb 2025 15:19:27 +0900
Message-ID:  <174055076681.4079315.16941322116874021804.stgit@mhiramat.tok.corp.google.com>
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

Expand the tprobe event test case to check wrong tracepoint
format.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
index 155792eaeee5..f271c4238b72 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
@@ -6,6 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
+SUBSYSTEM=kmem
 TRACEPOINT1=kmem_cache_alloc
 TRACEPOINT2=kmem_cache_free
 
@@ -24,4 +25,17 @@ grep -q myevent1 dynamic_events
 
 echo > dynamic_events
 
+# auto naming check
+echo "t $TRACEPOINT1" >> dynamic_events
+
+test -d events/tracepoints/$TRACEPOINT1
+
+echo > dynamic_events
+
+# SUBSYSTEM is not supported
+echo "t $SUBSYSTEM/$TRACEPOINT1" >> dynamic_events && exit_fail ||:
+echo "t $SUBSYSTEM:$TRACEPOINT1" >> dynamic_events && exit_fail ||:
+echo "t:myevent3 $SUBSYSTEM/$TRACEPOINT1" >> dynamic_events && exit_fail ||:
+echo "t:myevent3 $SUBSYSTEM:$TRACEPOINT1" >> dynamic_events && exit_fail ||:
+
 clear_trace


