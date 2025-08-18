Return-Path: <linux-kselftest+bounces-39220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5546B29D9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299513A640B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A930DD37;
	Mon, 18 Aug 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKYUvnb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17F2D7D42;
	Mon, 18 Aug 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509043; cv=none; b=ApSrJmOhagVuOnLaSCf06K9t+3LMhX2HDUW8DnOzlN3oTtVfbr4ycY11Pr9mulwu38i12R233EPrzTfkn2pwoSB+3ciN12wwjLoj744tbd2BLVldGAzZJGGfIrR5Vms5hFrhqsM0NiqFWmFFDWzAYTpf4wZvrN270WMjdycBO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509043; c=relaxed/simple;
	bh=R+FqgYeFfI0oIqaIfqH+R6PE25+PuyVjbwzjBTvhzVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhTQgn0LV7/loYHiuSykEC+6SRVfG1h7kkl5HIkkJsdABJDbz6e3VkkICRp3mIZEwfFCAiRS6fQNJ2bnQRHbnHsYcdqK8HnCVK9XShGHbHFzGclCqUJj9PFJiFYpKcAAdwFrigb1jmT/WJCd7lKRfVz6kJsP//5yZi+jF/Hp3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKYUvnb4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e44537dccso1598199b3a.1;
        Mon, 18 Aug 2025 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509041; x=1756113841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwBvcY4RCcWSaSeYC9UFBOB1LFbas4KaAkW06ayot2c=;
        b=nKYUvnb4iJmfDbG3mFs6M0qX1KxQ9jEK/ZjHSlc812kDB/SjxatZqm7Z902+9AmysQ
         7iCX2Bc+5U738vmrFJUkPmn7Ty8hOh/FLr1BhuCeMQYTSkECUPn9ISAUUkNcqST4KIqz
         mckIuuiNk56ffgP82VE5EyhKS2C7TKGtv/t0UMSetAk+EL8SZUCAyqH89KLYtfXPIRd5
         FMASC3Fv13Za8I+iNkCtBkEpfMcovanmIDTODV7YrncH6uCOgT2IoEyBz5JrwIeDuqwE
         f/iyZG8KpULvpd4epyvgkFOiq0jaR9iLgUqAabJ9jn7P+6B2N7QhbXy64ixCn33c4mXU
         vtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509041; x=1756113841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwBvcY4RCcWSaSeYC9UFBOB1LFbas4KaAkW06ayot2c=;
        b=i3/YWp4p8Sd4zKtNv9V3oYib7852jJHu+8uiA187xpytMmrXz+Ms5AhSet8gRyeXXf
         v3tcoItkTqYnTjRf35/lx+8HpHe50nXuHx3/C5FVTv4NtnjB96hYgfWIuqXd+9ByMzgQ
         KVVTWAsk7rKfcZUz2tOJWT8e7uaos7wMC1NnsAr6VF5OA4h7nXawYPOn8pqRKVJBtdm7
         TRv8x9yqslthY1JdTZL3gpuh5z2CX1qZoQU8LSX5KcGYW+bSG4MlAFmbL0QHQ+SfgRPW
         OoUwCotvbPb02SmdinYXZfLonHhHsB7MU25yeZWJCnZ9kffa87Pbi6zdqDD+kgYePZSm
         mUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z9fvRvgZV0kqiNYxsTpdHSTwS6D5EUzgOA1ZYiqaFN/uC3drMNNOVI/1lyaIchasU2G9bYiJQu02mcfLGL47@vger.kernel.org, AJvYcCUwRxUxyF1t9M8fey1hODL+GJWjyf9hJxxuCTrY1Oz5MTBnyYTlk5jrBPtgRJYNVgC/Dd6cN3SmqMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeupGUZvUg74ZjrWCsHZp88L4STqYen2TVhn1IkUNEEQiqFhs
	PFEF0LVBsBBs+LB4YbNmO2Sp4I5Z1ZDwF27aHWXGQhem4GtVCtoPKTrZuQTy29njQx4=
X-Gm-Gg: ASbGncsKxXVozoXxT7EHQ/4RdlZMWHp1tPp30JrU0exqHSDFb2UXi2399L+817iXcwW
	6E0WNBXdO7cBQEG6Xnp3fIw1AcvzpvHyJqOQ37B8XmDA+Lq6kv4SW1Xcps1avWHMqLqBDyWyHnl
	wb/Et67YibdgJieksF0Ji7iREGrP/I6FmoNLAJaotAZ54Sv9gzLse0xTH1Rap9/S1KuaPaLXzHi
	VjWaNR+xLtnR3Bk1IlYAkbX6PsZ52aR0SRGfIo9d3pFmabXJUtIwcvtx8Y4PWIKc4hlRtrz5jWu
	pNZvAIjMmAznua7o7MeC9j1UiYJnEfdEZdIxpjduk9Gyu1pWVwWSYT/uUbztqT9rFG+yFE4frtC
	KkgeHQCV/K3cXHs7vMHGe6+57AVPEPOOxBTCbK7CS3Q==
