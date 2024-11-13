Return-Path: <linux-kselftest+bounces-21946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860089C75AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51564284410
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23015575D;
	Wed, 13 Nov 2024 15:11:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EB208A7;
	Wed, 13 Nov 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510678; cv=none; b=VNpAIyqnLb2S175dzPFkjsQJCON2Q56CtZZFqLILchxIzd2zihnrGgKR1AmF4B4a7V0WWI2Eej7aiAs76JhdT+X9HU4cZgOKX6OdROiXwedMLFcvApz8imD03+Pb6rRy/DS+cnqkqzn5Qqmejts0urwK9QiSHZ4kujwLBRe/0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510678; c=relaxed/simple;
	bh=dvK97ikucZCA3mi0xw8qgSct+K0NNsxtWtBJbaBwBso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYo9gFQGKoSIRo+9qkVvo06upC0TMD3URQGMegF3k2F1kABSkgOaFygTL6ZOOdbi/McDh9fcYEJutyki/MpchX2xevA8xZpAi2bZ2go0faCSdGDZtrA11BzmtYGAEmCERvfrjf//lBwUHKbeSgz9Z1F8sGK4ePn6qDFLgSwEnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa1e51ce601so327885066b.3;
        Wed, 13 Nov 2024 07:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510675; x=1732115475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0okCZd3Tx+gQrgEVOilpTV31ZqkJUqPhWl0/A78bQ0=;
        b=re8fdyCM7fzxQxS1qsgfhIUfjw0Lfm4Z0IC0/Te9PJbe8wpiUbaU76ISAGj2NY1ve2
         3EjWNW+IP5ZB80xrxomaxMLlQKvS2zFLNTJ7j2tLqyZSf30WbdtW0b8tdKXj2lIueUwY
         crNx5/Tfn1hn3yH0+X3yzjV7BNhVlGNsKq46DUaTfezuXwkH42sMJ/gFiutxcr2FTrGs
         AarJGugQJbmN7Byw525/ejImGwXlwfojptePfs/yKxyyRocpd/GHpg50syF2/46T74pQ
         C4Zt7xz/ZhkGG5IepRAje7VCgI9kW0UYftJulxcy6v8uLR5iLYIyW/41CJSFPmpxCWev
         +EUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmT22IR3BAU8LzPf+EVb/1Xt9MKszASD32NfmJrFRgKcGQSM2N1MhbEhaUJjM6DZjhbGB99uoueWk=@vger.kernel.org, AJvYcCXFRhImIRU2Uf3uCw/J5WuJB/FAJgVC30qgdIejFdHb7Ux7P1INChK5r9z+hATm5GSS3zG8A9vaHnQt4oH1HoAd@vger.kernel.org, AJvYcCXnHA0PLFM0eh6BU8spsOXdIopOoof322bWf0W/f50F0FSq9Az1O2rYoLegdmD3A7tR7b11mQaWKizxcdBd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/2xM2byXqxNClboqdCkAu5SnQId72z6X13a0DEqr0EVQ/FM+
	i/DXN3QFcC5G3fpq2hacsTWo2bHQ3j1+zVC3hEaVIJ04Hsk1kSnJ
X-Google-Smtp-Source: AGHT+IEqga+x5+wVzdRkFEVj9yPEB6xOIvRkkWxf81x+yvhYejVYjpTd9wj5MB3gxeXmIfKIUFYygA==
X-Received: by 2002:a17:907:2688:b0:a9a:a7fd:d840 with SMTP id a640c23a62f3a-a9eefeb2c37mr1909473966b.1.1731510674837;
        Wed, 13 Nov 2024 07:11:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a9b1sm874787166b.52.2024.11.13.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 Nov 2024 07:10:52 -0800
Subject: [PATCH net-next 1/4] netconsole: Ensure dynamic_netconsole_mutex
 is held during userdata update
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-netcon_cpu-v1-1-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
In-Reply-To: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, thepacketgeek@gmail.com, 
 vlad.wing@gmail.com, davej@codemonkey.org.uk
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=leitao@debian.org;
 h=from:subject:message-id; bh=dvK97ikucZCA3mi0xw8qgSct+K0NNsxtWtBJbaBwBso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNMGNNLZFDm5UODb/yliTCrMzkzzRmOblnI0ne
 zFE3eQ7QcOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzTBjQAKCRA1o5Of/Hh3
 bSeoD/0YXmv/scg2QQ7OU0VAUCNpnLD08+t+xQ+IwTqsxUH5H7gj3wnukCQejaaFu2TAqNJtBPa
 lhRyMnRHZu9X2hjVHFhWZHWR4FibG2ADkEoyqxHyPJjeTn1MKVk1bB2fuvPRMsziosdB2TSpEbX
 S1dE1jemAtmpYBZpACpBgoEeET3C0iS7Qk3M8UxLF1pfSiGT2VXUJtqmW0a+WAWkfoDROFyj4qH
 ub0ZOaI/ILV2Ky7sl+W6DGwFTxxOERWin+Swjr9HI7vP8/lURJem0gGh5fVBIn5XlW3jop3jCaD
 IQLZ6wOjDBOjV39gX7reqazNlO9MXM2HyewTrchP4U/JCR/VT5tEi5x/CNhv759kirLFegZgB7Q
 us4gi94MbIkNY6oBzP+91Sza0IKxBDa9fUmWTd95ZM6uiBZBuSsYHFDrm+KF1iOpUR4uJO+TuKP
 XGYRm6/walO11gdJXudCyEw6edw4m/iCWoIReKA4WzfpF0AhGC4/oeSl6GueuW5evtrJi8GzomV
 LesQHUEWlnX71Of55gEjUz5HPZxcSVS6Bg8hbl6bNvb7siStQwdIOcV8psffyRV5hYPn57u7IIe
 GtnWvXi/kcyyahFAI0Xrb7yIESUldlNi9OuhD9FpE57NNanK8lNoT1aN8Jpf3uByY9zkBG2D1H0
 FGht4XCW5YRXwcg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a lock assertion to verify that dynamic_netconsole_mutex is held
when updating the userdata fields in the netconsole driver.

This change prevents calling update_userdata() without holding the lock,
ensuring data consistency and integrity.

The update_userdata() function is invoked only when the user changes the
configuration, so this addition does not impact performance as it is not
in the hot path.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4ea44a2f48f7b1f9059d275f0f0edc40cc1997f0..965712d65a014c60f91bf35e48f1b112f66b8439 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -697,6 +697,8 @@ static void update_userdata(struct netconsole_target *nt)
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
 
+	lockdep_assert_held(&dynamic_netconsole_mutex);
+
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
 	nt->userdata_complete[0] = 0;

-- 
2.43.5


