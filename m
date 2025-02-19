Return-Path: <linux-kselftest+bounces-26967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED76A3BF0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622A8179DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471731F5828;
	Wed, 19 Feb 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkW2EAVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530C1EA7E0;
	Wed, 19 Feb 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969540; cv=none; b=I3+s25tRQNnZpz/uJ8RlnX05TkuxZcdvegyMaBQoOGn1Yyq/OGmuuNVGKm0hfh3hC6NxA8uo2K9A1+8osBn6m3AGe9IaEeAED85mpZh/GYBvkwcqKXgxKUOUbk3j4AnVeP9yCARDcUon0lnQ7Wj1JooT9daRfFzASL2Q+lKedL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969540; c=relaxed/simple;
	bh=aKbzZxou1uG+4UzTz9mjeL2/4viaECGZ39kotodArQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4evghoBhyuibrMjvYsWkA+349BjGCL/Ivr6gFC4A1p32Q6I0mVdq6PiXRmbRU11WbSLB4+pfdZyy9kI/E2GCe82qWZFtwdHEY8yi04L9MUUo/Bg8Edxu3ynQ2o8sUmoAVMDnE3DXGWiwvDR9D0A4//05Jg/bWOmHNsa6FXJHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkW2EAVG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c4159f87so88471855ad.0;
        Wed, 19 Feb 2025 04:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969535; x=1740574335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=mkW2EAVG2SDFpUc2/3W1ZP13c2TWgVCY0ZlFIZDrllX3jjQIACXrPRQVR0aOaFTM+B
         hMN9nRun84zs6s5VeESbB7f0AVe3ZTJJ93kacpY27r3G98QGZiWU1kYnnQxlxKc2CoB+
         Mkv7MRsVqme/RBQFkLc26BwZZ3UG4BwM+4W4rXjOVEQyllrFR7yWxryli5NCJEby7FNy
         9v9O77fAyXC37CXtsGGJn4/8D2DDRYcgQePsZCsY6r2sJnPYpuRqviK/8xrjNt7AqIQA
         n69qNiPYVfofOLAf4SMl9NCktgfSAZM/BXfMiHpi4W9sof3wMMBCRY8vM/Bx9eqJ6+N+
         BNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969535; x=1740574335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=Ws3qFVlkVLpXNnPrGCfA9UbvSW6bdD81ChIvZrRE9bm9Qy6DEFg3CnlZxHRhLc2kXS
         fe5LCctlNGDwxUlVL9SBaK0YAqjJpt7tiRq6GWCsAjn6agySvhvEpe1ur9UllSja+ySj
         valMOcpnlAAPi7vOFMX8oVHxO0RgcVB2Jd4xhD1oscGLhvcvXLY7QI4mlnUbgpUe8y0T
         hXOSU+PWN7xx+mTR1lTv+EBBFLqDWthKpxYjIkv1/8+5UZ2D3umk1YW4s2zuE7DoonXv
         ONwtrMRhC1jw1YfWp5SicdWWxh0Dw4I/JMcDF5FRpEuG4FxriV5SQwAQDt1yO6qKhMjv
         covA==
X-Forwarded-Encrypted: i=1; AJvYcCUEWVqsA7eMIqEk813crIGzdVEDlSAiNtlTk/HSjwLWozo7LWbN+haIE/2myzS5Jg0JjZZgao0c3Ry2L/jJB1nT@vger.kernel.org, AJvYcCV5RwGCsBFDGzXKZeYESqvbkMLFPah78mW95XUI4BX305x4Ay32V9+vSaSfekI25Rxia2xSoJrHbtUxO5CB@vger.kernel.org, AJvYcCVeCQBYdQPCr6uBLQDApVwCarradWFtdCpkL8EC1N1D3+XR3a95Hbp5B5Gk/hS2h8QJQiT+hytxaPhn@vger.kernel.org, AJvYcCVlc5bbw78DLMnukeAdu64hZ7n+uVYc1r7KeUA9Cw4OQcimwZzQafOrGlusfb0fIDlc1ftlLVuU0Qwbyw==@vger.kernel.org, AJvYcCVv11Ty1dp3aBHteCL80t4f8bzPvW0w+7ciuXxxnNM+88UQjJnkspmqzxvSPAyA6tmxjrXI4bE72Pa9aA==@vger.kernel.org, AJvYcCX7AnxbU8FKvmfwx2IkqBkagunOAJvjq8koDDWBhc8oFabn2iB89ALHf6W7SYLYWdh50EOdd6GXtx2swH2dBjs=@vger.kernel.org, AJvYcCXq3LAhEWDkZ6R3vOllJ2mONkv8tkzlynvXUQeELYy/KTSH0bLrR4FfYyRPWy7QpU63hAY=@vger.kernel.org, AJvYcCXszeWLnxq1cEp+CxFoHKG7PzSHLu7zKymfNnv4sj70wX3nTY7F1TnGlL3C1S8YPjx+qR2H9vl7/ffl@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPyJbJLZGPCsxVhvf8eGimNG6rhgPzVeOgLkdkUGXaYesCf2F
	bnopN3datwS5NaW+F98AKGWnuNuV4zWeZLW2UoW0d1NFHJKvpRDgwvBaoqv40SE=
X-Gm-Gg: ASbGncsz7OAkw3aINqEZvx0afovCiECVhu3+OFipUExXqapPECUlUwKSKLprblpR94q
	g+M8k+k8ZoMeRq8oJU66EsKu8GcEQZHTuK2z04FX/es7dGMLBmRDTDvoPd91bdRIc1DKd/5t2jR
	uP0dkp6IW5TuFPLfSS8QScEjhI/1Jhc14Tpg2mATHibi8jKpaJCLl+cDkTBV0BUIRo/KN56enJz
	n/p00fDirCRBl4knCM37McdJp1YtUtWoVMUyhKEmb6PQ3vsIQZIp5Cfq/6V3Om/E3QAU7RlWkdD
	FKMrVw==
X-Google-Smtp-Source: AGHT+IGEFP67zSY2isKHwZ8c/HiTSEQrpqN9J90h0hy0pUrJ6TwQBaUnsvMftR+A8p8DsBy8+Vg8gQ==
X-Received: by 2002:a17:902:d502:b0:21f:dc3:890e with SMTP id d9443c01a7336-221040255fcmr244598235ad.18.1739969534802;
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
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
Subject: [PATCH net-next v10 09/13] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:35 +0800
Message-ID: <20250219125039.18024-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index 5659a6cadd51..622445f041d3 100644
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
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
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
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct net_device *dev,
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.48.1


