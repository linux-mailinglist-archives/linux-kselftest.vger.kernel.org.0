Return-Path: <linux-kselftest+bounces-11385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B9C90081F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C2CB270CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4E199E85;
	Fri,  7 Jun 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3dtdi9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48301993AF;
	Fri,  7 Jun 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772537; cv=none; b=MkvJm62eppR6USTU7/8z/u063sYdVqng9imPOhCAsf8WDqNZFZF3HpHyT09QWoO0nmzanYtTN+XLt10Y8HRxUVOals7fH5HKXM34l/jMoOH6vL6KykKTd0INqlCGCdSw1mENbjf47S8337ly9SVOawIqCcBSespRZQT/4qy38ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772537; c=relaxed/simple;
	bh=pYJNoB2u1ZqMObb+gIcRRwqEKrEEAYdKPGc5UfseMP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnuoIr7HlHZyZOQUd0OMHqU3YzOi4wGQm1WN7Q81fxCKqVNi2ro5zv5W0tOEj9J3THt9BB+qxsumJk9FoyibTdNRkjNbtmuNecwagHTTytGTWkTHL7vHJPkw4JPLrip4F3usLYs8lmUBI3//W4S55Z01wLvrqhJyHP9M9fUxY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3dtdi9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56597C3277B;
	Fri,  7 Jun 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772537;
	bh=pYJNoB2u1ZqMObb+gIcRRwqEKrEEAYdKPGc5UfseMP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M3dtdi9mUjtm8N+238H1NcPMhSbL/RJ4OT/Mtk4Bf40zaC2jIx+defBoaMm2w+w3F
	 +2ttwNmWnkzd/fgyV1jru7JDsEtQISv0Q5lpDLP488zB1C2/V1q6Q6TbSgS2/z41+j
	 fDMGDwTEDk4J1ggdSTLyaHbh5A+ndfu6L2xgXle4Fo3+Rk3ZrKwxq53DO1jWFojqCv
	 ig02H9ipxPHI8z38s6DWekIciYu3Mx+X3+GRBnjPHnPbR7OSZkrCnMWCkME/xEzrpy
	 C6yDcSrYje4AabCNg8eLbQf3x9P8nz9G+3feVyqasqgPbvfp3nyaR/Mmd934NyTDa1
	 GHYm1ww6tsaWA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 17:01:48 +0200
Subject: [PATCH net 1/4] mptcp: ensure snd_una is properly initialized on
 connect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org>
References: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
In-Reply-To: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PfdPd1CZLVPmAQl+1xZ78iEyztMBE+4I5rQY3Km+0kE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYyDy6NeVsQvpbGo14NOqTZi/PfttbvDw/or7B
 hL5j/ruY1GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmMg8gAKCRD2t4JPQmmg
 c1dcEADORAJ4oXPVG4UPn9w/yCDwvL5Fyd1gVVSuLXaU6bLYhCcxscq7nRW/KKAjR3D7NGTLSCV
 HDGYFThEosOr3CzqqcDSco5denpV3jews85JNm1q8/bYhpCKRRSGXqf4gWVs49NzRnBaGAWDJ3W
 k3iEOzWfcPkjKILeb0mkIawct8pfi6QoYraMFy3Dsd7S51K/egDbNIU6f/9qTBDJahbU0u89Kz5
 Z5TJvPVMI7ge88KQTDO2tk5wt9b71JeB0ltY89pqc+nftvC8qDnVgfeIr5BtktmjsSj5s41Wmpq
 cCDKxW2uZQqtBvvYs/NtWmFpP8RtiY0pv8cFS7lUK2KYHVW5SkoYbJomEZU/Bu1Dw3giQxdSkkT
 6RPDWSNucwJ56LbnxELJojvW8djN1Jm+ugL5RKzvP6h4FHn0fJ7KGp5FeaZ1YXpdkxw4X1HoEiv
 G6IdV3l1lbAd69Fk9X0431biHR2HAHiX5V9jJlBxd/a++c1CeDUdEPBKQglvpz7KoMS1z5yYv8V
 DaVrPtbpNMcDdr1OOc0Ot8cFKuijXfvblPCghooMmxZP/0ZWy/rJOYgE4pp4zcxLD1Ckn6RfYsC
 oCPULTeG8HbENfANDylqni4MOTCHVe5dEjSxMjrgmThqqVK1dw/qBPvig20nMOXA0DbbEDogXfP
 jscIz7Ifr2RS1/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 96b113854bd3..bb7dca8aa2d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3740,6 +3740,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 

-- 
2.43.0


