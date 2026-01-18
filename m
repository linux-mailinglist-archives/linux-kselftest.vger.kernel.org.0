Return-Path: <linux-kselftest+bounces-49255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD7DD39455
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17EDF3015587
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CB2D5922;
	Sun, 18 Jan 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM6xEzUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683332B982
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734033; cv=none; b=P41qJud3X5Jz2VmLgjUowN5XYr/4o1+osPnkmL6CQk6CYgTnpfRJ5mgn7mI7mmLQFyP5WuFixVLW52qX7b9MtDlSHCyV4JSrGQi95EZaZQNvu7sNDg0gFYo4nqyGJS7hAaZGvNTL0idb3lKjN0Qk4IKtY8UTYNvHYdjxePWUbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734033; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXnZHfyv3DuEFHL0XK2zH5kSxnMjkNGSeFUdzQg5kiQ4jGfzv0o/kzq4ODZeU3FZFcJVI168poHJC3NdEOiz2yE7KRfdDu4u9Exe3HEib0z1Q/FaG6R4/jweoryqMgtB87uRA6aokS6L4SrufP7WioTAvhcVTJ5DuWkGW1Vike4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM6xEzUr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edffe5540so30719355e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734030; x=1769338830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=ZM6xEzUrJlnixDJMgVzB0RlaEAtNQNqH5SfVkeIQEauMxckLI/TBKtHBnpuff55nnR
         Qfmk47OrfmbJOlfBU+m2KUiJtiI3FDPAkWsKsGa8DnEuFF599MdIf4ZtHFi3AAGRjv/x
         BpG789CWMVFeDXo7P3mALGDwQp4u8h4NOFqdcclPAncfwOLdWdVh3Nhr9B0JM1DfF/kQ
         AbIUtIKq4zL3U1kLQuFruCJLCb1pEGzDDtZKWFrv0kSidyFsmfThvScE80Auz7FlKlPH
         cckli9Xk8oduWAfjRFJPO/AhERzVETjQEOOJk88n+IhYJ03uxhSa4BRjv6vcDialNYL4
         xkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734030; x=1769338830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=igLnwygvnInFsc9tfL4mt1ywF/XZWV3ilYIkNuViGAoyvRFwJ2sHfYb+yiR8pQddTx
         JdJyUO2Tjl9OvVLODpABygkntHdX1MLg+CCZSpsYVCgx3QcZhzFm+JXFqCr6K4z1iF68
         MyvlOsBiumDnpZRWDvSe2UNRtsJlCaUwinMtfVhlpVnfRvtN7FkU0ST56hzmNGp812f8
         DtgoMOTEgfpsz3Hhp7nXwTXbI5pgrk8VQKCK5NvJYC5pMv53NYCq9IXrxnyc6aZRmHyj
         GP4g1LtDph4gwX8styIMNS8uIAL/CigwCA4gBCtRsZFd6Fo+EJTeSCpFCQvPv1eWRyHM
         ZdLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+i7i9ZDhr4EM3AAyebUSTSbl8EUPEC70FzlY0dLvojqmWZGWd6v9pGBO8wrhZkrvprrtzlpN/q9HWpxLx/P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3JNFKWSDYAQd9hxblrW7vnQbk1nnFCTLrTw+8sL9azDmZdi+
	yNIbwGtclGFHsDNZrFjd7XbddIfO60m93U99vPUjHj36DzQOIrQ9+5UV
X-Gm-Gg: AY/fxX5SJwtIP0WiJRPZ0Soyk2LlpTWCS/dbL5V+8W3avBNXTunpNNFkwI5IQ8PS4YE
	WGSG7D8tHuPF9n+bJyZJ1ROjn9bGSpCzDvNJg55bHXo+Z8o8oUSNyYLVsHq0xDZIFyXXEGF1DJ+
	xF1bdZa67fWeWQy5aKyy3WBz5ZHqvv9EQGmBER7GlzW21nCm1vr9jP/+PYmHOfvepOnMJ8zJrG5
	CilBuHUG6lWTlq8XvsDNwkC7B+cIVG4s0ykx1Uu1/n/o5daOGMeCrdWasX6xKDvzhE3Sikz6qXS
	2H+GZLNsdxgXBVwdhJBhvQF9JdkqecQWnx2mkp0wqz1dnJUl245dTlc+1LhOj67n7Oem0ZmlElw
	vGmKAsc1KNylISQQ1whFNzQM4YUZuITKT4X/x3uFjKiThPn/UYkwSpDAcGXLwnVklo4+CNdCNWP
	Ef0F1Yhqe5mtR1fw==
X-Received: by 2002:a05:600c:4448:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-4801e2fdd54mr95040255e9.6.1768734029915;
        Sun, 18 Jan 2026 03:00:29 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:29 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:23 +0000
Subject: [PATCH net-next v11 3/7] netconsole: add STATE_DEACTIVATED to
 track targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-3-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=w47Bv0mJSq0H++87nzW6h5KMtb3quL1YV8R5bcPQBf+b6qibDRwH/Xr8ZeczEx6pVS526X8qp
 lrjJUKt/nNBD6Mn65spkAIhk/Po4No1vvdD2+IQ7ZEqu04Z7jMsQ0UG
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


