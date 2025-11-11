Return-Path: <linux-kselftest+bounces-45295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F589C4D314
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095AE189EF2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD95354701;
	Tue, 11 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4m/a/NG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inbNfnrT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631983546EC;
	Tue, 11 Nov 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858202; cv=none; b=eYpy+TBEkpJZGqYtDy22BrB1cS8eJ9Vep0yPqb9RMfFyn+O8UhcQ+iq7wcp1VF9BTdkeAQhJyAWoPlBj6JK1IHUyJpDuTBcwkl2KsZ5jr6XhU9hAQyp4KScD4/lTw3Pj8SV+Q62UqskSkuvnJBvyHlqgmQxb+txcrKpHvMIEZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858202; c=relaxed/simple;
	bh=pYb7vxhtfM5ubqs7Kk23tw+dzy6sb8BnNmtiWjJhBaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HsQDJnRw9o8MxzRbTjICxOOwrnErVIT2/L7DYRmYDAxrK84jIZtXXaUbNn2TxDgdVF2zCxSvOcFRDqzscg17KwZKruLcfzO7oq80TSSO/AWeXI9yoa2DMgziKC7fM3WvyQvt4INx1ntjLRVeootubRwn6YRQPap2yMQuDIeWnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4m/a/NG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inbNfnrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YP7FhE4la1Gi/u9709bHCz0zBQznM30ilDaWjSYpWL0=;
	b=m4m/a/NGrfd1WYD8oBqUwxW+brQzaiKgpaIakJoXwhE+Un1YlYWoPTgMq/E1io66zf1RuU
	XciQVBVs0TPaQAENigMH6HLmdR/uhdhDUL9vmoIA5HmM/P7sSe35sRcBxNEBtjEceJKPgX
	h4LqH2mqMoBZJaeDWneEJcJtMXUHDu4Wql9tv2a//7JRlVEYKjYoMjtpM+I30PQb48B4u7
	miuGw4VdAp+E60+gE/6e9sfwdT+f+GCVHgwYWvtFn43t/mwtHq1/f8zPt1hf9H3ESPnaxf
	DnAEV29/4MbNIE9GQxgcsHjk2y3FtWk/eW30Njca9Aba8Xb5p5CHrLvPNClYfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YP7FhE4la1Gi/u9709bHCz0zBQznM30ilDaWjSYpWL0=;
	b=inbNfnrTEPB1eoYyXZf/4MNrClSCzv/MuEqJUGTpBHs2lwFzF3ggsWLx++xlI2hpvW1NMQ
	1EkyWCdhlcGgFBAQ==
Subject: [PATCH 00/10] selftests: vDSO: Stop using libc types for vDSO
 calls
Date: Tue, 11 Nov 2025 11:49:46 +0100
Message-Id: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMoUE2kC/x3MQQ5AMBBA0avIrE3SaUJxFbGgBrNBOo0Q6d01l
 m/x/wvKQVihK14IfInKsWdQWYDfxn1llDkbrLEVERm8Zj0wskaMz8mKdePZeEd2ci3k6gy8yP0
 f+yGlD0o2oEJhAAAA
X-Change-ID: 20251110-vdso-test-types-68ce0c712b79
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=1970;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pYb7vxhtfM5ubqs7Kk23tw+dzy6sb8BnNmtiWjJhBaU=;
 b=BOaKHqLlljoh4h3uJLCrGUJHXYE3Fxyx6BycI5YgBLuanRhLVBZJHq0xCxUEamJOP5RsIYQY0
 flhKgOurLQcBHF1NBFCJr5daN1wOHLvFQY1xtbVDgkPmoDAzwTyhuhD
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
Thomas Weißschuh (10):
      Revert "selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers"
      selftests: vDSO: Introduce vdso_types.h
      selftests: vDSO: vdso_test_abi: Use types from vdso_types.h
      selftests: vDSO: vdso_test_abi: Provide compatibility with 32-bit musl
      selftests: vDSO: vdso_test_gettimeofday: Remove nolibc checks
      selftests: vDSO: vdso_test_gettimeofday: Use types from vdso_types.h
      selftests: vDSO: vdso_test_correctness: Drop SYS_getcpu fallbacks
      selftests: vDSO: vdso_test_correctness: Use types from vdso_types.h
      selftests: vDSO: vdso_test_correctness: Provide compatibility with 32-bit musl
      selftests: vDSO: vdso_test_correctness: Use facilities from parse_vdso.c

 tools/testing/selftests/vDSO/Makefile              |  6 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |  3 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c       | 35 ++++-----
 .../testing/selftests/vDSO/vdso_test_correctness.c | 85 +++++++++-------------
 .../selftests/vDSO/vdso_test_gettimeofday.c        |  9 +--
 tools/testing/selftests/vDSO/vdso_types.h          | 70 ++++++++++++++++++
 6 files changed, 121 insertions(+), 87 deletions(-)
---
base-commit: 8c6abf7bda867b82f8a6d60a0d5ce9cb1da6c433
change-id: 20251110-vdso-test-types-68ce0c712b79

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


