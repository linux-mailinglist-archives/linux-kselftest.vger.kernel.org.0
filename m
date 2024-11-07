Return-Path: <linux-kselftest+bounces-21604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFB9C077B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57AEB211F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA7212624;
	Thu,  7 Nov 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arF1gN7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA3212169;
	Thu,  7 Nov 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986234; cv=none; b=ZazzXxKv9cT8Zm3YJeo8WqtGWE6OlImBQ5obr6g0qW7Li7ohY5Xm5mlZdjivGc9wuyqn9FNFRdVV2Bsw42oNwEaI/XBOMCDjZbu1b7Lq4+77EPDX8dWaPfFNzXy2gZ6Qxv3I9KeRnpipOusb1sqCSs+r2v0NBIqdPhdVEYSe6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986234; c=relaxed/simple;
	bh=520bY/0sRcY76U5JvV7+YiGmAQmexLctQ/6aOXCbZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTSNbL9DQSf/2bo/8wra699Gq2CtsHSVjsc0M6CSPYVSG7oryAqPt1kPQkY1aPvvh9Uxt6bd5p5TxdWlqjqpZGrt7gFgIqz9XyKSXCClGayEn1LjYLqegalQgEE+jGlAHJZW5/r7XLWYthfEcRMs/LkJ//iImizsr6dIifrHn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arF1gN7Y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e681bc315so733739b3a.0;
        Thu, 07 Nov 2024 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986232; x=1731591032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+eXRMVMKQHzq/AF94296l6CIgMBceDx8WLjFZJpjK0=;
        b=arF1gN7Ydv+vekmSbux6C0CXBIVnS6FO36GX+eiHlH+5bUzn69m8/J1V81x8JIE+rn
         NzFml4RD9EqQeU7PAQaKuSqQ3JEzCTVswKac1pUnt4BVPEQR0Cqqdr1wM2Xif7vph5Pz
         4Gx9OrllZxvxjqW5TTVmzFt0orAnVNXKu5VEZSKDVJVJnuyZ5GvEVbwOhhrxF2/wgsfF
         ZcmQsPEzGKWjQlD6u1ikfKNsu8nIvtLRBk1uxR12fTJlDPiaKjHr8xgBMFqmgCQt0Qvt
         Kq+OocqK9udbg9awlWVEk2S+4R0vyXAUcjna/iElnBSyk1okss+xqzWgeQ2WbzC8tapb
         cyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986232; x=1731591032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+eXRMVMKQHzq/AF94296l6CIgMBceDx8WLjFZJpjK0=;
        b=LngZjta9xciuO+rGXPLtd6aLp0/OpJPeZWU21pSJieYAXJD9MHlhlR+WzCfSLBzeE2
         aSQw3p+cM4TJEUYbcD6B6WQJVtr4K85mIupFbO3nOTnTYFAjAiKgJC8KJKXUrvdrA4EB
         Gila5HeyXjw7QQuQB/MQKXFID/+rfZEMiMv56RNoyYjvq8jAkTXsNbrIwhsUrkypibdY
         46ox272QtbFbT+SBFIBrg/KTbZRGD6lAPbW3z3ayZEpj1KtgLyPXOzvD6R2SVHSS9i8r
         yKEr4Rjk3RplUdtxI3orf61QEOpSlr3pj8rmDglVV4DCD5AGQQYso41SdljpbNGxZS3W
         dBmw==
X-Forwarded-Encrypted: i=1; AJvYcCWUEFzxyS74lEuTpETDW46nZA3yhpdoiACoQFkMk2cesRUjS80EZp8eOOGZ1tbi01ZMx0Kc7xo2R6/mEqox9SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4CcmKoTblbZMNQv1NeGd90DdMXZ3THXkBJ8Xw9oYORMd5l6p
	DfBIyAA3JaHP24BT5jpOV2MHEfUQHaiKfeTj39mR66Afm13L4g0OGav2xiHf4lA=
X-Google-Smtp-Source: AGHT+IHgbzYKY4bYk17LRWp95QI+OGcqsTdZmhi9h9N4vnyexBNReFmxgROSUY8O9vFH/PXJmsD/kg==
X-Received: by 2002:a05:6a00:194a:b0:71e:4dc5:259a with SMTP id d2e1a72fcca58-72410d18c9emr5644b3a.7.1730986230418;
        Thu, 07 Nov 2024 05:30:30 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 2/8] rtnetlink: Add netns_atomic flag in rtnl_link_ops
Date: Thu,  7 Nov 2024 21:29:57 +0800
Message-ID: <20241107133004.7469-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107133004.7469-1-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently these two steps are needed to create a net device with
IFLA_LINK_NETNSID attr:

 1. create and setup the netdev in the link netns with
    rtnl_create_link()
 2. move it to the target netns with dev_change_net_namespace()

This has some side effects, including extra ifindex allocation, ifname
validation and link notifications in link netns.

Add a netns_atomic flag, that if set to true, devices will be created in
the target netns directly.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 3 +++
 net/core/rtnetlink.c    | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b260c0cc9671..7e78f3952774 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -75,6 +75,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
+ *	@netns_atomic: Device can be created in target netns even when
+ *		       link-netns is different, avoiding netns change.
  *	@maxtype: Highest device specific netlink attribute number
  *	@policy: Netlink policy for device specific attribute validation
  *	@validate: Optional validation function for netlink/changelink parameters
@@ -116,6 +118,7 @@ struct rtnl_link_ops {
 	void			(*setup)(struct net_device *dev);
 
 	bool			netns_refund;
+	bool			netns_atomic;
 	unsigned int		maxtype;
 	const struct nla_policy	*policy;
 	int			(*validate)(struct nlattr *tb[],
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8119f4ad9e5f..b0d1cbb44a03 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3690,8 +3690,9 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(!link_net || ops->netns_atomic ?
+			       tgt_net : link_net, ifname, name_assign_type,
+			       ops, tb, extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3711,7 +3712,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
+	if (link_net && !ops->netns_atomic) {
 		err = dev_change_net_namespace(dev, tgt_net, ifname);
 		if (err < 0)
 			goto out_unregister;
-- 
2.47.0


