Return-Path: <linux-kselftest+bounces-39061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5420B27919
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D64B6176C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC82BEFF4;
	Fri, 15 Aug 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE6cQWCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAD2BEC45;
	Fri, 15 Aug 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238823; cv=none; b=tvDs85gM7j2Da6yS/vhOBHxtrpKuAv0srkpwe0yQ1YjrZUtAlUteWWrmNnqDtzV+6qAgIRMZykH2MQS2mhVRtIiJafWgdkr9+CjFkQDkWnLt8gK6lQyUcHzmCKIFRRlEZ17BA0EFcZK/hnKKQN6QtS69+vkvxL4xrInu9E3uwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238823; c=relaxed/simple;
	bh=RE2mu1xyG+Gpm6lhifDil6CSJ4gKqmmd/qmFE3Vicrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCEKYK6dfhm6AWJV/gWtoCrmtmhLaItkAglWIhRhbBUtrtvrgGBTdLgb8FBgbewxWDHwjZvVkDxmOkfJUuo9qp3WGqh6iuwY+M+pys75RddahkyKtsz/Bwp3QofhW4jaCa7C3a7WdQZXqh6TlqYn/V29tm1gPx0sVgI57WdIMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE6cQWCS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e60433eso1374496b3a.0;
        Thu, 14 Aug 2025 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238821; x=1755843621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewN7fzCA6lQTnvxGtp9MKhN573BIF38xR24dy5087lI=;
        b=WE6cQWCSUofo8L7kK2RQoLmXMPQe7tzfCk5cae0WgHU1ZhUnQC+U664EFVX/G66flW
         Afdoct1yXkt2oyCDB0qDocZ+YEvhy5T0mg6tML+oAH0dyTUbYVKn9Q4Lx9LI7T3P5z4c
         rfAUO91ZxElog/+X4YsQgr8QK+vnty1AH4Yj1MZU0JiRSU2U9mKn5CxFtiAP2ki6502p
         xAvBU9ryoyFk5lYEg3daf5iz8EVwUEmhhJjfsw8zwNdXapCRhY+pZKP43ROEIH7h3B4Y
         fVCaDqMzd8f2Lh/Hihe8zGJ3+g+86UPUIInsZ9VVpLKIi/0yD4186siqqiYtZzk7fNLe
         FjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238821; x=1755843621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewN7fzCA6lQTnvxGtp9MKhN573BIF38xR24dy5087lI=;
        b=UTfg/TTYeBJfg6Fbp5LyNvLVWXZu5f3ZWtxQIuLG5CirlS5oXpq7jN8QhIZH7fYzHW
         Pmifs/0qtwHrrVFm3qLAMf0LI/anUQVJXXmz/bpKbZuN1ZwG0SSDxSAUaxiEvm8EVCnf
         I9Ze6GxMZMAwS6t1o1dATGByFWsaQ0tVxTTiGPuUf/vgdOvq5nTadFyd14EHnIuXwKRI
         TrdmpWsmBJjrTdHmblIZcGyXGzDle/jR2RnkeYHet7nKecTKK9+ZKs+lVXk2u03xGGrD
         s5yt8s0hMO6y5M8V/6Pnn9YCjGxip/Hoj6gUQ31mG3wNtybCvDIuXhedUYVE7fLo7wTI
         HzyA==
X-Forwarded-Encrypted: i=1; AJvYcCVM8ZlGMgRxEJOBLB2lyGgrUQZxiSmzeBihWQTMNA2tzmnn1SLEl/wOs2LUuRnk96mISDhUZmM+05ipwJA=@vger.kernel.org, AJvYcCWVN+FVbUlDGjXMd+LKGIlJHRY9DiKHnXV6csjGM9AuRcvzWlpE1R49WmBGFFtraGJk7fwcoQZGwsr0Rpa4KCxK@vger.kernel.org
X-Gm-Message-State: AOJu0YwXINlPPDwV6gAyDSwADAWov8SG2wrBDhRUewoF6jTv9fnRUUca
	s6AfXOTQLIQJNbrzQFz7RKsXo5DbGwcq+KPawLwEGzZi2HubfU2pv0WJKHOb87aD
