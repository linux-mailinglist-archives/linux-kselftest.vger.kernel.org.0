Return-Path: <linux-kselftest+bounces-26169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67681A2EE4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7968A3A92F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBB22FF54;
	Mon, 10 Feb 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrsLSnbb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483822F38F;
	Mon, 10 Feb 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194301; cv=none; b=RrukiUkRIOxCOxig3slT/3FnBrf5WNOj9nVDo/NF+fSmTFYtxiHcVy4ArjWhXkpxQHgnd+n6cYZAJScU0jDgsJPY004xv5IX4nljHm/n54ptFqzAHq2oF47+7uO77GPa6XR4BvL4VAhCjEQAF1OIJPG/KTe4YwyqNDPVpeeqWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194301; c=relaxed/simple;
	bh=069lUPDUvhmknVR9QmYXw35UhK+BSSNOI16puwTCeHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV0sFfCyc6K5p7fGKXKhTCOxTyEdL91nh+CszlrqbV7o6OlGhrYp7KnS1lbYeE6ThibTqEQq2+l1SK6z2Si5YUwzchN0Am6gFelMkNvGn8ZEmyGEQ4uAeqgEN29bD4gxMIXAl8UuhqU1lCvM19pH+IPguQojUjbrdE031h104/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrsLSnbb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f40deb941so88660265ad.2;
        Mon, 10 Feb 2025 05:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194299; x=1739799099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=WrsLSnbbFqqRk3gc13zPDSnAZlRiwYof2wKlxYLa8R9BhTUxjZgnZ824xuxuIZ+u6c
         z91d4HIl7dsWvQ5NHt2KSXYVEiVyxkKrvqceg28NI/Xkg9Fviu5eoHyV7hS9u6PWfy0v
         u5grcFZpzr5LYvDX1yHJLjRjVrEZyS+O3Cwh3qu9VY1Co10eU93BfoJPFgLeNk4TjY8g
         ywDWXpUYIJ8h445zqmcLhxuT6JpmtntEGw4G0dsk9udhfzsaCBkQm9esVlTbQFKmuAtf
         80QGa9DBITUrIepH5QRBl+KMxcc8pnkPyFjTGSLBrrc0z55ufkxHX3GzYdYmV7aT60+Y
         aBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194299; x=1739799099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=kOXPPNNgwnCrb2a2D0SFWgg4gmJuxw8e0NZBOTdUQRZENDOdkWe5B2iKRtQqMs8+1U
         jMXXG/DB6roKfZCnIJ3lMm3NeC9kxObtQYd1ffylc4GgQnU/Nc3F7m/pUMfbKIf9qE7F
         SwpZhkRkhTEnijjXV5LoaHFxziZR1syn7ejquu2cGtyPB5HtPa5qSvdO5uWzOdsSDirv
         +ySFn3B2cODAe5N8p3gb880x3YTa6DHAcOkjdpxkbJwBy59T2l5J26BHWSeAenQRMhQu
         0rzzeVHJGpx6EkX15ZkU5v4rdNy2t2/42b1tCi8+TQTFOlQaY/uduGxlvnMRQZLjWz1k
         /gDw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6PmrHYTrs94846N9pF7zxkJ2VuL8OnTNMKccfN+v6pezFlF9o/JDBUpuPwhnzna+PXqLuZBg7ZfMXTsK@vger.kernel.org, AJvYcCUTq26oo6ZEVTt3sKkXVSzwrr0ZC/gnyI/zUDlMsuHTsyVwwl0R2WK/DpFDI78j2qlMMnndPc/ZLL1lyQ==@vger.kernel.org, AJvYcCV6uBl5Wo+jn+ZKy94miSuvAzhhf9e/77IuAfOF6QgbEdquVjQlN1KYcTnv3F4eJNYnIpk=@vger.kernel.org, AJvYcCVFxcR76AHDloJjxP2eZyGBlGGiBsJC42dJ/LA0IMqduVlWoe1EFPmFyCEG2LPgjeIWSxsSUVHN+DMe@vger.kernel.org, AJvYcCVI+L6sWRswsKm44obEzhf9ZgDO6OUc95B8U+pN7OxlE44GqF8aN2pS+by8jhP35/gkCTMLz7TEdLi0Nw==@vger.kernel.org, AJvYcCXEHWW8zo0Bb1OJd+zQwiqgQsqFAQyh6+j8OZpQaGW7S05jv8Ime7TRAvk76lwoYVYyUjpFhsKbosZX3R2l14I=@vger.kernel.org, AJvYcCXGZb385Fdcv1XZvTowgdZwyBLvnjZOqpRPgWWI5mUM2B3XmMUvR2I1ZQWahg3S1PLF+OA2QZgWKTIV@vger.kernel.org, AJvYcCXMcT22TiVeM/r71wYyXeytube77HQk6+4U9CCBmcIhRhXbVlDMNu26S7EVr1yAYU78CsbJzbuJdY2+Z62gtFns@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Uuq+JFfI8ecwJ6MC1tjJY/aUayh6I0vH46eJAorSMPfpBg75
	1VnId8KvOo63FKigjfVz8AoFMIvMYNUgTZPNai6FF5HotblM8KuBPddUSkG/CjY=
X-Gm-Gg: ASbGnctjaQTwmkxWBu+rhEmgez5vVmVS0LYihC99booBIyh4IoF0I7DIrfBf7VaB/Kz
	rwjP2NyNjFRncALD9tzBn1fWbLkHIVPiF+vkAcEOOtI8UdfsPbast/a2NnUR9rkwKUx4Skv8ea4
	lMnprLmu0Yi3gnWt0IfTvIEsCulXRauEF7sdwLKsf4dunDhy+ob3SppcIPCDt2EgRJUUOUStq8E
	WvsjktWK8yEn85tUWQ4Q1A3IwqldTtXPS/m7gsq26xLZ8UEJz+A1C258NIdj095V7n63hw1QQs1
	JSUW1A==
X-Google-Smtp-Source: AGHT+IEvqpw8e2KYvbqgEmvCDFUuCXdsu3E3xccl+ty2yNtqbZtpph7stG1AFKdWtDXwqVY0rqWqig==
X-Received: by 2002:a17:902:ce06:b0:20c:6399:d637 with SMTP id d9443c01a7336-21f4e78de85mr276877915ad.40.1739194299072;
        Mon, 10 Feb 2025 05:31:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:38 -0800 (PST)
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
Subject: [PATCH net-next v9 09/11] rtnetlink: Create link directly in target net namespace
Date: Mon, 10 Feb 2025 21:30:00 +0800
Message-ID: <20250210133002.883422-10-shaw.leon@gmail.com>
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
index e9af0775fa6b..a11b2c1f0985 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3788,8 +3788,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3809,11 +3809,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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


