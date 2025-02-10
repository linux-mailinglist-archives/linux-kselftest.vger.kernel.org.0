Return-Path: <linux-kselftest+bounces-26168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A2A2EE3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8819F3AA4B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13C22F387;
	Mon, 10 Feb 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URakFIDj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1E22F167;
	Mon, 10 Feb 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194293; cv=none; b=BV2ghvOXKHJv4ZSo2YE/pgKh2grcJk0hrfSCjgjxw8baTrgeofX9H7X8DgwmgfNBiJakvsXbcp/HCgmnMYvPn/IS2SC0JxAZO8NU576/P8xrg1Izio3bRXAenIxYZWsYqq62NkFmCAINwRVt7ouOQO0Qmq4Fd/+qoMV/6Y89rMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194293; c=relaxed/simple;
	bh=FC90xSA6ZrsI4/RZzCluVx1dKwXoKKlt/hRW+0eki0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2DjxhnK2vGCVG+RWWy9EUkHfrPHmXQUovA1xRVATILZARNxntH0TvDFYolaRiIyBhRvnhPsE3u4eSY6kvSwkeVQJKWzVTJ9U6Cu5cvcGl0pbic4VnJGNBBYHf7sxkElb4+oza7HgXPO9zQYrZGb9CJPz1gSZ5iPwbKrn5rMW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URakFIDj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f6022c2c3so35479935ad.0;
        Mon, 10 Feb 2025 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194290; x=1739799090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=URakFIDj76kxxhgcwZq9qEA6GLEUWaqu3EOQHSjSCQO9cm6iiRF2m7uV4AGsuTKqGK
         NsTCjEDtisWGMsm/I6P98rcHwAwU2F8i75gl4YL6p59rh3+MULyp2Zvjv8SlD6NW26ha
         LqZkLSd7Du82G5/yu0nOrWeVMMGEcsp1pumegdD+rFH2Xx7kSudo6hyjge6SJdXyt5Fe
         YicdP2xOgxfS+bIgxKI4cq6eUPAjpCSeOVpvwxcyNr1RSkbH2GLMXGUaOVKMqpXGu8C0
         jT+UjRrTeeUdbcNMj28T9w0Rqw1WHwizmUQUyvFNbFNUizYNwyuEAnCxp5MOrJOAI/Xz
         gkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194290; x=1739799090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=BSHE2pK3mCmmq0QRvVAJhBSPqB99PrpV+CE0te/272ADA7F3Wj0Ejq0Ji3tZenbc/a
         lgb2WuJWup+MMHeImBrNdelymi+e7xGvkUaANAJpNcQgdn+jECVJX6H/iK6XRWEQlCrN
         w4MbpFUMJ60t2OiHD/N74S2xRNPFKQaZzwHZI40+h/JVd7hiFJJfkP9PKdr9wzmaOaG5
         5f1+5OZThachJlAG61UlbVxglpZ5JsGAM68UEoWm3OLcOm/25i4pEjxqRdouROk29QJP
         KVR5Eo773egfjII4FkYfRUMWtYMRsOpY44rsyBP67S+Pte4x5eBz9NYMiS+jTO74dsiS
         zrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd0JLDYTo88uq/y1ia4UD3DZvtkXW3mmtx8vzo62zS49dBGktbBjOC+kqVCoBkcqwPM9DvtcAOpoiH@vger.kernel.org, AJvYcCUkQw0E4wF3wMNPvL6iqSkNx2CpcxgwP4dART4DHb9IL5LgXzOTCH/qP7nuhogopqCWWBzM8SHmWsDy5QUc@vger.kernel.org, AJvYcCW0O4u+x+U2mYqmlsuIY1SifefJdb1ub1gChVGPC81jRp7LEW/SMrXO2WJI3GlmPgepMChT1YB8e+83@vger.kernel.org, AJvYcCW9CPYc/Dn9d8XDR74O75deMckknz1imwAOHd3SA6pxBC9WPCNU3gTl/2ZPzt0rGPRmEVKlK7GOatzWuw==@vger.kernel.org, AJvYcCWT1EQqJyUh8joi5xZKVygl6qdhItj1aEkqyMOsb+6Xy8xcncSfDYQkmnsCKnsmB+/Keto=@vger.kernel.org, AJvYcCWnrDjYlSjb8NK+XVmtpYIjCusRQEP7jG1LtxQGUElZyWItBzc7aPgsDLRTrN6Wla8BHts2/Uxg4Hbrlg==@vger.kernel.org, AJvYcCX4RBCxqxnYeG0r0ToJccglzzix4vWg4LqkmyDnSmFeHDLHS6X1FwihSuQk8AcQezPckhq5pcJriqJ9XlndCtk=@vger.kernel.org, AJvYcCXDuQPQyPBOQtGxVyGXW+FLQ9OA9DrOLoNi9RE8AUMHRS+/BOL0IVYIWAumWPsG6+ZKOnR8E1+2WprkLqE9U4EV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7XANwlljNuyksHY3/UcQskHJnWBphpzvXgwh78xSUFf0xzNc
	/AyudIXAcBzB6+lDwDMoNIDset7D9Prd+pqfmnja6P9Mr4kwiafU0zoWbd3SLbs=
X-Gm-Gg: ASbGncsIBl9WOfuYhyyU2DQyxxYb92USSWpVXQ1+sNqWIfWfoYnMCLZ0pLfT/Igw55J
	2UHDDlOT9OlsJukxvZCIGNfiksKr/ld/qryfyZW3OYFdZ0HV5BOfUiKnqYjct0bydgjqWrJdJJ6
	X7LtwDFtYeL+k4z6u5aiWhf0YNSCzUAhBMVYe2kx+OfQDWWUyhVFhRP+hedcp+G+1gdpinHICRT
	Wgnyi/lxf71y/3qg6rtJ+jU2RRFdgsYYaMvvY1PeofZzym1zCFchlDQ66zvEUUyV6tfZZnI/g0v
	sejBvw==
X-Google-Smtp-Source: AGHT+IELdC20KTjI7AEzrj7SsYJqrzU0cpR4bU0xmzWBFbAdZdANoU6evRtqtyIIyxHfa7kTbn7qJg==
X-Received: by 2002:a17:902:f60f:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21f4f7a257fmr230770855ad.20.1739194290046;
        Mon, 10 Feb 2025 05:31:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 10 Feb 2025 21:29:59 +0800
Message-ID: <20250210133002.883422-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 00c086ca0c11..dd51240431b8 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- *	@net: Netns of interest
  *	@src_net: Source netns of rtnetlink socket
  *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  *	@peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7e98f3cd102b..e9af0775fa6b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3797,12 +3797,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	params.net = params.src_net;
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.48.1


