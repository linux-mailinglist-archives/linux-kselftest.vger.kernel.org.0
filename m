Return-Path: <linux-kselftest+bounces-40508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A87B3F5D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F12F205DB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E32E4266;
	Tue,  2 Sep 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHOjnbtZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22511CBA;
	Tue,  2 Sep 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795534; cv=none; b=WVdIrJJHBoRxmM3EXBm/0jvk6rDeJMeiXG+HVFunHIZeHj80DrqMIYdCmmI8ZVdkyBpDZhesNC1sEXZTHbFwDe55p+Tu4B90PaO1arTJqb9pdSQo4xq69IkRBkfeWqaHb65UX1uV6xOCtV6XSG03a1vX8sdyUdQEm4Cq3z1slYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795534; c=relaxed/simple;
	bh=+eEl2m6TKfSaL0Yru9MOtvYzTIoRjXZ7OWLtsLIgEis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/FbYLYK6GAcs+Wu179LrOy6hmCkJy9+dWABuauXrJN47G4eLXc6c9d+VJo006PUnLk3MSnrZTEhXBkgT7X+Mj8EFzcyuvwJ2MCpQcGiSqnAXeh0S4CZT50B2dPwS2dPJSzVk/7OyfiuGlELhYShOT9+3HtFvuRn9o31w68afvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHOjnbtZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b21006804so904895ad.3;
        Mon, 01 Sep 2025 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756795532; x=1757400332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YixYVVVha+6cM9X90RkHk/OZLZUvkDM0mcQ22otlc+U=;
        b=aHOjnbtZbZy+pluKJVzL/J7vteZCDQJH1VItvilJNk3SCOqaz4zCmB0quPMw8+ls9K
         gAXwgjecPdmQglCSV/Yle5KgyO0tAIXZfwwOyjuLs4TDOlz2hluoLehkiaQpYIbJ/1sN
         yLkkyuawE3tTn/r3yuhQn7YSiGTor+64AXALFl8NWRhPr5ktWzAs3PVBh+GE9WEoqclj
         x+umpGIGorrDHczdDIASZvKs3O4FeVas3bMWk8CvjDP7qbCdXt9zl0V8kn3+YUyLKl7y
         DobU/8T7Oc6bV1qABBsuIS9SwVO+158tYuEiady4415lSg89CoCMQRcbrQ/gP9qsPGBc
         TBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756795532; x=1757400332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YixYVVVha+6cM9X90RkHk/OZLZUvkDM0mcQ22otlc+U=;
        b=pqjJk8A6uViGWlXmlPKjKhIpzY221b0ffwoosW0BdNI25hX0b0TUdPNUJIn93KL9PE
         RCXkQVFGRrPluXAWP3QvHy6GkkbNxEWRP94cZQ8Ae9Rq7HKzUrB5RYjauVdDR/wOmPEE
         d1OVb1mK/hu3wFQC3gzgpS1BzRkOv30Vb3jdY+IQ+bpthy+QujPThgpCFehrqFt8F6hg
         ocq6YryUIB7VEnawFVP5HszJycBDIjtaGVMAhquyHxaHOxmJq/757mOK6u8aFKi9gkWh
         Ay4yvn9IuKGUAiSmTfk7rsicpgR9DNiaZCArIE5c+MNaBKf+cH3z5YS0LyKTcWZg+hSe
         9BbA==
X-Forwarded-Encrypted: i=1; AJvYcCWfbiPo2BKFW4/RL10g3xgtYL6iqm1kCCpmZx+8mOMUQmcgB3XLfFiUPNKpumgxhpHCvodyj6fTazgoqNNdi0b9@vger.kernel.org, AJvYcCXQFj2M+A0DEmRzVl/Ns4A5HrGrjnfvFb5s+l60jsSg9a7VtbHN5xVlqerq7K5AjlWJZPNLXy0uPF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAeOqFGcfmSXNHS3mfeZznce6OZD7XRH1C4hr+w9XmWTT2mtv
	jVTiddJjTB8qNjqyiv5Hogd/fOW8KcqB6DcRmYHRYHt68+gG2i4zV422NAfcvyfy28c=
