Return-Path: <linux-kselftest+bounces-34455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29772AD1AE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E4516B0D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F21E5205;
	Mon,  9 Jun 2025 09:46:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A616224FA;
	Mon,  9 Jun 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462400; cv=none; b=szq5nAS69oij+EAYc5A6f1RWyMoBwdz3aqJ2bbNtbjNkPaUUOXvJdlp6JEZw5jO1Ag9HGUVm8VZ1XXK7ZCY9PJaDuzgH5NKW+DDSilBFD0K3Dp0u+WfC5kzKaHAMpbSAOzJdPsqDTKmAaWHGWb/hL3r1zBPKnrUh4CmHlnYirmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462400; c=relaxed/simple;
	bh=nvE9yPETJ0cMSZMbyble0XWiAJ5+Ig2FHrelAm52G1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqVlL1+0cV+bJTRn4NKFPqs9b/6cp/z+ra3vRHrcU+MlWToKYGM6i2pZlVnkvPBvJgDAZEgK3Ho5k5yDRpW/AYPZaopsWGBK0sc66l+WP3o+sTL0RoBG2pdFy9D5U8ymhZQE+bW96V1UqKfo0KRxqq7tU6pI6pYDdTq8LcmidE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso6824555a12.0;
        Mon, 09 Jun 2025 02:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462396; x=1750067196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6K5ax7dZlM1ceqO80t37SY5RGau3fBKg0lIDvsG7A4=;
        b=ou0hmepsBGKgJALdA+VddNDjrtzX0N/j2/9DLHzOplRKTIwhsN5AMNzwxTJpkpnfC/
         e/fWgGt6L64kJLS2aCR5n+eFBefxNfo9fZ6/BVszVNdoaThnho9yxqly8rdNeEgLbT3S
         e3hUll/EjPzDBAhTWQt56Tsdo3lR2bHPQUZ8PGw7ESt6OjQTpfyMvUyxKY6Az/YYXbuY
         XQv0h8NI0L1R//SMrsM6g/jjOUiodsMZw1evfT4nRq0MqTJGYcS1iB0CoRWS0iwn7bYE
         j41beM8D9+LbGLz1Ulq4IlUfV4h2d9jddJAfe6MHNVbVUWyE1kT9zVLi4l+iv49MUvko
         PJyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfRbWwXBwpwYxR2PvE/EdX100Ly9fytzxn3fO0+LlIC2QhlSL4tRhoDS+1rXJp0qKU/a+aVT7RGOQOuCE=@vger.kernel.org, AJvYcCVTTXpiGLe0944ddIs9BcQ+VIqbRPpZ37MbGGdL0/W5eNGhJY5Vrk8/7KiXGo53zafa/dO4uIWN1qc9tUTn2UP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RtBiL47NSh47o5EbELMPPqA8mI6KNGIA9MR6eQyrKpNqFmf2
	GppJd+WrJn69SJfD13qZ8qh4A3EPWkWO+qeCOLgCnhsZ0QLo7qaEjHvGWWb7YA==
X-Gm-Gg: ASbGnctUk2R7l2SH8lO6731ZxGsEfW4JkEkKlIn/Y6LoIBd6yfMWOdq8l+WlbS+CEMZ
	E3nEW2pneizLJ9bFJJstFtdGtnksvDZBFMRHjQ65Z25IuDcDBSbt/e+tDikXLlOsPnHTpZ9rgZk
	Q94sHLtiXRhjvGYyKabkocATMbFLDMkFffAC+LDOIVoKoPQgVdHFXL0K2ZDYAKvKHwFevv9LCkD
	55Th4F6YVr/Ou2JHBBP9lrxQZb1magNxlT8w906SsbFLmoP/SoIN1pEY8jzwSM1Q6/adgrTTRgz
	IilX4HQrHmyuexKKIpncfzGPRPQtcyg/f2X/sNoUZL/prF7umrQ8cE9AwgUURPc=
X-Google-Smtp-Source: AGHT+IHXb5Lt1xkTHURyUlGaCjSEG0oUpnSdcl086/v+gHb3uUHfr89IF7Pbwr3lH0tImuY6hHSJFw==
X-Received: by 2002:a17:906:730c:b0:adb:3345:7581 with SMTP id a640c23a62f3a-ade1a8da66bmr1144295866b.12.1749462395758;
        Mon, 09 Jun 2025 02:46:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade31896bddsm447849166b.182.2025.06.09.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:35 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Jun 2025 02:46:26 -0700
