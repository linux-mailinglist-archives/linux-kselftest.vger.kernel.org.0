Return-Path: <linux-kselftest+bounces-25105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544ACA1B8CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAA47A269F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6F1C1AAA;
	Fri, 24 Jan 2025 15:17:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D31A9B43;
	Fri, 24 Jan 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731834; cv=none; b=SiSEcly5JpfI8e7V8rscgCi01is6Cm6/bTGQcGyX6WZZ3q91l1rqkptJ9t2XLEL/5wujVeWpjU21EPbUo5UgmpYpVYnh4TsaiJomMbsTbV/xjp3BSoKChuxHKg5XwvfyjIn6LE/NaO0U5yAA3AIZX74MByVniutKKdUnLjURVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731834; c=relaxed/simple;
	bh=90ofQRjddhIwjY7B3NdBo3IIRS/bucBdlhjUgF+NetU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mfh0gaEsME5CZT35m4y7kqAUEmLCayLbxkoPFndDlfSuVvHCMGsFHjt0o6KSjg2Z3M08jw3My2QtTWreT/un6xf4gm0IBWaqo4dUJiVy5wizcK7/T6QEmsKcx17RtlpiiYN6Xh0BoDf1JMp7d9ll4Zet5He/Q0jPaokSsQl3EdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436341f575fso23742855e9.1;
        Fri, 24 Jan 2025 07:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731831; x=1738336631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0R5eAfrpk5/TXaX9HTiFe76PxOptLYOl1qhyiQmRyhk=;
        b=VfwggWEazoY3kBBiFlRexoLrCBW6vsFGCRzk4XH+yPmJVWZer/1vHuXXAYUsNyOktE
         2ajwZo7X8SMCuuHJZqwmwPRNfYdjCWMR122aPa9hR2h0FYpXAG90FSMkwl/2PPaItYdk
         t4fKy5ulRnDeX/UtThjGr5MSMYS61B25bvGlJvm8x3d83bd2KirOucVyZeOrDmN0EUKo
         O3aoyl8R6JgIdZzqwSNU9aQlWJEEyg9B5BlQ76Zn7MNdHgKqOYAiw4ThW60l6JS+5VrP
         qLc2D/r+JayNIPdASCZwkIXJKTcTcOUH8jZbfCOWXc7B3/Htc7ZyACYvmQ9YE2I8wUvP
         aKLg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeqUFQ2D+chxXKfD2dkLq7c5UBoDPSuychkpDlr0mIBkQPer1jrCCTVHHV7HxJuRki/UcSWxy/YbO3IEl@vger.kernel.org, AJvYcCWeUKmOqXSxpQUhLBq19UAZ6RlsPrZZasxdbrMuxRcYuP5OTrH8TVCx4KYJwtMfcof6A8NSH3Z7RUIH6FOIOE58@vger.kernel.org, AJvYcCX8EzwsL9NTMnEg3hjtmVloHDOnyHdO8BlEbiOr0GTGBwcL+Otpymwmko2HMXPUmo0mNOG0/72V6T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRswVzaswOY81yl0aIzF7DgMfoVJhBhe0pyPQZyE+2zOfyNzmq
	hhNynTH4jwP3PZJJt3qKTW0s5KBZCcp0qYLj42oM8oNU9HioNlE+xCM5rg==
X-Gm-Gg: ASbGncu1gA/CYTnJIv6gCcu1UsgDyyt4YNdm1RUz+nY/sz77l7CqxA1Lr3ohe6X6h05
	L9gKY72qPmZ5xUkavCJ6JIFMN09sqxtxprPMfyKKuEApFHEOyDW/C4AZ540Qmn99y2hR4o+/9tF
	A4kO+CRWuVS8IZwmHW2S+BnulD+8tY+VWkBGVNrMIunrJdh4nPorhXOUUESmisR4ThB/fsgP54n
	atF6pK8iLefZawwpK542jDhXUHnrjSMKJ8hEp2gJAjHaBeuhs7dsPCHM8w5bOqaC8Kp7q3B
X-Google-Smtp-Source: AGHT+IGbwuU0YUTK5ski45/DPq5R/feN+h1iQPzoO7KXr6SpIOhTmlD9nMcHyJDhlejriWK7Mujlcw==
X-Received: by 2002:a05:600c:468d:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-4389143b715mr277099595e9.22.1737731830891;
        Fri, 24 Jan 2025 07:17:10 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e13694sm143592466b.24.2025.01.24.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:44 -0800
Subject: [PATCH RFC net-next v3 5/8] netconsole: Include sysdata in
 extradata entry count
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-5-12a0d286ba1d@debian.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
In-Reply-To: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=leitao@debian.org;
 h=from:subject:message-id; bh=90ofQRjddhIwjY7B3NdBo3IIRS/bucBdlhjUgF+NetU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67rWYcX6SWsGuYFG8q6jneB281uW+NNRGcYr
 Uw3FzJniseJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6wAKCRA1o5Of/Hh3
 bdZ2EACler/RBhAu5PNHtKud9KcWiGqhyUQT4SVa+YxhctC7UU8e+GDDwuCwaiG7YDSCMeN6IVK
 Lmn1tz/AKUUqTcmufHtBpn4a5Uej0TrAIZNTt1k69TMsPDkhERZx7loY0TaF5Y58Vq8ZICBfkec
 3SFUZzh5NfNcUjAIJ9Y389Q0vhYUjxeeiAPnYmkqES3k7vJKGm7cMsAbu9CLNk3Na0CaLvJ5mo7
 wXcMuYvhwJ21kyxvgz2QUBGajAhGrl69hLjDoLU3uqdRoCCtcgZoIK7wD2zrK24K/Z1WA/jLvda
 wWWBUeLNE8BhEog4qCRw9hiBjV8+rlX24dlD3Z8OUiqi2fjB2WFZ/sinoGf2GkxxXQmp5afc8wK
 Bz5C0wl9J1tLgGYHhTM5Rxlzs0KUMlR1rdpbC7ThnM0mDxjL/pG10q5bH2yf8rktCuFS4NL0qOo
 wbDOT4v9QDGP9i/Lg/47aPG44pLV1vnPC0UfN8I6iyV0OTXEjIlaJrJHVCSpkqr91g+M73UbUMR
 z/GZZ6bADwv0cpzyKWndsZyKu8FqOMCSJWd+tV/L+KdORU1zJtP90YDiikPr1ToxhHtx+bxBJ1x
 BkumSaaMe64mRHb6c9eR2ICTw2RuprvVpBGJyF6qfBtFTiCJReaDT1xn1JoqdguindOXafiHWoF
 O+0XIxVbAnbxLvQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify count_extradata_entries() to include sysdata fields when
calculating the total number of extradata entries. This change ensures
that the sysdata feature, specifically the CPU number field, is
correctly counted against the MAX_EXTRADATA_ITEMS limit.

The modification adds a simple check for the CPU_NR flag in the
sysdata_fields, incrementing the entry count accordingly.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4cefa43555aada25769b705dd8c8c89964f51a52..2f1aecdf2a47f246e75061d09b9ca524a82ec994 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -693,7 +693,15 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
  */
 static size_t count_extradata_entries(struct netconsole_target *nt)
 {
-	return list_count_nodes(&nt->userdata_group.cg_children);
+	size_t entries;
+
+	/* Userdata entries */
+	entries = list_count_nodes(&nt->userdata_group.cg_children);
+	/* Plus sysdata entries */
+	if (nt->sysdata_fields & CPU_NR)
+		entries += 1;
+
+	return entries;
 }
 
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,

-- 
2.43.5


