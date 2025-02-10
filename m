Return-Path: <linux-kselftest+bounces-26164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2903A2EDF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6961518867E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4F230D0B;
	Mon, 10 Feb 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlcJ+47w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB1222579;
	Mon, 10 Feb 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194257; cv=none; b=dTeQ2q2a5s0rZ05FyALj01DspcT7+gckbfaO+RJ0a4iuo7dBk+J8+4UUoAWzfHttDBmP0yydYI41vnWsmqANQD1s1fl8B3HSNfNua1qQ30Qg6I/APWdYPapaQylv3XY1x4ev7dFGzhG6I9op86Hmza8UtH3YhiAsGaHh4noDH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194257; c=relaxed/simple;
	bh=2u3aiZwG7nXyk2L47N18SQQLK/lDv6g+qT0nQKd4pSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVjvNTgscK9y5myhrlgw6WGu5fAu8a6lATRGFTIKH3pz5x/hpeT5XEf13KP2Ez22+2v6cyBP1j4qEcUzqExOGxV+l+ci1mmyYEYQKL5q05uaDdtBkjXfVX8oQagl61L5Ah6B1gtAprUNk6xGj3AilP9URoccBiZD7cpTzsyJ5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlcJ+47w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f2339dcfdso68365765ad.1;
        Mon, 10 Feb 2025 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194254; x=1739799054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=SlcJ+47wGGDUbl8sV5PwIW7AoAxfUG7nCeJM5ww7b+nw0BiGPXIl8QA6yS5m3t/QJ8
         x7QFuIGD2iVmE1pY7/2y9PT0sO03WioE+Rn1tgNCwBzbcvp3OVBaWTPvPwEJ0p5gvdPq
         q2CCrtUoARx/4aYWuiCPkFgIXtgGXDqPz9fiKFxrQ4UFEoQS0e2g/v0RoCmCDfPAnvXu
         1+7laLyJ5HbpSZxKZTRijbfnAYCzQ2Kdo4eco51Rv7zQDUcLeYxsid2ED4X4nzcMmC+/
         EyqNK3sFOOT4oS9VwDZlKmll5J6ZlzdAulvS/vAr8804aWjkFd2YbdndBmyKeGRAvEsY
         5XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194254; x=1739799054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=tSKD1z1QhoLZlnEm1256y8ZQSsBE4IxrtyFYd7YB195lKRYkpmtnQlO4qjWJSYErhl
         HGZkeROP6jYSIIkZXcONUFfQV18OtsSHze42KJDk2/nh7UxFJBKQO6pYX63w/OhIlcle
         Y+5LINgTbyBk+SO+L8ta3rk60pAS2p+PfuETwr97jBE5gR9foeBlo3aVgH7I4GN/8q3c
         YfiunFME73w+RQrgxpk9PhtOJyegDTQVODbGHAW3VnJbePzt4OQFqJEwdgnCHwJcOG2g
         AfoupIva9e3xY86iSlyc+6eHsDxFv8H7XQjzUIN5qo3uAckTuTXOxHMj44qnFMTeba/+
         C+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0l8At6FJ/SYLME2PzXx4uRE6mFl8dBanUGBiqqq8Th0huJqssV7lTN2hZg5bQBCFuurWkwBUo6kN4/GOHp98@vger.kernel.org, AJvYcCUU4Tq9SrFX+qOF1eRqOt00onrXZu7fPDDIEZCgzQEu5JwC+BZiXf1sNqXpTOuCLh0SjQGbFUD5Kdd8Tg==@vger.kernel.org, AJvYcCUw9B/WT94e/UE+JT45D5MSfLjZ99ZNmphmlSClc+QX+fLqLxb8IZEvxYMqbCKn0aKYE2Fs4mhEf0Kr@vger.kernel.org, AJvYcCV16on7V3lLlXPY3K/c+ui6kODu984DDNS4gJ71eNzIe6DGFv54o/nP1srnuC5MQkDb3qjU5wTyIWA+xQ==@vger.kernel.org, AJvYcCWhTQybiO587wGgTUhWun4rJFb78pXupN/PGofz7uesaeEGuYTAMB82jx3OUmX06KkgrAOkQt7ZaKHt@vger.kernel.org, AJvYcCWxVXImtm2cTF8o49+hZG3dmZaoyEI07XHaAtwB67E8X+zgA1PJEdO8WOOPJ9FobS/1Wpo=@vger.kernel.org, AJvYcCX2/Q/wRJi1qtNjs0TVJJtRrEY2xbU538zws2rvOoDo9AsieKOAFxLlRLmtdYpn5qJ3d5CvEYkqtHKN+ohc@vger.kernel.org, AJvYcCXSS1VY8u/saK2+CYLbadSMVWG96/xSZS1OXLqiTUxP6WytnNDaeh94Kq/LZ5aD28sAgGJFBCvagibN3FamzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UoaZX78phZhN/gNgzJ/lTcYubxrZ4Ga6F3pU0HBvD7ezlWmB
	JB4lyAuCRRD3sjIBEOpJYtyGYZ7KlysFjzQ9ThvU6PNT7elw2ymGiA6v3GrdhCg=
X-Gm-Gg: ASbGnct26Cxl6MhRehdV9Cixw4wUpwYfB5zm0PfHyGQm7gb6/hRuaNiOEi+2dpXd+jm
	lyWYRYR9VpySJ1eXDy0svlbWp79S5XbvCkWQoIakUFltBnjb9K9sd8ySZrp4A+VrHHSL1x2UTCO
	P3lxO7b01c+wVMCKgoQgAEdYMmbdEuaPerrtogVSyYkdzcwUitB8Mpo+sARtUEDz+TJy+v+m8da
	5Y4uOzVeOdwoYV+R2c5IFTNGw9tAx7NvL9JlR5HJOSo2pq243Q7lmwmQk9e0tRjuhLuzmqKkhDz
	GLjrPQ==
X-Google-Smtp-Source: AGHT+IF8gihjdkRbSU1HRP8R4mEppMkEAKGDChElxIvCxKcXV79FUInFhj/RnX7alUKIg2RAq5xNnw==
X-Received: by 2002:a17:903:46cc:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-21f6d636ff1mr134607475ad.2.1739194253851;
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
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
Subject: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:55 +0800
Message-ID: <20250210133002.883422-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.48.1


