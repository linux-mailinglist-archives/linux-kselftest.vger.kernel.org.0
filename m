Return-Path: <linux-kselftest+bounces-23496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBA9F655E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 12:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A94918806A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAD1A2396;
	Wed, 18 Dec 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zRbHESjN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975641B4234
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522712; cv=none; b=urJyFbOllMc2PN44buIz8umgmGcB1QwUK8NMlXdjOyKoLHdVBXdU9aCHwf588LLRbtsI0FCMyI/YBF+DOrBpZBvCa9q96Q8uDFbuyWNPqCrsuimk2ZgIlAUZG06AWyIXRMgYqbVnP2x4ZssqibI/Tn8Jpk8u5WLkDLzcULz2mkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522712; c=relaxed/simple;
	bh=bVQk1IH/oYmp2ISiAjJgs9fhUluBeTZ2boMdlRAm1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sC17XsifLXJ9sbLOU9TnufEqqg4OxeL/T5vsFR88Q5o/RsCt11sLMM69fBy4ip+RFT1e9TSAfaXYR7zwHN3Ta0elF+uufSFJrBpXpfoq4pQvZapL0VKjDTSxDuDb7JAsJyaOil94JSbDZmrqWIkxDK1BLXutG70x1xcOdspRiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zRbHESjN; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YCsTl5N3Fz5DQ;
	Wed, 18 Dec 2024 12:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734522699;
	bh=LBITfqfai7J37XOUwox6hatMirnCfP5i+juTnBH9htY=;
	h=From:To:Cc:Subject:Date:From;
	b=zRbHESjNAMyorCyUxpToqsVkVTb9pimoRoGs0s3pDSN3/nzFAbd0LCV7OY6Mgsy1j
	 MVgvoWuJkO/M2vdvInk+sls7zzXfr49hylKMF/DljnGCFh6rraGLCeG8RiuFdF565M
	 RZfQf7x3Ny5Ex2EhNSuKRVgUNkIqmxAj3LPC7PY8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YCsTk3xmFzCGS;
	Wed, 18 Dec 2024 12:51:38 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-kbuild@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v1] kbuild: Allow building of samples with UML
Date: Wed, 18 Dec 2024 12:51:23 +0100
Message-ID: <20241218115126.264342-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

It's useful to build samples/* with UML and the only blocker is the
artificial incompatibility with CONFIG_HEADERS_INSTALL.

Allow the headers_install target with ARCH=um, which then allow building
samples (and tests using them) with UML too:

  printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
  make ARCH=um olddefconfig headers_install
  make ARCH=um samples/landlock/

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Richard Weinberger <richard@nod.at>
Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Makefile          | 1 -
 lib/Kconfig.debug | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index e5b8a8832c0c..6e2cce16a2a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1355,7 +1355,6 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 
 PHONY += headers
 headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
-	$(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..fac1208f48e4 100644
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
2.47.1


