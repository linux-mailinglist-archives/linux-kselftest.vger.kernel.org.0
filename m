Return-Path: <linux-kselftest+bounces-21923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0A9C6FC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010AD2862B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DF201024;
	Wed, 13 Nov 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkwosjhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CF201022;
	Wed, 13 Nov 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502328; cv=none; b=cmU7cMNmI/8IZ00DDfolEn/XXBt/UgjKdXKgeMy0VzyjT3VonLnJ6Uecy8XHA+/IYqgz0h7d/wQfsnlvWXa44AOsdBqtF751JoRvX/Vg/Dx+LDCWHCp6aNMdQS3Jml9dQZjYN4kc88Zm2TanfGdY5iDavfrKfu05kY8AOh4naiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502328; c=relaxed/simple;
	bh=wXPMfk4R4lN+fsFTHmCqEuZRii5imvxepYxDIbkqZCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFMDZ5/aDdm4kxRs7jOdOaN5Lp7TXkCy27TScuCuPKZ8/k9AVXOfldlcwq6FDXLL8ZgLkWu9DL+jzGX9xIACVkfdMeeDPemZVnZzy6ChuQ4dqvUm/KZg7ZCx3ECdoV9lYHXI3On2/vFL6tYDem5fgPyHGBWtZBemjZXPgFY83zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkwosjhf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdb889222so67959275ad.3;
        Wed, 13 Nov 2024 04:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502325; x=1732107125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d82L2SdWhBMpOjB96IbZ0ZbezId4gnZTN7mnyHKj4b4=;
        b=DkwosjhfphAM1MkeSZHkpnAiguGas33WlAjb7ARrZ2bbZOIb3iui/ywKR8/bQ2Yf6I
         lRB1RHk1Pab6+9ya4mAinj4CfUJiisemiddYXoUJ02rl5uKdTxgBcvc6X2waedDz5WBd
         oLNW9jZ9omiOa1TBXj4MZr/i0rybqsagYrWHZrh/45k8KRHkosmaF5y0Oeyofkd1bYun
         10d8qRn1lQAxZvueFXAslhW3o43wPe5R32w50LZrZAtIfl334wK42nGRh83bzht/aX0A
         +GDsTWPekV8OnLYWYvkN47k+C5fe4944wFoBF8cxiqzV3u4JDF+DvQLc/EssS1ZYOXrT
         2L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502325; x=1732107125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d82L2SdWhBMpOjB96IbZ0ZbezId4gnZTN7mnyHKj4b4=;
        b=Zm2VYJn+/co3+xJ1QnnCCt7AObTBuzRdvG9KFAsHByQJtL6z1QILwcVc4NWAXF5Qc/
         2log13gCK4DE28dvNDLuvh1vYGA91X8bfbDC7zhnsG688ILD8AP1arnAH3tjGGte3dtT
         rN/DOn+xAibIRGHmq9IauAdw3rdaP2uRva2kofYAReOs3yH9lkOUc/vZVVDtsViQww/C
         +L/ZG8J2ev13SyHarQbd0AcmalzGxCRDqLpUj9MDHBYWnXvuED1zSPZvZRyPQER1VHEY
         qIzPj3F1GR5sbuCx64Br+xIKb+1B0VbaaA7t9Fdyzm4V1NdNfiM2b3n7fYWAe8euZ01X
         dMzg==
X-Forwarded-Encrypted: i=1; AJvYcCV4t4SZeMUr4shNIraOiEZYQH3o7uDJVSgvsCPkf19tp12xRTRhUJCAJSWO2J1YWfjO+3pdcmIa9PThutV4U0UM@vger.kernel.org, AJvYcCW1OVwARR0CurVwxv03Nu8wEmZZlzVa3LUA2uZ0tm15Qicv5lD1qXAxK2Rl/u6V87XftRLR/6RrnY/z3aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8L6JKffEXJBeGuXkkusXoDk2lqXf6N3gK/T36c1/FKpJCpbaM
	pJjiy0LM3Dm0//6syZAXiY+jJ7X3Ar4LDr5WXVyb8LKMXXL1JSOikdXoQVuKxY/MBw==
X-Google-Smtp-Source: AGHT+IG46DaaLV6bSnoaWxiVbMQ7/nWpHKTmHrUv79u+WFof17So49wSTLYzAuL+ual5OHRS1yMtgQ==
X-Received: by 2002:a17:902:f607:b0:211:81a7:fa95 with SMTP id d9443c01a7336-211b5d5cf37mr27238935ad.51.1731502325441;
        Wed, 13 Nov 2024 04:52:05 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177cfb0ecsm109276345ad.0.2024.11.13.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:52:04 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr is removed or un-mngtmpaddr
Date: Wed, 13 Nov 2024 12:51:51 +0000
Message-ID: <20241113125152.752778-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241113125152.752778-1-liuhangbin@gmail.com>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
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
or becomes unmanaged. Fix this by deleting the temporary address with this
situation.

Fixes: 778964f2fdf0 ("ipv6/addrconf: fix timing bug in tempaddr regen")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/addrconf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac52884..6852dbce5a7d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4644,6 +4644,10 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
+				if ((!ifp->valid_lft && !ifp->prefered_lft) ||
+				    ifp->ifpub->state == INET6_IFADDR_STATE_DEAD)
+					goto delete_ifp;
+
 				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
 				if (age + regen_advance >= ifp->prefered_lft) {
@@ -4671,6 +4675,7 @@ static void addrconf_verify_rtnl(struct net *net)
 
 			if (ifp->valid_lft != INFINITY_LIFE_TIME &&
 			    age >= ifp->valid_lft) {
+delete_ifp:
 				spin_unlock(&ifp->lock);
 				in6_ifa_hold(ifp);
 				rcu_read_unlock_bh();
-- 
2.46.0


