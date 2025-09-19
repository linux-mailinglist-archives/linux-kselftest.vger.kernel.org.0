Return-Path: <linux-kselftest+bounces-41936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314AB895AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D465585C75
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361130F92F;
	Fri, 19 Sep 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTIreopD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CA2F291B;
	Fri, 19 Sep 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283763; cv=none; b=O/XopHgIq9c4sV2gq3vcA4y1hFUSm6fH/8s1tC4UYKQpDrescjI82XqdPyfszB6sdMn5VL1ExIlm1AGMOseHMbwAJb1TNmkaTKwMYj72fSTxbgz3hebv2byZ/bxsPuzQuof/3TEfZFVPacA7FS9jMhwEo8w10dmgrOvNA2us2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283763; c=relaxed/simple;
	bh=H7NObkyvfcoRPyXEgtV/Spg1ML0gmYh6Vd5VqF7DHyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6W5icq0oWwczPFgJv+xtUretFQ1bX0tqjRn8icpZwDEx0IjNYuMbmgejuudZp3OhTf9tdjz3p5irpqZzfx4p6Dy9Xn9n0GFkTC1IJtI21dgm01/dzBygimPkWOAaZsMo/BNLxndHzWEaOMkk/P6l/SpBF3vxuekz8IqUWoFzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTIreopD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8898EC4CEF0;
	Fri, 19 Sep 2025 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283763;
	bh=H7NObkyvfcoRPyXEgtV/Spg1ML0gmYh6Vd5VqF7DHyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTIreopDXJ8BA0hQovsnOKIhfNqPqJ/s1fX1ngTKmf3sNNx5Jif/UvrhLyehs/KIt
	 23TU8CdII8gF28NQzHrfV2pOs+QWy5SmdFQsL5ztJIWa/X7Pkpa0G708fUdmYdeLkl
	 xK4Usu6YEAVmTbBVE0pKlanFqUHSw5C58CGkai49bMaEQKVQ3ISiBxc88gf661Mlu+
	 6Y9dv+JQaq1DaLUn9gK+es3ZFi2mTky3BdphFHyQ6yzvn+YuOEd3/e3O6t1Wss5rJw
	 Uxv43XIY/uxAQqz6cu1UwwT8kkeXf2lunTmOM7CGtoL0TnP2kfZZf3SSgniz4Bxkqx
	 g3zCABi8LRCvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:08:59 +0200
Subject: [PATCH net-next 2/6] mptcp: pm: netlink: announce server-side flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-2-a97a5d561a8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=H7NObkyvfcoRPyXEgtV/Spg1ML0gmYh6Vd5VqF7DHyI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuj/JiIn1VhH1KZobvUZwyQkz44JzBr8fHHDV2/Zk+
 3Z5rgctHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZ+JCR4c37jxeM2mcu810m
 xL9Hsv71afsJTRaV/Wa3DCqnmy9MqGBkaF27cZpa84/LRwokZgYdvXp3gvelAolZK848ZJkT4N4
 hywAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that the 'flags' attribute is used, it seems interesting to add one
flag for 'server-side', a boolean value.

This is duplicating the info from the dedicated 'server-side' attribute,
but it will be deprecated in the next commit, and removed in a few
versions.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 5fd5b4cf75ca1e0099e0effa351507d3ab002f1e..95d621f6d59810126cbc37b1d6baf896a40dd9bc 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -32,6 +32,7 @@
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
 #define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+#define MPTCP_PM_EV_FLAG_SERVER_SIDE		_BITUL(1)
 
 #define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 33a6bf536c020b59717472aca2d38add26255419..aa0c73faaa6acad3fd66ea0942726ecd4d0abcc0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -413,10 +413,13 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	/* only set when it is the server side */
-	if (READ_ONCE(msk->pm.server_side) &&
-	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
-		return -EMSGSIZE;
+	if (READ_ONCE(msk->pm.server_side)) {
+		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
+
+		/* only set when it is the server side */
+		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
+			return -EMSGSIZE;
+	}
 
 	if (READ_ONCE(msk->pm.remote_deny_join_id0))
 		flags |= MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;

-- 
2.51.0


