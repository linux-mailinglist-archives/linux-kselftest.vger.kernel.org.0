Return-Path: <linux-kselftest+bounces-41380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C5B54E7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2373BD464
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDB30AD04;
	Fri, 12 Sep 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbzXRb23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912D304BC5;
	Fri, 12 Sep 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681589; cv=none; b=RfTEbnOsrsltO2cJeziW4MKlKVKhpZnYmZmHOeg0H/4jJaJUAK4QiUza9No92KpVSAx/dGtcrNWRwh+hvMWqaq5xRTafve76PXFQwSgPDukPvbfPda3mAUfXI5YJ2YnYAJSg51/22GrAtgw8tAILE6AJw5+w/vqnOcX9qLncvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681589; c=relaxed/simple;
	bh=lkbX7mxCFhUloTL+Yp0yN9A7qSk5SV/fUBoxR5SQYSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxUNaJGxvJ0/kNy/hRz4T2UjhT/Bke1XRZMHih0UH/dDQFtpSXA4qwHSfVKooz26TAhS7r1YfTjLPzPCPsMRRfjifCq6RlapsySve6kJs/3Z+BST02nJe0bimsZfIyXVzddaf2YsEFW6VrsCzjDrs9EIaYhNzkJElbLruB08ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbzXRb23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B0BC4CEF1;
	Fri, 12 Sep 2025 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681589;
	bh=lkbX7mxCFhUloTL+Yp0yN9A7qSk5SV/fUBoxR5SQYSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbzXRb23IyU4jhoRH2MbQB2qQ8FyACXfCSrsBFLaHpe1u5yDFJmRRCsI/mY97b1cg
	 8XqHpPjRPR07vT01qjxc+PSb7nSL22QipcqW6ga9mFz9JXmP5kw5k4jotMTwZZlXjg
	 KhXkIuE0W5XhNQzTXLGnq54tpqwT9/Ar3QgvorwG1MV0fR4/KXmXxJRfn+tr4Maox6
	 y0XXw2MsNrJ08ypVZ2ElG2wQdXh+Xn3flelaoubNHMrMlMxqH7pe9nzA9LGZ47Q/dF
	 ukJ8oDjnwThEvxApMOSUemyoRZ6hAS6eQh9ad5Z48A6bhiugVJjovYVWQ47Wg/oUYp
	 +FYvdxTyxwE2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:52:21 +0200
Subject: [PATCH net 2/5] mptcp: pm: nl: announce deny-join-id0 flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-2-40171884ade8@kernel.org>
References: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marek Majkowski <marek@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5232; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lkbX7mxCFhUloTL+Yp0yN9A7qSk5SV/fUBoxR5SQYSU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiC8T+efsMDtqpeyfMqXF86fsb1FXlei8J/i7i3dPt
 M+8uyHzO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZS7c7wP6de2rlgxR+lsyap
 035osJky6+5tVOSYOCdlZqj6s64acYb/SSvvOEYVF3SVf74U4PWenU1d7Xrxp6y+CSr/TjSvE5d
 iAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other one that
it cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflows to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't.

The RFC8684 [1] is strict about that:

  (...) therefore the receiver MUST NOT try to open any additional
  subflows toward this address and port.

So it is important to tell the userspace about that as it is responsible
for the respect of this flag.

When a new connection is created and established, the Netlink events
now contain the existing but not currently used 'flags' attribute. When
MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 is set, it means no other subflows
to the initial IP address and port -- info that are also part of the
event -- can be established.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
 include/uapi/linux/mptcp.h                | 2 ++
 include/uapi/linux/mptcp_pm.h             | 4 ++--
 net/mptcp/pm_netlink.c                    | 7 +++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index d15335684ec3d6256505f2b3887ce5818eb57462..d1b4829b580ad09baf4afd73b67abd7b4ef6883a 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
           traffic-patterns it can take a long time until the
           MPTCP_EVENT_ESTABLISHED is sent.
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, [flags].
       -
         name: established
         doc: >-
           A MPTCP connection is established (can start new subflows).
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, [flags].
       -
         name: closed
         doc: >-
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 67d015df8893cc1390a483bda034191525b8fef0..5fd5b4cf75ca1e0099e0effa351507d3ab002f1e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -31,6 +31,8 @@
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+
 #define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 6ac84b2f636ca22935c191c645449fb62b673899..7359d34da446b94be148b363079120db03ba8549 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 50aaf259959aeaf36e7ab954c6f7957eaf2bc390..ce7d42d3bd007b13f214fab699bc69b5e35c25e3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -408,6 +408,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -415,6 +416,12 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
 		return -EMSGSIZE;
 
+	if (READ_ONCE(msk->pm.remote_deny_join_id0))
+		flags |= MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
+
+	if (flags && nla_put_u16(skb, MPTCP_ATTR_FLAGS, flags))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 

-- 
2.51.0


