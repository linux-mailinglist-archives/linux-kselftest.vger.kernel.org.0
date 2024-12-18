Return-Path: <linux-kselftest+bounces-23507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800239F6702
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAA816206D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B51FC11E;
	Wed, 18 Dec 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwjuFNV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B31B4255;
	Wed, 18 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527441; cv=none; b=IcaLMGSH8A0Nb4bX8X9drsnm6DyjizRUxcCps6+3mwX36gmonByzDERkI4Ert/3L9S9pTQ9ZSnCPCQKr1++RUteUs/pCH9uuYHbw4UlLtpqluoniNNbINlOcE/Mv24u69s4TGmJZL7NQzRkatoppCNmkTrqgz50qy58dODohtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527441; c=relaxed/simple;
	bh=v/XyDBj1rv0kMGLFRo/fVc4C1+xJWpbKQllsecdMufM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2HTH3m4HVqkQOI8Opo0t5Gp/oD1FXyq4qMRox5ZJhB0QEtcCfITr+AMl4vqlpZuhEs6U/ZmWqGpeQ39n2uN5GWJN54cEj6vKDV5NyuWBdtZopF6/aUrco3MDomJb1M3eKqkdlnIC7SyHee1jR7mlhRUhhczsiOVNC8wRgTYgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwjuFNV1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso4477312a91.3;
        Wed, 18 Dec 2024 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527438; x=1735132238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=fwjuFNV1Nk0lLZdtKVIBtPvEmD0FpM2Zg6hA83lyD/ntezolOf7RjQezpYZLedaCAO
         CBQQ3nR5c3ANBuuqwCpfFChZcr5z/HKH1/1GM60VwS272bWKTo376LdLiOdBeiW5PxNB
         nsbTQZZqywvQoBFIi0D7K+L2GxL+TKNTo5npJW8AO6pCoPa1h5DWYhynbniWX57rBtFG
         69ffIDwWbugDdWHsL3I9bD1R43J8582tYTwXOS0CA6o1rUcMRKz5yS+eUMHNmC4OrJlF
         MzYZjhppO/4+U1VPQi06z7hix7p2pRS6ybZ1AzZjq7kOc58EPOdBqZl4TTZgt24VEnKE
         aL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527438; x=1735132238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=wT4DVu70ZFX9BWkAWmUSwYH/pIX21nzGjrlmUxNkhe8HPAv+Yt2Dgh4sXmLw/HJwV3
         8MdsycTZnUQzxSJH7/Z0OysiZrO3l2tf/42sB8XtZuSb1/VLHtPSOSN06Ci/HyLZIAcJ
         /lDZpAvNiVB7Qwcfq4eIMJnfsuAu1vVIBqSQbZlUu8JXmCCY23/NLMKdfBJ2ofo62rC4
         ZjQDopf6m38WguCoBOq8Xkfmyr9u/MD5/ysTT0I53E+5cXJZnnpI9K0gmp9WdEQqg02h
         bzf1x2cWIt5KJZPGYreBcW460zAHx8XJL9wUJp77Tu29yc/gN3dQ0Tek9zD5KGFwBhsH
         1MwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAl9e4MDZcJ+h7IPtI68GUULbmM5E7Gf5PYQm2b2IE76G1ugzNdCvO//yOmhW/qVUw+Vsth4YjWJZIFg==@vger.kernel.org, AJvYcCURioy7SHTJlJcJYlWl4sb3O4/BQuSLNKUpmDwK2iOlIba3ajX2AnbXRrcLyI8annyHjB8rfUoCa933@vger.kernel.org, AJvYcCUfW7Nah+vHQ2HEz/imgAduouCzmITMjOztocQ+ynd1h0mR7j6yhbfPB0OCA22PbvSOzw4GTHbIJmb1DQ==@vger.kernel.org, AJvYcCV1p8UXnZaHodIQlB3+cUQKEk2FVLeT3ufLLY8cmfvJocyHWiJVaH/Jrsn49mbyONTeVg27ybkcKy48@vger.kernel.org, AJvYcCVEBXCwuTJT8A6QJJUcokZbLCqMXhdQdHuTyMwLZaO6dwyokbeTYdk8UhtGZYX81B5zEI8=@vger.kernel.org, AJvYcCXCHS+nUsnU0qw3jocrkhENblK/EncJwFxn1lFOD72pJa+ZMCpJ1D3lII8Zai0/EEio5bfU9JiZtFqkX90Z@vger.kernel.org, AJvYcCXP34SdKGF20dIzWaKpZAMrwpQgavmVDFeHJ4gT6APXBsos7QJnt0xg3OOv4ezH9ssvk93I1c4VcLZJ4sLxxbA=@vger.kernel.org, AJvYcCXwvOaYnZQ7yN+KO59dLjSRSUEeBVkatgNrbGXFoRFNdzp9QztvJEQ7gShbZ7c58S5RjKoZYzYBXV8EKgdfOAZy@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbtWnlGkXShR/u6X1uNwa92+yCtSq3OifTnxk+4XhnD0LtQf/
	wOxlrUauhk1zS426rDxMH0FZ3/hhih/MUPr9WnE/rfasKEMdUKdYB/e4JbiZf6c=
X-Gm-Gg: ASbGnctWmgNu+D+GOJd9/Zd5bcO53/q9mIwsh7qoWSOoyygoYgtCTncxlNyZwQAfERv
	K3wTvy8nDCofBfVyZ+XTzevwZVqjvGyTXZaxcPKd+C2X1toIuu7Ux74DAuGEiH16R7JEnB6b/AE
	IA9Q9uf9Zi+QNN6+2VOb13DH0bgJQqJfa+8Srse9P2x2sHUUyKBzUmFNhxq+zfBYwQn/HsfpgHm
	lkvCUpWp+eI3DZm3FZ5XP1xR44bmka5SRd0yRSK7HVfGb4=
X-Google-Smtp-Source: AGHT+IH6m2w3HOgAGhkzn76085OHsWsSUyL1uFaSoqu4LH4xby0CPd4muKbobH9sGAmWFqgh4Hldug==
X-Received: by 2002:a17:90b:53cc:b0:2ee:fd53:2b17 with SMTP id 98e67ed59e1d1-2f2e934616amr4153078a91.29.1734527438446;
        Wed, 18 Dec 2024 05:10:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:37 -0800 (PST)
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
Subject: [PATCH net-next v6 09/11] rtnetlink: Create link directly in target net namespace
Date: Wed, 18 Dec 2024 21:09:07 +0800
Message-ID: <20241218130909.2173-10-shaw.leon@gmail.com>
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
index e33ef8a0a6d6..ce5bea096bac 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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


