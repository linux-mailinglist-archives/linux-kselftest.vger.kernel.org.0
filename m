Return-Path: <linux-kselftest+bounces-24373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C608A0B9E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15978188423A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA522297FD;
	Mon, 13 Jan 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaSxtuw4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018542297E4;
	Mon, 13 Jan 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779121; cv=none; b=hcWNhBJ50+b793ORx1yvkQ8P3lUHohk6XKkt31kq+fXFkwXFA5pGOd5rpUt0//P3SkYS2uCnzH9GcWpURp4w+xfvPYaCP3SAWS9Edf09pdHh+IGPA3lwqW+DgwvirVWoPYZy3T6ImW76mlBjpDMvB7qcFJ/VbfztRARCZn3BLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779121; c=relaxed/simple;
	bh=pUkeHC9Duzkf0b0cEfL+7VFfzV63XchEu8lpcFtp5IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWHRq0QpzV7O04Ual9WFIS/PoNAveX6eEVNKpZc+ri4inhzE/NykvC5rSvWl64bM3ffwihFnncgxphM4j/Xahla/+32oRBP/z4RXkCuUlsOGZ2UsL3kS9OMRGjFO82ohpluSqzClRXzF84DtZKuwtHMkySKrjRI/ex06wNOLeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaSxtuw4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso78936185ad.0;
        Mon, 13 Jan 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779119; x=1737383919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=VaSxtuw4+z5YRbznyJGw57orxt8BaN3nxucZFYOcb+Y3/QVE0tI8u/ZJQGfq8p+Sr2
         PS0okpJa55NqGwhL0nlZRUFM3OGX3R/u706zsyz2pyMEE9gI+6TB6bRFmybILuwmbLfv
         O4O5jtdANwtUPEyu1Mc/X4x0h8eOCK8uALgITZ6VPz38p//1XmOziXZktyCNiQhLsX7n
         a2jEopYN71A/0VotmmAaqjJ20NMlKIGAYhbJhIKMiNdiJgsGTcN/yX/8f4MaclrpudCz
         IFMkBNCtzCUc0B6Cct+mIrfMZ+/JXzCmr0kDNHKYi1GSP5gGOA/CMB2STSXumj4W4Fl5
         QPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779119; x=1737383919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=GAtxwVagYJhdu5NQJptnnl8JWYwtUB3JuayEKl/5K3QHZLMz8g2UngkIaQUAjwjwBV
         XK22HPE0k9RHaXBaIFqs5xt3JTRde7l1Cl9xJ3LhkLfD0AFIXxmZ3E87iZlJknRWQu2F
         lJaMMMeApkpxDKwE3WHlM/6Xb+ooyoyRzgs2yIHi5xAhe4vbqm0tj1v2Kik+i/0VAuHf
         LOy2UOgE7vAutn/fp55fmy7A7GwJiFgfcDEjwxxYWsDGhaC7sW/oBUPSd0SUC89pcHsI
         B1QFDYCjB4ibalYex5w/nATeKCSKyuzUk8+RfErt18+GitqgiOD1ZNyQtCv6JNPPy9Ym
         ld+w==
X-Forwarded-Encrypted: i=1; AJvYcCUCbUiyI3cH9cq4Cixx6+sqBlbMSIbycN+fdQrTzyM0ooKI3gIclMrn6H07XbZ52yvJO84QLMS1s6So@vger.kernel.org, AJvYcCV4pmqQiRPJCnhqXviQsPnuJZ+GvbgqCUJF7x9r6GRq0t5P2LOP8udeB0+c7vxxg+FKZqMG+Fz9S64K7i/V@vger.kernel.org, AJvYcCVS5jvkhKBCwnAls71IPTfGysYXt/x/rN4MFBjPqqyo/UAyt+0D3dHqLzfwQLJkr/rj/bc=@vger.kernel.org, AJvYcCVVOxQ4BcD4ntjNICscuQTeVlp+IzLCtUosyGfSCo2czcQQRbbh9VFaLjWEseIP0KxD1NMGrOI5hZXoHA==@vger.kernel.org, AJvYcCVjcXD1+RteH69G6E2RW2D9NZGRSpZpzf6Y/Ui9OY5AJH6EP7v0S8olQ06fx6dyBKf/ORTLtHF3SDqQXUYPEFM=@vger.kernel.org, AJvYcCWO/vteSDdRT/Cosz2r63xXrey1auG3PyL0486xWn5fjOfml1p86umoVOcx5UEfp75fAc7f3pPF3Usx2g==@vger.kernel.org, AJvYcCXWCeC6y7B0vNC1et/d7HHuiNam1aJvImFRAbDYb50IXWfqo5H49tDJbfky0VLhPTdu/yoUkrdI2Vq2@vger.kernel.org, AJvYcCXgURTHVA4jcLrra0TqDsmFD/XidEFxjkGh+XE6X2ZlimrE5J3Jrlah/LOdukzkIz/zlxjp+xqR7/zVI7TT3hy4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsaPijT23PtLu0DtlB2NIXrDYLmVGqUWKbrcY1jIdGGg1tUpMV
	lnmedXOkBgOF9bC5ddUMNuxeiTKETmQkgitJpqPdVArUrI+a6kZikN22ZifdmcE=
X-Gm-Gg: ASbGnctRMkCw3yARvgvAdAGN21gClc6EnQo2pkY44L9WyOoJ6NapuAW7seen1ydpgkF
	eKI5cy5qEz1VdddKAceE3eVytxshK8SmUBmOsVaEy+WzPr3rzUwQ800jrsm/bdn83HsDYlmKlWV
	Vr9fua2wVG2Pe54r1vLHcWhZoEAAUaN54wCoE9CAfZocKoDcTumarYaqIdklqrhuAZz32Gb5T8m
	a5VAQ8ahIc13yxuTXYy8X0DSWxKjJqhKev953uaQ24qfLg=
X-Google-Smtp-Source: AGHT+IGazeu03SiYco1yjo+DeQUEtizAzSGgMZznFsd/ItXTJBGhLqoPfMkABloEPy5ZTJeLHULJqw==
X-Received: by 2002:a17:902:cecd:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21a83f3469cmr286693405ad.3.1736779118671;
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
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
Subject: [PATCH net-next v8 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:15 +0800
Message-ID: <20250113143719.7948-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
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
index b7ac558025d5..b87a5c950833 100644
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
2.47.1


