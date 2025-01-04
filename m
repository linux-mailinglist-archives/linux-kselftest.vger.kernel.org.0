Return-Path: <linux-kselftest+bounces-23908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA9A014B7
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DD518847A9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6D1C07CD;
	Sat,  4 Jan 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlGCEamz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2EB1586CF;
	Sat,  4 Jan 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995525; cv=none; b=GQTTNA/QXmzeVK/Y7Eo5Wz95MBx3fFHLaFW0TszDun8NxmRLbCt8sT3Hhs2PXYNrOYQk2L18YV+0/fn5QEh4nQxj4QSCCxwQn4PcguCzlV4R5wcnTgsyqzpsJaXc4Sblq8Sx+YIzu9VVYP8gEF3XsSoZ/1wuapqvCYnOgzFn7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995525; c=relaxed/simple;
	bh=FrNFlIgaLGZInVfg7c+Ua7z0X9F1i2NtBJYO15VwRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJeSFT7QC0gV47Q5GgpF25jtjqQ4VXlNGRWMlna1qOl2dEKPptT4xGfU/cpVidZ34rCI/c+nsBtOZZpORA6oNx8XNeelf1qHVydnk4cih4gzmY+1bA6tG2glgaXB4ciZufAnaODwMWR0dkySRJvY7DkJ8VDbFB/Hm/bDW2zR7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlGCEamz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b1f05caso180036685ad.3;
        Sat, 04 Jan 2025 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995523; x=1736600323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=RlGCEamzX5RQW9Y8au9s5HUeURYF+hzc1MY9d6ZgjOV67ihV2oAOOYHluBX5iPQ5u3
         VwQXM9so3y31IYAAMUt7d4XlLUszChyRWkj7r2S6wxGt+nQIBnGOcGeteK0gamAH6jdp
         DuWOvFlrhXb0aIDEx3NnrJhFC3wDfYmp4iYZhxOnMb0tskx6jic5teq/g80hkfCGKO7H
         oC3fmoLmLdNg8fvTlcuREPu0aGRysE4H61tY+tJ+LCgT1c7XVTyU0aOK7ZsV+ARjahIE
         V0NXcUKpRIieHxocJuF0THkau4OUg8qr53wepAUugIL5nk8IlOxQBLyRjFEAiKY19nP6
         eF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995523; x=1736600323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=SE7LO+f8ONjRQgIQFYlklTc7yp87BId+ZTiJYl7erpTws2TvA+ek8YFudDhpR7knYS
         g6BrirHgSksfRFtPj9w0SACXdn2/p7pg/8asBOZ/+GI+cJl4PP9KueCGQ5TgZTwI5CIz
         UWGjADuhCSC7LMSaUpa34ruBlLIU6Kxd6VFZfIVG8ZNf5N+xJFRy6Jwp+3d1VHd73eDn
         jLmOl8h+LtxdQVqmyMpnB57Zc8Ef7HvzQLBNPiOqH2K9KYqpW2vwop34VELEBqTowFMx
         n+YTETsJK3Z44Xqb32vPxzecucVw0u4Nel6GB4peG/ZlR0msWTied06JcdOOnb4H9uev
         GTvg==
X-Forwarded-Encrypted: i=1; AJvYcCUYQn+nH77QWCA298WdXTQqNPO93h7v3tzaBo7nEj6hRu3LGCc9r/dxEl4kKv+tOjRMqUZkf2b4lxG3@vger.kernel.org, AJvYcCVLg0NwEr/rnFqDaKwBsgQoqEx/tXGNiXzeWr1y5AnkNgBcNolrkpKRvgFjBfInaZulm0+dY+lqww9I@vger.kernel.org, AJvYcCVxpCgKwno1D2biuEtoVmwxSy1cEmR+xJUrLBx5xajNVhGyu3woxQ4ekGWL2ABBR3sQXSw=@vger.kernel.org, AJvYcCWEo60vvdr/C16T4F3yw2sBnbrbMyRPPjvGIYqaSxL3/Vz+jq2J0gZT0zkebw1ZRCAQsjR1ONJqkifzhUO7x6eY@vger.kernel.org, AJvYcCX9V0Tj9SqVrLl7Uf5ExWiQM6cj1erkOHGIqajt6U+6poFw1XVMX/C0JT1OragJxFmj/LZJM6PUluIyKw==@vger.kernel.org, AJvYcCXYzubqMfNh7ZBSZM3HYyzua+/kOHF2uhHLogeJ6X0x/TZ8qYbRCJd3/1rXtBMDmxy17ozVULtYPEzDnw==@vger.kernel.org, AJvYcCXc/DDSN4TQ3tW8r+JQPwc6TXquHAA25anilwW7fJzHkWSS6uXWADx9tIE3pvN4kpDk/kdyXeOEcR1mCcz/@vger.kernel.org, AJvYcCXzT3pfmJizkpn4nsvQZ6jLodYyT2Mt7tnpEvGOx+EHMeqEwChicANwwKDI0Ybp6qs5KUac600saISizf9Ai+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVM06o8+nRSqbHwkVzo9kePPT+ZkaoTHv256EBwhjYw/9fj2KL
	KhePZkHO30Vr5D9B+eEjQQi0Voa1s511HLN8MiT6cjFoYvJNUNQldIroAyFQt5c=
X-Gm-Gg: ASbGncugPHjeyckCa/qICLCYyaOpQuwtMXiPaZD27pB+ocweuz+yXSSvlvz0g1h/oec
	YpLENeDHWhsKPCC+uY/X20aqR3EJKWimdYjKadYDstQMulODDBHKjTltid6Ybo/7z2hzn7xg7r9
	LmO8jCzxitMQkT5GnWMUHRWzH+l7xoRNutFh56+7NWcfiNsEV5N10yHc2t8bbPmH8gWZiVVBpK+
	vFCPP8fcj6DkXmn7h2W+l6t1w6et7vEjZS/VOzGw7w+l2M=
X-Google-Smtp-Source: AGHT+IHa35PYbmCu1uOx6CEp/EQWjQpZHigmf2PgIvsgkyK5+Nfa2PQvUpv4CIvsSLNsXb9/anYWIA==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id d2e1a72fcca58-72abdd9603cmr90325957b3a.8.1735995523087;
        Sat, 04 Jan 2025 04:58:43 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:42 -0800 (PST)
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
Subject: [PATCH net-next v7 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:28 +0800
Message-ID: <20250104125732.17335-8-shaw.leon@gmail.com>
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

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 77d50d4af4a1..d1198c63dd23 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	xfrmi_netlink_parms(data, &p);
 	if (p.collect_md) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1


