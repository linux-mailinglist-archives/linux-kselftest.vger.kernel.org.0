Return-Path: <linux-kselftest+bounces-10994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC78D5EB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7066F1C20E23
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12313DDC0;
	Fri, 31 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+4d0iY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7A133993;
	Fri, 31 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148631; cv=none; b=shlGpXaWcLASdr66tpRDDa+xRJNBloRnYeMiu02s84ulB3BxtF+1uq4PmvexvxW/1+22dUyYXob8QwbtrHjoiQs1k/o1x20uCTmugHuE1wj3fns1gzkRMeNm55H1JaNntJ3MAOJgI2RqI4zjmOEkgSyLhZsUb52YNtG0Tw2QKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148631; c=relaxed/simple;
	bh=Ji/BCrczZrXFzdJ9KBTdLjwgMFK+b2bHwQAPjUjuiF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRhIAo39hmE7SZYOPadQcyTcB2V1zBxVbGoyZVbrJpo65mY6rgdRwPzaip7qtTqmbZPq9vTYUH6c6akSt7HlTfcYrZvvmHcCeCHpiSQ4MOYzKgFk4sO20B+/q5O9RB48Net3Cc8FIkCgfxntrgu7Wm8ACmDzkB2XwDpL9TX10S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+4d0iY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71019C116B1;
	Fri, 31 May 2024 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148631;
	bh=Ji/BCrczZrXFzdJ9KBTdLjwgMFK+b2bHwQAPjUjuiF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+4d0iY2y4Jo1b9nwvfmTfqGVsA5/JeClcvI1M1tX1bS2C5KXjcqZwTp6Vq06c48S
	 wrMTRPvJVID5Xt89uFTbo4ADWegnJRdcon9tPHknmaQNE/BES6SCutOjMCXKDC2G5G
	 B4gq4P+QJNb8eVnZWYTFC1VeCtNSDJmkMwt4AWafOd4Us18f4idAX0eoifa14g8KGf
	 BAdlrRdg/X+GmK0cCl/UrE5+yybqgWWUz5nwEx6xxJeqcifdJnD6paTxI/X5B9Chl2
	 OTtoPF0obQmt86/r/jObajHDXLbHNFwkc+EOdBm/Fs+u/YzYwiSFa8gPCFGQ3fpjyX
	 ldqRx67ejfbSg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/tracing: Fix to check the required syscall event
Date: Fri, 31 May 2024 18:43:47 +0900
Message-Id: <171714862700.198407.14000969067636098427.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171714860864.198407.18416314586430149538.stgit@devnote2>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
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

Since test_duplicates.tc depends on syscalls/sys_enter_openat event,
it must add the event file to `requires`.
Without this fix, the test fails if CONFIG_FTRACE_SYSCALLS=n.

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
 


