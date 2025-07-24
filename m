Return-Path: <linux-kselftest+bounces-37933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8DB10349
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2D1CE309A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FCD274FED;
	Thu, 24 Jul 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmGQMxas"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B220127B;
	Thu, 24 Jul 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345037; cv=none; b=PVxIlcbKzBNlSdxKmDrUbiu/9zs+3BtegbR+xHF/bmoPMrmGRQANrZAofxdiQB39bZjEmWkCILM93QHdkap6DbVjEjfgzz8Ejjgmu/MjDdAJNzGnzg0WjTZvZZ0TPD4/Z4O5Vis2YuFmm97DBW7vlRWqXUjMqy/Xn3CJ+XjRo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345037; c=relaxed/simple;
	bh=X9luu04fMOJ7fBr1sPQ+y9wsUOVz6Vo6plU++In+zA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzXXOjZBniMIPNTVM8mxRs9sibXyhQRLsoZzZ60DN3YARw+btJfTPjAx40VpA8gIM+y83GXEu5NX6p6Z9eNT+xM9flyNRrBV0OhFgsHwRhTM22LA5aTQ/WT9UbjkidXIgfIsdIBRg8Fe5GAuUx1OXWJn/XmQWWvWJT8yYDjb12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmGQMxas; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c44e014so619452b3a.3;
        Thu, 24 Jul 2025 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753345035; x=1753949835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6LMsfHLIpKIArigfFgHi7q/1uwSP7ojeqycHGuMcPU=;
        b=MmGQMxaspH9z79AGX3n/BFwdxLZDbLeq9P9JhrDXVEGtQe0zTqY2/Fuhr9h3s/SFG8
         0cWiiXHKqisOVkxbeRGu8xU63ZdOh4Cnymp6uySZDJp5jGFaawQRwxpSUizVSapDvgJo
         C6FRSCyAJqZEm4HNkLJAw2sVGSOSCEQjlYDOzwVOCVsS0l5Kq80fuHtjdJlN4pnJz4Co
         hOOloRXKexTFlNLlC6vMFX2fgbzl7LoJRw7Nwq3rx/jgs4ad2vPyJ/5D+6PZw2j8w+CZ
         QPHrEU96xnoHty0udORv6W7WIkf2KPDLml9g9vyxqI3vy7FhUwzMGKUjwDdoBKYAw46x
         jycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345035; x=1753949835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6LMsfHLIpKIArigfFgHi7q/1uwSP7ojeqycHGuMcPU=;
        b=BJwku7uYyVt3bqudx8D6jWNvxAUmVpHOLvePUGhnUHXOnOB7/RjJf5MfkK1MfpxyzN
         xhcAe+p1SKlhmYq4kvFXpSIrrDRDSUphEB2fIaz0J2omKpqHgdZpyuKWOIIWscfPmUh/
         cP784o+c66SuultA9tb639lKnUo6p+axZCoswb3eeo6SRZhcCM1O2xDgFhc+G2JDrMdz
         9kGnSTQtnrfaPUS3rlMXn6Yn+PYyExpffMOS4hMzbEu3vCcLm8b5evvOyVWIv9iWvIYu
         ppyj4htE6iswE6xWc/TlCfMCH0LF2PrBaDeyXt70vpxfgIIKRo9EYgI3cys7kEw+SjP4
         ZfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5mjbj3kigRxZcng3B75y48xTp6kvf6iViX+Ky+x2OxdVrEYJn7gw53xQQZL8Nsv/cDrwzBQuaDoZ4coNw@vger.kernel.org, AJvYcCVTDrmh9Ops+fMFLxIPv+oyHUlyeOkgggKIwi/xQ7l54pupwghOhcK25PS7+SovL0xESKDcIZ/9KfRVr6H/eh2w@vger.kernel.org, AJvYcCVoiykngIkCohndeSfBMWJicn4W3WNgV7w+mXe6WozZ6V4LYuBBAq3OuqRLZOi0KoS0YKYVcd7umyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EmE7RvnqZqgzZoNudryW1VtXcq8MlX9F+e7lyT6QL9t1hZUL
	aTJKEdZxnrWuch27RPV9GfiNyFlD5iMqAL/XMPsuQ1DXH3yPZLX0mmXyYR7fAkQ3
