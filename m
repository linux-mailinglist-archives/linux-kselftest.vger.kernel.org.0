Return-Path: <linux-kselftest+bounces-9447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767568BB8CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CEF1F2137D
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0AA3D;
	Sat,  4 May 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr8bi6Mh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECC6AB9;
	Sat,  4 May 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782794; cv=none; b=DAcFbFgrqaFk6SkumRUFBs9nStnFUv1aPutmj0ON9AIXc6LU88QWxwG+f/gk3LR4pzABk9zK21l7rhUBtYuaRkmJ2cHVCvEc8sm39gJvjSIoXxPLfsSjSlRecoro7LM6DjTwZyynIYnfgWf7ygCE5GQ/4Bd+ocJaDZV/bePfiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782794; c=relaxed/simple;
	bh=l/mKd3Tz3NUZlmQupCqAk03v+/7KAwnTs3xvrc0YAWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNsTLYoudi6juuSpPmdToJWwIb5FWUBrd/8aAJ4c2S0B4zCbvJLWR9vOzcYM7Ws9g0Fip/Y4sR5F42I1aMaDhoRQZdTXrBrYM/RkYvivCI/uXgyArKt8ypEhI7/1LwlzqNGRb1RVDhXpGdyIi57EuRvy2gochREozysqys7iLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr8bi6Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B2AC116B1;
	Sat,  4 May 2024 00:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782794;
	bh=l/mKd3Tz3NUZlmQupCqAk03v+/7KAwnTs3xvrc0YAWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gr8bi6Mhcg9xLL6FPZaVqvxubWa+K1C9apfuLoNG8/iwGhsG+JFlfqgh8HegQSfW7
	 5+HL45bC7+Z+q4YEo/iJI4gSDJ1e/OYIkxKhqXit5ssNs2EGPT+M9TwYzvw92cMtG0
	 7Nux+SUxp1e+a86K+93USw9HZh6Y5+y/jTD2qIn+EzuRGNLmRGd5YvWYf5qZ7Bl+OZ
	 IQgtHDc6ShvbrA/cLcJmDDkYXHjzXkQpn/yNHSkNmblWwPpIxZAjYAfKnQgGGW9B4Y
	 jKgWL6pSiPgkDojbo12y5AlvFPewKkXCGv/UsVN1UxRtzg15UKu9x+WaxyLfznvMFQ
	 8/BwjT/FIAtFQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly
Date: Sat,  4 May 2024 09:33:10 +0900
Message-Id: <171478279040.109670.8403406322028922001.stgit@devnote2>
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

Since the dynevent/add_remove_btfarg.tc test case forgets to ensure that
fprobe is enabled for some structure field access tests which uses the
fprobe, it fails if CONFIG_FPROBE=n or CONFIG_FPROBE_EVENTS=n.
Fixes it to ensure the fprobe events are supported.

Fixes: d892d3d3d885 ("selftests/ftrace: Add BTF fields access testcases")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index b9c21a81d248..c0cdad4c400e 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -53,7 +53,7 @@ fi
 
 echo > dynamic_events
 
-if [ "$FIELDS" ] ; then
+if [ "$FIELDS" -a "$FPROBES" ] ; then
 echo "t:tpevent ${TP2} obj_size=s->object_size" >> dynamic_events
 echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
 echo "t:tpevent2 ${TP4} p->se.group_node.next->prev" >> dynamic_events


