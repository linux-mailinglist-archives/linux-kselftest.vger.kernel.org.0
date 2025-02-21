Return-Path: <linux-kselftest+bounces-27165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D7A3F663
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684C317C88F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A020E70B;
	Fri, 21 Feb 2025 13:52:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CDC20B80A;
	Fri, 21 Feb 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145940; cv=none; b=qCCRgLlaZ2dV1/wYZvyd6WvVJFxb4dm0rduT2qnf6P0WIqVZN494R/fmzx8aAWL9xJGJ8M6RANc0h3hIc/lm98VekfF8+wWHzIyvGf182UVXHeRyLXycBWP1NOt/F98+M3ndHyvvmrQDhZi/aPF6c5vyiv1Wdv9cZx8j4PjOnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145940; c=relaxed/simple;
	bh=qd79kNXwt/HQTrzjcvKIpR/xJTo/G9eIk5zkjXwC4rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhX/H9PNS9SBGGWq7KRLcTnv2VVl+ISo8SeFOVfyJiEzZkVbQ+W+DbNHwVtVH30HOWiqxv31WljiigTOG92RA+X/U9KHzOafQuIYEGTwubKNeCppdMLZPx+POPT1lwQSOXincqVGZKaSUXgsHcHwgxDJUW7WwF7ZqsrXEgfp1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbd96bef64so344811966b.3;
        Fri, 21 Feb 2025 05:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145937; x=1740750737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMQIzzUDLylhdt65XZnHbHj+QNMnnT9fm3s4NlvWkE4=;
        b=TGm+7ojobpL3Vrk7FUGsmiQQBAWfXK4sH47ZS5xrMhvrrjApPiASvjKIJ5KhHq2nF8
         gZzIS1FPWbK8ybrEX9Lz6zwM/70b77jX/ll/vMLC9C9B4Z83X9m56G03STVRtoBnON8H
         KR9uwijoClL9uIfPdZWGX0M1NjFubOMt4vgkRcYFNtQFOflftAwyT/yk1JjbNMaa9J38
         oB5IaB7qO/SHSkivdC4fNSfih4P9aBKlPa4VksGp/56iKcAKbzpC+CWoVQBmyFu5EliR
         o6tUMxY1Ge2Qpr/axqboWLXay665uZ8NaeWK+YtUrlOsc9aZT6SSMkhmVwAdqik4mY5s
         NB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUOAXs7RrXrE/bToug345/7AskZZqy6/S6RUvfCRmPuOKxLjwz3C8BTpdU1AFagU5RAo3kblnTav1U=@vger.kernel.org, AJvYcCVdd41KoZCVldLFfl7dmz/8cQa3YoucW+cBf4R1IZVm9Mz7fSnmgDVWpgvj+l8qGVtgpGJpDAkS0NHKtgGINwjv@vger.kernel.org, AJvYcCVwkwplMuKY5M4VAyeemVUcGuNoZzCSJbwoA7By9Rm7u1iwUHsSD0E7uyj9en1CYbhh+0nJJmWCBCB4q6fD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5RVku4dXfDM69fIT6YvXTkHI44jgUHqYEsftM+B9ukxe7IdvA
	00Oa2dXBm8G4oSXw561e0R/ItSMzrlHPGzeeoPIBbTN7b75h4cKsxwZ6Ig==
X-Gm-Gg: ASbGnctTtuU20Aqi5ly0JXDvcMYRAI8Mz61LbXRuLjK6ENNHOO3UZBPi4cYZ6AAORlQ
	4e3+q2uxsvqx6/xB2poosBpY2Hy9BngnLCSN6qPV7r3XY23Gm4nxiu335yuKkrTyJaILr/uNyL9
	C7Egw0b/mL0fcabUF7/KC2MwCxXj5twVmIZi2X55Rj4VPvMgrDEeQD3x+d6qCdq9llv4TQuUoXb
	dZbMf+ogbBixpcCbmFItoPSuidreHtN10fJPCuK7J+6lkgH/t9197JAXCaT8biSv+r1oNT1Smuo
	fkPul9wSB9VSRw==
X-Google-Smtp-Source: AGHT+IHug/ztUo0GwBXc3XkhycLt7jEmpZVXVlASuiFgB8erdIaD3w17ljV228j7iujwrfl/TlTW2w==
X-Received: by 2002:a17:907:9814:b0:abb:b1a4:b0fe with SMTP id a640c23a62f3a-abc099cca23mr328795566b.1.1740145936580;
        Fri, 21 Feb 2025 05:52:16 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7c76b0cfsm1203699766b.28.2025.02.21.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:06 -0800
Subject: [PATCH net-next 1/7] netconsole: prefix CPU_NR sysdata feature
 with SYSDATA_
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-1-21c86ae8fc0d@debian.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
In-Reply-To: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=leitao@debian.org;
 h=from:subject:message-id; bh=qd79kNXwt/HQTrzjcvKIpR/xJTo/G9eIk5zkjXwC4rk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMmKrAKNkKqrRTLD/DEaZxsJynw0aSK2Nw5
 pyuKs1kxA6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bUs/D/kBp6+nezMAR/BNox0ur+m0Rk6CysSAPfH6/5CsNA7pHdNb+5PygsI1qLADPwoeMMO4gc1
 0eQJ71wTUQpbdslkXsNjFV72e7c3njPPiTBT2r4SjbXgO7Gz1sV/xaXPBGkmb0bJBN4pxS7zTuJ
 RW1i+VnAe8E99scZaR8OS3wag6fjtCNL0domk8OFx087uRurL2YCKpluckA6HTWm2/5PwnumQS5
 evhIAuSESXAR29DBJNPoCXkQ7iX3TmnlESmndUdvxuCgD8eh1eXhvTuWTXgxCD3TXTg+gEcmc/k
 Ap6xldjckb3aD2WLh1irRJOz2VoYB25b0fbICKNhw5max/SRYc1V/6LTkpB/vsHt9WCNUMfpGWe
 NhfyLI2nv4v7q7RlgbN0yDtCw34q7OQeETynbP8sU1O9Y9X/9W5Mk2DUHC+Dj5cWJIwc07tVFW5
 a7u4FvmV3ORED5h1C6Y9cWQf7wMQtyZFZQEuLp3pySbv7p7Pp9yITY0n/l2BhKZq0hEoLec3sDO
 Mod+JxeFwd2Kj1zp3is/1iRt34BvkyyCw5mvSPmW4e3FfyZ6JdrZbm46KCWAIsqBMZd21aqX/+2
 JnV/Q5UmGF5JECsWxaUeNa+dotVNfb8lcOVpQQZ0dLLN1qJ059LBNCCJIyxGvEibrIQhMCO0aqQ
 mdTnYKWSv8Vez5A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Rename the CPU_NR enum value to SYSDATA_CPU_NR to establish a consistent
naming convention for sysdata features. This change prepares for
upcoming additions to the sysdata feature set by clearly grouping
related features under the SYSDATA prefix.

This change is purely cosmetic and does not modify any functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f77eddf221850fe2778cd479e49c91ad695aba3c..c086e2fe51f874812379e6f89c421d7d32980f91 100644
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


