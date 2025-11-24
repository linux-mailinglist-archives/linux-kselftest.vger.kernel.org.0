Return-Path: <linux-kselftest+bounces-46364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11CC7EF26
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 05:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654053A1B70
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 04:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA844296BBA;
	Mon, 24 Nov 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkTBklUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9B296BAF
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958839; cv=none; b=Fs7qPsACPP90+CKm7SG8qh4iq1iAl4dBYORiGrX/z2wJxW6VK99sJqMOO3psoifIbSYTzg0OvyEOoqNktHMoMrQEeeNukkE23+rOmhtfxrRAqDeLMm5SpiS1VAvvZj7gAKR3g9c626UExhzDJfwYd9SThpD+VWGtZ8dDDN6Q6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958839; c=relaxed/simple;
	bh=1xQC3PXFZVlXT5DefNO8BMoRVIF/VNPF732QUiHqA8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysk04/UaYSvaOVmYFPVfBMjqYVMJuRtg7c9Ht5FFbvEEmBzttbzwTphB+OqR0+uRkNRknv7FMIxkK91whoxyqZKZ01dyosVA2UxwcXKbrv9gzAKpiwQOu9Sr5KoNJ+LBCNtqMhkNBiEPDBnkppQ4B+hpdM5Hzu1ZlwSk07lLN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkTBklUj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so3113470a91.0
        for <linux-kselftest@vger.kernel.org>; Sun, 23 Nov 2025 20:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958837; x=1764563637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRBpoPkU7UGqU0piOkFoRKlzbwHKGDOQx8cJk7SlG3k=;
        b=ZkTBklUjqalCXdL9WmSwYeLTLkcbtaw3EtUCeBwqfncJFyTtxakXp6lTlARWyGIsnr
         CFGfa7h7FDUqPPxFPIaVeH4BTHTR9nACQh1arkur/ku8Cpnxeupfn4CYtrSn6GNiZc8y
         MVIladJrr70RVEeh0PzxIFR+gg193G6HZfdqL+xoX7w4TqEMcGfmLegAxxV3+RK0fBMH
         9cR/d6PAL43BZ4hbZOOU2fS0V0zZ47Vy4oL7GJUtNxPX9TtnoXQa1c8VlDdb3IhoPxpN
         kTqBqssqlEb2V9d7GDLhHEcibf1B0XXSdhnBDnCnn58B0qThRaCaO50+8N40MRlOpEfG
         pUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958837; x=1764563637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRBpoPkU7UGqU0piOkFoRKlzbwHKGDOQx8cJk7SlG3k=;
        b=VUVkQZUkeQmvC++o+HxjYx5a9VMBBqVrFyskc5IJnX8PuzWHL5OeFjpWY5J19x4hDi
         aCqIssvtWXsUlSNTDmgbYM38CrkdF/Ej6wMHn1kXS31SvBQzE2cecceOjvTAiip7/wpg
         MFZ8x2U3nPvdVoBbX5P4ZujnhLRHcpuy7hH3eZVfQXKmB4IdBTQkMCNLB5pzFi3qv9hB
         UcVu5i1N/ujJ6zY0RP+WnPowvXzQxHMe8EVKDRHgoMCqf33Z1uL5v8KIOMUV07rY8AAZ
         C25V21TTHO7ZGd91zF2eZHcOxu95+v1rnYLyRlEHyeg8PVdYH2BaU19ezGYOJI93epN4
         rDyA==
X-Forwarded-Encrypted: i=1; AJvYcCXgeyC98hw7P5691yRIID59pUlwK9ltFXxI/U14nOzG6+X8WBx3dLFFv86LXA/MyxTh23mvQTZOcOvReV1THz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaXKO650I5haKYrgvio3UsbUrlL7Rnh73d3ZJSr5wjGyfN+4r
	HIzgxFysVSRnMVHmpwksRepNOQiyfaaCw/IwPmlK0LB8XTFfQJbkT8XG
