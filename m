Return-Path: <linux-kselftest+bounces-5373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB42861D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BF4B21C77
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB3149385;
	Fri, 23 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfZNbvzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8701482E5;
	Fri, 23 Feb 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719549; cv=none; b=LUFrrrSSP7oq6UiB2BsES0Uk4UBC7QujyXYYzsMaO+bayq7M6h3LBDF0XQLRC/nLk/eFTpkffDswS6HlGLT7Gti6U6c3b6nO/AlVmoxKqN/ZrlFMEgP28z27MA2Tb/QqBAo4dsEommAMlPnB2vThlp8voZl3Wg7S+cU4xjuKNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719549; c=relaxed/simple;
	bh=5XbSbQcot76vzj51X+whLVWkOCVpbJ7qUINfOKnN9hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZSVm+NF/ImYSnhHS39+ltwVxRPef1zdecZwrJ8xbO1upc1bJ13pQWe5hSDML+D+WuyCdoVQbf/maEkZFVj+2oAz0+0jN+0ZYV5Wb6FbHmpgFNyIpZqO2mukySDz/7ZZ5qdNt+y9PPc6gBP0lPpVYMnu3Bq4Y7UjGlzEi8+XYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfZNbvzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2733C43394;
	Fri, 23 Feb 2024 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719547;
	bh=5XbSbQcot76vzj51X+whLVWkOCVpbJ7qUINfOKnN9hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hfZNbvzdZgvLZ1tTNkjehvObdDMPeXJRgHniT0Lqqs0HcJCJjHcC+Ue9kSe3l0X1j
	 CrD32wlNKoh2540oQLVpVPpAoOIQtlBYfDph/eRH4HCqzuZ/CHlILT4vzIobaoehu7
	 T3ycpDbWI4QOrmV5n9dU/ns0s+l+ZiL8Ys4xycG+Br6IfZ3ST8rLNrb1ojbF8MJBnu
	 Ave7Ny4Mu+YmVyyyfxi2Mb/7mD6sUnTp80+7QE2AiGszZjRuoOoJUL1rTxCGmSRCST
	 3tBY2IBeyXSZSDKACt8Z/z2qLuuzSYAGN2yeUaBGFSCeLzzf617lP4aXmO1cTR1ExY
	 IQ/+5NAeHgIvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:55 +0100
Subject: [PATCH net-next 3/8] mptcp: check the protocol in tcp_sk() with
 DEBUG_NET
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-3-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5XbSbQcot76vzj51X+whLVWkOCVpbJ7qUINfOKnN9hg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qqgyGZmRgipL2S8fnVMnKdCwOJ6MnG75o0
 IF3dBDDlmaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c7p8D/4/9mO6jOvdkRSma6O/NWv4g3f+bULreS5iFD32UZeJOVBRE4DmnSyRfcSzG0BmOmnMl3/
 6myuP1ffuXtLyGF91dzbHHPFzO205edTjX94iNQhR+p3PHygYwDQ+pFongXYnBvKnbgcnnZIARp
 mLjA1TP6uo6wLs00TpzCT44S/Nsiw2lrIdGAGGu+3nnh2BtLY2oh0TJxQy6wS1EGdp/PX6PoMhU
 bmnFbgaT2xSXVmVZcrtTt7fk9FBxhltIMRAam0dVEN+8TIW4swCDGjiB9uOK/4z4qvwVmrns8rl
 5s4l3DlQzeijAlC0ctIPR7i67NG5rltHh7zxxQ78Hra9SlWWxERSwislWK1T0zFYAyylozkNMBB
 7I4WUPlzki0rtfKKDzB1ty7MbWJaFUvGGkTpzKcNeMhTxb1bvbaWT5aZtFT6QGPWpe31FkTh2Np
 1hKju4Q4vhb70PmL33zNwIBcYZo/6jCKiPnPoh3dv1CW9tnLoh3+ZUeR8adzvT+d/Aa/C438b8c
 LLvyrT3CVZJCtS/+bpkNJMooi/Xt6KRJt2hDMX4BHmu8rbt8LHMHd4PowHeHpzuuqXn2yQqbpO3
 X4lXA5iJrXRHN5CsV5WzSxDyhH86G+LIkgehxwK1d0bJAWDFHetUw1wMaDkMzbHcbCbz/Cqglp+
 8KS40rWsTxfV1/w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when tcp_sk() is used with
a non tcp_sock structure.

This kind of mistake already happened a few times with MPTCP: when
wrongly using TCP-specific helpers with mptcp_sock pointers. On the
other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
sock' pointer as arguments, and some of them are only looking at fields
from 'struct sock', and nothing from 'struct tcp_sock'. It is then
tempting to use them with a 'struct mptcp_sock'.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-TCP socket is being used as a TCP one. 'tcp_sk()'
macro is then re-defined to add a WARN when an unexpected socket is
being used.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f89b197a9f92..026ed360bd72 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,6 +348,16 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
 
+#ifdef CONFIG_DEBUG_NET
+/* MPTCP-specific: we might (indirectly) call this helper with the wrong sk */
+#undef tcp_sk
+#define tcp_sk(ptr) ({								\
+	typeof(ptr) _ptr = (ptr);						\
+	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
+	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
+})
+#endif
+
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
 
 /* the msk socket don't use the backlog, also account for the bulk

-- 
2.43.0


