Return-Path: <linux-kselftest+bounces-27897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E4A499E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6341892BD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3E26E632;
	Fri, 28 Feb 2025 12:50:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BF26D5D3;
	Fri, 28 Feb 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747050; cv=none; b=Gwga/tZ54qFL6NwhC9y5KzPkIdjZcLztMbSleJwF+ypR89Ps5MFschCEEqhc3YmyDu1ZgXFaXlMb/xtdntzSRszLkPEWm/eLARHYHlRnFLuFO2RprTB++RF4Rxxma3PQJqzkrhTxr6BiRPOUMyGY5ZbqeH7UQPm+TTVPzu1JafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747050; c=relaxed/simple;
	bh=u6HTcgfi/0RVvlYsOcNn+OKTFC2hRDiZqFOOJ86rUx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1D2rqPceU7uSHEotZiq0/yxBuEH0vukDy9fa8spJSqO0I/qki1yKoJNUPTxv1MtaMELJa0DXkVgXq52z/NTlYCbO8gyvOHiQFS07DgnufBbKuWNEFd+AhkADVCdyybregyaSLohLJ5Jl/ESOI2S9F0NRDGVNeAVAK5yCf+MKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4f5cc3172so824681a12.0;
        Fri, 28 Feb 2025 04:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747047; x=1741351847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uYjEG/3EBcxcEiuhrVaasawpj6zmwg7vb38gTsuOAk=;
        b=f4U2Z9mm41hmRkP0ud9u5M2mXHJU4SETSLWMuWtWWAt8F4kUdQu1bWG3eOaXyMw+LY
         KZkmBxny9bRMGh1FHDgqIHgSr94d8XSF61pzusBgmb2hh4lFN9WTQGCJOICDeNb8wiJ4
         fHVDDholVecqc9fv8KkFKDR6fuynT+MZjoGx+Pr+frkLa/aWMtg9j0VaGOZxH6qEHwf2
         f6FaCR7bnwcL3Yls0hA7Lm/FWYFd1cAGVwOVKfnVT7GfLgEMOwaVfCoQXEbOzy8VVJo+
         bcWBTKLp4yHLqUe7ZAb+SOtjxN+eo5Dy/YOd0TUcw/qeBHpI2BDyN018SyfGOTaRM1VX
         yb3g==
X-Forwarded-Encrypted: i=1; AJvYcCU1QLG6qOb76efFT5jYWYkn+FUu9xcOxbI2IFWzLS9weu7oLxwccwY6Z+wF3MtXNS042+T76mnoMF8=@vger.kernel.org, AJvYcCVU5LVBrzu1FqPyUUrYjvBVFjYEwA0A25qWV/NzBWwlizdEyZYDgs72VSuUC8/+P/1HE0TV0LBhtwcG7iqAlxIy@vger.kernel.org, AJvYcCW/GsLONfszwHucARRQFGAAzbRVVigX/k9Dhczi7icN1dMHqKDtLhnyuholxThYQ2NUmyvBeycku5orm2Xx@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcwwKZOcUzRxF/T5gXHT7F7vVoO5u/L+VCdrn43YFSB8BWFBQ
	k1K76Y568r4PcpHAEoihhVS0tbG74C//vKHGw3DZ7jZiYKs4lNMpuW6UNQ==
X-Gm-Gg: ASbGncvVhLQqm5HZVpivaUt/0ac3GaH0yCk2KsEfOB6QWIA1a2cjWq/18gocdKNQ66H
	vt51KSmp8P7bQ+uextckTc+nYr7r5rZ6Rg3aQBZ867V0rY56m6FRjlFAHAq0Y2w1lAm5WFk/wjx
	xDlMvpP3sLBXvK2CrBz+v25xAwTNccl3x4WerQGjF3+fKQE54jJkyZPWZCio8vwH9FhKXSzvsVo
	kXqsC6ABJUkHdLf2KyN7exgtZtuOfAvOD5JX635El473y8WRjr38Ppiiwp4mdzQQx0OtwQw9zJ6
	yY7QrIgI2oKsKZ55
