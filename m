Return-Path: <linux-kselftest+bounces-37974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B75B11889
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9C5876DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC222882D6;
	Fri, 25 Jul 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4DyS52N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83B2882CA;
	Fri, 25 Jul 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424950; cv=none; b=Z+i+7oobuonDo2oRs9HjB8gXxEIdWmAsJ6tADSCXGnnRfzwYgUPTNwP6G5FpyNVd+OO9cn6z+nujSRcAjUba1zakjuVrZh/mmd70xrY7hfNg0pKwYKr2kH8JnYq63JSOBW9Ur/q3HGJnNrRPrEbCX6ZsXJaqd+pSl7CeBdOokC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424950; c=relaxed/simple;
	bh=zKNGZKQBGrptdbrTvEAzEylSidThfayYt4Un3U6DYy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKikFfWRotYpiju4G+4RP4tIsPk+wJNSpXgJjhEFrcU0/85l8/QYDN+TeDffWrc3oiQIN2P4tdNnoVmFYIrYDs090iVN+k/YhTGIkmz8QxAEQZzqGhXazU7RoO3lmdO6shw11V9Th4KDaoNkDg90hfSlNF0hcdReCHd253ZwjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4DyS52N; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso1676496a12.0;
        Thu, 24 Jul 2025 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753424947; x=1754029747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By5J0mk6XP9+6XkDCu9GU7OV1b9XrAPGd5us7tK5YZA=;
        b=j4DyS52NudeR8VLjAxSutzflA0trCwixs1by3BvRjkPq0xtC+Ghvbukh0EMjhRvpRc
         atNHy7YpEECpdvGsn062UPHkG2nGwVjgczYQOdIT0DgiTOmmCYzvgB+2mwg2tlXG/6J1
         Zw3pcO32udXRpObKjAp6aiI5KkH2V+CSbleQwAl/X9Fm0XSQD85ymRlWL6CBoMaVaXF6
         wbhYIeN4NSQuUwgM4xybj1TSjh0Uzl2sDKlis0x2qKKVpwjZmXRhW85RhYGgAIW75dD9
         kbGRpA40c8BrKNoB8A4dHKJMH2+HOIDJ8bxtDtAAUIq3aXB6ESVgCCZ/MGK2Ol3Cs2tj
         l6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424947; x=1754029747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By5J0mk6XP9+6XkDCu9GU7OV1b9XrAPGd5us7tK5YZA=;
        b=Q5Ah7FCVOU4Yk4KJLPNTszHurI8nLdgmZAKLpTjrcnMbc/Ns+wcLYLgfv+xu2teffe
         zDvTCblAtZ3qL3ZCPhDj6EWfJyGuzk0q5aGnYZjMl9TwB7QAzgSNIAKjzVXGi1rBWtgM
         aR5CEplninSdP0JjpyHEV6ptU2+hp5XiglAW/RgukBwTvFj+PbcJ+orDhbjU3xr+oZnE
         lzvZi1kL8F38fCcf2ErPGDeZbsp2Dq4ZgVlkZo0TCBygfn+JVxESy+uULAscCBkamg2Y
         x8hI4P4G28jc1kEeY0tcowkUDr8ZjCmc6mDBk0IcbFJmQ6LUiKEV/xj4LTvEXldQpMTR
         E5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUOq7qimEGRYhSf8E1fuo9A1gqnXXHX6OyG9vuLH23wBb3XcPUJnrDPk8Kcz/5cmn9f6B7U85gyYU0=@vger.kernel.org, AJvYcCVqwm4xnTS4lkKKF7JHDe/8qzPOiuD+TEeKTEEyoCfEIgeOEt0rZdLIRgW3ebq7WzuqDWV+teM/ymbms+Y8@vger.kernel.org, AJvYcCX8Vou7l5/UxCsUuIK/wYrl1vIT1cH68SzWoquQwhm2q7+Exb6AsDeIn1OQjfFlm4MhL7qeIHsUIHtWdMt3Yrnk@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/G8rx5am+Izg43SSzBqK+VJ6PgEgh3m/y3Q3hhMcoKsbo6sc
	B+GGNwl7NGQjF1cT+gTMf/P4pAhB9Z+At1e3HKyQlVHWS733x7A/lvJT/Tmxr67S
