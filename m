Return-Path: <linux-kselftest+bounces-16412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F2960EEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D90EB25C1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220F1C6F79;
	Tue, 27 Aug 2024 14:53:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E61C68A7;
	Tue, 27 Aug 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770404; cv=none; b=mmk33iBNeZP0Qxb+iPUR6l2xo+ca37MbKMOmrZEtZRG1rv2DnWin0Y9zLWMrLewHXrBjpFuQPacWexEdVbcGCp1vexa2yBtjjjbPfPlhDQxZtZBginF4gozGgVQbjCQyb/g1KTOW9asyU+WFogqJK4QfoBcGw9mZg7XFkpz+KNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770404; c=relaxed/simple;
	bh=0W6/5DXG2DcFRavoh3C8a698EAohZaBZxSG9dYdXaEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVfWCFA7lmTv9lNq/KJ4nIo5LvEfghB8dX4N8TRyN2A/mdHu3JRnmn1+Quaa1hGnjmFLs1f7QU9TECLrXRHPnyVrR17y9QlU0Fy/bviVxIQPXQcAXRC9dU6v317UANXUaCVsgONbU9vLkDFL1DIQ9Plxe8VIk1nFrtYcp3AgumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a867a564911so667906366b.2;
        Tue, 27 Aug 2024 07:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770401; x=1725375201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvnQoI11cnIhCIanCL/V7Jao+EuSmkBzYYxx+Al41ew=;
        b=tmzni0oqSEBF0EfwmHu2XqRLgu2gCZ3qfpk2I0/KWQnnQ4nf1Kz3Ucn0sBvGY+Qa85
         xQjrEDEqTP2AuedsQ6XZw7gBU1SnL2OHRptiaAD9DdzrSBlHLpoelF07PJyRQQs/tU1Z
         fY8rBaDj6c7mxN2sGKhR+nxw9V1mNnEr58OAUkUJimzWrdQj1OPdOZvO3RHMLH97tsdJ
         Hgl/aLJ4DjWKllLKs6EiqzlA+xE+jVs2JcpdUYndCmaCeYQvYMTHjWNLlsRBK5jHuY3E
         BY0R5GxKJfDoeuHQf35wDy9HgOeRUZylyupa8pAVOoI4H8M9pCGpsqO2/GTh8G93KaiL
         g6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUODUU7Ic1T4raeXHFlxoghGnWVFyQechMbg1aVip2PlmPJXZxNGmLbXo4funUn2ZU3mfEAOSHp@vger.kernel.org, AJvYcCUcBXQVXhJ/v7213PvjPYLjDtnFBFCnGkbV5VbyoCFKbn5y969y2TbOfgKX06Na8n9R6xO+Gdkq7l2qh+GZgRLh@vger.kernel.org, AJvYcCWg/301Z5jNZi1C4gYV3vouDzDJ3S/hBv4r6ZSRskN/w0jF0pNt7Bx2OtEGAoaFJyatvwPr8mXuboDYKe8=@vger.kernel.org, AJvYcCXhBbe9l6eKN6+bzLcahkplnGkCn6Y1g76TAj5kUgdvP08P5SPXF528ea31IQFJ34QPjKLk+leyMhYYW9HKKR5m@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLin+89l3fDKiEeweURFJeWH3E7YTlx91pJfR1A3PZzjMFhyL
	bDqBmjptTFJ9TP1h3qmTA3xLeQqbtnvZ6OwdfgzaAYX/i72Z3bKX
X-Google-Smtp-Source: AGHT+IGlqBmdWflkZ270cG0mS6DRoKaULCV1IJosYDlU6qtuKfTGEIQ4voFO+9U2BeQ0FzAXB2bScQ==
X-Received: by 2002:a17:907:d84b:b0:a7a:a89e:e230 with SMTP id a640c23a62f3a-a86a52c1a8cmr1039309266b.30.1724770400571;
        Tue, 27 Aug 2024 07:53:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588b60csm117491666b.161.2024.08.27.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:53:19 -0700 (PDT)
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
Subject: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY selectable
Date: Tue, 27 Aug 2024 07:52:40 -0700
Message-ID: <20240827145242.3094777-2-leitao@debian.org>
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

This option makes IP_NF_IPTABLES_LEGACY user selectable, giving
users the option to configure iptables without enabling any other
config.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/netfilter/Kconfig         | 19 +++++++++++--------
 tools/testing/selftests/net/config |  8 ++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 1b991b889506..a06c1903183f 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -12,7 +12,12 @@ config NF_DEFRAG_IPV4
 
 # old sockopt interface and eval loop
 config IP_NF_IPTABLES_LEGACY
-	tristate
+	tristate "Legacy IP tables support"
+	default	n
+	select NETFILTER_XTABLES
+	help
+	  iptables is a general, extensible packet identification legacy framework.
+	  This is not needed if you are using iptables over nftables (iptables-nft).
 
 config NF_SOCKET_IPV4
 	tristate "IPv4 socket lookup support"
@@ -177,7 +182,7 @@ config IP_NF_MATCH_TTL
 config IP_NF_FILTER
 	tristate "Packet filtering"
 	default m if NETFILTER_ADVANCED=n
-	select IP_NF_IPTABLES_LEGACY
+	depends on IP_NF_IPTABLES_LEGACY
 	help
 	  Packet filtering defines a table `filter', which has a series of
 	  rules for simple packet filtering at local input, forwarding and
@@ -217,7 +222,7 @@ config IP_NF_NAT
 	default m if NETFILTER_ADVANCED=n
 	select NF_NAT
 	select NETFILTER_XT_NAT
-	select IP_NF_IPTABLES_LEGACY
+	depends on IP_NF_IPTABLES_LEGACY
 	help
 	  This enables the `nat' table in iptables. This allows masquerading,
 	  port forwarding and other forms of full Network Address Port
@@ -258,7 +263,7 @@ endif # IP_NF_NAT
 config IP_NF_MANGLE
 	tristate "Packet mangling"
 	default m if NETFILTER_ADVANCED=n
-	select IP_NF_IPTABLES_LEGACY
+	depends on IP_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `mangle' table to iptables: see the man page for
 	  iptables(8).  This table is used for various packet alterations
@@ -293,7 +298,7 @@ config IP_NF_TARGET_TTL
 # raw + specific targets
 config IP_NF_RAW
 	tristate  'raw table support (required for NOTRACK/TRACE)'
-	select IP_NF_IPTABLES_LEGACY
+	depends on IP_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `raw' table to iptables. This table is the very
 	  first in the netfilter framework and hooks in at the PREROUTING
@@ -305,9 +310,7 @@ config IP_NF_RAW
 # security table for MAC policy
 config IP_NF_SECURITY
 	tristate "Security table"
-	depends on SECURITY
-	depends on NETFILTER_ADVANCED
-	select IP_NF_IPTABLES_LEGACY
+	depends on SECURITY && NETFILTER_ADVANCED && IP_NF_IPTABLES_LEGACY
 	help
 	  This option adds a `security' table to iptables, for use
 	  with Mandatory Access Control (MAC) policy.
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5b9baf708950..90e997cfa12e 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -28,6 +28,7 @@ CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
+CONFIG_NETFILTER_XT_TARGET_HL=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_SIT=y
@@ -35,6 +36,11 @@ CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_IPTABLES_LEGACY=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_MANGLE=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP_NF_NAT=m
@@ -54,6 +60,7 @@ CONFIG_MPTCP=y
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_REJECT_IPV4=y
 CONFIG_NFT_NAT=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NET_ACT_CSUM=m
@@ -106,4 +113,5 @@ CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
-- 
2.43.5


