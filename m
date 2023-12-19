Return-Path: <linux-kselftest+bounces-2243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F081926C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23D11F25F67
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3003D0D4;
	Tue, 19 Dec 2023 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmKIW94g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741A3EA8B;
	Tue, 19 Dec 2023 21:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB2FC433CA;
	Tue, 19 Dec 2023 21:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703021908;
	bh=G38Y9vn95+svfjge9y+7TA53QzHDBFEvohQmqR7X9S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tmKIW94ggHYEEuJS3LH5KeTGTmWWVNDLQumexqYTobX2FFho7PEdNHNMmVxDBTr7s
	 AlYQhXw9rMlYaUqX754X+zmy2HVg+LJWdKM5Or3sAR6FIZdYCrGYa20PQAVOL95yqv
	 EvgMlNYUjp00QVDRENQAsG2AeYTTTliPWkwR4woSEEtanEDaG9+vA0OQ5Gzz6rld7o
	 rWnjQTxxbGkh++HvX/vD1cG7UA4otl9z/Lzhiugjz4ucWAmTQ0FRj6JhRPOtOTOgEi
	 W0XASrD/PXLk3LBxpehDD9Jx4mrivV6a51sl553+TDKkMdQC/qfTmqyiYQEvdne5dc
	 WS2lxg2b2Wm/w==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 19 Dec 2023 22:31:06 +0100
Subject: [PATCH net-next 3/4] mptcp: sockopt: support IP_LOCAL_PORT_RANGE
 and IP_BIND_ADDRESS_NO_PORT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-3-2b13bedfcaf8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3769; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4AJuGj51MOryvbeh06GHzAMXOcN8IZTC5d1GACIH8bU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgg1GkzI21MpKNVXeJqL+Um1GIYAx9tptIJjm3
 VfM6Rdw80CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYINRgAKCRD2t4JPQmmg
 cxCiEADa2UUfnDGEUYxlYYSLwol3CIRPfWs4mZdWacMIUQF/EySYy+SQxY/7onvCwcLCXnvzklM
 Z1RABidfzMyYk4OhkyL4NnhjGLuatez6SaWXBmp8WQbTLWIpxjxgGpKZ2IF3MPFubawJ9C2Ebd8
 RXP39ELMWTyib48ikGHDT+6Toqqfu8j4MFcDLtif7nXWukru5uAh3nnMBy/1NOCsU+XfWGkaJ26
 LEXA2Y1iP3B0QXiO3CnRQWzcc2eQO4kDKTqtAQfyaA4UpegE0R3JZYuASRgBATLDB4nQ3Z+CEi2
 H7t2F2YqOziO4e2pazUiRoH05jR/ibEd4t/kWMVvqR2wUewzoaIn0m502SktNCx/PuLiw1lWFlu
 QPEs9GZ0NILc3/CY86sSS25Vx4chBfKmni43MsPPTI6bjo62suanTni1SD8kZHRF4ZfYVskB+4n
 RpHtTZaXih+OPNxcMMsvxZo92bit5qe+0fSkCZDYqp7nCcGxJ2yOke3N5CuZdifCQP4zqUtLY1i
 bDs1M6uwotbx7lyt5muiuEwVDsqKnC7y5bBoob5eudVjfMX7hWoEIIGAy7y9YE5av7jULk5ofhe
 rkuWVPzMlFfzCyMYUzkJTM14eBXNXMhNmZIeX0YL1qqNUHBtm+ev1axLJ62Oio2d1C7c2S3ZdWY
 SPTB5TvSkFXWalQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Maxim Galaganov <max@internet.ru>

Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in [1].
Recently [2] allowed its value to be accessed without locking the
socket.

Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in [3].
In the same series a selftest was added in [4]. This selftest also
covers the IP_BIND_ADDRESS_NO_PORT sockopt.

This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
socket options, syncing set values to subflows in sync_socket_options().
Ephemeral port range is synced to subflows, enabling NAT usecase
described in [3].

[1] commit 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome
bind(0) limitations")
[2] commit ca571e2eb7eb ("inet: move inet->bind_address_no_port to
inet->inet_flags")
[3] commit 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option")
[4] commit ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE
socket option")

Signed-off-by: Maxim Galaganov <max@internet.ru>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a4bf337e6f77..c40f1428e602 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* should work fine */
 		case IP_FREEBIND:
 		case IP_TRANSPARENT:
+		case IP_BIND_ADDRESS_NO_PORT:
+		case IP_LOCAL_PORT_RANGE:
 
 		/* the following are control cmsg related */
 		case IP_PKTINFO:
@@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* common stuff that need some love */
 		case IP_TOS:
 		case IP_TTL:
-		case IP_BIND_ADDRESS_NO_PORT:
 		case IP_MTU_DISCOVER:
 		case IP_RECVERR:
 
@@ -710,6 +711,14 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 		inet_assign_bit(TRANSPARENT, ssk,
 				inet_test_bit(TRANSPARENT, sk));
 		break;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+		break;
+	case IP_LOCAL_PORT_RANGE:
+		WRITE_ONCE(inet_sk(ssk)->local_port_range,
+			   READ_ONCE(inet_sk(sk)->local_port_range));
+		break;
 	default:
 		release_sock(sk);
 		WARN_ON_ONCE(1);
@@ -755,6 +764,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
+	case IP_BIND_ADDRESS_NO_PORT:
+	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
@@ -1350,6 +1361,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_BIND_ADDRESS_NO_PORT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	case IP_LOCAL_PORT_RANGE:
+		return mptcp_put_int_option(msk, optval, optlen,
+				READ_ONCE(inet_sk(sk)->local_port_range));
 	}
 
 	return -EOPNOTSUPP;
@@ -1450,6 +1467,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
+	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)

-- 
2.40.1


