Return-Path: <linux-kselftest+bounces-27896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B4A499DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA10F1890AD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C783326E145;
	Fri, 28 Feb 2025 12:50:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072EB26BDA3;
	Fri, 28 Feb 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747048; cv=none; b=kkxXK3qe62nBnu9wl9HkvoJ2S94ZOmrZZSL9T3n2ILYLC0N8zeDQ4yAnANzqxn6pCLmFHMnAvIaPofFSXrb9voq4hIMmyxeAExsRmtOHChxcCnN6Tns3YIPhV/J4qdP2CvQS4SDpxpBH4BJbbiRevbg5Qykql6K/zG3Qm44u6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747048; c=relaxed/simple;
	bh=pm0c48NJ0Nn05osu/S/ixet/zk1sAPWRLWcPnS4ZWw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KW7u9PQSFv6pmS2AzA6c0NP1It43o3ZCGSWjr5BLRHlOakjPo40OOZBiuZW5xqRpHeDcChU8yT9kT4SOiDuTI3rMiE28CcliqvtOL5jdsYBd0MXBRghyGvgilOatnGcxsQef2t7sUZTPgBK5y2YH9ZgXKokg39ovRH+iRks7E1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abee50621ecso282117066b.0;
        Fri, 28 Feb 2025 04:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747045; x=1741351845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu5F8kOGJPxz/Bb9hvRPkqvLvBYaBsXDHbaT2XVsroI=;
        b=gNa6MP44kqDh83AmEe6hQHRGOgAqwjradtm5fnCR8LFntWOYxcKylI4z/nyGVLwPLz
         3jy1jFOUPnbxAOX63DQ6NUoUp8OF20zm4UCRhuJeEBZuXr54kStz1SnTE6rXtpyNCNOY
         qLLgQ4i0VCRYJ6AE7lzxPNdjj6wZIck0y6ULTpynJttJ1YJ8JZzC5sye22RpaJ8a1dlM
         0j30/BptRTTt52qYPienAvv4WzMFpH5qOOqfQcXzjuK5QPGNtlY3k7cnYnkbhVi0uYNH
         klQKh1CKTQlH0JlHLFQovSae/hB/w4qQnqcUtnCJJ/OxE9lxbVq+7iA8Alvp2Yo90R0e
         Ft7A==
X-Forwarded-Encrypted: i=1; AJvYcCVpyP/ycRPvV7La56MX/GOg8VCfuh6QtVB2TrCCXLI022dgZNhs2XSWrLjdz0V2NUxLMwnnrZVJKa0=@vger.kernel.org, AJvYcCXSzoePsefBmN7jabAKgzZPe8JR9LUug0N0vnWUgmAeT97Fa/abRrhKXWBN0ZRhRJSvx27VYGiL62LL2pkzPBXC@vger.kernel.org, AJvYcCXl8Jd1A2I8bLOhSIOUsmck2YYDDTyQTNEce2K+uAMZ1CtMF0vz3T9CS9wfg9/OnXO8HDmIA0aaLDkJkGaH@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMuDygTw1vxq7ERSCkRIowImepx8mLLp4scbWOyfCcQu/iFdY
	Hl8e94cqdmR2oafUe3Th7RCWaAbsaHK40FCTppJk60qw+HjcRD2w
X-Gm-Gg: ASbGnctGa0KbAWxoWmlHDwhGFSPxrfLzXT4mpovfsD/HeYwIO4Ktg99iPI0idgVRrIq
	KXFpN+/Q/8ua2ovfOkpTtHJ54O1TkSPIf9dm2Vnz9ubKN9n28R4nuO4602xEXNZ6+6sF0KrF478
	fOKyJrP6i7Cq/HMFJrR7i6ZMtZzJLXabP8/+B7NoslrjtgCioxPATEbhRn6dXuMG5KRSydIjjPC
	5eqoJ6HhN8qki/lkHHeHdp+HuQZIIDeALK6VMCELnXQhz832yF/H4CinPZAXTQKRR5ZhZqORiv0
	5d3vMCSCzhlUvUXgbw==
X-Google-Smtp-Source: AGHT+IGoTkB8G9zu0wLyoN3+y9WXN/pI9PvDpVLSDni/NiKzOBNtdzKT/iBTK0L6ve9ppsIAWSFUGQ==
X-Received: by 2002:a17:906:da88:b0:abe:fed3:9eb8 with SMTP id a640c23a62f3a-abf2687fe85mr413659966b.41.1740747044921;
        Fri, 28 Feb 2025 04:50:44 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0db671sm286062266b.72.2025.02.28.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:18 -0800
Subject: [PATCH net-next v2 2/8] netconsole: Make boolean comparison
 consistent
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-2-f53ff79a0db2@debian.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=leitao@debian.org;
 h=from:subject:message-id; bh=pm0c48NJ0Nn05osu/S/ixet/zk1sAPWRLWcPnS4ZWw8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEeH/ooJp0c8utMbt9uQnzkvKJwSxICby3JZ
 mcb+jM6YnKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bRUCD/9Mt6mmvYXEeiFuefxDnl4ZRpnPhImc8JbmJnJ/FIQ7nbRqqCGUeXxADGr71IK8+wUkkB/
 saMVE9bjzZ28DzkDmS/IHROdREfzi/HaTP8kgYPaSdeiFH2IQIiNYMSYV4BT6/oaaZ6TwTNUL5j
 6CW94JUujGiPdElhpF2LRNlFzIwsX/UX8ldNqtErKnnEcNUX7n0zXECn2x19eYe/2p9RAKVImqi
 ryZ8g4SQEKwa1is+X0f7eEQN8LYdf0rhGEcIQUJW10j4TGJ7LEvrO+Re4EUtVaL6Iq7+9tvBlOp
 7jW8HVm/AbNMFJc9hpqXFVl8kSJZsPlBUJbCXxYPL64kKtAMHkgjBCJjI796rc7OJxKM+qhRj3c
 ukPwDs1d901yLuCO2z47EVdBZoVYp892YTFiMpNSLjCeUcmtlX49KOKn7Dwyk1yrayNrRmgX1Mw
 0gC9GvGwwKzAi6fem6taaheHaNpuw8focqVvUswruORJGWHQXlMIngB7ShltRufNMxu67WEB5gr
 q/LL3kJT4QD1f2btS/bhXJwvYjJjQgCxd2Hf8HkJ9NPO46d5+c7Y+tmsG9VZ8dTO0K3CRbdMTCY
 Hw9DKk+ECXB7NxBuOT/J4uQW/LgA13glgufw4sVL1sJ6hNtFvVMTTBFb16TsHe7pnSeCYl46Txd
 /oAvH0n8lLREUag==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the current state assignment to use explicit boolean conversion,
making the code more robust and easier to read. This change adds a
double-negation operator to ensure consistent boolean conversion as
suggested by Paolo[1].

This approach aligns with the existing pattern used in
sysdata_cpu_nr_enabled_show().

Link: https://lore.kernel.org/all/7309e760-63b0-4b58-ad33-2fb8db361141@redhat.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c086e2fe51f87..698dbbea2713f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -850,7 +850,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	curr = nt->sysdata_fields & SYSDATA_CPU_NR;
+	curr = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
 	if (cpu_nr_enabled == curr)
 		/* no change requested */
 		goto unlock_ok;

-- 
2.43.5


