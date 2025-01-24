Return-Path: <linux-kselftest+bounces-25103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFFA1B8BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A97A3344
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25211925A2;
	Fri, 24 Jan 2025 15:17:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1015EFA0;
	Fri, 24 Jan 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731830; cv=none; b=gYW/lSGg9ZAFfWUvDKktvVGbs/laM3tCMYifZIRjFP4d59Rd8nQm/S3u2Gq34Kcnca1sieaVytBj7LBEe9DiO2fryqU/+b3+uO+yFQXavbF5v40XT0OdtBwEdkbGdpHiV4it2YnoM8Nhu7pQdnMHNBk5WrHtlCKT5mVfHu4Y4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731830; c=relaxed/simple;
	bh=GCi+43WWf19lNSy6J7d4ZBO0U3IT+kcIa4GMZvO7Xv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnR5GRITUQjmwRkqCjWZgKqvaxysuZN6QzANv9FK49bp1IC3qg1KC6IjIpZV0cwhDLTx99vWZtLDwln6cVDDWGodU84h4/EGpjhrjtStTwamfxMo4hNQ/gjQqLRb5EiQvV12SnKMEzqB4QFm/b5nT33PSl5Wx0EyQYIEmWkFk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa689a37dd4so452507866b.3;
        Fri, 24 Jan 2025 07:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731827; x=1738336627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6A2gXWuEaFoL/mi3Lklti59AWgaQA5akjMekqzi2GQ=;
        b=osyzJhaKddmr0J4le1HX9SjxN5b63Wd7qPJlTFjekBBPKzcTm2Da3KMVKQADb+iUPH
         QB7tzYkp0PNAHDdRcTIbG/+lgTGIKJqzzcxRpqmPAqG7ARO3cgt8o2Dv+g6oS4Ko/Led
         F991pYJbq4w2tWSTq/ZqVEAoOsV+YoR39CFMKKEP52nmeIB7C+Q9CzlO9SlXLZJfYf4M
         PMLubgVNj0zjPHyZ7t4RQHNiL5t06hoTwKOWhOjf+lFEr8jndjKEEzUL1CQo1LFft4kN
         Z7sVkoJyu5HZzPKIVvvGIPe58ZIs+okIccLWez7DXg7LzU5JhdaaeTHWyy7/Z3lrbK4h
         aRGA==
X-Forwarded-Encrypted: i=1; AJvYcCU5z9ZO6ohQ+QQWHtCBEF5yrYg0rRNvgqbty9AQYoMKGMWqtWIENTIEjzcLR5lxwdrDtO0IZBNBNmk=@vger.kernel.org, AJvYcCUEcJOgTcX3tq4tn+tW/q3sS29zL30U4ugEEI56/Nbio009YChmwaUMKDdwpXKeAF6K9Bu8K4tAjGBKoyhf@vger.kernel.org, AJvYcCVHA5perv50TYTZfUfrZ17HU0MYgCw5rDiidn1SzDU48asxhSFG2iToPPBkok4Y82RXBaGC7oVCZhcWpvC6aJt/@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3e1yj5JhV84i3e3AElTd9MH/SE5+y/ZO5EfDtKdthNTMW649
	srXKXLaC2u6eq5Sxxy+XNTp16wFu+qhG5hpxiFSfwLIYWODZuvMyt8s5Aw==
X-Gm-Gg: ASbGncutweEkzdcEFOPWkaaEqLh7oAlh/9TUlNl893FUFY+1zNeQHYxQcz3+mkW8aNC
	f/c1HpZM2B71BRebidMbS1CfMyYdIRlaUEVBXH/skxVqT7JNyecElS4YINPWAlApgJt0H7Q8cHd
	Oe5lheZzKMqtkjXkNYYrqwEGk9vKsSaGzrBUIk1TtLSTH6GMhoXfAuokxV5IcZi8op11q1VIeoe
	l/OoWyq3sjSXP/m9KxGqYpeufnRdR5z6vLLvH/yALwXwQjb0Kqv++5HRywc4rHvvnx37RI=