X-Gm-Gg: ASbGnctjtnQ3oWeIY+orCC8G8dWGenyBPZ6EhlOoybBhyyWwZ7ULbX2YylxQJGivbdY
	aan9Mou6IPrIJeQKzZ7Y0AnqPKFs/3gSk7AYu8UxyAJy9OnxuWWUhGaViucqm1Ukabby3GiXn8F
	ov/AJzdWZHPCwtSpTlZByJJXwKZExYhrpCUu0txK/rLi5RsuNV75XKWPPKTl0sAx3fCTkVaz90C
	r4alUqNv8811sFrhGKeYackUhe9g6INGIxAJ/8ZYobyU3ycBciFaxCTSIvc2EcihY8mzEhgW0zh
	1GjcJT9GaAHq6lEhRTmDsfuGI4saOD1p44ENTEgZa6apBmyqEHaLbgIFi1VuSKQ2iIguxkw/8aY
	ddva962+6/MM0dZcnnMk0jI2NV7oJqUxW14653HV0/QgJy/4H83IE1roqY7Az/KD6qXL9u/6DmL
	F4Rs4dKNr70U/o0vo=
X-Google-Smtp-Source: AGHT+IEzWCSHHvzBhSDG1oykXuu/eELH6u006Y8umJvq7W17yg0Y9nssged96A37BeYpxFGf3/3w/A==
X-Received: by 2002:a17:90b:4e8d:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-34733e4a359mr9487789a91.5.1763958837156;
        Sun, 23 Nov 2025 20:33:57 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:33:56 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net 2/3] bonding: restructure ad_churn_machine
Date: Mon, 24 Nov 2025 04:33:09 +0000
Message-ID: <20251124043310.34073-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124043310.34073-1-liuhangbin@gmail.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current ad_churn_machine implementation only transitions the
actor/partner churn state to churned or none after the churn timer expires.
However, IEEE 802.1AX-2014 specifies that a port should enter the none
state immediately once the actor’s port state enters synchronization.

Another issue is that if the churn timer expires while the churn machine is
not in the monitor state (e.g. already in churn), the state may remain
stuck indefinitely with no further transitions. This becomes visible in
multi-aggregator scenarios. For example:

Ports 1 and 2 are in aggregator 1 (active)
Ports 3 and 4 are in aggregator 2 (backup)

Ports 1 and 2 should be in none
Ports 3 and 4 should be in churned

If a failover occurs due to port 2 link down/up, aggregator 2 becomes active.
Under the current implementation, the resulting states may look like:

agg 1 (backup): port 1 -> none, port 2 -> churned
agg 2 (active): ports 3,4 keep in churned.

The root cause is that ad_churn_machine() only clears the
AD_PORT_CHURNED flag and starts a timer. When a churned port becomes active,
its RX state becomes AD_RX_CURRENT, preventing the churn flag from being set
again, leaving no way to retrigger the timer. Fixing this solely in
ad_rx_machine() is insufficient.

This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
(Figures 6-23 and 6-24), ensuring correct churn detection, state transitions,
and timer behavior. With new implementation, there is no need to set
AD_PORT_CHURNED in ad_rx_machine().

Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
Reported-by: Liang Li <liali@redhat.com>
Tested-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 104 ++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index d6bd3615d129..98b8d5040148 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1240,7 +1240,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	/* first, check if port was reinitialized */
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_rx_state = AD_RX_INITIALIZE;
-		port->sm_vars |= AD_PORT_CHURNED;
 	/* check if port is not enabled */
 	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
 		port->sm_rx_state = AD_RX_PORT_DISABLED;