X-Gm-Gg: ASbGncu34zGAged46INmlas38c/V0X5Wp6RRbom8eBEQ+k9qY7Sh07swXSga4zAwO+K
	2mZNMquAM1kxHFByv+ckwy+RSyYQM4D3huJfzkY3zvTPs8sqpXwrg1ym1C0Znn5/Jh6lE/tGh6+
	nTI0QzpkTtLNm405JBax/g9d0Gw5Xw3vVySu/guhHQvKmg0sPKGNtuw/AvjFbkhOP7TZWjtRRz2
	sbVbNxTTDrOTTXLdKoYfjWEP0uJsrAUgCS91EWz+0LE0k3aSWSXGPkL4s3F7DHUCR+uuYw4vsUR
	zPDBlhxcEZNLKwLjkUhmFyoBzplovYvHkJlzIS9WaC5kyHthN5O0O6uju0kF8WG5VIAyBZismPU
	48pYL53nZxOXyCh/vflX4NLmZJlcvBbykglyCFGJMBg==
X-Google-Smtp-Source: AGHT+IFwHq0v1t0GbSN8az0yckcI2BvE8DF3DVJKbLtpfn+ZOmCOGadlYcRdTXqVs03jlB+ZDyCcVA==
X-Received: by 2002:a05:6a20:7d8a:b0:240:2473:57b7 with SMTP id adf61e73a8af0-240d2d90e74mr1703860637.8.1755238821338;
        Thu, 14 Aug 2025 23:20:21 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76df62sm425206a12.41.2025.08.14.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:20:20 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/3] bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU
Date: Fri, 15 Aug 2025 06:19:59 +0000
Message-ID: <20250815062000.22220-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815062000.22220-1-liuhangbin@gmail.com>
References: <20250815062000.22220-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `lacp_active` is set to `off`, the bond operates in passive mode, meaning
it only "speaks when spoken to." However, the current kernel implementation
only sends an LACPDU in response when the partner's state changes.

As a result, once LACP negotiation succeeds, the actor stops sending LACPDUs
until the partner times out and sends an "expired" LACPDU. This causes
continuous LACP state flapping.

According to IEEE 802.1AX-2014, 6.4.13 Periodic Transmission machine. The
values of Partner_Oper_Port_State.LACP_Activity and
Actor_Oper_Port_State.LACP_Activity determine whether periodic transmissions
take place. If either or both parameters are set to Active LACP, then periodic
transmissions occur; if both are set to Passive LACP, then periodic
transmissions do not occur.

To comply with this, we remove the `!bond->params.lacp_active` check in
`ad_periodic_machine()`. Instead, we initialize the actor's port's
`LACP_STATE_LACP_ACTIVITY` state based on `lacp_active` setting.

Additionally, we avoid setting the partner's state to
`LACP_STATE_LACP_ACTIVITY` in the EXPIRED state, since we should not assume
the partner is active by default.

This ensures that in passive mode, the bond starts sending periodic LACPDUs
after receiving one from the partner, and avoids flapping due to inactivity.

Fixes: 3a755cd8b7c6 ("bonding: add new option lacp_active")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 42 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 414fecfd2a0e..4edc8e6b6b64 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -95,13 +95,13 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
 static void ad_mux_machine(struct port *port, bool *update_slave_arr);
 static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
 static void ad_tx_machine(struct port *port);
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
+static void ad_periodic_machine(struct port *port);
 static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
 static void ad_agg_selection_logic(struct aggregator *aggregator,
 				   bool *update_slave_arr);
 static void ad_clear_agg(struct aggregator *aggregator);
 static void ad_initialize_agg(struct aggregator *aggregator);
-static void ad_initialize_port(struct port *port, int lacp_fast);
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params);
 static void ad_enable_collecting(struct port *port);
 static void ad_disable_distributing(struct port *port,
 				    bool *update_slave_arr);
