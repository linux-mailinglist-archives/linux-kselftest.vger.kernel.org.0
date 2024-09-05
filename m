Return-Path: <linux-kselftest+bounces-17320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07696E3AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970B1C21D98
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F2199237;
	Thu,  5 Sep 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2STALQiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A397156C73
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566855; cv=none; b=jocJLkShv52SGPMdz/a/K9U2CYX29ElGbpFPYnz9/iwYf7mR34N2br3ZgI65yv5lb4dirU9KxBNaNLpDyCZEN8D0+gfBugcONQxmFAx/ms9s5zFLXHKN/4d1j7COOD83+IxKsXTJGaU5kNaC70ssiRnTtXuOm4kvl99KCi8eUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566855; c=relaxed/simple;
	bh=UcfouhfcqJEjJfgy6cA35gd8xPH1EhvSL63PhOueSQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BKFQBs3Gd2QfvW9gBR/rsHc6JjZcXTkxLnC72s/oqx+KTxp9nk+jaNqgiA78bwLrFb+rgKtUCvVvaZS4l5VgDQ3hpo2kZrN/Paa67L918pE3jchhUXUFKelzN7orqKFQjcIgrb5dSHq+8H1zKeyJheYLXTHFxGXOeGnjpBOq5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2STALQiv; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82a319f6520so328334039f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725566851; x=1726171651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzjZRbzMO+xdboEtQpI9uNMfcqo1XHcSdNxQ2YjUwqA=;
        b=2STALQivmNVos7A00rVyL0ckvhsMJkkO16h7qaN+3iBX//JiQt3oGOwLCxoR2qtaKO
         Snj7l+M+rYKGft5X/D9Js5kPFA2sEURy9uLrfThAR7baNl1f25EnQbybGL8Tzq1vYjG3
         372uc5YPh1AGKevdY7SXxfJKrki8i8Gz5DkBqQqJd3qPdr2xu0zx1IHEoLj3jJQZrhkT
         Gtu2tnKFq1D9tob/F3uPCDpul1w/LWoypu7/b51pSf6vq66XPcIHLSGfziQJe7+LuD5v
         Vc3xQJDlskjIUGeV+ADUtvMM6V4xdCsIBynwXaIF5OmJACJ15W0MiUpGXrm57dhk3SQk
         BJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725566851; x=1726171651;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzjZRbzMO+xdboEtQpI9uNMfcqo1XHcSdNxQ2YjUwqA=;
        b=ilIAvosrgRNtfunTaz+ICvWxhdxGJA9qDK4T+pXKwc9KW4dEpq6B4ecH2/UCH6MFU3
         7EXvKAheElLscKIvMEmCZmSF8fSaschhkfZFX7S6cVgSLMVjizwVNB8mE1h2uwk0uIPs
         rYZIofp6esfQKzd7E83d850kl8wEVH8AN37XIXl9CWy+BgsqEG/kpPWvWm+a7svFAUqK
         YEhQTjQXegl+h4uUB33TR0itY0u4+UTBdqcpbgEZF0O2fJju33xPmKx+aCvAQ4Q2Et/Q
         Vx9TXNKOg+5Dqz8C2IYuxDTQrHwod1Udh+NhL6LUnN4uIawOZJe0KqK7ynBWlgFe7ZpZ
         jL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWI+Hs9gQtkXyriQqfDr4xki47o2THl9zDObB38v1ME9chZt6qq28ubPZAENT2twiymWnR6FUu9QtUP/h0HzlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNus+O+q3wgaCs1DduqSFL8znFAUEro37AcAQhFCDEqo9ErZ/
	zitAhxYJeBefH4IDzAuv3vUwIgKZAC11w4AmI9o5psjfcqBVJW1e2vjX47W9mbDibEoJs3WbjA=
	=
X-Google-Smtp-Source: AGHT+IHEd+lsFnYs+0GqUENZHjM8rPmqmtwsqnAVXOkz3OUkiQAmcfLytMWw9/rGVtchSpKTLiUG5g52Cg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1e5])
 (user=jrife job=sendgmr) by 2002:a05:6e02:1b07:b0:39f:549d:e39d with SMTP id
 e9e14a558f8ab-3a04f105a48mr32695ab.5.1725566851549; Thu, 05 Sep 2024 13:07:31
 -0700 (PDT)
