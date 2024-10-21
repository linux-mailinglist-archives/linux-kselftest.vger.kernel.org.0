Return-Path: <linux-kselftest+bounces-20250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979FA9A62BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BB41F21AC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0E1E572F;
	Mon, 21 Oct 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6ZJ9QGO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD31E3784;
	Mon, 21 Oct 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506335; cv=none; b=FwluOKsYY6WXzcINPM2fWfucKhEOK4+dCOkEyjkTLYgqsKZCB+2CZvS1GBFta6iX83zM5vN+UjvlW+bfyKZzhFk08YP+UnfNae9N1JYLDfAUFQbiZ2RSbRe5kgrGEVeVWm6Lf9qzD+vAtRA9AB4zeIbrtclA9QkxgEf6WBGbJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506335; c=relaxed/simple;
	bh=uIgLSqziQCeKnnjs3M6A6U9bobYsrf6xTUo8tXLjk/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DyKlBWal7Y+bKJFPcO60Qsx3kWegbyVXjDpXEEIL+Rwe5kXmqo0QWdyTsYjwYl3qQqM9Ntt1gPQ8VBe3Qf2vuo4VXnVphBNSLOMBxKF/wtKR4nxUCquqamIOskGPaImuWUxTRBaQGoV4Db1S3MwlMbISRpUKyHgVH39BFNwq0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6ZJ9QGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EB9C4CEC3;
	Mon, 21 Oct 2024 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506334;
	bh=uIgLSqziQCeKnnjs3M6A6U9bobYsrf6xTUo8tXLjk/E=;
	h=From:Subject:Date:To:Cc:From;
	b=a6ZJ9QGOtOersDdiTY/X/N92Rp1/V/9VoTiBUwdbX4iO/ESfasNO660x83QMtcUXH
	 XGA+M2WR43csK6l6iSWel6a3dFsHetl3+eOE3cwWfcvMyX/hvNuNBfp3vhtJDHFJF+
	 ZRRWYTxenzkDOK703vLxQmpom3+IqiRMt+juiKAeHcpXQW+qXHMwHDtTJ7KaLuzx+N
	 moPlPU2RaJTcyzm2VUJFyh1a7iH2P7efmNDrK3jqvXcTLr+laJvGmYyL+76OMVHXbh
	 MZ0+REnRI/DfxDSdt+EEtMDv+bX17d09arJXFCTVtA8FyToWmhZtZ9UbYi258ZBjPR
	 q/WvN+vvbj2sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: sched: fix some lock issues
Date: Mon, 21 Oct 2024 12:25:25 +0200
Message-Id: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUsFmcC/x3MQQqEMAxA0atI1gaSogheRVxIGjWotbQiA+Ldp
 7j8i/cfyJpMM/TVA0lvy3aGElxXIOsUFkXzpcGRa5gcY9ALj3hJxCyretxP2ZDJz9K1npUICo1
 JZ/t92wGKgPF9/0F/G2xrAAAA
X-Change-ID: 20241021-net-mptcp-sched-lock-10dfc75d1e00
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uIgLSqziQCeKnnjs3M6A6U9bobYsrf6xTUo8tXLjk/E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFiwbUyEDYfJ6v5K+ZJSztVrh+r7PGQBWTjjTY
 lPuIsFotGaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxYsGwAKCRD2t4JPQmmg
 c1PeEAC0RZJZiiiBXPzXzy5/SBC1aGCpPNMiv6x5BNj1rNyZIv/l23Pn5ZdaP+ljrVGmNO+RnF/
 MnrGotL0jY76ffMuwDdJoUvG/xVoNlQUUlupPkK3IKtHLA9heRlzbJWYlf9F+vDHXaGg0oKLI+o
 0sNKmPt1ODvyX9Nt9xIDXJwhVaCPFLgwGoDyOZQvK/xv0MrN8Vv3mnHSvKnXi24XbLdbWRyGmLe
 4JHXGbJ8pa65A2yKZInwPjzHrIaGwTd79a5SCR0Tmkn4QS9kurjybpIQZ8bvQqUbvt2TRNz9HJa
 ysTS0+Cwz6cEFw/jyzcgkMsCR4m+mWOPq+gcRo5HXYgGvLevFFQXDYIVIY221Yl3YpHjtB+XKtA
 VfTbfxBlJB7pN7/rTPLSiN63B0bfaxhvterWDUTLfuWSxkD5RXvqfleOYSmJYR1byWmxzTHSnH2
 S47i4rJApubaq5MJ5lf3S6xYhqlRez9780ouAN/iyuEr78eOVEnroxpO78kxDpT1a6U1dZkLWgq
 hs3X6IuVnlcmyUHATLRZNE2ufKy8MoWtxqd/VRxPgL+nmIbiArfYIPrUc06jdGGVTTt+NtTR79i
 m+BIACH8Bk1NLMmKZPnnsvAtIWaMC0+2ErBNBiu394w/nRsXYCW38s9bbTCyDGpslwmr+7hmIdj
 hipEkxCJxf3tLjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two small fixes related to the MPTCP packets scheduler:

- Patch 1: add missing rcu_read_(un)lock(). A fix for >= 6.6.

- Patch 2: remove unneeded lock when listing packets schedulers. A fix
  for >= 6.10.

And some modifications in the MPTCP selftests:

- Patch 3: a small addition to the MPTCP selftests to cover more code.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: init: protect sched with rcu_read_lock
      mptcp: remove unneeded lock when listing scheds
      selftests: mptcp: list sysctl data

 net/mptcp/protocol.c                               | 2 ++
 net/mptcp/sched.c                                  | 2 --
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: 3b05b9c36ddd01338e1352588f2ec1ea23f97d43
change-id: 20241021-net-mptcp-sched-lock-10dfc75d1e00

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