X-Gm-Gg: ASbGncst5wsMoVdMQXZqD/9E4xH3DS/94o4O3PWv4XP0dVJRnLvKOeld9QeWckvHt2A
	CVKciHkx9sEnkND5Qojgu9IxoQLVs6MAQQDA1PJ3YAgjxAGH4T0TyEt1KKeL5rKz4Dt5K/VbiC5
	D1XqIZMFU2wyIz1I1IaKtuAFhE068bp1ZWrtPTpIOPYKKY+Ei177yTOTSYxDF/ZwkT8p64iNShF
	Gd0gTKVC3bEnT0TQCLBXlyVTWc1493MTUcONEEsodpog3dgMMc2l/FMF835QvKgDtoQ99R8jxaH
	RszCogzLYKnPruLmYw7nIYrSk2tBF6SyOCIJ0SZrsw4CerR3b+d3kF+AflEu1uRrmjSLLRtZI3D
	JE2cd7b6AgMSYXaKZnjP4dYVhjfLc5omyibVb6onwSkz/WTo=
X-Google-Smtp-Source: AGHT+IG5wkYbnVp8jKFG0nJNflPPc1F19sJ4bKx1DXK6Gx2kSs2NZ1GSVR0Xc8Gg5parlPqF9dUkCA==
X-Received: by 2002:a05:6a21:9989:b0:22c:a165:3664 with SMTP id adf61e73a8af0-23d701db921mr973478637.26.1753424947432;
        Thu, 24 Jul 2025 23:29:07 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09b532sm2667917a12.25.2025.07.24.23.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:29:06 -0700 (PDT)
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
Subject: [PATCH net 1/2] bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU
Date: Fri, 25 Jul 2025 06:28:47 +0000
Message-ID: <20250725062848.18889-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250725062848.18889-1-liuhangbin@gmail.com>
References: <20250725062848.18889-1-liuhangbin@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c     | 72 ++++++++++++++++++++++--------
 drivers/net/bonding/bond_options.c |  1 +
 include/net/bond_3ad.h             |  1 +
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 2fca8e84ab10..aa64b397bb19 100644
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
+static void ad_initialize_port(struct port *port, struct bond_params *bond_params);
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
+static void ad_initialize_port(struct port *port, struct bond_params *bond_params)
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
@@ -2883,6 +2889,36 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
+/**
+ * bond_3ad_update_lacp_active - change the lacp active
+ * @bond: bonding struct
+ *
+ * When modify lacp_active parameter via sysfs,
+ * update actor_oper_port_state of each port.
+ *
+ * Hold bond->mode_lock,
+ * so we can modify port->actor_oper_port_state,
+ * no matter bond is up or down.
+ */
+void bond_3ad_update_lacp_active(struct bonding *bond)
+{
+	struct port *port = NULL;
+	struct list_head *iter;
+	struct slave *slave;
+	int lacp_active;
+
+	lacp_active = bond->params.lacp_active;
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave(bond, slave, iter) {
+		port = &(SLAVE_AD_INFO(slave)->port);
+		if (lacp_active)
+			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
+		else
+			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
+	}
+	spin_unlock_bh(&bond->mode_lock);
+}
+
 size_t bond_3ad_stats_size(void)
 {
 	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 1d639a3be6ba..3b6f815c55ff 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1660,6 +1660,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_active = newval->value;
+	bond_3ad_update_lacp_active(bond);
 
 	return 0;
 }
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..dba369a2cf27 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -307,6 +307,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
+void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
 size_t bond_3ad_stats_size(void);
-- 
2.46.0