Subject: [PATCH net-next v3 1/4] netconsole: Only register console drivers
 when targets are configured
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-netcons_ext-v3-1-5336fa670326@debian.org>
References: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
In-Reply-To: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=leitao@debian.org;
 h=from:subject:message-id; bh=nvE9yPETJ0cMSZMbyble0XWiAJ5+Ig2FHrelAm52G1A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoRq142lf4H3g8cmhyKjEKuIseMJWVxMPHL8Rct
 GNVYfS8vZ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEateAAKCRA1o5Of/Hh3
 bYS2D/474DrpvR+Kv5UdIdphNIq5OyhuRiXTmYA2ETeMaxkqGEchSXVlNFku/vk828ubvu3MxVw
 RC/pArU1fx5BZo4u+iRYJhr6a43LbQE2qax8L2Ik5LgJLRrg7ae98IJkgX1pvkbFom8FQdw96jb
 x+G64bxpltG1CZoxE5RtuVeqewUyfi0l0IhgzJFG1aMD0rWccspXNLO0j/OAkX/fN15sJ9bHZXs
 xyyagVc4L9AJ+vkefwGC8ETcBEx7+7ikPkfjEm2EFEqALqld6jCH/FS2sjeDbadKGyBShrtd/dj
 xKgLbtO3/xV4l4DEmjxX71UzAeobPmMyTMC6dVrB7FHx4ruvzU1tRWwZpk6CcuaP6m5VAzaMmlo
 6pAQEPAcGbWg4ptCIo+rO1r3ccA/gin2MMr/ZUhiuEhaPKyqcUCe5R7Sq4DVie2UAbhzeY2Rkh/
 H+XEsAxYzpA0ZMEtEfplEmrWmPihVyoUD3JiJdRWsrt/nzBzKCntkW7tF9bdEpjKEYNDGBg84Fr
 /9cWOiG+2U71ycrpDd8peFAte5PhA1JEJD1AH2Z+tHASvfmeLfqdLaSfKunPCdRF3w51F0B4ZNU
 gUlxv1epFF+ID/uOKlrikuipiOzJo87URs5TWi5R4vO4fKJ0KXURhjbsdsbTpxw4+PZTLGs7W31
 mnkovat/xvbAmPA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netconsole driver currently registers the basic console driver
unconditionally during initialization, even when only extended targets
are configured. This results in unnecessary console registration and
performance overhead, as the write_msg() callback is invoked for every
log message only to return early when no matching targets are found.

Optimize the driver by conditionally registering console drivers based
on the actual target configuration. The basic console driver is now
registered only when non-extended targets exist, same as the extended
console. The implementation also handles dynamic target creation through
the configfs interface.

This change eliminates unnecessary console driver registrations,
redundant write_msg() callbacks for unused console types, and associated
lock contention and target list iterations. The optimization is
particularly beneficial for systems using only the most common extended
console type.

Fixes: e2f15f9a79201 ("netconsole: implement extended console support")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4289ccd3e41bf..01baa45221b4b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -86,10 +86,10 @@ static DEFINE_SPINLOCK(target_list_lock);
 static DEFINE_MUTEX(target_cleanup_list_lock);
 
 /*
- * Console driver for extended netconsoles.  Registered on the first use to
- * avoid unnecessarily enabling ext message formatting.
+ * Console driver for netconsoles.  Register only consoles that have
+ * an associated target of the same type.
  */
-static struct console netconsole_ext;
+static struct console netconsole_ext, netconsole;
 
 struct netconsole_target_stats  {
 	u64_stats_t xmit_drop_count;
@@ -97,6 +97,11 @@ struct netconsole_target_stats  {
 	struct u64_stats_sync syncp;
 };
 
+enum console_type {
+	CONS_BASIC = BIT(0),
+	CONS_EXTENDED = BIT(1),
+};
+
 /* Features enabled in sysdata. Contrary to userdata, this data is populated by
  * the kernel. The fields are designed as bitwise flags, allowing multiple
  * features to be set in sysdata_fields.
@@ -491,6 +496,12 @@ static ssize_t enabled_store(struct config_item *item,
 		if (nt->extended && !console_is_registered(&netconsole_ext))
 			register_console(&netconsole_ext);
 
+		/* User might be enabling the basic format target for the very
+		 * first time, make sure the console is registered.
+		 */
+		if (!nt->extended && !console_is_registered(&netconsole))
+			register_console(&netconsole);
+
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
 		 * already configured via configfs. Just print them out.
@@ -1691,8 +1702,8 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	u32 console_type_needed = 0;
 	unsigned int count = 0;
-	bool extended = false;
 	unsigned long flags;
 	char *target_config;
 	char *input = config;
@@ -1708,9 +1719,10 @@ static int __init init_netconsole(void)
 			}
 			/* Dump existing printks when we register */
 			if (nt->extended) {
-				extended = true;
+				console_type_needed |= CONS_EXTENDED;
 				netconsole_ext.flags |= CON_PRINTBUFFER;
 			} else {
+				console_type_needed |= CONS_BASIC;
 				netconsole.flags |= CON_PRINTBUFFER;
 			}
 
@@ -1729,9 +1741,10 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (extended)
+	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
-	register_console(&netconsole);
+	if (console_type_needed & CONS_BASIC)
+		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -1761,7 +1774,8 @@ static void __exit cleanup_netconsole(void)
 
 	if (console_is_registered(&netconsole_ext))
 		unregister_console(&netconsole_ext);
-	unregister_console(&netconsole);
+	if (console_is_registered(&netconsole))
+		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 

-- 
2.47.1


