Return-Path: <linux-kselftest+bounces-14338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABF93E470
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0991C20CE2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDC4BAA6;
	Sun, 28 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sK5m7f5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F93BB50;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161421; cv=none; b=doiY2FNyrtQZdEHnGG1MB+H9+8rwAj9/ZOfDiKqMHKmbXwI42/RaN7GLVZK4XCU0p3vVRoKJK9kyfRsurAQM6OJ9DT9LLn3k05QQIBPJR7kMtLTPpuMxD4hSNGpBLftlBYNXyxxPK6kWvjE5AP3av0vKCkimfDL7Ljofdd0RaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161421; c=relaxed/simple;
	bh=YtQZNF1Xp01+/vf4Ug6818c6NQxMXRGBNPNru0wXX8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9TuWLyYF6Cng0/bYN6o4nfNZgXiBN/fvCP3UkCtKgH5dbc/FyQXMKA7f44Wlly8ZRFJtswco5KysuQzhXV0N6fvvkudmQw80PjZKZyg5OyiDww+tN2Jcx0HEzVVDMDfPtLzc98qjF7PtGu42kYK6+yVpt9YItV93qXGZufV5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sK5m7f5u; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=YtQZNF1Xp01+/vf4Ug6818c6NQxMXRGBNPNru0wXX8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sK5m7f5uPCn2LW08pvehygoUX/wv9JP9xbkFshZwDfLSKwJ4uz5HZVB/isyxDCXCu
	 7che76q4l/XSF/CAghB0AF/v72ZPj3Poql0zJK/70NvGQBlmGwiZikDtK0fE7LclIP
	 W6RobNeshY3fqWbFNd41Sjt6080+902WaNW7BVdk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:04 +0200
Subject: [PATCH 10/12] selftests/nolibc: add cc-option compatible with
 clang cross builds
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-10-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1398;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YtQZNF1Xp01+/vf4Ug6818c6NQxMXRGBNPNru0wXX8c=;
 b=YItm5J56C4ZVJD/V0thuoQoZUzu9rt4DPk9wedEjblzaQPfaXedQEgyIv1L7uLLLJaXrMh/wg
 eFoGPXCkBJoButgG5N1OFIyoXhXLAEFPorDFrc+k2uwo8GOwfjA2syJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The cc-option macro from Build.include is not compatible with clang
cross builds, as it does not respect the "--target" and similar flags,
set up by Mekfile.include.

Provide a custom variant which works correctly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index cdff317c35f2..b8577086e008 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -6,8 +6,8 @@ srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
 include $(srctree)/tools/scripts/utilities.mak
-# We need this for the "cc-option" macro.
-include $(srctree)/tools/build/Build.include
+# We need this for the "__cc-option" macro.
+include $(srctree)/scripts/Makefile.compiler
 
 ifneq ($(O),)
 ifneq ($(call is-absolute,$(O)),y)
@@ -23,6 +23,8 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+cc-option = $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),$(2))
+
 # XARCH extends the kernel's ARCH with a few variants of the same
 # architecture that only differ by the configuration, the toolchain
 # and the Qemu program used. It is copied as-is into ARCH except for

-- 
2.45.2


