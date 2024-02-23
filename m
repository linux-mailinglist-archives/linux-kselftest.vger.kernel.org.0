Return-Path: <linux-kselftest+bounces-5374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E8861D65
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C64289EE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E7146E92;
	Fri, 23 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRRy/pWa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A81146E84;
	Fri, 23 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719553; cv=none; b=jah+GJd0SGISxYpf2k+YN1C6VOq9sTxwD6FXCjremm7rPkDQu7TX5T1fwCgpk/RKt6Kvu65WZUpiM0tpOSoes5nPa+3v8rFXjXFr/WxhrkRTAcvJD4A8wXTH65HFLXr3iWcgAbJffdiyC6vQmSdmi/nSN7KI7H4VNMFz7N1Nt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719553; c=relaxed/simple;
	bh=CUxFDPyTjDPgcgfn5h2C/Q9GGH3cNDWmsoWlzMpvK6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbWVRHMswrH1OJKbE54wQFgZlXXsIutISovrDjtZvI6qaK2jbgb+ttJIDYfTjt1YFGhy4nvIhOpP07LFRLCRqgbkArI8MUI/AB/jck9RRrk55dYd4arjnFm0QHNvvCgSzLQaisCp3bJUdQ9To1nUz41MX0aq0D2bSod1FhRoW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRRy/pWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195BC433C7;
	Fri, 23 Feb 2024 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719551;
	bh=CUxFDPyTjDPgcgfn5h2C/Q9GGH3cNDWmsoWlzMpvK6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pRRy/pWaoT1wDkwlVwp4ayT1x5iXCaJQZ4X5d6wrdqCCrpBDulYaIGVMYG+of5SA9
	 2kqwy91EIpIsFli8RAVVbHqHFNW1o01+KsBMvWIUDqMG6Lprao0pj4xwZnRuUwVksw
	 1eoPh2tbE81Qk8xQGsv4d8UhuYQOTMG3IEA8ljIRKQ6K7ALsXU4PghKKszckc98QrA
	 LZysgVeqm4mRPFvLoXDueXueLDlXOhgIjFsMXmdk2zM/Cszy8J0gwzd8ZClbysy6Kk
	 QqL7aYLam4chtYUmMoujxHQmf2YbttpyiYIeoWGuSUvenCiYAw6zb33G7iXf66MDcd
	 qI+ipf1X13+1g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:56 +0100
Subject: [PATCH net-next 4/8] mptcp: check the protocol in mptcp_sk() with
 DEBUG_NET
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-4-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CUxFDPyTjDPgcgfn5h2C/Q9GGH3cNDWmsoWlzMpvK6c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qEcJtSiUiDIwSGN1n9T5qWPvJ2VGPQKWAF
 p8P6A9lM4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c2gcEADibZI0WrfH0y2ybUH4yxBwbFJfUZEWnjhaaPJVdiH+/WjOcyRPvwLivx0QTPPAYOPiJ1c
 V4OHbrUISKyAhPMBuxmyXIpgwh93V2xcQF9+gjy7UTFzAm/1ql3uZncCAZNGO6+g9EJy8pyQCEO
 TTBmFcBI7o0/lxbJspHwUe+qQ0SSMJYxcVFgcX/B9de8tgJv1aQtLUC79PSTfm+oez+KrgXbr9S
 JFyI/MTIR4HmXLnwz7Y8PK+jr2uPZtqfar2z32/OMgLbynKlKKOvmNv5Uebi5baJvNVAPtCnau7
 ASS4unrgi4KcxcoPCUa/juBrWX7rXc1XQT37ikK3D4CQ8rIIyOKEBPhy+5oMZ71TYg435Y46gb1
 GgxyiwgsKIR5H0nF/+7B7yPPgCLt4u7vf1yh9whWycXga19ivpYG6sNa3e1+OK6/zb96oQaS7Cm
 gdAAlcuH8KvwUp92RkRpq2ERBfu9a5tpvaD+x1B9oIFQ2TShqLiHss3gJ1YvA4Mw0soc92tE/ov
 GNtbMrMxnO1jwiNv8iVqJcjvsfi929hhj29uHUCCnVNBn/UjTh1tTrOxFIJsoJMdWKcqPxCFEZP
 BTwXnwhoKDCMWxgRv2rWBJMG3jfwYaToN1J5HMm/ezi8kKE+v9CWu3VTg9+fUYii+I0G386Endj
 jckuvanoILA96vg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when mptcp_sk() is used
with a non mptcp_sock structure.

This is similar to the parent commit, where it is easy to use mptcp_sk()
with a TCP sock, e.g. with a subflow sk.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-MPTCP socket is being used as an MPTCP one.
'mptcp_sk()' macro is then defined differently: with an extra WARN to
complain when an unexpected socket is being used.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 026ed360bd72..051b100d9403 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -356,9 +356,15 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
 	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
 })
-#endif
+#define mptcp_sk(ptr) ({						\
+	typeof(ptr) _ptr = (ptr);					\
+	WARN_ON(_ptr->sk_protocol != IPPROTO_MPTCP);			\
+	container_of_const(_ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
+})
 
+#else /* !CONFIG_DEBUG_NET */
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
+#endif
 
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory

-- 
2.43.0


