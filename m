Return-Path: <linux-kselftest+bounces-39824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C90B33765
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBDC1B20F23
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082B28BAB9;
	Mon, 25 Aug 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3+2VS0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6A28C03D;
	Mon, 25 Aug 2025 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105543; cv=none; b=bGVKgZDFD/0dQXcl+IxjmlzQJNuxzUmUBr/5wR9k0772Gp+RfBn6tZLvmzybAufQybkZSwqENTmWsb2xJ0IbncIcyCYRhzX/lSUhYf5Egykj1Y6R2C0PdspA4TAnL62Qqzcv8wZXWts6gsQoN0Py0VXSt99UWrbg4YaqrPIirj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105543; c=relaxed/simple;
	bh=9sZmf7AGyfI6iz/dBNo/r0ok06yHtZ9RE9LaJmQjN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wimy4l7rorXuK9Y82UAMvOOH5nTzEeFGj7WuZaY03VLsKMpROcLcukAZ5MgrXu1++I82Pf/lhi4AxAzvVsZrgSNtZLAdsaVKC2RX0RZqF/Xc/pm5t23so9qXs9FQh0chwARa2d4N2C1ByVIxF5vUsdKUh2mk7UmHNqdTIwDwfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3+2VS0y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso704200b3a.3;
        Mon, 25 Aug 2025 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756105540; x=1756710340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSi+PDqK31R4kyf81JcVZ9RabPGgeXSSxO+pUjWJbz0=;
        b=P3+2VS0y94vSUGSGcWpweAMp3UDkTEJOJ+29dO92qFOwe2uQ7ZKgHtFnAHmUehLl2u
         AsuUI+r7/tC97Q/X2GKxH6ke6lmY3V4CbqqCkZqFQkYBghlkYVIGzrKH6i7rMQdHRCAr
         qBMMwH/VWqnA+lZOSq87DF1pymiBo5fgwweT95k7HNeDwxsz8xQcVqCcvvYfsw77JyJ7
         B/3bBiUv8hG6HsTijV3uXsu+lJKggkBCT83t7TRvMLo56RVxaPiFSbBESd/BMP2Gb4bR
         MT34l9xjVppIhXF/jcPiUby0vbbHV6fII/sVH4tw1aMejg8I5An184Njw7ZvwQBYG3i/
         e+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756105540; x=1756710340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSi+PDqK31R4kyf81JcVZ9RabPGgeXSSxO+pUjWJbz0=;
        b=h2EJrbNHX+apIF/j1JUEtCqEZRjXqMmLV5YstjuQcwEspj99nS1wujFit2LkHHh672
         uxWvNaTttHGvh/YgCLbrC2dRvh+VY+rrAAvluk0L8jYU+Eni258ZVFAVzpJSl/l1WcSX
         TZQ8ZIdXp4w40K0BMEFosQwzGxgHLXPdB28WR5Kvq63CVgvV16sZH/xGpP0QBvcZZDjg
         BFgiBKXTBexT54A75ga/oDugjvuMwLxukGPO4y1z3/E/5JEYreLHq9wBlU76ey4zyx3v
         ZIbTjrnyVTQbPo5abq7wNVSmjQ0keyZkVcZlt7SDJpMbWjxTsccw7lpWuyDKLdOEFMqV
         /foQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHkNiLJuRU5k6T5iHKNL6KKMO3X2oKBlkeRQFAl/DDRUTUVcHEJGhYNgdh8aWK3ucj/ATxrinqydg=@vger.kernel.org, AJvYcCXXkk0Nq+L0JFj3Pay+asIwKzOeC+jnSzEF8euEOh4PL1k/18ZpLzmRB0rU4nSsg1MP84NlAIgKwDwSoycFVBjk@vger.kernel.org
X-Gm-Message-State: AOJu0YyQh4Tv4teksjvx6sB1BENDUX2mwUdRZZVq6r7kWBSGdb91/gba
	tBsXxt+MyPdwCFW35pCMjsOdjBAZG4KyzoZKTLIQ5fW3dFh2Q5vjH78aTOm1qRiW
X-Gm-Gg: ASbGncuEX1bT7/2I7fIGk95gVURjWk+Uafze5Szvnp7TN2Giica/mQjZKRuMBGtLxk/
	RmYSovKV/4nyy7xnGAeFt+Zn3VbY/MTJ3kOUEMa/bg9N2pTUM6atGFxYNWpLPaZbTN99k9ppE3A
	p3E6FiPRnBbknkgm25VpskLSGZx5hAmyuw2Ne2udl/5/UWoJR3TtKXr3BOsr+U6pJ3CAfhfiI24
	3IuTqG0wZhdi5VDKDOPsXFGcqRWvTURKG3bo/ZTmkD4G9MD+gRVFXcwz5O0DxqVbF8uziaXTSdm
	4F6yue6DxOTDw4SOFHvEQCW/vP+eXVYTCljDh1Hnfi7dF6lmFdCpCUMe2VUce2WagnzsPPVC+tA
	5G3NmxNGQGNPFQfArSw1X3bxBF8ZjWAO/Y7yie0y4og==
X-Google-Smtp-Source: AGHT+IFBR0AuFC4u6MV0sEbZWV3XWWeixQn+YZ5Z1khw/ZpouoCtUHL0jQTM2Ha86blZQ0mMXeP5FQ==
X-Received: by 2002:a05:6a20:1586:b0:240:1e97:7a19 with SMTP id adf61e73a8af0-24340b59e4dmr14511086637.22.1756105539968;
        Mon, 25 Aug 2025 00:05:39 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704025a2c2sm6375262b3a.107.2025.08.25.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:05:39 -0700 (PDT)
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
Subject: [PATCHv4 iproute2-next] iplink: bond_slave: add support for actor_port_prio
Date: Mon, 25 Aug 2025 07:05:28 +0000
Message-ID: <20250825070528.421434-1-liuhangbin@gmail.com>
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
v4: no update
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


