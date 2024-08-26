Return-Path: <linux-kselftest+bounces-16294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A095F5B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ECCB21D1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4441946A0;
	Mon, 26 Aug 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmPyT89G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555654F215;
	Mon, 26 Aug 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687963; cv=none; b=I0lteTrKuVZ83P/RGdQ6WaJA7AV+m91SQsfDWmnu2bv26w5siA2EJhixLPLkgJASAoH4OErHuJeABLZYD1gtIlypmTSgguquBIMSpZdnPnnCLELJLjHwRpK7OO+TQdjkvXyR8x4V4HSv198v6WDiP0vHfteKNogfm7kdTkmcXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687963; c=relaxed/simple;
	bh=jdjD1iO7hHPikvlm9/kmvuRvj8KOSLZxB7ihK0uvclQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q1k5yvSZaLs5QJN1oWYKhWUgDMZotKZlWn/hurXfOdjCxH0hPkc5QOQmxN9sw2J7Rcvoz3NQYFKjfZ08G6K/wH68s/+aoW35YiwF8El37Y9UHjGbVxl1cMbGkYsEH6WBDBuZ1c1PgO+MaVd0Msg3jXe7zpvBFoAFVNXNxztUcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmPyT89G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0B4C52FDD;
	Mon, 26 Aug 2024 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687962;
	bh=jdjD1iO7hHPikvlm9/kmvuRvj8KOSLZxB7ihK0uvclQ=;
	h=From:Subject:Date:To:Cc:From;
	b=CmPyT89Gif345EujMnzmJRK3DJHjAgl46gc2lM4yi7pBpGHEZ7V+T2WO4px7D9gT8
	 nOYm8OaVk0AOQWCPFTewvF/EOksKRALvi+Q1Hy1huRDhDMGMsRAq1L6bP8wxC4undq
	 CpeO/McwNrCsHUEKxAX1wmasWbFX58l+5EnJDhvjOCW+nX7lGK2WSwcwXnICTyAqLf
	 PoDK2sV+8m4ImIvITq0/zJTLlmeb95I78t416V9YLCQ5R2ug8PGnSkBerF6tXkYEwK
	 nusWRbUNldpWSX5soDk2eOPMk5bQr4CuoCGHJab5X9Hc1Sj4qEkoo9z60nEtCe5ixl
	 6uyOln2Z89rhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/15] mptcp: more fixes for the in-kernel PM
Date: Mon, 26 Aug 2024 17:58:59 +0200
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOmzGYC/x2MQQqAIBAAvxJ7bkEtLPpKdBBbaw+aaEQQ/b2l4
 wzMPFCpMFWYmgcKXVz5SAK6bcDvLm2EvAqDUaZXo7GY6MSYT58xHoUwRwx8YwjOatfZMOoBpM2
 FRP/fGSSB5X0/YLoAwWwAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jdjD1iO7hHPikvlm9/kmvuRvj8KOSLZxB7ihK0uvclQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWCUzBkFaJOBvogv78Elk/Ytvo1+QDGIRpx
 kj7vO0q3puJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c2gcEACU6RiYBTHnEzBK4yPuiKnzPssXID4JYrUJzyiYeOIwC4KZpwJ3op1qKQCP67pkBR3vx83
 Z5G9g0xhX15v10YyGN9iTgfgCJlZVLyvQUyZN3moIleuMuC1SKIH75eh6AHydkje4ki04mKzNEf
 brXUfhQ0Cc3Z+j3qxpt406Rpq6XwIqJidAaS67BVxIpKNmnYZrsdJwWxdL62co9d653TXG8llDM
 KDl+0mWgZQ7SYXgSZPsRNQsL+Gg7Pz89pHYvX443e4A9D+g2VQbx/2UZQlYHutaW4LVtDGKI5hx
 cF77jnJYjM5QLnOy7e3S43+07M0PwYUi4FCII1ti/r37MvePhbwgo5DP5IVAIKwfLqpAIPn3l6i
 Zk4LCTsspu3h1tw61nj4BkGpfHLTtPwmQAEBFoE5oigb22TuGhxPfzgCXNVJK+sQWl22RLhBlw+
 2uvG5xUPpjvTyqOhGlhDvE1byFjoxSg77W4azn45TWtiBTfYZ7K6EWBNWJCp1TJPkN+10nJLNUf
 5DNDpQPLLrk5TXl5pPLiO7WLeKdp5zgEaaTvtfU6+5x/iG6OdHGA3vqzbDjEWeVtiGuOf5dh+w6
 7mqykAd1NI3IvR0VadcoRKMIGCb863N8lS+M0qfX0KHKO1CV37CJCoa2znY+C74wCDXscjN11uA
 LC6P/9pxNcCHBbQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a new batch of fixes for the MPTCP in-kernel path-manager:

Patch 1 ensures the address ID is set to 0 when the path-manager sends
an ADD_ADDR for the address of the initial subflow. The same fix is
applied when a new subflow is created re-using this special address. A
fix for v6.0.

Patch 2 is similar, but for the case where an endpoint is removed: if
this endpoint was used for the initial address, it is important to send
a RM_ADDR with this ID set to 0, and look for existing subflows with the
ID set to 0. A fix for v6.0 as well.

Patch 3 validates the two previous patches.

Patch 4 makes the PM selecting an "active" path to send an address
notification in an ACK, instead of taking the first path in the list. A
fix for v5.11.

Patch 5 fixes skipping the establishment of a new subflow if a previous
subflow using the same pair of addresses is being closed. A fix for
v5.13.

Patch 6 resets the ID linked to the initial subflow when the linked
endpoint is re-added, possibly with a different ID. A fix for v6.0.

Patch 7 validates the three previous patches.

Patch 8 is a small fix for the MPTCP Join selftest, when being used with
older subflows not supporting all MIB counters. A fix for a commit
introduced in v6.4, but backported up to v5.10.

Patch 9 avoids the PM to try to close the initial subflow multiple
times, and increment counters while nothing happened. A fix for v5.10.

Patch 10 stops incrementing local_addr_used and add_addr_accepted
counters when dealing with the address ID 0, because these counters are
not taking into account the initial subflow, and are then not
decremented when the linked addresses are removed. A fix for v6.0.

Patch 11 validates the previous patch.

Patch 12 avoids the PM to send multiple SUB_CLOSED events for the
initial subflow. A fix for v5.12.

Patch 13 validates the previous patch.

Patch 14 stops treating the ADD_ADDR 0 as a new address, and accepts it
in order to re-create the initial subflow if it has been closed, even if
the limit for *new* addresses -- not taking into account the address of
the initial subflow -- has been reached. A fix for v5.10.

Patch 15 validates the previous patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (15):
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: check removing ID 0 endpoint
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      selftests: mptcp: join: check re-adding init endp with != id
      selftests: mptcp: join: no extra msg if no counter
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

 net/mptcp/pm.c                                  |   4 +-
 net/mptcp/pm_netlink.c                          |  87 ++++++++++----
 net/mptcp/protocol.c                            |   6 +
 net/mptcp/protocol.h                            |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 149 ++++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   4 +
 6 files changed, 207 insertions(+), 48 deletions(-)
---
base-commit: 8af174ea863c72f25ce31cee3baad8a301c0cf0f
change-id: 20240826-net-mptcp-more-pm-fix-ffa61a36f817

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


