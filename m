Return-Path: <linux-kselftest+bounces-45408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3CC52747
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0FBD4F51DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F232C33C;
	Wed, 12 Nov 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0IDz1zZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A9316918;
	Wed, 12 Nov 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953186; cv=none; b=EjzyOhOgwrd8dpK0rhLjPZoNYD/lS8v7HqFYr2YOPxvhyovwSBNHfJrIaJi1JLWmBrjLnWyrnbZHMCpNgGmK9U6AoSyfFGjltxxJDokAml6wHLvfId2ykYWhqngBk6giL4D7taZFoA23C0ewiLn1tKCEE2jcnEdrv5NcjX+8MNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953186; c=relaxed/simple;
	bh=5BhmBWD+wfd+rrYTRM3269jsfIet1SdsHS2RmPQvEiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h8BBAaOFDjZgzYWsDFxVZkEQHAd/JFQbKOAzBKpv/2fA5sHb50HlUNz0GWkoRku4L+3EBXrbxIgQWlb3dZ7YYyNgyh9ODmWORz/PQJEN8ZW+M22JJ3RySz76T5hmEClVcjdphFgccAGwYc3T2IQ3wi5lmW3R4r7cXctuFzeQHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0IDz1zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F2C4AF09;
	Wed, 12 Nov 2025 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762953185;
	bh=5BhmBWD+wfd+rrYTRM3269jsfIet1SdsHS2RmPQvEiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=W0IDz1zZpv/yynyI6FVqH5D3A1X74SUZjfiabCXC8eQ349BnzxsnTTVxV2jTwoMAl
	 vmZ9oSJE3MfGx/iS2mKvGxhtB6hITyvrJiN5C4spPgVlaGIS8SSQ1oitrM5LWDi+vq
	 H7uRPGnsvw5cmv2gTihxIlfBTbcOMg38ae56E3pXSWv/mLeji8vbENQEfdpNo26o6l
	 RuvqXFR+yofoBkpOj54dX48MThX4IuQtivzau738o8EYeYMzVxCYbp5TX0Z/vFmvJH
	 9fwp5QPuklnxpaNedHnYe+kD2gCjw6bjAYJSL/6ZStVGRYVqrvhL1V/VwRCnUhS524
	 l5MRqJInZTeoQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: tracing: Update fprobe selftest for ftrace based fprobe
Date: Wed, 12 Nov 2025 22:13:01 +0900
Message-ID: <176295318112.431538.11780280333728368327.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Since the ftrace fprobe is both fgraph and ftrace based implemented,
the selftest needs to be updated. This does not count the actual
number of lines, but just check the differences.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 2506f464811b..47067a5e3cb0 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -28,25 +28,21 @@ test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
 
 echo 1 > events/fprobes/myevent1/enable
-# Make sure the event is attached and is the only one
+# Make sure the event is attached.
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne $((ocnt + 1)) ]; then
+if [ $cnt -eq $ocnt ]; then
 	exit_fail
 fi
 
 echo 1 > events/fprobes/myevent2/enable
-# It should till be the only attached function
-cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne $((ocnt + 1)) ]; then
-	exit_fail
-fi
+cnt2=`cat enabled_functions | wc -l`
 
 echo 1 > events/fprobes/myevent3/enable
 # If the function is different, the attached function should be increased
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne $((ocnt + 2)) ]; then
+if [ $cnt -eq $cnt2 ]; then
 	exit_fail
 fi
 
@@ -56,12 +52,6 @@ echo "-:myevent2" >> dynamic_events
 grep -q myevent1 dynamic_events
 ! grep -q myevent2 dynamic_events
 
-# should still have 2 left
-cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne $((ocnt + 2)) ]; then
-	exit_fail
-fi
-
 echo 0 > events/fprobes/enable
 echo > dynamic_events
 