X-Google-Smtp-Source: AGHT+IEWCI6PCcdVhUtDeYnoiUR+eZvt3VJqnBYGBWXN2N6mvLU1aweGGGV88B18d4VsnUuudGiPKg==
X-Received: by 2002:a05:6a21:9999:b0:23f:f9c7:f45d with SMTP id adf61e73a8af0-240d3162ca4mr19403653637.22.1755509040938;
        Mon, 18 Aug 2025 02:24:00 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45592eeesm6604976b3a.104.2025.08.18.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:24:00 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/3] bonding: support aggregator selection based on port priority
Date: Mon, 18 Aug 2025 09:23:10 +0000
Message-ID: <20250818092311.383181-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818092311.383181-1-liuhangbin@gmail.com>
References: <20250818092311.383181-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new ad_select policy 'port_priority' that uses the per-port
actor priority values (set via ad_actor_port_prio) to determine
aggregator selection.

This allows administrators to influence which ports are preferred
for aggregation by assigning different priority values, providing
more flexible load balancing control in LACP configurations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst |  9 ++++++++-
 drivers/net/bonding/bond_3ad.c       | 27 +++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c   |  1 +
 include/net/bond_3ad.h               |  1 +
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 1ca7830c24ea..10d952c3c225 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -250,7 +250,14 @@ ad_select
 		ports (slaves).  Reselection occurs as described under the
 		"bandwidth" setting, above.
 
-	The bandwidth and count selection policies permit failover of
+	prio or 3
+
+		The active aggregator is chosen by the highest total sum of
+		actor port priorities across its active ports. Note this
+		priority is actor_port_prio, not per port prio, which is
+		used for primary reselect.
+
+	The bandwidth, count and prio selection policies permit failover of
 	802.3ad aggregations when partial failure of the active aggregator
 	occurs.  This keeps the aggregator with the highest availability
 	(either in bandwidth or in number of ports) active at all times.
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index eb0fb7374391..7a0fe057cb6b 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -747,6 +747,18 @@ static int __agg_active_ports(struct aggregator *agg)
 	return active;
 }
 
+static unsigned int __agg_ports_priority(const struct aggregator *agg)
+{
+	struct port *port = agg->lag_ports;
+	unsigned int prio = 0;
+
+	for (; port; port = port->next_port_in_aggregator)
+		if (port->is_enabled)
+			prio += port->actor_port_priority;
+
+	return prio;
+}
+
 /**
  * __get_agg_bandwidth - get the total bandwidth of an aggregator
  * @aggregator: the aggregator we're looking at
@@ -1707,6 +1719,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
 	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
 	 *     select by bandwidth.
 	 *
+	 * BOND_AD_PRIO: Select by total priority of ports. If priority
+	 *     is equal, select by count.
+	 *
 	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
 	 */
 	if (!best)
@@ -1725,6 +1740,14 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
 		return best;
 
 	switch (__get_agg_selection_mode(curr->lag_ports)) {
+	case BOND_AD_PRIO:
+		if (__agg_ports_priority(curr) > __agg_ports_priority(best))
+			return curr;
+
+		if (__agg_ports_priority(curr) < __agg_ports_priority(best))
+			return best;
+
+		fallthrough;
 	case BOND_AD_COUNT:
 		if (__agg_active_ports(curr) > __agg_active_ports(best))
 			return curr;
@@ -1790,6 +1813,10 @@ static int agg_device_up(const struct aggregator *agg)
  * (slaves), and reselect whenever a link state change takes place or the
  * set of slaves in the bond changes.
  *
+ * BOND_AD_PRIO: select the aggregator with highest total priority of ports
+ * (slaves), and reselect whenever a link state change takes place or the
+ * set of slaves in the bond changes.
+ *
  * FIXME: this function MUST be called with the first agg in the bond, or
  * __get_active_agg() won't work correctly. This function should be better
  * called with the bond itself, and retrieve the first agg from it.
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 8f78f83fb29c..16448ee2cef4 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -165,6 +165,7 @@ static const struct bond_opt_value bond_ad_select_tbl[] = {
 	{ "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
 	{ "bandwidth", BOND_AD_BANDWIDTH, 0},
 	{ "count",     BOND_AD_COUNT,     0},
+	{ "prio",      BOND_AD_PRIO,      0},
 	{ NULL,        -1,                0},
 };
 
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index bf551ca70359..34495df965f0 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -26,6 +26,7 @@ enum {
 	BOND_AD_STABLE = 0,
 	BOND_AD_BANDWIDTH = 1,
 	BOND_AD_COUNT = 2,
+	BOND_AD_PRIO = 3,
 };
 
 /* rx machine states(43.4.11 in the 802.3ad standard) */
-- 
2.50.1


