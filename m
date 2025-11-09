Return-Path: <linux-kselftest+bounces-45195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337FC43C5E
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987A93B31F3
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D392DE718;
	Sun,  9 Nov 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJFs75lf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB712DCBF4
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686382; cv=none; b=kf8WWVDqgEgDLshjFqURKFfIeAnGJz+ee/I8M9otRsSUjHE4Pe/RSmNaKmmbsLMXYpgXRuQG7HPDenZGb7XP3/iezLhq5crsPcWW/xSCJEh0fO9f+tfrIIXiJ+Q1t8N1Zf8FJ+XEv0a5+mh0IclwndwOGyLtmLRE7LHJaaBn+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686382; c=relaxed/simple;
	bh=Sl57n5h3qnQFQNcmwKkS4S8dI3DCYu3TXVSej6Ds+H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWvrxj5xpcKhsQyafgMccxlmTWpB0rd5uYAKYPe0QsFGH5leimcOMbfs480m33aVgNjY8p4r9Bijcqjk+V+I9X5bUwLHhIYZhXlPiPJDmYWG5yicrWh/z7ojr+d+3s+JCD9FvaNpC2up24JUVz+XG24ZQ/avlPu/wRQgwx4357g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJFs75lf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1466386f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Nov 2025 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686379; x=1763291179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=hJFs75lfTSw6dZ9ude0fkIzdZfEXfXOneUe+NdXfnS/ZG1l21Ppofl+AXJUrdPKvwo
         nEr3PTun0Kkmvrh//hhyJBanf2bPN8xIVyrWQVTitZk1Nv3bTMN/MyUuTcLlt3vK63yU
         RajnY7mQJv7TYrE4tIHcqo/wsl/58Nhuba+RQQDYC5LuVd1wO1TOS7o00VZBKz64eyoG
         /vsY79s9uO9y5FZK0+F6FPRjZI7zcoZWR39/BTgVAjUVR6XqgFqreSkmdMIM9Oa3lRd0
         Da1vT1dZNJFtw1v55W5X7YQc1X3vpR+yLVHwvMuISCQPqqgLGlsF0KrLvMVFyxQoLObF
         l1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686379; x=1763291179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=XYYRM3FANtFlK1ae4rfOqjX2K5+xkavJHE1jwMwT4mY1+QoCpLlc7DiufVEVo2Tbse
         S4iD1JEUQNbfnoa3DcNPmYcMFwIDLCIMya7mtp5DDmsrQkRvMMbTIhIwN6N+7IrvdkiP
         Y4zB8X1ZxVOWzX5797UbF4JtGWVnb4fjcnuHeSe5rIqd5x7U1jMsp2Diyvt074GlUzo6
         rLckxvTvEClkugAQ3vAQqy/3N3yJirrtATmYAZo0vNpTyy1Sa3KNkoveL9CCCXhsNqxZ
         gZwR4UXdBoRFTQoDLPqwRxZEsRqBnzbfHULnOUxNAQ5ymkRPDgWAAThFVA4umkosLIHJ
         7PoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+SR43k6xA2xza2hNfHTPbA50N4upRaF+3PUkd8BblrZJRVLb462geLsdMiHwWQg6J/tVwUJgrLDVY0c/8y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lgV0mFRN8NTWQLaxuP7H6tLjE8zJa8ETuaTq+OFwpqSooTLP
	SRJIJh+OYk+KPptrPXfSz9C+uLSLaGc6nHHgtGUDru8lBgnbt+KeVumW
X-Gm-Gg: ASbGncvpHlrFjzO+CgQzPM3KRpwZf27iS+aQN8aaxo4OYVnVrhQsbxjEr0dx0pgvW4w
	fPHL43/0lpxsEUnuS08YCSd/BYvB9oDdMvZs1CYVg3Fln+AIiC+BNP37ZFApP0qKz8EypT58CrE
	9/fWpQN9buW7Aoi8Unm4G8+0plDcqXS0SAy8snq4EiupMh2xgsb9Gf6EnpWkspt5Tb4I9DU6SiT
	lKUyB+FGv13cQwYev9cWJ01xCQUUbqCeTpm0Y6t8Bb24GY8nmeuYM/NQi3N22W2ajhLFcRTBYwr
	xmo5zuf7EUpd9NkzVf6cYNv7mOX+QZjltUb7aE/SPqcFrSPu5Aq5ncK6Y0u+YcEnYB5xptXlXzh
	aUpiFfW/ozuor3kYZyh7rqzxYIbHXK/0jI9sXbnTNTy9w7agjRZe/xYg1jELkKXiPO4xarq1BcK
	5SK3eW
X-Google-Smtp-Source: AGHT+IHFIeiuJChm/jLLid7Ik0+NY4IPeqhmAps90p1OjDHbjatYqMo8FhZ3+4mJG2x/qi9W+hfY8A==
X-Received: by 2002:a05:6000:2912:b0:42b:3ace:63cc with SMTP id ffacd0b85a97d-42b3ace6596mr20172f8f.35.1762686379085;
        Sun, 09 Nov 2025 03:06:19 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:18 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:53 +0000
Subject: [PATCH net-next v3 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-3-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=2028;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=C8sdELlfliWx0wFIHhmVjWXm2jGpSIoVSQHcSClL97Y=;
 b=VosP6vA0UGMteFuPJJrdAB8s4fo0qd1/JQ+Q+l3P3elVqVgg7+IR5SyFib/tuF7ioDch2jzq2
 PLd4XS9fShgDELOMFlnJkQ5b97MLBXZXZgrG/Qc6y8rZBZr0oy34OK2
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
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2d15f7ab7235..5a374e6d178d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1461,7 +1470,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.2


