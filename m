Return-Path: <linux-kselftest+bounces-48908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB82D1CB91
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 07:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3826301C3CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7136CE1A;
	Wed, 14 Jan 2026 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4oH3VQP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2B36E47C
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373405; cv=none; b=ccokxS2ZmLSQLQbdvl5EwEwuQeGOxwrrbDdNhoRe4m7tnFFx1n4TvdPtR9w8CZrpD2q2kM2QOf6f3g3fPIPgQBz9VIn3KiYV3/dOV37sOvmNXtZN3KBkxWrEhjGd7oriC7E0EZ9GaiMZbj4rkTA2CaaDYWIleQJIzX3PfkUxlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373405; c=relaxed/simple;
	bh=0R/dBKf944EQx8pEmvyqKum4VIhIbTlogzkyEmg6Rdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ffw0Vp2/Os/aKRHSfcopyDSpKlKyz6qaPuVUXOom5BrM3Vel3tfupj3iZN/Bgj5KEU4OLOkiUf0HeCcP6LFnL9LWL8Xf4UJQogNWzYYRjcgmc9fRNXO2qP+KwoNTDGDpDGvSz3ZZGdKOx29POZ3JwMrCSAK8us10EzLj3loHTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4oH3VQP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso241220a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 22:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373396; x=1768978196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZfDYhswA92Nlf/7cLmt9NuonT5imrnRxL/6I454NmI=;
        b=D4oH3VQPGh7HJlc0vTeNKqjpbuObSuvMD2f5kEfEr5Ksf0cgSAeGRdz8Hcj3mA/pgV
         7Eom7aT+/OI5iA0yvB9EBm3L4gRP2PkjVPQKxru9mALG+loSkdmvGVNP0O4nZX3r64++
         2gurFEfWNWmJ0lEaCJLfTViUJMI2sqwxiL/xDLkew1VbCZrhLb5rdUhdVdC8bbGqWvWv
         arEZZmrRhuNrZoV/n7o3tAqXT4Icdz+pTKHAux0Qjnot7pozd111W3vdntIQQch3izcj
         lg7C26garDxbSLtrcrsd559kmYg3/rQJUARdYIwUFA94hfZH3UOz+Ff64OlecxCuTehg
         AF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373396; x=1768978196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZfDYhswA92Nlf/7cLmt9NuonT5imrnRxL/6I454NmI=;
        b=Ml7grofVeXHeKb5ejQcyUwuNhtlkaVHTEXvty5UN3fQvCsPHzn9q2W+XGiFD6nR8mE
         9etZ9yGsT+U6AlRPzT2dpyhP0LtL7X4BSPZefKl+cYzWxqsTBnNW4gptv0UdyyJzDQAK
         /PlGnXAF3fyPVl720OTEaE6yaFXMURg7ylEbWjMNczAsq48rUO/2BwecIvZWVQTLClv7
         ZhGRymndLwvsP9eccTO9miEU09PZti5KB94u9Bs4QJHdv8+BSpad3ATerM8TL+qmKXzo
         QRa7osAng3kL0E1dSNRcXlZH1zEnJGCXTO86Nbw5sv46z4FkkmlH6rcvoHfV3UESwI/6
         3Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCWiAJl3+yxB5ZOO6ms3CTCEpx9Kqb0BHQKCnFMQuePR/+JTH9CFOMnJbOHu71rs11ikLnk8Srtt/Tf62nxg+SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIeQl62TsfRMEVykxq1w/6blJFmXAvimKJhEZsZqKknHwWbgGx
	9UI7b+t/tGCWuIkClf21S32zJMHQ2txHzXpMFRQQr60kMltLOCRVnFRIkDwoD0Ty
X-Gm-Gg: AY/fxX6umudf5jEYWivBsAgZ8oi0ZxknHTY3mCNmLG4dx+y8Px7oR4dUy9qJdd9IKUY
	q+rRHtAMgG7ijU7cAT+Qq8So97bJsyDZnqSTecq5lV4LVDcCXhQMaq2F4LEeFm6VwIOO3WWfg2m
	/jHxtPNF53kP7MNSEMs866T81ZwXbKafA09PFkvPNE86w0vbxT5TzlS5Dcyr/QpBemco81EYzjj
	zDi4s7gTK0Ph3bLZVBLsiPej5i04y+wi+1cuB4v+IHPZWcHobUJMkjLpFcmyz50VK/wn+NecULo
	fCUp9TXie9MEQI/gL4WDUBh2ZrGlt0zY9WAFL5saJWuuLJVv0SMrdAk3i+bZSesE2qZ1u3uzo2e
	dkOp9ooo3jw2urUu4FbSfVbfVMuYH66QtxpFN0l7NLCODF4IrpJoDiaAds55V+T1mEeoGjCFkzl
	yrD4JfPyTYmjyaPB7Y0DHywsT9nA==
