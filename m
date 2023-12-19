Return-Path: <linux-kselftest+bounces-2242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB7819268
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBA31C21EB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8E3D0D5;
	Tue, 19 Dec 2023 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkKCl1TN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385C3D0D4;
	Tue, 19 Dec 2023 21:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C031CC433C9;
	Tue, 19 Dec 2023 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703021904;
	bh=aBjfw6fT7ns+cc6CISw+cYXM6DUUWWc2pJdKMlpk6Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CkKCl1TNYdbOkyCjQmBr7REKoe0KAojB26oGv6kloSJ0yKCjpJpIDIZNq+ZgTFdFp
	 +p96bDLLf+SqLYSWIoomW9fksc7WzWLxgXM3dRvxT0O077MLEh6u7LF+jFxSBzKVzX
	 rbckGuCpHc2BiBORyG+BB+3+dYneTqldA5+hizQdoHLJHHhjxNu5CbbI54Ck/n94AU
	 zsnvDNVEcFb+NYaTSjKuNa9vs/OICm/sQOABGgH4DAjssoypiMzC1Hn5itPaZrE425
	 cI4xWlDFaMmFezKR70BJ8MWxW6ZgWx+F2kYpBwN3KEqzBkuBxivCm50komVPWni5Bq
	 8/UIFheBD+DNw==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 19 Dec 2023 22:31:05 +0100
Subject: [PATCH net-next 2/4] mptcp: rename
 mptcp_setsockopt_sol_ip_set_transparent()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-2-2b13bedfcaf8@kernel.org>
References: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
In-Reply-To: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Maxim Galaganov <max@internet.ru>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XEswUomoEVDRkr2zFcuVgd5ZmZS3x1/YVKLTXtSAG2Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgg1Gc19zG3z5FZc014YtOLHZwI0p6AgQkvKDA
 0TQMeadrUaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYINRgAKCRD2t4JPQmmg
 cx83D/9CIsHNlz8qyUptArMYLOswrCZAMJlfedxNZJJyOZxxm+ODAaGqkcyZOCbH4H8KUuQ6rba
 mxfsQKlbA3/+l4p40BD7l7Vx4LMub2DX9n+gmJQfGPd/hXlF+z56r/veTLruY9+n5K0IUhujCFu
 BzBqDqdmmAjtNpctgvxB0TjkVuZFGjaf4zQDqfDTck4DMwLy0wHl1zou8s2eym+JR69pQlipK0D
 r7oV/uuoVCJJub1bz/NVK/lUka/b7wKHdt2T0hLTM7ARjNEmZTmvjSYcsfFDaC7H05E2og9jeLG
 NfvZFOt9g15Q5d9d2GYSl2OvS+uXWQDYGaeS18pAaihETHuYxZiOmig8Hsc5kiQy8aNgtcUQ7TY
 2s8SWc9ziu6j5wZqirVemi4Aay/X1XJiGBnVe7xqkyhRu0KKUK6pvqhchabkrW++nd6rXxTIiAW
 NSYuuOp/cNcmgV1S3/vXN43gJ/dV7EPH3/3UTlwrqBURTAmwEqSuyIPSq4KC4O2zHHJjLHmBcXu
 Sib2YLXKApgsaTmC19fSdVQ0ptFh6reEcqgK+qFSOsqSLvE0QUsaVkVIWVuEIF6Lk2ndK/lE5PQ
 Ioog4TYsNHrEDrwHOLO+aiL84la0YsRZkBQwi577lcMPWMxveYZlwbRQs1SKONKG/wX0WZqfGXG
 pcza2nO5ThCpt6A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Maxim Galaganov <max@internet.ru>

Next patch extends this function so that it's not specific to
IP_TRANSPARENT. Change function name to mptcp_setsockopt_sol_ip_set().

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Maxim Galaganov <max@internet.ru>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cabe856b2a45..a4bf337e6f77 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -683,8 +683,8 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
-						   sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
@@ -755,7 +755,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
-		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
+		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
 	}

-- 
2.40.1


