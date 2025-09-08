Return-Path: <linux-kselftest+bounces-40994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA39B49BD9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB73AB326
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205132DC32A;
	Mon,  8 Sep 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF7kfvvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4921FF39;
	Mon,  8 Sep 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366873; cv=none; b=I2CdJzrtp7cb74f8Q2PMUDUY05bQ1fNvuUsneo7cBx5DjjfN92vg8bBvFzy9+Z+ER42X6oyDS1m7OTUv3HKXzCih4lU+CzFBUHmAkB5WRmDfeyV+Mz5IINvA90H7j7olSROOMLps4h3tTjAfVyG53oj9W0QK+rOsVzzodMUkobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366873; c=relaxed/simple;
	bh=qfRK48mSlifn6pDY8w/IKVSEqIOAxhjI6tl2ICFaCGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F4xwbpRXvSWR9nFh16pBjYKmEE1k0nxMTolqqEpcILps8RvDYUf3L+iMdroI1JrxXTjRbTboJOZ4Lm8aQxyQ8D+pqhLiIKmPtBk9vP/fOGKyph369fVSP2T75WHpch3jmt5gLPIAxis369SX8NXb2H6WvM7C5sko0lRSz3ClVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF7kfvvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404A5C4CEF1;
	Mon,  8 Sep 2025 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366872;
	bh=qfRK48mSlifn6pDY8w/IKVSEqIOAxhjI6tl2ICFaCGA=;
	h=From:Subject:Date:To:Cc:From;
	b=jF7kfvvrhNiLaTSaxlM7ex0NV6i0IciSnTU/uciel6N5pozuxrJ5BlVCjc5wk4vkV
	 j9F/bwIym88rTm5fx4u1sSJMYX4yPCxp16uOv13vVZiDrf041YckBOi5qkW412i6FB
	 qsVK+KwcfQUO1WP9P+igNX41Uqgk7NZqQXUUy8uuH13KrxGEiWVt9R7fWetxc84Xp4
	 8klkUsHsdoEhqNV7LocT7kTRww2erMQ/rgEaWMGdVz6jJqBGPh7xW4mAF1dQIHSrPB
	 C/iNbChL8mr+tO/7h7Vz/Mdw0B20rEedwHC1NEzYy3ZB+C2qRkPwMquGAU9DxKOmMa
	 fTXvHGAOyyKDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: misc fixes for v6.17-rc6
Date: Mon, 08 Sep 2025 23:27:26 +0200
Message-Id: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5Kv2gC/x2MQQqDQAwAvyI5NxCFrNqvlB7smm1zcF02IoL49
 waPAzNzgklVMXg2J1TZ1XTNDu2jgfib8ldQZ2foqGMaacAsGy5liwUXtYhJDzEM2PZYI2PPTIn
 TSJ8QwB+lym344gWewvu6/u89mlh0AAAA
X-Change-ID: 20250908-net-mptcp-misc-fixes-6-17-rc5-7550f5f90b66
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qfRK48mSlifn6pDY8w/IKVSEqIOAxhjI6tl2ICFaCGA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2ewVU84tvmD1x1qXl/q4BEUdTsnySTjj2i17kTvsll
 3k9Oi63o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJqbQz/dFO5mOd4aAn/aHjy
 xWDREe317mbRxZpvlLesbLROSg/8z8iw/aBClf6LjDmuPTyF1eHrP995V2jZU7HyaY7WwdsXqjc
 wAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: Fix a wrong attribute type in the MPTCP Netlink specs. A fix
  for v6.7.

- Patch 2: Avoid mentioning a deprecated MPTCP sysctl knob in the doc. A
  fix for v6.15.

- Patch 3: Handle new warnings from ShellCheck v0.11.0. This prevents
  some warnings reported by some CIs. If it is not a good material for
  'net', please drop it and I can resend it later, targeting 'net-next'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: fix if-idx attribute type
      doc: mptcp: net.mptcp.pm_type is deprecated
      selftests: mptcp: shellcheck: support v0.11.0

 Documentation/netlink/specs/mptcp_pm.yaml          | 2 +-
 Documentation/networking/mptcp.rst                 | 8 ++++----
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 9 files changed, 14 insertions(+), 13 deletions(-)
---
base-commit: e2a10daba84968f6b5777d150985fd7d6abc9c84
change-id: 20250908-net-mptcp-misc-fixes-6-17-rc5-7550f5f90b66

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


