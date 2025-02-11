Return-Path: <linux-kselftest+bounces-26279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003CA2FF20
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E763A540A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BB1C5F26;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQOSxTn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02951C3C1C;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=OnE1J0TCF3UzXXqJDv7rge6HhByUGF4FTp9kbrcecYUI+IYPhPYudwS3k693T0kJp/nPsk0xSvz1VCXuZqXmIW2Z1kw12n1h+XAC0K2sCDvVtS4LPC0qKxkmqsIj738n8DuOVNxzY7g8aC5rdx4FTebSJ3v5ydRtYDwI/gHx9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=gAfzP3Akbt3rrJhscbWO+FbDpwpEfOValH1tmXtVu/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csriO/+ftKgqUzW7FUI/aRA6I8Y1u7yNPEGDgJhe9x5ZABPc4mw9vHC+NUpPAm0lsuWaLnw45PhRkhL87qmVLw34+SPBROImZnZt2yHjy2ulMjRCf6yLrwk7M8ya1oASt9Bw8RT0WIkcLwqGO/w8Nf5Bl/CtA5HnyEsUpTSVuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQOSxTn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043F1C4CEED;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233897;
	bh=gAfzP3Akbt3rrJhscbWO+FbDpwpEfOValH1tmXtVu/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQOSxTn+X5kq43kLaMi4OMg/Y89AeggPpgswLSdj7SFgIEDaeYf8pqY2ias7XpBqm
	 kw3v1ykE9UDnQ+0T4gvyySd6pbK0X7HzG3L9Jog8KvS/Rtn8SvYlZ/HLUwycAyx6Yo
	 qXHbaiwBZOp2EaBaeJhQcZ8nut8IL3g070zKFUzQIEX/OOWpu2FvwJKMnBu+csnVaR
	 tatG15/yCJ9L6PlGE1kWmL7K7yfxk/zKixpdT4RiJj8ygpso7Qx34/Xx4IGqvDIDOI
	 c00dGBgtPlL31P/iunYTXMaf3PIBIwvGKseoDasWV75oy8GVR/bvyg5/Sdag9PfG8z
	 pCRlKVAEql7hg==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rae Moar <rmoar@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
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
Subject: [PATCH v2 6/6] unicode: kunit: change tests filename and path
Date: Mon, 10 Feb 2025 16:31:34 -0800
Message-Id: <20250211003136.2860503-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=kees@kernel.org; h=from:subject; bh=HLI6DJk21kGeUIWW0nIc0fj9BIw5YtsNKNhJ+tB6yHU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqUlJ39dzn/OrKxD6MfTp8fZrL9athwKmZNRyZUqv e/T4qLPHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOpnsnwm/XY1/ZCD6Nt5/Ze vrItSkj7yMYtqyX/+UzaHjL7qPYdvipGhsWLmSY7rVQs7oq4tWtXZNTiRp/TU7zf+KywCLM4p7N CixsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Link: https://lore.kernel.org/r/20241202075545.3648096-7-davidgow@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ => tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ => tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
-- 
2.34.1


