Return-Path: <linux-kselftest+bounces-24367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0CA0B9AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C347A2CD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D724635E;
	Mon, 13 Jan 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kixnE4u7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DE2397BF;
	Mon, 13 Jan 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779069; cv=none; b=R9FdYnIMc3pQEOCITKlPXXBhYQR24P+6MWk8iyqa5WndYRoXfmEXYixG9p2UsxYbVBO5EtyZr2lFHndTShGN9XCLD5bCmSgwqyE+p8bECrj9zHFVVS1iEGWWm19PldK7RJnUZ5pZfulB7tx/bMouJ8tWYrnOOwSM3XSjL+SI0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779069; c=relaxed/simple;
	bh=1RoOlxGJ2Sn6kgEHCY+FxkXtwcVhSAPqVZyj9KxB0EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwwTQZp0CGMdVaMEiUgAlGgdGe7pyUWH0T3+Rjwr7g1zrTz72zu1chA5mcsm9xax6v/chsiMICWYP3c4aYIrENPifDgteP4PYmGuu1Xmd+PIjLSedIjpTrE7mIG+3hdgDssmKWDavjaQxheqPROeMI0klhAmentjXkytqWso04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kixnE4u7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so77851745ad.0;
        Mon, 13 Jan 2025 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779066; x=1737383866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=kixnE4u7j4CxKmHe38ncW1VAPwhl9JI40my+hvEntMKz/Cm4clDrwcRWQAOYkYMSs1
         jalfniK1aiHmM2Te+vM2A0koEXd+BugmA8FAys62oRgJ4E+wGerQ0DyHeA03yPNvPmBn
         Byl8B1ozIr8U/9Ltp5mcjZQh5QqxcMFZvnE0JDc9J92QH1DZyqhKFQc9ZvF4DVXVVqd1
         lqn+F3d01Er4JIsLl+DZH/19tIJJb6Mls4kRW47md21WK4fTon76/4jwHXIRU3vez+eK
         LPACa80/Yep3eGSIGL3eeBA/05/aAhsSGQ5Re88sEYV2SBFFWHN641vB4zVCfmlsTwpd
         3DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779066; x=1737383866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aStnhmnU+u9WzYJvS9wSRsKutCltWxiDBFKzpdLaN7A=;
        b=qL9VuZNdkhOKzg0NvvNX7ac302963UxtOzv5nnENPLe8bTXv5bX7GO7vZr6HVSsPuQ
         pgZl4vFMVkZivShBrrwVZqdN34xGWWqenpJeBQCjpZUm7aZNp2GE0uEube+RgqxlM2ie
         k9yxPCQcamzy5EJzhtJdsI/pi/oWTPNUtZXg3Z7SYx+Fnu9XlXKA/6uYkTyiJwZHWLbG
         5y1eRLzbQQMiX5h3rPyT8JMcdjO+GwuJ8HcaRIVxNGKOPPuXLGR/5Llu/jMYxnVshdyY
         LJMjT4x87UNFppTZnYxL5QD2GufsWilKTPrcvfcsXZGI4rhBbzQJGXl0guNYyhKs+yO1
         hzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wRAGsDry2pZT2YrphN9gGrfqTaF7MPWyiYTo+vulK5AkjwNT9H+kv9N2Y2s3VqywEriwAzKhjj/P@vger.kernel.org, AJvYcCUKb0wo+tvKXgb3uI0l2Wz09TU5d3AdOj6fSvKyYEikt9J5Q+DgnBo7leS3lROL7i3u4pfdHcERhV9ZU1z6fAkb@vger.kernel.org, AJvYcCUZ6IFBAac+R3bM8V9pERNBqHyVB83gPvIzKc1GYOVmQChskE5+DLai5OAm1qGbt7RsdXbEubgoZboP5y74Uls=@vger.kernel.org, AJvYcCV+adA/qdbX+P1jlLOj6eMmLiweIRweTZc+WgOeq4lOiiFxfhDFUmhkeXnLaMpQIIH+fyrpzEIdj3d4DKDv@vger.kernel.org, AJvYcCVPhcX5xcNl2GgxXmGE1lrd1BIwSSs8XPM3FdO+53WAiXnGBbgyo5cer6/32LrlZ1T27LE/57//vn3/@vger.kernel.org, AJvYcCVcH5AX0wNe3852401/JfpM0E8mdfDYalbWWUtDZKGGtMMeeuwfFpmWkXSVpHdUCA3IyA4VTXbXd8cYUg==@vger.kernel.org, AJvYcCXXIFOanl1R0GnVgHeBRNOa0O/Wtxt5gEtHF7lT+75GdcIzh1VRywMxBYC6cHVwdGYQ1Oo=@vger.kernel.org, AJvYcCXY/uSxWP7uaLsuEwlz+w1NXWBYp0wL/RenwO2t/CVEI3PnW6wAoIkaHi66rFHa86FjHOlK9jSEkFbqzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbjOPc0QBJ9pRF4pE2eeNavmtHNWqrfgGzh1xrSED8nwwKrLX
	rRpggr5uFkQ4Kq7/pJGO7X5dZEzO60VrAkEf2+/leb29qGH8FJbmwTe9SGwBIpw=
X-Gm-Gg: ASbGncuKttoRMBd8lRpINXdxGv4kd2lFplRhs6Ggp91IHcaADqeRq1+RRdUQPCelUR/
	HhmKfxtOSwCyrxb0Y1NzcFlu9bsWV/fpHtFBb1TvNm0pism3y7iaMahZqZTKmBr0TaS2jV/vnCE
	ifTo/LZbd21XojGd3tjIq/wl23aA2IsvYqobRde9DNig/kdAmp7KCQugjMQb4AwHZm0RBcNE0xT
	WIDYZteUyWmXMKlo51/WNartOitcVozWIguLGdvd26J3/4=
X-Google-Smtp-Source: AGHT+IEEIzRcAyOPsqmoPyg3LqUO10MpSinA1zy4f8+lVawQb15WuSETw63Trl8RPwnuvmvDM8k1Dw==
X-Received: by 2002:a17:902:e74e:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21a83f36d48mr318259495ad.5.1736779066532;
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:37:46 -0800 (PST)
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
Subject: [PATCH net-next v8 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 13 Jan 2025 22:37:09 +0800
Message-ID: <20250113143719.7948-2-shaw.leon@gmail.com>
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

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1f4d4b5570ab..ec98349b9620 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3861,20 +3861,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.1