@@ -1307,10 +1307,16 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			 * case of EXPIRED even if LINK_DOWN didn't arrive for
 			 * the port.
 			 */
-			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->sm_vars &= ~AD_PORT_MATCHED;
+			/* Based on IEEE 8021AX-2014, Figure 6-18 - Receive
+			 * machine state diagram, the statue should be
+			 * Partner_Oper_Port_State.Synchronization = FALSE;
+			 * Partner_Oper_Port_State.LACP_Timeout = Short Timeout;
+			 * start current_while_timer(Short Timeout);
+			 * Actor_Oper_Port_State.Expired = TRUE;
+			 */
+			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
-			port->partner_oper.port_state |= LACP_STATE_LACP_ACTIVITY;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
 			port->sm_vars |= AD_PORT_CHURNED;
@@ -1417,11 +1423,10 @@ static void ad_tx_machine(struct port *port)
 /**
  * ad_periodic_machine - handle a port's periodic state machine
  * @port: the port we're looking at
- * @bond_params: bond parameters we will use
  *
  * Turn ntt flag on priodically to perform periodic transmission of lacpdu's.
  */
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
+static void ad_periodic_machine(struct port *port)
 {
 	periodic_states_t last_state;
 
@@ -1430,8 +1435,7 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
 
 	/* check if port was reinitialized */
 	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
-	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
-	    !bond_params->lacp_active) {
+	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY))) {
 		port->sm_periodic_state = AD_NO_PERIODIC;
 	}
 	/* check if state machine should change state */
@@ -1955,16 +1959,16 @@ static void ad_initialize_agg(struct aggregator *aggregator)
 /**
  * ad_initialize_port - initialize a given port's parameters
  * @port: the port we're looking at
- * @lacp_fast: boolean. whether fast periodic should be used
+ * @bond_params: bond parameters we will use
  */
-static void ad_initialize_port(struct port *port, int lacp_fast)
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params)
 {
 	static const struct port_params tmpl = {
 		.system_priority = 0xffff,
 		.key             = 1,
 		.port_number     = 1,
 		.port_priority   = 0xff,
-		.port_state      = 1,
+		.port_state      = 0,
 	};
 	static const struct lacpdu lacpdu = {
 		.subtype		= 0x01,
@@ -1982,12 +1986,14 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 		port->actor_port_priority = 0xff;
 		port->actor_port_aggregator_identifier = 0;
 		port->ntt = false;
-		port->actor_admin_port_state = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
-		port->actor_oper_port_state  = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
+		port->actor_admin_port_state = LACP_STATE_AGGREGATION;
+		port->actor_oper_port_state  = LACP_STATE_AGGREGATION;
+		if (bond_params->lacp_active) {
+			port->actor_admin_port_state |= LACP_STATE_LACP_ACTIVITY;
+			port->actor_oper_port_state  |= LACP_STATE_LACP_ACTIVITY;
+		}
 
-		if (lacp_fast)
+		if (bond_params->lacp_fast)
 			port->actor_oper_port_state |= LACP_STATE_LACP_TIMEOUT;
 
 		memcpy(&port->partner_admin, &tmpl, sizeof(tmpl));
@@ -2201,7 +2207,7 @@ void bond_3ad_bind_slave(struct slave *slave)
 		/* port initialization */
 		port = &(SLAVE_AD_INFO(slave)->port);
 
-		ad_initialize_port(port, bond->params.lacp_fast);
+		ad_initialize_port(port, &bond->params);
 
 		port->slave = slave;
 		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
@@ -2513,7 +2519,7 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 		}
 
 		ad_rx_machine(NULL, port);
-		ad_periodic_machine(port, &bond->params);
+		ad_periodic_machine(port);
 		ad_port_selection_logic(port, &update_slave_arr);
 		ad_mux_machine(port, &update_slave_arr);
 		ad_tx_machine(port);
-- 
2.50.1


