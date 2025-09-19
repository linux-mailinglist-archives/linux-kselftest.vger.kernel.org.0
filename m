Return-Path: <linux-kselftest+bounces-41935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F2B895A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA323B6690
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212C30F541;
	Fri, 19 Sep 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TecuJnM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8030F52C;
	Fri, 19 Sep 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283760; cv=none; b=pkzHKaiorDTd2sVypRlL6lFTyY7RCMSnlD5W8HiLf5LFSgypGaj6umlWJHyHX/0VQzbKomQ8KxOSV4OJtRerLK30W5mcC/BWASSRMXrnyeU3HEbo5PFno/UO3K7buJhM71NPU+2vwEHnyzIRgT8ctckvvj1pnaNhM7RXQnSXv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283760; c=relaxed/simple;
	bh=C7KH3nGZjrEFxiXY5Osx6VSIL1Vign90Blv73Svnv9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2iKZPHGHrFJdc9YaVIuNdmSVQkLc8t7WyTWRO/gBZQbPpN1r/8pGccuZCrFkL0vfavQ6BomBuTtPQJ0LUMpF+pL9NaA3IR7doMl/yXr4vVZz7UfE54Ls2gabLqarozjgOIpgkN47nTwilFdqKUuI4F/nIplaWO/NjZDNOKD/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TecuJnM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18A0C4CEF1;
	Fri, 19 Sep 2025 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283760;
	bh=C7KH3nGZjrEFxiXY5Osx6VSIL1Vign90Blv73Svnv9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TecuJnM5wjBWCQvwn9JZdFUTA4f+XyPVhOzm9bJGOPWE7lm9E+8039JmHKNU1GWW9
	 behtnVkD/5nOpHryoeMjGtMDmHVDxDLOPxUYXw4qPJus5TiJwacXRMu4gxgZi+OspY
	 bXcba27jo5JsU57ybIlAUGuSNhZy/cP0UwQiYhBoNUCZQ7JK+xrtU8hYPyoFhuZWDF
	 m58naIpw8iPdWk5kTaOlgATcj8z4Xw0Vsp4c0wmhK5UzeQmTny5Gqpdr9uQl6H3+nB
	 k79upv+n2R0LREnI1mBoxjkiQEQt0oAYAO3HqbbWbjAtDjquGquh3N4BaMxHG1dfLh
	 +M0NpwAyAKvKA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:08:58 +0200
Subject: [PATCH net-next 1/6] mptcp: pm: netlink: only add server-side attr
 when true
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-1-a97a5d561a8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C7KH3nGZjrEFxiXY5Osx6VSIL1Vign90Blv73Svnv9g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuj8OXqD++1DtpsQfdgm1Ny//794vocNSxmaVe4ufW
 WqB141bHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZ/ZaRYbH+fs7WY7Z2dasu
 rvS3/J7q/qrt10q1uhlXPia6LFqm/JWRYc7KO63dTF8WRm0Oq/4jFm3ybWf1qbd7Y79dc+fas4Z
 pATcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is a boolean. No need to add it to set it to 'false'.

Indeed, the default value when this attribute is not set is naturally
'false'. A few bytes can then be saved by not adding this attribute if
the connection is not on the server side.

This prepares the future deprecation of its attribute, in favour of a
new flag.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml         | 4 ++--
 include/uapi/linux/mptcp_pm.h                     | 4 ++--
 net/mptcp/pm_netlink.c                            | 4 +++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c0304efd3215cc24485ea22e1ede 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
           traffic-patterns it can take a long time until the
           MPTCP_EVENT_ESTABLISHED is sent.
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side, [flags].
+          dport, [server-side], [flags].
       -
         name: established
         doc: >-
           A MPTCP connection is established (can start new subflows).
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side, [flags].
+          dport, [server-side], [flags].
       -
         name: closed
         doc: >-
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6d789632682a9bedbf8090feb9 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side, [flags].
+ *   sport, dport, [server-side], [flags].
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side, [flags].
+ *   sport, dport, [server-side], [flags].
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b59717472aca2d38add26255419 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -413,7 +413,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+	/* only set when it is the server side */
+	if (READ_ONCE(msk->pm.server_side) &&
+	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
 		return -EMSGSIZE;
 
 	if (READ_ONCE(msk->pm.remote_deny_join_id0))
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3d45991f24ede919264185e3b5c2a3b95c1dcc85..87323942cb8a0779717e6c0cb6be46314d303d26 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -241,7 +241,7 @@ make_connection()
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
-	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_serverside:-0}" = 0 ] && [ "${server_serverside:-0}" = 1 ] &&
 	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		test_pass

-- 
2.51.0


