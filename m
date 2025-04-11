Return-Path: <linux-kselftest+bounces-30559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B7A85761
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0C21BC0879
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EA2BE7AF;
	Fri, 11 Apr 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmCpPFPY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDK92w6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE829DB73;
	Fri, 11 Apr 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362120; cv=none; b=Nq7avR/rDQl+VxhEChhUIBlYoUclTmZEtEceqNzXkL2CwkzAR5ZzMuS1eGplKewrK5Tw4QC6FcRSWGoeNHBbQ4Y1E8v2FS4bjDrCKN8LkE3mFVN4cvWs63nsf7ou4ALK+cFeooNlu7OBz92TjqOVJO9UDQW3TAfrWHuDpQ/whZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362120; c=relaxed/simple;
	bh=q4kd7mGGuPTJdyPDCjQYjszzTh6pp6UOGPR7zUxPBBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQhsZ05JH/LIdtRBCcj9hSZ+xOlbFi2jjc45wMuNC+I4PzoZ+/NrF8+Ci+uT+vKe0gbgR0MiPM0blz9Bsgh9JSI1NR2OYBjexOY+M5ifxo+QMUTIcvD4EEfDUvVN9MSSzkbokqmt/YTmsUgtCJoFV4/51ApAA2ucjCHLChV1+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmCpPFPY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDK92w6P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqLj2uDZACTDisGAnX7h0mSVa8/8RdDY0n+eZ6yxnAE=;
	b=cmCpPFPY77n1JQGOCKiJIKbBGI5+vT8JwZOT5nF0noHy+dBsFuw7JS7wGt6m93jd4DfA3C
	ntWFRPvoM0A7btAeQJGsD3cd7T7KGZduxKwYnCTYWsC2475WGLgcjJTvN1pu2YFQCQqRgD
	WzBq6puk9Pv7l7AJvmc7I23WVfODl0be9rJMhpWwbzVcuApkUQkf3AdHyz53sImHXRYWR/
	x/AUwd5uS8jflUxW6+ZwFNMBMxymQCxw1oYmldL9wKVrcNb/DawfSpQ1++kzIbOzfUOrTn
	/xUwzK+6d2v77mg90kCtgjoKRHmE7CFFyLU8wsE26MPV9YwfFG+iW5Z/JuHR+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqLj2uDZACTDisGAnX7h0mSVa8/8RdDY0n+eZ6yxnAE=;
	b=DDK92w6Prl/kp8ESUX+G8v4mHKOM4lZQOKOAn501V5noJYv4NaEga4/dYXydnzqgt7+Tz1
	9QQpyr8DvmYkSbAg==
Date: Fri, 11 Apr 2025 11:00:46 +0200
Subject: [PATCH v3 22/32] Revert "selftests/nolibc: use waitid() over
 waitpid()"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-22-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1651;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=q4kd7mGGuPTJdyPDCjQYjszzTh6pp6UOGPR7zUxPBBs=;
 b=aJJNm82uWTw4C1wejU5ZKmg4K3b7O49aBmJY1+zCTBFAZLNIRZyiGEIfHJshek826DN5+GzNf
 QBxF01xxw/JBVYNpPG8wCTgYm0tx0pA+79f6kcn1rQaa0+SeHlYx3A0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc's waitpid() now uses the waitid() syscall internally.
This removes the original reasoning for the reverted commit as
waitpid() is now available on all platforms and has an easier interface.

Switch back to waitpid().

This reverts commit a0bc8947ac731ff95a56e0c1737e69e8c56d5b78.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 70d418b87f7731572b85d64a8128c62d01df6b2b..b4b9a8422d76e1170ff967850429916a2190139b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1462,8 +1462,7 @@ static int run_protection(int min __attribute__((unused)),
 			  int max __attribute__((unused)))
 {
 	pid_t pid;
-	int llen = 0, ret;
-	siginfo_t siginfo = {};
+	int llen = 0, status;
 	struct rlimit rlimit = { 0, 0 };
 
 	llen += printf("0 -fstackprotector ");
@@ -1501,11 +1500,10 @@ static int run_protection(int min __attribute__((unused)),
 		return 1;
 
 	default:
-		ret = waitid(P_PID, pid, &siginfo, WEXITED);
+		pid = waitpid(pid, &status, 0);
 
-		if (ret != 0 || siginfo.si_signo != SIGCHLD ||
-		    siginfo.si_code != CLD_KILLED || siginfo.si_status != SIGABRT) {
-			llen += printf("waitid()");
+		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
+			llen += printf("waitpid()");
 			result(llen, FAIL);
 			return 1;
 		}

-- 
2.49.0