@@ -1248,8 +1247,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	else if (lacpdu && ((port->sm_rx_state == AD_RX_EXPIRED) ||
 		 (port->sm_rx_state == AD_RX_DEFAULTED) ||
 		 (port->sm_rx_state == AD_RX_CURRENT))) {
-		if (port->sm_rx_state != AD_RX_CURRENT)
-			port->sm_vars |= AD_PORT_CHURNED;
 		port->sm_rx_timer_counter = 0;
 		port->sm_rx_state = AD_RX_CURRENT;
 	} else {
@@ -1333,7 +1330,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
-			port->sm_vars |= AD_PORT_CHURNED;
 			break;
 		case AD_RX_DEFAULTED:
 			__update_default_selected(port);
@@ -1365,39 +1361,107 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
  * ad_churn_machine - handle port churn's state machine
  * @port: the port we're looking at
  *
+ * IEEE 802.1AX-2014 Figure 6-23 - Actor Churn Detection machine state diagram
+ *
+ *                                                     BEGIN || (! port_enabled)
+ *                                                               |
+ *                                      (3)                (1)   v
+ *   +----------------------+     ActorPort.Sync     +-------------------------+
+ *   |    NO_ACTOR_CHURN    | <--------------------- |   ACTOR_CHURN_MONITOR   |
+ *   |======================|                        |=========================|
+ *   | actor_churn = FALSE; |    ! ActorPort.Sync    | actor_churn = FALSE;    |
+ *   |                      | ---------------------> | Start actor_churn_timer |
+ *   +----------------------+           (4)          +-------------------------+
+ *             ^                                                 |
+ *             |                                                 |
+ *             |                                      actor_churn_timer expired
+ *             |                                                 |
+ *       ActorPort.Sync                                          |  (2)
+ *             |              +--------------------+             |
+ *        (3)  |              |   ACTOR_CHURN      |             |
+ *             |              |====================|             |
+ *             +------------- | actor_churn = True | <-----------+
+ *                            |                    |
+ *                            +--------------------+
+ *
+ * Similar for the Figure 6-24 - Partner Churn Detection machine state diagram
  */
 static void ad_churn_machine(struct port *port)
 {
-	if (port->sm_vars & AD_PORT_CHURNED) {
+	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
+	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
+	bool partner_churned = port->sm_vars & AD_PORT_PARTNER_CHURN;
+	bool actor_churned = port->sm_vars & AD_PORT_ACTOR_CHURN;
+
+	/* ---- 1. begin or port not enabled ---- */
+	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
 		port->sm_vars &= ~AD_PORT_CHURNED;
+
 		port->sm_churn_actor_state = AD_CHURN_MONITOR;
 		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+
 		port->sm_churn_actor_timer_counter =
 			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
 		port->sm_churn_partner_timer_counter =
-			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
+			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
+
 		return;
 	}
-	if (port->sm_churn_actor_timer_counter &&
-	    !(--port->sm_churn_actor_timer_counter) &&
-	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
-		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
+
+	if (port->sm_churn_actor_timer_counter)
+		port->sm_churn_actor_timer_counter--;
+
+	if (port->sm_churn_partner_timer_counter)
+		port->sm_churn_partner_timer_counter--;
+
+	/* ---- 2. timer expired, enter CHURN ---- */
+	if (port->sm_churn_actor_state == AD_CHURN_MONITOR &&
+	    !actor_churned && !port->sm_churn_actor_timer_counter) {
+		port->sm_vars |= AD_PORT_ACTOR_CHURN;
+		port->sm_churn_actor_state = AD_CHURN;
+		port->churn_actor_count++;
+		actor_churned = true;
+	}
+
+	if (port->sm_churn_partner_state == AD_CHURN_MONITOR &&
+	    !partner_churned && !port->sm_churn_partner_timer_counter) {
+		port->sm_vars |= AD_PORT_PARTNER_CHURN;
+		port->sm_churn_partner_state = AD_CHURN;
+		port->churn_partner_count++;
+		partner_churned = true;
+	}
+
+	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
+	if ((port->sm_churn_actor_state == AD_CHURN_MONITOR && !actor_churned) ||
+	    (port->sm_churn_actor_state == AD_CHURN && actor_churned)) {
+		if (actor_synced) {
+			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
 			port->sm_churn_actor_state = AD_NO_CHURN;
-		} else {
-			port->churn_actor_count++;
-			port->sm_churn_actor_state = AD_CHURN;
+			actor_churned = false;
 		}
 	}
-	if (port->sm_churn_partner_timer_counter &&
-	    !(--port->sm_churn_partner_timer_counter) &&
-	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
-		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
+
+	if ((port->sm_churn_partner_state == AD_CHURN_MONITOR && !partner_churned) ||
+	    (port->sm_churn_partner_state == AD_CHURN && partner_churned)) {
+		if (partner_synced) {
+			port->sm_vars &= ~AD_PORT_PARTNER_CHURN;
 			port->sm_churn_partner_state = AD_NO_CHURN;
-		} else {
-			port->churn_partner_count++;
-			port->sm_churn_partner_state = AD_CHURN;
+			partner_churned = false;
 		}
 	}
+
+	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
+	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_churned && !actor_synced) {
+		port->sm_churn_actor_state = AD_CHURN_MONITOR;
+		port->sm_churn_actor_timer_counter =
+			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
+	}
+
+	if (port->sm_churn_partner_state == AD_NO_CHURN && !partner_churned && !partner_synced) {
+		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+		port->sm_churn_partner_timer_counter =
+			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
+	}
 }
 
 /**
-- 
2.50.1


