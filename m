Return-Path: <linux-kselftest+bounces-22338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E339D3774
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF406B23A2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0719DF4B;
	Wed, 20 Nov 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWTyx4ip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C022318;
	Wed, 20 Nov 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096286; cv=none; b=kfOhZCA1CpIf0TvxE8FOeDOGVOdFSvzg77xpnBsDWrDxloCcWzoYK/jSYA1CcPxWlMRSFmni3oyMJehwHwIJw0KqiRbEI3A/PPdkEA0iZIFP6AJBfyjhnhvQ96W0BLL4s/YlB/1yFbNcxJ4vn/yj02pK1sjtCW7EWRkW8cHYhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096286; c=relaxed/simple;
	bh=bdfVzDHS0RbRycCkztXr8m9XUd8atXqb0RSeP6dHbQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPOYIsnoIicGtHzU4PRcimyxOMVOjB+gMPD3TsUfpr1w93sjuW8XmBefb5jGqcckEBHfV/axOSBY2kqaBBV4wmVH6I655/nLZ7tgWT+A0b4ZL4WY2gc7wcQ94UA9/bRK4oTbjGiGKEl8oFv4jSteG+o0jZC+fXmtJ2uiItU2/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWTyx4ip; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea527ae14aso1428924a91.1;
        Wed, 20 Nov 2024 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732096284; x=1732701084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A07EaYUYVSyppCmn+wLYtsIPbMP3vR19wbpnU2pl6Qo=;
        b=DWTyx4ipI3x7LchB9k5UQpdTtwosEI9hODAkq1q03CQrqEQSBFv1TDMFgsN1o2fe35
         K9SNRgS7d+oNPxTJ2Ra4LLz+kyVKwLvczSOMgjq224P2+XTmyLpWwy37jGJDrUuWmz/F
         n76y4yYK00qP3rN+gSe5aIvVwbBeqoH8ABmaqZYxu73HdGTyT3rfDU3CqRpLfhSDKNcX
         wxlnWXC/ABPAO3fwa6DbhEhsVYt27LrHh5onujCkfbMGwcMWROS1dA+HMZ+ejFhITPCY
         WGCcIXV1jlsvk1DqMePhYmceSCv84BYRXZaT0gQjxANsaLnlRDgz51ZLklElLhdvEGMn
         oWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096284; x=1732701084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A07EaYUYVSyppCmn+wLYtsIPbMP3vR19wbpnU2pl6Qo=;
        b=Yz9LSWGONdud4Tgou4CgPl/ULh56uVAc2Y9dP7YUJrUZZqIcsijIJKz7GVKoz8It8E
         RrKZAMuy45EubrmqKGicpFHNl01zE4Lr1xEYoQY9u4+NdKaTlZEM5Pnkg4DdfN/Kjsf4
         IkjXMmEK5tOYtw+IjvLW0HRt+wXquAK8FBhBgPxM1iAZPVabPx0iLPz3Dos7s534cPa1
         Ig8K+9RX4xLIYSyCiSRIAxMCiQ4qVSFLd6ba1UvxTV/ggGCB9J6tlWqJrXzUFlYLUfYg
         SXqgSVA01TiLOLyefWBvRdwX3NeilVIFeUBG//kZGPhuPXhU1xqVNNkuiiYBPF3RZKJD
         zGlw==
X-Forwarded-Encrypted: i=1; AJvYcCVEtNYJaXyO5j0rJi+VGXhmTuSQfwrOxBf1cc9r/6GlAz73rIlXB0z/GUcFobtVbuKkG6+VDsdzgdbEmWDrOqgR@vger.kernel.org, AJvYcCW/NBzY6iuB/qSBtomQEqkI/25OuX4K1cpXkAeMj/Wi6CsT8y1+20BCfMyR/qmYuo81bOUiX8spOQR2/34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5mydTPlQfI78WrH6fkB1UbA8PAJRTGv5oLzw8ODQtF3xHkMS
	axTDTL4f9Qb3lvLL4MvGYxYxuP6hMsFnfdl0t7RxeuavFFAhWtccX1g/CVK+rNY=
X-Gm-Gg: ASbGncsaVR1D9+0Q6T6NzLPGx6qQtXbrcFY5V3+WZEeGcBgcUcUx00mI6sCoq6TSKcc
	vUXDdqHNELPoobcJB42HHyNZTOSYPlzUlXdgw03qXoz/XF8U1iMFbKfA6hrtZf1nGPD4u+PKQ7F
	sS69gdEExBmW2pB/uLR8ixetfu8f1iqPETFrTwF0uOBRzjAqaVMcr3LUy0FRimRnyKTx2PKLB2+
	AgTpOA3haBQY3Kcfqk6tVSjjkxSILWrk44Q/RVN2NCgwFh/UWW+eGecMzd+Riuh08hkGA==
