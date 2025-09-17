Return-Path: <linux-kselftest+bounces-41697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33974B7FB9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FD623A2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84092D6407;
	Wed, 17 Sep 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4QtnQcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clGfyVPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD62BD5A2;
	Wed, 17 Sep 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117722; cv=none; b=IxjNjPYpPC5LcVxaRey/jvMjFn7MK7nRWhWacKF0Bjeq/1HlBF56MsxifXJfjlZxnNjjx9gYyskNHPqKMZYWUdQOeUCdhPNmrbbKz2HBeTM43nynWKjM3hIyLn7mqqzw8GUlJhT6+oglaQkSsQ+aHZaExmgyngv2OpZxUHCnOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117722; c=relaxed/simple;
	bh=maGPJ5m6rp0f0JtOKjpLnq4g+/K6R9WCczlG5vZmDXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oybk1wI64PGAspRnmwUWFFlLW6JXHgsyE23E2MkmoJA7PMN5xMMe+UGQVc8sLccFcVA63TYUZ17q/vuqsIqpey4PUk8qnSTZC7HTbXLdVJXLIXgiuOYHCYlW3+ZWt6peMTFzFBPs3VoS7MzUJPZQVRi6u2sqg24OscnSnnWsgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4QtnQcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=clGfyVPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbW/ewILECNrwapEYf06gddZ1vN+MU9gLssRCizgec0=;
	b=m4QtnQcCK31MSxjh+dQ/zzwM0mnhmi1jnWYMs8gu4rLDgdmNdqaTXrOer0/l4Ju00+s6Zi
	SFSv1DgwATtqiaJNIJQiWemVpnFLqXmIV02TkhawuKglx2ej9IaTYUk63S6eWZZSKznjfF
	zbk+238FoG2GOGudLs9HpMp4X6xYhy1+wJAV8Rh+TgNRAJaX0L29Lq6BhqqR8RGWFHuVzu
	VYkWM4doOsm53wDopkhW8/5/BdoXgXoNJTPhAyPlxZyE/iVqwI75HCHYfynRM4zIRqjgoJ
	9nkceWFKBbewEjxZgBQmGd+d893QObumyuwW/uzZqe6De8IJGsw+G1zUKSis/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbW/ewILECNrwapEYf06gddZ1vN+MU9gLssRCizgec0=;
	b=clGfyVPA7VV3497wcj9EYhoBzk2iEMqGmmfs0sVKNUz1teXbiEXrbouaXv5amtEptG7Gai
	sZmLezU+L7b7A7BQ==
Date: Wed, 17 Sep 2025 16:00:12 +0200
Subject: [PATCH v3 10/36] MIPS: vdso: Explicitly include asm/vdso/vdso.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-10-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=752;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=maGPJ5m6rp0f0JtOKjpLnq4g+/K6R9WCczlG5vZmDXs=;
 b=JlOqDhfUk3zB0p/GtyOo0NcVwNRqy37A8m/sEtoguzh+7sHTXtip9GxD8p4ouF79RMqRLIkAM
 bQXjB0y3SvwB8eP7akGrkm6cTOhtRstHPByaA9ZdhjTIsssUTiO/yhd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of __VDSO_PAGES requires asm/vdso/vdso.h. Currently this header
is included transitively, but that transitive inclusion is about to go
away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index de096777172f082b5b7847a5c14cae5ddaee0430..2fa4df3e46e47b5c9675aeb00ebb96ac3353c68e 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -21,6 +21,7 @@
 #include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 

-- 
2.51.0


