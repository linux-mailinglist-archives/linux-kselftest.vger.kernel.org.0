Return-Path: <linux-kselftest+bounces-39822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC6B336AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 08:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD218975F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A628505E;
	Mon, 25 Aug 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQCKxdu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97828506F;
	Mon, 25 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104344; cv=none; b=MuOmf5DcWhE6mue+5MsuPj8NcDz9JqZJKeY1+UwchzWX0CyUqNzQVJtlkjpBdMiC2NaDLNdVl/xepfpo3XeV1u2m6AVvF1GrzzvCwyb9Ln0E1ckJnbJnWF0maqcyM1tKn2qNEFmi55+7J4fClcd6ZlciRBAZRE7BOl5tnyfLYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104344; c=relaxed/simple;
	bh=WaaDNHMKOQgGLiCg+WvOFieSpsMXD+y7E4v7eTNsWUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsGjqon/EH/YNvozJj21elNyQsYuRsCVb0LK/3xVOINHMebmBgyrlziYXi4vmj21CdKrToqk3gMno54/GC+MVzX2Wc64Pywa5PWELYHevNxi2hPkKFIUgs7gy+P/zZxcyk+sM7fEC2PGbS8eXyYV2hAPtbyH8cRA0I30pZ5p5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQCKxdu5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so3045575a91.2;
        Sun, 24 Aug 2025 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104342; x=1756709142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdspFmNMsfdlSXA03TMQzYyad4IWPC+538+i/kAv9CM=;
        b=eQCKxdu5B5Aao+PQnaZNjch2+mXAQWhHhMdUfNaA1A0fVXVaocXJq8NpyZX7Qsa70T
         rGmuiKGrao6LoCNaUdj2ZVNBslfNn1VXTp/4zH1FsxW7bVrUUT2oNNc93VGiWHOUa3wT
         MdnXDxTQriYAZZ4IvW0isvj9/wM5rjBp41/4KgEnOOKCO8iC8bMWo9Rb6Oek+ZHw9mST
         +VM6G7wChq+Z64YSKSkYJfcUofQ/tvF1HuEsBVxZBVMm3rKabxmYL8zdWWfp2bA6/C8G
         tXxQFYNiLH0M5ypwDjlRj8eNDIdb+Tz53IisTHcqubUUWDbSMb+ZOFaCFri9alaVDQh8
         XqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104342; x=1756709142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdspFmNMsfdlSXA03TMQzYyad4IWPC+538+i/kAv9CM=;
        b=gxoIiM699ylzX7avLLCY1Wdy91ECcz+vgmw3b5A5keV4OwG9acRx+x6FEtd688aJbE
         xUAMXJarXCCW6bMUQuevj7AVVOQo8tUgCqxgc5w7cVLTUHQi8jQ1ontNbIjvoilCQk8V
         URW3dyyy/ldw41+fbLL/3H2JqfjnBlhE7p6/ZFAFCkTCdG7chyWTwjqJI15CbpUmDoTO
         d6ReQMBjhnoq9t2Gyc4+S1GjQ9PBq2m0+/LHY1DsDqPOuekcL7h52WB1TOvqteEiyB1d
         5K9XB2RzlMLS15+nnsfZE3y9BSkdibHmkVDy3l4pXWYSyF1nJCOcZFzNQUKsFz/xVewi
         qblQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEiE1W7Pz3cwKab4J1S5qhE9J33sN5aGLCTS2mzIUdEmte+GTSM0asuKInW9q95y8KWtAZzQB4e3c=@vger.kernel.org, AJvYcCVKHloEdfkKiJpQS4e9TdvqCO192vPsqRewQXcvnxtSDb40TdON/jdaCHDaT/483zTq2onEzaxFUuWsDdsDmBeN@vger.kernel.org
X-Gm-Message-State: AOJu0YweAGc8od41CSlKydKBHy2gBgHYHQxZKP6OJXCywWHRdUlM0hjM
	ho097Su2e4iryI4ROwpl1/IvghjeksZKeRBYVa4JUmOznUMb91jgE5CNI0WByxRs
X-Gm-Gg: ASbGncvgFxmuZeotXR43jWPYuhhVFDoqZhTggej6rmhnVzNiTrZ64AzbaUaoOX+iSBH
	boo1J4AhhujlHpheLzHInp6ifwNTg53fVIgBe1sU1qNjyYXRSFqMAuYUWLUKOuyfCQLMFOQk4qv
	2u7E8cIVxNAm1vhcr7dhJegSvFb5a7oYzx4bYiO15HNsFALyeIBDPMCXKXse0zYKkY+iKA9Fk3J
	EGHnhD2tcxL++euUqcu+L+s556dctD3WRJxlKH2DLbVtFZGlMqSn8b119lstGBNVQej/z4kM9ce
	/gRAHqBfomIz+0HSYyi49lxZKHNPq07OEqhbe5tGKT2CoZU78517iACy9dZ/stP+BOiwpJnEAL1
	hslsWYzOzxMnjavujiP6jnV1TW6XpDfTfxHoOxMswxg==
X-Google-Smtp-Source: AGHT+IF08hkP2OnrjAGVZxXzwRQEzHh+Zw1qoZrF80V3daAN3fxpaWSdAdx4+pHG5lmuMtKXb7z26A==
X-Received: by 2002:a17:90a:dfcb:b0:31e:c62b:477b with SMTP id 98e67ed59e1d1-32515ec9f34mr11541955a91.11.1756104341771;
        Sun, 24 Aug 2025 23:45:41 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm5978118a91.18.2025.08.24.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:45:41 -0700 (PDT)
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
Subject: [PATCHv4 net-next 2/3] bonding: support aggregator selection based on port priority
Date: Mon, 25 Aug 2025 06:45:15 +0000
Message-ID: <20250825064516.421275-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825064516.421275-1-liuhangbin@gmail.com>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
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
index 7cc9b033095b..ee549c96945b 100644
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


