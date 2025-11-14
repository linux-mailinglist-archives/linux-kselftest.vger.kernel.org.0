Return-Path: <linux-kselftest+bounces-45663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE8C5ED12
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E9AD3555DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7872D9EC2;
	Fri, 14 Nov 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKHRBPmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093042D7DF7;
	Fri, 14 Nov 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143944; cv=none; b=qerZsf3bN4AHgnPEGlQG6IW1jrIeVbM43LD4PMVDkf6Km0w+ndN26rSPBFp7C7Y8a94Mdjqy1TKP7NatjDHRjuNXAtldMLLa5fsnYuQoNgmEI9MWkE7WAe/3gFZxuFcTVbJIi5CHCOvi+erkqCfhKkBNdjvLht2pRjhVSg6C6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143944; c=relaxed/simple;
	bh=HWdx5m4w/63GW+c5noK6/roJoo1MeRKB7OF1YuTwqgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PRfQMxlh9hghWr6ULJ6tyOVNS1SOqcjObW+/tw6o6Jrk4tliNUhK9IdiGlGMDHPJbHR1n1Ht/BnYR3idFJkSZR3UGWCVRMvQcHDDrOejG9Kplu15v4k4Wla8vR/Okcva8U2qlsPwvcvY/jHxZkYNR1PeWiPRVFvqtrouu/G/MfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKHRBPmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4400BC4CEF8;
	Fri, 14 Nov 2025 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143943;
	bh=HWdx5m4w/63GW+c5noK6/roJoo1MeRKB7OF1YuTwqgw=;
	h=From:Subject:Date:To:Cc:From;
	b=SKHRBPmr3bytK3dZ/umdfjG7DJ4IVzFg5DVgjksI0FM4X/xt7u7TbskZhcYJY25E5
	 Rxp4jnG0Pu6TBssuF8VyycSPJJ0HEVp6mVrs2VB39T8iqD/4OYyFrDH2I1LUJAfy5k
	 Umju4N8vP508QR0apLOLJwUocxafGzHH3T8FUy68xe7/rGRFaCTmX5uZLFv9dW0M0Z
	 Dx4LdN46cwulLJEgIEWaE8VWmQ9+4db9Go/i6+ncBQrSk8PxB/t6u7k93zIHU3fH3q
	 HvukNi+XXDG9cEdvS+Vb9NGapWG2uV9c61aViagca+JZIuKzArwyNtumvSUzfXA8nf
	 ne8JIt3hW4m/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] selftests: mptcp: counter cache & stats
 before timeout
Date: Fri, 14 Nov 2025 19:12:04 +0100
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRwF2kC/zWNQQrCMBBFr1Jm7YAJUdSriIsxndhZNAmZaSmU3
 t0guPgP3ub9HZSbsMJj2KHxKiold3GnAeJE+cMoY3fwZ39xzgXMbH2b4VwtVtRkGMuSOylOjGp
 kiiYzl8UwEV1DuPnxfffQk7Vxku1394R/CV7H8QWV0187iAAAAA==
X-Change-ID: 20251114-net-next-mptcp-sft-count-cache-stats-timeout-faa64482db92
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HWdx5m4w/63GW+c5noK6/roJoo1MeRKB7OF1YuTwqgw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC34a/Q3PVPdoOK8V484Y8b5l9/tDf78s3Nh+UmmSz
 9Qrk0M6O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy3YmRYY3Bkn6+XVMTpNJ5
 V3z4H7pt6xovvs67b6V+JE5gqOVtj2dkWLjyr/OP+e3ddzw9H0ZkG2WtmDftssjFrdtnJ00pKH5
 UyA4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a bunch of small improvements to the MPTCP selftests:

- Patch 1: move code to mptcp_lib.sh to prepare the new features.

- Patch 2: simplify mptcp_lib_pr_err_stats helper use.

- Patch 3: remove unused last column from nstat output.

- Patch 4: improve stats dump in mptcp_join.sh.

- Patch 5: get counters from nstat history and simplify mptcp_connect.sh.

- Patch 6: avoid taking the same packet trace twice.

- Patch 7: wait for an event instead of a fix time.

- Patch 8: instead of using 'timeout' and print the stats after, another
  internal timeout is used: if it fires, it will print stats, then stop
  everything. This avoids confusions around stats in case of timeout.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (8):
      selftests: mptcp: lib: introduce 'nstat_{init,get}'
      selftests: mptcp: lib: remove stats files args
      selftests: mptcp: lib: stats: remove nstat rate columns
      selftests: mptcp: join: dump stats from history
      selftests: mptcp: lib: get counters from nstat history
      selftests: mptcp: connect: avoid double packet traces
      selftests: mptcp: wait for port instead of sleep
      selftests: mptcp: get stats just before timing out

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 140 ++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  65 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  58 +++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  43 ++++---
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  44 ++++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   3 +-
 6 files changed, 203 insertions(+), 150 deletions(-)
---
base-commit: df58ee7d8faf353ebf5d4703c35fcf3e578e9b1b
change-id: 20251114-net-next-mptcp-sft-count-cache-stats-timeout-faa64482db92

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


