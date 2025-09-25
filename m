Return-Path: <linux-kselftest+bounces-42292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994AAB9EAD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590C91681E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C302EA74B;
	Thu, 25 Sep 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjqP/U1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE62629C;
	Thu, 25 Sep 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796395; cv=none; b=osp9OEvvhF06GuJoG7pJNmWTyVSrZF3HLs7kvJ87rGvjveAGKiynS8hQNOdEWiJR1HDf5Au5Mhq7nRY3z7cZdId5wuQKKp9yqnznCurjuRDTkRtSIRGxQ3JlXexrF5Wc1xi+N44f1cfBzCQrTAe+XN6DVYsOVEmF4tc8pc5//iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796395; c=relaxed/simple;
	bh=XnjnLjB9jLK1CNnStRu7DYFWYWCWzY1n0+gzU7pDaRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jYa9FYI0Z15BnpP2BcPPSlG0IV4ysEwuwRZartPDx2K46sLLwWEpq7ReulBAkqcphCQPJoks0wyBMtcdzfu9PuQYaLiB2ABSsgWfBeypbXQctpeqKtlgxX/gLWr7mc9gwmx6a5vFdvklHhCE/oXdHYoKls1ZFJ4SIXAhYDNiCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjqP/U1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A34FC4CEF0;
	Thu, 25 Sep 2025 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796395;
	bh=XnjnLjB9jLK1CNnStRu7DYFWYWCWzY1n0+gzU7pDaRo=;
	h=From:Subject:Date:To:Cc:From;
	b=kjqP/U1RUYC8ttxWgoquA0rJFAxvoo36gkjRmyfhkCFiPgIYiWgQbTW0g/q0GdhwP
	 kcjAHqxz9ukRocdEkgErSRIDXcjv1kqlSRtcc8HqqqmvNxbVRt5EI8Yub+xl/IAbte
	 jhDzaZII2KsJx/JlUwggsNqg3O0Wh8xeldoWJ+nJVU87oZDqUalxJtRz9FjYh8IhCx
	 7H1NwmBeJMxuVXgEpPZV9X5vkn+06cSdBzwQtb3twyjH/+ihywmh8IXvCUEVMuQbEp
	 fVUvzK3O06N3k9EbZ0d0U1xvD4PYaQGuD3VUyFFdeeXmSMe43BEeRLf+jamia4/rfD
	 BM+3gBnAZkiBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: pm: special case for c-flag +
 luminar endp
Date: Thu, 25 Sep 2025 12:32:35 +0200
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQa1WgC/zWMQQqAIBAAvxJ7bqHEoPpKdDBda6FMVEKI/p4EH
 eYwh5kbIgWmCGN1Q6CLI5+uSFtXoDflVkI2xUE0omsG0aGjVMgJD5+0R412Vyvu6mCnAtpeSkH
 SyMUMUB4+kOX8/Sf4U5if5wX1Prr9eQAAAA==
X-Change-ID: 20250925-net-next-mptcp-c-flag-laminar-f8442e4d4bd9
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XnjnLjB9jLK1CNnStRu7DYFWYWCWzY1n0+gzU7pDaRo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSgU2tv76anJcrnbRuQtHlN3koy2sunZs0vpR+z/wM
 ftFhxNyHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNplmRkmBLr/ORdjmb/ybp3
 ltVc9nbFU7l9CkoP9nFFR0ud7df/yfA/rMfzzt6KoxJszuyhixJ2sFbycFziU93yXPnhmZMPP0/
 lAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some patches for the MPTCP PM, including some refactoring that
I thought it would be best to send at the end of a cycle to avoid
conflicts between net and net-next that could last a few weeks.

The most interesting changes are in the first and last patch, the rest
are patches refactoring the code & tests to validate the modifications.

- Patches 1 & 2: When servers set the C-flag in their MP_CAPABLE to tell
  clients not to create subflows to the initial address and port -- e.g.
  a deployment behind a L4 load balancer like a typical CDN deployment
  -- clients will not use their other endpoints when default settings
  are used. That's because the in-kernel path-manager uses the 'subflow'
  endpoints to create subflows only to the initial address and port. The
  first patch fixes that (for >=v5.14), and the second one validates it.

- Patches 3-14: various patches refactoring the code around the
  in-kernel PM (mainly): split too long functions, rename variables and
  functions to avoid confusions, reduce structure size, and compare IDs
  instead of IP addresses. Note that one patch modifies one internal
  variable used in one BPF selftest.

- Patch 15: ability to control endpoints that are used in reaction to a
  new address announced by the other peer. With that, endpoints can be
  used only once.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Patches 1 & 2 are sent to net-next on purpose: to delay a bit the
   backports, just in case. Plus we are at the end of a cycle, and not
   to delay the other refactoring patches.
 - Sorry, I wanted to send this series earlier on, but due to some
   unrelated issues (and holiday), it got delayed. Most patches are
   pure refactoring ones.

---
Matthieu Baerts (NGI0) (15):
      mptcp: pm: in-kernel: usable client side with C-flag
      selftests: mptcp: join: validate C-flag + def limit
      mptcp: pm: in-kernel: refactor fill_local_addresses_vec
      mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
      mptcp: pm: rename 'subflows' to 'extra_subflows'
      mptcp: pm: in-kernel: rename 'subflows_max' to 'limit_extra_subflows'
      mptcp: pm: in-kernel: rename 'add_addr_signal_max' to 'endp_signal_max'
      mptcp: pm: in-kernel: rename 'add_addr_accept_max' to 'limit_add_addr_accepted'
      mptcp: pm: in-kernel: rename 'local_addr_max' to 'endp_subflow_max'
      mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'
      mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'
      mptcp: pm: in-kernel: remove stale_loss_cnt
      mptcp: pm: in-kernel: reduce pernet struct size
      mptcp: pm: in-kernel: compare IDs instead of addresses
      mptcp: pm: in-kernel: add laminar endpoints

 include/uapi/linux/mptcp.h                        |  11 +-
 net/mptcp/pm.c                                    |  32 +-
 net/mptcp/pm_kernel.c                             | 569 ++++++++++++++--------
 net/mptcp/pm_userspace.c                          |   2 +-
 net/mptcp/protocol.h                              |  21 +-
 net/mptcp/sockopt.c                               |  22 +-
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  11 +
 8 files changed, 441 insertions(+), 229 deletions(-)
---
base-commit: a1f1f2422e098485b09e55a492de05cf97f9954d
change-id: 20250925-net-next-mptcp-c-flag-laminar-f8442e4d4bd9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


