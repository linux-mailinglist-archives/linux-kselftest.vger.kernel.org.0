Return-Path: <linux-kselftest+bounces-48123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B5CF094D
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 308C8300A358
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB12BEFF6;
	Sun,  4 Jan 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUBqoj4O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C929DB99
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497057; cv=none; b=uMOdlt84pMPEHPPHv+DmMi8ZOqcmQA/GC5dazbBpqSKEuLtsefpRnLqgr+Dd3KoKcVTSHnXr2w9jX4zJWfHyMGL0ZAo3vQ7SSgsHjqFG0J2jDa0drephLXWEpttbHYgNq6gRMMK0dZlzIhLECDz0km3MxRhYr9sA4JL1FHcr+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497057; c=relaxed/simple;
	bh=/lEI3/+J/BPnZOVKSfEgPgwaAZ3096zvgLIqg+pqJh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCtgGuhSmw9qWHXoQIvMGLTw0hlq54WIQNqkXtLw63DQsWEu6KQyeck0wtqxKTbPLlevfkE+GEc+Vg7Oemn0nZSeP2DQJ9atoVmc2gvgs9hbrZJzjczF4xqIvE7L5NQMyt1PQtlZcUNF1QXjfZ/wvtRZ84Qv2IpYE/rJ3vl0Vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUBqoj4O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767497054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ii8w9Sk0VGXA6EfYewOe7fg/XK65AlKb5PXLcHLgJRs=;
	b=fUBqoj4OL6vGjlL6jPhmHkGBQoHYnBIkM8bNfGYx8f9HbUmeLbtOr4QICPxPpyzYAS0MZq
	JDC+tPCy0OOLfTKpbOuTj04FHpm49PSGDo0bB+c6S3cF5jmvYqrrTDLz6pW2ndtwJOq9SQ
	WWezm22+UgsS4ne+W1WEzeAqb198o28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-xbALdIZ0PR-HKjuLWFJAQg-1; Sat,
 03 Jan 2026 22:24:11 -0500
X-MC-Unique: xbALdIZ0PR-HKjuLWFJAQg-1
X-Mimecast-MFC-AGG-ID: xbALdIZ0PR-HKjuLWFJAQg_1767497049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D621C18002ED;
	Sun,  4 Jan 2026 03:24:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BF2A19560AB;
	Sun,  4 Jan 2026 03:24:00 +0000 (UTC)
From: Yumei Huang <yuhuang@redhat.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: sbrivio@redhat.com,
	david@gibson.dropbear.id.au,
	yuhuang@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	shuah@kernel.org
Subject: [PATCH net-next v2] ipv6: preserve insertion order for same-scope addresses
Date: Sun,  4 Jan 2026 11:23:57 +0800
Message-ID: <20260104032357.38555-1-yuhuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

IPv6 addresses with the same scope are returned in reverse insertion
order, unlike IPv4. For example, when adding a -> b -> c, the list is
reported as c -> b -> a, while IPv4 preserves the original order.

This behavior causes:

a. When using `ip -6 a save` and `ip -6 a restore`, addresses are restored
   in the opposite order from which they were saved. See example below
   showing addresses added as 1::1, 1::2, 1::3 but displayed and saved
   in reverse order.

   # ip -6 a a 1::1 dev x
   # ip -6 a a 1::2 dev x
   # ip -6 a a 1::3 dev x
   # ip -6 a s dev x
   2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
       inet6 1::3/128 scope global tentative
       valid_lft forever preferred_lft forever
       inet6 1::2/128 scope global tentative
       valid_lft forever preferred_lft forever
       inet6 1::1/128 scope global tentative
       valid_lft forever preferred_lft forever
   # ip -6 a save > dump
   # ip -6 a d 1::1 dev x
   # ip -6 a d 1::2 dev x
   # ip -6 a d 1::3 dev x
   # ip a d ::1 dev lo
   # ip a restore < dump
   # ip -6 a s dev x
   2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
       inet6 1::1/128 scope global tentative
       valid_lft forever preferred_lft forever
       inet6 1::2/128 scope global tentative
       valid_lft forever preferred_lft forever
       inet6 1::3/128 scope global tentative
       valid_lft forever preferred_lft forever
   # ip a showdump < dump
    if1:
        inet6 ::1/128 scope host proto kernel_lo
        valid_lft forever preferred_lft forever
    if2:
        inet6 1::3/128 scope global tentative
        valid_lft forever preferred_lft forever
    if2:
        inet6 1::2/128 scope global tentative
        valid_lft forever preferred_lft forever
    if2:
        inet6 1::1/128 scope global tentative
        valid_lft forever preferred_lft forever

b. Addresses in pasta to appear in reversed order compared to host
   addresses.

The ipv6 addresses were added in reverse order by commit e55ffac60117
("[IPV6]: order addresses by scope"), then it was changed by commit
502a2ffd7376 ("ipv6: convert idev_list to list macros"), and restored by
commit b54c9b98bbfb ("ipv6: Preserve pervious behavior in
ipv6_link_dev_addr()."). However, this reverse ordering within the same
scope causes inconsistency with IPv4 and the issues described above.

This patch aligns IPv6 address ordering with IPv4 for consistency
by changing the comparison from >= to > when inserting addresses
into the address list. Also updates the ioam6 selftest to reflect
the new address ordering behavior. Combine these two changes into
one patch for bisectability.

Fixes: e55ffac60117 ("[IPV6]: order addresses by scope")
Link: https://bugs.passt.top/show_bug.cgi?id=175
Suggested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Yumei Huang <yuhuang@redhat.com>
---
 net/ipv6/addrconf.c                  | 2 +-
 tools/testing/selftests/net/ioam6.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..ca998bf46863 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 	list_for_each(p, &idev->addr_list) {
 		struct inet6_ifaddr *ifa
 			= list_entry(p, struct inet6_ifaddr, if_list);
-		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
+		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
 			break;
 	}
 
diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index 845c26dd01a9..b2b99889942f 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -273,8 +273,8 @@ setup()
   ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
   ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
 
-  ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
   ip -netns $ioam_node_alpha link set lo up &>/dev/null
   ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
-- 
2.52.0


