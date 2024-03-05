Return-Path: <linux-kselftest+bounces-5905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47926871C0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14AB1F247F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B945C5E8;
	Tue,  5 Mar 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3GOxlB+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA454901;
	Tue,  5 Mar 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635362; cv=none; b=Bkdemc/KwEzzHATw//XKmA3qVGqgZFOm1Ef7GinMXorfDrPE2fEjlbuRey5pQtxpccI+5ji4o697gT6fmg0eeh3z7jmIjzGS+FhIyG/725H/i06XTOPnbShisyJsyL2YdoezMiJRai9ePSL1fpCDFGoVrwRUGy1pjMyLFdYpvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635362; c=relaxed/simple;
	bh=exgOqNE6brklM0ZHb0jOAgyhyTqgfiuu8zz8+7dwu7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XOgMZ/rChXRcVQlWtDplHQON8B1z2//HofrtDDqEGaqDPnS81APW2KG7ZVpNHQ/vPuSq3WeazNvvzZ2WtIWxmzW7hOfLbVvFHsw8CMXJj1WoxCB7rp+XldP761MOkiDyRFtWFXjqr+CQLbh4KDCu9RWaIBfOOHEShtvdnVHF4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3GOxlB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDEBC433F1;
	Tue,  5 Mar 2024 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635361;
	bh=exgOqNE6brklM0ZHb0jOAgyhyTqgfiuu8zz8+7dwu7I=;
	h=From:Subject:Date:To:Cc:From;
	b=L3GOxlB+uqIHQQxXd+Z1r6yoc4Iqw6Af04m7llQUERF5aar6p4CUYiA6r/PW1y8BL
	 49Zruh2Sf7zWraBZcuWwUTdW7yBKFEnnQaLoczM3/xylyTj/4wR1aoQmqnN96CHRGJ
	 +3kKQgrwYMKwHe2p/9uas5Ldf1P1nHrnlB3DUe9p1iR62ktWqXtfsnqUCaIxCBx+Ei
	 MOYKfBLeBDQEkiAA7uF4l/q37UQdK9KD9VYJpzqq9zYHa5tLB6udjB9AwDRfw521it
	 lHhepnKOaMlFKr1ibI++1BNycgZ03zv0zh1wyLyKb662seTSnk+oShB9+3vkP6jili
	 0B5PU7sZ2e5Bw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/13] selftests: mptcp: share code and fix
 shellcheck warnings
Date: Tue, 05 Mar 2024 11:42:30 +0100
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABb35mUC/z2OzQrCMBCEX6Xs2YW0Rg++iniom4kN9idkVymUv
 rtB0MPAfAzMzEaKkqB0aTYqeCdNy1yhPTQkQz8/wClUps513h2d51dWK+gnnmFVq/E/UozRoKY
 8ZZPMOvQFgWUJqB7jKAPkye3ZRcH9JPCe6k4uiGn9frjSr5Vu+/4BnwCD1p0AAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=exgOqNE6brklM0ZHb0jOAgyhyTqgfiuu8zz8+7dwu7I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccV1SlR19EinU/Uh/MFT4e4y1o778w05a1H
 E/IQssg1/CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 cxZyEACidUt8yUDI3PDTFLwHBDYkN10nYAT6F/FEYh423K4QecvsdHr86oJfjL4oppc8GXCqC3K
 kHJj2gQ4VCjUMg2EqISFR5aEvsy4tYNxmmErjvN8zNug4ehl6oKl9Qg5gCwKkzwJDfUxSYYZxIT
 qJiE2anucZKD+wXP7/d3QXX3osIEmGqC8DgalAtH/rwMLx+h05S6UbnhPmiexZFPQIA6U5bIY7x
 +srNikEHS9qTGzZAHeywxWF1HIxkiwJolVmLYf7eSs7wpfzUAzwxFs9vnZ6jorNDuNc59PzCQsg
 e67KQEa82TVLeNuQIag3nDZ9nXMwjJTZm94t8045GaIps1xOFnL4VNGRurk/r+Tm4ygFoNKJGhc
 RBUxYc8hg+0OvvW5amOKaq4CwvZNCNqzH46OfJ/tbIoNYldWx6OIs55cujDJhZHIMjK3QZfXGi9
 aL90HwSA2oQwi7XldhGGc87+Yvyz6yfdQ/45lgGjjIemqPxcCGILsiNagWDX8XtDY9Q0QFeqNtW
 30qdvgcGsDsBcqPKXH2ZHadE4MickBLqIUJihIwMJ+rwTC7J8PqxAmMrbCanXohSQTWc+/wXgBp
 8SPwZehl0fX5FDJeVw2K0N07G5ePPjW1FTg4YEfuJk0sEiyLN2UFTagjyM/xEx2BlMac19wH8Iv
 rysr8tNIBLI4WZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series cleans MPTCP selftests code.

Patch 1 stops using 'iptables-legacy' if available, but uses 'iptables',
which is likely 'iptables-nft' behind.

Patches 2, 3, 5 and 7 move duplicated code to mptcp_lib.sh. Patch 4 is a
preparation for patch 5, and patch 6 adds generic actions at the
creation and deletion of netns.

Patches 8 to 12 disable a few shellcheck warnings, and fix the rest, so
it is easy to spot real issues later. MPTCP CI is checking that now.

Patch 13 avoids redoing some actions at init time twice, e.g. restarting
the pm events tool.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (6):
      selftests: mptcp: add mptcp_lib_check_tools helper
      selftests: mptcp: add mptcp_lib_check_output helper
      selftests: mptcp: add local variables rndh
      selftests: mptcp: add mptcp_lib_ns_init/exit helpers
      selftests: mptcp: more operations in ns_init/exit
      selftests: mptcp: add mptcp_lib_events helper

Matthieu Baerts (NGI0) (7):
      selftests: mptcp: stop forcing iptables-legacy
      selftests: mptcp: diag: fix shellcheck warnings
      selftests: mptcp: connect: fix shellcheck warnings
      selftests: mptcp: sockopt: fix shellcheck warnings
      selftests: mptcp: pm netlink: fix shellcheck warnings
      selftests: mptcp: simult flows: fix shellcheck warnings
      selftests: userspace pm: avoid relaunching pm events

 tools/testing/selftests/net/mptcp/diag.sh          |  35 +++----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 111 +++++++++++----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  60 ++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  92 +++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  55 +++-------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  31 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  38 +++----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  56 +++--------
 8 files changed, 234 insertions(+), 244 deletions(-)
---
base-commit: 09fcde54776180a76e99cae7f6d51b33c4a06525
change-id: 20240304-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-160fceb5ce44

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


