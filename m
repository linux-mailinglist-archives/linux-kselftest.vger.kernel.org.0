Return-Path: <linux-kselftest+bounces-5059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF785C493
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6091F2520C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7D14A4E1;
	Tue, 20 Feb 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZXs+8u+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C2135416;
	Tue, 20 Feb 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456966; cv=none; b=A+pDUdRp42haKxL3DzGAPm03cxa7PCSOiGEJB5cPcsuxFUfmqS6sZHJVRF+aABsTE/lJu9+JGzc8QSPMsRb3yjoujh4qO+nkIIjaT7ut84renEvJJAKtMoXluN+1zcdv32uL2d5nE7dMemDsdJ9KH3utkxh9qkXKSnH9bTZdBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456966; c=relaxed/simple;
	bh=wh/nlauG0iN+G9d488n4DAzbLn6xokWSEnPNBO7vUWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe2/lGmcasEYK/Exwwe0MTRW5Q55VEoo36yosW0X1p4W2ri0rYvKNqM/Vl7mSLufrvawpI6PKgGvkvwJUwrwtopX2nltqJG6MLMR+U6odg44KtJQR5wggeV4JdOPCpi8+y0csvXpJ+cNmKb+ZFaZL70PubZDiLIfb6VdSYI86H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZXs+8u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DBFC433C7;
	Tue, 20 Feb 2024 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456966;
	bh=wh/nlauG0iN+G9d488n4DAzbLn6xokWSEnPNBO7vUWE=;
	h=From:To:Cc:Subject:Date:From;
	b=JZXs+8u+8B3NMyY6QBjKxCs8YocJ9H/m+g2+wKY/uO/+fx1ZFxqTbaEuNk21TuCw0
	 hbS9rjy2l/uinU3xO4eMzj0pTszCrxX+p9BJ7goYI+0ruCiuvrTeQsw8TsMHYvQeDv
	 gIe1AqMxV/i+LbHBUIKryYP5aRSI8zhogg27BbMWRDneWp7GtS1biLwWO2vHSf2y88
	 q0RKhXm5apRDh/F9RdVk+a+7ZX7/qk32rGVMDbmUDlimcqiskPYkWN7ymlhIaBjOgo
	 nIEMN982E65R9f1inbvfU1FRJMhiKYlRw/qZhKvcUcwaWcYUPn+CfuYafvG6jBPROC
	 ZJleBrKkUdoMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/11] selftests: kselftest_harness: support using xfail
Date: Tue, 20 Feb 2024 11:22:24 -0800
Message-ID: <20240220192235.2953484-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

When running selftests for our subsystem in our CI we'd like all
tests to pass. Currently some tests use SKIP for cases they
expect to fail, because the kselftest_harness limits the return
codes to pass/fail/skip.

Clean up and support the use of the full range of ksft exit codes
under kselftest_harness.

Merge plan is to put it on top of -rc4 and merge into net-next.
That way others should be able to pull the patches without
any networking changes.

v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
 - fix alignment
follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@kernel.org/
v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/

Jakub Kicinski (11):
  selftests: kselftest_harness: pass step via shared memory
  selftests: kselftest_harness: use KSFT_* exit codes
  selftests: kselftest_harness: generate test name once
  selftests: kselftest_harness: save full exit code in metadata
  selftests: kselftest_harness: use exit code to store skip
  selftests: kselftest: add ksft_test_result_code(), handling all exit
    codes
  selftests: kselftest_harness: print test name for SKIP
  selftests: kselftest_harness: separate diagnostic message with # in
    ksft_test_result_code()
  selftests: kselftest_harness: let PASS / FAIL provide diagnostic
  selftests: kselftest_harness: support using xfail
  selftests: ip_local_port_range: use XFAIL instead of SKIP

 tools/testing/selftests/kselftest.h           |  45 ++++++
 tools/testing/selftests/kselftest_harness.h   | 148 ++++++++++++------
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  22 +--
 tools/testing/selftests/landlock/fs_test.c    |   4 +-
 tools/testing/selftests/landlock/net_test.c   |   4 +-
 .../testing/selftests/landlock/ptrace_test.c  |   7 +-
 .../selftests/net/ip_local_port_range.c       |   6 +-
 tools/testing/selftests/net/tls.c             |   2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |   9 +-
 10 files changed, 168 insertions(+), 81 deletions(-)

-- 
2.43.0


