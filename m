Return-Path: <linux-kselftest+bounces-38957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41024B26311
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6647B79F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78642EA742;
	Thu, 14 Aug 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io0waTje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CA2EBBBC;
	Thu, 14 Aug 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168212; cv=none; b=FxT6Q40dhSIxGsZ9AKTG5lmLrluB4xc2nUu4dInbnsA4bsS0yscIv1Al4isECkxKpBIVPL0M9hlvohvMCwEjYQPe4oCygyM0e0RD4gpWFYG1o7QUEEOxLG9Sfxt/dSlWLv8iUjz3DgPeTvZ5LksARoDgPPMTNU3ry02U++pUYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168212; c=relaxed/simple;
	bh=L6Ju7SUIgCuaMZnDM9JbZMDZMgLAXtPas8rQb+ZknrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrpCg3ZucZuBOU7y01vGt/lJf/+za3LAuCsK9/89JXjrvPLnxbsnICH1s702BYEd2y4+lcCun1pfqPYboeUA8jTOyA9Z2/OZVGcu0mW2+cr/VkcxJn/f5ZMjhM7FEVgfIe6B27DWMcgEE62bQv0J1AgpyaPOLS7eKVjw2gBVSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io0waTje; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47173a7e50so589388a12.1;
        Thu, 14 Aug 2025 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168210; x=1755773010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EItWOq9WdEjL3xAyQN6Wh7gj+6TcXnopI7+G+zkdXxM=;
        b=io0waTjezWRwzj1AT1BPutsIPJwBUkbjVcoMKwwd/OBTVmAM+wLt9qFRTG/35p/Y+R
         EZuGod6WDa92R2cchN+iZ5W1hmBLEXZBesY+HFwcGt7sPXQf563OiJoGTRIAv/JFtTgD
         rUkjWeoOWHY62Lqk7+PvBDZhWmo96fZM1F4JcHrKhGg6ybpxgAPpsntOtun96Ap2uu85
         i6scXCMaeh0sFBKKizYVFLl+pD717xeMuwzPSUtXy8KwzjdiR7lkN3EnIOmUZG2ORA+G
         k68wO64kJplry42UhhWcparRLMQ8dgaR4cpbp0htGvEDzPvLQPKmhDDWqJYe5m8Ewrnn
         7xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168210; x=1755773010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EItWOq9WdEjL3xAyQN6Wh7gj+6TcXnopI7+G+zkdXxM=;
        b=d3ZOqyfI5/dPNtOBFBdOkP1T85M1o2FOCR05qFDJlSB+e1yGa3WBrwvU50Iu4HDTmB
         wJhpPgYEVV2WbmzwJTflqZOHBf2V9Bsuu4G8XqYKBjtB9Sda9nb5tLWgrrlR0A7+YHKk
         I4PrqZCn03S+Es4o98nyKxUTr/0JftIT3LmqPr8rtuHMzPZ6qb2T9gjcd3SfIuQKDAl4
         ohdizwEswdIHxkocBQ0jq9PCwvnxnLm5agVytyjsKtBXT40PA4sJJl21yy7UfY2YzH9U
         dvixbDWeMl8FP09RaIc+jZYsz9ibyez77inrHd1bIwOHo+yo5+9WauIJvsZdY+shQ5vl
         uzDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKVYYnNcLm2GpATDejjWV8di5krE7BElmWsr/xKof6qBYryP8DUEvpOw3LKCLQuQjYSwyLyeu/7jk=@vger.kernel.org, AJvYcCUgb5s7LxOxcj2e3vzq8d59UX+Iq797bz/etCqOgziBDfmZZswRILJDCuIY6I/zySmfEmgseYxgesQ98jl3frTc@vger.kernel.org
X-Gm-Message-State: AOJu0YysAMqrQiu2W7UmHs0L6J/X8yByWU7993MUd+SuKSaWdMpDVs9N
	vxJ9vL0GZ7oyh3UexGx6dERiUHSEGp6mjuiKczFHgk/7eYFOL9UliOiotMSDM84e
X-Gm-Gg: ASbGncvPNSybiQgi4Soj3yVUkHBjowS5YTIgYRxZ5umphf1NaBPKljEn2td87axNKwO
	6wrmeVRx3c4ZKRHeX8XVASKnbsx9x04Iiu6FuauJw50oBDkqguuy2o1QpecdX4si0EUIyhvoQQI
	nSo/STYrWueEbtixZHm+Ghzq0G4eliksBhmRM1S7FeBBP2mmCRMhCwqXCoZ9oz31kFxStl5uPV8
	2RzUcILHYGfiTkCkbahxPTxoZGSE6NCZeAK5+CozjGmrWDJvD5Lo0F7ZKn1NcpD3Nfcy/06zgOq
	NRlriU3Qkv+PeeHj/vdKUJsQ2QqR7qZrLaYwTGrGrx0JUe+LakUzi0ln4e7QsMz9cPcTI0raHGw
	UL03YRVNkLPnHXA7r+2jInJu7mCF6Om05nTdtV+uo2g==
X-Google-Smtp-Source: AGHT+IE/+LBZblpVx3SB/22JjiExe8JpIigzJBWhOZw+PnrURUYdR+potMBAhdA2GoX033vCBOrGWA==
X-Received: by 2002:a17:902:cf0a:b0:235:eefe:68f4 with SMTP id d9443c01a7336-2445868f030mr29234075ad.29.1755168210232;
        Thu, 14 Aug 2025 03:43:30 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm351796225ad.78.2025.08.14.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:43:29 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/3] bonding: support aggregator selection based on port priority
Date: Thu, 14 Aug 2025 10:42:55 +0000
Message-ID: <20250814104256.18372-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814104256.18372-1-liuhangbin@gmail.com>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
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
index 874d8a4681ec..151c964562db 100644
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
+		priority is ad_actor_port_prio, not per port prio, which is
+		used for primary reselect.
+
+	The bandwidth, count and prio selection policies permit failover of
 	802.3ad aggregations when partial failure of the active aggregator
 	occurs.  This keeps the aggregator with the highest availability
 	(either in bandwidth or in number of ports) active at all times.
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 19b389b81600..dcc1a1750df5 100644
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
index 5b58326dd24c..4bfff38b9ad0 100644
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


