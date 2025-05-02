Return-Path: <linux-kselftest+bounces-32210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E24AA78A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31F41B6851B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046B26157E;
	Fri,  2 May 2025 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tM64lHtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4854A32;
	Fri,  2 May 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206702; cv=none; b=AEK0qDt+AqYdkXdlAav2Af+uQQaw5rZRoTWQU0ZmjDuH03C7XfXGVeX1KtIbT6dthCWb7gxWqoHdIx+masx0UiRbYzXZTn+j4IU918i/61HCDI5YF7Ja6POJ//DoKuplEKWmXumFkiDPUaMHLb8v9y4cvCuSe2ayvqtfLtgn4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206702; c=relaxed/simple;
	bh=2cGLsKah/POrdc4clt/UyRsunwEB/yKQBASlqHtH9KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Azflk/10zau2TGHFBiwhJBDHejTEOnBqchal4Ykb30IgUsiWZZwNpxnU1FXgVqs55p095HkVfg2HqRqcfe1UY1FCzcr+j9pUul0rpiF2mxxnSLDo/L2qGQiN89azarh4NFZbHi/vnDwQcIgle0OnDsKtBvo2A5OJjdhMH9dti/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tM64lHtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39609C4CEE4;
	Fri,  2 May 2025 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746206701;
	bh=2cGLsKah/POrdc4clt/UyRsunwEB/yKQBASlqHtH9KM=;
	h=From:To:Cc:Subject:Date:From;
	b=tM64lHtgaSfwvXo8jexwrAKozvGBRLCgRO3RgS05BGSJOUVaOLufohC1+pr0f0DOZ
	 Lm5zvZ3aOoKCDbqAG8N5NkXAR4N5/+s+vBqujq8orRi1kbriywsWZa0MUlGElNk8j/
	 mD27RYxQm1HNZX451I0tesXS10GkBXfNmZuzau8o=
From: Shuah Khan <skhan@linuxfoundation.org>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas.schier@linux.dev
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] kbuild: use ARCH from compile.h in unclean source tree msg
Date: Fri,  2 May 2025 11:24:56 -0600
Message-ID: <20250502172459.14175-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When make finds the source tree unclean, it prints a message to run
"make ARCH=x86_64 mrproper" message using the ARCH from the command
line. The ARCH specified in the command line could be different from
the ARCH of the existing build in the source tree.

This could cause problems in regular kernel build and kunit workflows.

Regular workflow:

- Build x86_64 kernel
	$ make ARCH=x86_64
- Try building another arch kernel out of tree with O=
	$ make ARCH=um O=/linux/build
- kbuild detects source tree is unclean

  ***
  *** The source tree is not clean, please run 'make ARCH=um mrproper'
  *** in /linux/linux_srcdir
  ***

- Clean source tree as suggested by kbuild
	$ make ARCH=um mrproper
- Source clean appears to be clean, but it leaves behind generated header
  files under arch/x86
 	arch/x86/realmode/rm/pasyms.h

A subsequent x86_64e build fails with
  "undefined symbol sev_es_trampoline_start referenced ..."

kunit workflow runs into this issue:

- Build x86_64 kernel
- Run kunit tests:  it tries to build for user specified ARCH or uml
  as default:
	$ ./tools/testing/kunit/kunit.py run

- kbuild detects unclean source tree

  ***
  *** The source tree is not clean, please run 'make ARCH=um mrproper'
  *** in /linux/linux_6.15
  ***

- Clean source tree as suggested by kbuild
	$ make ARCH=um mrproper
- Source clean appears to be clean, but it leaves behind generated header
  files under arch/x86

The problem shows when user tries to run tests on ARCH=x86_64:

	$ ./tools/testing/kunit/kunit.py run ARCH=x86_64

	"undefined symbol sev_es_trampoline_start referenced ..."

Build trips on arch/x86/realmode/rm/pasyms.h left behind by a prior
x86_64 build.

Problems related to partially cleaned source tree are hard to debug.
Change Makefile to unclean source logic to use ARCH from compile.h
UTS_MACHINE string. With this change kbuild prints:

	$ ./tools/testing/kunit/kunit.py run

  ***
  *** The source tree is not clean, please run 'make ARCH=x86_64 mrproper'
  *** in /linux/linux_6.15
  ***

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5aa9ee52a765..7ee29136b4da 100644
--- a/Makefile
+++ b/Makefile
@@ -674,7 +674,7 @@ ifeq ($(KBUILD_EXTMOD),)
 		 -d $(srctree)/include/config -o \
 		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
 		echo >&2 "***"; \
-		echo >&2 "*** The source tree is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
+		echo >&2 "*** The source tree is not clean, please run 'make ARCH=$(shell grep UTS_MACHINE $(srctree)/include/generated/compile.h | cut -d '"' -f 2) mrproper'"; \
 		echo >&2 "*** in $(abs_srctree)";\
 		echo >&2 "***"; \
 		false; \
-- 
2.47.2