Date: Thu,  5 Sep 2024 15:05:41 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240905200551.4099064-1-jrife@google.com>
Subject: [PATCH v2 net-next] wireguard: allowedips: Add WGALLOWEDIP_F_REMOVE_ME
 flag
From: Jordan Rife <jrife@google.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com
Cc: Jordan Rife <jrife@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the current API the only way to remove an allowed IP is to
completely rebuild the allowed IPs set for a peer using
WGPEER_F_REPLACE_ALLOWEDIPS. In other words, if my current configuration
is such that a peer has allowed IP IPs 192.168.0.2 and 192.168.0.3 and I
want to remove 192.168.0.2 the actual transition looks like this.

[192.168.0.2, 192.168.0.3] <-- Initial state
[]                         <-- Step 1: Allowed IPs removed for peer
[192.168.0.3]              <-- Step 2: Allowed IPs added back for peer

This is true even if the allowed IP list is small and the update does
not need to be batched into multiple WG_CMD_SET_DEVICE requests, as
the removal and subsequent addition of IPs is non-atomic within a single
request. Consequently, wg_allowedips_lookup_dst and
wg_allowedips_lookup_src may return NULL while reconfiguring a peer even
for packets bound for IPs a user did not intend to remove leading to
unintended interruptions in connectivity. This presents in userspace as
failed calls to sendto and sendmsg for UDP sockets. In my case, I ran
netperf while repeatedly reconfiguring the allowed IPs for a peer with
wg.

/usr/local/bin/netperf -H 10.102.73.72 -l 10m -t UDP_STREAM -- -R 1 -m 1024
send_data: data send error: No route to host (errno 113)
netperf: send_omni: send_data failed: No route to host

While this may not be of particular concern for environments where peers
and allowed IPs are mostly static, Cilium manages peers and allowed IPs
in a dynamic environment where peers (i.e. Kubernetes nodes) and allowed
IPs (i.e. Pods running on those nodes) can frequently change. Cilium
must continually keep its WireGuard device's configuration in sync with
its cluster state leading to unnecessary churn and packet drops.

This patch introduces a new flag called WGALLOWEDIP_F_REMOVE_ME which
in the same way that WGPEER_F_REMOVE_ME allows a user to remove a single
peer from a WireGuard device's configuration allows a user to remove an
IP from a peer's set of allowed IPs. This has two benefits. First, it
allows systems such as Cilium to avoid introducing connectivity blips
while reconfiguring a WireGuard device. Second, it allows us to more
efficiently keep the device's configuration in sync with the cluster
state, as we no longer need to do frequent rebuilds of the allowed IPs
list for each peer. Instead, the device's configuration can be
incrementally updated. This patch also bumps WG_GENL_VERSION which can
be used by clients to detect whether or not their system supports the
WGALLOWEDIP_F_REMOVE_ME flag.

=======
Changes
=======

v1->v2
------
* Fixed some Sparse warnings

Signed-off-by: Jordan Rife <jrife@google.com>
---
 drivers/net/wireguard/allowedips.c            | 103 ++++++++++----
 drivers/net/wireguard/allowedips.h            |   4 +
 drivers/net/wireguard/netlink.c               |  45 +++++--
 drivers/net/wireguard/selftest/allowedips.c   |  30 +++++
 include/uapi/linux/wireguard.h                |  11 +-
 tools/testing/selftests/wireguard/Makefile    |  18 +++
 tools/testing/selftests/wireguard/netns.sh    |  38 ++++++
 tools/testing/selftests/wireguard/remove-ip.c | 126 ++++++++++++++++++
 8 files changed, 333 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/wireguard/Makefile
 create mode 100644 tools/testing/selftests/wireguard/remove-ip.c

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 4b8528206cc8a..ff52259dd8d81 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -249,6 +249,56 @@ static int add(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
 	return 0;
 }
 
