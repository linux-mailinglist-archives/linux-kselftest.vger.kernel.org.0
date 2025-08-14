Return-Path: <linux-kselftest+bounces-38959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF799B26330
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B445E45E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50D2853E0;
	Thu, 14 Aug 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+UhYTQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9A2264CF;
	Thu, 14 Aug 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168283; cv=none; b=JAUqoSoTMwaPLsAiRBf6oCe0008eg65KLQYV8mYB/26RCDTFFQGRrVS4a1mPi+fXzAdfFfGLPjmeyovsAl5Uit2t9rLjskStGpJTSD9mFe1quUuuBs20wlCVG53TdOHDT8lLf/E1WVY9Q+OjaMYwTMp7NzK4ZiVtMflBXUWGGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168283; c=relaxed/simple;
	bh=a5aQntAasDOv4w0vb7Hnf18WsX2N48zMQ6FzyCFSG54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty727KiabqLwd9uTTE8d2MVc9Ak2Te7va7msJpFUH2aSPfIV5FegT7Frqp/3dA4ZHtPnNvYKQdoM3OckKV4xiLBm82Al5OsERGYilRpfov01Kmxl0ORTNxFPTA4GfEa/Vzosq8nQS0/ISOw1sUZ1Q5sE3S0KL5/RWk0CXtr7iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+UhYTQu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f581aeso5893545ad.0;
        Thu, 14 Aug 2025 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168281; x=1755773081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq//dQi0YTa3IQHQYVjTykJ5ZK01C8v6LFJj8kuymN8=;
        b=W+UhYTQuXA4fZIe8jYyHDHoauusfX/640FsQnlgzZ4kRnpA9OODds2n7mIpdGRBZxn
         HbPyjQdyPiw2pZ45qoabHLjyADYQT6gbvyX3iwWac9rFd1h8f+yG0g+FOZeKeulRiDD4
         OO4+Y1FIY6yx/xNTVzTNj2THaN3MXRe/6vvwCWK+COZOk5ihA6/RyXFICjdylcN96F6b
         GxB2Mbhpko9glet8oYd2M65TO23MCMe4/f8LFopG4SpljzUhuKIg8GwzaMxchM7Efsrf
         M/6sQLqaSUky+qRCWl7O/vi10/2YW3Z29XflsQaBph6lAwL+iGq7nob9VgiGZGpe2ykJ
         BZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168281; x=1755773081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq//dQi0YTa3IQHQYVjTykJ5ZK01C8v6LFJj8kuymN8=;
        b=DKW97zSYq0PXRcc9pWlIlTgWgp6l11kDKWA7yrZLSMWoxqyFQkA0YF9D+w02Cv2jZa
         1j85PgK++ve7E941mp3aHqNoUIDQq1ahOoWfgRChrfu9Bx1kebx+jiVH0YFPhVeOUTKm
         FkzBoAsbxlLVCRV4/lGz334Sa3P4GysfxgwZjvowOKBLPDBVVGYcA+iaY6jWgeyA6+vt
         W68J+5nsjKDzG0mwwJ1MDNS0Ums/HhdSCIkPNrjH7nvp3C2R9QHel65E1t9HJnlpV+0n
         29RPYBnb8AaDw+CfZiHTqGgOVD5u8m+qeYtJouVymey8QJ6IyKmltNWMDDVEUzoV1P0H
         89kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq0iWCRhQQjjzvbDxSHuKA21MkCoqOSAo3dJccTJtzaf87nUNM3eMQy6Df2UCJyfi4bkD6RJc1IUc=@vger.kernel.org, AJvYcCWiVjqYVyApvtLIW7iOZ6u5OBSQg5JYGYQDi0NZtWezDoJqmJF5wwtBK3jTr8uyTwAbAcXYNzHyZo2MZc16fnkc@vger.kernel.org
X-Gm-Message-State: AOJu0YwIty6qz2xRqtKH2uvsIj8VM9Y+hzTAXkKnfh8YArjqrz7WUSn5
	VgEgLEQVfDDXVLLfrolk2R6V3yrkWf9z41z4kyPA8nKSEjUzykxdubijk5lGO6zc
