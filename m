Return-Path: <linux-kselftest+bounces-23909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972EA014C6
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF08C3A4292
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDDE1CF5EC;
	Sat,  4 Jan 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUvJM7rY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1E2594A0;
	Sat,  4 Jan 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995534; cv=none; b=VLnSAxehaz5s7Hj8T344qgnOu9u4Qxl+QKwuiI+K8iXd8MQTWby9JNVHFJrb1HksmIp6ZY6cY2YDZ+KjDIU/JRJLiRXGG4IMCr7RzYuuav+aqAZOW8V4PpqYigvlltqDPlKYkzR4lDl6xnE38WwAsCff+cmBU+oWnQV0BxkvFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995534; c=relaxed/simple;
	bh=EFQ2oZ/pVpV182DEe1+4WrljQP7wjczrTMLRD//DgW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2SQqsbED7K0BfnicTNGs4tgYzHq2FClaNZCplzD4DTJyXPNmhTlsWL6Kl1mXEilkdp+BAs4C+8FkAgRleB8kRLjCRPZAnPBLLDDKDuyBux92LVOLVY8Nngv046X+soB4IHQlNj23yISlm0otCEMQptt2Q7FQWSVNqFGB4e1RJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUvJM7rY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166022c5caso161625315ad.2;
        Sat, 04 Jan 2025 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995531; x=1736600331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=CUvJM7rY5y5S1RHMZwAobmiI/PQeYZkjhuPviKvA2Xnleqiug/AdpxRVUJfBkt22Y+
         u6t2GIcY4xCa+Rud3ehH/kA5/ZXREpKodAVzR9EN4oB0thr+FSjtgMf3Pq7oTA5tQyNQ
         Ilol5xQcqB/mSwqmuXEj+Rp6Nv7EGR7Dw2dJ271kOyjZOtk9RuEU1EOVr7ExwFKP7AWE
         wy4PhGrul0MAk50yC/Xk6elowk/Y5PiY94Mnzo/iExKHBNKjttTpFyOzgiavezjyV8iC
         gUTzQn5y9ynawGQGgqkmtzY2DzXx//KYx0ma+PSFnJ2ucbRMay8neBQvSPEzTV0W8zBI
         nalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995531; x=1736600331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=sCnt0AHCmiwZQ0UbjzfSshcu+/qBlf7VenPPoUoZOfQgawAAUwom0hYtTFf1AlJJat
         McqLUu9fEIyR2vK2zH/oayDCdUVFVFBisaN7lNIOmf44UPBYGMVAGkXbNrlvYJHcCWC2
         2BHj3x58Dgf2Jj53pkIUOjn/55RKDHAsSMMIrW2fZArc0SMPK8fAFEmUMGIiVhC2RGrS
         g+FwWpEWHroLWCV+Cg2aDNYlYLG/X7aXsA8n1vCS/3Q3VrOUTuc2xja4NP/aE5Pt1mI1
         0Zs8KrirQMrD12dmzViu8XgIgF9CCp+mP0tJ63KQ0QLAY3WfS3MVhN9I9W8qYg9rhrM8
         DDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUFp/+dn4+XN3s9z9OLe9sAOHn5BAFxIiVwP2SeeMQ5OAjJTQXmJH75RfDI94g76fcyXbTdrOJP4Snanfk3@vger.kernel.org, AJvYcCUrBQ1LsyBlLuBvHbiGittjNKu+4QmZLJaCxUDQ4rp2zCNXFgBOiw/zBNjcTXFeemchRg8bmkvSQo14bW4fDtdD@vger.kernel.org, AJvYcCVPO1HDs+pARThpZDhrzKmE7bWch+ojUGa88rAi6/prvO+vyOlurJALtWgHZvymqT9Axy6zvGTdImSunA==@vger.kernel.org, AJvYcCVWumpVeJIAwVWIV2xFcYZxUaXZCcDxPFO8QQsV57uXBZyhtKtdCX6IXcmCAqylAYD2vH6FRz7+mwgS@vger.kernel.org, AJvYcCWk2rVmxPetz5fkuq/q4b6fEcKqU3oqDf630FnGEA2MoI2qS0XO+T+aDdoFiiGjWXUSlMy0TOyi6v57ig==@vger.kernel.org, AJvYcCWnwIT8Bb5212TljZasSoCR2c49WvmsnoTJezzuQNX+QLhUNDacwJcGPsdDoUctWoqduTk=@vger.kernel.org, AJvYcCWws1VtjakraxnoqSac24OZCfqvcG/H+iG6fFo6iZZFthnN0OX2UDFXiuvyLga5XRcWJd/X7gzw982IwGy+byc=@vger.kernel.org, AJvYcCXQS5SLRA3WxKo6+NO6/aYGhNWSzmGyIEUQrMDeVp+/drJW0N83qUVN86b9DchjkFNQW1Zl1WICnK5K@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWSSy04U3l1k2JOSn0P0kCAYUaF9cwjg7i59AcgGDhM0iQuYh
	Ex48p3Xt/CLcePMgr1rrInMN29kN+T35qf+HgH5d93ZFIw1VG2FgE2WAKnscVLw=
X-Gm-Gg: ASbGnct8V9GCYUkxVc3kxezfaBscJoXn8/aODvDvMc6SE6fTx0ZajIP2gBmQJg4FwmZ
	4BBd/gg01IN38n/GobkNtmyhPjjY//dBn5OQhRJhcuCLt3v1RoRDiXRI8nd/qD39N+KSSrhE4Wz
	y/0vPRkQur9yochoWTIu3UYONYzcUxk5O6oxNN4oCobkaZtHHvd/9sj5UUNL+eX+dlC2hYc+ZQK
	iCZ9sQ0hM+kNa+gfsSiK2NWj9o6vEZfIIfubDJyZ+xjdXM=
X-Google-Smtp-Source: AGHT+IFpOYXqaI1R+HGOEzzxslPytJ/PM+OYSeZsg4xs6ImgmD2P2d6ce4kFlhBJ9qWXqvAf2AhpWw==
X-Received: by 2002:a05:6a20:1596:b0:1e1:9f57:eab4 with SMTP id adf61e73a8af0-1e5e04609b4mr80108339637.16.1735995531119;
        Sat, 04 Jan 2025 04:58:51 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:50 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
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
Subject: [PATCH net-next v7 08/11] rtnetlink: Remove "net" from newlink params
Date: Sat,  4 Jan 2025 20:57:29 +0800
Message-ID: <20250104125732.17335-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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
index ed970b4568d1..04fc0e91af42 100644
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
@@ -82,7 +81,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@extack: Netlink extended ACK
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f902b8a5189f..a2246bbaf2bc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3758,7 +3758,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3787,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 	params.dev = dev;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(&params);
 	else
-- 
2.47.1


