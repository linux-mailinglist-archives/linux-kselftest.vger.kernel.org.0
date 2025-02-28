Return-Path: <linux-kselftest+bounces-27895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D5A499DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A538188DD56
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59EA26BD8F;
	Fri, 28 Feb 2025 12:50:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647625E471;
	Fri, 28 Feb 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747046; cv=none; b=hval6RFAXTyOUQdxzBEX1yX0T/Aq1No2h6Vz7CA7VcJmqrZnl9IjapQsHUCZ4jI+SQeYadmJfSfppXDAjsDAjwCB8QtoxWbJvCsN/2GXZnJkpB6DWhzr5Zfs4eFx4E8aYrUlg4u2LaVPKr6XSRtdPeVDni/N0RF3n2hnHcz3zPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747046; c=relaxed/simple;
	bh=0x0Gx32v0Fsnmhj+Mrbqul9AuS5VljG47NRA5YIMBgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMsRZJhe1j6+elp4/kgDnVco0VmkmCGzcJpGwvZjVv1k1Bg2ReNVJcZyI+FIpwu6EOBWis/rTuOpnw3u21nYFYO8foanuSBcIT3ILRDuxYk0qlRi5V1IIe9Zc6cbYfxnz/TwL2vm5pHyh0JUo6ku2O795lLpFc/lrumf1OKj/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abee54ae370so297219266b.3;
        Fri, 28 Feb 2025 04:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747043; x=1741351843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ/Uxno2sJapqq5emKe+5WGWVCezpD4yR+xMpZn60D8=;
        b=tIuVyQ8zPC38bowIUMkgDx30X8j+EXzfEmgXSsZhu1MDzYMH7P5Mvdf1gO4kQemLNT
         hNO/x41FLm73xxNvd3rTYBo+2nlcVJEu+nTul0OrYnLuXz1m8ORJ+0dSk5ZR/+N6tD9B
         CRMn5iyVCAf9op0tdTTtmpNTTsU3nGuC732TZebv4uv/oeU7yoM1w3++I3ximRAdtsQA
         EHYyzD5iYc8DdsjJA9p61QR/Afs5T3AGxieV/C+p9zN3gPmeTCTQ81oDBAk/PBw9PqQ5
         amnayVC0O4tYrsYTueSn2FTk2D4gTmvuTaQKAKm/KbhEAKQdGi1TlDLxtux0ZjZgMSiK
         Widg==
X-Forwarded-Encrypted: i=1; AJvYcCUBbY0WVwsW6tIPjvzqtunBLAXwb4Dk90TRuLoOibjE1avQ89rRSpjB12UDS3TLRhlxUbytw2NxTrQ=@vger.kernel.org, AJvYcCUUqCM3/h6/FHe95hukBU57fpHbUY98GiiXYUOi4IjYic4FCjuCfyGjmDHgP/Ug4BUUBQ9ADxnS4dteDMAUH+mt@vger.kernel.org, AJvYcCVC2ZsP6TwtB7J7OQ3tL66rN0MvnFCAJdN2Vep1jnEKrW9HcprUAEKusVCoBEnU76yz31V6DPGt+47z9YrY@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7XNx8S+R0+bQ/GD+T0g8DlG5vyPxIDuc1y+nJ6RIdvGIaFWx
	A51CnwCZTf6xYlvCmOWosn+3RDBaVeMudRVfsdoCcbXNbc3vMXbH
X-Gm-Gg: ASbGncvs56VzCVUSVz+5iKIzxCZLFQ9H9NUxzV7Ryq0akWW8th3DeHsIhG4qOwbPppQ
	sA9r16s0N740nK0jtHxu2VbOn9hzwN2pDIFKEkivvI6qq1eiGtWoOhuiaCjEaTb8driM9WpsMdy
	Nkw/K2TTugtY1TjrgW32ELdSWR7Qy0BPiHBk3QwUgMLZPH1iu+Ga7pLtXfb1ikgMBWbiT4RD5Sd
	u1+k5HVAEzznCskfTqMIRNZvd6T2qMel5NyET0VtAcQ/GOKGrKASOwD18xiBU2W+C2qOVC0MZV+
	/d2tKwSY0ZEHWH6K
X-Google-Smtp-Source: AGHT+IGkK9Y0CoFRDHFOeVyt6vNvvzlg42JJzoDLjNnlzXCAIsygmzbGoJ2NIghis0xY+XCICwHUeg==
X-Received: by 2002:a17:907:3e8b:b0:abf:1386:fcad with SMTP id a640c23a62f3a-abf261fba23mr378719866b.10.1740747043084;
        Fri, 28 Feb 2025 04:50:43 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfedsm287417966b.144.2025.02.28.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:17 -0800
