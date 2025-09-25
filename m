Return-Path: <linux-kselftest+bounces-42304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C948B9EB57
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ACE3AA675
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3672FE04C;
	Thu, 25 Sep 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwyctCYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6F2FDC4A;
	Thu, 25 Sep 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796430; cv=none; b=MgJvEGrNXYLZfKp18+g8BLx6xKp7tTvtBhsSo8aOY1aa61ePSqEUXb7J9Vfmf5puDPymmreuTL8f+ji8YAyq2ZQHb15jOVbsyh4kOJb8BW91GieLZHjlLToyRsJwbrxK9WquQTP5ZrO1AU/VTjCDVbuf+q5iQw/n+YDdnettxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796430; c=relaxed/simple;
	bh=jUq10qEuyfLCSOIOWBhjXeJWF9w/ICeF9gkl6mio7JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NbYk9XciW0B8bi9t2G9SIpbq20Qibs1epQqSXj0+DqNHXoL7V2ZZBxOYh+2xwIs6WAOFhMjMhiS8N9zweCicjKNPsjQuS2mGFB8EN0G308Hb0WOgxr6+0y8DL/vZwyWOIKwstkaIj8u0/ThKn+sQ9LlJBX50l660fJ6VburVHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwyctCYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DA5C4CEF0;
	Thu, 25 Sep 2025 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796430;
	bh=jUq10qEuyfLCSOIOWBhjXeJWF9w/ICeF9gkl6mio7JQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nwyctCYGiuJ9lnARJk2d3syFkvif4tnCcuLyrgPNFZaCDc9gHxLSih+Kz0DfmCc1j
	 F3q4FPJxqkE4twpMU4cOxpnRaHuWLxtWGll96NMf5arncHRQRZfM0k+oIqdTgukMNw
	 p2HdTlwbcVkGb2eUe/LVfMqlqLcyeS4YcbwpqmiqkiEA0ZLzc/ZkptPXKo//yE6qHW
	 Pze/3tWehjW+TCCsvatX8b2fPmbAumS6up4FGq2FT76cz4WSbKspam2di1gHKImcJ+
	 q9kwhzrtfl3FjwIoSZ774UFmV0Q+YqcGNXTB73/6qcJUP/G7twyOLzhKZ7me3if5Qf
	 cBWum+B/kpmZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:47 +0200
Subject: [PATCH net-next 12/15] mptcp: pm: in-kernel: remove stale_loss_cnt
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-12-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jUq10qEuyfLCSOIOWBhjXeJWF9w/ICeF9gkl6mio7JQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSiX7eYt4ng/clfbe/3Hc/OYfG4OT9bYonjL+7bJDk
 JPtjVdiRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERWXGT4K238ZuPJ90wur9fk
 Sh+QOKX6RMen+uKrP011GruULp+PdWdk6F24cu/HZ4WxnuEdd9p0XdatPGW/xXrGnkgfKxHRI9o
 T+AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is currently not used.

It was in fact never used since its introduction in commit ff5a0b421cb2
("mptcp: faster active backup recovery"). It was probably initially
added to struct pm_nl_pernet during the development of this commit,
before being added to struct mptcp_pernet in ctrl.c, but not removed
from the first place.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d30b06605f623aaaf38152ab6750841c5deeb0b5..0e1e99e72950f2432b33610047bc4aa68c5e75af 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -19,7 +19,6 @@ struct pm_nl_pernet {
 	spinlock_t		lock;
 	struct list_head	endp_list;
 	unsigned int		endpoints;
-	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
 	unsigned int		limit_add_addr_accepted;
@@ -1469,7 +1468,6 @@ static int __net_init pm_nl_init_net(struct net *net)
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
 	pernet->next_id = 1;
-	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at

-- 
2.51.0


