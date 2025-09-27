Return-Path: <linux-kselftest+bounces-42539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98697BA5CE3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710504C6B4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF392DC331;
	Sat, 27 Sep 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc/oP+wd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB12D6E60;
	Sat, 27 Sep 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966081; cv=none; b=b+oDnipB27sYcWYsR4CwC5RAOaDTxTO+9KueeE39rzuK5gREEPdz6hBCsrF7RkQf2Mu++WmyXWhg7sgovh+bPuwQYmQpdqBeYQrUInb3EJXHY5CC8OtRVlT5MdPCBrpwMorJdQ9q+6UVLCgOYyNMEy5OcPNalOT2t86QeFD8rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966081; c=relaxed/simple;
	bh=uK4MTHtrQ6SSERaqWiaD+OwnrKXL/vfvHTtfjRnIhoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QasK16P2R7iJaqenQyVp7qoAF8JTTx1cAHLFSBfEy9QifpKTfF5DmUdHj9F8waFQ3f4eGlidIM4PZIJmmTHXyhFCIM2d4j9NW2Z2VyDydKcMrRiBAwycaEPUVURDpfuwZEMF9WrxCfBTY4WNUE5VK636Sl49msY8VF6HpCdx7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc/oP+wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB05C113D0;
	Sat, 27 Sep 2025 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966079;
	bh=uK4MTHtrQ6SSERaqWiaD+OwnrKXL/vfvHTtfjRnIhoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bc/oP+wduWCLociejsEq6sffhFWTRbGsRK+vQmRegtwZP4lU3ZKYW1DuKAs5OdUPJ
	 9GT3GSi5DT0neV9XQeWOcizE0gEdnXkHiFJXzsNcK+ukBamP77pw+5zXfaVvLGx0YP
	 q4Xtqz0WbKvPa3bCUcRQrfIRKx1o4NEhCrqT9LLdjN8ek94YIxNquKN+ftUxVwZ1PF
	 DzY94DIMNW7L+9+NYnFpLPFdYrDg0yAmD5sCATrs7xUmvJdZU6EnURLGUWugMsbKRh
	 TY67OrPFL3HOlZWy7QOdTbz4Kz6CYg+3aMjxtg9D3RIBKt22y69plB60Fzz9k/Ctm1
	 XpBW5v5ypsUuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:43 +0200
Subject: [PATCH net-next 7/8] mptcp: minor move_skbs_to_msk() cleanup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-7-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ebLihUpgIkWVECJiN9CNG9hKMwQHMYtGGDf7BTsq9yA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub1RpU51gIF+3TcTcSm5vx9E1YsYZ5Z3sJ99NFpvwo
 jHg5GzpjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInMn87wz07n9MX1RWFWN67c
 yJu/mUuPK0jLVduW+43K8qOv9a7/aGBkaDPZLntjRtbzFcIH9jAyGTOuXmXZYZ4zuX62kri/UKQ
 LPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Such function is called only by __mptcp_data_ready(), which in turn
is always invoked when msk is not owned by the user: we can drop the
redundant, related check.

Additionally mptcp needs to propagate the socket error only for
current subflow.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da21f1807729acdb7d9427a399af66286ed125e2..0292162a14eedffde166cc2a2d4eaa7c3aa6760d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -814,12 +814,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 
 	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
 	__mptcp_ofo_queue(msk);
-	if (unlikely(ssk->sk_err)) {
-		if (!sock_owned_by_user(sk))
-			__mptcp_error_report(sk);
-		else
-			__set_bit(MPTCP_ERROR_REPORT,  &msk->cb_flags);
-	}
+	if (unlikely(ssk->sk_err))
+		__mptcp_subflow_error_report(sk, ssk);
 
 	/* If the moves have caught up with the DATA_FIN sequence number
 	 * it's time to ack the DATA_FIN and change socket state, but

-- 
2.51.0


