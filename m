Return-Path: <linux-kselftest+bounces-25551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C0A25566
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566231886256
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0422010FD;
	Mon,  3 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqHJOYRL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rybI6sz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77B20013A;
	Mon,  3 Feb 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573529; cv=none; b=q/TpadB0F0a9+nbn6Lrm0fd9ZRRwQ5z8Xz0iQqdSanqwXfmYbnCsLDGzo9RWKz0i/yjrr1uPnPmCzc/GnSpbXOvMMXvsYBFJFcLEhrb2cJ2TQ7DmQiQROLbcxqqTTwmropTYULX3rJsFpTinaNNMDuZwO+maedaufcY6quE5WMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573529; c=relaxed/simple;
	bh=M1LNRTP++ni6j86RT9Rb5Y7RmFRtlZo8BBJFYlsbVjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsFA1tnifuDpuur/Xhw6NP3moJc3WAVm+2qV4dDEFjMWYgjn7t/8N2IMkkYxKkTAyNvt4xSHo9VkO6MPmj0hyp2JREVbmQSTNDeLWcxA608CpYpLXQiiozokq/QMsKFd67KzkNbXAXK86KBgl/F8GeOlXZ/UoPoMz7MMjZ25gE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqHJOYRL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rybI6sz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akjX6ejZy6yrjMb8T4TWrINw3z0nyCa+K645jeCYdtU=;
	b=UqHJOYRL16V8iJkhRHeGNFCghjH4fyhS1flQsI2QrAvDEHe13267dEjB6OtyxCq2nrOXm8
	Wi6Ce7ido4LLW4mO3Hk+sz30Xnh7ddepdAADMIenVUaAwkH4VpuNtGyySMClyJrsKteEgy
	BhHewXdJG96x6RTzomwjwGMu8Rdq2NwVWPyc9yDj4WcNkO9DzTreQ2EMs5X65r9/I8Q/J3
	+AwuVUUtXpACdl+Zta9bPe17LQRBNm3zn3i0EJD/KTks5iV2B48iKIgWxg+RguF5Id+7EL
	MM7iU4gQUFKSbecqSHzFKIfu0JsPCXza0t+XhsDa0mpOvwf8oZLtBXqqCna6Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akjX6ejZy6yrjMb8T4TWrINw3z0nyCa+K645jeCYdtU=;
	b=+rybI6szJmwaOxnMbGkpE1H0dn8OSbN7Z3I5x0wi1pTVv5WtLBpnD1xPYrt6z2X0Vh+rtz
	7Oj39xC4G/+BxuDg==
Date: Mon, 03 Feb 2025 10:05:16 +0100
Subject: [PATCH 15/16] selftests: vDSO: vdso_test_gettimeofday: Make
 compatible with nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-15-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=811;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M1LNRTP++ni6j86RT9Rb5Y7RmFRtlZo8BBJFYlsbVjE=;
 b=tc0ELT6WhbHsJLvQddowjngOvtPYhzILhrX41ImTVVgJKAtZb4t+Iv2gwURamYqufz368zilT
 ejOhdeac9lPB6l0Kn3cv1zKLlfQXV+b1zaxTjWqCUDh/C26xTuB7yD8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc does not provide these headers, instead those definitions are
available unconditionally.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 636a56ccf8e4e7943ca446fe3fad6897598ca77f..9ce795b806f0992b83cef78c7e16fac0e54750da 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,8 +11,10 @@
  */
 
 #include <stdio.h>
+#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
+#endif
 
 #include "../kselftest.h"
 #include "parse_vdso.h"

-- 
2.48.1


