Return-Path: <linux-kselftest+bounces-28475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BFA56614
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6228316CCED
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA31214203;
	Fri,  7 Mar 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pSvSd49D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B5213E8A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345306; cv=none; b=SLab+vsLjpsDevRYgpvQHRZLQkqXEK244gassvJYSmCLl2wMqTipmg86fE2Y5pb6WQ5vQWgA5hzbI7NgLvBJnyhbc+f0PGBMEfW2UPCE6mzA5L6rN7ZTMd5KcWZtIXRzJE+ZVvhpmOZ6l+1xb4mxdG/l3wYUwhpFpx5W1iCmNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345306; c=relaxed/simple;
	bh=0OHQ36QrTe7B1BaBYHRqBfDehy2+CeWD8fTKK9khYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=RD8jYVBj551JblnyvW2NVJjn2uPA+sYI4nWZJv/XEwkC11U6ObrYYXgMR5XBmg94TqBOQ7qZo4inPZ60pO4qKD2lVG0rvxqeo/2OqS8gMlNJAD4LeJcNEQBc/CdyDVx7EF9GZ++u6cwKooIt6SbxQQnks0xZsyURZ5L2N/TUaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=pSvSd49D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224171d6826so1670275ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345304; x=1741950104; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=pSvSd49DoWaQg/f0IZCJ+wGwjbFt4a5hvjUDiz3wJ4lUQFyWw53uwpuwFf2hj6jY5Y
         r3frdY8PkzjsgnQBOgnqgfolfyjWx0EfU1E1sC5gh3fKxCB7vLeJTqIIBEflHsJOoMdn
         R/ja6NKtbcJKrg1Ni/VaJqn16aOpSjD5M3s75q4bL0orOOILL9P4ccV3PYiEeWhbryoP
         DyDl5KWuSqzshm52yQ787w2gYBqyFsX6D9uOtebp3s/fhJsY3P37tj8njvytymqit+4s
         Fx6wLPk1Tsj4Smlm7TxYUW7ibEhjNWTJgJcRP+8cYpkWUyIMPQpIHzC5nE/SHgCvIWqR
         Mpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345304; x=1741950104;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=GgML68DuUR/tk2HaL0rHZa5VeyWKIYNEQKVLMPII8KfAvGZB3ZCFPTlAkkPb7Z5IIl
         q+Y/rhwwsqGA88A9JArYj5AO7HlGmCE+4WEDdfDMTZdtC+0wed56z7o8Y/cSGnZrbAre
         3Dmyh+ECV796GRogk4UTirk+YDCQ6w+171G8HA+a9SvsFqfI+j3zCzIYnn4Pf3eE5W7q
         6nMRd+gJYBuCMS+wS1jDLxVCO71qAy/46SJKszyb9dzd4wN0uqWG8Sq2FenLgUBujiRr
         qa85v013SEP5DGLp6IE6u9azMtDYfGhbG4ZRUXPBZXFze8zCNsIJO3p/GrHQRfipRzjx
         yKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXL/7tZei4IIOeHatqp9d1k0k/SiJic46WClmWHhpjbsMSyJlkKbbFSkx6RR3G2+9q1TSeW73KlVQveTVADBSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVn12QvjcOOx1O69emL++FweVy5yX9cKTwbR/k3XwJnH+s7T9
	FJgWuOjyBNanOtltxDXK7e5STrcoKITbnl08FQqjztfvQNd69trAuJgsT2PqY1w=
X-Gm-Gg: ASbGncvS+4LG03zuifhlL3nsBYNlyuEl+7dou2xy8xntDN5pMeC2xxcToUiRn/aF9a5
	5u/dXJ57i6IL8jEkisZSCaBnEPH5SrRQqmuMoORkOsFV20g7DbddlXXCMlO04mo/1ZYuxXi9AfK
	OzM6qDXk4BhL3D16Q0Suze/7vX1bQm/tsmMOFKFyFwGZi6cOWafLFTX4EpxdvpJVs3XrlzIR47I
	xmHl69Th+AAYedxcko84NaTasKhYX3CU7IYULbf1OGuD2dObXbLh9anHL3IUAh9xvTOzq+QBeDz
	5FY7z5WN28uQvhos15uccAThUKfFRE2pPQae+3ebhuQcnrQ8
X-Google-Smtp-Source: AGHT+IFjXPz+rtxm9fbn+OJtTENM9UvJxDY3nmnkxyWgPEnLzrhO14S9pj8Y+h3HFl0juxuW+kAxWw==
X-Received: by 2002:a17:902:d505:b0:223:37ec:63d5 with SMTP id d9443c01a7336-224289945e7mr53616935ad.28.1741345304575;
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a8ff3csm27196145ad.161.2025.03.07.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:18 +0900
Subject: [PATCH net-next v9 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-2-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e8560e25a4dd567a04f5710b53452b45..d01c1ec77b7d21b17c14b05c47e3cdda39651bec 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb543c3d672f576e03b29aa86b9d34a..32c7ee31330cf52df05d7a23b3e50d1a1bed9908 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.48.1


