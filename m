Return-Path: <linux-kselftest+bounces-25547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD6A2555B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073EE166814
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579FB200BAA;
	Mon,  3 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvEN1cOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oF1rtIul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172651FFC4C;
	Mon,  3 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573528; cv=none; b=NeT1ZalMW2dKtbvxvA+8XUxVB5JLahe8wMUZJZgiSnHarwhMb8HCLQ8G8NQGnORvI9QSq8JQ3eWAc4yc1sDbpyJ923N9bSv3w+YokVklZJwkMQaIlSw+uIE5jDRrYnv02kWR3ZWCMTufh+FqF/k4wnWps2z1+3hAszaU+v1Myr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573528; c=relaxed/simple;
	bh=fJM1dVn7zNhQ0eUj0mWU+BrWz8rCvgfwxzZIAbjOWds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXHYIHvoMEIWsFaqFoCMJGL6e3KlccbOjhlazTlSVOkvgtLNsqzKhrI9VC1eURSPnPrJF5thaEm7Xqhk5Lil86sOZAV+yZ4LW5Bz9wTCmt/bl/6HRBx9HtUQ+t7DkElqVtFKw9Ao6yn4mo3wsbQhlu0eqYWLjuFN73Usr5uqwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvEN1cOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oF1rtIul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIWdgZoCmwWBnzk969udACPDuwBISkKWyW+kvFZi0zY=;
	b=nvEN1cOmn06k49QOVYgcSYuPY5VASet5LsKlrY5DYUZOHO4UmeYOuTHYyWx2OLJ4wkvFT2
	ja29nLqXV6qQBiSPYRZZ8jD4RgMVrGmKu10RGdVABquOEtfTIpNicZN5WA4ArSK5CibbOo
	idVN3IMAor/2EQHweC5iQp7PvxrNVEg3kdiDD0JPtJe8WumBoOh6ZLAnsgNPLnoviMOAaY
	FxooXiVCuBCUq1eYPuAaqNED5jsajGMiiMYPUXeWXJqAegS0Pmwu5Pt8D6ojtc+2j3MNjK
	QZS/YhVUAe8sYq817HUGYzz+UdOHcqqnevqre9JX80n6T3KMbdb8FefbljQMTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIWdgZoCmwWBnzk969udACPDuwBISkKWyW+kvFZi0zY=;
	b=oF1rtIulgN3B5woeBiKpzvQTVwGp3aSYHc5lUe24f1IDKPQ9ufAslpGaab29OU3BJWg1nG
	EV6VnsFpjI1gEyCQ==
Date: Mon, 03 Feb 2025 10:05:13 +0100
Subject: [PATCH 12/16] selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__
 instead of ULONG_MAX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-12-9cb6268d77be@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1086;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fJM1dVn7zNhQ0eUj0mWU+BrWz8rCvgfwxzZIAbjOWds=;
 b=P2jF09IdnCieXPEKGoemdM93wx2FWHeUgvh77I2DZzUgYMzUUEK/15O2kADdMBCByL/IGRMDb
 XPonFfZ5batAjxJINdtO2IIyDvSP2J2y/IOTq5G6FHdWQBmcgPx7uiA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

According to limits.h(2) ULONG_MAX is only guaranteed to expand to an
expression, not a symbolic constant which can be evaluated by the
preprocessor.
Specifically the definition of ULONG_MAX from nolibc can no be evaluated
by the preprocessor. To provide compatibility with nolibc, check with
__SIZEOF_LONG__ instead, with is provided directly by the preprocessor
and therefore always a symbolic constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 200c534cc70e2c2381fce3be5c0ebe4cb5675e84..902b8f9984a1f70049d46bcd4f199df24f507dcb 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -26,7 +26,7 @@
 
 /* And here's the code. */
 #ifndef ELF_BITS
-# if ULONG_MAX > 0xffffffffUL
+# if __SIZEOF_LONG__ >= 8
 #  define ELF_BITS 64
 # else
 #  define ELF_BITS 32

-- 
2.48.1


