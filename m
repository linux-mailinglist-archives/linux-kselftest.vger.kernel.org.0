Return-Path: <linux-kselftest+bounces-35819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7AAE95C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B447AEC40
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9D23B619;
	Thu, 26 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmIo2LNf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/6zJfpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D122DA1F;
	Thu, 26 Jun 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918223; cv=none; b=R05aKnKr9L4wO6ryho//9WaxvxuwDhuRAATl0UfGLCDyR1db+mIvIlFStdhygBX/P/cHGJjIZkKK7Nbh+8IRHTTzLDNPvIlQM8KFDvPQhKrZU/X8jMX8c4ExTKcSQoRuXE886eN399jMfmSYaZdIEWubTVAA8SoEj40v41/GBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918223; c=relaxed/simple;
	bh=h7DYdHC1OtpWy7vh2b+uyM13209qgHTI+Y+hFSGtCGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aq3NVQvU8iHDquJJhZt0XT2KSKbzIAtJhG2qVmCxy+dmS+554hKtQICDTkB3wmF0fv2Hh0uJHypuWe1IZmTs18qMPOschCtyFBVbLDkNT0Bku2cj54mHISqJAKurWKlEnQihOQL72M2tIzkJZYYGtmefJycZKPpqAFIXh22jZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmIo2LNf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/6zJfpp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnuX25+yiOU4QMtDptciO6cM4cnjM1y/MC4HVWlwD98=;
	b=wmIo2LNfnGV1LMap3Iz/FrTpawbjSABWQzAr+SgTzhraLdEVOkSVLlg95gLVY2Z47dErUt
	S5h0fkrwsFaWerbmKaAUBvUs9BzvDPqAyCTD+NINUHhs37CJJqOq/AohsNiLLPKHMNRikx
	Gd2cAfPqabgoX0RxW5mhXYL4vjn2cTUOoVgvyEZ8NVpkwewlEceIab3R9/ytCt4fDh9HuR
	9sxQ6qtSN32jQI3F9N8zU4DTwi6fEy7KvD49udib4oQVj2MOAYa/rdQ/y0rIw/xzCvjPrM
	IUYcW38P92bdkfdZp4Ll9jwtDwWg8O+ukwzY4PvI8HVDaelht2JXnUPL5pyiSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnuX25+yiOU4QMtDptciO6cM4cnjM1y/MC4HVWlwD98=;
	b=y/6zJfppz8B5ZRscW3CJHAC+Wp4SCIH946jtZk0y0je2G0JTs55+vHwHIVfH9ixqMbSgld
	MFGiHG8nYbn+pDAg==
Date: Thu, 26 Jun 2025 08:10:12 +0200
Subject: [PATCH v4 04/15] init: re-add CONFIG_CC_CAN_LINK_STATIC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-4-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=1194;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=h7DYdHC1OtpWy7vh2b+uyM13209qgHTI+Y+hFSGtCGA=;
 b=pToUf3ZJV4fZXrlp35p1Dlfk5Td0WAWgKb/+e9jRJmwQVY5tJfcMZS2h/b+tAaEfNTCld+BQQ
 H0cGVu0I9waADBJz/Ew79uOsYSmn2XoLsDB6m6WYCAe0hIQbVQwJ2I+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For the kunit UAPI functionality this feature is needed.

This reverts commit d1b99cdf22e0 ("init: remove unused CONFIG_CC_CAN_LINK_STATIC")

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554bbcdf193852cf5c1d2c2accc64f..26cafbad4f1560fb56b4bef31ae29baf54175661 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -87,6 +87,11 @@ config CC_CAN_LINK
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
 
+config CC_CAN_LINK_STATIC
+	bool
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN

-- 
2.50.0


