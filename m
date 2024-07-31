Return-Path: <linux-kselftest+bounces-14535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3C942CCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6EE1C2147C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B11B0121;
	Wed, 31 Jul 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXQ0o2Hv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396C1B0115;
	Wed, 31 Jul 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423989; cv=none; b=fFvY5a4z0VX1gippA2Vf5G/+eQX+18jSZ/H0sPKl41gaLBtZeVYn4/7DP4vX/R18pgpKwMG+rU+asP0of1ueUMpabqe5JHF4lXPxtr+9BhHaC5Li5p861t4GNDgKa0PGGY+WZDa29ds50vpCkx3GZd5hj3GesZJ9gmrrev4Ic58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423989; c=relaxed/simple;
	bh=vSxE9dZVA5Q6GagAMbC/uiWZrzBxnN5FNeRgFv7dSkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxsbTaLDyOlkKLOt8T3JP2K+ruEF8Fk15tjDOvGeafmh3/yw7VkOLAdycMarvipVat1F6MIBQe5TMuoNk7oT/iE6ocOkFb33AMy240g/V9NDJ1j+7BgFvqyj8XI6GNr2Hq8cKngWZMxRjwS4WJJ28SjoiOcips0zzUI9nkCA+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXQ0o2Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB5C4AF09;
	Wed, 31 Jul 2024 11:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423989;
	bh=vSxE9dZVA5Q6GagAMbC/uiWZrzBxnN5FNeRgFv7dSkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GXQ0o2HvIsiHxJi7qiok77XRnJPOreCqL1GIk2Pk2DMFcNSZ8iWMCZObZAqTMLePG
	 JvqCzfkY9RsmKgdLzBmSjdv2JHCFNrvgNjfHs4mJtAEfNjwqADWPtvO48+EvX9hHNO
	 Js5OTZ/qB1K5s7dBe+/yaNA1wHz0ULy5pQV4eJh4vk7QU7PtwXFKVaJnRfkCCKmsGk
	 eDfDdXQ0y7GSI2DSql9gqLAAy0iyxA2IOerNHQNhiktRo8/vprCDQFq/fersoZVeaL
	 O2yALOj0tRkWD4WchRJOdZ32AoFW0L3w5GQZcXt53no7Q5YVfnlQGh0cu8ACxC95NZ
	 kGcRw1EcduZYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:57 +0200
Subject: [PATCH net 5/7] mptcp: pm: do not ignore 'subflow' if 'signal'
 flag is also set
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vSxE9dZVA5Q6GagAMbC/uiWZrzBxnN5FNeRgFv7dSkY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqiJJixt2T17TbHTeIvdJlCr3A5AFQFcvdN3
 Pa5IBG39xKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 c9OQEADX6153k9W+4S1S4qaARvs/quggdZGgZfaQeSPCstSxk0klZoNIIlwUa84dpgBpmIJOJ7n
 0MReIIULkJUDYQtNBHeb6g0fz49Q+e4rHA+txEv3BeZZg/R1xbLzoOt/N3eTJk9gcDdU6ZIRmby
 vjchFAoAdXpxNT939DW3w87wg8qQ5pMZrRwnU2uYxZUDmKa2/kmuGGQzsaVVrQQdPOnD4nU7K5j
 ZhEa8GXA6m7tmVCRf3AmHlQVlPbsVDkXRM2SZkAf7LKXX5Rzcj3YVpzNmizoSumfA8OmKSqoFE5
 d4O9i+0omuUpfx5/ns3UkXH0G1g/eihmQ333G52q0PTx5mW9DhU0tH9LZ6fHzK8ItyvpPBpCHeZ
 PTmFWTXGhcp2jwXgdWbixZXguSwQpZO9ESRzA43THA6YRSzP98bUi5ZH1GJB9w9oS9YLglYmyzz
 FmmGKgJrWqi8bJwJy5aXK5sDuM/ikFqqgvqZixM7cqC8dD3MIYEQI2EhbKs0wPD39liZo/NRIPq
 fMFU53IQTNm3RYXR6al4Ww/OvcQTcd0P0m5qVWWe1voiwioZjlUD8OvlZuvTdj7jvaav0ZbMNm7
 mBT/pXl9TxLsTSvjHhTONTfBgE2FPgGVzbiSXrYMSvKsSepA9L1evyc84TDd3JB8hORy69UzEeo
 CPLDqKGYPLwESkQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2be7af377cda..4cae2aa7be5c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,8 +512,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -579,6 +579,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -589,9 +592,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 

-- 
2.45.2