X-Gm-Gg: ASbGnctoo+knWVi1NMXLFDmGZ0uDb3zx0e+QRXL9CTaICIuOH26T1QD2506EPHmZORI
	PdnqioXllffYMFPxhLWuLqzVWTb10wjUpDfpwMuUkGa91ExT8leWf5RGFsYtrZCwRoAl+/xcyaz
	FAjYOxePTjJ3ODAyivO4khIfPWJVnsw2PwyXBsn0uULo0v5TsdlW7d8dxs2aAo3YdmdDf1vr4UP
	IHhUEubacCELmSmdZZkuaOJF4oD+44QLAL0Ud8V8FxAgPKxSlVN+Crp/Om2UDMhhwVcY+DJ6jnp
	a2Od2XLJj1LTcNvxoNn9r2cChp60am1HyvDKsRyvTcdcGj7FmH/Xz0yVuc/EMTl4OSRjGlq9WkQ
	HiuZsrbHJhUOmPREZ9WJE+xwlzN0Q6BLPqZQhFOQACA==
X-Google-Smtp-Source: AGHT+IF/oHgevoCi2cRDLT2+Tnabm5Nwu5/FXhs9Dsy0nrg+AwZLk16ZM2fMrEq6/faNqNl03ZOquw==
X-Received: by 2002:a17:902:c947:b0:243:e3:a4e5 with SMTP id d9443c01a7336-244586db845mr41317635ad.48.1755168280885;
        Thu, 14 Aug 2025 03:44:40 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm267055485ad.54.2025.08.14.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:44:40 -0700 (PDT)
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
Subject: [PATCHv2 iproute-next] iplink: bond_slave: add support for ad_actor_port_prio
Date: Thu, 14 Aug 2025 10:44:28 +0000
Message-ID: <20250814104428.18431-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the ad_actor_port_prio option for bond slaves.
This per-port priority can be used by the bonding driver in ad_select to
choose the higher-priority aggregator during failover.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: kernel side update, no update for iproute side
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
index ad6875006950..67b154e194f7 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -15,7 +15,9 @@
 
 static void print_explain(FILE *f)
 {
-	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n");
+	fprintf(f, "Usage: ... bond_slave [ queue_id ID ] [ prio PRIORITY ]\n"
+		   "                      [ ad_actor_port_prio PRIORITY ]\n"
+	);
 }
 
 static void explain(void)
@@ -145,12 +147,18 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 			  state);
 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
 	}
+
+	if (tb[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO])
+		print_int(PRINT_ANY,
+			  "ad_actor_port_prio",
+			  "ad_actor_port_prio %d ",
+			  rta_getattr_u16(tb[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]));
 }
 
 static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 				struct nlmsghdr *n)
 {
-	__u16 queue_id;
+	__u16 queue_id, ad_actor_port_prio;
 	int prio;
 
 	while (argc > 0) {
@@ -164,6 +172,12 @@ static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (get_s32(&prio, *argv, 0))
 				invarg("prio is invalid", *argv);
 			addattr32(n, 1024, IFLA_BOND_SLAVE_PRIO, prio);
+		} else if (strcmp(*argv, "ad_actor_port_prio") == 0) {
+			NEXT_ARG();
+			if (get_u16(&ad_actor_port_prio, *argv, 0))
+				invarg("actor prio is invalid", *argv);
+			addattr16(n, 1024, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
+				  ad_actor_port_prio);
 		} else {
 			if (matches(*argv, "help") != 0)
 				fprintf(stderr,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e3297c577152..5714dbecabcf 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2846,6 +2846,12 @@ the following additional arguments are supported:
 (a 32bit signed value). This option only valid for active-backup(1),
 balance-tlb (5) and balance-alb (6) mode.
 
+.sp
+.BI ad_actor_port_prio " PRIORITY"
+- set the slave's ad actor port priority for 802.3ad aggregation selection
+logic during failover (a 16bit unsigned value). This option only valid for
+802.3ad (4) mode.
+
 .in -8
 
 .TP
-- 
2.39.5 (Apple Git-154)


