Return-Path: <linux-kselftest+bounces-41713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94076B7FD5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFE61C82DD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566742EBDC0;
	Wed, 17 Sep 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBLCKt/k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oV6NLZvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21602EAD16;
	Wed, 17 Sep 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117737; cv=none; b=hNysGjtuy1XYZOVg1iPRhgFJ36KFo8pKHrKVl57Rfp3FY1mWtEUAPXmeSrSduV0K70QwMuCtZIxOpuI/zjbjQ+yC+5FR0FMxuN7nNJXY33ke5VoUp/28lqzD4rO+jmWQeo+7GT2MXOrqAipRQXynzL/PDuJHmSKhYHneeTr+FLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117737; c=relaxed/simple;
	bh=4jrKaNatrlS2U1eS/SPq1jK5+LqX9GNesaZnhV/t5C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SM9kpex/zO/5oo3egiLOd8GPYAXLnHffvGvVKr8JBYDtvJxFGRtyd2js42ffdJTgswYDCG9P5VsiNYFfZWkjb8C0TQfhHdbiwCjy/ST3Zh5u5sdAPblzJcCLO2nqLTYPaNy31Stq0FC8SM0+5+GNQQAhpHTaRPG71GQagmdnEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBLCKt/k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oV6NLZvV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEnEiqv8MrBrNggtOru79S+HEO6OQ8LMpOXpkEewXe0=;
	b=DBLCKt/k3dS7BWaT5fIk4eZieaA31cI16K7p+8qtu3RmYKOnJeteUFFhu1yS9VLEcYZYA1
	zCWIv1MfoKxFmtsyDueA4/CKVv/HWmWFqZFlRG3hUIPMtBjw9WdbZgZWAHMqYzrMfaLIe+
	KMNk2p6icqp7LniuzHYciSb80iTtdydkyj6xxHeGSP9KCCfUrk3Sy9zg+fI4gLOdIigzty
	fnSwVnZz8324Z3y6fRBfRlfIXnx69sE1pC0+yqc2TB7AIZVqeNTQhEFvynXWdjUzAne/Xr
	4ME+kTaZFOBFWlGldxm+smIH/rL5N4V5ZJ+d0mZchftJYEnAFmZfW4s4uCvr1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEnEiqv8MrBrNggtOru79S+HEO6OQ8LMpOXpkEewXe0=;
	b=oV6NLZvVqW8nysBOg+Qtw63QqZ2f9SBNmWkvaz+/eBtuJk4wJZTfl3foKC/jZ//jZJC2rp
	VEjq1L1LjmBYfFCw==
Date: Wed, 17 Sep 2025 16:00:27 +0200
Subject: [PATCH v3 25/36] sparc64: vdso: Link with -z noexecstack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-25-3679b1bc8ee8@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=1408;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4jrKaNatrlS2U1eS/SPq1jK5+LqX9GNesaZnhV/t5C0=;
 b=5D05C1PiiGthWjXxTYFQYwCCXf051B2LPHkCKwscOyPOGzDY7E0en5oVCQyH1EGSdrZtKSAfX
 Bpy13R+3cWRCq0TqGfhLp7V37YgMsBK3+t2He9rMtxoApwdaVoHWWie
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
index 1a4e585c91d7d03d8444cc2e4914fd10cd078fb8..2e911ccc9db71b2888ffc432d75ac8815ecce0f7 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -107,4 +107,4 @@ quiet_cmd_vdso = VDSO    $@
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined -z noexecstack

-- 
2.51.0


