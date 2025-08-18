Return-Path: <linux-kselftest+bounces-39222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E7B29DC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0F4E28DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768E30F52C;
	Mon, 18 Aug 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flbIwWSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F730EF73;
	Mon, 18 Aug 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509119; cv=none; b=D+ZpiAi7WqipWlkzx8Pxqb/J9ycnJMOzE4L89bjxkn0i2eexVEVXDlpEe2VGs10K4M76bo4l1JmTX5N0po/87GQn6scU0nNTj5j8fyEelHdaS/AH1QLlSX/eX38zpRwB0H6SxXjfWmEYjioL7gQDkL9YHfjnNev6ZU09dV8GPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509119; c=relaxed/simple;
	bh=r8keel9tNrM1mBmsCuc5MbZulk5cXHRZhpxY2FojLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1rD2TCHOKSdseGDWIBGn04BwfSlZg4eJ10jAy2HmmkDnR5LF8cxBOSZAJKD5k/KUIx9RrYA/rGlfMiPnSxRQfMHQrUVuxMuO78rPCG10jUGj0qjw6x4lxUi7xynkMeitHI7V4G/uI8VgrzwVM89dvGY1YL2ZJSq0RRdQVEgQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flbIwWSQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so2813704b3a.2;
        Mon, 18 Aug 2025 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509116; x=1756113916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPYsBsYooN8Tcb0YJTHUtki0Io18/MUGzlOjf9f/fX8=;
        b=flbIwWSQkGV7oihelsx/EmdIy7ytqDiUglutCinAjPodLSlbm5djRDSsyQsx8Kr7iW
         bmOEavIN90ZZIijo0GdZnhnC9yRZNXGJBqRvJDCXIktknHUXMAzQMRR5+HTEOaA2gHCa
         zmL7cBCw6VFZTaTF3CQaMhmvI2VV5mKZuDHEgATHhgfMSMg/wbQSsyD9Decci1w9rrZd
         +YTkINNbu6ZuggrrAgsLAjDxdYzbrvSqwSnuSDyN3rXod4Q47cePwKNzfWORPSG68J85
         RU4kRuNAUKSYPY6kt0jA9q7CNAJnCthXsR6yH7FGAeTFKh0j0F4W7x9UGN5XTFLG1DeV
         WDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509116; x=1756113916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPYsBsYooN8Tcb0YJTHUtki0Io18/MUGzlOjf9f/fX8=;
        b=MONKEVm4Ix11yTe6exLUQDqWCZaeID5qteAgCUtWhrKCzRHM20cJ7LzeDLtzDX7IOs
         uU4wf+8kG0sheqOFFgm6r69eana7+f3JTxK0dXdgKTRxDuU9VTOKRP7WmxtSth1koGr9
         xlCncW5K1JlLxgxxxEafeHiVK70orNF4CEnR/3Sr5tNTwxcacEzraj9x2+suW91s5Kll
         2VxtUseUDDFZ/8OHPZmxdvNVPxXryRdgeIweOkyH7vHhCpzwHIlgEyEIY+v2m6iR1NWr
         ScOvOaQT1NcCZVRK28rS5WqJiYSZUKPkoFiFuCrI0cDIvz/59Nhr0NXVdMhnzTcVfiWY
         aejw==
X-Forwarded-Encrypted: i=1; AJvYcCULF8l0+m/tSBuBdnqbkh68TsJOLM6opzEYLwKkoPpQVLlpd9jwi8SvBWxWC63M20mSm/JapdmHApo=@vger.kernel.org, AJvYcCURbtsgnDs9Zhe0b05gWKYDPVn8T1G7tIf1jAOw+T/aDXDdhdRbZTWzmIg2zL3ZN/PljFxj/KZ7rVWlSM+U01Lz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/f4aCITKrPqbDHnQBc7XDQgqY9fJIwkKMPPhcPB2xR/VnWGIk
	aUuDiSuUvM0EWbw+/9Wd3eJOHC81xZIjAbCjoHviH8Mt6uIKbXwEyTi9O6CUC6Ly6/4=
