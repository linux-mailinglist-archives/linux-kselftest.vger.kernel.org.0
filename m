Return-Path: <linux-kselftest+bounces-48138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B24CF134A
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C42C530010CF
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB42D97BF;
	Sun,  4 Jan 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtckQmtq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACF30FC27
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552116; cv=none; b=J5akhRZJVZ2RBQqPFvj4jnZQCsBOMyRwuFWQ8PwdqkxzctR6Tv/2DljhTpjrX6TDpSL5Ige64a36EEcNlNYS23T9HOTttF+AyF+8bLsa6sFp9KeV31DUISpHnWZ9XDTS9Q/xj/oD+bVFkzhvccCtJOv+OGCng/0ho2NtkiIFOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552116; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP5vx1ug/BvgdCIaKdeRH1TYg8wiMXBKqsii/+Ur8rAaEdIIuMTN7RMUbcKcL8W3Mm4lyksreDdvkK6wW+hhFFw8HAr5eiZSpO2bxJ3fpXOAKBcmtwXKWYLwsMurWByItrAHO7jwFJIp9XFDaTejMi2QIJmqb7yolfMGGeRm6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtckQmtq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d52768ccso166613455ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552113; x=1768156913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=jtckQmtq+Z0flE/4z9TctNvX9W9LWLunJWaNZjTtukk+oNHZfnwiUiDy8aFq1Lodin
         abW8vXQwIBx/6IFCeqO73GdkEWfdna1tto32eniSu50sS3b3UG/+bARuvPrCeoWFEZIZ
         /TByR3xbQvRIbejFJ734q5VpyY+OLVgGK72IXQYHNJOKfF61THsLN2RCJwwX4+oLqidD
         5lqU76x4TVbqVhAtH9j1CIpY5IfdSkzeVpvrkE9GIWmyKvkFXotcyeJUolpdNwPSndDf
         qozu1y5wZtwQ0JYZXVJjVGRNwzoQNO9Ht3FkmSQAB1sIvUM289+WrPKr9ikvapI0GXiN
         uRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552113; x=1768156913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=ePyoSSMrVkjrYsoOk2tuWEjQ/JoavsqyhPyD7Kvd22pV5RvdgeGIZptUabz6iMivvN
         BH9Kn/sFUvigDiyawzCQKFy2QtjAR1CZwHqdDHL7Qw0NMNDSTHPzWNRLyP1gSc/QPPWZ
         PU+w0uIBLhUzp1CkRuV2enSOj0XI02gf8hWrmyQXmvpkCWE7JQMb3OP9M49jTAdRcuhJ
         fkhn1+nnJ2R2GN3EM6UUAMvUtllNM0mZCUt7Lx7rjm3Zeu06UDJ+5jxgW9d/77V7FMSj
         rgLROa8dnka8+wzMp5MyB/S8driUS7zVQ7UPEIhjgArBEIipL1jfXKt6TjllUnV7zDiW
         GZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCU4/99ngR/1hqeO8c/W2n64daJ0b5A0zSOUxcnyraeQpjEKIDzwZxT91bdPnibY4/O9No5Kc4bLDELh3TWIXw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/qdPSeaH52pArXLSyHqX5VWW8lB/tACClkbz8403MvtKtgDC
	qTrq4csvcvnKeF6w3istt7dAbANjlRezes0iVLsF7mC5N7Q+u9V3oKn4
X-Gm-Gg: AY/fxX4JSDhSJ9pIGQ6QplIyX9unk2ybZyFfMaLHKujzUzCOts/NOI34XDok6qOC6Bh
	7SMh9CtXOhXF65A4azRnQH7umnHeDSgyTyr3nkinhFmFSSeYmIeFWuXaWGDoMuy+pYNXuDZDxVq
	BxGf0T+ivBF1Ih267sJfXc4ENtxXDl3J63grraSEgGdGshkoHQ4WwggBGZ7jq+sbG0LuDG1nGyD
	N97i/rbJ4iDq+kYFvd7CMRIRBMvyhergP4K02wJwrcvKcZDZPau+aEN5mX89A1unT7ev/XYH93Y
	wPzXG6KVhDf3r6nZGGDE5k3/ik1IebIvU/3E5IcC+p6roCgyeZ5ssLGT9yb6FaJDaddlbtyB2CB
	SDEToP24IRmD5Vzn14pxR+0burTL2dq23GMQ9EaxHedykaPyzVsg0d8M156h24s74PB320r0uOJ
	BdmC0Pgw/3FaJAZuAX
X-Google-Smtp-Source: AGHT+IEQqPsuEeqSwJnEmQG6HRSkHTjK4rOFxwa+Org4QKZJRNkBh+LEQ9iqbFn0O6b3i5bQUEEUxw==
X-Received: by 2002:a05:7022:f307:b0:11d:ef84:6cff with SMTP id a92af1059eb24-12172308947mr41968866c88.37.1767552113327;
        Sun, 04 Jan 2026 10:41:53 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:52 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:13 +0000
Subject: [PATCH net-next v9 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-3-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=9BWcXu9Fg7r9j3L7E5V0TBCP14D0o6QF69OAWDX50MoYWCkS/CfIzLkCaOhni/6GXsEDKlWxP
 g+k4/TDEhnfCR/UNaLWnaqv7wSY6dpVpZqpB15KHJCnGq5BdslcaI/M
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


