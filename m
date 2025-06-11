Return-Path: <linux-kselftest+bounces-34645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796FAD4D16
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255A13A7866
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F32343C6;
	Wed, 11 Jun 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUtSnZ8S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LNeYvbSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878482309B6;
	Wed, 11 Jun 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627515; cv=none; b=RRQpj0m1IZCBirRs66w8+Y928mUyU1Rt8xThKU+agNqRoJdVTeL5PC7MyoqIWSSQgTImMl29k2+byotyeAfaW8M/BbsTiLlOB7xEMgih80wM3PrDi9A5p+we/kob+Tfz8J5SNqMbxuCstzngI8yNmrStoOPmfwZcRGckduckHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627515; c=relaxed/simple;
	bh=VQTecfMbGmIE2mhR3lC6cykpMVHE/XGTMFcN207W2vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJtuYk2515JEBVQHpPYVlTNpTL1HLVXUT41FVK3Z8IZdBz6swxgdkFSIcxjDVdTqHQmWL/1B8GKhAkHnzfPoHZ88mX19g101ZEviaQmkz1HPU/zt3dereSYzN521MwBMFjGq/pk3QHXu+S2nMYuhLP8uq3POfM3N/g6C1bAAZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUtSnZ8S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LNeYvbSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxrB5F7pB41w5mjMWE31LUYj7rWMdcxJbt62UaOAMsU=;
	b=iUtSnZ8SzUl94tBC7W3072/gLmGcrlaE2EhTrJWMC2GDLjcZPMyVl1KreixsLGR48oGRTL
	41lQuTNF3Ct7gb7hOZHrd7N2WMpGx+7pl8TSdAncde6FbKe6cSM0iX7sTwTOd7GFthV/tW
	tmoxU40Ge1JoK1iywTSGHNQpQErtQXKaA4lz5kMjl2BeesEWIiLg2EonyazKjnPHSEgMTU
	MdiT10EeC1oJiNmtL6lXpU5pDgszIDjUqnLdUZw+21K3BMQIQcCEKb0gOd6PSqNBMA0Min
	oKu17jdxQD9/jsQfSL4JuvvCb0kI/rSJHcNAaTQ6K3iB9xnSXwUURDJ47hPaSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxrB5F7pB41w5mjMWE31LUYj7rWMdcxJbt62UaOAMsU=;
	b=LNeYvbSa+LpU/7ZesflVIAWrD2JkrhkWvf19GMqBrxd23szxDDLnHqcSuz7EczU1H0oDlT
	7YPp73cJcxAEYsDw==
Date: Wed, 11 Jun 2025 09:38:08 +0200
Subject: [PATCH v3 02/16] kbuild: userprogs: also inherit byte order and
 ABI from kernel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-2-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1177;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VQTecfMbGmIE2mhR3lC6cykpMVHE/XGTMFcN207W2vw=;
 b=IFuBTpGS+0Ubi/+ZN/eyZa5QO9sDBYBdL8p0IZCQJ6pqJ48E7Q50nmm8O7fsEW2cmBChEcD0m
 YbGBwFi3zgxB/ciDPbleIFJK+oMk2BGULFU+OAUKTBj9jX8WJTM3PrO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make sure the byte order and ABI of the userprogs matches the one of the
kernel, similar to how the bit size is handled.
Otherwise the userprogs may not be executable.
This happens for example on powerpc little endian, or riscv32.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e45a2807dfa257f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
 LDFLAGS_vmlinux	+= --emit-relocs --discard-none
 endif
 
-# Align the bit size of userspace programs with the kernel
-USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
+# Align the bit size, byte order and architecture of userspace programs with the kernel
+USERFLAGS_FROM_KERNEL := -m32 -m64 -mlittle-endian -mbig-endian --target=% -march=% -mabi=%
 KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 

-- 
2.49.0