X-Received: by 2002:a17:903:2344:b0:2a3:ccfc:4de5 with SMTP id d9443c01a7336-2a58b49e424mr58071045ad.5.1768373395689;
        Tue, 13 Jan 2026 22:49:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:54 -0800 (PST)
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
Subject: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Date: Wed, 14 Jan 2026 06:49:20 +0000
Message-ID: <20260114064921.57686-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_3ad.c | 96 +++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index bcf9833e5436..154e06e345ad 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -44,7 +44,6 @@
 #define AD_PORT_STANDBY         0x80
 #define AD_PORT_SELECTED        0x100
 #define AD_PORT_MOVED           0x200
-#define AD_PORT_CHURNED         (AD_PORT_ACTOR_CHURN | AD_PORT_PARTNER_CHURN)
 
 /* Port Key definitions
  * key is determined according to the link speed, duplex and
@@ -1248,7 +1247,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	/* first, check if port was reinitialized */
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_rx_state = AD_RX_INITIALIZE;
-		port->sm_vars |= AD_PORT_CHURNED;
 	/* check if port is not enabled */
 	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
 		port->sm_rx_state = AD_RX_PORT_DISABLED;
@@ -1256,8 +1254,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	else if (lacpdu && ((port->sm_rx_state == AD_RX_EXPIRED) ||
 		 (port->sm_rx_state == AD_RX_DEFAULTED) ||
 		 (port->sm_rx_state == AD_RX_CURRENT))) {
-		if (port->sm_rx_state != AD_RX_CURRENT)
-			port->sm_vars |= AD_PORT_CHURNED;
 		port->sm_rx_timer_counter = 0;
 		port->sm_rx_state = AD_RX_CURRENT;
 	} else {
@@ -1341,7 +1337,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
-			port->sm_vars |= AD_PORT_CHURNED;
 			break;
 		case AD_RX_DEFAULTED:
 			__update_default_selected(port);
@@ -1373,11 +1368,41 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
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
+ *
+ * We don’t need to check actor_churn, because it can only be true when the
+ * state is ACTOR_CHURN.
  */
 static void ad_churn_machine(struct port *port)
 {
-	if (port->sm_vars & AD_PORT_CHURNED) {
-		port->sm_vars &= ~AD_PORT_CHURNED;
+	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
+	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
+
+	/* ---- 1. begin or port not enabled ---- */
+	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
 		port->sm_churn_actor_state = AD_CHURN_MONITOR;
 		port->sm_churn_partner_state = AD_CHURN_MONITOR;
 		port->sm_churn_actor_timer_counter =
@@ -1386,25 +1411,46 @@ static void ad_churn_machine(struct port *port)
 			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
 		return;
 	}
-	if (port->sm_churn_actor_timer_counter &&
-	    !(--port->sm_churn_actor_timer_counter) &&
-	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
-		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_actor_state = AD_NO_CHURN;
-		} else {
-			port->churn_actor_count++;
-			port->sm_churn_actor_state = AD_CHURN;
-		}
+
+	if (port->sm_churn_actor_timer_counter)
+		port->sm_churn_actor_timer_counter--;
+
+	if (port->sm_churn_partner_timer_counter)
+		port->sm_churn_partner_timer_counter--;
+
+	/* ---- 2. timer expired, enter CHURN ---- */
+	if (port->sm_churn_actor_state == AD_CHURN_MONITOR &&
+	    !port->sm_churn_actor_timer_counter) {
+		port->sm_churn_actor_state = AD_CHURN;
+		port->churn_actor_count++;
 	}
-	if (port->sm_churn_partner_timer_counter &&
-	    !(--port->sm_churn_partner_timer_counter) &&
-	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
-		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_partner_state = AD_NO_CHURN;
-		} else {
-			port->churn_partner_count++;
-			port->sm_churn_partner_state = AD_CHURN;
-		}
+
+	if (port->sm_churn_partner_state == AD_CHURN_MONITOR &&
+	    !port->sm_churn_partner_timer_counter) {
+		port->sm_churn_partner_state = AD_CHURN;
+		port->churn_partner_count++;
+	}
+
+	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
+	if ((port->sm_churn_actor_state == AD_CHURN_MONITOR ||
+	     port->sm_churn_actor_state == AD_CHURN) && actor_synced)
+		port->sm_churn_actor_state = AD_NO_CHURN;
+
+	if ((port->sm_churn_partner_state == AD_CHURN_MONITOR ||
+	     port->sm_churn_partner_state == AD_CHURN) && partner_synced)
+		port->sm_churn_partner_state = AD_NO_CHURN;
+
+	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
+	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_synced) {
+		port->sm_churn_actor_state = AD_CHURN_MONITOR;
+		port->sm_churn_actor_timer_counter =
+			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
+	}
+
+	if (port->sm_churn_partner_state == AD_NO_CHURN && !partner_synced) {
+		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+		port->sm_churn_partner_timer_counter =
+			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
 	}
 }
 
-- 
2.50.1


