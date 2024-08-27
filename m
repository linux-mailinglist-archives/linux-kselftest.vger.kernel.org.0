Return-Path: <linux-kselftest+bounces-16413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA94960EF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFCC1F2253C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C91C8FD9;
	Tue, 27 Aug 2024 14:53:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C81C6F68;
	Tue, 27 Aug 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770407; cv=none; b=i8uCYo+EBld6rV8Krw62VVAFxBOmrq9RNdBAS/GRH1+dy+wDmtbvYFbV5Ft77ucbUdGJIZNJ2JNsyHj/b7XCeXsM3OR7vj4/DGxnar8lNRYBEIkW/Vj1BJpJDz+xa65JcACBJ6gro4uXdG6Z2EWEGkgyTGkHHgXCfZ6d/rBcx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770407; c=relaxed/simple;
	bh=qKmQ10P7wEu4ZGICAJrTaYyAWxzwXZ07wXyJ9Jkb5Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbDLdW7TdKvxDu/8i6jYnBsHJgRmbsbhZS1T1NEgwa0otW/VJfjROwWuiWuJd9WCnmd5fZvSwZOwyZQ4QAzsE108sNbcTCM+9J7Mq436HGqB1J/grhnlNidAZgHikHugkRqMVU0ixmujiUozJdOwB2SjLOFonoCJvoo6EXQNKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c0ba8c7c17so852430a12.3;
        Tue, 27 Aug 2024 07:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770403; x=1725375203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HOmad9WKjizUc+THpEm69GHMQSx3SDgk6R9P99Vdmc=;
        b=GMp+X1/mWnVS+bE0vOe6uzXuJHjaALEMMKoIfz+OVEE3AZN1dWUjzsKtRmgGyOGIhj
         aS0U6McujKjXZYFvu6TdEKMI6mcDXwayBQrpAq0ffCCtXOZW295tqDEiUFWUqPvwCnxJ
         Ws/jP0ebmIYxaIJWdF5NFz0zfpfhfaPyfbrbHFwgf70F7PUZsvs0irePufFoH1ZBvgRs
         ABCP+0T3heBPgi+nA5PXum/47zQUqGtj6g6sRBFh1TLmK1HB/IAHVNP4l637IGmM6tpB
         wJ1KL5SBkmi4AANVEklRbj6uFHTO1hbLf7qXXeZVkZKhPPwKYY8WJgAnRf1N70p71rxS
         3VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4dclpWRDhycb6RpeBP+2IXBgy53owtIXffpG+nB6d2YgTKjwDgwrtqyQ0GohahNKiSrM52PHi@vger.kernel.org, AJvYcCUTg4sXbD1LPTWoMBF74yV+uiugcNo2ayvsZH8SxO5tSBu5wvll7xClsTwgzrPYYzUkoXTN8ldNuV2hzfJm+ac8@vger.kernel.org, AJvYcCW+A2quWkKALD3VXXtEgmKR0xA83pymBTM8CQL6nNeeWAOjxcrNq+3bdunpnPhKoCcoL7QQJ+9x/VlkerovDGmM@vger.kernel.org, AJvYcCWkvnlggerlNMg1Zm2gLka9ZpdGlz5TcIT6V1pUnThK8Rcx8QLexl9iWTQ21mAtUlRNSJQcpUInKw1IpXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mdivxM0YUrOn5/beGEjV0vIZH8vVUcFmIw3ivdmDbIDm/Zg1
	+RYPpOxhjIwXoV50q0v0fF0ff+6/Q/DAQ9fByCCZ0Ivx30Qgz2q0
X-Google-Smtp-Source: AGHT+IG24YrM9f5H3NKVsZd4J4AbMBgyEtSVbgqInkakGRDDRFCvwSEtCuDcKk0vBfiaGCi+ukVooQ==
X-Received: by 2002:a05:6402:84a:b0:5bf:17f:4b7f with SMTP id 4fb4d7f45d1cf-5c089175dc4mr10932792a12.22.1724770402759;
        Tue, 27 Aug 2024 07:53:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0e55023f4sm277912a12.70.2024.08.27.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:53:22 -0700 (PDT)
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
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org (open list:NETFILTER),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH nf-next v3 2/2] netfilter: Make IP6_NF_IPTABLES_LEGACY selectable
Date: Tue, 27 Aug 2024 07:52:41 -0700
Message-ID: <20240827145242.3094777-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827145242.3094777-1-leitao@debian.org>
References: <20240827145242.3094777-1-leitao@debian.org>
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
 tools/testing/selftests/net/config |  5 +++++
 2 files changed, 17 insertions(+), 10 deletions(-)

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
index 90e997cfa12e..e534144c75ea 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -35,12 +35,16 @@ CONFIG_IPV6_SIT=y
 CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_IPTABLES_LEGACY=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_MANGLE=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP_NF_NAT=m
@@ -61,6 +65,7 @@ CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_REJECT_IPV4=y
+CONFIG_NF_REJECT_IPV6=y
 CONFIG_NFT_NAT=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NET_ACT_CSUM=m
-- 
2.43.5


