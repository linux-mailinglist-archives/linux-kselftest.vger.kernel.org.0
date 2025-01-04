Return-Path: <linux-kselftest+bounces-23902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AEBA01477
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD0E161FAD
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1612B1B87DE;
	Sat,  4 Jan 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWPZ2unN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9D1917ED;
	Sat,  4 Jan 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995477; cv=none; b=DckLAU98L3fsc8twFlMKB24JD35caO3kyzSHLZwPcPMPoU9doLnn0SUhs69S/ecZSnrHWNyYTBkkRhk7YxEFGXXiKJ7mzzZzflQM33T/wT0xYs+FHw/qR3Zm8fHvgBSWea1M6s7Ag782iybvnVgw2NzJZZrUYu3mv8R3BufkmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995477; c=relaxed/simple;
	bh=CIC06w4e2E1VMUFcW91Xc/7RxK+9Sh2l/b7I4i1q96g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HerL3x9Xn8ok4lm9j8WG5+jRjWK5iq8f6S5Dziv9a0ebQyQFfkRa0Ebi4FPVtRBAZpNckTNqtpCVbIRrfQlSUzJcWXuk/aaxh3EH26zfjtBREbCNffw3HwXAXdoVSw57xEw691QC5K6Xk+0audi5it3QAsv68YFVs7ZERHWSgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWPZ2unN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so18845785a91.0;
        Sat, 04 Jan 2025 04:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995474; x=1736600274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=fWPZ2unNo5wQTP7JBCYGvBOnr0d0UaK5kyFjY9gh9ig7fNOjepicELK8sP44uiaCRb
         J1vHkm94gU89F4JMlhuWQYfb0c/xYjLcX5M7qu9EG2Le3yhBy26Sm2/9FwQT8aj2F95L
         vynfruAYIEKr7K9zwUIe2mHE0mCY4DLaOTS/V8qsePPZKuECAVtqjoj7CvMUzZLV5G2v
         mhaUDGYgxi9p5K2NcQ7R5hBUDCjYeFSm4OKG/Dcpya5fzE5OJGu0zfSJdsFGEkDlJLEp
         C6vWXf82By1krGkouJcg5qMlkWMuRQM+HEkl/Svm8NVaCC/kF+Nwq6T/9bQWa/eQ4agO
         B7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995474; x=1736600274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=n8VtyMvuMqgramWmfavxniu+jNexqG2v1dyPXw+D8fnRENKe7kIrXaUWJJUpYZ6U51
         /1jJjvzL/VPaHUnoLg2O1vs8MjjsMeoel6SJdlU6b02voVkIUi8a3X4Ed07rp/DCoeY+
         CHjuLNM1HSP3FaLLT2M3IJDnCs1bKVyOkQjHMMpyrHQhONeY7cNcS4DBDwRh9fqxAbdW
         o10U9ZsuJMOzv2DBg+dA82G9PZ5klJcbXVsS6ALBhdRMvz5cSRDGqIPFW+DdhUvGYS40
         TCDpQ4aBjm11Yz3rA/UuoTH2M+2LnhHIYnWq6+xLK7FY8SCyB68umAr17xfIzp2qes/S
         Luaw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ag9rh/wbM7wApnViTJ004c4kC4CiWsMAl9d2SSQ1gi5d0iwZXpr6nzzvD1KMt81fc7Ai51S8MRDc6w==@vger.kernel.org, AJvYcCUghFl+4uKZGxBSa/7x2M4wuZU4CrLOrlYKf0yeCCogya/HSSR01Lv5obOaISBYPBGmEb7WB7tqF1K/hOZ0Fdw=@vger.kernel.org, AJvYcCVaDoAVGPxocG1mzVpIlmHIVMFKnEv9HULJZd6aC8QThvCg0SWdzX3Dysu2OdWX6LyDGzUsvmFqdSnR@vger.kernel.org, AJvYcCVlRLAx4Qybi70EOjLTEFQ6+uiVmWNTaAaL5uh44ugKaU8i2nDqzn6LJVJnxGc8Ro5VQlw=@vger.kernel.org, AJvYcCWMaUjtdBeAKkfskRgIE5fzWdlsX5AKZ7S5MuvsfUH6fZ8Gr4Kv++orvYp8m7Y0fS5cxWJRPCMI1RHjwGbnpSzU@vger.kernel.org, AJvYcCWU9pJYcozHw/6x4/kx8+bsxBWI2jM3EOsomnwFf2XRG87zbMuvBW9UA87h+LL5CF6DzRdtsLvebdNvtnsK@vger.kernel.org, AJvYcCWpCN//yv2XAl9lzA5uAVaFyS08P+D1qIZxWkFWF2+AENk25VSIjqfL7hYFRONJknOr43eQvQS5I68W@vger.kernel.org, AJvYcCXy3fpzBsaaJBSnzAQmtCFSDUdPUT6ki5ugn2xrZqpjugsEfCCtQlPUZjNiOHSYnKma/evSIJH9+7K9jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxldIg1ayCTtVf/G2KxiiI09KsZjyHUo2BPr9z0dgEb/uQ/Vclk
	sgDI1Zwfe5HqrREsfjpnJLLelOdS71V0vYB0uBR60iy8nrwC9xbkL+ZlJiNyDLE=
X-Gm-Gg: ASbGncv3Q+ekCCxxaWZetjRaAk1WRn5VCGo/sJ6MBwDf/iiq7mnIBAncGwXcaoya90M
	QApgtKvQVsmaPooAqdK5lHHtaUgkV86/zD1AVnboaAqjdVeC0ozNCSP3k7Itpy7mhVcWFv+AgQu
	6wZ6ZhQn0BoN87KhaBphdvgWkHsxU8EJ+YrXRoCU74SUmz61y3mVNtFcA99378YtcRzJZGrZON6
	v9xykSCQlWq7PuwGezZxMjj4C4fjLOO0B+fyDdLeWDJMBY=
X-Google-Smtp-Source: AGHT+IFUA9yMRsjxfnRxzsse9+CSmxwl7XAkA4eYuGkgQjijZt7M7pM04aasIYGaynTW3Vzrs9d/kg==
X-Received: by 2002:a05:6a00:22c2:b0:725:ef4b:de33 with SMTP id d2e1a72fcca58-72abdbe4de8mr66912486b3a.0.1735995474274;
        Sat, 04 Jan 2025 04:57:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:53 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Sat,  4 Jan 2025 20:57:22 +0800
Message-ID: <20250104125732.17335-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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
index 6b745096809d..f65bd49da541 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3852,20 +3852,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


