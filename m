Return-Path: <linux-kselftest+bounces-2244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19E81926E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8F11F25F96
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C93B2AD;
	Tue, 19 Dec 2023 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Ry5sMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB90405DA;
	Tue, 19 Dec 2023 21:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71D5C43391;
	Tue, 19 Dec 2023 21:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703021911;
	bh=f2gvC7w8UKri1c32TAYRYmZfycGTKFEwGDAv7yV/QLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S0Ry5sMVLnzW9pfp5OOWzLtrq2lcFYBDkGnWaWhIjb7vvdmk3FiP0tm1rxUkZverp
	 q4jbOfBaymVSztcy7QBqDgi0jxV+u5Vh2O5bH0yCs0lOviTxRDe75bbU+VfRnlnqUP
	 sGcSQSuMyXispGjJyyoynNdSuPLW5iTpYCQZ0CrLvflAkFZtRMTbLL/qs8TPYnixKI
	 jglBDy7OFaJAbElv9eCKTw8k0i8Xla+DpEBvwJlYl7319mtD5nC8iD67IpZrhmwtim
	 ViaKR6nh2f+sXbP6uyKGqAtklvCO6ZjqU6+81WboqQ+wVI/J0uUHM97gH6Xii6JJxN
	 rxLa5yCTq1DNg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 19 Dec 2023 22:31:07 +0100
Subject: [PATCH net-next 4/4] selftests/net: add MPTCP coverage for
 IP_LOCAL_PORT_RANGE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-4-2b13bedfcaf8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fbNXZmS3qdsPsilwuM1H+dJAdECITs25qe5pVmz8Lns=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgg1GFZH7w/nEOkP6mdB5g8NK5fxpSdj5RXrmW
 2XtMy/upC6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYINRgAKCRD2t4JPQmmg
 c8NTD/4t4jyh509SjqZKZ8C+OeSKDHHfwQbtZPaRhfzX6i3eG8MFzJIoSYM4KleCc090f+b90uc
 +KjaK5eCRueP7R6jxZLwVynQjlvikIJRllhTeTUEJNTy6NJmNsS2PPZPaxkRARcyPHr0ty7Se+Z
 4N3IIBbZzIjaa0COKK4uzvcPNQpDjZZvyweEKWOb6J+rMYJjVnfr0gDYjg49/sWCelsdswXS/XP
 JcGyYv5my09XipqrpNFwPGtJgmbV5yz3AziF8gGEZlBZj8k7ANSJ0TaMaW+d4JtBG8BDyd535bZ
 7UBv8e8QZBT5ukVEFb9y6Epdp44xEhvAEyNT8ECMnxopATc6L/+Uj30pCQ5kmHFFDQ+ogZCFwkI
 8frd+F3amLVX/4Tm5hVFmGyBVwpvKczuBdBobCBpW8S2iTfJD7guBCE5HEKZwb7HMDuFaY6q9s0
 41rKsdFtLtCRGCZTR+aSkdGmGqsWXZP0X/vCTYwnLDjcMWqFO8E1PjAh/5fdr6X+30wsL6Vt2DT
 sx6C1UR6StmZP0+eCnv0nv1OORPnWwITowgBkDr+OcEDJT2i/DSshKBPotSjd7L5xwSLQ8blFj+
 vFBrGTTGjC1S9t9D5KMp7XT2Qv7818reel2WYzIo+v91qi7inseuHV/D6zdGkFzfW9zZr9XMf3E
 g+AXCkavMVLUhSg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Maxim Galaganov <max@internet.ru>

Since previous commit, MPTCP has support for IP_BIND_ADDRESS_NO_PORT and
IP_LOCAL_PORT_RANGE sockopts.

Add ip4_mptcp and ip6_mptcp fixture variants to ip_local_port_range
selftest to provide selftest coverage for these sockopts.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Maxim Galaganov <max@internet.ru>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/ip_local_port_range.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 75e3fdacdf73..0f217a1cc837 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -146,6 +146,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_stcp) {
 	.so_protocol	= IPPROTO_SCTP,
 };
 
+FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_mptcp) {
+	.so_domain	= AF_INET,
+	.so_type	= SOCK_STREAM,
+	.so_protocol	= IPPROTO_MPTCP,
+};
+
 FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_tcp) {
 	.so_domain	= AF_INET6,
 	.so_type	= SOCK_STREAM,
@@ -164,6 +170,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_stcp) {
 	.so_protocol	= IPPROTO_SCTP,
 };
 
+FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_mptcp) {
+	.so_domain	= AF_INET6,
+	.so_type	= SOCK_STREAM,
+	.so_protocol	= IPPROTO_MPTCP,
+};
+
 TEST_F(ip_local_port_range, invalid_option_value)
 {
 	__u16 val16;

-- 
2.40.1


