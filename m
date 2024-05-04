Return-Path: <linux-kselftest+bounces-9448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F58BB8CF
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B46C1F21EFE
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0892A38;
	Sat,  4 May 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdZTNfMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D161859;
	Sat,  4 May 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782805; cv=none; b=qLMuXxYnyDvgabgcwtVPTC9xq9KE/CQap5N6PurqLoLEtHbyyBE+bR01jaP2FZHwmqK+ENsikJyc0DptKyureLz2fWxH3Gusfwvjg6gZC2zKr1V4eZ2AkAnr/VUCNVsM7V6WWdRpa4k8LO6k0kEpiDxDgwPmWvnvOR88LaCTT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782805; c=relaxed/simple;
	bh=F04mcxzFyrySYotptkIyuShPMhd/MamWCEQNHFiPe4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZDnxvDG1gl4zISDXO9B/wdAsl5VvnJZToENl4b4XV4MjnRoTW+3alkgSmoNJAeJHrY/S3SYLWez6JwPMqwIQ/p8dHR3GqoYxeyBWuM6x1TKkLWR6cuAyzJFiz18g+b6qCEGjaOZ9Wsuxb2jeuwDMiDeG9K6ta6aMEOESIZ71DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdZTNfMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400AFC116B1;
	Sat,  4 May 2024 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782804;
	bh=F04mcxzFyrySYotptkIyuShPMhd/MamWCEQNHFiPe4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdZTNfMAnWtkW8i+qkLuHhCdIv72R8o30pNTV4GqcxiVz6YhcXVndn6vnmMxqcWPe
	 IGlpWbljcV/Dtcc0Q6b8QP7Dt5xNf2l9hwokXUglRP6KxfOcblnnoJ9XR2/bYbbz8d
	 660I6rRyEPtmfDJjo/isq80TtCk6dR3CXdswbDpDhnWfjsKk+SqbADRhp4t59upwqu
	 RNNU5eFo7S1EphMZxAr62nyn6NTy9cyjf8ZgGwNfwDYfXEI+Gl0if3iv7mlMxwzW2J
	 WQEGpzrWsqs4Qq83Bej7iH4vhMyhmbAu+zgfAVdbVsA4mnmsL+xgzxnfkl45ewR/Wl
	 iYl98KyUqIn6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Fix checkbashisms errors
Date: Sat,  4 May 2024 09:33:19 +0900
Message-Id: <171478279972.109670.4978406413990459886.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171478277880.109670.10932081511777701353.stgit@devnote2>
References: <171478277880.109670.10932081511777701353.stgit@devnote2>
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

Fix the below checkbashisms errors. Because of these errors, these tests
will fail on dash shell.

possible bashism in test.d/kprobe/kretprobe_entry_arg.tc line 14 ('function' is useless):
function streq() {
possible bashism in test.d/dynevent/fprobe_entry_arg.tc line 14 ('function' is useless):
function streq() {

Fixes: f6e2253a617c ("selftests/ftrace: Add test cases for entry args at function exit")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |    2 +-
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
index d183b8a8ecf8..1e251ce2998e 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
@@ -11,7 +11,7 @@ echo 1 > events/tests/enable
 echo > trace
 cat trace > /dev/null
 
-function streq() {
+streq() {
 	test $1 = $2
 }
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc
index 53b82f36a1d0..e50470b53164 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc
@@ -11,7 +11,7 @@ echo 1 > events/kprobes/enable
 echo > trace
 cat trace > /dev/null
 
-function streq() {
+streq() {
 	test $1 = $2
 }
 


