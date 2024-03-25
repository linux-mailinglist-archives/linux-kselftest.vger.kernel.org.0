Return-Path: <linux-kselftest+bounces-6548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B0588B464
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 23:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB4DB31CAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E18129E79;
	Mon, 25 Mar 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsfSBmoK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65D128384;
	Mon, 25 Mar 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383477; cv=none; b=nAIA7S2ksbD1zguxjXkj+u8ot/SuliGINp1sUYXuU+q5/M58h8rOakw3Lu+4woklKzTzrWpVC4ftd0R/aRggrEVIFQNMLiKsdFD5rdw9UAUIxMLW+N23p1hD6Grmwm5TJJq3KlR4ZmcM536RnLyuWjTBqwKMcXuNmkVeCsTzq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383477; c=relaxed/simple;
	bh=CxI/roqLmFPpR2Hha1nY/b7X963/yvMAOGGo5SgRBwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVCyeBs8Xcpv00A40FqAnNic5vAJ2/6wkejTXwVfE/LLFQU/nEj+U8NCsmmO1ll14KAIWgW5mzNdoanoO6r5mQBw1ZUTD6fIaWi85qhQZvbt+suCh/JYQBiwN6ibro4PCB1XsJZkfFAgy5LYy+9MvHD4r1issQulkdlu1+aBZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsfSBmoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4217C433B1;
	Mon, 25 Mar 2024 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383476;
	bh=CxI/roqLmFPpR2Hha1nY/b7X963/yvMAOGGo5SgRBwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nsfSBmoKyXXPw+fT5obU4phfsjWDn2XOldfVOnQRulY08FsNuIX3Oz/6rtvxiBU3w
	 lGY6BVp3pF7/+Hast6zF7sPFxEhwEB5gIxmO3J9QN56wcGa8Esc+udlC0yapn2CD7p
	 tNXJSC1zex2E+1yNvxm1MIHYiHqckDt1XRZWfSkZFTeHIjU2dhYJh6mJoULNPmmyqx
	 ptrUGeGqOaPsTko9wWs2+6Kf8SEUpmRzcL31AVsGCvyFwYwborjS7aleryRG9aMCI2
	 tMM+C1dBcxvoLvwI/ekA8qvG/3+v17AZqUlYWwf8IjLsXtixSUC9pNzkZaXScy0Bwv
	 VOBogIt7ImBzw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 16:15:50 +0000
Subject: [PATCH 1/2] tracing/selftests: Support log output when generating
 KTAP output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-kselftest-ftrace-ktap-verbose-v1-1-3785199809da@kernel.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
In-Reply-To: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CxI/roqLmFPpR2Hha1nY/b7X963/yvMAOGGo5SgRBwY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAaOuDdcW/Bl6VlAkmoAAnO4Bj4ULO6YUx1zdiLb7
 P08+SPyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGjrgAKCRAk1otyXVSH0Fr0B/
 wPqT/zxNbf5zUFigZq4cx0MyjRgJbriybraCGdQLbt4rIEY6OVikQztgYZ5huMIyZZnqDWT6pE3G+j
 tJerHTgzylob9cxVuBGrHv/zxXtV+NVAL7PjYwdW2560TvZ6CqunTFTgBWUnDKEc8l9au7z0Vuxg3T
 zv48QQQcguh9Fw9agc/pGuRwopP8nFpYXhCGWGuE6u6sneHmctMJHVkgBvGZbiBmajGBtom0n5oE6L
 UWRkwlndIWVM+1dTz8GfTYhxpz4MfF1zKXtovnkL35sPuzWfiwKYXkjFe9mdR9i/1+5D+9zX/CkwHo
 ZmTEC2EcsRBGFKs0lEJTRtpTnEb6pK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When -v is specified ftracetest will dump logs of test execution to the
console which if -K is also specified for KTAP output will result in
output that is not properly KTAP formatted. All that's required for KTAP
formatting is that anything we log have a '#' at the start of the line so
we can improve things by washing the output through a simple read loop.
This will help automated parsers when verbose mode is enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 25d4e0fca385..cce72f8b03dc 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -255,7 +255,13 @@ prlog() { # messages
   [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
-  cat $1
+  if [ "${KTAP}" = "1" ]; then
+    cat $1 | while read line ; do
+      echo "# $line"
+    done
+  else
+    cat $1
+  fi
   [ "$LOG_FILE" ] && cat $1 | strip_esc >> $LOG_FILE
 }
 prlog "=== Ftrace unit tests ==="

-- 
2.30.2


