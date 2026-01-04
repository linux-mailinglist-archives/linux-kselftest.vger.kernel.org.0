Return-Path: <linux-kselftest+bounces-48136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31338CF1353
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5393007FE3
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F730FC37;
	Sun,  4 Jan 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFs6Qzgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C432D7DE2
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552103; cv=none; b=UtHNcTk6+VHOI6vIeRktYyluN4IxOkwfe/F6R3GEC2D+0c86k+YHy1s2Q7E2ld+vV0bESxOXj2CfII44BzSvYO12uFtATLXuq5EY77ERUHPveR7PELm2zt0JPBARqI7sj54AyboUgosQ+TBI2tszLVWP5Ky4er4quXSbNHuoFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552103; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hspb+lmbkzhoh2CBb2VkWCM0Q69sUpzQRTotAZSQExyoxTMn2qq6JryMmAn/o1HBINnpN5faCannT3Mm8JrAoo92RBop9y+c737VSQeAAET+APEZuj54zBvl/QaVlJoyjA4N6GGcjh7V8zzSP8+t/eqTUMo9zjyAcx+i/ax+7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFs6Qzgh; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1563394c88.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552101; x=1768156901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=EFs6Qzghey7xQ6Fcur0QLwvI940WJB8GnGr2SNvRWe39WZsSBZRiAl9SmSMEQkR+GQ
         70BZndiK56RDqkzGfMIUraEGzKAr4MdJjXOzpct3kVrPq9aj1LwXU/inH9NqI4o28FGC
         4dPjNRt4sP9HCT8eCJgcOTQ7wJdalG7Sq4UWPzJMX4K7KBSQb0Ed4lxRRDgliGHHdONn
         Ydv5NqPb58INBhoP98o2ja+AGm8HN9rcz+Og2TgklpV45Nb/G+BI9q8nOS37EV96apX+
         iKUfeHAQJs0XcO9ZsPxnqK4BlRsLGDMzqtO0VTPanIm+OyzHrTs54Fm9MANeXxkcB1j4
         mcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552101; x=1768156901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=mVUm+8dBPKW+Mr1gjU8oTVBOF7ld6R+XaPf5CXHP1m+IReA6kOfhJW3+FUIByfWQKV
         yNpwV5ijSn2gQD62dd6/lPkin0SSYCGjyex/0hkLkB4gpOU6QujYM+eOK32oD3NZigU6
         8WuCDQMBAnKdTUo2eiYL+lZJwK4B07mbQtK+asU5H/LbbLpDoMqhAVADeuMzLg4UKCIw
         0IKk2wKVh2CNHjxqnehzdHzWrJJz+bJk9PguXbbp+S3FErpDZO80j+vkHqquR1R76NcC
         XLH9uR0Bmu6XDAzFl4Jd5/yiX9InAMNvfzxjetUNRXJSUa4my9hNNlWHRfhE+oFkuVkf
         XmEw==
X-Forwarded-Encrypted: i=1; AJvYcCX0sdlxJRmeMakQ67ud029JAEtieRT9D24EnAAXv2nSMV0AkgEHliNrwQelffaR8D48G2ETExNPev+Fi2vkJSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgFKfwPJvHb+ctRmXg8WaTi6/XNJw72JXKKgaIjJMv52gB41I
	GDaEB6aCj4BsyFQcHyGmWIqvD3FceIj0sKy8eMC93hu0NMXAOT8yG3oB
X-Gm-Gg: AY/fxX5RlptDnVA1KGjjlSc6kF7Z7ugy/KFbDx7aBruCbMd76bnBEHDtnfKw7Cob38+
	5McNA21XQ1Ydw4QjMGk7Cy8BSmdCBUYlGOqZbXQvv75SuVyzLxwyBKyGCQ37AqUOJFJ69tGr81b
	O1DOQFTc11vBnYD1imfl73C5wJ/bxq2l+E/NEGXb/Jqts1KafVCYmFJCrQXFlK+Qbe9G3+5zns5
	Wz1uA028vONuRaW17i1/0+F326vKvoOzjXYsOhZxKMFj5nPgUFyj0TN+SpMvzQIyyYcermD/9tZ
	wmHwWCQuwXKENU6mISOx//WmCvbVXMxs5rWJ6B7HO7NOJFLBVilxadn7wDlkqu0+OpzsNnbPbzi
	QmvV3S2F2o5uCqzFaBBMhcoChVt2kV9sjfLAE3DbXGjKgQwlKhsDh0PtOb9hp0AqfDOqdonGo86
	zOLjJ312/hteZjDEyg
X-Google-Smtp-Source: AGHT+IEkrerLkA/4ixjyUlfOE1XXFSRLs3hEvRo2xtxXa3LLm+JllqO1Z2sjIR8HVARMLkkwliMMxg==
X-Received: by 2002:a05:7022:4589:b0:11e:3e9:3e91 with SMTP id a92af1059eb24-121d80da9a4mr5164433c88.26.1767552101038;
        Sun, 04 Jan 2026 10:41:41 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:40 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:11 +0000
Subject: [PATCH net-next v9 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-1-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=16wxTenr+y86Rt/Ag3RI3x399WrHWTY/kIyhlsFlYOMk5zACPlbx+jeBwuMORyjOODyzqYAE4
 84+KGlB10dsDrvpVh1t3elftkyBxiXuobe8zN7mpmcowQZ0MWrnvM+N
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..e2ec09f238a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -119,6 +119,11 @@ enum sysdata_feature {
 	MAX_SYSDATA_ITEMS = 4,
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


