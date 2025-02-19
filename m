Return-Path: <linux-kselftest+bounces-26968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A55A3BF19
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F223617A1BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8F1F76B6;
	Wed, 19 Feb 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbYCuAO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A741E834B;
	Wed, 19 Feb 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969546; cv=none; b=umdYnRf4JRrqmPWUFAnsm2sozO7oBA7az6rb9lRIAv39zTFPhe2/XSCsYNHpKQs+qeMXuylMEL59FqmRnBm2avbHNISoUdNe1kIY59HAWH76bzgo3lvLqILOCziokJsOSeb+HitA7Ud5yNdUQVz+2Khi9NFz7y/aCZvNaGMR8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969546; c=relaxed/simple;
	bh=vrqN/QDiEY3adtUjiHJ4zc9O1wCwDFXuoMcSbYrSEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTM8qv3HXLN8y67e7xqntzaR8wstN25PxKRP82XfIRQdrc/08px8gfwuIkR3C+ZHbr2rc+aTZAD1aqX5DJLi6xL7u7gzt+TMV7M6fnvLZ7s6rTPxzM331oNHh6hBF/gmIxxptlec1F8qX7mszavVASfrRzwR/SVXopAO/4u0eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbYCuAO/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220bff984a0so120192085ad.3;
        Wed, 19 Feb 2025 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969544; x=1740574344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=bbYCuAO/uPM/IAbhFhD0C8uVo+R70cult+/NQ5+tcP77DsIA2Z0vSjQnakXFXInxRc
         prK96zFSCARaa+l9DWe6xKsPbLZ4N5xQH3XlPMz55x4LpMnCdq0c4w5lpePiegNUr5+H
         XMmi324sskK0zPQF8C9D6x09yl22+MtHJACNbvri5uNRXFQ4peSl+ku3BKnUgqCbK4ko
         AzsxsVbdJgwWEbbGCaDuITa6j+//fYBkAj2uQOCvgxTQcYqfRyxtA5UCE163vkFa+c1G
         Fmbpiaway7M7UVT+zTuPEAt08l6Bdp+0nEJ/YyOOd9nGZeiMbIc5Fvko3whVVZzHYrDY
         Zf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969544; x=1740574344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=L1knVZws6WmJ+dKG/mEM2TdmygUWUANsuStfFhzpbWEM5ODCNAoXreQNQrYl3Eyw6i
         HEXoqjQwiRbxXSu/9BhO7c5Fj2CukVMkKccOkMj4+hsWD8fbAssNxH3pAMO3uwTIikwb
         eacC04Q4v9LWb7j/0PMlexcr9NM8OTixMBpYnny7ine1bR4fZAQEz7q7+CLHX/cKUS3Q
         ivZK6jMBDHATVF+H47Tf8lE3Qpt8A5In1ebCzW1e6EHpC826y3PMN4eONlrnBv9Nyr2C
         Sxp6wTGimoia3oyEOMUufLUxb+T5//8evrqy0hGW04EFCkvlIO85zH/1grEwCQ1z40He
         nMoA==
X-Forwarded-Encrypted: i=1; AJvYcCUYBBYvDoXQzsOpjJ2b0KGI4RsFBbErEsfDcW7v7fcGG0nHmB7s86iVfPv46SavK20weEUftT0Jo0QO@vger.kernel.org, AJvYcCUbT2/4Bnfn0n46fo2wPL/aQkZieUReQ1M+XrWEHypkMaNQl7xBdt2XYEBPoV5KidtXyFwCkpLwxpCN@vger.kernel.org, AJvYcCUds6RlnyvrQcltWnbFMiiWsUSfTicFMz1wexCRwhwtsFB6urOgfY4uM0/+tOM7g/8pS1Y5gqZkau3Fpg==@vger.kernel.org, AJvYcCUgL1o8xbjUKOatF2Pk7RkDy4FwLfT4m8ThJwjYfQ+CMLBKdxy9APkhE1gdcySZWUYI/SF7AGwpnjOXwlcYmty0@vger.kernel.org, AJvYcCVIQiFK0DShtd6Br6t/jgv2GBfBeHBsFtv7bloSp4Jyabl3WYZks/9GWMgiNG61yGxrYPlVyXXolMREqNTY@vger.kernel.org, AJvYcCWd74sf/8mPC4NRpWuKCrdZikU+fZgkFR/PVCIgzhTONZYQHNJiXohFZIkS0Bqg4pxXUj8=@vger.kernel.org, AJvYcCX8ASXmlI4P/ExrQuHqOhScTRHJepktNI6OkkvfAh0UU3qR595JWGj971Wf45JcNzl5Nsmc4ZWToteyXSAwjgg=@vger.kernel.org, AJvYcCX8BM3yxhSKb4bUO/ihAlNvNhFBzp+ZhCahVWAMy5xMCFm36ntuM/Gd4camEpsxVRL17q25ixQeOhIJOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJ6PQk+f1sjekIzH8NY3GVjp+WLHDKm2K51gCSnBMjxftnuSD
	HGRI0q64MeaytVhRhrGD5/bn4TXOgxyVDKHt582Dq6TWp1y/iDY97VEbL3SWo+c=
X-Gm-Gg: ASbGncuKt5MfL2vceU8WtlTDxVgphCFhjuwfsxayDf4znqIyHvOHorGsfAT5h5IlMrb
	khhZ/dvjFxLYAr7RSLJimD2qGQZDWE/xCj8bFqg69bRlhafIA8FaX5DoO1IovobPZktiqLQtbL+
	MbMqTSW7PXh3WvYjwO6M8YguoT53ql0JcjMCEaWIB3TKnTuK0BukniCuTZ3pH+JoA1e/rLE/xcf
	HyvNyyBIbdnQqLYljtgdjyc7gXhFjYbPtbsQUeCc2GvXf0cDSlI6+PUUAse4WghbMCXlxjzM5uS
	qw087w==
X-Google-Smtp-Source: AGHT+IHnb5v62m0BvDxfIowP9iMNtE/Y7pYhM/eIGIlagffbyppVP0uCqTnvfVFz3C1LICvyxAmpug==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id d9443c01a7336-221040a9a0emr294098225ad.33.1739969543796;
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
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
Subject: [PATCH net-next v10 10/13] rtnetlink: Remove "net" from newlink params
Date: Wed, 19 Feb 2025 20:50:36 +0800
Message-ID: <20250219125039.18024-11-shaw.leon@gmail.com>
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

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b22a106621fb..ec65a8cebb99 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  * struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- * @net: Netns of interest
  * @src_net: Source netns of rtnetlink socket
  * @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  * @peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  * @data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9ebbde0d131c..e980481bdd28 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3798,12 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	params.net = params.src_net;
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.48.1


