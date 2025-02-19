Return-Path: <linux-kselftest+bounces-26959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E7A3BEA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073BE16FC31
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E41E1A18;
	Wed, 19 Feb 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecbgRuOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674C1E105E;
	Wed, 19 Feb 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969465; cv=none; b=nMexeF46fSz4/CYZaCHzMWEwwSeGayGzqo+YuokSSeoby8o+sZwSynkKCi3A6TLa3iLWUdCwKk1HxZnRxkc/5dT5RdL32XIpyBYueSWBK+FjFNbXzVKqFvVicdFDzSC9sHmPTZVPwTazGimCnLNR+9vUDC2aVQw/BVrp5gKB7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969465; c=relaxed/simple;
	bh=PbUXwb75wlN+Ai+ym+Xm59yi3YKBtBMlSAHxh5phdAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYyVQJ6Dj98Z1a4lYjrSkuJERU29X9ekkkQGDW0J3t6uqZqkTEej7a6KOKK7CsCone4K8Bx/LOwnh+UIbFNRvWB53pl3hI8wlQ5Q8rkr/1tMX4tO2WUg3hv7jqVEAbdViecaRTqr1dqaL/lIchHtCSKqmNngCL0mmspfmggp6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecbgRuOP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22128b7d587so61216405ad.3;
        Wed, 19 Feb 2025 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969463; x=1740574263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=ecbgRuOPJt5TgNbUWjN3xWsKIy4XyHaJDdrJ14hWFD310P5kqlOpPiCAdIrJ6MnZgK
         f6a2qiNdxjsZwou06cvneXr4WK9lYOtDJquvpTCL0gdBSL2CSwdPdQeYG75xKCbQWUFW
         P8LtOhuhDIWUuzOpUM5TEjnheevfenovhzDc8ZvAcrSxWEXw4k4xxSw8B8P6ZRhsrSyY
         o1gaHtA0Q6U6btCHdI4faZIHIXdGb6jMbMTFGRjqH7Vd6OwRgnzcMgGtl5uCi9/lYHGf
         yguR7fpqPGq9BB9YKDlTtnooZDToRYtOqbfdxdewyepul4rtXf1poqXXa+D5dQ8r4WDZ
         rrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969463; x=1740574263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=gzdkp3gjSZQLqf9KEodvLZtlqwk0wDuVf/DNA5m4+VKQWBKnr8gOLwPTvF6l1LfLx9
         aKDlI1Zek7/rH+ZtJzdiieOEtbcwYkY92+ibO58J6crrZwAPfWQ0lkfDO1IL6ZUMLC+9
         M66V7/4lWcWEmo9CcexS0AmlyECu3dfm3saHai5Zo5KIB657II3nPAjnyyP34cXOMEra
         j5OGBd1LTJJtBu5zjcfoQTP8OwnTtEMUdUtR6p4uFC+vgPJ7Us2KKf2nxFCD6O1j3m9R
         qKrDHgA815skkVM3NLb8dOFZuh6B4LCPxwBx6qPrvRlkjsoU9wpDauheaYBtU3ztBSvO
         sazw==
X-Forwarded-Encrypted: i=1; AJvYcCVOcRHJiIR7rVkdOHkfJMQhYjBpchU6oNR+qSRTzdVfJL7vmQSLkF0O5CHrCgoDsMqLRFMWDsfZnD7KTA==@vger.kernel.org, AJvYcCVhX11t4/1UBkW001Wm5/lo+J9MTwXyKGs53dzFd/zgiw+9vQU+laIpzoABIlbmk3mFj8o=@vger.kernel.org, AJvYcCVk0PDtXP//d5HqLb4NJ1x4HHfORs09vfCBaU00EG3TQ3A4ibfM9uSatvH2GcgNQg95qiAwFoaKfJun/k9C@vger.kernel.org, AJvYcCVlp9KrngXsAwUM9mp4QHKdNhSo092L7Z6QezvnoPZb3MBMcysZge97TR3jiqzlHojSW3GzQykbPXii@vger.kernel.org, AJvYcCWJdcMN8PO8r/oh8n2oM50eSimc+brdIpIN5bQYUKilB7mKZraX26+Ki9maBjguORs0MG6EoGLDFqFwLw==@vger.kernel.org, AJvYcCWuQIRy7ZsNN0hhNTudJUEVUzkQDwxL/bkPEBMstsici6FqdUXktKz5INhisDfWa5X7xOfqcmJp543CylxQ3ZBm@vger.kernel.org, AJvYcCXX3zhWB4eGDofNRJe2zI7g2kv3AK0yPrpzlUOaL4+STcP9prNWeohcD/rXLfW020e6na7vMuHAJTzDqBwJf7g=@vger.kernel.org, AJvYcCXdl8jOK4Jr2/hLUvKRy5dwaMaqww+XOTVpJWP1eS9ExKrubF+XQNsbTEJlm6A36BhPYHN2AnS3RYPW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1kNO/4oi65u1grqqCqFS/JWTgUdHqSAhEEpo4GHLZSJhrrsK
	xapTiBJbyT3RB84Fef8NQoTGXsxs2JSH2+DUK+mQAihkaXfXgF3dtKlul8qoyDM=
X-Gm-Gg: ASbGnctAeUbSlJuxGQePlG4p4We82q5ItC3BR3ehJGvUp4mpPaVpF68S71L005QceV+
	PgAdQ/aoLAWh6o4LwHjdZuZYoAEfpRpAP7utlUpsETnFniM8X/pNAt/CVH92N7dVQ0hgLhR9OkV
	1Fs5JpJQ+RWmggrR3a236D3MNUS4P8XqFFCmAaX8uPszicEtyI44xt0ObgPR+/YzUsNv01xX/tr
	SY1JnnOSNuTkDJXxdfJJ3FtLfGOMAZAtSVF8jeFUqJt8hcOjP1RevTIOAMvG/B9tFCCgKZ9PVVu
	PnM+LQ==
X-Google-Smtp-Source: AGHT+IGj+mvdG9uQ6taCs0F1tgau+Kd1RL6XlmFtErS9OY17fyECZArX3uy2OYbhVupliE/g/xkWBw==
X-Received: by 2002:a17:902:d2c6:b0:220:be86:a42d with SMTP id d9443c01a7336-22170777df8mr53655825ad.21.1739969462888;
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
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
Subject: [PATCH net-next v10 01/13] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 19 Feb 2025 20:50:27 +0800
Message-ID: <20250219125039.18024-2-shaw.leon@gmail.com>
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
index abe1a461ea67..0f3e2c6021de 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3867,20 +3867,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


