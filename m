Return-Path: <linux-kselftest+bounces-41940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FEB895D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3431BC57BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9743112C2;
	Fri, 19 Sep 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Uptx72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1A3112B4;
	Fri, 19 Sep 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283774; cv=none; b=fkSgm8zlxupcMSDNI2u95VaktAYm1x/zmTtIkMYCft/KI4veIv9/Jqt96aSrHU00Vi7qyh3eAanhrAcZ0hTr/y45ZtQeDECZISZLwTEWJiWXji0ugxo9zfXq1PWfw8socl/y6jCj/jbxN4EEeC/lTwX1/KtpwZHNRyVty88H74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283774; c=relaxed/simple;
	bh=VEFdLyXaaEcCsg1hodeJ9zVfvHkzQkxNGmndJdo92hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXxvV5choTi1vZNVhA8L/LtPDhtHN5E9PH3YHx6s/EEZ09zPeCzwYWQdGIK6JxgXT1r7Vq9AqFUTZrJnV3iNmMyUkK0ydBaKLyOTbpnyBFar4k2E4kr6PaVPjCiY3L2Jcz2lI02y3JdVLmR0LBAhl4iapsJmXmQLgN7p0YPk1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Uptx72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8636C4CEF0;
	Fri, 19 Sep 2025 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283774;
	bh=VEFdLyXaaEcCsg1hodeJ9zVfvHkzQkxNGmndJdo92hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j8Uptx72Xu4CP4JM/5upxQvtf5gq5kX9FXELtlFdovw3sR69XywHKGzzw+2u7DTHm
	 BJmlWvQ8gPIbY02AiOXtYk8SHy+94+LV/lY3ap+mHYKkweCDcqIJqZHvc+wy/vhM1L
	 NRxV+r+YqbmK1H7FZwudURMJptO8ZrUFJWdiLQr0Y2ss0T+cWbJG/cOJxXxAWJA9i6
	 vkJUjUms43FFOxlKPA5DcunpIXn9yfMoX31yT5mKtpPUYyC+6015r76AYR/vCjvibP
	 Gda1SiuK/a4k5DrHI4pRxRyV79j8z2G7y294wnhe9BrjUaq5Vkw1lGpUfJsK9Z4GFh
	 dt9HRiTmGCvBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:09:03 +0200
Subject: [PATCH net-next 6/6] mptcp: remove unused returned value of
 check_data_fin
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-6-a97a5d561a8b@kernel.org>
References: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
In-Reply-To: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VEFdLyXaaEcCsg1hodeJ9zVfvHkzQkxNGmndJdo92hY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOur9q9d++k/HjT5PlR4rT3KWdCier9TCX/Xu1e6fH3
 DXzUkTKO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZi48jwv1jyne7H1sduIgcu
 au79s1tz+6NX9vPC2s7kG/1qPmf9eTMjw5rnfKsPlBctW3yf7coH81mWrpq2Rmt+3V159P0k3b3
 u7xkB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When working on a fix modifying mptcp_check_data_fin(), I noticed the
returned value was no longer used.

It looks like it was used for 3 days, between commit 7ed90803a213
("mptcp: send explicit ack on delayed ack_seq incr") and commit
ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").

This returned value can be safely removed.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d9fbddb99ad0fb53f160af7654433a12c609ee25..735a209d40725f077de1056de5e1c64ffec77f55 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -545,11 +545,10 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 	}
 }
 
-static bool mptcp_check_data_fin(struct sock *sk)
+static void mptcp_check_data_fin(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	u64 rcv_data_fin_seq;
-	bool ret = false;
 
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
@@ -588,12 +587,10 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			break;
 		}
 
-		ret = true;
 		if (!__mptcp_check_fallback(msk))
 			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
-	return ret;
 }
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)

-- 
2.51.0


