Return-Path: <linux-kselftest+bounces-14304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5C93DE8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA091C21409
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380B6F30B;
	Sat, 27 Jul 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8uTqsdd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD316F2F4;
	Sat, 27 Jul 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074610; cv=none; b=E2q6FyJaiUofvCTSXktmE2qrDvpWT6M+2/s0CRZnsiIPN0aubgi8QDIduU+HTzYOH1+gyi3IvVkR5mIC+B6MMfk3+RUvNo+yzt0iRFBC6WuJnMJ6iksjDdQGR9ExjO4qsNuflKrQVrrSwjbkPtCqh9v7lu/RypU8VQv/RUY6Dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074610; c=relaxed/simple;
	bh=KregD46JHMeDBGYPvMEUJHE+xqSjZTW69dC5EAyRguE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAiKIRKLwuQdp+4nggA8jhIVcHnMZM1cpFj9UzffpTjryCwvTWmOhJzjzDyvvIFk1bTOaSp+VVDE5hD1jobCjT/su29ID0XKho4/8L26mPUZIT5BHSbEog0LtI/YlBKJ4S9tstjvgbOJl2w23/thkgSQ7zom/V7M6H/VwoE9qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8uTqsdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93DAC4AF0E;
	Sat, 27 Jul 2024 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074609;
	bh=KregD46JHMeDBGYPvMEUJHE+xqSjZTW69dC5EAyRguE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N8uTqsddRqHiS4SyleUuB9hQfuSF5tiFwWCKcobuXYv80fRfxJ50GIHYWxQ3kUIKi
	 WrKJc0np7wjPPFrWhY1fBWay3C4SodlWz1gZ5mLCMnWw9uuVVW4rQxJVds4WlU4Vvt
	 s9GxuegDiAOMgitGWOjxtc3Z2Wlr1nLChh5Ffgw77upHq2HRX6oYWwEIOEpRSBrgVo
	 ylsiEq6xJEfpSpuP/6Yt1YvjHk2PLV7agtgyqK741MiEZJ3I/Uxzp8/E3UFcxIZ3QT
	 LYZwH0NYkH+1FqWD7lJ/i56I1jm6OV0BZq4hbYOsMnXhkwg2W+k7ge5o5HRUeEUDx+
	 e028SongCtLng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:24 +0200
Subject: [PATCH net 2/7] mptcp: distinguish rcv vs sent backup flag in
 requests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-2-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KregD46JHMeDBGYPvMEUJHE+xqSjZTW69dC5EAyRguE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXlc7TT260ExETbRS3kGsRuQLDLvefwiewI+
 kNP8iox3VqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5QAKCRD2t4JPQmmg
 c3OwEACNtET1mfVHYlMCoF1MiI5UUqOK97bld/5Ao0EMbEKukaxliiOW+rQYSXzcvI2PecAXjPN
 Iw+P47TWc0ynwGEEpY88o8hjdoi96zHXrQMDDsdNr5ZPSshH9xBQraoUjGHWnYdrn4i/JbizWYD
 FyiniDpTEFaeVR2LZiSrFU0Tb9Q+Ua2Wihx5AMwUJc+f13dRMSn8XcUpuzU1tCP9qgUNyLXtG4d
 0KofJEDF05e/ydNPWf8WRi3CAsGB8peumWQM0saSWVFO6ZGVnPUmZKfMEozylfsQbH1n4h4EJzf
 uTVf+7mfv6WkiO6DAE7UQq1cXAngtcQQHCbLR0xGiT3ozZf3FkUb+ZbZLrVVkE7JuTQFPSok97R
 6TrUYNV8PrWiM15oNd4BJgpm0kZjEy1UrSVSLjaiCe2/dngNvyp9AvZQUhGsIMzfyKeNCOWAAD6
 HYLQFcWP3L1HPy3UCfHZSrXtS/oHG5UQXoKqyfZrZdYwwR/iVex4XALtdA7nQHaqctjx+8n3TFo
 msOvt/jER2wcuVvHOVTGGm0d9/TSM583F24JRnLLGYgwg7FWg18ViXhW3jyWYZvtINV0nS8UZ2D
 cMZHvi4mYRvBBWuri0cvb6tlWeORJnlilJvsqvp5T0zmwRv68ij/cn7amPtJaFrTZ0nYQ0Y0XEu
 M8OydleRTaeLxCA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_JOIN + SYN + ACK, it is possible to mark the subflow
as 'backup' by setting the flag with the same name. Before this patch,
the backup was set if the other peer set it in its MP_JOIN + SYN
request.

It is not correct: the backup flag should be set in the MPJ+SYN+ACK only
if the host asks for it, and not mirroring what was done by the other
peer. It is then required to have a dedicated bit for each direction,
similar to what is done in the subflow context.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8e8dcfbc2993..8a68382a4fe9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -909,7 +909,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b11a4e50d52b..b8b25124e7de 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 39e2cbdf3801..a3778aee4e77 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2005,6 +2005,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;

-- 
2.45.2


