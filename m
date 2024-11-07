Return-Path: <linux-kselftest+bounces-21603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7109C0779
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8900C1F2225E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5D21218B;
	Thu,  7 Nov 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkjP5DAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9081EE019;
	Thu,  7 Nov 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986228; cv=none; b=Z/LXtL1ZfIqVkvGraEevKR52CU2mGVzD03dqWllqRUmyI4QmrXImOGPMcq+6XxteR5guw/EolxukyM5mGfOFaupFlfmajSshuDaRP3YgUuq8Kc4uRIRe7Y6zaIP00UeZjvZkB2uOANA30zXjYhSYRZl58reKqkcaxCooIwhqnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986228; c=relaxed/simple;
	bh=iw/SM9Psp33X0c2Lv+k4yRqInuKG2rlsgifBPqJLhmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOgWxFX4Kt80znulxzjDIUL7NUy9jc78rPsAS7hy78EH4pInGiWUUdTkO0u7VTjczaiooAQOuh5RwF6Owp5Oy4kuF12ryf/6L2l7WYUNVHzue2t3JhPDvIqWNs4NvZ5EEL1Fm3ZXr6ZfpONhIreZIRQX1T+epoCce4055KsD/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkjP5DAo; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2884a6b897cso510236fac.3;
        Thu, 07 Nov 2024 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986225; x=1731591025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcQAk/hItgTSgG59VLwLZXQpYC3MmRXj2uoY0G4TpWw=;
        b=GkjP5DAoC+HPPt/lilPLHB9QlT1ut4FO/CL4VQHh2ECDI4g7khicn6pUjetRouoMBy
         mnkGKW5iuZO57CWaFWRg7JJHD4xr1WNbYJOHyBQHxP8hxdeMyUZLnog6KmC4QXewzd12
         TkXOyUUEEZ6xDplP7uLPP1gAeMZkm9zgaVM03NDpRoA/EWRjZmKDSn+RJjo5f28S065C
         C1vbQ6/AL3OkCZelk440rA50LhkExcxWtGPmAc7o24TCo0vMg9iN9k6FHHLrU6kXCFhb
         8uHXkSzqcDGHOVK2aFyolvlyjTwjaJk/nnX2sdYdBrtltzcu6WBQGa8oYKHYphTYaymU
         ueOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986225; x=1731591025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcQAk/hItgTSgG59VLwLZXQpYC3MmRXj2uoY0G4TpWw=;
        b=hoo+W0Q3duU2ziBsBDGqiKBGMbu/M7EKSgzOY3UuUCJnrYaEbURnn1KcQ4bqXn7ZLW
         CS0Nzjkt74b8ThOx/vTx1OsyaY2SpxStmbkbJXevtje1YKcKQs2SMzlLZGbJszCXYnxv
         TpnQmgwhLwkWG0ZweCwZPO0GBm5/KB2UI+K+Pa7+IkL6Y/4n06ejYV80rJyYWWO0qz7L
         VjZxR/TaNRg8ARc4dNVMnWp/cj5HiBPlw1HHVyaQ6Nt9bsMM9jMOj/GHwD6/G4apOMT8
         5CmCmxJ5quIjs2ePmmE/KnOQ9QqhlTWIEtFUUvi+F+hWbULFUyU932B0gMk+kNs8Z5UO
         uLJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVefhginyussyyt4YwFwUssLfuW79bxKwzEllx+XKg/h8OvFtSJoVpAfAiZuZKMcudX26O+EbfYkSJX4wAgTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohfzcPzWUEI8KeIm2OXFFhDn5GG2sV6lPmjbOFg5dtuwV/u4m
	fI2U2aXsRSEPEzIV9SiBldPR4Y7xOjf3hqHsbspEstUlsyAv/Jv2nmmK9Q0j4LE=
X-Google-Smtp-Source: AGHT+IGYtGTmiIvy/cHSxBYa5kuiJKBz68ystxKTgA/zLNlQOrr/HoyXfzazbNJgEL8sE3fRt9dAeQ==
X-Received: by 2002:a05:6870:a40b:b0:287:a973:2c66 with SMTP id 586e51a60fabf-29051c830f8mr39192512fac.28.1730986225349;
        Thu, 07 Nov 2024 05:30:25 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:24 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 1/8] rtnetlink: Lookup device in target netns when creating link
Date: Thu,  7 Nov 2024 21:29:56 +0800
Message-ID: <20241107133004.7469-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107133004.7469-1-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3b33810d92a8..8119f4ad9e5f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3744,20 +3744,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.0


