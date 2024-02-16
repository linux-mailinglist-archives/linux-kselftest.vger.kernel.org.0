Return-Path: <linux-kselftest+bounces-4827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4978572A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DD21F24791
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB6BA50;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EENlP9q9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EC803;
	Fri, 16 Feb 2024 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044089; cv=none; b=ZvxDisEQt48Ol7jlph4JaOsDNu8I7RaLtNEShUaeXs6SYi+ry02Sg4R7+vr8P+WtxGw5QuA9J+Cqb2JusKmEvLXfL9t35t6cGcYDb7b0fFNB6wJ6+1VXpdVjEC5jKn4INcMeL2Y4N30Rkqbr3R134iToG4tpzsVkI8Yae3YNFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044089; c=relaxed/simple;
	bh=fpHIseZvtLsJiftPTyOsid6xMum/McIiK/zF+aacUGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kuoc8Ln4an89QMozQFikzlVFpCL6Y7nwUwFmwhgQa1c4ikrzPjPk5aSyJgS7jGdVfTBIryyncC4T+9YmEmrWyyjzfulww2JJ5dGvA1GGkEKBGOCs3kanzBJ4SX4R0N1RMeZ7bZhjR/MX6TE9Mbtq2HIg0o0HGBe/htiz0ZeC1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EENlP9q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2929BC433C7;
	Fri, 16 Feb 2024 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044088;
	bh=fpHIseZvtLsJiftPTyOsid6xMum/McIiK/zF+aacUGU=;
	h=From:To:Cc:Subject:Date:From;
	b=EENlP9q9w1AVKzjvOrb4j/J9Y1mCYFeh7uRh4bgOP1KS5RIOI7Pn95Mn89HPUZpRq
	 dQKp4CIehb5WCue43j7TCxy5sSK7+oJ2GXZeBxfVGdkL27F52txM06m17JfhkpbERt
	 8DqQtoTkEeG9DgmvNs+v4gYBN3/QEl5NxLevvI/6mfeJeI/1toLNoDYoSMH6UuGoWc
	 7rolHgXmhmHSha/7YkTvLMq21+NvfN6wgBibaDExrTsSZTReVBuVJN4tsKm7Dhq39d
	 uM14i2jug5Wcf+KJhV+/Zw7QNidAkRf7/bTgdN+ybFuFMeFJR0bBfphvuAw6l//r7P
	 2Kyeg8uUkHkrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 0/7] selftests: kselftest_harness: use common result printing helper
Date: Thu, 15 Feb 2024 16:41:15 -0800
Message-ID: <20240216004122.2004689-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common result printing helper and always include test name
in the result line. Previously when SKIP or XPASS would happen
we printed:

  ok 1 # SKIP unknown

without the test name. Now we'll print:

  ok 1 global.no_pad # SKIP unknown

This appears to be more inline with:
https://docs.kernel.org/dev-tools/ktap.html
and makes parsing results easier.

First 3 patches rearrange kselftest_harness to use exit code
as an enum rather than separate passed/skip/xfail members.

Rest of the series builds a ksft_test_result_code() helper.

This series is on top of:
https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/

Jakub Kicinski (7):
  selftests: kselftest_harness: generate test name once
  selftests: kselftest_harness: save full exit code in metadata
  selftests: kselftest_harness: use exit code to store skip and xfail
  selftests: kselftest: add ksft_test_result_code(), handling all exit
    codes
  selftests: kselftest_harness: print test name for SKIP and XFAIL
  selftests: kselftest_harness: let ksft_test_result_code() handle line
    termination
  selftests: kselftest_harness: let PASS / FAIL provide diagnostic

 tools/testing/selftests/kselftest.h         | 45 ++++++++++
 tools/testing/selftests/kselftest_harness.h | 96 ++++++++++-----------
 tools/testing/selftests/net/tls.c           |  2 +-
 3 files changed, 91 insertions(+), 52 deletions(-)

-- 
2.43.0


