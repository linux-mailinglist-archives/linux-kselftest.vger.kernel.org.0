Return-Path: <linux-kselftest+bounces-23910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80126A014C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365E616040E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824811D2F54;
	Sat,  4 Jan 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9tPAQXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6D1BCA11;
	Sat,  4 Jan 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995543; cv=none; b=Ecrptg2gkH9RLemoRWU3BRxCeWI1DUUE4Ns/1e9q1n6XBT1GNHN7MnxnegQ3b+6Gbu7nq0zwD3a5OXXC8rc+mcW3PGnKz+fpRYiu9KKMp+NtjYFzJrg5DXHdhePjRe0Vkn2xavICS00SgnIfu512PgrZ9k8kTM5kMtiv00Wrk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995543; c=relaxed/simple;
	bh=W6Jch7g8Z9mySu+CSy86wpVopsPfVKuW30huqFSsC+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2Id47PWKqP7RhZXsiTTQ1gvzhGfaGuqAY+ahYvmf+bRonTscHA6udah375lyQOet7g5vaVcxkSjBom3igjOG2BT45Skr9I671EroSBEY1zrbeYDNr3n/2qVeqZSnBDfIYnPV9TR/t3Wu/ZZuHTOWL5a3TFYRUTsIzWDEdEE/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9tPAQXj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216728b1836so164392835ad.0;
        Sat, 04 Jan 2025 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995539; x=1736600339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=a9tPAQXjtWHArZwzYeXWVce8opQF7UV1kWl2kbDaf3lP86bAsnXzqrAreaHBSyc79b
         1XB/L8SYCqSrt1QLGsGkpnd14Yy52Vq7ig2d9zi3ABvzWBW0MWGMsMldI+/Sbug7EDMh
         GmtpjvMM/lSwi2yF/gm0iBn/n9cUyPhtuuQuBL397gjTGuYdVPjYCqsMPg+U9dpNCXgb
         MJoHJVxhliaXqZC1RFhB5oTnKZ/TCohaZ6Z+GEXnXumqtY7bttwpsElJvHM8ECc61pYF
         SH6lE9de9JMhojeeOU/LRpjPX+90C6DWPEXvZ6LZiprKZz9CsW3OJgjtAOnq7MNCPVWo
         tBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995539; x=1736600339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=d/1zyiUcmGzuw6kYALVpw9ADU7pjsMroMTjrqQ93WwZBnM6+dQtJwXUNlZpj8MR9KJ
         9N1052cKwtG/FnzkNldeLPxBXEi/HrT0vKeRuRHJrYvXThfzGd3ghYROVVFFNwF6LLQu
         E7S4ezM1qYr58llEumls5EL7mzWhOanfFpWGEa5J/YV4fHlI2oA/UB2KnyiUbEDmB9oT
         11bPcu9BKqIkfeCU2qbZ1LNXemny5YlisXNXWqvSKynH6GRxBk+SDLF4Fsk64znIHSOd
         cewFH8dobRiDde6CqcQx2iLkMB1uMsZJuxOivDWqu4yPOkqW9RksF8A9WZfkKhJKpgCy
         V1yw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcJwBWc9Z+NgFuKOrKw+LLTnyTrQLAttCFdANk3pjpHDpDAVNaUumsf0e7LK6psyAdBlu2YzagUfQ@vger.kernel.org, AJvYcCVwWwT7gvA5yWGVWL/6dq8Hrs9+IZGaD5Y1m4tldb2MCqXnPGcBskGuv7gzGn2xBqLGizuY7vqpvx78BC37@vger.kernel.org, AJvYcCWYZ4/MqmHiRnzpQxhFWTQk+i9AN3XnHthRuqhcvFarjTJagwlphkWU5PQmuRy9A+o7m56W8s1dxK6mU4BrX7M=@vger.kernel.org, AJvYcCWdj6EHwfWmVipDOuXRjqePqTNWZRpukW3nwAnVeSIGcOlQwoBvVshC4Sc9LeZr4uW+kd4FA5r5BJdbYA==@vger.kernel.org, AJvYcCX31wvKcTAVCir0BVLLsC3aDQwAM0wBZA6Cou6PlcHqs1DryXyPXV+J+jPtYyruHHWg4zKTLjYi+2NEiV0croET@vger.kernel.org, AJvYcCXHmAdXsUgr65lNgue3kK5dc/YNMhsvGv5bZzUgyqEOJcoMpmbHqt92osQqq90WhooQDOdycCuR0Il3PQ==@vger.kernel.org, AJvYcCXK/Bm9RGmPQr79LHNBUEcHmZuXQ5uWdPowWhW44JOohTQ98VqkqqZ/e2Xw1aVzaUfwkMI=@vger.kernel.org, AJvYcCXlypk/83xonJJHcktzP2kxOa/PwMAQ0k2fm5Kt//3Ot5T0MJ2QWl1PbVl5ASG91RRH3bnKHQSCZ7pt@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJBSpFhw29NdhBZl6gLNxmFptyqWWzxQYndjuAtARWAwf/K7V
	mFPrv8paP3c0Y4ucz/+1c0X6toW4LviOMLusMdHWqKYFIOlDLfkND79dGt9RU+E=
X-Gm-Gg: ASbGncuZ1eb5C3N45VeerLkzqDiSDESYPcNnI6GB83z5inpk3REU/qWNyrDd3czUvrI
	SrnLVbc5qaMynC3St+WEafzIdatix6ci3AZMVTbYZKQ2T65LPlo42zNAjpVH5Okv6vuHgOOvZ2S
	pssJne0fHlPN8ZoPrIFMEIcQ1HjUurpNY3vv2wgK9J8oVc/0GhfXi67x1z4dtF7t/jBhfSdxeb9
	HJ1/GnAlcyneEr9jpSvTcPSv4wnvqlJYdFkPYVbmXxslFI=
X-Google-Smtp-Source: AGHT+IHLCiFk9BrspEkmn14rTTpjbLwBW8SdPWZM+0IkwauKRrd0EY+n9DzEaoNgd6USL3r4X9FuKw==
X-Received: by 2002:a05:6a21:99a4:b0:1e0:e027:2eaf with SMTP id adf61e73a8af0-1e5e048adf7mr83019375637.19.1735995539121;
        Sat, 04 Jan 2025 04:58:59 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:58 -0800 (PST)
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
Subject: [PATCH net-next v7 09/11] rtnetlink: Create link directly in target net namespace
Date: Sat,  4 Jan 2025 20:57:30 +0800
Message-ID: <20250104125732.17335-10-shaw.leon@gmail.com>
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
index a2246bbaf2bc..e8126007eb00 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
2.47.1