+static void _remove(struct allowedips_node *node, struct mutex *lock)
+{
+	struct allowedips_node *child, **parent_bit, *parent;
+	bool free_parent;
+
+	list_del_init(&node->peer_list);
+	RCU_INIT_POINTER(node->peer, NULL);
+	if (node->bit[0] && node->bit[1])
+		return;
+	child = rcu_dereference_protected(node->bit[!rcu_access_pointer(node->bit[0])],
+					  lockdep_is_held(lock));
+	if (child)
+		child->parent_bit_packed = node->parent_bit_packed;
+	parent_bit = (struct allowedips_node **)(node->parent_bit_packed & ~3UL);
+	*parent_bit = child;
+	parent = (void *)parent_bit -
+			offsetof(struct allowedips_node, bit[node->parent_bit_packed & 1]);
+	free_parent = !rcu_access_pointer(node->bit[0]) &&
+			!rcu_access_pointer(node->bit[1]) &&
+			(node->parent_bit_packed & 3) <= 1 &&
+			!rcu_access_pointer(parent->peer);
+	if (free_parent)
+		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
+						  lockdep_is_held(lock));
+	call_rcu(&node->rcu, node_free_rcu);
+	if (!free_parent)
+		return;
+	if (child)
+		child->parent_bit_packed = parent->parent_bit_packed;
+	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
+	call_rcu(&parent->rcu, node_free_rcu);
+}
+
+static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
+		  u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	struct allowedips_node *node;
+
+	if (unlikely(cidr > bits || !peer))
+		return -EINVAL;
+	if (!rcu_access_pointer(*trie) ||
+	    !node_placement(*trie, key, cidr, bits, &node, lock) ||
+	    peer != rcu_access_pointer(node->peer))
+		return 0;
+
+	_remove(node, lock);
+
+	return 0;
+}
+
 void wg_allowedips_init(struct allowedips *table)
 {
 	table->root4 = table->root6 = NULL;
@@ -300,43 +350,38 @@ int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
 	return add(&table->root6, 128, key, cidr, peer, lock);
 }
 
+int wg_allowedips_remove_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls */
+	u8 key[4] __aligned(__alignof(u32));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 32);
+	return remove(&table->root4, 32, key, cidr, peer, lock);
+}
+
+int wg_allowedips_remove_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls64 */
+	u8 key[16] __aligned(__alignof(u64));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 128);
+	return remove(&table->root6, 128, key, cidr, peer, lock);
+}
+
 void wg_allowedips_remove_by_peer(struct allowedips *table,
 				  struct wg_peer *peer, struct mutex *lock)
 {
-	struct allowedips_node *node, *child, **parent_bit, *parent, *tmp;
-	bool free_parent;
+	struct allowedips_node *node, *tmp;
 
 	if (list_empty(&peer->allowedips_list))
 		return;
 	++table->seq;
 	list_for_each_entry_safe(node, tmp, &peer->allowedips_list, peer_list) {
-		list_del_init(&node->peer_list);
-		RCU_INIT_POINTER(node->peer, NULL);
-		if (node->bit[0] && node->bit[1])
-			continue;
-		child = rcu_dereference_protected(node->bit[!rcu_access_pointer(node->bit[0])],
-						  lockdep_is_held(lock));
-		if (child)
-			child->parent_bit_packed = node->parent_bit_packed;
-		parent_bit = (struct allowedips_node **)(node->parent_bit_packed & ~3UL);
-		*parent_bit = child;
-		parent = (void *)parent_bit -
-			 offsetof(struct allowedips_node, bit[node->parent_bit_packed & 1]);
-		free_parent = !rcu_access_pointer(node->bit[0]) &&
-			      !rcu_access_pointer(node->bit[1]) &&
-			      (node->parent_bit_packed & 3) <= 1 &&
-			      !rcu_access_pointer(parent->peer);
-		if (free_parent)
-			child = rcu_dereference_protected(
-					parent->bit[!(node->parent_bit_packed & 1)],
-					lockdep_is_held(lock));
-		call_rcu(&node->rcu, node_free_rcu);
-		if (!free_parent)
-			continue;
-		if (child)
-			child->parent_bit_packed = parent->parent_bit_packed;
-		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-		call_rcu(&parent->rcu, node_free_rcu);
+		_remove(node, lock);
 	}
 }
 