X-Google-Smtp-Source: AGHT+IFepS+mMuTupRIh49Vx6oHoS69KSVeOFuVhduZ5zU6H1V56K/wHcjw/DeARYcqm82+rVERmlw==
X-Received: by 2002:a17:90b:3c48:b0:2ea:95ac:54c6 with SMTP id 98e67ed59e1d1-2eaca74e933mr2131364a91.21.1732096284188;
        Wed, 20 Nov 2024 01:51:24 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de5bbsm887338a91.36.2024.11.20.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:51:23 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 1/2] net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged
Date: Wed, 20 Nov 2024 09:51:07 +0000
Message-ID: <20241120095108.199779-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241120095108.199779-1-liuhangbin@gmail.com>
References: <20241120095108.199779-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RFC8981 section 3.4 says that existing temporary addresses must have their
lifetimes adjusted so that no temporary addresses should ever remain "valid"
or "preferred" longer than the incoming SLAAC Prefix Information. This would
strongly imply in Linux's case that if the "mngtmpaddr" address is deleted or
un-flagged as such, its corresponding temporary addresses must be cleared out
right away.

But now the temporary address is renewed even after ‘mngtmpaddr’ is removed
or becomes unmanaged as manage_tempaddrs() set temporary addresses
prefered/valid time to 0, and later in addrconf_verify_rtnl() all checkings
failed to remove the addresses. Fix this by deleting the temporary address
directly for these situations.

Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/addrconf.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac52884..01115e1a34cb 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2570,6 +2570,24 @@ static struct inet6_dev *addrconf_add_dev(struct net_device *dev)
 	return idev;
 }
 
+static void delete_tempaddrs(struct inet6_dev *idev,
+			     struct inet6_ifaddr *ifp)
+{
+	struct inet6_ifaddr *ift, *tmp;
+
+	write_lock_bh(&idev->lock);
+	list_for_each_entry_safe(ift, tmp, &idev->tempaddr_list, tmp_list) {
+		if (ift->ifpub != ifp)
+			continue;
+
+		in6_ifa_hold(ift);
+		write_unlock_bh(&idev->lock);
+		ipv6_del_addr(ift);
+		write_lock_bh(&idev->lock);
+	}
+	write_unlock_bh(&idev->lock);
+}
+
 static void manage_tempaddrs(struct inet6_dev *idev,
 			     struct inet6_ifaddr *ifp,
 			     __u32 valid_lft, __u32 prefered_lft,
@@ -3124,11 +3142,12 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 			in6_ifa_hold(ifp);
 			read_unlock_bh(&idev->lock);
 
-			if (!(ifp->flags & IFA_F_TEMPORARY) &&
-			    (ifa_flags & IFA_F_MANAGETEMPADDR))
-				manage_tempaddrs(idev, ifp, 0, 0, false,
-						 jiffies);
 			ipv6_del_addr(ifp);
+
+			if (!(ifp->flags & IFA_F_TEMPORARY) &&
+			    (ifp->flags & IFA_F_MANAGETEMPADDR))
+				delete_tempaddrs(idev, ifp);
+
 			addrconf_verify_rtnl(net);
 			if (ipv6_addr_is_multicast(pfx)) {
 				ipv6_mc_config(net->ipv6.mc_autojoin_sk,
@@ -4952,14 +4971,12 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 	}
 
 	if (was_managetempaddr || ifp->flags & IFA_F_MANAGETEMPADDR) {
-		if (was_managetempaddr &&
-		    !(ifp->flags & IFA_F_MANAGETEMPADDR)) {
-			cfg->valid_lft = 0;
-			cfg->preferred_lft = 0;
-		}
-		manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
-				 cfg->preferred_lft, !was_managetempaddr,
-				 jiffies);
+		if (was_managetempaddr && !(ifp->flags & IFA_F_MANAGETEMPADDR))
+			delete_tempaddrs(ifp->idev, ifp);
+		else
+			manage_tempaddrs(ifp->idev, ifp, cfg->valid_lft,
+					 cfg->preferred_lft, !was_managetempaddr,
+					 jiffies);
 	}
 
 	addrconf_verify_rtnl(net);
-- 
2.46.0


