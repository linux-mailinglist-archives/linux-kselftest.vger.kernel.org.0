Return-Path: <linux-kselftest+bounces-16172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C495D4B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC75285016
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC641925A2;
	Fri, 23 Aug 2024 17:49:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBD1922D5;
	Fri, 23 Aug 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435353; cv=none; b=ut0O5WrXJFVMsgWsjMCcbvZJiFO39vW0ABQGFr0QhIpTxIiRvK5dX3IlU3Qr1JOsI60lXeTGWlMMd6evVPog+hC/lwIi2PvzjP6S+6mBRXMiY/oPzAuX0Oju0Z7lk+9lHw2OWgqKhfj5oOMh4i+p54JTQHYKIe65b+xOntysWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435353; c=relaxed/simple;
	bh=6j5Z2GLBTYlWHUK6CmfBaeaSi0as9+i6bBlu69vy3ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C07h2yzM2fz6cu+DWJn8OVrtaeKIxJLsW4CqQV4YfVRGdTKMTsy7n73Lt3gKTy3gjhMnKf9M/rYjkZdWG6InFiXSJ+IXBsf/ixG8PQiB6LOCs9kdmPAjQRVeWeRvA9Clfqz38tho2p4fX3es3ai9ECimiiXal77yWhEz7NYw3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86b46c4831so1255566b.1;
        Fri, 23 Aug 2024 10:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435349; x=1725040149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szDQdcdN7BMvS+OUeXjzJL68Ac7ZIZYOcJVX3rjfiPU=;
        b=pm7aGfkxJ5VF8p943FpF0tUtNn2luv9vp1gZHd0svhP7hYXPzJV4VipaA/vdhhGgEp
         kax+fHYJnzKBrOtg/DutsFhQTDB9d9p7C8Jh6irykO6EE9DgHUPOwj5HPMAlNPtAcaaD
         lAeIpTIfZnLLJ40MeO5QkRTxVETVysTj+yzc5KM1qLRONJFSUqlMVLq8v2yuOe0R92VP
         TEqkGxAhIoUsdtvhSgpFVgprIqcdDKspVCGgOUECBrs8dX89fH+bhMrCjnBYybYWpGDD
         +K6K1YWugrL/SE5NTvynKDhzowwQO/7J7YQJYTWQ4yN0vh4Jt5zwT60aWji7Sr1G44MC
         DrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFJzYwTjvWy0rRIK3ynfKpqOQmIH68kGYF4V0GrHw+1SwDPDLgF1c1U7mPyYgYxXB/jApoUeqjXVmnWDrSY18x@vger.kernel.org, AJvYcCVJU8CAYAvq9554JTdKPoiJCmJH04e79M3U1GwyGg0kzudkhTw2eTVzuPFhOKR2zd9RjsoP5eE4xQU7mD7HfM7p@vger.kernel.org, AJvYcCX6TVXcTmYMohTGU5SraY6FFgTFOoYL2vnAXYIs3GFU2WgnYsDWbzQjumOHmxkrEs7AnqxN/7uF@vger.kernel.org, AJvYcCXE1LkpBIwR/oPqH/+R/T2pjCKJozjS+8Rl/lgFTfn+Dz32g+/LS4usHjwMgn323lo0Eib07tTPZiWnIJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2E6tJW3NWGdObGqS4PM5m01dDVgq09BzCERmbS/LzTx8wlk+
	90mbBOt/PrjpMGubEIGtKwRO8MXhEOCHu6/VUhP1QMKEcYznDedwXgV7Rw==
