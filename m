Return-Path: <linux-kselftest+bounces-26276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86239A2FF1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DC01889180
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC341B4259;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0eCgAY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF23175D53;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=sBF0OeWcRKaP86ZP0DfjT9FY4fVWFR80Yi95W5yLh6N0IfIv94Jzjho9uXWVIpn+6Zuzz9nIS9Y+TREc1hDvWaJr+P0o4jiaxeR/V5Zma7n0lRgzZ6OR2mElKr0YpD2JXuUu3wzyKbw9S+2XGeEOx0edGKn0YPBT5jPj+WGZrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=H/CNbRKKIExSOBBo689bE82GEti0qTANuIwBEnwrJ3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5xxV7umoCdq3ou2OR8+VB+z5k5ftQBeBgEYIg61ZnD7hVD0TUDUb1H9DfMXN8hdxSdzauwNbxd371p2GiB9Am1of9s5DoSqBeSR2P9HMrukoHTLwl0DgPyNHOhXuzWzeJ9KnqiDC/0uzI3Fnq9l3NFAh7REhCprKpf3TdegRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0eCgAY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95852C4CEDF;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233896;
	bh=H/CNbRKKIExSOBBo689bE82GEti0qTANuIwBEnwrJ3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0eCgAY3KGcWv/sIaJ5aD8ymcs5tIBCJfdGXry2l9mysodb2P0mdEs16JvVqpzb5O
	 NGW085IyD6myvhHD/j5Q4UPL7tEuVg6xNcrrBdh4vJWbEwHvlwnVsq84zrD0tk0ZSz
	 CmSU/36mU0b19CkUxvx3cTC9ah4T9S5U6LskcACo/h6LbxAiE+E6XqRvTie/PsciUC
	 TbxdCInDiuTCs/Xog5T3KAvigGSEkO2EtiZ4QPU0AJbdgd5fA6nS0tzGjdFwg+ozjV
	 hL8Y9hqwVDn9yn9/d7k/fKTKhZDHSub4s/7psBkoaekK8Eu4qGknFGufKJDOQaOE35
	 45w1l+8q99ZDA==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Rae Moar <rmoar@google.com>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v2 1/6] lib: math: Move KUnit tests into tests/ subdir
Date: Mon, 10 Feb 2025 16:31:29 -0800
Message-Id: <20250211003136.2860503-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869; i=kees@kernel.org; h=from:subject; bh=B+Kg5uu/+lAyTwgFo1Ezlkz74SLAmioONnDEVzAUZxQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqVIF2kz37v4n/OKV6zPodcJnEvkFhle2XbwjfjzR yuzJO7v7ChlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZhIVQwjwy+ffRHHt5o1Jemn 12cenxxfJnutSUdaU3nx6bc1vxTeMTEyzDKdVJnEPuHImx+WmfJb9wtObs++HnEjX2Q269tDoQ/ XMAIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

This patch is a follow-up task from a discussion stemming from point 3
in a recent patch introducing the int_pow kunit test [1] and
documentation regarding kunit test style and nomenclature [2].

Colocate all kunit test suites in lib/math/tests/ and
follow recommended naming convention for files <suite>_kunit.c
and kconfig entries CONFIG_<name>_KUNIT_TEST.

Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Acked-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Link: https://lore.kernel.org/r/20241202075545.3648096-2-davidgow@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/Kconfig.debug                                    | 2 +-
 lib/math/Makefile                                    | 5 ++---
 lib/math/tests/Makefile                              | 3 ++-
 lib/math/{rational-test.c => tests/rational_kunit.c} | 0
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..b18dbfc53ca4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3166,7 +3166,7 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
-config INT_POW_TEST
+config INT_POW_KUNIT_TEST
 	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 853f023ae537..d1caba23baa0 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,8 +5,7 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
-obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
\ No newline at end of file
+
+obj-y += tests/
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index e1a79f093b2d..66b10a7f5a84 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
 obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
similarity index 100%
rename from lib/math/rational-test.c
rename to lib/math/tests/rational_kunit.c
-- 
2.34.1


