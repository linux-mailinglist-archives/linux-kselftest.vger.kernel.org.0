Return-Path: <linux-kselftest+bounces-16303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4395F5DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D7B20A9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393219923A;
	Mon, 26 Aug 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez6evKAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296F199231;
	Mon, 26 Aug 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687994; cv=none; b=LaYsBmDTGXpBqys4Mek4Lvq8T/h2oAyKOGTwu2nfVsQEXcfuoSj0/dU8dVv6yXeL7UjExl+d9HQuaiauLZ2mMRhBiIsF5Kmv5T0hf/1JABIkZyzFu2ELm7c20pDybxz2kqiNsbi3aDw4y5hsOpTCacZHGhGSPAr86vCoLdKHIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687994; c=relaxed/simple;
	bh=j7L54oZ5ZL6jITms2lQtOOeQiDYGlSxAE2X+7XTP8Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inFUFlVLZY+Eag8zhHZMWnwyf0ZM1RIAqv1sXDIyBBC3lHl09eUBfuOGIoXfAMb8N2lNKdFYOCuePK72SFMKN1uHPKjHi4cOKsjV7+dX97O3G1y4E6l7i8DsbHC+EO0r3Digmn+HVRZZxvGGU9IJbVzmr49CTrLh3Giz63UCd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez6evKAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC6C4DDF5;
	Mon, 26 Aug 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687994;
	bh=j7L54oZ5ZL6jITms2lQtOOeQiDYGlSxAE2X+7XTP8Z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ez6evKAXQG9DkFiPL87Ov0JZX3yRzuPCR4M43HJiT8OLdIrwth3pVl1ilSiXNQ4Qm
	 tH6hekqGm1XRgdkPPB06ZZ3nn+4NS85zAUym+Xl0Gd+1ijLScDBr+i5C4I22cdPcIB
	 X4DvYLkxYsIlXpLCobmmJWioU/7cIYikcKIlnIBHPglOIZr7pQlqqf6GQFqTgoenTd
	 76HZQhxSt9b6B8dZyN6ENIbGBCxwRui2mmisqjqWNFDquxyUewJc33sRCdgNCXqUAN
	 Tdkc3w+NAIPLfbrdUxD1+TdeBz62Xw7rk+p+1oAehX7rjE0skPh0XOntNx2Mnj9kPg
	 Ksy3ot5XN40Og==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:08 +0200
Subject: [PATCH net 09/15] mptcp: pm: do not remove already closed subflows
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-9-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=j7L54oZ5ZL6jITms2lQtOOeQiDYGlSxAE2X+7XTP8Z4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWmYh1TD7NzbYV1EDm90ceDNlnet6jA8MEy
 6HlqSU5d3SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c9UcD/9TVwYIZHzIap9G/HUXS7mVd6F4lfxrPqyE9kRRx7+DhyDji863NKZNNIhFJy4hRQ9KJiI
 HebxocXDgTmP+qmkNep4MKtfEojwUKdUK42n9Bu+XKmZAguv8pY411d5ASZ0N1i3fLqpSTgn1CH
 gEL94q0CoWzps7e3j1wzGRtvBSNzLp9Lh9jFpNfJPMhzmnPhQ8TL6e64OKLbKeytcXER4uT8ZvE
 ijKlkC6d6r+y4SacwY6mwGWM6ydzgBU+wOaaWYeCWY57oGQXynYqXJa0XhvVua8la2mwjdb22ZK
 mq5W6AZ2mx4ez9NIaupy+OHCd/gppsuHQ77dkzyBizQfK+FlkCEx2kSbIUnX+O7JwY4Hzz7Kk0y
 Nu6m6pCgIiAKIsOiDWzikx1vQjy5KHzRNe9lPEymyiGGcnMSK+UmXn0lT6C+7teZvkGq4vwnEQE
 gdwi/v7+FpipzdI4gn8K8JvfH2c9vpz0/exDSU05Fv+2VOg5t6BUpGZw8JrV15J7czCr4lFu6XL
 xIVBwtim6f7Nvw1Y1CH9PjGTjK3N/pnteeTk8QcEYxhClLsU0NR/14R7Jm+h919YvJL0MPBRw1h
 YKA8b8jLHsaF1XkZjAJOgiYTWlmzOo/w9uMdrUEhpVxDwbE8FcFzv9DFAyXqBYohq64qAGuC0Us
 qrdM3ESb/9PyGxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 75c8aede7026..90b7c8b45027 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,6 +838,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)

-- 
2.45.2


