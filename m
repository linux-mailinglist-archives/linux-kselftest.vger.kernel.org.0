Return-Path: <linux-kselftest+bounces-5565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E8D86BDAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314A21C242C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2153770D;
	Thu, 29 Feb 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/7d43uu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01570381A4;
	Thu, 29 Feb 2024 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168368; cv=none; b=W/oFj4jxL8CoJSpKKuJkbpe8IDFQ1vPaJuy7wuJeYo88gI4z+WBxCJsG0K7zQfrNlBNuvQ4GFbas7mpnSE9exSDxdGYcmmGKwZnUq7k2WSJ6xdenznvotsZ2TNkby2OmtYswbdx0TM30uRB64/BtQ62lBV2QKDfBek6tphIp+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168368; c=relaxed/simple;
	bh=Q+QGIJvuOU6QgFJ3hAFW23j2UTp1o7jtrsjPxMADnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dEoj329HTWQnfIQ9yXqTD0JMimxb8OkuaDT0AvXRkSUq9mGzw9LFdAvPE6l8ICcsyCwyZPO973FJuXP/h8XwCjtVsRZ+6tJTusLzHF3UHU2ClG5tx+ft2oJQjdaJXiOV5EoRkkjaRzwgJzeCN65DxBT9ODU8qFTCnBnwAHXbfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/7d43uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A0C433C7;
	Thu, 29 Feb 2024 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168367;
	bh=Q+QGIJvuOU6QgFJ3hAFW23j2UTp1o7jtrsjPxMADnEs=;
	h=From:To:Cc:Subject:Date:From;
	b=I/7d43uuLJncrhm4hIZCiqs6DLj0hpuz3DZcLNKr/Nqvp11CODCg8EqsMauyBydqd
	 5fZ0XHJ1+2snR8z1UgrsjQEt06BIcefu0Hwm/iI9jyfdoPxZZw6WlY0jLBZZZYf3QG
	 BN2rEpJJ/hzqEACwWjqGdJyTm3yDFBF1q5agkOHW0IkU7aI+6BwRZibA7t7uU7KzR+
	 rNFydd11O1wNmQnT7n3Xu5SrycXEV5/wKKCildM5VtV/2tFf/XqfAfpL2wyDurlNl/
	 UVFhmJLPLkjTB2Sdt5iNsuNDFLK0wF8G6Bd6VE4jC7MvFYl2qykZ7x/eXjGMsf6tUS
	 ttvdlt52bK8CQ==
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
Subject: [PATCH v4 00/12] selftests: kselftest_harness: support using xfail
Date: Wed, 28 Feb 2024 16:59:07 -0800
Message-ID: <20240229005920.2407409-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

When running selftests for our subsystem in our CI we'd like all
tests to pass. Currently some tests use SKIP for cases they
expect to fail, because the kselftest_harness limits the return
codes to pass/fail/skip. XFAIL which would be a great match
here cannot be used.

Remove the no_print handling and use vfork() to run the test in
a different process than the setup. This way we don't need to
pass "failing step" via the exit code. Further clean up the exit
codes so that we can use all KSFT_* values. Rewrite the result
printing to make handling XFAIL/XPASS easier. Support tests
declaring combinations of fixture + variant they expect to fail.


Merge plan is to put it on top of -rc6 and merge into net-next.
That way others should be able to pull the patches without
any networking changes.

v4:
 - rebase on top of Mickael's vfork() changes
v3: https://lore.kernel.org/all/20240220192235.2953484-1-kuba@kernel.org/
 - combine multiple series
 - change to "list of expected failures" rather than SKIP()-like handling
v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
 - fix alignment
follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@kernel.org/
v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/

Jakub Kicinski (10):
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

Mickaël Salaün (2):
  selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
  selftests/harness: Merge TEST_F_FORK() into TEST_F()

 tools/testing/selftests/kselftest.h           |  45 +++++
 tools/testing/selftests/kselftest_harness.h   | 182 +++++++++++-------
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  58 +-----
 tools/testing/selftests/landlock/fs_test.c    |   4 +-
 tools/testing/selftests/landlock/net_test.c   |   4 +-
 .../testing/selftests/landlock/ptrace_test.c  |   7 +-
 .../selftests/net/ip_local_port_range.c       |   6 +-
 tools/testing/selftests/net/tls.c             |   2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |   9 +-
 10 files changed, 178 insertions(+), 141 deletions(-)

-- 
2.43.2


