Return-Path: <linux-kselftest+bounces-13847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A41934398
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75521C21385
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CE1850B4;
	Wed, 17 Jul 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLMbumAv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D43A8CB;
	Wed, 17 Jul 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250054; cv=none; b=LWC4DSRUQ5LeguFEaq8v7kqfp/PSofnALIH0+x4I/zFwt3PdQscYbHAhuFcrk79RmWkL/e6EFNr1HWCQuyzAKnKIoEGW+HWn+ytvOMnCs1XllOo93cVKS0JFkJVoOTGKzwTVjLqoUwcT6MpYsMvNDgWTKj+TxHPr9HwF1Vi9IVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250054; c=relaxed/simple;
	bh=hx0QDwgtkl7XPPPboI5Y5+whl1JJAdaP0kiIHNpUrFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ff47tPCJgBSjssOmzkWBd33wNVVp//2x3LnKgZ0v0Baixbd+DruHLGFj1AEs9YAu2rhgQFP3cUDaA0CGRNYjTQZBMNz2FAT/dHvB2kvydXu5ED9PmeKHRVldMaPSkOhfKJVJBsIoRrMU3UFqRKmEqhsr2pl0v/Kt5ivkpsvLtpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLMbumAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60B8C2BD10;
	Wed, 17 Jul 2024 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721250053;
	bh=hx0QDwgtkl7XPPPboI5Y5+whl1JJAdaP0kiIHNpUrFM=;
	h=From:To:Cc:Subject:Date:From;
	b=CLMbumAvH706svVyKqCqd2AS2KDtzWf6R9wl6kFPjPMaWffWQfNdIroZWzLwAelZj
	 5UWwtLACy2VHBokwoK0rXL/YGAJIqHr5qMy9pXgmFROKZ/1QmZOcaDK3nYZZmFk+QQ
	 4sN5/Nmdy7P9YoY8Nc8AZJYfmLIDwsBkFBLk8kRgRQ2Tm1XbaszyQGxACIDttP7tm1
	 b5ZmqDOaWRTftKoFQKAJ91uiENGRofMGnhPNGO95woBifKOnfnWS37/O6ncKGpFcDM
	 sLyPUwLfWveD+XiXSjbtLUwHh11WS5JWyEYfwQxnbFwbhFNcMSyN22+MiC6hZ0Xlya
	 ZTLK7pWdSx04Q==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Documentation: KUnit: Update filename best practices
Date: Wed, 17 Jul 2024 14:00:51 -0700
Message-Id: <20240717210047.work.412-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=kees@kernel.org; h=from:subject:message-id; bh=hx0QDwgtkl7XPPPboI5Y5+whl1JJAdaP0kiIHNpUrFM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmmDEDs+QbXewuQGR1tbdvh9esJtQOJRD/O3tua 64PBN3SwouJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpgxAwAKCRCJcvTf3G3A JkAsD/9q2jXtZWkpZFiNft5vxU/PHm//mD+0lzWW+7WLTyr7XmF9o9O/QA4pVpQKttRpb/J9nvI FazHC9c3CgYi1splpIjPfdfNcVr8wTOtQbSOjJpgI8ppmDPzL0Z4HVLL3MeH1yUnjcD91stXBPv lHckhC6nRn+oeYa7gFtS+kTp0yCuqHjUCGDTxBmdilLwpRDUh4oLakhdzqqfhq3nxEAz08dKmUN 4P2gxUeo0IgwOa6ciO+pPTiiDgV/1ko1V44CjOw2h6pXEZdkhW+Pk8Oi6Jhn0Ec7t7q85D6Tz2R PO8i1BHGYSX93CKQSdoJub6u4SGnyCyma8GTdFz71HpdfM8XAOztcWJMI4YMnnxKqyexjW6gOOM yeZ41vK1cFlK6/jupmp5BkbsJgpB3t7WnaLPRWxp3oLubAL+651cFO0rSsgZj+5dq+9Rzr/GTGw GphdIflMOZ+Ji6SH19zx2Um7yAU7xUTVHsFm67JXvSOTRECLhQq1J1zKxU/vbH1D/A9LWUQhBPD k//jo3ZyMamL9+Vvibk0AcI0BYu6rbGVAHcTeJgQ1lVdNJ475wHT2ppPchH4hnSnxTnl9ILm65V ScI8oFoOJqd4Y5pfNqeS+R2MPSHa2FOuq4s1Pw/aJRNzByevR8oQOg6vK4e9k/9gIX7250i7Abu XDwp+bvDplrC4
 eA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Based on feedback from Linus[1], change the suggested file naming for
KUnit tests.

Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Rae Moar <rmoar@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-doc@vger.kernel.org
---
 Documentation/dev-tools/kunit/style.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
index b6d0d7359f00..761dee3f89ca 100644
--- a/Documentation/dev-tools/kunit/style.rst
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
 Test File and Module Names
 ==========================
 
-KUnit tests can often be compiled as a module. These modules should be named
-after the test suite, followed by ``_test``. If this is likely to conflict with
-non-KUnit tests, the suffix ``_kunit`` can also be used.
-
-The easiest way of achieving this is to name the file containing the test suite
-``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
-placed next to the code under test.
+Whether a KUnit test is compiled as a separate module or via an
+``#include`` in a core kernel source file, the files should be named
+after the test suite, followed by ``_test``, and live in a ``tests``
+subdirectory to avoid conflicting with regular modules or the core kernel
+source file names (e.g. for tab-completion). If this would conflict with
+non-KUnit tests, the suffix ``_kunit`` can be used instead.
+
+So for the common case, name the file containing the test suite
+``tests/<suite>_test.c`` (or, if needed, ``tests/<suite>_kunit.c``). The
+``tests`` directory should be placed at the same level as the
+code under test. For example, tests for ``lib/string.c`` live in
+``lib/tests/string_test.c``.
 
 If the suite name contains some or all of the name of the test's parent
 directory, it may make sense to modify the source filename to reduce redundancy.
-For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
+For example, a ``foo_firmware`` suite could be in the ``tests/foo/firmware_test.c``
 file.
-- 
2.34.1


