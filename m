Return-Path: <linux-kselftest+bounces-38695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F1B21453
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D103E4B31
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8402E11AE;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0qNMgoB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839422E0B64;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936895; cv=none; b=UjXypbWJB1PXBzhI9ot+yic5IB87kE3NUhO9sQwaJFIuBRHcCwiobXkLsj9j8j5Cc2hHUWDsZzhF/T9O8yMAj1nDmOcKX7tbP8v07khQcTNICQUQ8wY0QRcgP6+FyCSchwYShtmw8YsEhhrMGHBgMHJ2SJjkvxYRjZkCVFaymxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936895; c=relaxed/simple;
	bh=IVrFmgYuMdiDJL93cZGS1SPLtlUDB68qHGDJJcuGWDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFf8/OLtsRd1o5OCTSbD7KReDtK3875QIVcS1b3NKDUSSUBUrRK263q3Ffyyj9h9ud0e8dgF5U2bZ4R/EYzAu1QIyGX2NYaogOX7HLcaSBxIEiwGS1h/J95mFYD5f25xcwY7snYYKBoMw41WlppNcTIFeiAuOMfGA3U6GSa9C2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0qNMgoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF737C4CEED;
	Mon, 11 Aug 2025 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936895;
	bh=IVrFmgYuMdiDJL93cZGS1SPLtlUDB68qHGDJJcuGWDs=;
	h=From:To:Cc:Subject:Date:From;
	b=T0qNMgoBNnGFDwzgTPKdXv+ECGpbdSQBb4DNCA0JyfImiL0rmlNZtWlDv/dU5tICW
	 QWNMp71VFI9K+mxSp7YSLRBuepSzWWM/og3v4g0f3y9ce7JOGS1pepVwxbrhKjbogH
	 S/8oM8ZlRu//VZLB1VcWs/6xwvQKG7alewkTMu7wsv8lynXUExtERWm4/uqke7SXIV
	 mVzH/LBLmy7KJml+tFHJhDJaJJ7pSiNZteY8GFPfsZTJHsM94Tkn7bEN4zuPHiugeB
	 e/l4ckF2kG/j32Ayp7KmKnmbk3SQ7qC+rCCUmlwsJAgY2a3AtR9XxZRDru+DTRQTwe
	 xpt5DZ8KU5ghw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/3] Test CRC computation in interrupt contexts
Date: Mon, 11 Aug 2025 11:26:28 -0700
Message-ID: <20250811182631.376302-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates crc_kunit to use the same interrupt context testing
strategy that I used in the crypto KUnit tests.  I.e., test CRC
computation in hardirq, softirq, and task context concurrently.  This
detect issues related to use of the FPU/SIMD/vector registers.

To allow lib/crc/tests/ and lib/crypto/tests/ to share code, move the
needed helper function to include/kunit/run-in-irq-context.h.
include/kunit/ seems like the most relevant location for this sort of
thing, but let me know if there is any other preference.

The third patch replaces the calls to crypto_simd_usable() in lib/crc/
with calls to the underlying functions, now that we have a better
solution that doesn't rely on the test injecting values.  (Note that
crc_kunit wasn't actually using the injection solution, anyway.)

I'd like to take this series via crc-next.

Eric Biggers (3):
  kunit, lib/crypto: Move run_irq_test() to common header
  lib/crc: crc_kunit: Test CRC computation in interrupt contexts
  lib/crc: Use underlying functions instead of crypto_simd_usable()

 include/kunit/run-in-irq-context.h    | 129 ++++++++++++++++++++++++++
 lib/crc/arm/crc-t10dif.h              |   6 +-
 lib/crc/arm/crc32.h                   |   6 +-
 lib/crc/arm64/crc-t10dif.h            |   6 +-
 lib/crc/arm64/crc32.h                 |  11 ++-
 lib/crc/powerpc/crc-t10dif.h          |   5 +-
 lib/crc/powerpc/crc32.h               |   5 +-
 lib/crc/tests/crc_kunit.c             |  62 +++++++++++--
 lib/crc/x86/crc-pclmul-template.h     |   3 +-
 lib/crc/x86/crc32.h                   |   2 +-
 lib/crypto/tests/hash-test-template.h | 123 +-----------------------
 11 files changed, 206 insertions(+), 152 deletions(-)
 create mode 100644 include/kunit/run-in-irq-context.h


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


