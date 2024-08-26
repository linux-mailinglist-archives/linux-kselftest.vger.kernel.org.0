Return-Path: <linux-kselftest+bounces-16322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633B95F778
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53880283089
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC4194C95;
	Mon, 26 Aug 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk3y5IwM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8578C89;
	Mon, 26 Aug 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692289; cv=none; b=bFMvkPQzzw+seViK5fuAlCCgGVqz0fOWJK1eWoC55SUhBuPTh3Pm5K4x3pa9QXLSRKv8toBDc+6FFPUtTSa4qoIk83mwtc4Hgc66YwznobDzhViIXDQipr4qXjZjf4u2HG1Wtz6NJKVqcw/AsjhOSih6hd80NKb5ObV7CKZUW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692289; c=relaxed/simple;
	bh=OjlRIP/YfMcFStEv3GSbKGrEZZShBXmsGgMZmpWuKoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R2eN8yChufE7NL1rMtLSYHRwDY0Lgq0iTZ85zz2Hx83KF6DoyBSiJM5JBaIwGK8JVXucjB+s/exyo0RbzZKTJxbEnLHUs/6bHY248MIoPF22sMCS9pdY3ffEBuud07Tkx7uzSagV6embrAV44wGvEot+pLZjAhHR5HRHitJd2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk3y5IwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B83C582B9;
	Mon, 26 Aug 2024 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692288;
	bh=OjlRIP/YfMcFStEv3GSbKGrEZZShBXmsGgMZmpWuKoE=;
	h=From:Subject:Date:To:Cc:From;
	b=Zk3y5IwM3tZZZpj3Yczdp6ghADoDbdWFt7dM+jBLL+sjffW/NoPIFWfoTB+Nd/NKP
	 ps+12We/LlWUv98/iGFbjc3LkPETV3YCSOmRBbfSasBg7O6U4JLONp0BcVKogmRTjP
	 F46JT0/K1JE7hsiGyARLQ9qROymFJpSmCheN4MhW0WoNx14BZ1JKeCRUIzlsoTyPDV
	 zuB9c7xiXKFEpe+PWfTs/DMbzwyIDqxkx6ENBBfaqnezMvCKh+NLkrzeoUJz4By6Wp
	 s8EVcKMRt65h/e3+4+2pMIyL9UmpG9wiVmzIx4+h/g2uIcYbNTR8cQrrGs/5HZ0sta
	 zns7TrkE5h3Nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: close subflow when receiving TCP+FIN and
 misc.
Date: Mon, 26 Aug 2024 19:11:17 +0200
Message-Id: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADW3zGYC/x3MQQqDMBBG4avIrDugIS3aq5QuwvinDmgMmVAE8
 e4NXX6L904yFIXRszup4Kume2oYbh3JEtIHrHMzud75fnQPTqi85SqZZd0NjKOWwBY5auJhmj3
 uIXiZhNoiF0Q9/vsXtZLe1/UD1b4aL3MAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OjlRIP/YfMcFStEv3GSbKGrEZZShBXmsGgMZmpWuKoE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzLc9JZUW5F/lg9YktD1Wr1ePhZuARG2/gO24t
 4WWfuhbFGiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsy3PQAKCRD2t4JPQmmg
 cy/lEADW9ymX2YFVRy1SQl2oH7snKHe/kKsDkN33iltiwF8JAA9Fll0E+ZZbKRK7ziewH4/NTH8
 dkU6O5rOsX4sZ8DnCtpAja6RbqV/1/oNZyID4tCM9rNbpu9UrLYc5oPJwhfC0OHfv39+nFFiKtp
 igENzx06TkOKIDB95HQo/+He1n3fyvBUfEok69PH0yMOsaa0nmkr9yhZTPirB+jCkRjxOwel7Rl
 eD01VAH6hOHEX9A5024MGSRcMGkYiPHeF13/w2Orv+Pl89+QmdkKTlXvm5nEMJLKx4JTPIEMOiS
 iaFP6ka3nAbfGIvWZqvETFZu2TnGNneD4Snv+6xqvHSUJgL9e9kcIZN6J5DUk3g2cxRlQSPWGrD
 XTphIy1uRzMu6mFLBoukBlDfD+3A3LEUXtvGLi15L8kIXZjj+Tp/LLyFOP+95ek5FI6tkBB4lrz
 AkpRnjBghq4CZXEHCQpZgVDS3301/f0yxQa2FKcn45kd2C9dXF9ttV4dbmrvmDktuqCSs+Ra1y3
 YcWKwvdK6yHWObA7KaIdDKxz0d3fB2uErWBklAzJK+n0UhQ1JvpjCs1vMIkPP2MF9rY8EEfMehc
 ecC9BTqxhr/nkSKvza1eYYlt79zosPJJhoO43D3f+WTyBwvxzHXneIe7+hhCNNvnTyBalVvj+iv
 cgGn9lC8JeP+Qag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are different fixes:

Patch 1 closes the subflow after having received a FIN, instead of
leaving it half-closed until the end of the MPTCP connection. A fix for
v5.12.

Patch 2 validates the previous patch.

Patch 3 is a fix for a recent fix to check both directions for the
backup flag. It can follow the 'Fixes' commit and be backported up to
v5.7.

Patch 4 adds a missing \n at the end of pr_debug(), causing debug
messages to be displayed with a delay, which confuses the debugger. A
fix for v5.6.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: Peter's email address has been removed from the Cc list, because
it is bouncing.

---
Matthieu Baerts (NGI0) (4):
      mptcp: close subflow when receiving TCP+FIN
      selftests: mptcp: join: cannot rm sf if closed
      mptcp: sched: check both backup in retrans
      mptcp: pr_debug: add missing \n at the end

 net/mptcp/fastopen.c                            |  4 +-
 net/mptcp/options.c                             | 50 ++++++++++-----------
 net/mptcp/pm.c                                  | 28 ++++++------
 net/mptcp/pm_netlink.c                          | 20 ++++-----
 net/mptcp/protocol.c                            | 59 +++++++++++++------------
 net/mptcp/protocol.h                            |  4 +-
 net/mptcp/sched.c                               |  4 +-
 net/mptcp/sockopt.c                             |  4 +-
 net/mptcp/subflow.c                             | 56 ++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++---
 10 files changed, 122 insertions(+), 118 deletions(-)
---
base-commit: 31a972959ae57691a1e4f539399b2674ae576086
change-id: 20240826-net-mptcp-close-extra-sf-fin-19d4e5aa4c9c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


