Return-Path: <linux-kselftest+bounces-26275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA395A2FF1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B08D166B94
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9B1B4F17;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLqIcdbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBE16D9C2;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=TbVTjZHFARq+2mHCMsFIaRK6Nm39El27INrDztnim4nCK2F+zJ5DL4dcpGviCCS9uK2JuhCySA+ikXD6xTrI+q4JyoycuOMlM3sVswMkNlO2T9DctCMFi0uip7+EhyVkRWHsu4znvB6es97dfJj33goalFgSZGDSrpwifsQK/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=351EThpS+t9RF8RdHEoGmC3hU66ASzFB3lNONnuywOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KNTl9aI0mmax2s0mm955ymkeFsldIAkUooFhiT/WkEY4MXt66QSdm3a3UM15cg2GzszoKqZ7TeE7AA91SN4cV2RxMp6VZYEUW9/Gc6Kqcgq8N/sPBlvaqp3/fIBAlXUHxjrE2XEHR6ssc42RiY5Jahdg6Ut9nzRFEsf6JaL2Z+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLqIcdbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1819C4CEE9;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233896;
	bh=351EThpS+t9RF8RdHEoGmC3hU66ASzFB3lNONnuywOY=;
	h=From:To:Cc:Subject:Date:From;
	b=uLqIcdbIYJE77AIl5q+iSK0S8Hu1L4LRt/HzGyvvVxcIUJ17NhRAYTQQP2XQ2qVvE
	 C1mxWCGKTJLkcj/goPTlpjG6KWCUkMTKmyWuC5m3a0fEkN4+F4v3w5uXJcQGhmE1+c
	 +RDUB7UIAS++eoPrPRB6SC4a4pJ5fw0iJGDnT5HQtMGny9p669Z64phmkXTUlzJOVF
	 Dr14eZUsnfVezSBvVyM9B2LaUz2f3mgMR8rmWwoPbW8XB9Belz9Gbfw4hEPtmVri2k
	 zhrwP7A6hi8EskQj16QjmFkpFg9sjfNi0+3c0Ho8KZ7fJlqPwl4vgc4NZlvIRbeNO8
	 4lNkfnx6l0ANQ==
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
Subject: [PATCH v2 0/6] KUnit test moves / renames
Date: Mon, 10 Feb 2025 16:31:28 -0800
Message-Id: <20250211002600.it.339-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4504; i=kees@kernel.org; h=from:subject:message-id; bh=351EThpS+t9RF8RdHEoGmC3hU66ASzFB3lNONnuywOY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqUwLSlqT91x4AiX9jzx7Uv0WuKVQla/aI9I2fVqp YB9veecjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkovWb4H/3AQZLNd2ay+rSO Q74tOkyG3ft2p+svZzNq+Gmh8NtFlJFhitvuTxdeGpvti7m8ozv0sPaEZ7b9E79t21C2Yseupxt 38QEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This is rebased to v6.14-rc2. I'll carry it and folks can send me new
tests, etc, as needed to minimize future collisions.

 v1: https://lore.kernel.org/lkml/20241011072509.3068328-2-davidgow@google.com/

Thanks!

-Kees

Bruno Sobreira França (1):
  lib/math: Add int_log test suite

Diego Vieira (1):
  lib/tests/kfifo_kunit.c: add tests for the kfifo structure

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

Kees Cook (1):
  lib: Move KUnit tests into tests/ subdirectory

Luis Felipe Hernandez (1):
  lib: math: Move KUnit tests into tests/ subdir

 MAINTAINERS                                   |  19 +-
 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c => tests/utf8_kunit.c}   | 149 ++++++------
 fs/unicode/utf8-norm.c                        |   2 +-
 lib/Kconfig.debug                             |  27 ++-
 lib/Makefile                                  |  39 +--
 lib/math/Makefile                             |   5 +-
 lib/math/tests/Makefile                       |   4 +-
 lib/math/tests/int_log_kunit.c                |  74 ++++++
 .../rational_kunit.c}                         |   0
 lib/tests/Makefile                            |  41 ++++
 lib/{ => tests}/bitfield_kunit.c              |   0
 lib/{ => tests}/checksum_kunit.c              |   0
 lib/{ => tests}/cmdline_kunit.c               |   0
 lib/{ => tests}/cpumask_kunit.c               |   0
 lib/{ => tests}/crc_kunit.c                   |   0
 lib/{ => tests}/fortify_kunit.c               |   0
 lib/{ => tests}/hashtable_test.c              |   0
 lib/{ => tests}/is_signed_type_kunit.c        |   0
 lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
 lib/{ => tests}/kunit_iov_iter.c              |   0
 lib/{ => tests}/list-test.c                   |   0
 lib/{ => tests}/memcpy_kunit.c                |   0
 lib/{ => tests}/overflow_kunit.c              |   0
 lib/{ => tests}/siphash_kunit.c               |   0
 lib/{ => tests}/slub_kunit.c                  |   0
 lib/{ => tests}/stackinit_kunit.c             |   0
 lib/{ => tests}/string_helpers_kunit.c        |   0
 lib/{ => tests}/string_kunit.c                |   0
 lib/{ => tests}/test_bits.c                   |   0
 lib/{ => tests}/test_fprobe.c                 |   0
 lib/{ => tests}/test_hash.c                   |   0
 lib/{ => tests}/test_kprobes.c                |   0
 lib/{ => tests}/test_linear_ranges.c          |   0
 lib/{ => tests}/test_list_sort.c              |   0
 lib/{ => tests}/test_sort.c                   |   0
 lib/{ => tests}/usercopy_kunit.c              |   0
 lib/{ => tests}/util_macros_kunit.c           |   0
 40 files changed, 458 insertions(+), 136 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (64%)
 create mode 100644 lib/math/tests/int_log_kunit.c
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)
 rename lib/{ => tests}/bitfield_kunit.c (100%)
 rename lib/{ => tests}/checksum_kunit.c (100%)
 rename lib/{ => tests}/cmdline_kunit.c (100%)
 rename lib/{ => tests}/cpumask_kunit.c (100%)
 rename lib/{ => tests}/crc_kunit.c (100%)
 rename lib/{ => tests}/fortify_kunit.c (100%)
 rename lib/{ => tests}/hashtable_test.c (100%)
 rename lib/{ => tests}/is_signed_type_kunit.c (100%)
 create mode 100644 lib/tests/kfifo_kunit.c
 rename lib/{ => tests}/kunit_iov_iter.c (100%)
 rename lib/{ => tests}/list-test.c (100%)
 rename lib/{ => tests}/memcpy_kunit.c (100%)
 rename lib/{ => tests}/overflow_kunit.c (100%)
 rename lib/{ => tests}/siphash_kunit.c (100%)
 rename lib/{ => tests}/slub_kunit.c (100%)
 rename lib/{ => tests}/stackinit_kunit.c (100%)
 rename lib/{ => tests}/string_helpers_kunit.c (100%)
 rename lib/{ => tests}/string_kunit.c (100%)
 rename lib/{ => tests}/test_bits.c (100%)
 rename lib/{ => tests}/test_fprobe.c (100%)
 rename lib/{ => tests}/test_hash.c (100%)
 rename lib/{ => tests}/test_kprobes.c (100%)
 rename lib/{ => tests}/test_linear_ranges.c (100%)
 rename lib/{ => tests}/test_list_sort.c (100%)
 rename lib/{ => tests}/test_sort.c (100%)
 rename lib/{ => tests}/usercopy_kunit.c (100%)
 rename lib/{ => tests}/util_macros_kunit.c (100%)

-- 
2.34.1


