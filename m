Return-Path: <linux-kselftest+bounces-4822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC31857281
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D921C2290C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648E149E0B;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6U7KATI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AE7460;
	Fri, 16 Feb 2024 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043187; cv=none; b=RnP5fbSHM4vEYPE5WiWgAgQ32ofQq/I9SgXTBcI9uSg+2RGCRqTYlm+Z8It1Bf8HB5Yki/poPGFxiJCaN0UT/p/hNHIRh8zbyMfDFC9Ht7q6gI5jvP7D9depfUzDqgVsMSHEtYMmy8GiTZkZlaf1xecKcDkBNuvN/BPFgJP7/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043187; c=relaxed/simple;
	bh=NUPAGYzH1Kbh+8gZ+V94KstVi6/jPcsu0H2/Ou1kVXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6Ldo/4EAhFlg+j1w5BV7D3O7/3Tn1Xsv5+4n42ahL06JIFTcHDWGsgg0NAtTGsfZsy/bNC/lLYsS5WFyEL7vKcIte28lNk187VFDDYFCHKPjlhoEZFE9/oeJ5owhSjmuRJJTXq5o+MIXm3YNQt3bAIkpK9mrKnMfVImsqoqu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6U7KATI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D079C433C7;
	Fri, 16 Feb 2024 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708043186;
	bh=NUPAGYzH1Kbh+8gZ+V94KstVi6/jPcsu0H2/Ou1kVXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=t6U7KATIBvy/DYMH82y4EHFi0SDj1+ahwiy5Mh4kJL9eBOBLbOGtGRz5z2o8bWQJQ
	 FcdkuAtkQa9KPrhsJ0S91hqWhABtzx9aPBgMBXS1po3ej4sgn1uhW1f6EMgxlcMBuK
	 to93T9p5iJgwar9jOoYEZ/GH+7vOpjiA0GTIsa5tr0Yemwk/7DQS53d+wF5Vy3Utfp
	 v4amhbsJ0ezvxRzXcJNR0mlTk5+SXMxguo9LRyVWWMKrvnS0XposgMB45RXJmn1a63
	 ngLNOpzo+Mxhaa5L5QULrrDUREJALzXHrQh7RTQLMaNhOSYoXN2CAblq/LauO4yYdJ
	 Bb/8CWXdpLu/A==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] selftests: kselftest_harness: support using xfail
Date: Thu, 15 Feb 2024 16:26:15 -0800
Message-ID: <20240216002619.1999225-1-kuba@kernel.org>
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

v2:
 - fix alignment
v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/

Jakub Kicinski (4):
  selftests: kselftest_harness: pass step via shared memory
  selftests: kselftest_harness: use KSFT_* exit codes
  selftests: kselftest_harness: support using xfail
  selftests: ip_local_port_range: use XFAIL instead of SKIP

 tools/testing/selftests/kselftest_harness.h   | 67 ++++++++++++++-----
 .../selftests/net/ip_local_port_range.c       |  2 +-
 2 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.43.0