X-Gm-Gg: ASbGncu9iIIOE37qZjTsbDTumW2IqmJ1XlyvjewUMwt3CfvCpznvnpNFbMcFCpg/7lr
	4TvsE4uSLkNovVhCthG6AKt+qWe4WwOQVUfr01UIMcwv4EoRdLxb0h76ZS6Jd5I4AfThp3LIxfP
	gzcFmwR/Sc2TOruecdXCmFoJ+5YkIFiboL1lTCAcAGQ623QhJuWCzLk1XhxxuBS5ZJAKj7rn5Nu
	1P8WgK9ATDlfHN6TEHpTJ7BTCL4rJBw2auWsPzgt2x7KGieZ1tF3kh8wdfI/r4/AUYR8jP/YEat
	zAjUk8WMQ96e+R8hpZ13QhShrOlnUUl/MWS2n5jhIRN/S9uuX1rBd/YGvI5iAzH+SZ8E13KIogx
	OrWHAwQKrg80LX2ys/YYZhwnrGFB7KUrcw7U5Lyb/JGTqpP3IQhTF
X-Google-Smtp-Source: AGHT+IHuuCjmn3VL+qTDrLvXwzkv1Nw0RjOxb+vDljJsx2Ou0XLT3910Ahnp3+arQP2EMQ0FYyltGw==
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr146707035ad.28.1755509116058;
        Mon, 18 Aug 2025 02:25:16 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm74940645ad.86.2025.08.18.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:25:15 -0700 (PDT)
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
Subject: [PATCHv3 iproute2-next] iplink: bond_slave: add support for actor_port_prio
Date: Mon, 18 Aug 2025 09:25:04 +0000
Message-ID: <20250818092504.383217-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the actor_port_prio option for bond slaves.
This per-port priority can be used by the bonding driver in ad_select to
choose the higher-priority aggregator during failover.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: rename ad_actor_port_prio to actor_port_prio
v2: no update
---
 ip/iplink_bond.c       |  1 +
 ip/iplink_bond_slave.c | 18 ++++++++++++++++--
 man/man8/ip-link.8.in  |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d9b03..1a2c1b3042a0 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
 	"stable",
 	"bandwidth",
 	"count",
+	"prio",
 	NULL,
 };
 
diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index ad6875006950..c88100e248dd 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -15,7 +15,9 @@
 
 static void print_explain(FILE *f)
 {
-	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n");
+	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n"
+		   "                      [ actor_port_prio PRIORITY ]\n"
+	);
 }
 
 static void explain(void)
@@ -145,12 +147,18 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 			  state);
 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
 	}
+
+	if (tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO])
+		print_int(PRINT_ANY,
+			  "actor_port_prio",
+			  "actor_port_prio %d ",
+			  rta_getattr_u16(tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]));
 }
 
 static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 				struct nlmsghdr *n)
 {
-	__u16 queue_id;
+	__u16 queue_id, actor_port_prio;
 	int prio;
 
 	while (argc > 0) {
@@ -164,6 +172,12 @@ static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (get_s32(&prio, *argv, 0))
 				invarg("prio is invalid", *argv);
 			addattr32(n, 1024, IFLA_BOND_SLAVE_PRIO, prio);
+		} else if (strcmp(*argv, "actor_port_prio") == 0) {
+			NEXT_ARG();
+			if (get_u16(&actor_port_prio, *argv, 0))
+				invarg("actor prio is invalid", *argv);
+			addattr16(n, 1024, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+				  actor_port_prio);
 		} else {
 			if (matches(*argv, "help") != 0)
 				fprintf(stderr,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e3297c577152..7995943ab11f 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2846,6 +2846,12 @@ the following additional arguments are supported:
 (a 32bit signed value). This option only valid for active-backup(1),
 balance-tlb (5) and balance-alb (6) mode.
 
+.sp
+.BI actor_port_prio " PRIORITY"
+- set the slave's ad actor port priority for 802.3ad aggregation selection
+logic during failover (a 16bit unsigned value). This option only valid for
+802.3ad (4) mode.
+
 .in -8
 
 .TP
-- 
2.50.1


