Return-Path: <linux-kselftest+bounces-26969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2BA3BF23
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859691885C6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199701EB1BB;
	Wed, 19 Feb 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFOUGuoF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606B1EA7FB;
	Wed, 19 Feb 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969557; cv=none; b=c4roXaXt4f9TxIUTrcbBQ7FOW3+NGWKPTpqcujAm45dbqTc32r7sh/zKbUyCc6rQsOfg21xANB0PefEWySiXnFG+WhX7nxgK6vp3kDHTMOMAjm2nxRKXV5ZI3VX1i0ifaEMMQameI0yfv466SdP98HCNQK+n3pni7yuja++WWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969557; c=relaxed/simple;
	bh=Ued/MDbt2p6tJKKcyAlb084zWv9B8seAzSAzEKvzX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7bNhiGzxuMTepNOfd2rGCBos+uTjTwtOjOvZb5noWgd1BgzLX7IFDcTbCZ6Sc01u01oZLGjC6vslXzAt/JSaQ3XbwVkqJDis7wrGB6ezsGD3srapqacwyiqiRKPuDUUYYVM0M7VCWYOHacUfb80JoPtlnDmo0AoASoAcpd204o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFOUGuoF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c2a87378so94581645ad.1;
        Wed, 19 Feb 2025 04:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969553; x=1740574353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=NFOUGuoF1R0BnFRPOqCzz7ykPhyP6RzETufGkgm65RmPZXD8bqf6UezhEKxtcHBrxd
         bWDsFMqkVqmM04/19saJNEBubCbUV9928Kb7nOix9MGAqOijTOfLRdDtBnIb4E0Z421Y
         5XcR9D+xvtNwV71GcMk3KY9wah1Az8OaPbwVlgJK5UXsZfxia1mFx6hofSaNdbnujZt0
         q9VwAMjG3QTdsA8/vpdCQIDPXgv4KXVZh7iFThkM7fz2eC8Ij/QR3vY/BJZLFRRPYe6E
         G4MsvSEe0UWjPaBrrRKELn5n71l7ZVwmVOUznhcrSs8Xh336OBq6dgvjAGLmKPIVHGSI
         BEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969553; x=1740574353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=N7XOtn8uUdBBfCVyuhzskCnvzkTIjRGMrPEswmIoYJAjVl/39/Wv/VFw0Qd9jkc0xN
         hw7ghbKUlEMvE+g91xRZCaZC05vcD5VSzrXYTHde5qZUI0H8DAI8q5WW0hBw9pN7oTNJ
         n3n1CffLDaMc/Q77e5ka9dJEHjU0I+mEjzw8kk313Gdqply+2D07f7anPNpKEAZOwa2L
         A3erLNyuIsVGPVFVPlgiLoQMc97qPwIP6kFoEHTsAa+DjRl+/+oB0LMMDqbpkv2SuEZl
         2q30bKXEtUW5iwnwrj7TMSu+fG5MPNAckuV/QBMKCyO9+HU7rYuL8/m5KV9kjpwpe5bo
         /Yeg==
X-Forwarded-Encrypted: i=1; AJvYcCUqx3LtOZmNb3mvgKgIDCDfW9zJ9J/kmGdgdFQqDHcYxG7cufc1+OKlPKDyAtVKedFJVxI8Z8nyMFU077M+0ma/@vger.kernel.org, AJvYcCUvIEKqaFpJ1lPT/Mxe6+8Xa1EMH0nUSUe8VtkO/pGH6/rVEQGi1TOg3P3PUp2+K1eMP75uRumSQI3c5g==@vger.kernel.org, AJvYcCVSXv9qs114vVDDXAHzQp7+tlYV3XvlFOX0yCedzH2J9CBHQ1/pvHlnpcpl3pGepL4MahX7Nu/V2BNhps0w@vger.kernel.org, AJvYcCVm00JFfSrfMrVYU23JyXsDpfZaZ/jhrQKQFRJxIYTWLk8YbXgrnqfeflv+hhD8/xmjxPs=@vger.kernel.org, AJvYcCWgdgVSQ4FgS9LyElKWqCH6XjOkfRNN5lelu1AuHe+cqMynvBHXljmbhY7C777RCqdlS/iWLI5bR6Cg@vger.kernel.org, AJvYcCWthQUgT0+yhupzMitjKVy56o7/d3F2Ohh7z85jgjv6Iv+xhpGzTF6InH9PdyQF/9fMsYd0AkfXJMo4hw==@vger.kernel.org, AJvYcCXSXivTmuf+yELwUuRsz8vmVLTyWeVwYf1Ocs5WsjS2Z2CGrryxiifN1MZNUJ51Qw+GyO8mtg1bX6pQ@vger.kernel.org, AJvYcCXWB6bpBqCU5TfD0Jk17BJ/w07ht4Jw6Yz5tkU8DPTL0/0Wql17e+jvvR6cnhY9iKK4azbYa/hVF7JmjPNKlwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH71oFzQDYwqHCliQEaHp/4Z8cULGIJNN+1Be7ZzJilw2spd3f
	JiRdcdkMAuyYcqWDN6kqGsUZKuQl9UIrc40Ds4+H5rnxeA+Qwc30vJm13r9Z
X-Gm-Gg: ASbGncuHPH1zV2DMjmiXTaQ8d+0M/rQmFXSl3Zi3dPMktnleeeO9gw0JF8C1gU9HYyg
	/2szSW/Jr9mmAd6xn1BHWDNQJCeFue48PC83GB/33OllPf+gCmzgEQo6WoRo8BY6u7wxSHhDo0M
	akD4jo7cBr8m2zltFT+C5qjhvwQKXjfASUngsBzbzWEKgn2FBTLFTo/N5Oq65oNTgPhPtxSdM3x
	2bshSU5YoUXXDCbx8HPPhr82VxVmVrHAKY0joN73X+LkGPyR+jG0U2lcyE6F/Iujir7LepbKPfB
	n3QHiw==
X-Google-Smtp-Source: AGHT+IE1TMZXqzhrHhhVSaIMtrPumBVmrpPdtKnId51KbxVQ9NXXxJP9rSJ1kBfk/uhAUxck4sNSxA==
X-Received: by 2002:a17:903:1a2d:b0:220:c813:dfd1 with SMTP id d9443c01a7336-221040bd77bmr298031085ad.36.1739969552787;
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
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
Subject: [PATCH net-next v10 11/13] rtnetlink: Create link directly in target net namespace
Date: Wed, 19 Feb 2025 20:50:37 +0800
Message-ID: <20250219125039.18024-12-shaw.leon@gmail.com>
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
index e980481bdd28..b52e610e157e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3789,8 +3789,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3810,11 +3810,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
2.48.1


