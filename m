Return-Path: <linux-kselftest+bounces-38289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8FB1B163
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66823189EDCE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48669266EFE;
	Tue,  5 Aug 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABKvfgO+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634E265CB2;
	Tue,  5 Aug 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387229; cv=none; b=hkjA3bbyCb3S3pmtfJL5gqQ1BJlyMFvO8QQqQ0N6eQ1Z92ohv58DuBekv1BSwibWDQ9k4CQRIiyJuhPqsQeA5xhUj/V7Hq6QslAmKzHOJLGjksCF/J9ciXl9BF7gh7MmSmMa1s+2kWhq4agK4M3OMryj19Z63nMvdWg8krpVVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387229; c=relaxed/simple;
	bh=5z1xt1Krh2qjT9qarx/Rb3Zb+mHSt+sFCoLHZDjIjfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBmA1hMfvFA7uaSaUIurzHB2GuL5nN383r4VoU4kGIvKHgzXnCb61oqC0o3cIN5Wo4mRIDqpLW0ETtZncNr4RrV3abKMJSnDHGha+o38b3PungYwQFIOIlTRCmo2jvegMJi196t+GOa+DiG20V9TYESXPeHyi3wO2//Fmv2K+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABKvfgO+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23aeac7d77aso47175245ad.3;
        Tue, 05 Aug 2025 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754387227; x=1754992027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D++XzzWL4D9eQHmt1G6QH5Oxn91nITHhFKLHnRhSn8E=;
        b=ABKvfgO+iqV/zaVtTpiWEMgj5MWAMcrCRLeui/dHlFLyHeQFxDTeDs7cuTF8QgOPvV
         mjDCaoMC96eaqSVrGx5lJ+epv0ykvRKBGDU8KThATayR2elzGIcCYXXHpG3TURW36SC+
         M3a5fiLB+O5ocBgQt7dfiH1Z+ddQmKUxlORjkuEYzoRY+pDFDi3nsRvMRWPx/7XrImtU
         H+RwGuDblVIUtJnKCKhivhmXKCPJyR/3bCaw6pC14rEsufGG3WHpXY6UWFAFxiNee0BB
         noREBrK34tu9BbSIQQEC/P6VEovTfXVwNnphHgF4zSt+MDmUU7ifTcglRViWPAm8u811
         NJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387227; x=1754992027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D++XzzWL4D9eQHmt1G6QH5Oxn91nITHhFKLHnRhSn8E=;
        b=Z86DBFixa2HGSHETphbukw2FD6/7S50//bvZq466gHPc1o311CaAdME8AXGRdKHfYG
         67/2dXR4Ti+YXyQkM805G0yflut3OOXZ0jICII5aC9ah716K3kr4kk+ErlmjJdXPoZpg
         tIRP1a+k2I13kxEwBa4ZzmCRQJaerNTOpXPJptVRWKaal6+QE0v2HRibqgAUhpQH7Wsd
         S8hZI1aoVlyNhyIXRx9DOsMaM/6c3cSHN56W02RjPm4BR3MUEisN/3DeNXocVgvF2RhE
         3hEAjjHPSQgsI2ut6hKzPfYJBRsGL3VWtMwZ05rsWFUy8m6Yt4Smiy3OYLzb/MTo7Y+N
         lk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiPpyNlaoBLHx8dx4/7Nq656HZs1zdDdI9KE7QK892lB8E7oRXjY+AGwu4ZqxK6xr/yrGyl4YdDTJCNWc=@vger.kernel.org, AJvYcCXnTHECkAlAZAIcnJcRyu0NcoTLXfpc2kbeuIKkCGkhIz6JiuHBCNJ8/1FjT4lhyJNh9p1DcfDcDXZnbmxWUDdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhO/QzGLleeMrQ6h79+Bcq1b+0Obpa/RDwXij8jEfPdojj/IvF
	8eof3HzGbuF8XFUoz8rfdQ8Pb0pNQvTq6vdEOMF7pVAd23e1yB9efk/xLOOuoRpfUs4=
X-Gm-Gg: ASbGnctwglntYHMdHmFAQl/rhrYP5p1MmTbqGO1pyhiQnaQewvslv4hk8dA32ooixwH
	A/6VurcF0RzfU1wzLCnGEpaC7ATzU1nlO9JLZjJUYvy3gryQ9ma4bLFOpvmokZoT5COqnT+BYTJ
	Gk/y2kdalmteTEkl2xIdpIgXdwb6lR2HYjTlNjxIp5813nMumpnogdq8jJGKs2LNoCPGoSEWn5I
	RX89TWGR4qpBvDp67F1Zs31OGo9vtR3ECwHOALSvIyT6QjjF/MNQzk6neD3qwQUlzCS/BWJvaTN
	HV7k3kFCv3htx62M7y73/VEAi9E7p6NXeu0djqD6Hb+5i5WiVJ05Dl9xEsqAZiJDPfQ25H/zVVv
	BYEsxkSyA/jiJKQinhiUnnrYEBIztsmFMr5jcCRXFAkN2Dz0=
X-Google-Smtp-Source: AGHT+IHixjD0g2t7S8sKR4hMnQgUtcla0x7OcX+dNBNFjk7TDPqFed8rIoeHLmX5p0VSjId9DjOUrA==
X-Received: by 2002:a17:902:c40d:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-24246f3ed84mr206931255ad.1.1754387226600;
        Tue, 05 Aug 2025 02:47:06 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d18asm128934875ad.141.2025.08.05.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:47:06 -0700 (PDT)
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
Subject: [PATCHv2 net 2/3] bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU
Date: Tue,  5 Aug 2025 09:46:33 +0000
Message-ID: <20250805094634.40173-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250805094634.40173-1-liuhangbin@gmail.com>
References: <20250805094634.40173-1-liuhangbin@gmail.com>
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
index 414fecfd2a0e..da8cedba286d 100644
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
-- 
2.46.0


