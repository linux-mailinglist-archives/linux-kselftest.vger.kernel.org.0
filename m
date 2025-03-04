Return-Path: <linux-kselftest+bounces-28169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF72A4D476
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E8417480F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570E1FDA8C;
	Tue,  4 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vol7zITN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBcr30tn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B351FCD0F;
	Tue,  4 Mar 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072283; cv=none; b=BdDO3bUE0XIkaKHCFuIku0RqjhR/CkvhWMYdK0IeD5ns4g6N2hrQBy6IR+hT0EwhVHcI3e9GWiFFxYvugVFpqRMkPUs4o/ikGY1HABOMwsjJAnuE4Oo1o7iJYG2KiaEHIwDJlD0v1DXIlBmmQ3jMYYwqxB6c4kQ7H5/Gr4loEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072283; c=relaxed/simple;
	bh=/FGAVdR/lBFiJpF01Z1OIzO0G6YTio2depaq5mGhDOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DrqxZDm576aQC0ol2crgwWcsP9EijKHCRjF/uQw0tvkYshp1YEF0bdL0pnNeFa6UH476JrE1qHAQudVVDB78umOXew63oNTxcQM6XnkvSv1agV0a8vPt9p1KjXJ3uiA7CmmCNPWJ8P771d+r0sbOuyglFf7PcXt2UlsrjMbSEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vol7zITN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBcr30tn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RywpLmAaEKXr7DP5hCgWvvj/+hzmJ5kykcM95l+s4g=;
	b=vol7zITN37V8f6IdnPjad6aldBSLIBCoBI82ktG0Rc3OPFkRLey9CsR+iQO5cN5WLq4bwh
	IdoPx4YYQFx7fpeVceeiYDWbIYbnLOucaRUbrXDZtT1CXGXI9kYIriOyxGb1yzHekws8V6
	ajJFZp8Mpy0JI4FxXvVX4jGyz/XRPG+ZL+qi8AbVEkEU+hp60AS9TlIsZNAGpOKa0eyNV/
	kGO+XrnIDMTmYBw5MbHQqEzvfNq/GWCfpYOJ/Y7e+uDhGYcMf/yKnFlehW9IOPnuqyYotl
	eaLsZcdprajhaJcob7YY7G0318RrBspznlZScKfbpI+0XrNMD3MbpOU6XGx9yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RywpLmAaEKXr7DP5hCgWvvj/+hzmJ5kykcM95l+s4g=;
	b=eBcr30tneWoUPD8IpXpZYC1+eehjN/VEfJvpCZsQRQFyO0FEuqqItPxpQeNlqAMmG0GFKV
	Iv+HsJ3QjBaOmEAg==
Date: Tue, 04 Mar 2025 08:10:52 +0100
Subject: [PATCH 22/32] Revert "selftests/nolibc: use waitid() over
 waitpid()"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-22-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1615;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/FGAVdR/lBFiJpF01Z1OIzO0G6YTio2depaq5mGhDOI=;
 b=tLCWq54LSTVWzYI8n0Krhq7HmA9ff3fBQkk6K+kHA+7RCN6B72q6ZCQw3uL1yf+s/bnNQvOX2
 6XkqVhY/0JTBQ8KCqF5JnXkohN813+XWnOo9d2cv4ndAzbXitNqJ/Oz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc's waitpid() now uses the waitid() syscall internally.
This removes the original reasoning for the reverted commit as
waitpid() is now available on all platforms and has an easier interface.

Switch back to waitpid().

This reverts commit a0bc8947ac731ff95a56e0c1737e69e8c56d5b78.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7eb7f3fb067553cccefefdaa2ccfc81af281336b..6fa659429cfc38c9d42f36f80ab6c529890d9ad7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1445,8 +1445,7 @@ static int run_protection(int min __attribute__((unused)),
 			  int max __attribute__((unused)))
 {
 	pid_t pid;
-	int llen = 0, ret;
-	siginfo_t siginfo = {};
+	int llen = 0, status;
 	struct rlimit rlimit = { 0, 0 };
 
 	llen += printf("0 -fstackprotector ");
@@ -1484,11 +1483,10 @@ static int run_protection(int min __attribute__((unused)),
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
2.48.1


