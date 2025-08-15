Return-Path: <linux-kselftest+bounces-39114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F3B2850B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B0AE4590
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78932310631;
	Fri, 15 Aug 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9d4HPNd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CC31062A;
	Fri, 15 Aug 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278941; cv=none; b=Ql55M5w/YsEPISYS54BwwBmsMh1fOtLG2VIDbYgZJAEC1fyBbhUkNWfmN6UyFqGPlADBE34jr4sAbbauZtzOBJw0XY9iowCjaCZXvZL/SdMh2qIkhu/xYbi5PH9E6OT9E0eACojtw5q+VdT9KYMWqGsr4RCuZPpRgNor6EpJI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278941; c=relaxed/simple;
	bh=ua3JGiT4jYheiUorZF5N/JLVDKvXbPZiqO4sZcmEV0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZL2mNgBpdZL2ISQt5c2g6CyVmEQ0Ep1ik4YFHsfdUObl+FRYmyn/K5prDVlmg14MvWuU9nydSIombSnCDfRwL747fKCUZJ06HGiwhA++o5S1r7UC2Spb/x+U9H4YOav5VBWwrMizctZgZALn9r9bWPb8BVQcg0gxCuAzWqpCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9d4HPNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB91C4CEEB;
	Fri, 15 Aug 2025 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278940;
	bh=ua3JGiT4jYheiUorZF5N/JLVDKvXbPZiqO4sZcmEV0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g9d4HPNdBdMi0TKNdKc0gkLpdaiq7Dp+pHGdlk94290g6xgbxBMyt+EWtBEXI16Qi
	 i7JTsmt3xXEi8rONAD6/1sqqJEYbyJme+Ushr6X/Xa9o1DVD82eRegb24TrThrvDIF
	 3mJXWP5mhPdn5iXdJvA8iDk4TBwV9E3d8XuOlROKHJyN/3xMMxhaF/37ZB8kLG3pz+
	 pQl/CghsPtPjXku5dwCHrgWZFBhnb3OrerB7Trx76AHVkjzw+oABYZaWhDfK7U9kSd
	 rKw1gXYbTDZJKxy9fC2j4aSyVf2Emth16JVJjpPqupVD1vmkBeTqFl14O5WyNZCikU
	 LZhwDzf7wT35w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:22 +0200
Subject: [PATCH net 4/8] mptcp: remove duplicate sk_reset_timer call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FrXeJh53BVT5ky3wW9Bq6fbRb8TgEnUSVU2pkmK1AX4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm57m++iLLP3tfsag144yNdp812yLjN1UfaTO2ySl55
 abHV3Sxo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJrpjL84XzT8pg5/FH1bU6e
 I69W7d5u+2zjamvf/tW6DVbb6uPeJTL892h/1D1R9vvVzCet6o0V8+fqNR/m/mnfb12TEcSgYC7
 DDAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 420d416e2603de2e54f017216c56daa80f356e87..c5f6a53ce5f1e10dada52865e41b685d888a71fa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -353,9 +353,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -369,6 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 

-- 
2.50.0


