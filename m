Return-Path: <linux-kselftest+bounces-24370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34FA0B9C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CE53A7CB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403928EC89;
	Mon, 13 Jan 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7nvOU1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB028EC79;
	Mon, 13 Jan 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779096; cv=none; b=sJMSTcoJHW0q3D0ljsi2bOKCLITUPsCatlBVYWdr+JSYkGSWmRP6t9uo4jhBu9078IuzP6jXDP9O10yL9qGfFKEp4LTQA3rS3Zmhuphph/PKTGYjLedzIu5VxGi4iSEqAUqWZlwxiPIh0EQ6ldLuP0VUGK2BbuznMcEAfjZeBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779096; c=relaxed/simple;
	bh=UswJPFD7QmjNf9lnKyVnvoe2wLuFgTdsosj3eJpjk+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFBJya9+/2ST+QHD9RH0iRlnfIcggsaShzGR5VegLYDh8L6wisf0yPnizVF+IaIpd6elHipJRs3mxou7DD35fkMkkcdFAvMt0UfwoHtAq+nbZ8VulhSWTiRGLU1OOpKgR9qf+6ad84OBxolmuUfGhLod9/ApS1X2vnvq0Zq+NJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7nvOU1B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21680814d42so63198495ad.2;
        Mon, 13 Jan 2025 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779093; x=1737383893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=P7nvOU1BAVVJX1pcnp7iwBxwFvhx72OP6LhQPvJ5zpjEJOzBN4sBwGopb4YoOsRKPM
         7zvnb4MT0iG0DwRujS2lfYJ12u+U2Jz3dyaiZgFDZ5V3fjvZrYXTqoG+PBprAl0sRiBK
         nI+b1n6CHABpH2XpjwvOFlVWGSX1nOpUIjtcMYQ9fYgKGemCFWCFy5ga/pO6IjQY+Dxi
         +5Hw74YrnR6o3DXIwr585ErIIQZkWL7QLlIpNcdTd3M+XVKlCz9RkgssIEi/qZoR9G36
         qorMca4lHqQbXoPa6G7BTa24hvX2fHGjcSeLPIvjWmT/7YhFeudZfnV2uJSlSjwb7dRH
         knVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779093; x=1737383893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=sTWVuh8zUJSfieh0OOuSBiba3eHAMY8QVg6F/ezkIsWOjhKZWzMNSz1n0K/I0qNDu/
         0oFnKA844Y2yXNSjzmFgZv9KeZoufsXSvkFbX9JdcC56eg1sOoLELxZD+P19zVEl35ss
         Q9dVQ+obdVfRLEr+Hnclp25+dXm0MsmvQWfHDlSxFayDfBb2q1baUB6jxg2hZC2XJGOS
         iS8yj9XasqNalcPJcUlHrYUFXHdt8e6FgQqAzTM1ssh65OoZ9nXgyLC9WWbNuFxk+GnQ
         aFbx6BU9mHNkChSwjh8yx8bsejqD7VlIPmlNvy2elu3IOWZGjv4E+onZkvYK4AgP6S+t
         WBEw==
X-Forwarded-Encrypted: i=1; AJvYcCV79Q6YCyuLd9HOOgEC4uefg8nyclqynMuVCNKnXevsktnj207pLWQ715uE42cIJ7j/sgmTwotYEKJlm/BwtTin@vger.kernel.org, AJvYcCVUWQrGsThYqvCVK0TltVomGS0kny5hfm1IBI1kQl5bEGBct5cfWIb5FpAwNr7XJZbF/7LuPSQFVMbOVQ==@vger.kernel.org, AJvYcCVcdct8WQehNT+H+ddfuxHIvlEsQrfDXYvrqK188phpYpFRI6tCLXxCkHdmgBkfKuQflNnWv/7G9KuQ@vger.kernel.org, AJvYcCVey9sqsa62ob3mDqgOCyScDa5sKY0//W+fqi0V1lBPdYZD3IWTxLQVXuDBCAVl2SlNzwY=@vger.kernel.org, AJvYcCVyqPL5pOOLY257Js1kYL9xftAtsgHuRKUScxxvHDeWeBSXOkJhNC/gB1ognbs2fpQXYvi7VYdRBkVR3A==@vger.kernel.org, AJvYcCWIJ/OEdftjY2GfRXnR3mOOUhrxeZHG2xYwAc5swEDXBKj6hKoGI9/kC0UT5o/H4D9KGgRFqi3w6RavZyffajg=@vger.kernel.org, AJvYcCWtqh2IYFchfdmGkhjC+TCUMYFFQgUQxYhMk1lkvWruuSjVboc0TizRDdieEwpo+Y3ua3dl3Vcsa1stWgtI@vger.kernel.org, AJvYcCXBzgP1UMDag37CgheJImBdJevSuDBHm3ApCBbE+6Yr0yHT96ejrqLvccyxP9h0MCrtL87Y3HqLidaM@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwsqSG/Rhsf7iluZIJSflOeA3C2hHMix8NNj1r430FbfdIl+k
	6YKNbBX0PQZCKrWy3549cb6NrzB0zOswpX8SeOznimWqTndbNZBfmg5YO4WGod4=
X-Gm-Gg: ASbGncvUatyTxjgZ8GT8qMOxngVhPx8GKu6Nx58oJo8CbFAtNWAoxQFCh+6tJdXgHJ2
	tHPRPjJfH5hirAYF4b7ciZCxbu83+2s7ZQycGBehL10wzPcqrq3QcHazRCYdSsplbA4J/CPfEqF
	C8HewfZqkLNprfIXYxGk6D5pR4SBQhjccHAjnjuDQapkKdW5rfGTxsbN9f9yz+jTgWW4BLbmdq0
	NkZGlTpnzCEWDvjFyrabaFl8dXjvU5Zao6iWR7mIkQ7T9s=
X-Google-Smtp-Source: AGHT+IETQgOg7AunUSIVLfQXCmw6Miexgpzxtq5jBXEGmuKIo/a/YyzF3Hf0c0R30+3xPOc3lWG52w==
X-Received: by 2002:a17:902:bb8f:b0:21a:8d4c:a9b5 with SMTP id d9443c01a7336-21a8d4cab74mr209427215ad.12.1736779093022;
        Mon, 13 Jan 2025 06:38:13 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:12 -0800 (PST)
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
Subject: [PATCH net-next v8 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:12 +0800
Message-ID: <20250113143719.7948-5-shaw.leon@gmail.com>
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
2.47.1


