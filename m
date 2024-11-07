Return-Path: <linux-kselftest+bounces-21608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBB9C0785
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9381C22BAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6C212D28;
	Thu,  7 Nov 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFxtja6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BC212D0D;
	Thu,  7 Nov 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986255; cv=none; b=hf6SHUVqA6phABxSTUHLgYzBt4YX3oQYX6UDJxxP6p7vXMkkZSrj2LHwvZLbYX35U6dJ6+NUUeQWD/timYjwqDMtiYp6bvjdaCK+gmnZfXshNQKFaw7BAIINrbJ4YeOcmuqkern+hIEuG5HeUbCwRubG9z7oPlq3xXnwLLXLjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986255; c=relaxed/simple;
	bh=HP/T98jq8ZVtbRkR8ymskxcaIrygIxP03M2Tey2Ql7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgt90EMQXGqmZYEbs0snYX4oeRTeXL9zUd2GLdZLi6pDG13MmqYuZD1aosAV5SUlMweSQQ3eJunAMQT4/Pf5wBxDFwQwuzuN99urx852kzBlSS/h1cYn7lCSGx5/8quETvGv2dBLpSR2rFTYXqefJ4HBLvPEU1YSgdo5yQfFfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFxtja6f; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so3393125ab.2;
        Thu, 07 Nov 2024 05:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986252; x=1731591052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUs9BWOu32L2gGfBENh+erfoCLDyT1PmV3IMsurFVA8=;
        b=QFxtja6fETJqAP2OjKQNj+8hXAkth/QPZUQ32Gs8MZ49fSuznct77gK6y/69GkerX1
         37KQmvUL3nIuhHxDSaJwgIP/ZhukLEFQAtzXSGJciXv5u+Wa8/AL37JSy3Fzv0ewAFFD
         SXUdqlX2EC+ihY+a8g5WTvBw4lUpVzvcfCcSzukKj85j779C5QQXSZYYAqZT0j+Xss6J
         ESkle3ooDQIqOLQm6253aVioVuHjyCpUinxkapBVky4i+MBe5mgKkGiawZFqdpCgWafF
         i/pOsog/inU0mzteKveTytQbchqmwgu9+nJmTL7706K8vwS5/cb6dGXkMv2y/ltftV+L
         q9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986252; x=1731591052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUs9BWOu32L2gGfBENh+erfoCLDyT1PmV3IMsurFVA8=;
        b=XxfMTE4C2VErTJPaadLmOgzCcnfQ0I10VJY4TlB0pB5Xsu2dk6DlTJqqVWIeb+TCCe
         XDWps52kcd7wEa2uswdsumtWlKhCPxDlY21muXdwc3zYSc/ceYpJf9lWPrcEBhgGZyIE
         k7MBvBwYKYNaKThJq+Ra75VD2k1zI5Ena69ylcrpeuAadWM1gK27ueudw0h6CB7qUWPV
         J5ePHULDzCMu1Scy40ah1ZB77Hh/b+PHxqKdfcb0b8kflLgrf3VrWlMC59Mjrqa59IDn
         fijPYxu51w2vesDUAN1kClL5I2146RK54aNdvRB0Vqnt1PXZ6Rm8UPzCeHdi4L7JmjDX
         1HYg==
X-Forwarded-Encrypted: i=1; AJvYcCXJG0mOgf+dO/6F9xErTY5ORZrDAP2R7rSGGZsVrrcqJXXUKj62xjByxg1tO2Z3k9bMqFRiE2UzR56OG9IiibA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLh0LRq7Fi+yboNb41QtW+K9Aq0YmgbPiuoIyjLSQbkCL2aNU
	rZ/e9XEnww+TQc/wfjABFX/JoYYP0ynZwFW0fhVrajFArrl7jng/3qsxiatOz3o=
X-Google-Smtp-Source: AGHT+IHGKUmmx0POT4xmxjZoMd4NM+GzQvAiR8OFD0CMQp+8DnJsg/ZtDJybFx1AONbQK2LxQ7Js5w==
X-Received: by 2002:a05:6e02:1a8b:b0:3a4:e8cc:2aa6 with SMTP id e9e14a558f8ab-3a6b02612ffmr271633295ab.8.1730986251843;
        Thu, 07 Nov 2024 05:30:51 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:51 -0800 (PST)
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
Subject: [PATCH net-next v2 6/8] net: dummy: Set netns_atomic in rtnl ops for testing
Date: Thu,  7 Nov 2024 21:30:01 +0800
Message-ID: <20241107133004.7469-7-shaw.leon@gmail.com>
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

Set netns_atomic flag in rtnl ops. For testing purpose only, since
link-netns is not used for dummy interfaces in practice.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/net/dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index e9c5e1e11fa0..38d79f543998 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -138,6 +138,7 @@ static struct rtnl_link_ops dummy_link_ops __read_mostly = {
 	.kind		= DRV_NAME,
 	.setup		= dummy_setup,
 	.validate	= dummy_validate,
+	.netns_atomic	= true,
 };
 
 /* Number of dummy devices to be set up by this module. */
-- 
2.47.0


