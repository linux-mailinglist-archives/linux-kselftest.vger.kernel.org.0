Return-Path: <linux-kselftest+bounces-23041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD079E9828
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445D82830C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099161ACECF;
	Mon,  9 Dec 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt18EpZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD15233157;
	Mon,  9 Dec 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753028; cv=none; b=sLNXim2TsGIGmtO94p9rs5aTowGjlLY1MLMQaSVgTnl9jwA3zw6DLHKx7Obffc9H85Q7Pb7PrOzyWLJWrVGlxtDlkyPCA3WAV/rRIWkEL1LUc95JuTK2EFpg2G2G6Rcl2tQOdL3i/XXlJcbmT3ECaQu0DsAmo+M6T2KwvB/1v7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753028; c=relaxed/simple;
	bh=P+WesIXJWgwaVpGsZha80KW/I6PB+JZFQ4FU6cAXIU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArIedKRp2/Tyx/EaNAnqPi968LZTfezty9TyO9fKGmP6zYosBgUeRkRmDEXa11BP4bL9oydIPw/WG2zQwOXeeKloc+3pjm7rp4aGXn3wDOZI8zxSVlYqpdFKM8ws5Qgx3ilVdxef1XBzRq3dQ7oC7o9uA4dEL2/Io8i+mXt/Msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt18EpZh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so37998125ad.0;
        Mon, 09 Dec 2024 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753027; x=1734357827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=bt18EpZhbkmSZPipXdriXLve96flDYGauM4qfigG3cNVYzbTxBXTMv952cm1GBEMV0
         2gUTOJVmeCzMal8tqKpXhzEsenw9Qqmb0pbcenlOvaLmp0qd+M4OxT2FYZ7JkJ2spg54
         8yc/BIVbZNVTVcopnX+snSW9BRr+L/WbWCYLJqlaH28PUGmQ8/XUOkWIlIzCv/pf/HxD
         y43a5SIrullzd5gPQ9GZgGwnaC23srEYaNuEpCpgdWmPErrvQL1zLEprmcPtxkl5eyC0
         hsCBFNwiDJ7/3BShMqoTjYDDTm8aHWnvCcEBwYPhhxKTVAansN+gk7e+x242/DV5bfny
         Tl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753027; x=1734357827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=WaRVeMi6rTxfZpD8KD6VMtfgJdyTaB6prZUX0iXmL02U4bg71rEWswh/0HwkMGYQw4
         BDXLoJljMl5q+Ddre6Vh9beT/7wq1Rcf/sxxuMKeQHKk1GRtiCA6lWcmfwSN9XCJ+yUx
         4rMsVwMvIHqAx/5Iiwk902FMfILFwQpPZYxRjFzq7LrYOnO6OMwMF0auaEgwu4/trEuC
         EOMvO8FkOAgxcBFcGAgw4/5MtoKrVoHsyC5jtH6pm9sM5s4hvOvjiwA6TRtw7y5GEFJM
         gKf1MjfrdQ/fDP0vF1mXNntIi947jD5ioySVOU9SBmDv4Bafc+7+JS+hz5cNih+zZdV/
         NT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU39ku/KKGyrX2XoVF/R5Ev9Hc0vJNFDlioVs8r9JZIRW5ClGYtdav2P79FGBkpSXRFurQ36TwWZpPN@vger.kernel.org, AJvYcCU5NvZPLg9Cfyzfu9hp1vjjZHSGNUsB7YMtVOqx71ZAV0dZeTUs98Vmvkvk7n+xYko0zWthzH9u27YiVQ==@vger.kernel.org, AJvYcCUX6A6vFfbC2ALAO2GuSIyDFqO9WBJMppBspVO9MbxyyeOZ1VFzGrkI8qoWqsaT8y3C6vM=@vger.kernel.org, AJvYcCUaG7UauKrwGX36zYp/PPfF77Kl4K9lMTKD4HXA3b+/MGDi9/qhfZJ7+MiZuE2K08VAMoKRY2/vAZ068Q==@vger.kernel.org, AJvYcCV1nkhu1teABx+bL6JIWi06PRePQz1AwQoab+ZwJL4p9UPXaOCnfGhlIQyFyOdKmp7TakzuBE6PSGOrbxC9g0M=@vger.kernel.org, AJvYcCVEhymsflfj29gWjgc4cjy8gDbagOp82LQuWCqgFTzArQhO74hCvtU/W4RoUJ9vI1kxtK9MPR+jn8KHuD7rR7vX@vger.kernel.org, AJvYcCVd0LvoF7VzMx51RHtire/P6AO8sg3tqvsK4ngNk3yObwNN3maYVraZt1Rb+Sjl8cT39eDad3PHUdoF7oCv@vger.kernel.org, AJvYcCWnPNACnb8LyuGqXX0khAAYkNGwGPlyWesKBfcsGU06h9YLQCI485/9XfGM2cHlEGND+vbqUZ+L3Ulu@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKuKEBtpZMtvgFgl+FrmLZ4nujePKV7WEk2xZmQ+czajoM+jM
	4qhL4/zoYYlI5fHh3y6Zg3BWsiOMimdJxVXdVo5+YZrcN4hxZLp1HC2iuabL8PM=
X-Gm-Gg: ASbGnctj+KjhjJt+WH4VuqRvl/ULkouF7ZNUQIgs2cyFntEhY5r9EP0sNQUM/UtIeOS
	cUvqwhKdZpUbrq1LtixO2hdVAEOXjbv0X81p+QbRx0VOgJkkiQhDvmXkEmpMhEEYASjg+b6n4EU
	mk49DuHTSkdT82ztMy9iXhLfntGJ5EFyzayD4aRPcjuPFD/LrFUYLv2bhLd5Yx9OgKsxMabKb5T
	cNmDFtJfSMTwnOQyfLqDCzgpADmHK0+CBTH+DMg1GlSrNw=
X-Google-Smtp-Source: AGHT+IFvuzKQIZf1qkxZ4+Ci/Eeds3C/nB8ZqihF0Bnr/4C7RYL2k3LJsI5chnoI4Z2JG+UfbiRHQQ==
X-Received: by 2002:a17:902:e5c5:b0:216:393b:23d4 with SMTP id d9443c01a7336-21669f993b4mr7567455ad.11.1733753026559;
        Mon, 09 Dec 2024 06:03:46 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:03:45 -0800 (PST)
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
Subject: [PATCH net-next v5 2/5] rtnetlink: Lookup device in target netns when creating link
Date: Mon,  9 Dec 2024 22:01:48 +0800
Message-ID: <20241209140151.231257-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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
index ab5f201bf0ab..7855f81c917b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3851,20 +3851,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


