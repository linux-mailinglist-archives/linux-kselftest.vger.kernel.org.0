Return-Path: <linux-kselftest+bounces-41368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D370B54DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A610465090
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16143191B1;
	Fri, 12 Sep 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmZFIZyn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FC3176E4;
	Fri, 12 Sep 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679978; cv=none; b=cguEHDOl3o+D8NpX6MF/p4LfL53wPKkmxbzH+xasMMmsK98UgIlDbUhT9ZbL3cKVjfOCHk9oyaSdNewJ4d1i9L5XpSB9QODr0CUV0KLmsqd8c5gWsyOBRaCmHoPu+MZK88uDzI9/GtwTyKd5aXCzDWgOYZ9c6Skx8MpKM47deCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679978; c=relaxed/simple;
	bh=8DS2hF+BEjU7aaHlrAzv+IT/n2Wvo9mCPVI4cgDetqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRhltRg+pxHjvsFejRRQwhTL06Itbgt6O28vkTO2IS/4Mh/lBkSN9aG5GOBMN/snh5bK48CdFByaeOKupgGquK7OaHUCbyNdSRbmYb1gh68uckOOFaPLx864BDi7o8qnoK8hTOS5X+GcsA3UJT9s/AA+Lym72ORpPwYxM/mjp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmZFIZyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCAEC4CEF1;
	Fri, 12 Sep 2025 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679977;
	bh=8DS2hF+BEjU7aaHlrAzv+IT/n2Wvo9mCPVI4cgDetqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TmZFIZyn9I1NCK9zVlRIRW8S5p97IojSuNvg7DJrGDlm5K6EHuopLtFMVvwTSMTgZ
	 6CL5Wwa4LgMhB9QQPKDibZKuS9My0vjPQ6Y+O8DLit+P8bog0BJKOsMwR9n6C90Ti/
	 9Yw2fCBWyHfaWUxVo+uYJIocbKlllCg7pWYX/cCV0x56VTG8oIvfyyPGMMGgdQOstg
	 62+kwIPWB63KzR6cL2IJeo7oUd+juezWAgdA1hvHboqJLjcD/LCmOk+1fsYV7me9NP
	 kHyIGv55R4NQRrZ2uGqLUCExCY21fNcxk52DKJ0SFgKFfZYjHdKUin6hPNZ8jeylOk
	 z+BvZZklMHBRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:25:52 +0200
Subject: [PATCH net 3/5] selftests: mptcp: avoid spurious errors on TCP
 disconnect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-3-d40e77cbbf02@kernel.org>
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8DS2hF+BEjU7aaHlrAzv+IT/n2Wvo9mCPVI4cgDetqQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCEbXGnzwfCi31G9/6Ae7VTc3eV4taH7jZss7Q29f4
 GyFd+/kO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyJoKRYdaTlYlCr8pmz1V1
 OT2Z53PlBu45TYwigklxCtE8TNozAhj+qcrZsafynOm6OOufyruIa3dYgv6XX578snadP9fETMV
 AbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The disconnect test-case, with 'plain' TCP sockets generates spurious
errors, e.g.

  07 ns1 TCP   -> ns1 (dead:beef:1::1:10006) MPTCP
  read: Connection reset by peer
  read: Connection reset by peer
  (duration   155ms) [FAIL] client exit code 3, server 3

  netns ns1-FloSdv (listener) socket stat for 10006:
  TcpActiveOpens                  2                  0.0
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       274                0.0
  TcpOutSegs                      276                0.0
  TcpOutRsts                      3                  0.0
  TcpExtPruneCalled               2                  0.0
  TcpExtRcvPruned                 1                  0.0
  TcpExtTCPPureAcks               104                0.0
  TcpExtTCPRcvCollapsed           2                  0.0
  TcpExtTCPBacklogCoalesce        42                 0.0
  TcpExtTCPRcvCoalesce            43                 0.0
  TcpExtTCPChallengeACK           1                  0.0
  TcpExtTCPFromZeroWindowAdv      42                 0.0
  TcpExtTCPToZeroWindowAdv        41                 0.0
  TcpExtTCPWantZeroWindowAdv      13                 0.0
  TcpExtTCPOrigDataSent           164                0.0
  TcpExtTCPDelivered              165                0.0
  TcpExtTCPRcvQDrop               1                  0.0

In the failing scenarios (TCP -> MPTCP), the involved sockets are
actually plain TCP ones, as fallbacks for passive sockets at 2WHS time
cause the MPTCP listeners to actually create 'plain' TCP sockets.

Similar to commit 218cc166321f ("selftests: mptcp: avoid spurious errors
on disconnect"), the root cause is in the user-space bits: the test
program tries to disconnect as soon as all the pending data has been
spooled, generating an RST. If such option reaches the peer before the
connection has reached the closed status, the TCP socket will report an
error to the user-space, as per protocol specification, causing the
above failure. Note that it looks like this issue got more visible since
the "tcp: receiver changes" series from commit 06baf9bfa6ca ("Merge
branch 'tcp-receiver-changes'").

Address the issue by explicitly waiting for the TCP sockets (-t) to
reach a closed status before performing the disconnect. More precisely,
the test program now waits for plain TCP sockets or TCP subflows in
addition to the MPTCP sockets that were already monitored.

While at it, use 'ss' with '-n' to avoid resolving service names, which
is not needed here.

Fixes: 218cc166321f ("selftests: mptcp: avoid spurious errors on disconnect")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 1408698df0999730d9a9a4ad6a6362a4ab122d54..b148cadb96d0b735901c92a1e4417f29c263dd90 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,7 +1248,7 @@ void xdisconnect(int fd)
 	else
 		xerror("bad family");
 
-	strcpy(cmd, "ss -M | grep -q ");
+	strcpy(cmd, "ss -Mnt | grep -q ");
 	cmdlen = strlen(cmd);
 	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
 		       sizeof(cmd) - cmdlen))
@@ -1258,7 +1258,7 @@ void xdisconnect(int fd)
 
 	/*
 	 * wait until the pending data is completely flushed and all
-	 * the MPTCP sockets reached the closed status.
+	 * the sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {

-- 
2.51.0


