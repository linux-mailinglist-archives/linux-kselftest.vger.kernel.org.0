Return-Path: <linux-kselftest+bounces-40510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD0B3F5E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24252485C5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F52E54A8;
	Tue,  2 Sep 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9UXFpzP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23721C17D;
	Tue,  2 Sep 2025 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795677; cv=none; b=f/Csg5iXSzna4e8mwd2uGXRyllOnaZ7DdGhBNMvXaSvp0l3SNCfxNtz/JsX9Ax0pEZYRiLzusalAuN3GuqL936xVTVmEGp0hPsxxRGZxDXgvVp3al1Qt02iza9xu6j0c2mVnhj2TNiTXf772LDQOVTYjxeA4JlUd4lWuZby4NYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795677; c=relaxed/simple;
	bh=y4iwgy1InLjVLkGHeHvw/N6MqMMDdI0sR73CE4+VRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhuEaYz40mFU/x0k3FL0/v57vWW918zVHas2AomuisXCgydW78LQ4rMaDLhKTwPgFRpH34BQ7HkZuzr7Ld/xcDEyc1qELQUnfIe0ySQb2g/41rQiR0lmIV3Rcr7iB5dVTR1tGw/YQGE6OxMioXtbp+nfrVbrQAjmA7Jq6j/AFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9UXFpzP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b13313b1bso3621175ad.2;
        Mon, 01 Sep 2025 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756795675; x=1757400475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTPq8+2AdLPc961xK1EiH/64P90CB0xN8ApLWD7VVEA=;
        b=X9UXFpzPCeDIilBvG0wKZ4Z2QhK1dlLVXgENP/+n6kRODPA7HZ8AG6YmN68ODXS3K7
         4u6ppGwjrE0s50NY6ivJjD/CRqgLw66mjrDF9NpAIwMg8d6L81JW+IgXRqe7KhYWFOIu
         9pnmod/YM5ckAKEHP4j9shIv+muSF/CzGuEnwt6mCcByO4RwkekZF6nYUusE8wt0LiOv
         I3mhYfgOlS7COc7tgbLYHASJGIBuA9jwPX3edjunHGUYj7bOBwDXshB31+uTdL4DsAh3
         lmWGWaUBMxrUiQLbMDel7wVqZqP96RuAjBKj0HSLN4zt8AFSv4kBPK7xjrZLhajJSGFr
         y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756795675; x=1757400475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTPq8+2AdLPc961xK1EiH/64P90CB0xN8ApLWD7VVEA=;
        b=RzP63swP9Y8CYToipValt9iLomVu0C1fxyEWHS+SQjk38KCPnY5LyMXhDnbjftzWTE
         IR7Yu7uASEGitc7WHwbpVqVWtWebdUZQrtcK6AV65PzkYvgUbC6wvmkBbpnn+fZw9x5k
         UCEa8pRKvKX5b8ZI1Ju2c3HLkm1Nzj3NrOluYUbf+G9Q0DKEORHZUp5M4kIbhzV8f+iB
         C7EWRp1vCNt3T85MJ45hs7vEuEAz8Xe9TRvNPg3S/ELktnmlg/5R5IcVx2DPGeA/O8SJ
         V8qCvgFCJhJ6LG+O4JNxZZYe3SZXZeM+vMaoBD2UnSQvg1kRSefhELM/uGHGE9vdatkH
         JHRw==
X-Forwarded-Encrypted: i=1; AJvYcCX4iwQNg07rPibGPHzw4wvvL/78ODocQK36MuTCfaxXt5ErjxaGaLMRR7VrdV0MrZi+4+3pPkHKbTc=@vger.kernel.org, AJvYcCXx45BfRi/M+CEqousrffDnJHqbcf/ld5qfVlwkEbfHDa7kq9NmwHLKVHoJIgMXS4NUfdBJsFytmG8Gc968ps28@vger.kernel.org
X-Gm-Message-State: AOJu0YyRmRUjKxoEU983graLXJLx5L6Z5deAiNBE757mTjCzLhpuvH6N
	AARAhqoT8rJG0H3TiCx4V+pDj7LWIVwruvU7xnO7pjC93FqUhMqou9w4HGkT3cfoprc=
X-Gm-Gg: ASbGnct6wJoNDPwwMfL7GkH01avJEGWOwQcZv17PWPIAnS+6OvvqsXHQkpcmE1MjBH3
	yuwNuxJtvRuD7qM+uQWbNUtLeq2JQtgkqIU+POeUUDqDhrMH9bAPSLk74SqzS1UyKbHScVXBO0V
	CBJmo46i8zG1GZ57VEqiBpSmCmwGh+rTpq9LmoGHhU8s+ppcV4Q2EaJGLeJFo1uGMk2bo+jUumh
	HSko5bJPaLRnDM5dyc64PQ6BhjOtj4Ck5jwjxPS6A76pGgr3yhM2CxhXtSKMr5nLVmSRCxrebL1
	eRaCfVVisO/H8SW1GwY0/kzn7WhPPoothRDvBtgYmTy2DXSlzTwD//jM5Q938FSwmDC3bKk7NFe
	GjKX+otUkgA+cci0WQQpxzGNOwY/RaSwBgEthWZXB3k50h0g52bw8
X-Google-Smtp-Source: AGHT+IFqPfCf85R1WSNoSoStlsAU6Gwf4ETkoZiH7H/3zJ3Yl2D0KBpaXiFN05FTws4AOvDG2/uDSw==
X-Received: by 2002:a17:902:e882:b0:243:e3:a4e5 with SMTP id d9443c01a7336-24944b51fd5mr159448465ad.48.1756795674950;
        Mon, 01 Sep 2025 23:47:54 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd073c207sm10856900a12.18.2025.09.01.23.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:47:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCHv5 iproute2-next] iplink: bond_slave: add support for actor_port_prio
Date: Tue,  2 Sep 2025 06:47:38 +0000
Message-ID: <20250902064738.360874-1-liuhangbin@gmail.com>
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
v5: rename port in ad_select_tbl to actor_port_prio
v4: no update
v3: rename ad_actor_port_prio to actor_port_prio
v2: no update
---
 ip/iplink_bond.c       |  1 +
 ip/iplink_bond_slave.c | 18 ++++++++++++++++--
 man/man8/ip-link.8.in  |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d9b03..3ae626a03e6e 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -91,6 +91,7 @@ static const char *ad_select_tbl[] = {
 	"stable",
 	"bandwidth",
 	"count",
+	"actor_port_prio",
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


