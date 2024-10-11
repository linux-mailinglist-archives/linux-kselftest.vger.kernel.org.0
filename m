Return-Path: <linux-kselftest+bounces-19554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDB99A9CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF61F2368A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29C1A00D1;
	Fri, 11 Oct 2024 17:20:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB5196C7B;
	Fri, 11 Oct 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667233; cv=none; b=pWjozH+B/1dacVUc/4GcIMYje65uvBS4XBDOzniQ5CAbykJMaZjbw/gXDoQJUOLr7mImGBigM7IqGhi0ecH3LX19X6yBe+TVElAckulpqrb30VaRg6JfYBefyebU0BcDqOw66j5/OU/kXGWlFQVNnsZlSMsPxJLAz0SRC6LwRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667233; c=relaxed/simple;
	bh=wxOKqPmAotZcdO0G5Wq6n6Rm1APgf6eiSWLQowMLzJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=me0ExRHA9pE2ojmSivXwOZtSrLG+XkqHG/4FOgtAubTjKWWezVOZvg/20mSqXpi6hMBBpS/8eqj4HKu0B9TF0A7i4A8I2/iZVrvxJ6PdBozM5c9QIWNoNumIjFp1kQ3HyV82l60UaXZJSu6MVOa9XqVugcNqq0c9YcqFbsN0GI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB77C4CEC7;
	Fri, 11 Oct 2024 17:20:32 +0000 (UTC)
Date: Fri, 11 Oct 2024 13:20:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Donglin
 Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] selftests/ftrace: Fix check of return value in
 fgraph-retval.tc test
Message-ID: <20241011132042.435f43cc@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The addition of recording both the function name and return address to the
function graph tracer updated the selftest to check for "=-5" from "= -5".
But this causes the test to fail on certain configs, as "= -5" is still a
value that can be returned if function addresses are not enabled (older kernels).

Check for both "=-5" and " -5" as a success value.

Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Shuah, this update is only for changes in my tree, so you do not need to add it.

 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
index e8e46378b88d..4307d4eef417 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
@@ -29,7 +29,7 @@ set -e
 
 : "Test printing the error code in signed decimal format"
 echo 0 > options/funcgraph-retval-hex
-count=`cat trace | grep 'proc_reg_write' | grep '=-5' | wc -l`
+count=`cat trace | grep 'proc_reg_write' | grep -e '=-5 ' -e '= -5 '  | wc -l`
 if [ $count -eq 0 ]; then
     fail "Return value can not be printed in signed decimal format"
 fi
-- 
2.45.2


