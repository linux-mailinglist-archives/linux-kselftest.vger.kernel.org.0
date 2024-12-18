Return-Path: <linux-kselftest+bounces-23505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2919F66EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8200718834DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23C1FBC9A;
	Wed, 18 Dec 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXFfFAJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF631AA1D1;
	Wed, 18 Dec 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527425; cv=none; b=ss32dZfC9YI6+4j5bg2fytjuoIWa8Q0H1+PXLTRG7V8DF6RgxofKYyFa/9M46tkkmW80sB39ZSwe4gGtf6zMvOG4W/m7RfMRqyfXcWH+2Mzd3X1q8hm/Rv5ibBdByuws0YSwRg4pYWFDAQPxho5kYRj4fLbTK7JAxLbsAkZN59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527425; c=relaxed/simple;
	bh=FrNFlIgaLGZInVfg7c+Ua7z0X9F1i2NtBJYO15VwRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtdJ8nud3xUX4PVDtByk8VD0raqVXrs2EUkxMzOQtKdHCEykc0Ug49dP/YF4uxfPHAw2LCujgO5mfKMmqLwlSmDryuaJUKfhaEejMyrb3zvzNZl56j7jrkNQYFdmN7OFksqaK2qZ2NfY3skUUw4UyHQMgKQaky7tOwv1dilVQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXFfFAJS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728eedfca37so6598128b3a.2;
        Wed, 18 Dec 2024 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527422; x=1735132222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=LXFfFAJStzsAvJ4WY0N0t92Sz+QQpM5xZfw9bvPJsSKC7oPWpjeBxXOHd8+7rsBj7t
         UBEGYAF42K3f/1K+h4RiDHOX5eTsWAcCR4lA41kPLWRDgBZxoF82nG3sbECRkHxqXI+S
         xBCH/GXgQ1OoBEh4U0l2OAyCh2RNVK7kf90cbWMiEGGI8Dte3wj6zofVFkf6T/+791Pd
         1Flds0ACPqJQvszkoHG1rr4a3Yp42AFWDKii3HIVEiI5Fz/N2/sYKRn7Ajt6MdI968HS
         q4bB0LayuJKmYVB1wlMRpTEJzFrO6G+Y93G6hIUsbPUmcAiZLsteZOhQwyJB8kSuv1ZN
         rVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527422; x=1735132222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=DRV0IIkKN8nNEKrYqn0uGibhcMRKfVQIk6RH31aXm14c43NXSDxwbje8hx+ilBa/ut
         d3ivEP8/tEkSPmmBkc4TYoL3z9U3j7/UFCPwnyfnFOasnQDhmuUk4MCsDjIpHARj/eFn
         0XZ93t6U8X4xecOrnjbEex0NbajZ44aBRiZ4xRsnOlQYjryOP0YJOEGDA5PlszUbBpcw
         YUGjJS9K05DVDsrRw7YlsAP1kQc941Rk7vJXDdmY1ngEAjj9lSWNCThBazZSxEsdOwIB
         SXhOR+/NZ2uVH7nNQN+a7dgvBiURfLMzz+0gIc0ZIJMIMvm9g8qQc2/CitOjn3CEOi01
         ir0w==
X-Forwarded-Encrypted: i=1; AJvYcCVEnxedAMrHl0J5Cf7EZsd+PV6PYzdkAaxCJ9nqhyV4Ro9VYGTf5YgoFtN6HY1UO2qDeAeJOZuRdjzsoQ==@vger.kernel.org, AJvYcCVI3JzEDJheQzB3xlrjMWks5M8yc+vNOWfwiGznkjdIvTKpAlWIFvUHiUQcP3GPmsewH5R8Vis+LC4Bfb50/c0=@vger.kernel.org, AJvYcCVZt+qLtz+W7TRo4YHMxnLGudJxR1zA7s1xGw7FbsJo14iSfId/viHJoHv8nst+TIvTqtc=@vger.kernel.org, AJvYcCVdQo8WkP++f+IlQBwrxyPSWkzxH8t4ZAMuCXveuoyy8tSEHImkl9Te3Ekfci+LilLcGLAobJaJbaGR1Q==@vger.kernel.org, AJvYcCXAjWu9ushPnyKubCWA1Gg8h8tkrPaQVOdnZnfOt9bkKGcAq2nX4nb6XjZLzmk8TDXfleTqiSUT3BUQUJqd@vger.kernel.org, AJvYcCXQqLdYs4yvqIsjeQty4dyRmEP1w8bG5OGJIwK4lJcKChevSQutHFo5JptehncHIwq7UXsTz8Vy2aBI@vger.kernel.org, AJvYcCXmjzhblLfQ9u9b2VvcT1IX2DFJNmw1Q5qCsZG+je628iPolFx+EhNIG+C7DSQDMxtcn9OOSqsco8NE@vger.kernel.org, AJvYcCXnbMOwMRII9dkwL7VxLP9lyNmk21xvLFeQw6lhbosyilUUOV8LRrmGaNLKNoLmYPlCwH/m/qKlerMY2rZGJ2nb@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIy5KVc+GwH7kWsjraqVZGIcO9eyWp9jaAy5o4bRdHfA3r+eA
	HXYsY2XKSS5LJdip98N+7kn3OvvKnIoUFJnTcwFQwVtiC74avRitm3a3TGyN1uw=
X-Gm-Gg: ASbGncvZHp5R4jpUPmkWEkXUXkAULvm+t5svNRAzTOiyMz43xaWsLIrJW2+lXcskFKb
	k213jGDk3k6oChdpU0BSQeb1OlHGmoTaVZ0WYYRZkzLw73ip9MqZVWZrBq36awXKh75NerIGd6x
	d297vuKqoThrdL0yQQgzsYLKaYXOslLIqi6Q1r+pwfaW1UQLIQ/AmAzy5KdqtwHEg4ppTujkjwp
	67PzArbtl1PCue39Zg+oowktGZiZkeV6/jIG8n5rNbRwnI=
X-Google-Smtp-Source: AGHT+IGLrMJpewCg9a6Mvczs3iBMMwjIWUW57/cgClFku2ou3JPxqZ6yK8d+Q9sS8i4XncDR+dfRig==
X-Received: by 2002:a05:6a20:12c6:b0:1e1:bee3:50ea with SMTP id adf61e73a8af0-1e5b47f94bcmr5116348637.11.1734527422239;
        Wed, 18 Dec 2024 05:10:22 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:21 -0800 (PST)
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
Subject: [PATCH net-next v6 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:05 +0800
Message-ID: <20241218130909.2173-8-shaw.leon@gmail.com>
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