X-Gm-Gg: ASbGncvQ7FbJ99rLJiZxcrHle7XQCXKq/l474mBWk27zuIKlhCkq/zFAWRmJurhda+Z
	OxJpHB/fHGo8aPie8XaT9Tnn4uIQE2ncitDc3rmgX8lwozA/H/+9eKzcOgGhDX3GwIZRjZ6PoJ4
	GV9ZkOEb8StrbfHC14wx897vUPZSBnx11/cYUaqPwQVXi9zEj+ndmYhktQEgeJo6vc5czV0HJa2
	tZdpRSSmzp5MptYwdCLlATgHUqw4iezCPlQfrRySHjrBoJ+G9dkOQAsc0sNqtY4HYmkbeNe8pA6
	ZsO0YLfzXUcBIdVfO4H9ocYRHgUMt6dW2LtDPytQtTg5PAUBmMqvtMWRd6pD7LtKde53YyqniUo
	wDcXpGwrRdWHO6o8E3ipec3kY4E2tYD+UEHnBYoy9aamJjhhFL7W+F+pSm4HrHcw=
X-Google-Smtp-Source: AGHT+IGTV2LjWsR/Olr7Gi92Y2iiScB0dKVp4Vmv8+HdmhMHSgrcKy8uLt8ILimkEOzwPBUD82I8/A==
X-Received: by 2002:a17:902:f54a:b0:24a:b073:c8e4 with SMTP id d9443c01a7336-24ab073cf85mr89197165ad.43.1756795531854;
        Mon, 01 Sep 2025 23:45:31 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd2ea3a04sm10936681a12.38.2025.09.01.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:45:31 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCHv5 net-next 2/3] bonding: support aggregator selection based on port priority
Date: Tue,  2 Sep 2025 06:45:00 +0000
Message-ID: <20250902064501.360822-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902064501.360822-1-liuhangbin@gmail.com>
References: <20250902064501.360822-1-liuhangbin@gmail.com>
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
 Documentation/networking/bonding.rst | 16 ++++++++++++----
 drivers/net/bonding/bond_3ad.c       | 27 +++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c   |  9 +++++----
 include/net/bond_3ad.h               |  1 +
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 1ca7830c24ea..706cf1312d71 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -250,10 +250,18 @@ ad_select
 		ports (slaves).  Reselection occurs as described under the
 		"bandwidth" setting, above.
 
-	The bandwidth and count selection policies permit failover of
-	802.3ad aggregations when partial failure of the active aggregator
-	occurs.  This keeps the aggregator with the highest availability
-	(either in bandwidth or in number of ports) active at all times.
+	actor_port_prio or 3
+
+		The active aggregator is chosen by the highest total sum of
+		actor port priorities across its active ports. Note this
+		priority is actor_port_prio, not per port prio, which is
+		used for primary reselect.
+
+	The bandwidth, count and actor_port_prio selection policies permit
+	failover of 802.3ad aggregations when partial failure of the active
+	aggregator occurs. This keeps the aggregator with the highest
+	availability (either in bandwidth, number of ports, or total value
+	of port priorities) active at all times.
 
 	This option was added in bonding version 3.4.0.
 
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 67ca78923b04..49717b7b82a2 100644
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
@@ -1708,6 +1720,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
 	 * 4.  Therefore, current and best both have partner replies or
 	 *     both do not, so perform selection policy:
 	 *
+	 * BOND_AD_PRIO: Select by total priority of ports. If priority
+	 *     is equal, select by count.
+	 *
 	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
 	 *     select by bandwidth.
 	 *
@@ -1729,6 +1744,14 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
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
@@ -1794,6 +1817,10 @@ static int agg_device_up(const struct aggregator *agg)
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
index 7cc9b033095b..a35733301bc3 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -162,10 +162,11 @@ static const struct bond_opt_value bond_lacp_rate_tbl[] = {
 };
 
 static const struct bond_opt_value bond_ad_select_tbl[] = {
-	{ "stable",    BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
-	{ "bandwidth", BOND_AD_BANDWIDTH, 0},
-	{ "count",     BOND_AD_COUNT,     0},
-	{ NULL,        -1,                0},
+	{ "stable",          BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
+	{ "bandwidth",       BOND_AD_BANDWIDTH, 0},
+	{ "count",           BOND_AD_COUNT,     0},
+	{ "actor_port_prio", BOND_AD_PRIO,      0},
+	{ NULL,              -1,                0},
 };
 
 static const struct bond_opt_value bond_num_peer_notif_tbl[] = {
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index e9188646e22e..c92d4a976246 100644
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


