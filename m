Return-Path: <linux-kselftest+bounces-14532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3246942CBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531F31F21EA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2B1AE864;
	Wed, 31 Jul 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC4Ulg+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5671AE85E;
	Wed, 31 Jul 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423980; cv=none; b=n5crIwsjtL/02P+IrQLxmIppqTd3nHBHmwoYYCDeF7qLSz0m1gEd0tURx3QAhWQ+zCa9ia6OYqCsjCtV9OV379soFyB9UQYmnKWchiNEtzgO5IbDyFYQMEgoQjvyh0GAuYS3ITZS36An2/NrVojQGRHIhb8J75cpLBMxBLijVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423980; c=relaxed/simple;
	bh=FmkH0+f1Fqx4WtwJID1fgBwuFioKVrOh3mCO/tO4RrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMqbEzElKP+ks+2359mpP8VOjxaJrXobzYVG0NvF+Cpe7SNW5u3ClwXLPEJK3EemG8HgcH9o/oHrmEHo7QBPsocXofDuoAQuqqVtKUin2RdtX1LvYZBig7M5F+0Ckldw4HzaVwRkq3hU47INjMuggEXHnu2/vUlkhYUQlgdNe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC4Ulg+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDABC116B1;
	Wed, 31 Jul 2024 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423979;
	bh=FmkH0+f1Fqx4WtwJID1fgBwuFioKVrOh3mCO/tO4RrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TC4Ulg+Ep18OVuVjeJqfiIHM+AlZU1WKCBpGwlVjGdHRDSV4I+FKkLOEVQh57HTt1
	 FRB/zMftzBCFNTVoIJPyXi5ityL6J099RqDuqQubcPovJ9TlVzmdgyF9kcECwMBs27
	 j3ydHFgDcqQ6W7IyRnKWQKR0PpnJZuXQbMnaabyMdyjpE8li0yPlH1X/df5ZeaEK2G
	 zKTWPQN6BB0/ZzmalygLDYUlQmknPm3lXzN3Y53ZiTBHNvk3aHtcJoZR0p7S65ABK6
	 C9I4/kp31/fHH/453Ac5/agficbQtZOUZMVFx9vbjVViG7kpS6QSz2nwOGIjMt6v+D
	 1v3+SPBKiPI3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:54 +0200
Subject: [PATCH net 2/7] mptcp: pm: deny endp with signal + subflow + port
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-2-c8a9b036493b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FmkH0+f1Fqx4WtwJID1fgBwuFioKVrOh3mCO/tO4RrU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqiivhaBZFFCirPtnI6jP4wm2uKizquuPbib
 xIyyx1//iWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 cz/7EACEnXwJ1umzoiyD9o6ZCfopCepktNq5klK8Rk5aNR4qDozgW8JbjVHV0XOgKmlY8BC2/Wk
 WuWCpcbSVjUzfE1/CcPRXC5XsnNkW0CNByHkUsNW+K+IPzNrvZIIkc1hwuZ50K3Gc0M0AzU2heP
 5V+8LKYsGVdtJn6X97cwrp4v8NRricaFB0tgP58QsuOfsYuPDrN5SessXS2j6R9g9DpsCHD1C1o
 EMDzaPqxIPnUUYjq7wCWIs6fprzwEYfKK9XNN0zHrmAY/OI/DGvOXfrWqeoaC2qPfTK9mWW0He+
 ZMo4ef0sZMeaNkFlfDTcl6V5EFK2vBd8fkfDEGkWig6h9/CzuiF3GERIHpddrppjBNwWAvCLQ1Q
 scQavo/1IjME/xpr92ngC7YdLGN3gySCCeoyjN7JhU7ceEwxhYiIgo9gqLd6bzYtYKfkoYnyTMW
 Fp+LLhA2pQ+IxhodHyONLV87trUXki/8+ut7kPUi/D9ftZuezDg5nwuuvykUSMJs1ocGornoRuh
 4FQOq/t5e3/lQJ/GpXMbwUhoKTkDRVcryeiH18a6zocm+KSqMnVN33UuI7pUVdpe7vKy78N/mxX
 hLpew1Ux8MmoKqxv7PsginwfJEAc4HSAhEH6p9YZ6QGLYgKsWI7itcXtgQ/yK9Mi3VMQaWOJwGi
 WAUqf2ouyge8G0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the 'Fixes' commit, the port flag is only supported by
the 'signal' flag, and not by the 'subflow' one. Then if both the
'signal' and 'subflow' flags are set, the problem is the same: the
feature cannot work with the 'subflow' flag.

Technically, if both the 'signal' and 'subflow' flags are set, it will
be possible to create the listening socket, but not to establish a
subflow using this source port. So better to explicitly deny it, not to
create some confusions because the expected behaviour is not possible.

Fixes: 09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 37954a0b087d..c921d07e5940 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1328,8 +1328,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+	if (addr.addr.port && !address_use_port(&addr)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 

-- 
2.45.2


