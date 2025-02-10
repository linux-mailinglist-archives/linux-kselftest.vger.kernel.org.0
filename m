Return-Path: <linux-kselftest+bounces-26161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D123FA2EDD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF5116710A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95122E409;
	Mon, 10 Feb 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7zhZWie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360972236FF;
	Mon, 10 Feb 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194228; cv=none; b=b4ic+a37SpcRVOrBkVKEOvGEAgwot0PtYhh5Tf9wma4NYgKVIgY3bbIjLFSLy1A1NAoHo2G8VtMFtTbIvwGTynlQUCruy2y26nA0XD0R/n4wJE8fTMz86vSFOR9dfVb2A1U//bE2RxnZhNRKFkjejoOD7HLYZyB9aUJZn5l33NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194228; c=relaxed/simple;
	bh=GjfoXCki/WJvjmnx4S+xzsgMh0oaUaBRvXwm00gIc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbWboGAKTm32NyAdgrzwDkZqBupbAWBILZiApFkRbiPdwER/o/whP/37wXVALu1bkvZWzJl8gY8rY8VZMEQcBh6xyF0dfOp0a5wsFRNrQX/4Ga5XN43DcNfCRyE/YBFrAL0dhjWu3myLNYJAKFHiB0Pdk/CJLNFOZw1I96TIog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7zhZWie; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f7f03d7c0so28828615ad.3;
        Mon, 10 Feb 2025 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194226; x=1739799026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=l7zhZWiegsCqo2a522+QRmFU8ReWGBta6pQekMDMWL3DQ4cUeiYw0+j0nh0v5eV4Bw
         53ERdwNr+ARI1Cikr1M6dXNCBfZNkXFOuE871vFEkbn8DICWoBJrlSG8XdVdr40P/bxr
         oqaEdXLZzJFBdiVG9XCAPQ/b9VnX2Ss0keS2BHRyPivrYaYZriZlDW8nrZk2M6TAR9bs
         UoH7MXzFO9RF/0vp7+vINXF/VdFXKyW4XjSEmjBOUZ8NXTHcgusQa+VPCSZ9yfVksDU4
         21CRFZ4owtNApzS542JuJf/ViK2CEY+hM79gVThdZpfg0voTg5Mm3kcpyQAOnuoLGhMJ
         4AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194226; x=1739799026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=fUAhSICIBAfuTKQq7gWc6Vpv/bJW8eJm/7vhCxBNjIyOFT4AjDZ2WDUt0hCkvNHhNX
         ZqbNO63sUWM9YM0UtjW6SnAdrnaKihrtzHd/qHyySkAb2mCODAF/EkI8+gYLk4/ihWqJ
         rWe6y0naoDwcSYJw6U7RupgR8jT145KGW+ylxA7pFY3+xybNLsyslNGU9w1FCeSC2DqS
         86Cl/EK4vG9xFqs/AnbgC75qFasBGFveO453Q+BRxVI/S2Rz7StsrSuMd9IuAe0emlkU
         wdWTa/DxDs8kX8rJaBAMNbSntOqmhSCe9yYmwuu3HSoiPy8ln+/o5BuTeAySxU7yVUdX
         KHfg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5+V/YZgf6zpIk8dkrAx+nAD9gJepSbCzmNMDgQ8vQKvuQ+Fgux6jbJMMHH/OoK2CC5jX63JcTm8o@vger.kernel.org, AJvYcCUYz4CwpzuFAGa3m5qyd0xg5eg9x2GQKvuXNXTeKx+89U55xbcT8u9qq3j5GpcDq0UUPk8=@vger.kernel.org, AJvYcCVasPHnN4+fiiluianPgNM7BJuEk+Y+jebKu11olccxxvnQuzJKw49URKYr9VUgNM6kBhNdKE/8luK5og==@vger.kernel.org, AJvYcCVziuYSNeYPDJ3NRugiFtrjS087p9qvpx5hy3PeNC5BwFFz2cd3uVPMyvoT1XPL0woThuyZ+9IaCv43pUs2@vger.kernel.org, AJvYcCWEXo+Lp4idfsjgOi7h3iM0rVNed28M7PJZ+6mpv0saAgfiAQjoOblztN88Y6LJ0p9/D3PaB4r+1Bn4SNJDAb4=@vger.kernel.org, AJvYcCX2gOsID7FCs+646zeG2l441GzDdcb9sgjUUtslEdB4qecAD9vh1ESJI4nBSfwC6Z7ypmXlR61qavORqXE/MOuu@vger.kernel.org, AJvYcCX6jrnIqV46jJg1w8KrQd5Whm96gjrITzeLYgiSDTPgGsdReQhDeWxYIEkfkYmJs/RPsf5O2Qu40bPZ8g==@vger.kernel.org, AJvYcCXlfROk2co/7Vlc4VFGPXPvBMmrtwjU5MNCN8eOV8G5Pw4OZ9+MkNqg7C9opjZAcHqh37oL5C5zwAYe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GXkBkAAl4g+10af0QyUDX7GQlYjGkhPmZNLJD/elA5BnVC85
	/P+LqFxCAGQKv8/PXSLH2z8eVBGOPdDfQr0q7aCQiKdZVmZhrQ5OZVBt2Dna
X-Gm-Gg: ASbGncu6qGMhy53Ri/FY2ifSrIwYAxzbvN6Q1T5u5qv47QWFJ1Zhb/wpvzyNeRI3RFw
	sdSKWr7JBa8S2YuhgG6IvtIfXX5YVHHhBGT+o/hlHTEADfyjD8wemDBtruXaCAezsTMGv2lT8G6
	sA8dkrybBLNP7KVo3eayxeTS2pfURqg8urGNnr0Sqy9s0CQKSzODqk1h29Lp6v0AzqdVxp/e0db
	goA/nuxxJbp0zRErLc8vnIN3Uj474ojhuveSeqCETZ79EkwtrXLgXceoO6eNlPW8M4sRtYZby5n
	IxrPeg==
X-Google-Smtp-Source: AGHT+IHnIbIec9duqjv7lrtmGReNVQPeBtoczKplB0CDd7UUW+fM90Yj1MwAFqvvYB9Zquhv6onO5g==
X-Received: by 2002:a17:903:240f:b0:216:7cde:523 with SMTP id d9443c01a7336-21f4e739f99mr242405235ad.32.1739194225944;
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
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
Subject: [PATCH net-next v9 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 10 Feb 2025 21:29:52 +0800
Message-ID: <20250210133002.883422-2-shaw.leon@gmail.com>
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

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cb7fad8d1f95..3b3398283a8f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3866,20 +3866,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.48.1


