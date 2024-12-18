Return-Path: <linux-kselftest+bounces-23499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1E9F6693
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4731894125
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585A1BEF9C;
	Wed, 18 Dec 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjTLjUk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62A1BEF80;
	Wed, 18 Dec 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527375; cv=none; b=jQFzbKvQ846P/KxqEUF2ZGbn9bC0gF6j/nF6DAqZEmXG16/sXVTT7KaKvFU/3vWvphAn5AXLMCnraLA0j7Uc7rKgXB6ZMomLJfEU5CxVg1056hSaF3BWd3/g6+URx0287S7EQ7if6KKSCZkppfwt/vdS9zz7bwqGwGg93gT+qGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527375; c=relaxed/simple;
	bh=Egm70QFHoPJQeKbJRemzVe3pKzsMp6lZRsVFCxj3tAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meiLWGGmjayuW3ELdlfVu0oBZIhD/o1wWchOI7TZX4fmXb9ce79I1MNUENv91FHloqPhec68mJXTu5olg1GS/Tm7lLIUtpVwXxavQ1Zok46dVTf5YtRvmtJF06pXDqsBr1z++66qKYi4lXZI0F16/UDQL6tyCUlAwKqr/8dswi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjTLjUk0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso5823381a91.0;
        Wed, 18 Dec 2024 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527373; x=1735132173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=CjTLjUk0q7PWkD2Wk8lKDND0twaWac56uX+h/mdW2vX6gLjm9Ime3iKmO47wb0slpi
         /T6eRuJVW1Crm3AdG3O0uz2M6vS5PazvOpVuC9n9alVaZwq6Qo+FkKtsHyEZnECHqJN1
         WgKsRXCE5vjre0ZptRvxozWew6vP+J5nLeInYnOAL/mtibxtvEDQqaXB7FCfn04EL6i5
         bSQs5rCEx+a8kjwxJS5DyqzkbcGrblbE/CkXjPOKq76DOnKpnXet+At6LipvyfeHZ2rU
         mJoQ+JuZVIlKZHxmWjrQYhkwzm0sNwcndWnj8mFWohaeVIdl3b6f07IrWY6J6+XT8k0O
         7vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527373; x=1735132173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=l0Qt9Bu+2CaJZfiTxJewFk+cqjTO60upncl4rIGbemDCMkOEucRcK2i/UmE53Dpqnf
         eesQSzyRWFfWVWcNmrTPRdzUC0cqQL7AvFWk9uBECA5PiUw7kkYoY/ZZkYR5IXc66aB7
         M233xz2POUmV1EflBvoZJ4XVga5Y0KICQJzRmBgrSU+p+wGLju9T9RIRK1cWANBFSjug
         X+J2DrAPbjLv/JoDq7l8TY4rweCNAD3VeghzcV5ESmIOKtu+ESyidFK7Rh34DZtvZo7/
         ElNO3xmkfxu0FvNZ3lJZABkNPrN4IMTal4jwyotteRl43cjcOxZta7/dJJZ0eAqaa7vc
         egQA==
X-Forwarded-Encrypted: i=1; AJvYcCUUOCpB2jrdhYLfKT8oFo7PpFUDU72FE/7E6czFa7oare13pkYm3s+RK73tLDeCrlA0DXn6bQzTnIFWfVVtyhM=@vger.kernel.org, AJvYcCVhpvXVl8FB1sFCDZeGr89w2V/5+TxmnPoiWSa4JzzeyqRGigAjH5LYBpPx4O79p8I4ri/JVSQtZwWxpdQTjvtg@vger.kernel.org, AJvYcCWhp+vx+xg5uRT6A1B7zfQ4MDZrlGNHjR1JVxCFEXdNStgQPFC8cuOMf1YtiWqjCaBc5FdFi8x++zMx@vger.kernel.org, AJvYcCWkOs1Gfg7fpRiO/BD841W574rhHDVMYUM0xS0wbVKveTxXwf9lkRLrIh7Bg/aJ1m/Q748=@vger.kernel.org, AJvYcCX1KRy+ndV/nz6TjsfI8NwLjCsRpuAO4cUyfFozh1Stg+UEqQlMPPflGEqsTKusulqa2jAMgMe6Ow2Ra8fx@vger.kernel.org, AJvYcCX9sCvSEILuTyszKqfyPCFS7gGOTLTCNQMCE/vY6oRImm3LtJ2vMgUAambcDjSauci/MNCvkCNVF2VA/w==@vger.kernel.org, AJvYcCXFMQ5F+c56nXRPKxc4VPMuKRPgvB47L8KeBwrJrB4a0rqO4mt5BjhUw0Jtf+IHKLafaI9bL9fhTheV@vger.kernel.org, AJvYcCXQsrj3IGCy00zdp9Z8yA3ron7wwbtKMzdyo+IG9KcELUZK4Te4HveMeyZCsFEEKs8fL5c0pLH75ztIBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjcZ6ldzMuBq2PuQ8S6VZ1TIamNBlxlhFaSZbBWVEZYNzStkG
	LMkJCM5erKcBvF0SqJTDgmJJopdPNBfUgq3J6fBX9RHYfARaFCiRSy6JoOQaeSg=
X-Gm-Gg: ASbGncuokuBb5mP9mPPtGw0diTcwKdbXEPhKg8Jh5uOERKM5+37Fjm5/ATj3ai0+4+4
	tNQ/DCOXsGFdikCO+c2VWzEQt6CoOaesP0e9SI8mowt27d9IWn2tPI3FxKfUpTTCo9qQWfE8uCD
	fayTFA96f8xEH5SMdjfkPpdNQntWEH3dTgbmW7oGBjKvY7rLLQJl5yH7lmEprJ2dGOpIpA6SKre
	x0pl9EYfXc3ayyyz3bSg5Q5Z5q2ybcV4mPBF9kW7EWvXOU=
X-Google-Smtp-Source: AGHT+IGwupxRC65MgCyutia2fH86BtEscvZ3hC19otgxhx9O+M/gNgTyzVuSwrO7sHgcHk/UbitTJA==
X-Received: by 2002:a17:90b:5490:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f2e91f1112mr4682540a91.15.1734527372952;
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 18 Dec 2024 21:08:59 +0800
Message-ID: <20241218130909.2173-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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
index d9e363d9fa31..6a2fa030c8e0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3851,20 +3851,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.47.1


