Return-Path: <linux-kselftest+bounces-30224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB22A7D682
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30041892E43
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B29226D0F;
	Mon,  7 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eb++AmGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWcv17AK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C21225765;
	Mon,  7 Apr 2025 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011782; cv=none; b=aDpF8av1jlLgatyEsK2Rs68UdbxVhqOiUo2rgPv8EpdcKknXL62eWJ0BkhJy4AbbPeI7W7UFVtqqUlrR/phDXYCoNXMRyDICXxTfLZTiuygWaDqNc/1H/Ep1aFvxubZmEI4R5MwYbPw/X9gMmDfCVmqRrKNNQVrlpDAoBUDYn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011782; c=relaxed/simple;
	bh=UUkGY4o+ifkQsc3DKnXn4uCCR2dbB0RnO9mTqC6cgkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pE8RSBaboJC6+kpBXSZ68+VcNQ/2ii+GSkVJKcX9xNW8/VwOYzaHdYWTyKQDpFMvMoOwIrBaavQsE2hBSGlQjeVujzntOCQgkQ562dhydZKbw58XcXM4d30U7FzJcSvFMgDYAIYRIoC8MEkbZJaL0SaU7isd+EorSCmSHK9HcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eb++AmGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWcv17AK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5PnaYTRGYGhHVHk+c6RB1E0+rI4Nljv8ReosjhNj+o=;
	b=Eb++AmGWuA+Lg/Ixwvxjcytg2Sw9sDuUStHzS23MyBfne6a6+jWwNmjgb2+utfz46JWDbL
	Z7jYk+UOY7xL1xCz3cSRkUTthtne34JyIjPlJe4mwBkNaGuiBC1teOIrnytVmfkxxjxPQC
	lZjgwkrgG59ZwvZMN4UKCqnGOKD7ZmOuU7OX228JeS0AXQ2vTKXTI03loJ8xl1SB/8J5Ar
	qSRuwhI1fEFsNpMa5bHX7qKj9AdHHTreAPW5DL7qSFhehp4ayM/D1CMXN5lZt6v7vVOtZR
	0c2eTQ0dvJQprIOhZMhDyHisLr4toRBuzZiLKpXEAkhfTJvUnoYmkKm2uHzR+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5PnaYTRGYGhHVHk+c6RB1E0+rI4Nljv8ReosjhNj+o=;
	b=OWcv17AKsxmJaq6+cw2I+u2TuYKqqpVW02jVmwXS1wJYxYERk424xdM1RsnckZCU1jFQ9o
	jGvaIe2Sfuq+cWAg==
Date: Mon, 07 Apr 2025 09:42:40 +0200
Subject: [PATCH v2 03/11] kbuild: doc: add label for userprogs section
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-3-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
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
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=800;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UUkGY4o+ifkQsc3DKnXn4uCCR2dbB0RnO9mTqC6cgkY=;
 b=5MrqfIWVi0PU8VDN/+HT1jS+ZIea3w8r0ZB3eiXK9wHl9f08gGQQy5VSExElH91pFnjMaJ+v7
 KcQtMG7ewJkAlVksniIxAacYYL3A29yxywvUzwi1wRcAWnXU/HkOI67
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming new documentation should link directly to the userprogs section.

Add a label to the section so it can be referenced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/kbuild/makefiles.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index f905a6f77c965311c491cfd7ab3103185af7e82e..d5cd73820e406276ee2e3721e265e3ed3cc299c9 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -887,6 +887,8 @@ This is possible in two ways:
     This will tell kbuild to build lxdialog even if not referenced in
     any rule.
 
+.. _kbuild_userprogs:
+
 Userspace Program support
 =========================
 

-- 
2.49.0


