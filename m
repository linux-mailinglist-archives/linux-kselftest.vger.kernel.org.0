Return-Path: <linux-kselftest+bounces-20252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A519A62C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53E41F21CD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7C1E6DFF;
	Mon, 21 Oct 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZzbSBQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3681E7C1D;
	Mon, 21 Oct 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506342; cv=none; b=tLie9bEyrbqirB+iUT8fk82C+4eyTYvMu9niSPG5F4UDyBSnNhzc5QqpdUl6lOaBPz6XiVy9F1NWJS6IRtO58ufVhVm1zO/GWYXm8q4OBCWQW0oEYJKX+H3zOvHoepv9PHvBYYlBTbTrMxfl13X5rXpNZ+OLA22MorDDuMO2VAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506342; c=relaxed/simple;
	bh=sc8jhN+g3bazvvXRQ1yzerYMsmvb+DSO6M7l748KWNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZtddSxGZM46qB/sPPR7Bk1RgAG/dHjh9YS4BJ8pts+yQAd0Ta1gG5GsaDNpWnO8gL0elrQPolUMlxi/YoSNE8E3hn8mlziMguWGltAzEtApdQlOHKw3qidZKCOWb7NvjXFj4AuGqUa9xUfoI5j67vyeMx8braEsUv5sWqtHFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZzbSBQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE7DC4CEC3;
	Mon, 21 Oct 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506341;
	bh=sc8jhN+g3bazvvXRQ1yzerYMsmvb+DSO6M7l748KWNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZzbSBQc2+bSfBSa+YylekSkUe/WIi+qG8ZDgwkdxuGQ8kmGGyHGHaKmfe/13z//T
	 SqU/Ry1n54mntoVKwejzzEbkE2CCRBl5j/DcPbXQisLXLEIPYhbaQHuKZTNlyGjbMV
	 YLCHEfaEKRF8J+Qkazzak7MwZaDLfxiJk6aJAi7q2TECGq5vTaBfAmcSZqlYGHZfLc
	 9KKWmH00Nx+5ZaLQcrPoTkotzRNSd96TnVfb7PBwGuxO4KbyULReI1hYCysjslzFYm
	 x7R7/qVUHKjQ3Nf65vsBbWn4I0DYKjdb5Kw/FJWzW2q5iuXW0KwJqy1DebiwHgk0YT
	 r4/Ljx55HWAdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 12:25:27 +0200
Subject: [PATCH net 2/3] mptcp: remove unneeded lock when listing scheds
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sc8jhN+g3bazvvXRQ1yzerYMsmvb+DSO6M7l748KWNM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFiwb5DB1p3KgSrPWEztR8Un4u7jVwmAXFuTBv
 n3DLRPi+ZyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxYsGwAKCRD2t4JPQmmg
 c+uHD/9p62xCprKBXbWLdGbx0fgrK90+4dPS30lanUOsqd6/tyuiaMHPIsTfpMdaWYaFLfXBQct
 4wB4bQPmFaMV9zNdy5BNDR+PjAQ4NBrKzc4vVPVzFkMgaHk6ivnJvjOEDbjFlzUCqPdQS/Mh7ne
 ceFwVCdwDb2ao87QuxLmvIlT33QfaUgpJXydKmqs0hK4utjxOT1cH1DrkkawI+dDMpaLQVPkZ3D
 qXuc2Jre25UaylEDUMyft3Wlf64jKK1NlcuembIyxkT6PugriFjpit4c4qtrBp6wJXt8/1aMxzm
 UVAAWaBo+KKlJkx8kifoWh64fzVwEAu9MuivFm8Kdog0c0TqaYYuyGg2YCgHne+0Ubed3DZkLQ8
 RtcOMDFtgmPdwDC7UCT1q4b+5lINxkoshqzMQl1VrLdDT1NIkD3+SZzhNwUFlY4SvO6XkRkEAmt
 WnC0+z3ZFKEu29GMx9D2BLVHSLVyP98O5kA7E/Kk2QdJl29GSFub8wieE4MZgSpeQpGMwIFUdPp
 FVOezhbF8GxSIT9zN286MLWxjpVTzReGx5Hw4UeklfoCKX493VULNrUoKDry6qXsbhgoDgFgSSV
 b2AotkxrijvmYryQXEoR+LFgQJM7VUAKAg/++Thk2sOFpKU9sGdIU+0BtTYek6WdnGbL7XxHMUH
 9xI4guGWM8AjipA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_get_available_schedulers() needs to iterate over the schedulers'
list only to read the names: it doesn't modify anything there.

In this case, it is enough to hold the RCU read lock, no need to combine
this with the associated spin lock.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 78ed508ebc1b8dd9f0e020cca1bdd86f24f0afeb..df7dbcfa3b71370cc4d7e4e4f16cc1e41a50dddf 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -60,7 +60,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	size_t offs = 0;
 
 	rcu_read_lock();
-	spin_lock(&mptcp_sched_list_lock);
 	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
 		offs += snprintf(buf + offs, maxlen - offs,
 				 "%s%s",
@@ -69,7 +68,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 		if (WARN_ON_ONCE(offs >= maxlen))
 			break;
 	}
-	spin_unlock(&mptcp_sched_list_lock);
 	rcu_read_unlock();
 }
 

-- 
2.45.2