X-Google-Smtp-Source: AGHT+IFcdDDhdkw8EzE+JkUdrN0u1HR8406mTTA7T5cOqaDMzf0fSOIIWBv/EZITqUHmhSO7D14ScQ==
X-Received: by 2002:a17:907:7ba7:b0:ab7:ca44:feb8 with SMTP id a640c23a62f3a-abf268380b9mr338191066b.52.1740747046522;
        Fri, 28 Feb 2025 04:50:46 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm2431080a12.50.2025.02.28.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:45 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 04:50:19 -0800
Subject: [PATCH net-next v2 3/8] netconsole: refactor CPU number formatting
 into separate function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-netcons_current-v2-3-f53ff79a0db2@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=leitao@debian.org;
 h=from:subject:message-id; bh=u6HTcgfi/0RVvlYsOcNn+OKTFC2hRDiZqFOOJ86rUx4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEezpkePZ7JIglu3m/sca9WFPnDcPa6tdBuX
 qt69nBDiHiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bRCED/9fyu6zZJYc6RZjuzbTL23aD2eR3llcuSI/xojJNc7cFKMDJI9anFt1TaN3oXGojBamlVf
 UI4B7cChwSO7SKvnam5yksRDgOmgsikG/7nJzQCZZz5HrVsAfIKA0Q3CUkFXsk/fVn6Z8e5dPrt
 mqMiy2no9IEjNbAwZLf3xCzfNTYmlYO0lxKmmLqr9aUylmd8bpx3EYuX5ofyiwoXQn+P0UM/e2G
 6+TSz7fYxWu1OV4zC5EGcg8EHQUs1gQ0O3lkxEfUENvzhIP+uZHf2ICFJb7ND/pkbQM7eKmcN6F
 E0RiCFyJN/YikJPpvVNnxHVH7j4GfQrbaSqxxcFNraGieZUkIFk2pY2PWxXCAtk+6Bs9ZadR377
 PqOJx8TmN/YO/o9A55HP+SmNQL8IqE8HaokFCXxaq+2koHp34Znhf06NZCcTm4sdRwi690sAhiS
 d6m0dblsZn7QYssFOzJP5WAwpxfbBcng8p4ZuTdA0pZxIS3FioQx6bkpv9vnE0s5NU0uFWKVXVz
 To7Udz2Di9FmJb2CouKeq8jah1fVPkjiNdfrV+BUoqZjcsI3v21MK7hFX0GyIdV+Kmzv592WVWH
 JVwAoyxkDXJP5vJLpZHtcokMnhLqTrGzu/Jq9LF0dncV/NxKkZEc063WVELo/Zsf8fiq6ocza4G
 tbzTQ6KIHoSMvIw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract CPU number formatting logic from prepare_extradata() into a new
append_cpu_nr() function.

This refactoring improves code organization by isolating CPU number
formatting into its own function while reducing the complexity of
prepare_extradata().

The change prepares the codebase for the upcoming taskname feature by
establishing a consistent pattern for handling sysdata features.

The CPU number formatting logic itself remains unchanged; only its
location has moved to improve maintainability.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 698dbbea2713f..96153fd01f46e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1117,13 +1117,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
+static int append_cpu_nr(struct netconsole_target *nt, int offset)
+{
+	/* Append cpu=%d at extradata_complete after userdata str */
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
+			 raw_smp_processor_id());
+}
+
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
  */
 static int prepare_extradata(struct netconsole_target *nt)
 {
-	int sysdata_len, extradata_len;
+	int extradata_len;
 
 	/* userdata was appended when configfs write helper was called
 	 * by update_userdata().
@@ -1133,12 +1141,8 @@ static int prepare_extradata(struct netconsole_target *nt)
 	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
 		goto out;
 
-	/* Append cpu=%d at extradata_complete after userdata str */
-	sysdata_len = scnprintf(&nt->extradata_complete[nt->userdata_length],
-				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
-				raw_smp_processor_id());
-
-	extradata_len += sysdata_len;
+	if (nt->sysdata_fields & SYSDATA_CPU_NR)
+		extradata_len += append_cpu_nr(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.43.5