X-Gm-Gg: ASbGncvyt0LbC2mcAAIpwrQOdIG68ZGfGFI8MU27yTIRBN0uJGXLr7KdTe3EP1jx4AQ
	z+p5jIQzanczxNd0TL4ft7S5xmg2gXZ7aJD59lqqNvmteAyg6OeP9U8Bb4PBydhHuX2KVWSuiM4
	t92WjQzvv9cqRZl/xliTdLN0EoYwJOxWiKIXb4uC69B3UKnMwnukjITo/ZW2FURTO6DGoFDp0LA
	5cYoU5O4eQahGd566fbe8kV0LahSJm1HJBXGNwcKeJASb5OITcz03UH90ZUj9e2VfexGUHgezII
	f3Lrd6YORuPgNA5rr4C7fbIX0U7SwCfvugMZ5LbhsTnjWoJ5dFtdC0uB1ysVPODIJYaj6UzlrJQ
	ldfjh5fHWblQzwmuFvdLCrA+wlDEgLh80s8VbD2dvQCkdVfI=
X-Google-Smtp-Source: AGHT+IGTDblVYTvdY+9K+d2w6/YOegYxn76AqrB/KFLUQIuMVH8krKT1K6So44Imi3w1nWhGAtguWw==
X-Received: by 2002:a05:6a20:3d83:b0:21f:a6c9:34d with SMTP id adf61e73a8af0-23d48fec363mr9232902637.1.1753345034945;
        Thu, 24 Jul 2025 01:17:14 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7bbeesm1074704b3a.24.2025.07.24.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:17:14 -0700 (PDT)
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
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/3] bonding: support aggregator selection based on port priority
Date: Thu, 24 Jul 2025 08:16:31 +0000
Message-ID: <20250724081632.12921-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250724081632.12921-1-liuhangbin@gmail.com>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that per-port actor priority is supported via ad_actor_port_prio, enable
a new ad_select policy to choose the aggregator based on port priority.

This allows users to influence aggregator selection by assigning higher
or lower priorities to individual ports.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst |  9 ++++++++-
 drivers/net/bonding/bond_3ad.c       | 29 ++++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c   |  1 +
 include/net/bond_3ad.h               |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 5e105e7ac8e6..a234ec12ece7 100644
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
index 4a1b2f01fe37..6f8a406ed34a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -747,6 +747,20 @@ static int __agg_active_ports(struct aggregator *agg)
 	return active;
 }
 
+static unsigned int __agg_ports_priority(struct aggregator *agg)
+{
+	struct port *port;
+	unsigned int prio = 0;
+
+	for (port = agg->lag_ports; port;
+	     port = port->next_port_in_aggregator) {
+		if (port->is_enabled)
+			prio += port->actor_port_priority;
+	}
+
+	return prio;
+}
+
 /**
  * __get_agg_bandwidth - get the total bandwidth of an aggregator
  * @aggregator: the aggregator we're looking at
@@ -1695,6 +1709,9 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
 	 * BOND_AD_COUNT: Select by count of ports.  If count is equal,
 	 *     select by bandwidth.
 	 *
+	 * BOND_AD_PRIO: Select by total priority of ports. If priority
+	 *     is equal, select by count.
+	 *
 	 * BOND_AD_STABLE, BOND_AD_BANDWIDTH: Select by bandwidth.
 	 */
 	if (!best)
@@ -1713,6 +1730,14 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
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
@@ -1778,6 +1803,10 @@ static int agg_device_up(const struct aggregator *agg)
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
index 2b8606b4e4f5..708ca1f18a00 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -163,6 +163,7 @@ static const struct bond_opt_value bond_ad_select_tbl[] = {
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
2.46.0