X-Google-Smtp-Source: AGHT+IGmnmh75QaC2pg0Pj5gbc6jCVy46lhWLPnQKudTsIRNwaTOH3VYiMBs19afUg2CN6P5y/vHVA==
X-Received: by 2002:a17:907:724d:b0:a86:86d7:2890 with SMTP id a640c23a62f3a-a86a54d1af0mr219004366b.50.1724435349090;
        Fri, 23 Aug 2024 10:49:09 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f62f1sm288840966b.218.2024.08.23.10.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:49:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: rbc@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org (open list:NETFILTER),
	coreteam@netfilter.org (open list:NETFILTER),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH nf-next v2 2/2] netfilter: Make IP6_NF_IPTABLES_LEGACY selectable
Date: Fri, 23 Aug 2024 10:48:53 -0700
Message-ID: <20240823174855.3052334-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823174855.3052334-1-leitao@debian.org>
References: <20240823174855.3052334-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option makes IP6_NF_IPTABLES_LEGACY user selectable, giving
users the option to configure iptables without enabling any other
config.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/netfilter/Kconfig         | 22 ++++++++++++----------
 tools/testing/selftests/net/config |  1 +
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index f3c8e2d918e1..dad0a50d3ef4 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -8,7 +8,13 @@ menu "IPv6: Netfilter Configuration"
 
 # old sockopt interface and eval loop
 config IP6_NF_IPTABLES_LEGACY
-	tristate
+	tristate "Legacy IP6 tables support"
+	depends on INET && IPV6
+	select NETFILTER_XTABLES
+	default n
+	help
+	  ip6tables is a general, extensible packet identification legacy framework.
+	  This is not needed if you are using iptables over nftables (iptables-nft).
 
 config NF_SOCKET_IPV6
 	tristate "IPv6 socket lookup support"
@@ -190,7 +196,7 @@ config IP6_NF_TARGET_HL
 config IP6_NF_FILTER
 	tristate "Packet filtering"
 	default m if NETFILTER_ADVANCED=n
-	select IP6_NF_IPTABLES_LEGACY
+	depends on IP6_NF_IPTABLES_LEGACY
 	tristate
 	help
 	  Packet filtering defines a table `filter', which has a series of
@@ -227,7 +233,7 @@ config IP6_NF_TARGET_SYNPROXY
 config IP6_NF_MANGLE
 	tristate "Packet mangling"
 	default m if NETFILTER_ADVANCED=n
-	select IP6_NF_IPTABLES_LEGACY
+	depends on IP6_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `mangle' table to iptables: see the man page for
 	  iptables(8).  This table is used for various packet alterations
@@ -237,7 +243,7 @@ config IP6_NF_MANGLE
 
 config IP6_NF_RAW
 	tristate  'raw table support (required for TRACE)'
-	select IP6_NF_IPTABLES_LEGACY
+	depends on IP6_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `raw' table to ip6tables. This table is the very
 	  first in the netfilter framework and hooks in at the PREROUTING
@@ -249,9 +255,7 @@ config IP6_NF_RAW
 # security table for MAC policy
 config IP6_NF_SECURITY
 	tristate "Security table"
-	depends on SECURITY
-	depends on NETFILTER_ADVANCED
-	select IP6_NF_IPTABLES_LEGACY
+	depends on SECURITY && NETFILTER_ADVANCED && IP6_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `security' table to iptables, for use
 	  with Mandatory Access Control (MAC) policy.
@@ -260,10 +264,8 @@ config IP6_NF_SECURITY
 
 config IP6_NF_NAT
 	tristate "ip6tables NAT support"
-	depends on NF_CONNTRACK
-	depends on NETFILTER_ADVANCED
+	depends on NF_CONNTRACK && NETFILTER_ADVANCED && IP6_NF_IPTABLES_LEGACY
 	select NF_NAT
-	select IP6_NF_IPTABLES_LEGACY
 	select NETFILTER_XT_NAT
 	help
 	  This enables the `nat' table in ip6tables. This allows masquerading,
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 784e2965896a..32e04837084e 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -34,6 +34,7 @@ CONFIG_IPV6_SIT=y
 CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_IPTABLES_LEGACY=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP6_NF_NAT=m
-- 
2.43.5