diff --git a/drivers/net/wireguard/allowedips.h b/drivers/net/wireguard/allowedips.h
index 2346c797eb4d8..931958cb6e100 100644
--- a/drivers/net/wireguard/allowedips.h
+++ b/drivers/net/wireguard/allowedips.h
@@ -38,6 +38,10 @@ int wg_allowedips_insert_v4(struct allowedips *table, const struct in_addr *ip,
 			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
 int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
 			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+int wg_allowedips_remove_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+int wg_allowedips_remove_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
 void wg_allowedips_remove_by_peer(struct allowedips *table,
 				  struct wg_peer *peer, struct mutex *lock);
 /* The ip input pointer should be __aligned(__alignof(u64))) */
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f7055180ba4aa..5f2a8553ab43d 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -46,7 +46,8 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1] = {
 	[WGALLOWEDIP_A_FAMILY]		= { .type = NLA_U16 },
 	[WGALLOWEDIP_A_IPADDR]		= NLA_POLICY_MIN_LEN(sizeof(struct in_addr)),
-	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 }
+	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 },
+	[WGALLOWEDIP_A_FLAGS]		= { .type = NLA_U32 }
 };
 
 static struct wg_device *lookup_interface(struct nlattr **attrs,
@@ -329,6 +330,7 @@ static int set_port(struct wg_device *wg, u16 port)
 static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
 {
 	int ret = -EINVAL;
+	u32 flags = 0;
 	u16 family;
 	u8 cidr;
 
@@ -337,19 +339,38 @@ static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
 		return ret;
 	family = nla_get_u16(attrs[WGALLOWEDIP_A_FAMILY]);
 	cidr = nla_get_u8(attrs[WGALLOWEDIP_A_CIDR_MASK]);
+	if (attrs[WGALLOWEDIP_A_FLAGS])
+		flags = nla_get_u32(attrs[WGALLOWEDIP_A_FLAGS]);
 
 	if (family == AF_INET && cidr <= 32 &&
-	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr))
-		ret = wg_allowedips_insert_v4(
-			&peer->device->peer_allowedips,
-			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
-			&peer->device->device_update_lock);
-	else if (family == AF_INET6 && cidr <= 128 &&
-		 nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr))
-		ret = wg_allowedips_insert_v6(
-			&peer->device->peer_allowedips,
-			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
-			&peer->device->device_update_lock);
+	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr)) {
+		if (flags & WGALLOWEDIP_F_REMOVE_ME)
+			ret = wg_allowedips_remove_v4(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]),
+						      cidr,
+						      peer,
+						      &peer->device->device_update_lock);
+		else
+			ret = wg_allowedips_insert_v4(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]),
+						      cidr,
+						      peer,
+						      &peer->device->device_update_lock);
+	} else if (family == AF_INET6 && cidr <= 128 &&
+		   nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr)) {
+		if (flags & WGALLOWEDIP_F_REMOVE_ME)
+			ret = wg_allowedips_remove_v6(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]),
+						      cidr,
+						      peer,
+						      &peer->device->device_update_lock);
+		else
+			ret = wg_allowedips_insert_v6(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]),
+						      cidr,
+						      peer,
+						      &peer->device->device_update_lock);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 3d1f64ff2e122..9f6458a889e96 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -461,6 +461,10 @@ static __init struct wg_peer *init_peer(void)
 	wg_allowedips_insert_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
 					cidr, mem, &mutex)
 
