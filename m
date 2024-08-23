Return-Path: <linux-kselftest+bounces-16171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7AC95D4AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB226284691
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C201191F8F;
	Fri, 23 Aug 2024 17:49:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBA191F6B;
	Fri, 23 Aug 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435351; cv=none; b=NbeK3pGVhGFPW4Uv9okbasNs9YF6niNpWzoevEPsG8d2YBN+/tg6SSts8+9nvAmMnLgJ7BQMOU1wyOXBQL+5Kliiz/TKj5toQS1Y+5Wp2uPMby+NlZWrdL005DalOXgb0++iVNrymXDS1urstsfp/C/zo1dcOPa2p7telB3cY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435351; c=relaxed/simple;
	bh=JPmeRkWYY+2KSVJkCOMkvdV8p0irCIdkXP4F6YkIbGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJs2Am78K0iRRfzg1daVXhkemxFwjLpLcd8c0NCXaCOrtskbvvqv1OYkGG3DhHEqNSg49FGLihxGCZbThanq8EJPWLFx4oauK4EsIyGWklc5XiKCA/hEnhUlSu138UutuadnI98+QJHPJqultfJQIrtOAihZujQpAhpWyHeq3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so3175974a12.0;
        Fri, 23 Aug 2024 10:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435348; x=1725040148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqD598LxBlFmt2MsNr5Mid1xXVOmt4wJxiSrQp9nSW0=;
        b=draMBGaGxo6QlWwr1c/ed/NEpjCZK5EpR02U8MsGP0l4+z2tBiezSFkXRA1Gz6A35M
         KZ0yScjwYixE0NbhVOTPOCEX9jeEtZGnnTXi7XST+AsR8yT7mY8BNUCPyn9kYpA0CQ81
         //mDuzSCZS8oM4otZCBM3lVu/laY5oHjQGtVftSgueu5zNrsFQXlb2G+dFZyPDCe3ZCY
         BelkShARrvLxJyLHUeiN46tHj5R9regOQGZZAFIpDyOm6Mw/xsF6PPz7UXAyoI8GFlZm
         wetF9LU5LWWCRXyA0ZkyasYtMsNemsQVopI/FYO5nr5CNDA4FRxTszaJPXzwZG4Cx/Bv
         C2wA==
X-Forwarded-Encrypted: i=1; AJvYcCU5rEk4OtKH/P6gxePZ5hS8waSY9qrH522ddcE6JO7Yv3dGhWv7GjtgkIHp8P43WTln6ZFUIXKJorOCxEB1odNo@vger.kernel.org, AJvYcCUt3voe2AQDbK3S99LPP08j6+zvVCgYjVOUbiEUf6n3bxd/tNTmkxhyS1YArmbGUq3YgtcVFxsjuLtD2PQ=@vger.kernel.org, AJvYcCWEXxa53Ruerzvo5J8BmDNO/Ef6XZAnIwPN3ivI7sQY8jIw/l/FcEMZ5+KyNZYA3+SEjKoRLYgn@vger.kernel.org, AJvYcCWLNQpW/KNoKI3isreXxHzIfdZ631PCAK5rPcH3ozAHqOGlvPum4vgX/H4j0ukolsU1jd44emFmynvYPh73V/vs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DXZ9+BT/vZKq4ZHmrJFOKzykF7NadD635C0iqYhPAnv2Th3v
	npkt1T5KtWRfRR3bZh7pAwcimwo0pQB8aZHvucVjpILfmApK6tdf
X-Google-Smtp-Source: AGHT+IGsCED+/krMzoX0Z0slfJR2jMjGjilqafqsebtwBtUuFyPsekLUBr0kXzc7SSXxd6+vTjkgCw==
X-Received: by 2002:a05:6402:27cd:b0:5be:f4fe:5345 with SMTP id 4fb4d7f45d1cf-5c0891a1f0cmr1780942a12.24.1724435346999;
        Fri, 23 Aug 2024 10:49:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ead3esm2468053a12.46.2024.08.23.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:49:06 -0700 (PDT)
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
Subject: [PATCH nf-next v2 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY selectable
Date: Fri, 23 Aug 2024 10:48:52 -0700
Message-ID: <20240823174855.3052334-2-leitao@debian.org>
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

This option makes IP_NF_IPTABLES_LEGACY user selectable, giving
users the option to configure iptables without enabling any other
config.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/netfilter/Kconfig         | 19 +++++++++++--------
 tools/testing/selftests/net/config |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

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
index 5b9baf708950..784e2965896a 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -35,6 +35,7 @@ CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP_NF_NAT=m
-- 
2.43.5


