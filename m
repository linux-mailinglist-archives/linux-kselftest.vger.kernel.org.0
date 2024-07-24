Return-Path: <linux-kselftest+bounces-14181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8AD93B7DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 22:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668C9286069
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DF16D4C3;
	Wed, 24 Jul 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+qyi4q3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233616D308;
	Wed, 24 Jul 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852039; cv=none; b=j09togf7MhULujjG3jeh7iH5Ozv8g7sPU5ssDJ9tNv3yQPDd6BFGXRf3iBIxYCiUrFxDmvh8KIEESydkz3bTKzIm3MVc4r44PhxNuM5FPJAgkeoK8Qm4A+siK4kEpXT/vJpxYAxZPfWDLvnwgM6lq9t5LWLUwI3th/nJTYL+N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852039; c=relaxed/simple;
	bh=mARe7Ca8d/75D50Cp2rVaGOdmiEEiXvk3s+FYqLVEFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fx81UwpomJJ76W0FbycxNNUYHvw+Lp0NFSik4gqHBOXx5I2rdxj5bB10PYhlw3MhhjoKcLHn2hZx6O+oO1BCPatjTXKk5uwVJUu8eh03L84vnxJfNXEtYtz9R1s9LIBIgiSEGjg+i0KWr8/Lt9qy/WcR7ae8wYLAZZxgqGCkuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+qyi4q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02084C4AF0B;
	Wed, 24 Jul 2024 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852039;
	bh=mARe7Ca8d/75D50Cp2rVaGOdmiEEiXvk3s+FYqLVEFc=;
	h=From:To:Cc:Subject:Date:From;
	b=r+qyi4q3xJgjQUiT2rSleZ6dl3KQDpAuFkRzaDdzxj2c5dIi4DQPdzqXBL49qsQ6j
	 Zu9m3Uj4Z3aVEVHbMTnUgyPhS1bsPG7hTP4LbIiLiZ/7YrrwsOZQnrPlnIEhohlq7E
	 GHQ7AEiBSvlXBeIQJd31uNQm/bPTUVwTG1Ww9hb+YZgMyde3s0y/H4AEzzd/Pm5qte
	 QYi9li3HQWK+95W1d2PA7cp0wCfLV/afNxEDNnDBvqfv+QnMYropYmfM6glAcwDjd2
	 vU7o/Uc4/y0e1QM2TIqdaNR9y4JVnii3jGZaz1DCbXUdsdqtBUjy79PtbrjRUtCE8n
	 xSC3uMZEu2kXQ==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] Documentation: KUnit: Update filename best practices
Date: Wed, 24 Jul 2024 13:13:57 -0700
Message-Id: <20240724201354.make.730-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; i=kees@kernel.org; h=from:subject:message-id; bh=mARe7Ca8d/75D50Cp2rVaGOdmiEEiXvk3s+FYqLVEFc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmoWCFgE2lcCtsYXyhQvzRWinL5gJ6Xn6+sTpc1 PEt02k6REOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZqFghQAKCRCJcvTf3G3A JrD8EACEzA6Z60pcotw1RFNmEOr4VVf08Qd4tw2NS5BQnowhxh0K7TWf3CGOyhyVB5ErxLJpFrx Xja0YcR1Zkb9i6waIIox/v3jWWF3tlycZHaotH6dsGlUVaPLdKSHvA3M549Pt/f302wum3EMyVy PILM6jqUrCtUxKJUKWszl4vcfDD1vyN3U67+/tQzUCnTHcL4yQpCdecBZCsAm60ATEBjSv2pHKx ZEePMCW8gAbVp3TeSfjoAyFrpBZybaKG1d/JK19mRfXwkIpRJbX4EHZFzWMrBDzL3hZhrIaBeMY pQCyjXXKKlrmCkBwOHvfZ+V7G3S2p9rwHvxC2JYmZIWP82dowMtSZQ9fh5V8hHz0AVFMa5wvdiH kyL9DumKPlywl/BnPxMxUXqQOB/kzqGh0o9lLDgLxmdVFKSo3YMjsOAl3TzdY6vWXd/Yl2QfsVe FgdL1JpPhMUgKb/h3XtoZeELLUW0v4mNyrZfVGOUSpGKDlwPxyBbYTeMJWaNtOaS0mQUyHLGGga yyBRbrnt3CsOZLH9wcpGtleqYOQNoAB/IkOFviLxL+Hezbjww1ZUz6Tj+tsDRPV6fS+Wm+FCpMO TFYeEtUU518rGmO+1O7uqXDU0XGLl7PJAM1zIrf8xiIRb8cDwAuaROQ32XXhR2ow0xI9Tud69Hs PHR5mHPFgF2EQ
 Vg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Based on feedback from Linus[1] and follow-up discussions, change the
suggested file naming for KUnit tests.

Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3: additional clarification
 v2: https://lore.kernel.org/all/20240720165441.it.320-kees@kernel.org/
Cc: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Rae Moar <rmoar@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 Documentation/dev-tools/kunit/style.rst | 29 +++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
index b6d0d7359f00..eac81a714a29 100644
--- a/Documentation/dev-tools/kunit/style.rst
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -188,15 +188,26 @@ For example, a Kconfig entry might look like:
 Test File and Module Names
 ==========================
 
-KUnit tests can often be compiled as a module. These modules should be named
-after the test suite, followed by ``_test``. If this is likely to conflict with
-non-KUnit tests, the suffix ``_kunit`` can also be used.
+KUnit tests are often compiled as a separate module. To avoid conflicting
+with regular modules, KUnit modules should be named after the test suite,
+followed by ``_kunit`` (e.g. if "foobar" is the core module, then
+"foobar_kunit" is the KUnit test module).
 
-The easiest way of achieving this is to name the file containing the test suite
-``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
-placed next to the code under test.
+Test source files, whether compiled as a separate module or an
+``#include`` in another source file, are best kept in a ``tests/``
+subdirectory to not conflict with other source files (e.g. for
+tab-completion).
+
+Note that the ``_test`` suffix has also been used in some existing
+tests. The ``_kunit`` suffix is preferred, as it makes the distinction
+between KUnit and non-KUnit tests clearer.
+
+So for the common case, name the file containing the test suite
+``tests/<suite>_kunit.c``. The ``tests`` directory should be placed at
+the same level as the code under test. For example, tests for
+``lib/string.c`` live in ``lib/tests/string_kunit.c``.
 
 If the suite name contains some or all of the name of the test's parent
-directory, it may make sense to modify the source filename to reduce redundancy.
-For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
-file.
+directory, it may make sense to modify the source filename to reduce
+redundancy. For example, a ``foo_firmware`` suite could be in the
+``foo/tests/firmware_kunit.c`` file.
-- 
2.34.1