+#define remove(version, mem, ipa, ipb, ipc, ipd, cidr)                      \
+	wg_allowedips_remove_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
+					cidr, mem, &mutex)
+
 #define maybe_fail() do {                                               \
 		++i;                                                    \
 		if (!_s) {                                              \
@@ -586,6 +590,32 @@ bool __init wg_allowedips_selftest(void)
 	test_negative(4, a, 192, 0, 0, 0);
 	test_negative(4, a, 255, 0, 0, 0);
 
+	insert(4, a, 1, 0, 0, 0, 32);
+	insert(4, a, 192, 0, 0, 0, 24);
+	insert(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
+	insert(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test(4, a, 1, 0, 0, 0);
+	test(4, a, 192, 0, 0, 1);
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	test(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+	/* Must be an exact match to remove */
+	remove(4, a, 192, 0, 0, 0, 32);
+	test(4, a, 192, 0, 0, 1);
+	remove(4, a, 192, 0, 0, 0, 24);
+	test_negative(4, a, 192, 0, 0, 1);
+	remove(4, a, 1, 0, 0, 0, 32);
+	test_negative(4, a, 1, 0, 0, 0);
+	/* Must be an exact match to remove */
+	remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 96);
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
+	test_negative(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	/* Must match the peer to remove */
+	remove(6, b, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+	remove(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test_negative(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+
 	wg_allowedips_free(&t, &mutex);
 	wg_allowedips_init(&t);
 	insert(4, a, 192, 168, 0, 0, 16);
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index ae88be14c9478..e219194cb9f5a 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -101,6 +101,10 @@
  *                    WGALLOWEDIP_A_FAMILY: NLA_U16
  *                    WGALLOWEDIP_A_IPADDR: struct in_addr or struct in6_addr
  *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
+ *                    WGALLOWEDIP_A_FLAGS: NLA_U32, WGALLOWEDIP_F_REMOVE_ME if
+ *                                         the specified IP should be removed,
+ *                                         otherwise this IP will be added if
+ *                                         it is not already present.
  *                0: NLA_NESTED
  *                    ...
  *                0: NLA_NESTED
@@ -132,7 +136,7 @@
 #define _WG_UAPI_WIREGUARD_H
 
 #define WG_GENL_NAME "wireguard"
-#define WG_GENL_VERSION 1
+#define WG_GENL_VERSION 2
 
 #define WG_KEY_LEN 32
 
@@ -184,11 +188,16 @@ enum wgpeer_attribute {
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
 
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
+	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+};
 enum wgallowedip_attribute {
 	WGALLOWEDIP_A_UNSPEC,
 	WGALLOWEDIP_A_FAMILY,
 	WGALLOWEDIP_A_IPADDR,
 	WGALLOWEDIP_A_CIDR_MASK,
+	WGALLOWEDIP_A_FLAGS,
 	__WGALLOWEDIP_A_LAST
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
diff --git a/tools/testing/selftests/wireguard/Makefile b/tools/testing/selftests/wireguard/Makefile
new file mode 100644
index 0000000000000..4f4db54f89cb3
--- /dev/null
+++ b/tools/testing/selftests/wireguard/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Note: To build this you must install libnl-3 and libnl-genl-3 development
+# packages.
+remove-ip:
+	gcc -I/usr/include/libnl3 \
+	    -I../../../../usr/include \
+	    remove-ip.c \
+	    -o remove-ip \
+	    -lnl-genl-3 \
+	    -lnl-3
+
+.PHONY: all
+all: remove-ip
+
+.PHONY: clean
+clean:
+	rm remove-ip
diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93d..70058d6ebbe85 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -28,6 +28,7 @@ exec 3>&1
 export LANG=C
 export WG_HIDE_KEYS=never
 NPROC=( /sys/devices/system/cpu/cpu+([0-9]) ); NPROC=${#NPROC[@]}
+SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
 netns0="wg-test-$$-0"
 netns1="wg-test-$$-1"
 netns2="wg-test-$$-2"
@@ -610,6 +611,43 @@ n0 wg set wg0 peer "$pub2" allowed-ips "$allowedips"
 } < <(n0 wg show wg0 allowed-ips)
 ip0 link del wg0
 
+# Test IP removal
+allowedips=( )
+for i in {1..197}; do
+        allowedips+=( 192.168.0.$i )
+        allowedips+=( abcd::$i )
+done
+saved_ifs="$IFS"
+IFS=,
+allowedips="${allowedips[*]}"
+IFS="$saved_ifs"
+ip0 link add wg0 type wireguard
+n0 wg set wg0 peer "$pub1" allowed-ips "$allowedips"
+pub1_hex=$(echo "$pub1" | base64 -d | xxd -p -c 50)
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 4 192.168.0.1
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 4 192.168.0.20
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 4 192.168.0.100
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 6 abcd::1
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 6 abcd::20
+n0 $SCRIPT_DIR/remove-ip wg0 "$pub1_hex" 6 abcd::100
+n0 wg show wg0 allowed-ips
+{
+	read -r pub allowedips
+	[[ $pub == "$pub1" ]]
+	i=0
+	for ip in $allowedips; do
+		[[ "$ip" != "192.168.0.1" ]]
+		[[ "$ip" != "192.168.0.20" ]]
+		[[ "$ip" != "192.168.0.100" ]]
+		[[ "$ip" != "abcd::1" ]]
+		[[ "$ip" != "abcd::20" ]]
+		[[ "$ip" != "abcd::100" ]]
+		((++i))
+	done
+	((i == 388))
+} < <(n0 wg show wg0 allowed-ips)
+ip0 link del wg0
+
 ! n0 wg show doesnotexist || false
 
 ip0 link add wg0 type wireguard
diff --git a/tools/testing/selftests/wireguard/remove-ip.c b/tools/testing/selftests/wireguard/remove-ip.c
new file mode 100644
index 0000000000000..242f922d99b56
--- /dev/null
+++ b/tools/testing/selftests/wireguard/remove-ip.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/wireguard.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+
+#define CURVE25519_KEY_SIZE 32
+
+const char *usage = "Usage: remove-ip INTERFACE_NAME PEER_PUBLIC_KEY_HEX IP_VERSION IP";
+
+char h2b(char c)
+{
+	if ('0' <= c && c <= '9')
+		return c - '0';
+	else if ('a' <= c && c <= 'f')
+		return 10 + (c - 'a');
+
+	return -1;
+}
+
+int parse_key(const char *raw, unsigned char key[CURVE25519_KEY_SIZE])
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < CURVE25519_KEY_SIZE; i++) {
+		char h, l;
+
+		h = h2b(raw[0]);
+		if (h < 0)
+			return -1;
+
+		l = h2b(raw[1]);
+		if (l < 0)
+			return -1;
+
+		key[i] = (h << 4) | l;
+		raw += 2;
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char addr[sizeof(struct in6_addr)];
+	unsigned char pub_key[CURVE25519_KEY_SIZE];
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	int addr_len;
+	int family;
+	int cidr;
+	int af;
+
+	if (argc < 5) {
+		printf("Not enough arguments.\n\n%s\n", usage);
+		return -1;
+	}
+
+	if (parse_key(argv[2], pub_key)) {
+		printf("Could not parse public key\n");
+		return -1;
+	}
+
+	switch (argv[3][0]) {
+	case '4':
+		af = AF_INET;
+		addr_len = sizeof(struct in_addr);
+		cidr = 32;
+		break;
+	case '6':
+		af = AF_INET6;
+		addr_len = sizeof(struct in6_addr);
+		cidr = 128;
+		break;
+	default:
+		printf("Invalid IP version\n");
+		return -1;
+	}
+
+	if (inet_pton(af, argv[4], &addr) <= 0) {
+		printf("Could not parse IP address\n");
+		return -1;
+	}
+
+	sock = nl_socket_alloc();
+	genl_connect(sock);
+	family = genl_ctrl_resolve(sock, WG_GENL_NAME);
+	msg = nlmsg_alloc();
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_ECHO,
+		    WG_CMD_SET_DEVICE, WG_GENL_VERSION);
+	nla_put_string(msg, WGDEVICE_A_IFNAME, argv[1]);
+
+	struct nlattr *peers = nla_nest_start(msg, WGDEVICE_A_PEERS);
+	struct nlattr *peer0 = nla_nest_start(msg, 0);
+
+	nla_put(msg, WGPEER_A_PUBLIC_KEY, CURVE25519_KEY_SIZE, pub_key);
+
+	struct nlattr *allowed_ips = nla_nest_start(msg, WGPEER_A_ALLOWEDIPS);
+	struct nlattr *allowed_ip0 = nla_nest_start(msg, 0);
+
+	nla_put_u16(msg, WGALLOWEDIP_A_FAMILY, af);
+	nla_put(msg, WGALLOWEDIP_A_IPADDR, addr_len, &addr);
+	nla_put_u8(msg, WGALLOWEDIP_A_CIDR_MASK, cidr);
+	nla_put_u32(msg, WGALLOWEDIP_A_FLAGS, WGALLOWEDIP_F_REMOVE_ME);
+	nla_nest_end(msg, allowed_ip0);
+	nla_nest_end(msg, allowed_ips);
+	nla_nest_end(msg, peer0);
+	nla_nest_end(msg, peers);
+
+	int err = nl_send_sync(sock, msg);
+
+	if (err < 0) {
+		char message[256];
+
+		nl_perror(err, message);
+		printf("An error occurred: %d - %s\n", err, message);
+	}
+
+	return err;
+}
-- 
2.46.0.598.g6f2099f65c-goog


