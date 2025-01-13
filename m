Return-Path: <linux-kselftest+bounces-24375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58597A0BA07
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55387A2C04
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C922CA10;
	Mon, 13 Jan 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCymOuVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE922DFBB;
	Mon, 13 Jan 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779138; cv=none; b=ADzK7oEC8EknPnFYpxqKP5YTAiQrfzA1BPRr6Ue/D968sOZ4Vc/Lb73dcuMTbNSOPYyDBkvgZMWJ2eoBl/OY+lMm+g2o87RsWCja+xrQyyBTDgkUJy+H5UrstjVTk9Gz+yJwaKDOYo0RR/fXomuILTp1FZgPGekzNNOcP5e58bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779138; c=relaxed/simple;
	bh=HRgkD5FKjFgLgWVxBNT3gyl1M0RycbLvrFOZUB35tkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td++9PxjjmlCjNRnktdJ9PfYP/ec198sa5tkhTbe8w9BPY5oLGstcX4JhPK+qYlI8EijRt5M9140EzXgObwhg/h1H98fHdVHe5UwIn88vnhK6JLep0huV5iDyxsajXDePUi9wcp0Wz5g2wkN+Z0F3piQCYPYOb0HkuKVDEUCJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCymOuVN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so72494875ad.1;
        Mon, 13 Jan 2025 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779136; x=1737383936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=TCymOuVNtub+RoSE/q4/jI7nJDy2ZTafd4gGusYP1GD4bB0XE8b5fqgX4mjn3nUp+P
         vtvKnWDy/FTUsILLdgeCGUcRTGnbuJ79Qw3e2HEXwMi5cXXcPU6v7UPLZ6OuxyU+BnC0
         5CEailZ12Ufq3Y4PjnQQ4ccHc5Lh7JzpwX/98C3tYSiDR/NdzGdKlhcmEgPWhChFBPj9
         YrfAWUl9nWlspKF08eJaTz1QLwUFnfTDdNmm4L0D/VlkgZJfns7P8x6hhNMnPJolM+/e
         +ARHlADeagomj5phE8nsBLzr/a/Xg0HJ2+ZR41EWOqAiow9Ja4gCdHe9cNGclldV3pwJ
         aLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779136; x=1737383936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RwrUezkHV4Bxso8Lan3H8PNeHkallTCdG4JVNGo1S0=;
        b=WnviK/ZcJIFKatA1O4q/t0C0s52kmuVHnHCsY8u+AODeXEGIW2tu8FLBiESJ80BumF
         gW/TNUFgW4HlbuJoyhmq0c4unehs7dBucZiZ6mIHL3iitt9rGkScHwY9yYv4LDIRn7t6
         6E5bU0cabahRTR/vKHhLWKhit0tKQ5QXqJGegbaCqeUlAWpJ0IhEWAnKu9iNGw1x6yLo
         fJUtJTFX9EA9GIkmT2vIVyFjdf1SlQ2cxUL1T3SgiNWusevcxCpKFwZGlg9IdWdHVjuy
         v5TWeJha7lTlGBGmY5x2f8HD6fUL5/sNBuE7VxFUNjnM0jbQwNXqYMx1wVQZVnfSTNoq
         nakg==
X-Forwarded-Encrypted: i=1; AJvYcCU3kPIFp32L68EAjgtaZ82+hHKbwN8Bc/g0T39e5/loGLgNSa4imobz41uqdH5O2JiTHYaF6F7tJ+Ke@vger.kernel.org, AJvYcCU97xC8iLU9PbPoqk5nZXyXjtjr5Ruv2VkRBfj5LhjhJWhdORCrAuPl5rKZJ+Qt2trpSUjcS57iSSlJ@vger.kernel.org, AJvYcCUXgPW1rjteQ7WOIGWs9R1PVlCXYUXF4p7/3tuihuUHKr5zd84Sj0l0C70c54Inzjp5KW+4NAXBo6PXopZ/PTA=@vger.kernel.org, AJvYcCWXfSjICMyvOKRjSGgmK6sup0SRjrxwAN/l2EJ58rRokct2GPZRg/3zdYz58GUU9Un9pCE3+CvU09DHIw==@vger.kernel.org, AJvYcCWac8ybgMS3OkRLE56avFYqOuW3/O4+VtD2DcScckmVo5pbfk6gjQrO69h9TqFt5EGm/Qo=@vger.kernel.org, AJvYcCWxBKoabvtBkqs/KHwhYwzTrALQlw0x7+m4Zvi5ONOlg1UZEI6YB/rbcIc7ibp3q3xmbO7BnJkP6h8dTA==@vger.kernel.org, AJvYcCX1l2+pgVaXvtEaCcoPKstIQPpMSkbwGAtPSnayailoNW5rNd3+7f84M92jZyVZCCYvqCcCDbEOkhSuzBcE@vger.kernel.org, AJvYcCXj9zMBVBs6IZOrfdyNuavH5zO4qOTtK/cq+3jQYUIpIZ6e0OH+R9EHQ7+wD+MTzMN1q994oZD9zKDOHLYpgdC2@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLtCiD4ayWXm+QiQs1uZYiG/4hC4crhh46QdpoyQDgiVWgg/L
	zCIS41OOAQUhSytwE6U+5aic0BSeHMcJwqKobeyP3D1s8eaP9DNoQFnrSIyst3Q=
X-Gm-Gg: ASbGncsmZuvyHUSquy6otKQY8/7Od6oxNvHHnfeA/c4h9KGtqrLeN5ijlV3oZQEf5yu
	t22GLf7IvwM84dH8KQVKWA5DZy1SaVjUmdQCn7PJrsHiz6DTE+MsycRJwDD15zm19rAz3ssVPNb
	lcXaGpQKvtNMTkngDyXKHE8KrR8B6EYKNAUoibvzcx0osquVlMDDxO5Vsd8rYQp1YKduUYcYlFh
	qVOcxHhvAYZ0lIk7hnGQm50TQHcfMi6IKjZaXHCnYCUarU=
X-Google-Smtp-Source: AGHT+IHt1nCTDh10fBQS9NHgK/oOky2VtiRHLWbePcQNxSAsFYQfmLDkyg61R0c+C95BGg+IP2F6xw==
X-Received: by 2002:a17:903:18a:b0:216:4a06:e87a with SMTP id d9443c01a7336-21a83fc7640mr358427785ad.40.1736779135888;
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:55 -0800 (PST)
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
Subject: [PATCH net-next v8 09/11] rtnetlink: Create link directly in target net namespace
Date: Mon, 13 Jan 2025 22:37:17 +0800
Message-ID: <20250113143719.7948-10-shaw.leon@gmail.com>
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

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cce5bcd1f257..65f09ab616b5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3784,8 +3784,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3805,11 +3805,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1


