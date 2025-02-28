Return-Path: <linux-kselftest+bounces-27898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE861A499E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E76018946C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D926E976;
	Fri, 28 Feb 2025 12:50:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF726E17F;
	Fri, 28 Feb 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747051; cv=none; b=YnIYKGnwn16IDxsxEw0dThLx5ME3rpR2lZLJigQJIqQ06Th2/zP1XbmnKPEgrx3DUPv/eWZvl7iB+eVLzeMAcRBB9gJ8MlU+ezj7FaZv01AvF4EApmmN49Ebo+dyf64Z8MobdCfkms5MF4mXktiZCnbE1v8WtK3/SZtAxOD+kjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747051; c=relaxed/simple;
	bh=HelmDOCiSVH0oYe5AbfcFFoJ/Ba6YNqbtam259+9iGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVRpGMozAcmhrIvt5SExUkHeJMXylOMRMJGJC/8aokL8FngsGChFJlcGI2OQa/rI9Aq3qEH8BRJXr7Ls0X8vQsx8qm5UCi8dIlE3HsVTEJJD9Kc6+VMj676GBUPLX1LCYXrBddeustI3d+jyXeZdPJCvh5uvPH535SkV/tm4uYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbda4349e9so292521966b.0;
        Fri, 28 Feb 2025 04:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747048; x=1741351848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhK35+BiG35IdJLkSjkxmypo8Es3ZZiEMfpt6eVF6Ls=;
        b=Ky6fzWNEW8n58yxm2+65q4yJ0LUOOzHvD0hHC3i2TIhC5ZiAoX4TX/EXCq5YHijxN8
         kijSxgiA1RbIamu2TMdZCQZXSvlV0ex8kzb78SOcCn61IIs9E2dl6wbEjT0bKqt21Cmw
         ADSno09uMCLYCwNNmqisOdtr4uKRx0nZ+n9KLfRsKD7E7Q4+4UjWz6gIj8N1tuS/iXCw
         moqw5ftXeXr31ErGGnOg2M7qgcw3K+HOjUk3/SHuy7JgcXvcs86qS43lTewDCLuVxgHV
         x+SRUF9OHTyk+nymjq9l4ys6bXtfuBmYHUcjvPEAWn27Ws9fYgZcw9jcP+NTlKYxQ0W5
         zkSw==
X-Forwarded-Encrypted: i=1; AJvYcCUu2CtDHMJyU50WcFaaLg/sgtPS/u4lAETXqYZPezsrENRXEKME3CeOIuEF8SKhCI0kMaebLkFrFk/ot9kj8FEW@vger.kernel.org, AJvYcCVWAVieeMyTPUZR99mWpKu9th90OMVVZOllzUxszG4MKZPqdkEjYy8IBH/yQcTGxlIepLXUQEyIUMo=@vger.kernel.org, AJvYcCVnSOu4bpb8tulbfWOfap/GxZ0Gw50dMmaIxyTbJK/inc+fpObY/uZCCjJYGjOB0QYk9fGeT+4SdbQ5ZjJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpUslTbnp6lZCBL0JPbrpO9iYeiBO6zbsuxtRlb6Z41ZT/jtc
	5JGDFX0xxHHSLO2eFYG9C8ai30pTWaUudmz+A8vPHKxWuDQYvg1detg84w==
X-Gm-Gg: ASbGncvP+tAPYZf0GXs2hspXieF4yq5rJ2BuhT7999v2kxRuVvE+z2wBTJIXNW+r4Qg
	AhUSXLuBfpLaBscq0wPmxtLwyF4eBEgIG5Kq6gapv5vRtsR/rYJWUuLPQVMUNYtypG3vhAII/DV
	gwEZODANqjseCEO0QLZb6rM+gMr2YzNyY77H6hJo5uRJc4MNNDAzJCeWWraMNSsrEnSkr4wCVEH
	iv5np+L7G7SaFTJ2LPwPWtT04dL2t722myxgjKOyzgH7DkDzOOIIio0afkh2FH7tDOflxhOOcAc
	u2Ns/e1ZKWOfeAn6
X-Google-Smtp-Source: AGHT+IEi6GG4q7h6Czla8F5HRsiaBM5uUvVEFc8Z5W+Gdl1t9LwTk9M3gyqzUDWfgbRKNU21Rocabg==
X-Received: by 2002:a17:906:6a02:b0:abe:ce46:6226 with SMTP id a640c23a62f3a-abf2684aab7mr365028666b.36.1740747048144;
        Fri, 28 Feb 2025 04:50:48 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c74de3dsm282418066b.125.2025.02.28.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:47 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:20 -0800
Subject: [PATCH net-next v2 4/8] netconsole: add taskname to extradata
 entry count
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-4-f53ff79a0db2@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=leitao@debian.org;
 h=from:subject:message-id; bh=HelmDOCiSVH0oYe5AbfcFFoJ/Ba6YNqbtam259+9iGE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEe301Sb0AKLT8rFcoVzhgcn+pZqZij3ml1u
 CG0sIXfjPiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bRaHEACGkaxq34Y4XQELZWMecCTu3lPxRsf98bW5ISjqhmSyigV6AZnFUGKoOggadE9xpZuO5rw
 TQTQ5DmHb1ZXduCietVDiJg7eUJ59sBu/iiWGRzEYqYoES/5nA9NNCNPxKxuz2cC7vHxxheIS0a
 XHI6hshm3S5CQ1nQv832PteQ7OSC9ZYJ4Q0wDWxUvsBPphVww8/vwuR64y6Tp7IxOYbckcoYBoL
 j2ZNjZY15NLs0oSGqLD/Dt9a8QLcZBznAZSDw/oxGKKNt0TqusQqOHn/8ToV3IUSjOJUdHPNd+U
 bibSkAPB6VBHCyM0lOZHDRidT2WckaTcgv1UD21MoxQBPjorXpyTULrW7PtuQyv77a4K9Ouw7Lr
 l7YLKHlSszT3qraY4fF/amA+qD+eVpDlFvQMNg7Sd9wLb+Iz8aTWeEonfumzff2byxPp7wJdpig
 CzTzeBUapkb/P6CZoT/pZ8d+wFf6kcoeI6N2/aZoZFyi94D2ZofGRZDYnA7aMbwV7yM8RHdgPMX
 WCQhckEdJ3JDTycwslmIw4Z4+OhZHahk2GGldL71k2qwdPB8YdJNEQ1TREgOfzSDJeP2FuAH6ov
 0PEyp4hR8JqTTTwh9Je7yEKWDdWEifGDfDPWxDE/NybHat975OZBUNqoymeHotHZXKxXr9fwFc4
 UJuWyr+r1gkXZQw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

New SYSDATA_TASKNAME feature flag to track when taskname append is enabled.

Additional check in count_extradata_entries() to include taskname in
total, counting it as an entry in extradata. This function is used to
check if we are not overflowing the number of extradata items.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 96153fd01f46e..f46a0edf9c11e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -104,6 +104,8 @@ struct netconsole_target_stats  {
 enum sysdata_feature {
 	/* Populate the CPU that sends the message */
 	SYSDATA_CPU_NR = BIT(0),
+	/* Populate the task name (as in current->comm) in sysdata */
+	SYSDATA_TASKNAME = BIT(1),
 };
 
 /**
@@ -701,6 +703,8 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 	/* Plus sysdata entries */
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
 		entries += 1;
+	if (nt->sysdata_fields & SYSDATA_TASKNAME)
+		entries += 1;
 
 	return entries;
 }

-- 
2.43.5


