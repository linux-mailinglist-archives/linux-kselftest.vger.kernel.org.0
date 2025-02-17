Return-Path: <linux-kselftest+bounces-26761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22FA38119
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7E168713
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562EC21773D;
	Mon, 17 Feb 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVZxORj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAO4g1Rk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7947217716;
	Mon, 17 Feb 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790039; cv=none; b=jIoEpQAP3HJDOPBUhOesyHnlHypyzJpMH+glHswg8eSsy7OAztJkOiHFiCMaj/oBW8Hek5+abPd+nmWIoFVUowI0VHtSEZwFsAa2xSWAC6WEnd/g+VlLcuhn3o8+TBK+/ktcIxugZH1K2qStFV/rVojtRx1+DDc9LzdCggQiX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790039; c=relaxed/simple;
	bh=1eJaz8tcbhUuEkRn5XBcnGfKRMXHc58fjTtiPznAV8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtvRAO16/T+uoBkRQg/tZspmNT3Y+1qQjchQGXY3Q2/GtqZsP7Xad8P7FwxEZ6YVL1By/AZvwh/nZIxFt6u/V/7Vaadio2NBJmRoNOkhA95qacRMUtGRHxvUDOznl8/+AGPrslSVh42IureJGufIRAcYi56VEtjgScOmcILtubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVZxORj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAO4g1Rk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvsyEkTJZdl7d2gno8A3VI/QC8RYoPkLuhmYx+KvTqY=;
	b=FVZxORj/uTMmrkQMCreUB30ZVjbRynx1FL6ZsBFWpMaqwWPbm6w3KtlSCLRcOJk9NRHfmN
	5EE31keem3dX1UaT71Q3RHxeATk2xJfnsE3WuSIGfdkEg3VpXeRGO/p69Wie0SmyjayAAA
	wU86BXB7Axn7qc2HF3dGag9EjgFEVNvevsRjrFh/q/6O4Hj3xabZn9Vji3i67krBWGmTsu
	qSlNHnsIdzjVRxkqa8+wdfpZHAus1er+xOQsJC9dwO2JU4ojELbq6wYCW9Lf8IyXlIEAh9
	U/v+S/qNQFjLST8laYzkNeR44GFB31EvFSPcCRT+RcXCj4+7CFNYbJwMFawJ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvsyEkTJZdl7d2gno8A3VI/QC8RYoPkLuhmYx+KvTqY=;
	b=nAO4g1RkEz+HslqPucvDyPkYlL1WttU8zh/KpfzPUwoUYbYgO7FrZpkP1bWpgglaBTnyuH
	XnTwA6FRGFpxgpAw==
Date: Mon, 17 Feb 2025 11:59:21 +0100
Subject: [PATCH 01/12] kconfig: implement CONFIG_HEADERS_INSTALL for
 Usermode Linux
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-1-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=1658;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1eJaz8tcbhUuEkRn5XBcnGfKRMXHc58fjTtiPznAV8Y=;
 b=7fXsYl7gDcHgQEPAqhLIu66XKFSSaF7nv8fekpa46pGteZF+TJ/yIfM+WSmpIwfmEZtTSu2IH
 igakxQE/i5pCghDA2ea6d5Wwuja2iSpMdQohVDC1o9TaAOG7dgX71hZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

userprogs sometimes need access to UAPI headers.
This is currently not possible for Usermode Linux, as UM is only
a pseudo architecture built on top of a regular architecture and does
not have its own UAPI.
Instead use the UAPI headers from the underlying regular architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Makefile          | 5 ++++-
 lib/Kconfig.debug | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b4c208ae4041c1f4e32c2a158322422ce7353d06..275185d2ff5d3dc99bd7982abd1de85af0b9621a 100644
--- a/Makefile
+++ b/Makefile
@@ -1357,9 +1357,12 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 
 PHONY += headers
 headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
-	$(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
+ifdef HEADER_ARCH
+	$(Q)$(MAKE) -f $(srctree)/Makefile HEADER_ARCH= SRCARCH=$(HEADER_ARCH) headers
+else
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
+endif
 
 ifdef CONFIG_HEADERS_INSTALL
 prepare: headers
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06f6e3f7beec4bd086c00b412c83ac..60026c8388db82c0055ccd8b8ac8789d6b939b62 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -473,7 +473,6 @@ config READABLE_ASM
 
 config HEADERS_INSTALL
 	bool "Install uapi headers to usr/include"
-	depends on !UML
 	help
 	  This option will install uapi headers (headers exported to user-space)
 	  into the usr/include directory for use during the kernel build.

-- 
2.48.1


