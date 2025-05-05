Return-Path: <linux-kselftest+bounces-32368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C15AA971A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C518907BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770525C826;
	Mon,  5 May 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKxUygPD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMRlgZSS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643024204E;
	Mon,  5 May 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458175; cv=none; b=QGU09mo0Y0s2EUW1khFlaf/DWbICll58058t2sIyHnh4Ff2CC24AKW2+MLOs+6WAPnCT6HjLqrtpU9mZle4iWGm216b89hQvpKvxTchDp91PtbTJGXOJRl8OqzYqVlW5kuqD5H7Tcs27hnIlm84dgUiUnnQmby/LfHqHi8tAMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458175; c=relaxed/simple;
	bh=Mfsyo2fSDCNmEv9ZhVx16pPueonzCvDgyr5p8l92RKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FAaJYI7no7RBX0LI+8/FC1KSg7iz2eMH3Mn5aKnwWpgCjmeFXtRp4o84zjbSVLLGR+knegutlXnsnFdwkx35HCNg9i35MZbTuFXo/K4Fmig+ynMIMJjuPhr9Y1X5QMVPCVWZbsjC5VRU5JxI4Jmm1liGVEvpQnxxZC1/nZ+J+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKxUygPD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMRlgZSS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rhKbZviyh0DAUxpnNqUgMkCDm0UvTfhEoezn0+KkcyE=;
	b=PKxUygPDerNLepPVwNJawPuRl2VPnsk9ov8WwvISJETw006A+eVn6/jD1hkmM8M/1QMCOB
	Tr0dI5a1+XjWeR3WgnC3F5NWd/x/9F1basFi4S5d6YQ4q0tOYmNg1UgDT8P72liveRLhvm
	01lqEUk0yVbfUQ4joePBapmiqyLIlaIVD9YPICSzWQGmq8c9UbU1T/R9wEZo3ztgtXnDNj
	J/Uh6qtoJ5AP0UhuDfS2WYACCaHlR6PJzA8dADHC0k+R8f0eM6vS4uy4hduXoOvx2z4jEM
	njo8Dk6WXjNH61wBs6U4W+H9ibUc5Kkxg5jeceLfLPHt8Rb8Ehd+FCf//XHReA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rhKbZviyh0DAUxpnNqUgMkCDm0UvTfhEoezn0+KkcyE=;
	b=RMRlgZSSHVtl8grGxghGuzPgzBlX+YKuDlE9tKqqaj15ov7fxpiZ6OUbnSAvEKe1bID+7E
	aMR6fceC2yNgjuAQ==
Subject: [PATCH v4 00/14] kselftest harness and nolibc compatibility
Date: Mon, 05 May 2025 17:15:18 +0200
Message-Id: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAfWGGgC/4XPwU7DMAwG4FeZciYosdM15cR7oB3SxKEWVTolp
 Rqa+u6k5QCaYBx/S/5++yoKZaYing5XkWnhwlOqwTwchB9ceiXJoWYBChqlUck0jdx7+VZojDO
 VWQ4uJypF2h689c4b7KOo6+dMkS87/XKqeeAyT/ljb1r0Nv1CQePf6KKlkkhkj8a0faPi88jpf
 c5T4stjoK1nR1CZfxAXvGt9ANQEN8h23QLfFxnV3sGgYtFaDbE9UofqNwx/YFrfwbBiJnReQdf
 YDm/fO63r+gllOEHQowEAAA==
X-Change-ID: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=3781;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Mfsyo2fSDCNmEv9ZhVx16pPueonzCvDgyr5p8l92RKo=;
 b=AXsv6aUsN4ncuUf6sHOJJ49+hKnIzDsVmDkMsD8F+48DPHJ7yjAJKEZfXpPd/DdYOyU8hMs1y
 IPEFZ38LViqCTsnV5GUDWu8nioVgWm6c5hEH77d1TR15FddWH+KKYih
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc is useful for selftests as the test programs can be very small,
and compiled with just a kernel crosscompiler, without userspace support.
Currently nolibc is only usable with kselftest.h, not the more
convenient to use kselftest_harness.h
This series provides this compatibility by removing the usage of problematic
libc features from the harness.

Based on nolibc/for-next.
The series is meant to be merged through the nolibc tree.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v4:
- Drop patches for nolibc which where already applied
- Preserve signatures of test functions for tests making assumptions about them
  drop 'selftests: harness: Always provide "self" and "variant"'
  add 'selftests: harness: Add "variant" and "self" to test metadata'
  adapt 'selftests: harness: Stop using setjmp()/longjmp()'
- Validate test function signatures in harness selftest
- Link to v3: https://lore.kernel.org/r/20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de

Changes in v3:
- Send patches to correct kselftest harness maintainers
- Move harness selftest to dedicated directory
- Add harness selftest to MAINTAINERS
- Integrate harness selftest cleanup with the selftest framework
- Consistently use "kselftest harness" in commit messages
- Properly propagate kselftest harness failure
- Link to v2: https://lore.kernel.org/r/20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de

Changes in v2:
- Rebase unto v6.15-rc1
- Rename internal nolibc symbols
- Handle edge case of waitpid(INT_MIN) == ESRCH
- Fix arm configurations for final testing patch
- Clean up global getopt.h variable declarations
- Add Acks from Willy
- Link to v1: https://lore.kernel.org/r/20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de

---
Thomas Weißschuh (14):
      selftests: harness: Add kselftest harness selftest
      selftests: harness: Use C89 comment style
      selftests: harness: Ignore unused variant argument warning
      selftests: harness: Mark functions without prototypes static
      selftests: harness: Remove inline qualifier for wrappers
      selftests: harness: Remove dependency on libatomic
      selftests: harness: Implement test timeouts through pidfd
      selftests: harness: Don't set setup_completed for fixtureless tests
      selftests: harness: Move teardown conditional into test metadata
      selftests: harness: Add teardown callback to test metadata
      selftests: harness: Add "variant" and "self" to test metadata
      selftests: harness: Stop using setjmp()/longjmp()
      selftests: harness: Guard includes on nolibc
      HACK: selftests/nolibc: demonstrate usage of the kselftest harness

 MAINTAINERS                                        |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kselftest_harness.h        |  175 +-
 .../testing/selftests/kselftest_harness/.gitignore |    2 +
 tools/testing/selftests/kselftest_harness/Makefile |    7 +
 .../selftests/kselftest_harness/harness-selftest.c |  138 ++
 .../kselftest_harness/harness-selftest.expected    |   64 +
 .../kselftest_harness/harness-selftest.sh          |   13 +
 tools/testing/selftests/nolibc/Makefile            |   15 +-
 tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
 tools/testing/selftests/nolibc/nolibc-test.c       | 1715 +-------------------
 tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
 12 files changed, 313 insertions(+), 1821 deletions(-)
---
base-commit: 2051d3b830c0889ae55e37e9e8ff0d43a4acd482
change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


