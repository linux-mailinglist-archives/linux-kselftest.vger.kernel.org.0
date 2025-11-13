Return-Path: <linux-kselftest+bounces-45550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEBC58AD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFD0500FBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7053546FA;
	Thu, 13 Nov 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCuGLAHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JYvKvU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995D2F3621;
	Thu, 13 Nov 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047870; cv=none; b=p+gL0Edks5E4lVRofH1VmwiJeObeawQ1z/jSUX3UnhPLxDERQjW0wUN/oXlAsl8HoVTRbcTGVKkTPpa3otlRbuvMbPPruCk2lZRVg7FJQ03BinETiEUn8uEhZl1E2jH6ZztA/gx/hI0mZ0s39CLzOmWhp+USjzCE4ZkoFoqbUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047870; c=relaxed/simple;
	bh=TGcKeBkgz11eVd1/eROWlror7QWLtk1vSCzPNBRof8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ttCXTkb42K22AC0qFUOR8ZRekwOId+QxA0oINrZfZl33gggCylwvkz8q2doeqew93z7ZkDWVHLLZlNRHRAfGzPgOJrwxb3iQV8nu6eV1clV9YoHO0uFR8lHWUxtqBvVi9TBc3dkEQqicCRoDVny5CtrDshFE5V73TGRzNZFctOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCuGLAHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JYvKvU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2MmUcroBuAR7K4Pm+x4nWX7nRULthvq86zgxGuC7iA=;
	b=XCuGLAHC41JYD9iHSfmlCYOzURg+oui1YOrr9V7j2ejDGbJfOUbkPiJqrmi81TwE4/NBFq
	t0VwS0/uLzeOmXjEpaAZh+Ra9Xcm3l2wmcNTZffKCAt68cM0f+irOXL0NFPPYnh1Dbjj+I
	SxMLfe05c80K8L3aeWBexjLqMPALX9soAbU8AGUZdY8qqA1yQTPkVcBItzHWu3vvMf/m4z
	UWD4hQ8LT5U40lLw3QPWbOw2cbNDTc4AkEqcu/wHD4BupSkhUL0nxiqW4100kFDtZpeB5G
	nSc3OBBYUODWIU6s+iV5/q9+8ChrVbCHlBfY5HBh9zIGs5AYW7Ih6gFKwAoDJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2MmUcroBuAR7K4Pm+x4nWX7nRULthvq86zgxGuC7iA=;
	b=1JYvKvU6j4kxsK5ivXG5K4/8ip6xWcTlNQ7nfrnzYWrgcLm1eqK7dSvEwGT2/7xwq8LXL0
	IsGfipI9AHEI9oDw==
Subject: [PATCH v2 00/14] selftests: vDSO: Stop using libc types for vDSO
 calls
Date: Thu, 13 Nov 2025 16:30:16 +0100
Message-Id: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIj5FWkC/2WNywrCMBBFf6XM2kgmpS9X/od0YdOpHZBEMjG0l
 P67seDK5Tlwz91AKDAJXIoNAiUW9i6DORVg57t7kOIxMxhtKkTUKo3iVSSJKq4vElW3lrRt0Ax
 NB3n1CjTxchRvfeaZJfqwHgcJv/bXwr9WQqWVLocSp7a1ddVdn+zeMXjHy3kk6Pd9/wCpuBlTs
 gAAAA==
X-Change-ID: 20251110-vdso-test-types-68ce0c712b79
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=2631;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TGcKeBkgz11eVd1/eROWlror7QWLtk1vSCzPNBRof8o=;
 b=mT/nrNhuaqXUgo/zCm7isljsxPhrDKHPdsTkWYeRYfhNZRbWtp0cvc3SCUuUGAsq7V354XTGW
 9ifcANAfVK+B7Y7lXioaiIBdnGZvB3pMBVIJaDmYCY8H5FpkxExSHv1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently the vDSO selftests use the time-related types from libc.
This works on glibc by chance today but will break with other libc
implementations or on distributions which switch to 64-bit times
everywhere.

The kernel's UAPI headers provide the proper types to use with the vDSO
(and raw syscalls) but are not necessarily compatible with libc types.
Introduce a new header which makes the UAPI headers compatible with the
libc.

Also contains some related cleanups.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Use __kernel_old_time_t in vdso_time_t.
- Add vdso_syscalls.h.
- Add a test for the time() function.
- Validate return value of syscall(clock_getres) in vdso_test_abi
- Link to v1: https://lore.kernel.org/r/20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de

---
Thomas Weißschuh (14):
      Revert "selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers"
      selftests: vDSO: Introduce vdso_types.h
      selftests: vDSO: Introduce vdso_syscalls.h
      selftests: vDSO: vdso_test_gettimeofday: Remove nolibc checks
      selftests: vDSO: vdso_test_gettimeofday: Use types from vdso_types.h
      selftests: vDSO: vdso_test_abi: Use types from vdso_types.h
      selftests: vDSO: vdso_test_abi: Validate return value of syscall(clock_getres)
      selftests: vDSO: vdso_test_abi: Use system call wrappers from vdso_syscalls.h
      selftests: vDSO: vdso_test_correctness: Drop SYS_getcpu fallbacks
      selftests: vDSO: vdso_test_correctness: Make ts_leq() and tv_leq() more generic
      selftests: vDSO: vdso_test_correctness: Use types from vdso_types.h
      selftests: vDSO: vdso_test_correctness: Use system call wrappers from vdso_syscalls.h
      selftests: vDSO: vdso_test_correctness: Use facilities from parse_vdso.c
      selftests: vDSO: vdso_test_correctness: Add a test for time()

 tools/testing/selftests/vDSO/Makefile              |   6 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |   3 +-
 tools/testing/selftests/vDSO/vdso_syscalls.h       |  93 ++++++++++
 tools/testing/selftests/vDSO/vdso_test_abi.c       |  46 +++--
 .../testing/selftests/vDSO/vdso_test_correctness.c | 190 +++++++++++----------
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   9 +-
 tools/testing/selftests/vDSO/vdso_types.h          |  70 ++++++++
 7 files changed, 285 insertions(+), 132 deletions(-)
---
base-commit: 1b2eb8c1324859864f4aa79dc3cfbb2f7ef5c524
change-id: 20251110-vdso-test-types-68ce0c712b79

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


