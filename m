Return-Path: <linux-kselftest+bounces-26167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA4A2EE18
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D516116810D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BA8233130;
	Mon, 10 Feb 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyI5OqrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA222FE0D;
	Mon, 10 Feb 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194283; cv=none; b=kv2v+FshHdQrTUcXBLrdL9OguZxZKz3TbMz+hIifT8dUskKgnvd+PirX8fem/1eMk3pAn070BrFhGapNGaVVgZe3tQlvKQlEoj7qQOhsy7rr71q0FbAhw/AY0d7fprjEzm/Dj4I9+cYcMPBGitEGIeLH6de0C2iDs230Am7EIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194283; c=relaxed/simple;
	bh=aKbzZxou1uG+4UzTz9mjeL2/4viaECGZ39kotodArQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBoYtAURuRkpa1R1/5QRLfchn5HUuNUztlGSrMIrBsLLN+Fu0bgwmp4Ry/Kj5C2et4oWtR9F1IXy5WM+ITSHmWNbp+NToBoVgAvedIxjxyOK0cSv4+pCKAV9ngy4e47A7cog3r6EkcYYxyGO3py1AiOsbLvOlRecdnkPIp8rBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyI5OqrV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f62cc4088so40125755ad.3;
        Mon, 10 Feb 2025 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194281; x=1739799081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=LyI5OqrV1frdJQ8PpqSpyO7i0VEUiS0csLTv6s0Q91C4asspdrAfgq7kOCU5/dRjCZ
         pQz/ob1OSgN7mYYh7tlBKRV0ytz2wyxGhpkBUNxtIAX8dNHchoq+CplFKuJgYYE817KK
         gA6dxaDuhXMV3VOz2qUBDGCkyH0gVzA91XMaqz0OvAKqOL90NTey1iheeSm4VzudDZFO
         usPu57iOtp1838bwDGDa+WLOKqMGaDPqXyQ4lUhJLZa5fqDyrPU4I8ykjLE4N5dUIOxZ
         xAyBrSdoHthgBiL/ZPetfT5Vkv4KDfVVOftpepS2hgi3QC7tQjam51EKTAAIaFH96eJm
         gWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194281; x=1739799081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=Lj/jWFUSt1Vq8fN3KmjMpeG89PtmwFPVqm2xH1RSwUzPpkjlQabsVDZVKy69dG/SnR
         rijgIce4YuhazakmeY+pA1nCiZzqnHODgqyj7cjdZh/I5l54YSKqk6F7Y26RF04hlXGJ
         ByJALm2HLufL+vAOWQtRK7wpzuTT87aUVzq5qqf/FspCJ5GOYR/ato004jf1pPh/PgyD
         5/c4aS4Yf8V/PQb08n7VJ66ELBKiY5DiPzhUnZLXzKWe0jZ1QPo9kppjCe7yw+vQjeMm
         HzCdhS5Q9957oASt6A7sXZ3dvgXjVGXVa+dWvy6Z1AzdBPeojU19UwYY1VNoAYbErtvw
         Ab+w==
X-Forwarded-Encrypted: i=1; AJvYcCUA6W/ewlRFSFwxfdpjrDSImaoX+K1Z56UZui+qv4ozgcjB61ZDednhtbauLE4sIScp2JjRFbK2BB82@vger.kernel.org, AJvYcCUW/Wiak4kHs9oIcY84pCAVsLXOqB1bfdNqMwVkCUwAY0fIw4MROlkqaNLtDsvnOPjQ9AgqkPU7ed/7SA==@vger.kernel.org, AJvYcCVHkq8grzuZl5fog8zCvhr0Szk7NodnN1xaIWgGUB/CDu/f5vi15qnRBjrJjOq+Q2eEQ9YM7kV07KNqeHVYSMc=@vger.kernel.org, AJvYcCVW9FdFINrqG+zJ2+CIpTC59J4aZ4z6t8CYVn66X8xzhcQggw8NYRRiNgXqwbi08tB5a2y3oSch7FmdJA==@vger.kernel.org, AJvYcCVr3ggYNuZxZbU7moeqRN+sKD4I4N1j8tbQd/gVHRX3yFCHwi5Do1xPL9iCU+w+q2vqptyMStGgU1Gg@vger.kernel.org, AJvYcCWkA3fepQbCBjNyigJdoNUOx3s6jeM6CHiKBm25NJ0CCrd2oN528GttvwJMUUKI9l3Cb38=@vger.kernel.org, AJvYcCX6ESFQ3yDZ7S++jtxud2qGrnT7rOvZW8tirxQxlz784G+Dak+Rj1EvemPy7CWgmGmtyj/1rld0jMsO1hNs@vger.kernel.org, AJvYcCXNQZoQ1+0g+L5rbSwdxXz7Bq/kDL4M8jXxyoxOtBG/n3iJqLYO/D0IDpxSoOY6vi6gtzK0Sgy4crHO1qDHD0Dg@vger.kernel.org
X-Gm-Message-State: AOJu0YwFN4DM0N4XJBfW2XJAgZtw/TfcVRuWuMnQqHL8uze2MtRDj7x1
	W+gY1lcQST+k6WZelv5/Xy8so0B+dGditO1GyV5vYMudWl2HAms3/NS1N1yesbA=
X-Gm-Gg: ASbGnctjLyKHXCcxfBFeWlhvMmKEihKVjSa/SoqC8AqHIXlWBGcxo3eJRGnTJKTpeU+
	U1428mFpYi8OOJP2MSFJiCJg0OjagXkfkriy9+Sd/s+oDF1WD9wlDICZT1fpLbg6BxTPdhU5ubd
	cCpka/EEZirAtjW21UX5N4vVfF8oSrz8YX2iwGTaAbaIkpjU71bCvxwK1iHDd4qFefrWlF0nBTB
	1zCPT3tUQSpRGinvHoOa+nxY38bhO/rTU6mcaOahRjPfwVv6k8EatBnuP4lSt2nKPZm8nz3NehH
	/RFPRw==
X-Google-Smtp-Source: AGHT+IHeusvrHP8M+FV2U5mrdVgA+KXf+BNwroimzhQyBeA1391Nd6kFx/ISaagEKEOW3Rex1VbPJw==
X-Received: by 2002:a17:902:c94a:b0:21f:8099:72e4 with SMTP id d9443c01a7336-21f809974bdmr103657145ad.28.1739194280801;
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
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
Subject: [PATCH net-next v9 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:58 +0800
Message-ID: <20250210133002.883422-8-shaw.leon@gmail.com>
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