Subject: [PATCH net-next v2 1/8] netconsole: prefix CPU_NR sysdata feature
 with SYSDATA_
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-1-f53ff79a0db2@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=leitao@debian.org;
 h=from:subject:message-id; bh=0x0Gx32v0Fsnmhj+Mrbqul9AuS5VljG47NRA5YIMBgY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEepkmuEJnuyolooRY/O6NfJaA1dLOBVLJNe
 N0MFpWd32OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bdYwEACwfDyCJ4K+c0zESH8z3JYsdd3l38okuXfdQWl29catwyZppRFt/rkDQAL6A1sAPeOymvN
 J0MyRV9U0rKUCWu/gXJzr6FkBimRf79CInE9BX7UtJkZPh580PMtwwtcSEbOVXkj9WpAxsxVDw+
 K3kMTGQd20RQEKLETZkLBqUuZG4oH4uHqYofgxzO6fnjWDtNs6piQSUFGSekzMf/SDhrAbaFztn
 CxMEMO1OjQm1Ui6yfE85reB8j2p2tEtenxgnISDGycTYrGgPj5+vpEFcPbpNX+RLVBbVzn6pD7n
 02eHy5UPoKQCm7A5mIze3MO1qdk3sNmNj6wtmIwqRue1zTU+EeQuyns2tRy1IVNEIp7PqM4DEtZ
 WMJ22cEGGpSgq0FREAZoToPaH/Vdn5UACuABWHLHHkbodX7sJ4400UJbJ6gmbutSiX/TijXjc3z
 RXJqx+HPo5bAgkLAOLTjAyF0ohjy09tKbEkvjtv/kveTc8D054zV3S6ukRBfpC2M9rjjAa0wKqs
 5BGVZlT+SFJYKFAvdVfOpzLXCBGz1trheXV4kEAVmBfpK74GF4Th2Bsk7ZPfLL51EhbpfnezwrS
 7iE/280BxfAx5RL9foJI+Rlwp+OIg6xk9EHjpgv1uuAIBgVDnpHNDUixr6SAUWqbYCqWzlkvpwy
 tJ4ZbiF71/PRPrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Rename the CPU_NR enum value to SYSDATA_CPU_NR to establish a consistent
naming convention for sysdata features. This change prepares for
upcoming additions to the sysdata feature set by clearly grouping
related features under the SYSDATA prefix.

This change is purely cosmetic and does not modify any functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f77eddf221850..c086e2fe51f87 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -103,7 +103,7 @@ struct netconsole_target_stats  {
  */
 enum sysdata_feature {
 	/* Populate the CPU that sends the message */
-	CPU_NR = BIT(0),
+	SYSDATA_CPU_NR = BIT(0),
 };
 
 /**
@@ -418,7 +418,7 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
 	bool cpu_nr_enabled;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	cpu_nr_enabled = !!(nt->sysdata_fields & CPU_NR);
+	cpu_nr_enabled = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
 	mutex_unlock(&dynamic_netconsole_mutex);
 
 	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
@@ -699,7 +699,7 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 	/* Userdata entries */
 	entries = list_count_nodes(&nt->userdata_group.cg_children);
 	/* Plus sysdata entries */
-	if (nt->sysdata_fields & CPU_NR)
+	if (nt->sysdata_fields & SYSDATA_CPU_NR)
 		entries += 1;
 
 	return entries;
@@ -850,7 +850,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	curr = nt->sysdata_fields & CPU_NR;
+	curr = nt->sysdata_fields & SYSDATA_CPU_NR;
 	if (cpu_nr_enabled == curr)
 		/* no change requested */
 		goto unlock_ok;
@@ -865,13 +865,13 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 	}
 
 	if (cpu_nr_enabled)
-		nt->sysdata_fields |= CPU_NR;
+		nt->sysdata_fields |= SYSDATA_CPU_NR;
 	else
 		/* This is special because extradata_complete might have
 		 * remaining data from previous sysdata, and it needs to be
 		 * cleaned.
 		 */
-		disable_sysdata_feature(nt, CPU_NR);
+		disable_sysdata_feature(nt, SYSDATA_CPU_NR);
 
 unlock_ok:
 	ret = strnlen(buf, count);
@@ -1130,7 +1130,7 @@ static int prepare_extradata(struct netconsole_target *nt)
 	 */
 	extradata_len = nt->userdata_length;
 
-	if (!(nt->sysdata_fields & CPU_NR))
+	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
 		goto out;
 
 	/* Append cpu=%d at extradata_complete after userdata str */

-- 
2.43.5