X-Google-Smtp-Source: AGHT+IFn3tWJ/ADXrd3oO717cFG70u92LZ8ynhOWopFdUS0IWNtbdCmzZFH+CxPOkXVvmDJ5zi5zaA==
X-Received: by 2002:a17:907:2ce3:b0:aa6:8d51:8fdb with SMTP id a640c23a62f3a-ab38b240a67mr2605110666b.19.1737731826761;
        Fri, 24 Jan 2025 07:17:06 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbd51sm141531766b.151.2025.01.24.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:42 -0800
Subject: [PATCH RFC net-next v3 3/8] netconsole: Helper to count number of
 used entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-3-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=leitao@debian.org;
 h=from:subject:message-id; bh=GCi+43WWf19lNSy6J7d4ZBO0U3IT+kcIa4GMZvO7Xv8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67qdmMAXEMstMwVd49qG2/cV073AZXA2RWd/
 eCzDQN9jTmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6gAKCRA1o5Of/Hh3
 bWQUD/9ueTW9DbIz0lvGKCfF2zE8DD716Ww7ztp7PiuNusOZ6F7Akj2xFJWxO7XSHJ3SYizpG8B
 3oyhd5xTcQjYJrGFPn14+y7m08sbkUTsKSZ/JwBrCbQ3BMDIk/aGhUFHZm6pWctnj2emnbVST/L
 P/wt9mcoEAyLINlb1rlS4B/jJYhs43gPfkTYZ1gcz+KOkJskrnejknGk8Fz1PAx6H0NLVkWj5Lp
 FjsyNhrEuVGTLE/yqKg+jZnP93soWBuX6deAYx3f+zgCCd7467pb6Rs4pqFdy4f9wtw4gCc7F49
 Bo5nBdKo294tIHDGB00rl6TPhFsqU38BplErDBboBKc92C1B2BG53/uVfkj32hAMjMAbNmefkC4
 x44xvOBOsULeQr5ZGxvlraBG9gbHKIRrmkLTMb5LvIXaEneif1Ok6getx8hMQev56kD0RhCXg8N
 UG2LKwWFMjAkkbAu5NudG/4yBVMD75pE04ur06oFPu0q1rJWi6vDnX1LcS+vkyC1vzQGUi8WLoz
 zek0Wz42c43Z9B/J36TRBlNsqmU6cUFwfjOWQmEqoAPabiI3H2AQAsc+z1XMbETXpZMBCpNYw7Q
 ju9wnj1IO7GquLSoFvXL1S9FOJE+0cQsr/Y+NMmN9Ha8uyI83THpTDyhwj8OiLe0krU4yrKn5h5
 nlIUsCYZw2nm3dw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a helper function nr_extradata_entries() to count the number of used
extradata entries in a netconsole target. This refactors the duplicate
code for counting entries into a single function, which will be reused
by upcoming CPU sysdata changes.

The helper uses list_count_nodes() to count the number of children in
the userdata group configfs hierarchy.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6c67840e583a295e4f357bd19be0dd0ae3b76627..1c197da806962a751a3da8794def6a97cff5f701 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -661,6 +661,16 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+/* Count number of entries we have in extradata.
+ * This is important because the extradata_complete only supports
+ * MAX_EXTRADATA_ITEMS entries. Before enabling any new {user,sys}data
+ * feature, number of entries needs to checked for available space.
+ */
+static size_t count_extradata_entries(struct netconsole_target *nt)
+{
+	return list_count_nodes(&nt->userdata_group.cg_children);
+}
+
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 		size_t count)
 {
@@ -810,15 +820,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	struct netconsole_target *nt;
 	struct userdatum *udm;
 	struct userdata *ud;
-	size_t child_count;
 
 	if (strlen(name) > MAX_EXTRADATA_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
-	child_count = list_count_nodes(&nt->userdata_group.cg_children);
-	if (child_count >= MAX_EXTRADATA_ITEMS)
+	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);

-- 
2.43.5


