Return-Path: <linux-kselftest+bounces-4558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E018534F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3361F2BEAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52385EE72;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9YJYLiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8054FB9;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839059; cv=none; b=WYqrRivqPdTZcrNbBaifiWdtyQz2nfRVUk0o8ucb8LgtbHv+zViOvYRFOko4k6zjrAVi5B4dVOoitpz6TSeqUNexnT1dO6qWL0x+O1Yni0p6BmZ4HLIirNgPTBH9qfIOBQ+XGPNP0cALoBVGCjTv8yPRsaYDTgevbz3E8jKdAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839059; c=relaxed/simple;
	bh=RzEpH/jf0l0piBmT6CfbQn9VpIQHPHfqdyyais21eJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLlrn/Fsn1keC9kNbMK0957pGSlJbM+1EcETkuZ0ZBK49yiCrjsN5/pLMckcxQJ7OBzQGQbQozCr747jTvu81m1D2b6fL32E7unw/czOPQCXC2rIW6uy04ar8eDxBFSkm3MrkXT/Kar5T3Rza2aJudpOGXRDJCQbBi3L3oSVw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9YJYLiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E95C43390;
	Tue, 13 Feb 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839059;
	bh=RzEpH/jf0l0piBmT6CfbQn9VpIQHPHfqdyyais21eJc=;
	h=From:To:Cc:Subject:Date:From;
	b=r9YJYLiJCH5LgxtPPp7F8vVzeUVQazTL/Q0AMcIjFB95+I97T+NUv0uNzMPa7blB0
	 4nHzeIX7acuYEVLcw2lmO13j9cRM/Ej3nOJyf/GWtIStXrtD5t/NhHETqmDo+4zbuW
	 gcbtFFxKNhRsj57ZuntWaXjDSKY092LPICkuVBdky4/5ysdxf/Hg3K45qEZP435lFE
	 +Jq8J2morILfQ1Y/uP0hnYHwYN3uUYGU+Ct+Xi64AJyCio8nQGLQZ7U1V98ZGOy67U
	 jZx3jV1LjMwygbRBwz2G2v1inAp3HS0VN0G7MbNyWl7s0Vgkr/UlXW24FkJXHyGwtO
	 UqqFal6K+K3Kg==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: kselftest_harness: support using xfail
Date: Tue, 13 Feb 2024 07:44:12 -0800
Message-ID: <20240213154416.422739-1-kuba@kernel.org>
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

To avoid conflicts and get the functionality into the networking
tree ASAP I'd like to put the patches on shared branch so that
both linux-kselftest and net-next can pull it in. Shuah, please
LMK if that'd work for you, and if so which -rc should I base
the branch on. Or is merging directly into net-next okay?

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


