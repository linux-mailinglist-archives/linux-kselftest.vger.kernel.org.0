Return-Path: <linux-kselftest+bounces-37913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D077B10086
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE774E86B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47E221703;
	Thu, 24 Jul 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NyJSOk6v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+HHiGxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2D1FE455;
	Thu, 24 Jul 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338439; cv=none; b=XBf2xIde4ezfGyBREyrmHBfeO59Kmnnw5sdp6AJ4sX+Fiq3XQdeWVjnm2d+2k4YPEsBAY+h52C4CKvxnGpU4PQ1mzIwwQiHPsyY+ZpqP5Y0XUpTWyOEh8SNb1Wi1bhcOK2gdX8p3pCuyONuijitJkhkFpUPs5mAci5EpjT9rtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338439; c=relaxed/simple;
	bh=OF0zs863T2ln/hf9t9vv6cwCgjqYJUskdPhzQ1YPMKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PauWpv22odr8OOlVP9XmAZc2gYj45pQUjXYSN3RTSc9lTJIo860P9KhCsrNURn9SFTphn75xi7AvGMrt1w5E8lqLyNY4dmkBxLpXJUpUjIY/lcxXfmt40TUzGxREFx/B4Q+xFPbN6rxPq+Q0FoEEAv8yiVXY9oVcJdjpMWDk3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NyJSOk6v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+HHiGxU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTyVW1AyH2uYz1KpZUjxr56LsdGe11sv/GpweXPS2O0=;
	b=NyJSOk6vmdU2uR614yz7FfBgf3go2QgYZQAlrtpMoJuSLCDNl2I0mcYAY3a7+bunmXY74q
	6rEa8evverZGj0Ky1l5ehcFjfbW8whLbW8MBvtBgXLIeFLAfKkQ0WiJEtiCdPU8jiETe3M
	EFrsiwZrr+ph7hAz9Vujnmg/WDReqSw7GAMbnCuptfKXpJpNdYQPfxmS9J3+IKOK+zGCJl
	mJ3dm+hYcFaa+42uFsyUs4XnwAWFUiTEWsfwlLWNsnUK9ZO8V0yrZX0jhssOgg7W7f9B8e
	JTJuToJwq6nhShVj6fq9GGc6V3IQkV9Uji+ooafE7UCdxYhP9iItVg/dgABL0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTyVW1AyH2uYz1KpZUjxr56LsdGe11sv/GpweXPS2O0=;
	b=4+HHiGxUHuRmwwcmfh5CxrgGvE8R+R40NMGmb0L3JXm/z+0gPWS6w/ZyTFCAwTAaXxV81g
	PBKlSKlLsbD454BQ==
Date: Thu, 24 Jul 2025 08:26:54 +0200
Subject: [PATCH RFC 04/14] sparc64: vdso: Link with -z noexecstack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-4-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=1408;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=OF0zs863T2ln/hf9t9vv6cwCgjqYJUskdPhzQ1YPMKg=;
 b=R+X3+xK2CwadfNOR4CPiR5eAEEabRClKLgOhBCa55Ojln/l7oDGiRfTteLyH6slfTaiyw+N+m
 OWtlAE+CvjaDJt3ejfEkRbfA4r5MxsvHgSQpjZn0YKl83D0uiI3xN8f
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vDSO stack does not need to be executable. Prevent the linker from
creating executable. For more background see commit ffcf9c5700e4 ("x86:
link vdso and boot with -z noexecstack --no-warn-rwx-segments").

Also prevent the following warning from the linker:
sparc64-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
sparc64-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index fdc4a8f5a49c5b27fbaee861b24e8b31cfe64477..e8315c6acb743137089d8e77d3539db63979e959 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -103,4 +103,4 @@ quiet_cmd_vdso = VDSO    $@
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined -z noexecstack

-- 
2.50.1


