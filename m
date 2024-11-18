Return-Path: <linux-kselftest+bounces-22181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00969D1319
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6590F1F23378
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A51B4F25;
	Mon, 18 Nov 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrGdvGVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BA1A9B40;
	Mon, 18 Nov 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940413; cv=none; b=aRW1oeMPGVy7mvnNya5CqPy8lqKqHUXpiZgPvWTD2BYJ358SMB/ciKtglgm6PXQy2xOMgK97vgeC9r5zKuhA3CAFpjKpVCI2jVYlM1vm/53PlRnDwzXOpe6zuZZnHtogVXHAZIrdVFrIJLimGrs1txEugb4/NOrJSJf1pNqDYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940413; c=relaxed/simple;
	bh=nxdsqBvo0hyUQybkrGt/3BQTttdYFRelexxuCroUuOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ2sT0O6ewDWEYr60sIMxhFJ2tebW8XCaZmFTZA4PeKyGIGuAUuBsjPTazfpup39FolcASNWmkBnRpr7g8r7RLfxTs1VeK+HkfVJuGzckOmbY6oNVuU2A8vvdfg+Uy8q3SQc05IK4FEysEHtpZJpr/TzSCbfKQGYKwSPPI+z+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrGdvGVV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3155702b3a.1;
        Mon, 18 Nov 2024 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940410; x=1732545210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=DrGdvGVVhXohpQZQJOGA5MmnBto+9SVa1wU7CCnZUl7bvmxrBheCSYYmwVpd5B7e1U
         hzm0aYLEvefXpaRLr4XAeUDeW61p0ik40barR1RB9PorcFmRbxIwbUZkDXdbM4g9yLpP
         vwj01zgcAJTnYfdd+F8ttdIozePguVb0Z2xqNe/GMRahckMUiEudRK9WMZ5+G2Lx7rZH
         g+Eijvmr5s5NX1yfi0jq/Wtx9Rl9h1OG8PRrZjiBSKw4a2RvZvH8ys7LHysGLef6cogz
         zDARoeCuVlYMoohkKlEktt/7RdFK5ykrMqos1K2AVHjYCCD8sfkRyobZHpzpsUZBCN5Y
         VpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940410; x=1732545210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=pi1YAPCEbSPVwuQ3vEbrqNumrzYCq9Nk8sibFaQ9YXMciasGqgF72nQhha4Leyci4N
         cpmFjJvj9PkMA0ZW9BqM6Xp3eKkY7YC0+j97i0gJUzr25N/5sSZ1hgnf+ZfzcahP++On
         pAlh/tTFgvVWbk2mrOAcvjfSF/OG6pur7jUHeG9tYWHJszBx8FF7SK87106aLSftpjD6
         vLOVfJB17CzclzgVaJ81AqFg8EPv3Xuo6UNtoRkEw5Kk/7LaBhSkwz65QcPAvkmZT4dS
         JUXfW30mQD3folQuVaWWDLFE7TpLuD/h2qGUeebjoCEBmISzYlaiP3nXHwLW1wNIGP0o
         Xk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgE80ggx7tYxaDCZoJ48VlgHcWplQAbvJbu0vy6jiGznE4FP2F7ls9Jeew6/JOA5mTMeGyQN9z+6gqXvcUwFCo@vger.kernel.org, AJvYcCVHYd9PaMrX6SscrkPd5lB308xbD1rRSSKfPKceFrWtykemZhlRhxuasc1pu6VMoI5vj5aXtOBwzn5aeoH4TjY=@vger.kernel.org, AJvYcCVRouwWu1N+X+vy57Dy6uV8IpfRkrxUrQGCdArWuxEQdHgkfK5LsBVFVCQg8CYGE3lphUZPbqZ2tXqgeQ==@vger.kernel.org, AJvYcCWNlS+7TYDW8qRgMEjp5emY75Gy8tnZRYNUtS1Ievw2H/1UQ4N36ozcAxPZ7e6rzth8YdRy1oOJpkpc@vger.kernel.org, AJvYcCXFQzAYYlFvhnhzWXsNhyMFzwPjsaF9iH1uPPXJXMZTgb145w6IKNwNhLZbLzuuO46/PyRTwYwDknFR7Q==@vger.kernel.org, AJvYcCXdRFoGh3pizopx7HFkQa4ApKRSt8zWmIj0yhuFyEhd3Nzfq7x/HW4TW/B/jedCYKjRBtA=@vger.kernel.org, AJvYcCXdXMBkG3T3c73qINCJlTr8nmLyMuTlpAxY3xHEf73UteHPW7pg+DjK+WZ1TqJv1/L7Ejd9a4OPg4LK@vger.kernel.org, AJvYcCXmN4Jz2z2nuB3nL066nkBxiZqUqRaiEOx3n0gcKmqBn+6cV5AvrETT1N9GmJZza/E0RBluckmPw124hr0/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29Wa6p4jAt8MSvh4dqkSXjcryVWnXpcJ01KL+Vy4O2zFaQg3p
	YZxtY1sF3zW/CFCOFxu/VaDq2t6WShwB4xMwDOwLdp1wRSvfatHRmxjh75DPgGQ=
X-Google-Smtp-Source: AGHT+IHPKnavfiiQCNCjr1NezmwMnBacyheV8zyl63QTPg6m3L868R+a4UJrSv5jLV5RsxhfHcRfpA==
X-Received: by 2002:a17:90b:2687:b0:2ea:3f34:f1a0 with SMTP id 98e67ed59e1d1-2ea3f34f38amr9406817a91.30.1731940410205;
        Mon, 18 Nov 2024 06:33:30 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:29 -0800 (PST)
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
Subject: [PATCH net-next v4 2/5] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 18 Nov 2024 22:32:41 +0800
Message-ID: <20241118143244.1773-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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
index dd142f444659..bc9d0ecd3a1e 100644
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


