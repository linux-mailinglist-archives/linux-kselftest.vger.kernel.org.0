Return-Path: <linux-kselftest+bounces-34049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEEAC8C51
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5527B3B16
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24C2236E1;
	Fri, 30 May 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq4V1QOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A6219A81;
	Fri, 30 May 2025 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601751; cv=none; b=F7vY3BAbF8c7Ysq2YU1vh4AfU0cbDG8tLRk6Gz/yFx9+3tVghrzxTXyM814c6R2GRiayGF8fkmz8FRLVQzxU7Cxctv62/ROpFN25lkVq/mziBSI7/NLyjB8BOJv8CWG1Wv2lIw/K83AOAKFUOMu8WHNwd8GQaL5OtqqhphewYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601751; c=relaxed/simple;
	bh=uc61bsBJSLGuSuh9Jcrbv8/TNMNS1gczvGk3TJaNKSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L3kbY40x+dd1qN3kHw/pKgaICZlvV2DWf73ALsrBsLbsaomiWFk1FoyXivsKaFynQ17rIv5uPX0IYRwMvKAAmjYvotLzeDk6ilmk9+hIKXc+79QCfaoQxJjFaKFr5Aa+UBCWxm/8c0MU6L0CaDM67l+G4Bro+cXtuKJ1kGGTtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq4V1QOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47C8C4CEE9;
	Fri, 30 May 2025 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748601751;
	bh=uc61bsBJSLGuSuh9Jcrbv8/TNMNS1gczvGk3TJaNKSA=;
	h=From:Date:Subject:To:Cc:From;
	b=rq4V1QOhTFtu6WYvLhUsG4RxERkCFeqYCg1yzNMacBFLYgbKut/Hpr1fVYXZWusjy
	 Lihv8O25Fb7DRQz8mKUGKJ1qu3Xu4sg4n4TbV6Z1Reft1XFDnT1CfllK6lP4gGtV16
	 Ard1kh+GT8jLC2JWle2GOwbZVJM2ypt5Hr6UkLi5oHVonJ+RWwMwQjy2IFh/I/N0DA
	 65Tl57WneQqrzXuxEDQYVMVY4SE+UBdM+uQF1NNSLv3fw1VBO3i1dduuvMxZYRVZ+n
	 4ZOfkfV9N7o+x2Wfr5p+GdyDVhPW+ZIPsb/VjcSA+TUOAw68TZgBhJ/IvND5odIpqX
	 EoTPM15UbjcLw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 30 May 2025 11:42:25 +0100
Subject: [PATCH v2] selftests/filesystems: Fix build of anon_inode_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-selftests-anon-inode-build-v2-1-74c47eeeacd1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJCLOWgC/33NQQ6CMBCF4auQWTumUwUaV97DsECZwkTSmg4SD
 eHuVhK3Lv+3+N4CyklY4VQskHgWlRhy2F0Bt6ENPaN0ucEaW5qSKlQe/cQ6KbYhBpQQO8brU8Y
 OjanZmord0VrIwCOxl9eGX5rcg+gU03v7mum7/lj3j50JCWti7x25A1XufOcUeNzH1EOzrusHo
 LFb4sUAAAA=
X-Change-ID: 20250516-selftests-anon-inode-build-007e206e8422
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uc61bsBJSLGuSuh9Jcrbv8/TNMNS1gczvGk3TJaNKSA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoOYuUux6srIgAg/623R/aOfehkFPP2EL4N0FOZ
 74Oi/rgEGmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDmLlAAKCRAk1otyXVSH
 0HQAB/9rYJWf4VDl17XhI9ebWXABeXt2NIdwSKBY56ows9Bej4mHqLFLjqwGnGejTB94xQlX7k/
 +e2spX4/BRSYiLNBG1JBBdMcDXM6VM/Nrdw+bAJBwcwlj4yT+JFQQQMZP69iFCM0g1TOfMavnpx
 mh0EnkQ9X5KrKnmUgXO5q7jLTDnDL4mLW5ybrUXEH+naQO3Zpy1vCpbym0N5bazhspQj3XKuXhB
 PEgpaBRTUfeh7m2o6v7VOXDwUfxblnRB69lkP2SHWgx/AZlgOC1Sd9Nh2BSinsK7EYDnQLUlQhu
 T1TkFrd/WrFueGryrNCA07GfZWBvEs0eII2p32Frgj7mrPKo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The newly added anon_inode_test test fails to build due to attempting to
include a nonexisting overlayfs/wrapper.h:

anon_inode_test.c:10:10: fatal error: overlayfs/wrappers.h: No such file or directory
   10 | #include "overlayfs/wrappers.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~

This is due to 0bd92b9fe538 ("selftests/filesystems: move wrapper.h out
of overlayfs subdir") which was added in the vfs-6.16.selftests branch
which was based on -rc5 and did not contain the newly added test so once
things were merged into mainline the build started failing - both
parent commits are fine.

Fixes: 3e406741b1989 ("Merge tag 'vfs-6.16-rc1.selftests' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto mainline and adjust fixes commit now the two branches got
  merged there.
- Link to v1: https://lore.kernel.org/r/20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org
---
 tools/testing/selftests/filesystems/anon_inode_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index e8e0ef1460d2..73e0a4d4fb2f 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -7,7 +7,7 @@
 #include <sys/stat.h>
 
 #include "../kselftest_harness.h"
-#include "overlayfs/wrappers.h"
+#include "wrappers.h"
 
 TEST(anon_inode_no_chown)
 {

---
base-commit: f66bc387efbee59978e076ce9bf123ac353b389c
change-id: 20250516-selftests-anon-inode-build-007e206e8422

Best regards,
-- 
Mark Brown <broonie@kernel.org>


