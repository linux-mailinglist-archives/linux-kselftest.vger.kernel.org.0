Return-Path: <linux-kselftest+bounces-21928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4D9C6FFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802B02827E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761742038DC;
	Wed, 13 Nov 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeGm5nw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F51FEFA0;
	Wed, 13 Nov 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502684; cv=none; b=K3Gu1JEj5dKaeTUkdHda/7tL8hEQoVqUKKLIdWzy7fNXCJ5UPgjIprTOGdtmr/iwZqa5czcMW1wmepdPi+KSkxKuEc9/ig21WnfsnGjmUTg7n0DWTH6FTFSBeVMBNY3tVhU8gsgmUPLcdNaV9AXjUMieO1OKfiOej1wkBM3cl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502684; c=relaxed/simple;
	bh=LFiCqhXlvihNQqIohXypmeWbbfe7D5PEOM7sD6uUzcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw8wNHAf6N2gUL2JT+69gxYa+lwUk8wK6OVJswCe9XccVsL1EZo4vrI0l3uDVmpCRcJdRwnh5x/EM2jXI6D1BvmbPdmjJjocsOaLI+t2asEOCOdfEokWEjlfjtIwCwdKEpx+k5ZhA7Y8iT49ulN3KsqyN73EkmhZHB6wpcfCThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeGm5nw1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e91403950dso5270253a91.3;
        Wed, 13 Nov 2024 04:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502681; x=1732107481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=NeGm5nw1k+oyDwu3kG5xHAo0ijebYcMlLKi7V8JFOGFrVl1Wy82WxKNNhxGtHNvKOj
         53u4mMm5YIdyhkm4ZU3ioXlpN2IBw0oKs9/BMNQ3VzjSW1Ryu0lkbiQTdljGcaQcceAO
         iITpxmbiYZOMJ5yTW7NRp22qZGse7VYMMT69FTnOqsHcU9eLdVg9yqeNmJNPZj6ONnjO
         GqO8blpwMZMWRoCLAiAewb2gzXfx4UE6511kp0/IdRtQ3IfE0ew8dmML3el5SgfTi4xg
         tnT9zSNKCrnnJHDQU3Dxk3o2/0gCgr5nPxIWNe5buQoNjxaJXMa9agzlH1MAEWNW8i6v
         yoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502681; x=1732107481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=hav+TrBn7f5RLeyoCSRN1t+LIGPzjBi0V1QDHFqKBYlwBQXLz59SqpdhWCqD7TX4th
         IeIINRvmzIJSHDKdKr/mXGyld5el9QXnKh4LtfRvkwDw4AgXFcAV8lcN7mqdUsNZssAF
         Mnv90Iwawoqw5inmYhtlvZL2Y5nZCKaWhiHoJttWQg34CeCz0VI9MHbcIJu7bpaEbHGi
         5UKOno9fydpVhbMykhc3BI/gXd3i8TNEdv9YN5HkIgL0lhi8/rnKdWBAW1CqFeW6wRt1
         ZxntDu5m/ByuKDHkrcMRE5X8ggKNZ0X1kY4KHXU+wgbR2yeydzoZz64Rpc58w2U/oZ1S
         q9tA==
X-Forwarded-Encrypted: i=1; AJvYcCU5hT9VlNOnBVylY6GYMaxa3mWJaI2DDK0qSgUC67UMav2+csC/Xyy8YJM/e94xWygfQGQ=@vger.kernel.org, AJvYcCUQoZnR2PpcZnBDWVB48PZ+FA78ifHr8XdBp/2QZnkbNFABtSBzYshVDRyRj1b8Y77zdaLFXKmnXmneGkcjY8Y=@vger.kernel.org, AJvYcCUgNg4un5PYDW/RmM5IvVXSgNncLCg1BlgiDlAgbZW5cT6Pi7g8Mr3kYVnZQ7CXVjZlTgnkPzGdGCTf7w==@vger.kernel.org, AJvYcCUoANxcDY8gi4PJgWNbTCoADnV2HGg73mpaIR4qgTKO5OU1jk5gPZqpmlsKlcuQpzoV07hsZHELn73d@vger.kernel.org, AJvYcCVmpR9slt4MKng9Z2qUQ7eVv5+C+30Q5wlnQXsTawa543wRmJZzN2a6ul09SZWDMuYgSsX9ToBDs18F@vger.kernel.org, AJvYcCW7VY5H4+r/yF9VY2LINLyoGwCegZ/zUrLyuVYC/cIlv7JRDamVShxKtYtgEbe4zPdrnxIeu5S+k/slNA==@vger.kernel.org, AJvYcCWKwNl54bQTQYv++0sor8i1NSj2ENY/L1jmevy71BoWkPvTRkb69mmt/W0MwBgA+dizyJVjYRxLqjIhc6a9ks2a@vger.kernel.org, AJvYcCXlFbXo8tg9PYmIi2cgZLBG4eo/8w3CVib6aqcvFmthTtK7dyefQ00dckvM3XwXBgC4jVmE120fAf8fjF5H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs5pOD93QWAXA5w0qKZR16+dBzFOY8ncvcfn185Yv0mo4X1Cj
	M0QuxwhnGG7c0wpgQFgihuXO5GyUjx2z00qki5DcbeszrHkI4c71lqe3q+VX/Bc=
X-Google-Smtp-Source: AGHT+IGHbWu6TztKh6tN8Sp6Cv2pF+0T1uVgEKu2tiVbycxbLB+U4mJhCEtmHq5ke3dUIYABcOdsZA==
X-Received: by 2002:a17:90b:3907:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2e9b177fdcdmr24476632a91.23.1731502681391;
        Wed, 13 Nov 2024 04:58:01 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:00 -0800 (PST)
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
Subject: [PATCH net-next v3 3/6] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 13 Nov 2024 20:57:12 +0800
Message-ID: <20241113125715.150201-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
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
index 327fa4957929..f573ace60234 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3846,20 +3846,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


