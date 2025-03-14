Return-Path: <linux-kselftest+bounces-29062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D7A618D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522B27A9821
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680C20550E;
	Fri, 14 Mar 2025 17:59:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9FC204F87;
	Fri, 14 Mar 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975198; cv=none; b=irqiQKmgLS01ROeGm+Y7Ba0zq1YLrf89FsUS7GF0YuMXasmzo4XVfgAA1nXKhYjMghQ/rUF0ABYRbVVY/ZH+jEwSNvHVf8HiG+hjjqCMJPtCU8UESFTwzG7qZCi57wB3FfVfe1iIJl0BJxvi+D1yReT+i36/Y2mjCxoWRGyYAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975198; c=relaxed/simple;
	bh=9zoK/o370Hp+GIGyXyaCMaBTt0r5VttvjyFVwdbqryA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SErH3VzyJMLyMA2RsYRT4tpBYSB+WRBLBSwRYdx0mYeW0vOeIFv1l1EP0nxNDh9iWcsN96Fk9fxqECA4oQwuUaYnXHOAUPjyvYXUTjvZpmhJzDP/ts52iKQxxTNvPrE/6qt7YtxyFaekw9SOlE6cB9EZLQBqGROFYSHGhefIzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abec8b750ebso412951166b.0;
        Fri, 14 Mar 2025 10:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975194; x=1742579994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0wf74SckaVD+jh859Co9o05rMdYp58DCNm8f+EmDjg=;
        b=JOpBd8885i5mkfrz5WqlVnnTf43tyo//KegFgLLxKnw0gAlLSf4cdNbGa4Qh2NkHwN
         n14KrtZheXWCbEDtbl+agSQckwNSj0Tg1E7sMPd7aswjYAyfhYardAsxF5H3bPTwBM4c
         reNTpuqzD2HoOkdOslUtS/XSBIRa68GC6Q0FwVyJedmMCnal7xcAarxppTfcPRjzexrQ
         d+4KGW5l9TQAc8uVzMQpRmm7NFDoPck0RpByRR/pmegsq7nWNnsZMo5GsPnn8ggfqxgl
         lGk9NaZcKR9susLXnWUgjhTQOqXwqzPA2ocOYz9J/koiQgIAVwH4/MCgSd3YK619+pTD
         s+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUEKLLoIx0Bzjc6hx1hCCwkJCy1mB6NAQIpkRfwz2gCMzzdaawxuLTQTWpFSKb8nhZ2azIrEOSGjGIGMQ50@vger.kernel.org, AJvYcCUjWXt2RXFi93vajwdeVw3CQ2w9eZNniL16M/96VLuXwiBqV8ITv3Tr0bT/ad2PeVysx4sbV03dqcdhDmDultyK@vger.kernel.org, AJvYcCXHoxN61BVoVCwc3X4oIMWen6PmIIOdWZZPw4qLX7IpkK/byhCculSNtDi2JkQpR6UwqIAJQAPIkgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztF9Nu+6uskQalsEAqtClBkYqoZjqMS/DKt04WMreywW4gmwRK
	cYY8hy/vsrBNl0NrWyWWHgW8oi1IWyYXbj45T8NSe+VrTiFPuJ2nbmP0Kg==
X-Gm-Gg: ASbGncssELqsYgfqFpdEkNqJ1foWCg+Rfxw8WLRuR5f19SxicNkAkMrtF/2tyXH71YW
	j/MU9n+4zU4brIkjm+THyg6Qb59bxGLs7TpyUN9tNmA7fMoDIxeGxCDYymTt90D1SHIfJXwJu4d
	4KPHiEsg3SUIHKGXg2e5kMlOND5iLhBs4ybd96cS1BVCRHMrS7fLYeqR8OfoMwHxKknr7i9q6NC
	sG4uD1YOQZDwspzJvls8SItQUzqYLFr6Ix3X85/0KxmCA3wHGh7OBcJbAlfGWU5hWRuBzMyHDJJ
	9e+LclL6tL9tZnfuC6qOVQxYBSoa2dWu///9
