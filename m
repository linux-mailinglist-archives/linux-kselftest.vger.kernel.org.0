Return-Path: <linux-kselftest+bounces-26962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBECA3BED9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4142D174EF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DD1EFFB3;
	Wed, 19 Feb 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqAKVtrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EF1E1A18;
	Wed, 19 Feb 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969493; cv=none; b=NXgGbIvE/PpiCiXlDdQURBqEiQk2feLk3uh0TF9zpwyc1iW4RZFsHqCz1E0zTIRqnbrkXnjb+2YH/RX3g6uTKTiNdBNefXV/tjte2cF/vgmB9l9pGa/udsru2bJoS+aS2lFpJj8bGZvS9dPlf0aX4y7zkCMDYj2fu2swsdapR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969493; c=relaxed/simple;
	bh=wPBh+lm62MwNx5uxT7ebUmt4/Z+4/EESOV0PaYKRJhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDQmV1cBdR/4BP7wab3zZslnhgpbcdrXrcbVeoVjNc+Zr+XOJjeqQGePEG7Lx3JKCqmfEJQ3t/FmloOwj+zNOR5MEQj39u+lUL/ymvBvmFkZOLf2YajWsyPLyV3BGndLrXtyrmaFD8f5TBzJBRO1gJHaY9k20yA0TrgxMGiliGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqAKVtrs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ecbdb4c2so2358725ad.3;
        Wed, 19 Feb 2025 04:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969490; x=1740574290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=IqAKVtrsIK9gPfYvB2qMyHNznqkv/bqL39s/TeYvl07ZnugiuA6iEKNeai4KI1M6G8
         ICw8sihir6VBTGmR6m8LtIO9uBtzHXQxTgiZYXeYKH+cfufCVt74ziKaYs+NMr3boUOm
         eAGGBv8W7bpeBmsjvGVxIhNx8gj6KzXPS//YKVoNHbVoit5siXdtuzEe81ZilpbjIC51
         ApjksghQhcb002RpAo9Hc9WO0Q8Qcnu1crjvqNlL16/5DGaqSrmlhWJ1NV+24BGyfwNs
         UDS4pewY33rqtWjR2ncQFgwhPywxfASXHHd9/1nJuwmhW9PGpVddb4ZO6o5BN85l+mGc
         4iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969490; x=1740574290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=WICITx8dW38A8p4vfYw64NcXz3zFVlHEw2wD+fePXjXyzb34NGPNlSzdht8JM6fNH7
         U1EFom/XmbBSP9A1l6nm7wMXTrJjR3fD14ENwKQqVgoH9eM3j3gJL4InCG8QiIefHBVt
         lUSXJ9/dlITdw9VKVVVeXkroBnXK8ezgd8JN/uw0qn22+sgHv4fnC+Ie3vU6jBIZZ985
         ibDy/tOvMSq7c9cLi46DjZN2RaKlYkpkMos0JoChawGDyrMDU1Rlm3NPZU0zjosPus48
         YDDgNeEgM6E9H1LyYv0je/yMKfKRgxYCc04lEf0GFW4YOHEQ9VIyo1QuAB6V8n18buw/
         NOcA==
X-Forwarded-Encrypted: i=1; AJvYcCUTX5iYD4celzeoRnUPNXzhD0qjugCQ8dnrKQSjTqp14KH6r8GuOYiYBfn75hm6Gu4+7h4=@vger.kernel.org, AJvYcCUxcFoH08nYn6Ike5cSgoBX+AxuflvwwvhM6NLrl00NrxvCpOZyzbO+iyQt+TmFRhF05ODix6wl4HGoLw==@vger.kernel.org, AJvYcCWF8mseTqY3VvZmTT9+GYS9H/ZF3ZadpIhSgkwUerEv72x4I+ny94UKNxRJFWvyuF5m4hg6K2LIKhLiKwZ9gad3@vger.kernel.org, AJvYcCWpMeFmT0GlQFAQU3W8xF9hMRPY93Gfa+v5lJRAeU3ZJIRyIUEmEe21I7o2OViGYVu+U5eI72Yp2THV@vger.kernel.org, AJvYcCWpqL2+BmTFwAmiwD2InIlWDIAvNMAdCMzmHE5OPGDRcc1lH//NkRbSqAZZ2E5xYToFTaTXMGuYe5MUEU6m@vger.kernel.org, AJvYcCX0Zqt0Knq1/V8fVjFLrNGqh/BZwlgeo0nQlzF0gEqYS6LVmZ13gKMKPhyiGhEsn8QIGFOIzs+II6rFNg==@vger.kernel.org, AJvYcCXqa4DKLQ61oaFODfSX6zVnR44GsMSI3V/hzDf/w/Znv5lo8GKaeYTVUbrTit+HU+uX5XN24VMYCag7ahLjQIs=@vger.kernel.org, AJvYcCXzkzwDbk0YaZ1ml/FrUePO6kZtUpUCTjCRoIshSjltE1jl2yOP8YGI5ggMHPfVXDQB3G6JfkLaUpbq@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5793nj6pFhPx5qGD4s0kPRH0AJY6pxlY53aIWRWr+VCbmYve
	p/0MlQIDec0xOsf0iQ/pUJt/dm1aqRx6+9TN5+GEGBScGs5uizaRBh0qkV4IXTI=
X-Gm-Gg: ASbGncvfhRn5+KnBSAN6Teg5/T+r9LZmP8ew2nVGFpLl0NROugO1yrm0naNt00zhwke
	QG0csqyg1TYi+uiA434zg6XeRiqjTl26/z9C8yb1HrykRRxyJSk2+riLtGvq1yKRT7ztpUquhOI
	hTffb3rUGyij1kyD3qr2qbwiT7qju0mnBrJYJPBz7Jx3zcQ5srHFS5Yxb2n4Ovfctlw9qqvwAj7
	l8t5vi9wuUee6kxIjD2K8Flh5MfjMY0bFt++01czcZize9PkY/+Xh52c7pmI9p0kNHKeccvCZLR
	mTfDIA==
X-Google-Smtp-Source: AGHT+IEqkCyGg/QTxep/fqv5CqcRvswNVHWV96b7TSvHtcfDnyWeYpeOAf5Az1bAxRJk7mW/W72uWQ==
X-Received: by 2002:a17:902:ce0d:b0:215:a179:14ca with SMTP id d9443c01a7336-22103ef5861mr278510175ad.2.1739969490317;
        Wed, 19 Feb 2025 04:51:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:29 -0800 (PST)
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
Subject: [PATCH net-next v10 04/13] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:30 +0800
Message-ID: <20250219125039.18024-5-shaw.leon@gmail.com>
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

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


