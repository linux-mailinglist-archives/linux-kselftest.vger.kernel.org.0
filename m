Return-Path: <linux-kselftest+bounces-15701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D369574AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64113B20AF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16F9188CC5;
	Mon, 19 Aug 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8imgfX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B928F3;
	Mon, 19 Aug 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096726; cv=none; b=UXa0qDV34Ira0XX2gfsups8h62m2Nc82yZbaQ+9WmmZ/DGX5lJ9GjrEfCkEWyITrEmZC1wGEe0zhLgiwPQEUlQPYbrpz9e63z3SwdXp99J74jrnDD6hLvbfivXA2wiMqHk0I7dWPZk0ectNo2EKxoaTLb6nQcdFSxX8op/y7OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096726; c=relaxed/simple;
	bh=rxZqESM+eUB7EBEwECl45DgTGVkm6axYqGu1hueOi3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ULp3/ETAFOnieizY51HkybI05+cHaIH9Cku8wdTExy/SeR/is6bxoSe5Wvu7e+sxeH4G8EfDO0FyTzvFtOTu+qkqS/oZK2ZE7EkuUDekN0a6MIP6XGXVQ4/NWg0YFWitOjQ955M3kueYnBOgFtUFmZHVKZYybGfybUfqNo/sCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8imgfX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2248C32782;
	Mon, 19 Aug 2024 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096726;
	bh=rxZqESM+eUB7EBEwECl45DgTGVkm6axYqGu1hueOi3k=;
	h=From:Subject:Date:To:Cc:From;
	b=Q8imgfX4tWt0Am2fcYPQDZQDcXPfAqjIMEMTeP3vEMSe+I48OZQ+0636BAbr1rpoR
	 OrPhUmAAJBXJIjnaTJW6fr9cTOIHE3puqIhjflPX0n2URSKycxUPlrV02KzO3WzqDv
	 ZQFGXw3AfZ11AoKrJIjYhadbthcMneP/XH9QZUCTMIEK1HeJTqVH6GujeI3ENApz96
	 MaFoBlQgV5xdL+BFAsSkeO4s762CYXAHwS4q92DYZh3OEk4ETH22xaNzrbkCYYmSKZ
	 o1tK9wsVMaq/rATiyQZxI+CYM90jsEPn5h/fLLSMOAii0xmcmNrgBFiLFsQxLcozxE
	 Lzdmf/lcqOv7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/14] mptcp: pm: fix IDs not being reusable
Date: Mon, 19 Aug 2024 21:45:18 +0200
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6gw2YC/x2MwQqDMBAFf0X23IUYion9ldKD0dd0D8aQqBTEf
 3fxODAzB1UUQaVXc1DBLlWWpNA+Ghp/Q4pgmZTJGvs0vu05YeU5r2PmPHPBViVFdRjBeG9dcAE
 daZ0LvvK/z2/SiD7neQHMpnhxbgAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rxZqESM+eUB7EBEwECl45DgTGVkm6axYqGu1hueOi3k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DShCkwBCwPsrJVDaJvEoQKj7WScMrjECzPx
 fIdApAUFeiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c3bvEADbcGE+bC1WIf8Jqlxgk1takIjIZGTB3mULFhv9P0Mr0uK3FclMmHKiui4wFIZBNHjxzWz
 y/to1EHPzGK2eFe43EaleSE/OEjsHMfxXrD9TcDQBQ+SFI5xNgIT9Q0S5gu3OcaipqRji2Z1S6H
 1DsSYbtV6/1TgQTyK6MlWLsmjSsGTKhhgEdInvOenGu6z+ALsYKoAHqeDIMA1OExxaYDZi4p632
 xR6DInNq9BmIowXTxaZLZjPJMTT8f0f6SybBUx6HcCttW9cr60Rfeolv1wnwpZIiuOVeHbvzZ8i
 Bqtck2b8ViW9dgMDJbF8TL+ChrvnO1oGbMeT8c1c0y7a7HQZ8n3Q8dCcmcSRqZaMmSmQqJgBbci
 LeqO1wMg1e1XmxjcBDL0IA4l0oEDnhhnrywQTDsiNwmmSW/ws77AuNYJN815oHz2U0wu6cOXIcc
 4s/avXQcmwDGZLDzqjoV2clt3edhoPVqjegjFahfn4Ua6Yy3nJXpXhanX2hY8yFGbHz/DdaqN6O
 g+6URHda6DoJ71oyeqTde7O7Az4BjANkB9M8IOSlnojxcQdndB6wMFzhUuUdMS2riBxfWM9d5mh
 loWdoTR1bDIwmUqNkrn7lJ6pnxPJyuV2hs1edGIgHl2ekNOIDf6VjovOlK+MrLbbv1H9s0IQMJ/
 avD/dqhgMWeDisg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are more fixes for the MPTCP in-kernel path-manager. In this
series, the fixes are around the endpoint IDs not being reusable for
on-going connections when re-creating endpoints with previously used IDs.

- Patch 1 fixes this case for endpoints being used to send ADD_ADDR.
  Patch 2 validates this fix. The issue is present since v5.10.

- Patch 3 fixes this case for endpoints being used to establish new
  subflows. Patch 4 validates this fix. The issue is present since v5.10.

- Patch 5 fixes this case when all endpoints are flushed. Patch 6
  validates this fix. The issue is present since v5.13.

- Patch 7 removes a helper that is confusing, and introduced in v5.10.
  It helps simplifying the next patches.

- Patch 8 makes sure a 'subflow' counter is only decremented when
  removing a 'subflow' endpoint. Can be backported up to v5.13.

- Patch 9 is similar, but for a 'signal' counter. Can be backported up
  to v5.10.

- Patch 10 checks the last max accepted ADD_ADDR limit before accepting
  new ADD_ADDR. For v5.10 as well.

- Patch 11 removes a wrong restriction for the userspace PM, added
  during a refactoring in v6.5.

- Patch 12 makes sure the fullmesh mode sets the ID 0 when a new subflow
  using the source address of the initial subflow is created. Patch 13
  covers this case. This issue is present since v5.15.

- Patch 14 avoid possible UaF when selecting an address from the
  endpoints list.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (14):
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      selftests: mptcp: join: check re-using ID of closed subflow
      mptcp: pm: re-using ID of unused flushed subflows
      selftests: mptcp: join: test for flush/re-add endpoints
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      mptcp: pm: avoid possible UaF when selecting endp

 net/mptcp/pm.c                                  |  13 ---
 net/mptcp/pm_netlink.c                          | 142 ++++++++++++++++--------
 net/mptcp/protocol.h                            |   3 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  76 +++++++++++--
 4 files changed, 160 insertions(+), 74 deletions(-)
---
base-commit: 565d121b69980637f040eb4d84289869cdaabedf
change-id: 20240819-net-mptcp-pm-reusing-id-eb08827b7be6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


