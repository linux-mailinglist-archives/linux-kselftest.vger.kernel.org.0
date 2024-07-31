Return-Path: <linux-kselftest+bounces-14531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB876942CB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A67CB23624
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E71AD9EC;
	Wed, 31 Jul 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9xJtCy8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675F1AD9DD;
	Wed, 31 Jul 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423977; cv=none; b=gusAW4mYpCUUnLkewQKh5CSE7DwZDdZS+B3SWH8UDUXCaeboe4TzVLuRY4dDJ42LOT4w7r+mZZVcB7+Rsw+wBHKx+feuK77ZQ8YT/AewqmeMdvKEY8nmi21L1YGNWhcOqbX2FURsE//k8ZCyAu9LOghZHQqjhNmanA1iNcyB/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423977; c=relaxed/simple;
	bh=HReNhR43esWLHlb4CxNQ1QPflXcu4lQSD0K4aCKNWIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbKLmvXbH3ENmoaRdKr/kv25EMJGvXUOqgb8EDHBMRKIh1AVHxoswTpQausRL0+05gENmKZ8zR+J5o0KQc46o4AxH2bhNbHc9RMbSqkz1FxOi0WZkt0tiwEzO034NcI3aNaT5BfSCcK72Xrd2vCDUDrqM7Ehq59hq4wSGpq6dEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9xJtCy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2DEC4AF0F;
	Wed, 31 Jul 2024 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423976;
	bh=HReNhR43esWLHlb4CxNQ1QPflXcu4lQSD0K4aCKNWIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D9xJtCy8xk9/i2NXHzk9lZwVc3/WQtqfTsvCm2gb/MY5Wz2q9WMjKjOq1T1GTfbID
	 UbppDswdOOhJtqqvTDDK2hMi4sbQKt64nIHadKVA3BLSdpBjaN/qfRd7bBf9A7cKdJ
	 M+L33ZCSw2JC4dTLv7WzYus5rNQtEbXx/Oxqik6pArV4uHfHWw3Gp2GoNhWxSQ+0hJ
	 ktwN9pcGFJ6Ti7qF4cP4deVglW/HfZb7LVFi2/VglhybAg3StnbMUDW03QM2leYIIN
	 ISDPXew8dYxEowVjkZ35MICcJgzwQk/4M1/P9GR12VBbogboQV5iaNz+gZHxu1lzqw
	 U5e2yyhIx1zdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:53 +0200
Subject: [PATCH net 1/7] mptcp: fully established after ADD_ADDR echo on
 MPJ
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HReNhR43esWLHlb4CxNQ1QPflXcu4lQSD0K4aCKNWIs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqiM1pBE5/gDL3yeaYLb/u3+NUN0lJ1Jm7yD
 dhr9Bs+Z92JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 c2oDD/4nIN7uKmD8X7TtoUzgqt8I6ERo45qTgx5y97rcK2oMzB3ZHfcpvOM5ym53s9yqGcAWKHK
 xk9gCsdzlujh4pJ4RORm+629m3CMXJP0GP+SuG7FkW8HLdjOJI1381M4PwMmiUSLGthi+LenJor
 czET87j8cvXdAiALP5dCeVVJiOfc34obo6eijIkY0g4bP1pwYcyMJtumqQSyzziAj2E2OHhrLOD
 jEfVj8gITOZdiNzRavJtjgStJAPt8ZJR+0j4amlZGjFHrTcRvg0C47iiC3ZE2OVKvENO8bYvtWp
 EUCfmFfDl6zjOKxBclu/RFSgq/Cfkbr8MhN2j2dJFqRcZAbPn3Ck9M1JQtzYJPO4XabmCNX0fdG
 mQ77q+8s59S70/ukgaZIbx6u39WtMTyB8Qu0Am1Kz/FC0LBi3srZe/j6XuCQVyFrm7hwfTzKNoP
 Dz4EhK3JkEUwdwMLC9V7odvJ8BcgakaaIChMhFm3aWc7FDIcpMTSZJFM6myNcq9GJn/LawGIP8p
 oeOchGTrr8riNYXtw4Z1JjjEAD6uOfinrV8Co+dw2EXcY3seoa/+dB+Fdv66rzhpNFwQo+GwyF0
 wlpbbRxDxCf0Xkhg2d/i8btrCzMbpSShtvqvVYq8I4lT8Wl2PGxYxeFuH63oyDPSLRgocYEdUp5
 NWmqh4ruyLARJsw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a68382a4fe9..ac2f1a54cc43 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -958,7 +958,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (subflow->remote_key_valid &&
 	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	      (!mp_opt->echo || subflow->mp_join)))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */

-- 
2.45.2