X-Google-Smtp-Source: AGHT+IGyemGpvQfthPAyO2rLzUepkGTVknVu1bf1FV/uW02p3ujQAyHxT0pAeQScTy7QQEKjIgz2Aw==
X-Received: by 2002:a17:907:2d91:b0:ac2:d6d1:fe65 with SMTP id a640c23a62f3a-ac3303bb742mr433366366b.41.1741975194269;
        Fri, 14 Mar 2025 10:59:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3914sm2198493a12.64.2025.03.14.10.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:59:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Mar 2025 10:58:47 -0700
Subject: [PATCH net-next 3/6] netconsole: add 'sysdata' suffix to related
 functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-netcons_release-v1-3-07979c4b86af@debian.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=leitao@debian.org;
 h=from:subject:message-id; bh=9zoK/o370Hp+GIGyXyaCMaBTt0r5VttvjyFVwdbqryA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn1G6SxJ+fcN5J9iL6YVottqwgkSAmc4BmBTwl8
 nrAwnJWc0+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9RukgAKCRA1o5Of/Hh3
 bWj+D/4y08QBG/ROOmdhJUzYgOPl0kCLyWOtcKYPcnqFZNthHEcuaJp4nWe/e48JzoK3lwKVME/
 g7hfPNBN5HfzTJTLMeqDRYoO/1kha3XVGVw9AUGkcfeZcpyXoA16qvbXrcBTnCx9neHKsUZhAps
 DRH72nvZVKk1Kc9mDBaFAxtmJ71JQ/o9nkJJEuX5kVooVW4aOhs27XLWxA1uPebJzfIPpve61ND
 XmKVI4GciKtkID3orwShg45e6JNBXI3HaokB4sJMFpdW7fJp7tl9uMi9Ro0bMmZEoZnDX7UjNLX
 4fON4Qoeq8EF0FjaMyhejrFk2iQrlBYoc9GoBiEq2a2kYHeGVtc2MPEcG4cq1Pk9nakX9y+2Sgt
 NFER5IzBb0DZd9KgDtOkS3IFVjDjw/L4JMJ0nxLtfqNJU2gBXrvYcy9jX5rxPI4QH/3EEDJQtv0
 detYfWiExyn4pGS5mrXFOJkujqUJFG+C5aCayApi+PQjCBIzddBK67BMP1z+qNRm4y60n05D8gI
 TGFAs0YBa31Ow6lhPflXrkeoFSst/Dd8pLY7vwmwycFRWOIiRQHDwG1x4rwe6S2Aw5QsHtnYRKq
 UGRXbRorE+x5PwqDbZhXRrrDWb+4s72hT1b7+4DW3+qZN7tH2Eb+29aaFgfr0w0ZrGDg/M+PeIP
 tPVCGhPLnzFwDfg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This commit appends a common "sysdata" suffix to functions responsible
for appending data to sysdata.

This change enhances code clarity and prevents naming conflicts with
other "append" functions, particularly in anticipation of the upcoming
inclusion of the `release` field in the next patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0914d29b48d8e..970dfc3ac9d41 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1224,7 +1224,7 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
-static int append_cpu_nr(struct netconsole_target *nt, int offset)
+static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
 {
 	/* Append cpu=%d at extradata_complete after userdata str */
 	return scnprintf(&nt->extradata_complete[offset],
@@ -1232,7 +1232,7 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
 			 raw_smp_processor_id());
 }
 
-static int append_taskname(struct netconsole_target *nt, int offset)
+static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
 {
 	return scnprintf(&nt->extradata_complete[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
@@ -1256,9 +1256,9 @@ static int prepare_extradata(struct netconsole_target *nt)
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
-		extradata_len += append_cpu_nr(nt, extradata_len);
+		extradata_len += sysdata_append_cpu_nr(nt, extradata_len);
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
-		extradata_len += append_taskname(nt, extradata_len);
+		extradata_len += sysdata_append_taskname(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.47.1


