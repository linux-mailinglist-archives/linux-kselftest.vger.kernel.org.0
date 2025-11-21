Return-Path: <linux-kselftest+bounces-46227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731EC79101
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19853350360
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21FA32039B;
	Fri, 21 Nov 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/FulqFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1C302158
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729376; cv=none; b=Zv9mmicikz8+ylmmeEn2GhwQ4Xh18HuoTjAX3ST/eZeubgvNvtfpkZyrDirDMZm+XaUYzVXW02E9btr0rf+A7thByWOCSn6sHCEdqhQIVNHa2lzequQg2rI1t+mg7OXokcRqzerKFzU0cWAi1nU1urUcsjdDVpWuPOxaUQipRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729376; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2yF8toq+IeE2PpmjmKFHJXjbzNsdmudZ6r+dFLzM4urOuK3xeONVOoN1pZIagTDoilvOUXB+byOE6K4b37REZazt6gTotOQwAHo6HNZvgF4vK6IGOIl8SDMBuXkQSUepXT+LNdrmXvAqcTibwADtd6wOKUnVGVvjeUcFRkbZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/FulqFM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29558061c68so26428885ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729373; x=1764334173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=T/FulqFMD4RkJ8LEIhvIFbMjsEgbbCMtjeAWXHQTg2boHHy2v7YXbJBXQ+DQiAE/Fy
         efV2gv/VF2t9407tqcGVphyYQgt/GTxXP/9Rk71WCBaCXLl3+c2Xnw4p6ufwXYhcSuh0
         Xm8PMcmjzxsmoRTlLVAnt2/VMjriXa2Kx87nOwa8dGPPnmECp91B1PmX5Oh9XyUjLAJr
         ue13kdTPi6NUN2kYPEfU5/ZWrZv29J7sxQIdzUmk7vZmlitHWr63TIYxFYVw7fF6QwBc
         myF51NMyKQJkA+XiP1QE3xiIN104iGeN5HbqeUva5+49chY6z7skduj6LHRky0ED+5hJ
         FiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729373; x=1764334173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=rf7nDLNAkMNf0+5a8hIqZX7H9kbG+mOwmANefTI2yTZXCPrpCgbnZMnZpROGZ7qd1E
         iePFfvlqe8NYNmrmULQzySElzSkpNDsES4zoZrzeoGr0c9GCX+S/8R2glx9dpMZQVeT5
         pYUuJKX2hTNT7xj/5HD/rdmJ2gryMl4cDWfvx2CDsmGoB3sJp51iZ0nkfS8zhJnPBlqg
         rVJAzsobYA3w6TuVaISoMnVAmzIUbnapk4/Ds1GHWru7bVP34XkeaPLZDakxF7z4/eKD
         nTdloMX3e16RcvlFXbqh6j6I0qPxPcvsnbn7K+in934PCEqgwUu8qUYdWzurM9vUCZ75
         dBmw==
X-Forwarded-Encrypted: i=1; AJvYcCW7JVHPYqyChNnAoVdBxIoBHd5ZKUr4hagRMZGHdwZDj4fthmHffCNfVCRIpD/OSbI5wOp3nqXEsMBu1xC6cMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzblICAGMgykUOoXTqSqGD9++rx5GPTE3yR77ZP5DAG1wYZfE
	ilZPu5udMwBNCzqZORUBnA8iJEAJJJ//X/29cME9gSkFuureZx6Y1qhb
X-Gm-Gg: ASbGncsUOqu1wyXFc4n0CYyUKSOqOBdldT/jHRPSSz6kd564fEj7DtDDVN4GD6xIDZ4
	RFfIdH25ZIBGe1PHGDUpaVBXGVEkHI2wjXGfKJDeANOUvsp7jjy2Dv7O/SaVoxGX0W6LgNJB1aO
	mzMBGe/8eTpvmeq91JAMoGP5NjEYv1Xrrt/IKL+ddsMQwK+qJ67bm6g+QqyT4elR1aHsJ00dDfo
	41SXP+rnx389i8JnmZVHnHIc/x1vw+HE+B19BelM6mAsVYhQvCADWZET9r4pBHzU6Y3F37qhgDg
	S34CyO8buIQi1oKl+0JPGG4c1HGdrr9F4mYjK6y9igxSfuMP18ugBiRHEqLHcm2tLs79hFrbdwt
	gwrDFSd19r3W06kXKDopEayyqc4UhyAXjL6t3t1/RLZf8+v49XGUPbqocvJr9iBV5Ke4L5OWBY0
	oT/NNpvzFyk0H8MC0b
X-Google-Smtp-Source: AGHT+IGjQY393wbPoRfTrgThZUbRXZ8/OuQlRpf2ILVHZvNAbrSjcZJduZN+Y2ALKisyM9NoH+L+Vg==
X-Received: by 2002:a17:902:ccce:b0:297:dd30:8f07 with SMTP id d9443c01a7336-29b6bf806bcmr29078625ad.50.1763729372688;
        Fri, 21 Nov 2025 04:49:32 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:32 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:02 +0000
Subject: [PATCH net-next v6 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-3-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=mUF4xs6Q425NCVpPCEL2wiPv3fqPZv2HRqxhVxxflU19F4YinKcf+E/B/ctw676dwZSgMMBni
 b80Fvf7Oud1BObj0an3VZA1S+MxE8rbrVuQ8R3OelHwa1uezyuAywYT
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


