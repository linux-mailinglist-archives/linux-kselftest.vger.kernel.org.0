Return-Path: <linux-kselftest+bounces-22833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4299E3FDF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488EC280DB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6620D4F8;
	Wed,  4 Dec 2024 16:41:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE461B85EC;
	Wed,  4 Dec 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330460; cv=none; b=npKHh7GulsNgiGr1KWgQwY2lyiWGjhtWxYsrZniUS3qgHdOmsEz53fUmgiAVlVFXHIW4xsL5FPNWzf8n+IEKa6UEC1PiBK1z+AhxBL5G5E2u8Rhen/rll3urMOqHfNP2rjeRsWMwgJyhWbWKOSe3xcx5b8GdLRT7/7QSSWv5uyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330460; c=relaxed/simple;
	bh=ovxjdhKZTZJF3bNoyUUKDjDyDyhf1uuMTZmUa6QGS+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEIreUO5PUxX+7vjrln1MK0M5PNnAtteg3EacB0LQz7s7kTH19uqJB3JJb4xXLhsETzQTAw8IPzpeZER0jOaida6O66rJizPvhxOVRgxxaGzFD90LaodZoZHo8Pu+yJqO2mef4CzRABZ/xhlk8G9r3rvbNfADR8y6QFur8WbLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa55da18f89so1044156766b.0;
        Wed, 04 Dec 2024 08:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330457; x=1733935257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGKhXWb7HtZIOVQHIFExLTvViIJYYv0F3Lwy/m15R3M=;
        b=wH/Fu6IDYtAyrWkG+ILgRtwer3VElxH7sW9jg2N+2stFXVdDL/aWrfZiUD5GCkPbW9
         HZnmxXXZxpJSHTZ4NBeJ7bnpbcRBe+l7ONeK3L6QUk0Rn38u3wZ3o6k0HkA2FXDdnlHR
         D5UqjsXtWzE6LFrgCWIoDghPYn84PLOeWf7UkB5ysYOinwd8vXrKFMJEtnItFHchof+n
         ci3HOsJp2pfYZDN4sadwdHQgYuYL8+xZiqyQ7dB2UD63G62+097+3MiKvkFBD5TQ2imX
         hRqW8axvcVsDF0udUCPlolFlIZxYlklM+Wwlh7Q5FdWZe0hKKRs+bnHAYhpfmaShrQKG
         qPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUUiuoFXE41ud84AJCUmWPkE3I4MQKBG0Y7CGC5Z0oX0ALNesDyWHVYmsk9UU2gwlkGvYjxyam363m4FHlMK/JK@vger.kernel.org, AJvYcCV26EGSOPS5dl3WThzoQQNFYq/hYhY1imVsO76XawHQ86aLqDoijNyIwVTQ+7eosswLOQFJ7jalzQtiiPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNhO/npUKkaljiTYAlzeUUN4mewYNAqJlegaUtMdetTj2Fx4R
	qo1lgPziXLkrDITVvLocZN2z6kAlmVXfmwkLTu4xFK9qLG7zb/PnVz3/cQ==
X-Gm-Gg: ASbGnctUU+2FDlLnFM7ldrJ4RSmTBoh2WSSb5wCCSMhE/Vzwew2SkgfOFV/MVp/HJ4R
	m5zr65vUP1jEcMyC4Sip6zelGHXSKQYFgbOOHKYeuxWZYaLh5eMd1BrAmCsd088sZMofh89AGyS
	1HZeNmilmBkPCOHKzvD13WaeZoqWufmmXbykI7T61YFQAXkDondNQ8BrOPWCYwmHp17v/JdfiPj
	fF7bgYaGmLafqK+42CqUMjxZfOmt95+lElSZahF/l8YwW7Giz0Gwhokr843HsQqx6PTEUiIyIvo
	CA==
X-Google-Smtp-Source: AGHT+IGoMCilSf/5FCw7ftvtOv25fdXS12WGiCb7ddKIIZZQguO8hPB3cVK/S6ZqT15PetPGh7lhtA==
X-Received: by 2002:a17:907:780d:b0:a9a:1585:dd3b with SMTP id a640c23a62f3a-aa5f7d4d219mr570414066b.21.1733330457195;
        Wed, 04 Dec 2024 08:40:57 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c2c44sm762955666b.29.2024.12.04.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:40:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Dec 2024 08:40:42 -0800
Subject: [PATCH net-next 1/4] netconsole: Warn if MAX_USERDATA_ITEMS limit
 is exceeded
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-netcons_overflow_test-v1-1-a85a8d0ace21@debian.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
In-Reply-To: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=leitao@debian.org;
 h=from:subject:message-id; bh=ovxjdhKZTZJF3bNoyUUKDjDyDyhf1uuMTZmUa6QGS+4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnUIYVs0kjByuqSoxAk0AiC4ZBu+mV7D9Kr2Y9q
 7JqHzAbaQ2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ1CGFQAKCRA1o5Of/Hh3
 bUkAEAClfKd1/z37QRE3JG+vQupkR9Vd1UrGnL9LaUSIA3qsKw3iFb5WWQelksTT62587/NQt0V
 N1am6K0jlfl0ux9Vs0nGk/sxsyfgiWZG359/87I6NLH+M2iccbCcE8s24M831Imkhb98jhtYvHH
 e4oeFgi1g6WXVdYtA4z0SsCb0+d28AI8jME0h3Cn2BwD/wzZLasFTTqd1ybQMexS5Nv9Ww58gCC
 ryMqs7bvoCecBheWtHro0qqwdwJ2m3562vufIGJGg1rD4yL7vBawlLfspfq7ulYRGzrYqcZH8D/
 m4IgoJksgEMz4uLr/m0GE7/4Uzk+lsifvxJjdessPKC2SWtbJo01OsDrv+wWMvDtSJMZQ2wnvuk
 wTwUhvtVg8JutXgkAkzLRqSZ7mOP77YWNgXrj0vs5cdpmvwavDCziDiGiN1PvIVtVlG4Skzv65T
 iUH6V735PiKWe7NXi3VCDyx0PWRINTcg51GEXr3oNZ71Gngr9DdCWpeouy2x+TY7e6K2SOX0pZw
 mmwcM/B4cL/yHgzWACkUmRWdU5QPJ4bLG0yuvd4CFu5wdcPQFAT9HR6c1kx4OM5rT8hliH17UOP
 qSRh7InGo3Z4YGA3sUL/YORURv23GDMoh+zW/BrHLq7xTIqSwvzMKQhp8kfHVOSZGYOOInu99cQ
 mZYZpftASXUQJiA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

netconsole configfs helpers doesn't allow the creation of more than
MAX_USERDATA_ITEMS items.

Add a warning when netconsole userdata update function attempts sees
more than MAX_USERDATA_ITEMS entries.

Replace silent ignore mechanism with WARN_ON_ONCE() to highlight
potential misuse during development and debugging.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4ea44a2f48f7b1f9059d275f0f0edc40cc1997f0..8b9dd4842f3e516c7eaa08205a45092e64417440 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -705,7 +705,7 @@ static void update_userdata(struct netconsole_target *nt)
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (child_count >= MAX_USERDATA_ITEMS)
+		if (WARN_ON_ONCE(child_count >= MAX_USERDATA_ITEMS))
 			break;
 		child_count++;
 

-- 
2.43.5


