Return-Path: <linux-kselftest+bounces-25664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B750A2705A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FC83A60FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398C20D51E;
	Tue,  4 Feb 2025 11:35:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A120D4E7;
	Tue,  4 Feb 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668937; cv=none; b=IwFRcnpSIhcW9NdUJ69QvK5PgLLO7BwnGBHIsj2zyHNYcm+Ues09HHru1g9eNx3JsARSThvt8wFCLzsrWH+N2vo3xDlIEfJJyRWFqhwaBDF8/UDR4Y+bTTToXlwM3JPwi1mVXyK/1mTYTRSoGxBc61s0b3rMva9dcHiuAhIjX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668937; c=relaxed/simple;
	bh=IjZkiLAW4iU2C6hZ49uxGABatYfCQ4v/9ISyIy6t2+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8O5hpwm/b6iotzaAgiD7c9nvKqHWWGEKlfXSYrMGiaY8kxrTGtwSnOGng8nbgdfPJW3ZKSyfh41rJeyjIy9O5LVaK3aqaqPpbAdk3lNd5mOuJupKMpoprCapJD01r7mesJ3+wlN6o+1eqcxBi4VGksF6YVhTf2gSpXNFqv3xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dcc38c7c6bso1249076a12.1;
        Tue, 04 Feb 2025 03:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668933; x=1739273733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/npJbJcTx1+Ep/iKTQCUB6+kjufTBRaHHPsIia9g2og=;
        b=t3TmADY518g6/g1F6G0caD3lVqsloNtlXZZJ+h9OqEoJ3LgGhVIM3ix2QGjom3sGDJ
         4hOl/O+j0c7sKdsE8n9AFFp8CD5Uh06LsEWwUMgjw9yiPi9djFpo+Rgr98+2B5KOUT/v
         oLHAJ5+N1HbV7eWFlj++R6wv3fkRA8iVKvFKTjcUuMVXcV31RcS8ECIPEHX2VL6aWY9b
         ib+tD8dVM8d7GS7z9yg36NU49E0wZoDZi/kfmcjcG4SZ9/QLKUmpyKQA97BMMAiWLPWt
         oRNwHFf7rFiYr6eS4nMmTMaZH4HLYhJu2BeBvcVRSEp0UAJlXWuoqrqYgiHKKthbhru7
         70xA==
X-Forwarded-Encrypted: i=1; AJvYcCUzxSWdmlfSiuW0AqS/ehHk6atXj7H+Vd2cy9rLvabYWS9SX0USpbeZWavCLG10QOtliqbGS8MfPdE=@vger.kernel.org, AJvYcCWNfd5QeavmpgaLcXEz+uSTaCGtUa0Hqwf/LjkW49esFlokziMRTchkNIiuRmC6VxOgIgax09oqMMIPbO5T@vger.kernel.org, AJvYcCXyev+rIhKcboTt6Kqhd4clQmlCoMmgfSBupqBs1dtWzgi8jkry+bXDEKhSkG3T3uImAA7MbFRnUjXeTnzC+xVx@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2PXixOA20NlWi7bipGFjx1Of7KsvdPxwYKeqeMnq2td46qh4
	wc7Rb8pGl5wpxKxdGrOXJ7UxCYCdBGf11YAaDJP2Pur3bQguOeQKAnOGTQ==
X-Gm-Gg: ASbGncu+wzkM/g6/fUy6L7kE9XVLKDvkyNakRDSc7yIdxoQzL5cCTWN6jjig9BUtgGA
	Rkj5TjGtTsjZsD1deCDSTRZunb4+J0sXo9Vh7Wk98+I2p948VirvkS+h0Aw6jBijTqFtgkfjCRd
	eOz5LyLbv6I4GozOhRdNKByDYov5O9/XnS90oTqbx7+TNWVYkZt5tgnPOe5uvUsgDm3AhkZAZw/
	l/gHYUut3o9jFe1uOMEhpd8kAMxd5ZmV2Ush40im2F7289PBpwYsdPfk5kshynQ0UHE41DQzk7N
	FW/jJDI=
X-Google-Smtp-Source: AGHT+IFuTFVdhB6HttmAeptILiHpRNNaQj+Ayc5Uuxq6nCzfdtwIzl0gTB+Frn8vEzevFTlYmsZ45g==
X-Received: by 2002:a17:906:730b:b0:ab6:de39:c7d9 with SMTP id a640c23a62f3a-ab6de39ea32mr2606500866b.33.1738668933266;
        Tue, 04 Feb 2025 03:35:33 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cfba6sm925768166b.57.2025.02.04.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:11 -0800
Subject: [PATCH net-next v4 3/8] netconsole: Helper to count number of used
 entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-3-9480266ef556@debian.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
In-Reply-To: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=leitao@debian.org;
 h=from:subject:message-id; bh=IjZkiLAW4iU2C6hZ49uxGABatYfCQ4v/9ISyIy6t2+4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+19NXucyGY2Sc0HU5ODXEFJ1WKoE2wCYbu
 7NeKRZxK8+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bZxGD/9prJB3RycqyQ2grUimSymowHKl+aicCOhtu9warJXrMnhl7KsrDhPJj1y7gB84FpYhV4o
 Sq7FsMQfIsGRFr0Py44MXVmoDVYVx1yrQPd+76FVozfozGpOy+IPYaSZwcLxs2Vyw1UwPgR65N+
 tIctdopM7dtpvziSc/kGZkuBC2X2Rxy7M9bbTbqX66DBzvJ+U9ySpgO+bKIaWAsWiGJ7r0Mf/ci
 dxgDGM7q2Ttm9td5bncZ/Tbb9LNvP/w7M3uCWYacSLhBijnd4CQBTiwYvIiuPd/NakjHNjyiHsy
 ZGj0KqDr9UjOuR6nmHA1BOVFU/7B0gYqz1tui5OG91CQx+BFz7GdlO1gaee7h4G5Z+bxsKB801K
 Sw4WAI4PVIoB++/h9WmlBr7YYRRANOyffjCAlVEGcuIPI7ohRqvbsl7LuPsZyLR2SjsI2X2NUp7
 6u27cC1swLccvVkZoQo4/tGqoMSn03jV1ZWnaXMJFIYDfBgU2RrHYGvh0rUGO6vJpsi9fdpztbl
 WB9tkX1lF9fr2LCrDyruoiWVXxQLUQCuDoohceyPr17D9M2vj66XdzXewlhQzwXESqqELeJ1jFk
 AlzWMkZKN/Hobgg91MZjLF/8Q3A6iF675ocmyTt7zKwM4C26Z55MOQBh+ArCYdWgFDRMGULboHB
 yAUa45SyHMxCotw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a helper function nr_extradata_entries() to count the number of used
extradata entries in a netconsole target. This refactors the duplicate
code for counting entries into a single function, which will be reused
by upcoming CPU sysdata changes.

The helper uses list_count_nodes() to count the number of children in
the userdata group configfs hierarchy.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 15867bb481e226cbb4164642e470baecca730a40..bfcc3809f4b5fa351c8e7e6340a54e93d525aa2e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -662,6 +662,16 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
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
@@ -811,15 +821,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
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


