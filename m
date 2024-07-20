Return-Path: <linux-kselftest+bounces-13965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5B938232
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5911F216D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCC1487DD;
	Sat, 20 Jul 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF5xzDDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AF1E481;
	Sat, 20 Jul 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721494491; cv=none; b=PDFCTbaAEFcBDioWkXpvYzY7aIvUW2rRBjMdrLHlRDxWzVnFoQehaZP6x6EXvmYcdHnBdgl3nkEgE+6tAoLxFEW72XxKINGHT0EKiylL2Aov5uZYZ/QzlSP9lWApGT2b1pcqexfEd+J+JhaiUep0fLWsJV1RiGf6Iucnj7P5Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721494491; c=relaxed/simple;
	bh=0fk7KXJgdWQwlGKxQxqidUKlJ+05k9Mh8dJZvLqYVW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QE/HbnyfnSc2C8aA8p4UBl86E/frcCjLN0J86bnRdJ+m+YyYB8gwjQt3uhdVVa5fNlVZnxoVO5rrp8Hu9e1VcN4wTkldgNfpLgreQdiAe0o/8t/6mUhKzTW8kwNRher6qMBUIrvSL99MIaPVtLc7kxPfOUrnBUCqCnbbgMSEhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF5xzDDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FAEC4AF0E;
	Sat, 20 Jul 2024 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721494491;
	bh=0fk7KXJgdWQwlGKxQxqidUKlJ+05k9Mh8dJZvLqYVW4=;
	h=From:To:Cc:Subject:Date:From;
	b=MF5xzDDCPkE0nx+jeh0dtTqk/hE1+DfJeW8E5HxhC88Jktm2yCoF7tbMmuKNyvueJ
	 XsWhUJqTWW2XIFGcSDQN9gvO4b4+gPVvQhfzXOao5nB1oT8+CiFWy1HOxdNDouifBJ
	 W153RPHfVKEgDDzmZzmX8fjH6HSI06YHsezyqvvaj7TapQAVmD0wektpXqxBFLx0i9
	 zW8r+DqmsxBm8SP4MDp6Z/J8jPrLKFgkop9YLOUnqEz2lfrpOwnkl19HXvazFemGA8
	 Ha2YstgqmJ0sM1BWIJxJQ67oq79t2GL75qTogf5ZgaSNZ7AqmSBm7XbVYnmqX/OfSq
	 x7LFQYl7KjBkA==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] Documentation: KUnit: Update filename best practices
Date: Sat, 20 Jul 2024 09:54:45 -0700
Message-Id: <20240720165441.it.320-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=kees@kernel.org; h=from:subject:message-id; bh=0fk7KXJgdWQwlGKxQxqidUKlJ+05k9Mh8dJZvLqYVW4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmm+vUHND5tIObdZT01gSwxbAVlJ0GL/6uV0k5h hwGEQTM8ZSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpvr1AAKCRCJcvTf3G3A Ju7wD/9kzfOMxcJkYF3W8uzaMNovwrY1AV46Tajm946YnUH10f/RGf37PAHvOpEWSWtSfffvuNI 8sIXadYOHXgJRJja36uRaEPXyCjuRN+HdkyVBXRCLiLDwR0UCQ7l0/j0jI9ak6EjN5Ml7+xzuuz AsVEXKp/SgcCL4uYec2ElI8T3vqAhTmlnOMezYovLr/BpZxtZDCyC0bk96R9l2YMUvqoyP/JMUr 4OWEOvj/s53v0Z1OOa8Q+5/KZ411s7v9yA+JB7Bp75fhpQU67UsNI4EM4hHSYmvafLwuovlFIPs 7+zElpMpZIocLqOob6LmTTk30mLGw7PyC9edSNV4hKxa3XacksbP9LdO/c7xFI4JRramu37MhDZ erST4YpQHAXJaIJQyMrPDvm0pmLCfpeVDyVguGDWt8gk+S29S8HZqN6KwcXbFy/GRCokl669SJK Cxh+NrC/Fll3QJb30SvMaD3vyMAZxl3C4N5P1JcwwLjPQl9tvB4OQTu7QfL7B3g2ZohsCZLhMVT lAaLzmwQ3+IYC4vfVk/UMfHlfMOUZWhdRDwjNhALR7A1agEHM6HO+4oT2ZmP0fC9hdh392iHTNM qihcV1KBwGAe15ahbhhOCPCiZwR1gSCsI8TaN6HlDPzz6tSen31djgxAbKVr6+UBCnTSJB/wCZ1 SaZGkpHm4R+sg
 fw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Based on feedback from Linus[1] and follow-up discussions, change the
suggested file naming for KUnit tests.

Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
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
 Documentation/dev-tools/kunit/style.rst | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
index b6d0d7359f00..1538835cd0e2 100644
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
+``#include`` in a core kernel source file, the file should be named
+after the test suite, followed by ``_kunit``, and live in a ``tests``
+subdirectory to avoid conflicting with regular modules (e.g. if "foobar"
+is the core module, then "foobar_kunit" is the KUnit test module) or the
+core kernel source file names (e.g. for tab-completion). Many existing
+tests use a ``_test`` suffix, but this is considered deprecated.
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
+``tests/foo/firmware_kunit.c`` file.
-- 
2.34.1


