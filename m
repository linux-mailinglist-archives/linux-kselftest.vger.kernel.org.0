Return-Path: <linux-kselftest+bounces-27166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF22A3F672
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5A318937AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3B20FA8F;
	Fri, 21 Feb 2025 13:52:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E420A5DB;
	Fri, 21 Feb 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145942; cv=none; b=ZueiESP3XGXdNpTsvW+pIvcX9EL7onld26ps+XZfSMBUJtHYt/JrzTLFnjV/qnlP+3G9acr9okDHa+MDiV0hVTxGE/Jswr+uGb8Xb7BCDOBeqAhEe3qPq3DiNOMYl9UaF3JN3u12eu4p4CfrYmZZBfuYqyRyqBCwT8vi9Tu7Jrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145942; c=relaxed/simple;
	bh=ouzsS6LEZy5R1+wbJDmnkKV4jTSjqxGnKLnsqYxr+B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MavQnnuc0ZmgvaSUIhFp1YVKzuzpCGxiANaP60axUNLQW1c/bNYeR4O6+ZPKfhu5TQTSjOHLxoavJNqVowsnua1FyoA7fhUW5/DeaqYE49RqsIIsjrAsHpxyVGqQ9B9KyfJ0xLc9GAsYrQ+/ua68hIvy4tsKas4yJZnJMcEJ6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso401467266b.0;
        Fri, 21 Feb 2025 05:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145939; x=1740750739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2zfb+4gI7tn7/YbAaJLOzfVab5hlUbmHbxbNlQhJLU=;
        b=Wa8jcywGoMXXr0q02nfF4XvO1nh5AMx01rL7pPr22uLkVn6g3Ti42NETqJKtOUT48b
         9RV9XwbIHcIqobq5I5MeANA6E92PkFvUwurdhZI7SIes+v930RpFjAXDhB7l4stXMp1a
         LAAzq22xoYgMoQv2joWnRmqnCLV6lU/k9JT3I+yG5Csnokz6k3Kzpe74G5Ev+jsX8eWg
         n3c42cSaOe+oswvSRRmq2RhH76gcH5Z60jdB+FwegT3s02LlJnPF0Suw216zec3tKu6Y
         iGUIK38J4MdKXveJwbmdBOASMDSJqmx3RMsEuYoFv74M2IittF1knHZlDCZuYVYx95Dt
         9jlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUndSsLiQJDyIm76gCcSOY3aRPD3ZU9IcusV/Nvz7nkh4oUxZr9usOuEvmJ2MVCic1zjhJfzw9jIyzFQIQlbvKs@vger.kernel.org, AJvYcCVcCyFCsaSkBl1mwKDY+FFtkDQF6dtEsshqRRwrikz/z0yl9Awsnz1wqIqSeu1StmrrYGqB7sPqpfs=@vger.kernel.org, AJvYcCXBe+JA49rKJzXBq8GE2EBBkVzg+jvJ6QdTzzBUr7Ffua4M7ACypoXZaof5zLt/0gbhCQ19m5ShclgpgRyo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mdYoMhoZTohryf88VJJq6Npm4xaqEyi9ATAiOa1o+y0NGuFq
	Ad113FZEBpDEDY1TU1+kyaBDYIXoEfVMOKdsioGFOFBgkm89Rwu2JujUqQ==
X-Gm-Gg: ASbGnctvLv75+NXDgxynJQuo3ok9Mf2k2+s1RYxI2/6nby/bfyoWfF++FqZFCYKmvf+
	WaitCfvUuozGKIcbK81XWzHhjaHUYVKpdtqK36U9Xp4YsHyVWpVhnToWQCEmkv7xGO8Vj5tI/1k
	V62vHKTfQ24n55dOIRsaH5JpXueyatiiGklmlwElRurY9BsXoydT7Is6iAlFN/kyLuaMNc9v5PG
	QKPEYjrwaeterhIGGX+wOkiqADihyvR/GMbluH28MejFOPZm9OTxPNslZzOq9NQs8eCm5M2ZI4G
	rvnXHgFPDqFOgABv8A==
X-Google-Smtp-Source: AGHT+IGMUCJOPm0mkufH1pHQ6A4LkbIgOHvnbQOpIFyEPIcdewG3uisCTkveNRpP4uPuHRSN3hkcgg==
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id a640c23a62f3a-abc0ae1ab4cmr259483566b.1.1740145938327;
        Fri, 21 Feb 2025 05:52:18 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9e44b7fasm934937266b.120.2025.02.21.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 05:52:07 -0800
Subject: [PATCH net-next 2/7] netconsole: refactor CPU number formatting
 into separate function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_current-v1-2-21c86ae8fc0d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=leitao@debian.org;
 h=from:subject:message-id; bh=ouzsS6LEZy5R1+wbJDmnkKV4jTSjqxGnKLnsqYxr+B4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMOSMCwnRQu+wfrEnqGdzKJblDAs5/gtCvK
 dZgc/jPS96JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bdz1D/9W1LCNzsx6Hrt4u39U2I1T6Wwn2YlH1by7/phhojTF4sicrQAthnWxApREcKFD16MA0UK
 SdsdsnVV1i7w3mwTVa2YqWms9PTeypySJCpwDNOqVoYO4TgigjYYD82KOLZbSUoYh3YktHHAE21
 0NXssSAgqu2oDXElJ1spRMCei/iPEk5ywsVxJf3oFd78wDv/uN38S/KprHexJswrWFf5DFJJQRW
 Lsemz2g+g4aUxMpB0dlHoTjEuQ8Bc6Tm6ybyiLRRebplN4yAXr2ersS6W53ivKfd5MvaiHhymsQ
 pr1n7K2eP/ki7281GnxAfpaRaq7uTrtq9YEh4N9KPmJXTLd2pULNiwZIVBK86JBBkkDnzP19yeN
 SXgdQbvHD2ehUad8XfAlbk1SegMACKnw4ocUcMzelYHotkX544cZO3yE01EJgLxECegQuIibETN
 +bG18In96Wkw99pKXgm2k5za8XHp7PCMPa+0Eg8BDg51hwMr9U4tAEO3TxYhdKFe6ErEFN3X9v9
 ND3WDxVZQwJq17op6RnSxaNLp4JjmWUi8JPm68KOaSUf/Tuvm82f4jin7JjYSK4AZrxV1swiQyy
 vZFBOOjKqJ5WuwyPxcCAZp0SJHgsxQapX77ZZhYXjo7p+0o24NijEGQiXzHlTAPKhbH3ot47cox
 6nJaBfYXHz0s3jA==
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
---
 drivers/net/netconsole.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c086e2fe51f874812379e6f89c421d7d32980f91..26ff2ed4de16bce58e9eeaf8b5b362dfaafaca0a 100644
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
+		extradata_len += append_cpu_nr(nt, nt->userdata_length);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.43.5


