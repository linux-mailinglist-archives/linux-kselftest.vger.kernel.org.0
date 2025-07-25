Return-Path: <linux-kselftest+bounces-37994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69992B1220C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9180B3AF542
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47202EF2B0;
	Fri, 25 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b="oJGiuZVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from shadowice.org (shadowice.org [95.216.8.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851919E83C;
	Fri, 25 Jul 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.8.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461113; cv=none; b=HFsxxmpU0jN0OJ0IeCtipUGMlD6qZG7njYZP6g00AOlrrbBl5/09mj4zvc9gsoG6br0LyXk47bA2TEgNFIMW3AeL336h1wMPSAOPjerE4R0sN4IDedeSavOOuFRnTp5kvL/Oau0ukkk4J6nHMnKOO8Mfv6seCahrlDFNqEu11QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461113; c=relaxed/simple;
	bh=G9NxamZv7FrgWvPlZzyMyi8LaTF/CSwlDJWZP1/YZBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaxLQB3LLpc637iHBduOf5Ps2KYlFIQYpgpzpfotnoEfGpUx7l2d0f1rY2TyXkDsBOJogYVhKrMGf/QCoHIHPZg8Vh4uP0yFIwY0HZQukWExZIbAR8jNPEtvCMDT//H4ghEbYXDsPkB+/U0UuiKthCLD5Mc3EwZw1cKeh4+BuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev; spf=none smtp.mailfrom=nixdorf.dev; dkim=fail (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b=oJGiuZVa reason="key not found in DNS"; arc=none smtp.client-ip=95.216.8.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nixdorf.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=G9NxamZv7Frg
	WvPlZzyMyi8LaTF/CSwlDJWZP1/YZBg=; h=cc:to:in-reply-to:references:
	subject:date:from; d=nixdorf.dev; b=oJGiuZVavgv019pCle98cM0doVpVnI/JKe
	4nu7GUbIMiVHMq2gGvD7mK2+1AaqPlVAqJqQzbbUWGSyohauAI6z4urjJT1lMqPajhy0/8
	9yJtg+BICjMZBlDHSD7hh/vQ9x/Eah/ZEIkTNr/fFUkSwUXXr/a/262kisR0goG1eqk=
Received: from [127.0.0.1] (p4fc61662.dip0.t-ipconnect.de [79.198.22.98])
	by shadowice.org (OpenSMTPD) with ESMTPSA id 9e57e4b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Jul 2025 18:31:42 +0200 (CEST)
From: Johannes Nixdorf <johannes@nixdorf.dev>
Date: Fri, 25 Jul 2025 18:31:18 +0200
Subject: [PATCH v2 1/2] seccomp: Fix a race with WAIT_KILLABLE_RECV if the
 tracer replies too fast
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-seccomp-races-v2-1-cf8b9d139596@nixdorf.dev>
References: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
In-Reply-To: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>, 
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
 Johannes Nixdorf <johannes@nixdorf.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753461100; l=2897;
 i=johannes@nixdorf.dev; s=20250722; h=from:subject:message-id;
 bh=G9NxamZv7FrgWvPlZzyMyi8LaTF/CSwlDJWZP1/YZBg=;
 b=geugrL6tcFhpFjLWZY041RkSP4TQ/E1zGOqdHVWp/HeJ2YL1LwLwscX1Q300l5wY1ypo9aDSC
 Lvo7hvbyyylCc0CQY21k/ZSaGOr/t3a20uAajyJeS9PUOTzqrWEJt1v
X-Developer-Key: i=johannes@nixdorf.dev; a=ed25519;
 pk=6Mv9a34ZxWm/f3K6MdzLRKgty83xawuXPS5bMkbLzWs=

Normally the tracee starts in SECCOMP_NOTIFY_INIT, sends an
event to the tracer, and starts to wait interruptibly. With
SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV, if the tracer receives the
message (SECCOMP_NOTIFY_SENT is reached) while the tracee was waiting
and is subsequently interrupted, the tracee begins to wait again
uninterruptibly (but killable).

This fails if SECCOMP_NOTIFY_REPLIED is reached before the tracee
is interrupted, as the check only considered SECCOMP_NOTIFY_SENT as a
condition to begin waiting again. In this case the tracee is interrupted
even though the tracer already acted on its behalf. This breaks the
assumption SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV wanted to ensure,
namely that the tracer can be sure the syscall is not interrupted or
restarted on the tracee after it is received on the tracer. Fix this
by also considering SECCOMP_NOTIFY_REPLIED when evaluating whether to
switch to uninterruptible waiting.

With the condition changed the loop in seccomp_do_user_notification()
would exit immediately after deciding that noninterruptible waiting
is required if the operation already reached SECCOMP_NOTIFY_REPLIED,
skipping the code that processes pending addfd commands first. Prevent
this by executing the remaining loop body one last time in this case.

Fixes: c2aa2dfef243 ("seccomp: Add wait_killable semantic to seccomp user notifier")
Reported-by: Ali Polatel <alip@chesswob.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220291
Signed-off-by: Johannes Nixdorf <johannes@nixdorf.dev>
---
 kernel/seccomp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761c7738cefe01ca755f78f12844d7186e2a..fa44bcb6aa47df88bdc5951217d99779bd56ab70 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1139,7 +1139,7 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 static bool should_sleep_killable(struct seccomp_filter *match,
 				  struct seccomp_knotif *n)
 {
-	return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
+	return match->wait_killable_recv && n->state >= SECCOMP_NOTIFY_SENT;
 }
 
 static int seccomp_do_user_notification(int this_syscall,
@@ -1186,13 +1186,12 @@ static int seccomp_do_user_notification(int this_syscall,
 
 		if (err != 0) {
 			/*
-			 * Check to see if the notifcation got picked up and
-			 * whether we should switch to wait killable.
+			 * Check to see whether we should switch to wait
+			 * killable. Only return the interrupted error if not.
 			 */
-			if (!wait_killable && should_sleep_killable(match, &n))
-				continue;
-
-			goto interrupted;
+			if (!(!wait_killable && should_sleep_killable(match,
+								      &n)))
+				goto interrupted;
 		}
 
 		addfd = list_first_entry_or_null(&n.addfd,

-- 
2.50.1


