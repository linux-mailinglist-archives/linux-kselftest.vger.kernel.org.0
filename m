Return-Path: <linux-kselftest+bounces-33289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFBABB06B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76278188C812
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391C1DB356;
	Sun, 18 May 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVIGvpw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52EC13B;
	Sun, 18 May 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747576905; cv=none; b=hxwME4FXj+RONaKPeebZ1x3ShTS/aTr4eGvqpYehl2ynuZ0DVBM1USCrX68Huk9sBbncF4/Tn2Sbz5OepVCfZ4187R+s63XuuFUpjZFi5CAwy6sPe3Eqigkb8Jcw6qzFmLFnTJxbUv/WehMySqTK7INubCa+arOLEoL814+oyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747576905; c=relaxed/simple;
	bh=wt/j0ZrAf0AZ3PPUUZAaCFknAZEi8dhs7KLe2oe6TEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IDLFIm0PueDSFJgeq13rYgkkU2YZVQjjvYa/KDVeiwlmETcyJcy+3ev0/DARy80fqsRiNyD7Yh4TfcXR+zB3is3WgR3Lcht3Q0ufMGTi9zQxgu5/y3Oqa519MugowDD/1xYILNuF/7M0HlHR7t+XdzpXthi5BKZsdT6Iviy53D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVIGvpw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED34C4CEE7;
	Sun, 18 May 2025 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747576903;
	bh=wt/j0ZrAf0AZ3PPUUZAaCFknAZEi8dhs7KLe2oe6TEc=;
	h=From:Date:Subject:To:Cc:From;
	b=cVIGvpw/ClvxbGYbYhrzlbHNrXrP36MlgVcjXdpSclhM71LJUh0nAYVWyZOUOCMfs
	 IUKJKmQIHVJAALgGSpN5uDJXIftk6luXpTy1u9yRFSu0Q6zEq6EHI31Bw3sxS5iuRP
	 dLvzKtcwiG43EcukX5sRLTrzZGFllPxvkxdvZxQAb40WerEgNGvzbRncrC3MI2654U
	 qj7IiE7ehJLLAoUaUp4gFrjnOTtS/rBy2mVXcsjW9Vv96SKdW1mI8HoSknPF70b4I7
	 ZoWy9m+lBAiETGPu90s+GrMFHGEC9EQg7btNgyfcWz61vzlo3+Oc8Uc8FYFeS/0U2O
	 KQsbbIVk+yI3w==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 18 May 2025 15:01:34 +0100
Subject: [PATCH] selftests/filesystems: Fix build of anon_inode_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD3oKWgC/x3MQQrCQAwF0KuUrA2koa3iVcRF6/xqoGRk0opQe
 ncHl2/zdgoUQ9C12angY2HZK9pTQ4/X6E+wpWpS0V76duDAMq+INXj07GyeE3jabEkscobKgEu
 nSjV4F8z2/ee3+3H8ANtcHZ5sAAAA
X-Change-ID: 20250516-selftests-anon-inode-build-007e206e8422
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wt/j0ZrAf0AZ3PPUUZAaCFknAZEi8dhs7KLe2oe6TEc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoKehEt9PMpJ59l+Fob1MdaOkGaYXd1k6tb8VTy
 RMulHFOZgiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaCnoRAAKCRAk1otyXVSH
 0KFrB/0QYWfH8MSN6wq34vAHVnzjxAmbkkL7KBWQLgO8Xm28ys216B1s3Vtqk7VN+jTuz7PSJ/p
 F0HTzhKfl9x1pR6Fx9XTmjAzasAp+UnOLRTbbGve7yq9FyAKwtluYtrEjEZQbR4NnKXZCiX/KxG
 mHwYEv7YOq50qnL7Z8I942ASRQrpNFkkBpDzrq/Z7oeGA6QvQvMiymT70e3nZZAXcvlsAbj78BZ
 gNHnzmuJpRSDPVcBDs0paJASc7K+M1eO1BCOMwKKNJBAMwvHCyBTYQh3ijUr71eNLW3n9ARdHTe
 dQG16SmQwr5SEQwhVYqk9YUrh4hbpF1Y+O/NJ8WFhHn5J5q+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The anon_inode_test test fails to build due to attempting to include
a nonexisting overlayfs/wrapper.h:

anon_inode_test.c:10:10: fatal error: overlayfs/wrappers.h: No such file or directory
   10 | #include "overlayfs/wrappers.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~

This is due to 0bd92b9fe538 ("selftests/filesystems: move wrapper.h out
of overlayfs subdir") which was added in the vfs-6.16.selftests branch
which was based on -rc5 and does not contain the newly added test so
once things were merged into vfs.all in the build started failing - both
parent commits are fine.

Fixes: feaa00dbff45a ("Merge branch 'vfs-6.16.selftests' into vfs.all")
Signed-off-by: Mark Brown <broonie@kernel.org>
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
base-commit: feaa00dbff45ad9a0dcd04a92f88c745bf880f55
change-id: 20250516-selftests-anon-inode-build-007e206e8422

Best regards,
-- 
Mark Brown <broonie@kernel.org>


