Return-Path: <linux-kselftest+bounces-10772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE2D8D1AC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3468B24C80
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153216D4E1;
	Tue, 28 May 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXRV9Geg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6116D33D;
	Tue, 28 May 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898318; cv=none; b=chIpqN5eHRwUHKdAspzwejVWLnTm5RRhOuGs+GOBlYYRdelwDFZfQq4WmU8uZt/jzdZ/KmhzR4iKGcsvjBbU6Umtmy8oJ1D9Qi2G2Ygt8ExZ6oMJxNzTiQxhS6UkMikkv9D+TaAkS1vyJXbAbFmcct1jEwlA7EhrrnRnZTA33b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898318; c=relaxed/simple;
	bh=2Zn+MRzD4zp2At5nMXKJJkFkLHFklXmVoSaWizj+wUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU8HrqBkwZysySbpCw+y+jm/1Z9h/hsitTNVJujgb89vhylTtBCeCm2ShDk7Hsb6HwE5Js1OBpu5Ie+RkVg8WHe95Khu1ha4BeyZqcSEUwm06Gyib+fxwlZprFkuTeDIqIKOOhzfKhGeUzV/qjTNhz+61ANBHFVIB3B2i8qQCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXRV9Geg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295a66e775so953079e87.0;
        Tue, 28 May 2024 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898315; x=1717503115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GCONS2GAp4x6IRgECj850ZtZKPg0LpfTQzn2c2IRsA=;
        b=QXRV9Gegq3sp/jG4410/HlCuffhEvZxtm9AW4+JCj9yHUQhqHzvVFkqh6cR1BNkSWP
         BEPMtiFzUcBwQ1KLsdqr4HXRmaL9clXFm+tZjUpgyjAejZKey3smpcUoZQcC4ow9dlex
         qzJRHA4OjGu7w5EiGGQfrNdZCYlVd8AwnM6kcAXmfKigmrqKyoyaa0pWyhBeo7VAB3Pe
         RG43XsllUb6LYt7p+qB/8swhtGacQk14v3SsjYjoimR+wkahvz4SbOqO15SzBQKgde8d
         MNtOjJDbMys6SCG9c10zcSg9DKNk3CkzvEMEx2Ygjk9LZ2yIODdFA1Wy+EYlBEr/NPn5
         sFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898315; x=1717503115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GCONS2GAp4x6IRgECj850ZtZKPg0LpfTQzn2c2IRsA=;
        b=VWl6LGG8xFG4eV8KlJB+T2sZxu5ZX5ueC/iP09IE53AusqjiDpJZEXlaKih7ZiChnj
         c93dlFGee+WPOnF/DMKlBkkxYd+a7CiBpIALHgypshr/bIz0NszJ+ryh2jgYP1uyP57m
         QTODcwJmFaJ3gGjwZzu0FIJlYoQrB5+DWFLJHREUwGqYKRP6ZX/eOlo+gnmjhqaxuWIW
         H5nmmZmbNjwL0y3qM+yVlP3/Zybpb2Kci1zy7CP8ZaozBIhIZWIPilwUQtMtZ1pbamXj
         9InuTeqqGnpeQeidmQQJxPfpihykhOrDYp7VR8/sxbhDOZF69taietYsliPKzl2QOZRu
         Tg6g==
X-Forwarded-Encrypted: i=1; AJvYcCVoZKBeoN0Cec5WmCaXq7AfS7agu4JHLrk2T67lDf+XqNK4SN2i9C3s2naPFvs/s9z9+5B7jPCjs7Pd0Vd8hpfUag49gcqTdm7P8YCFSUfar0a2XnUP127Eximp88I44w+PTbYqfcnXU4YZDjf3
X-Gm-Message-State: AOJu0YxAQ7oxHc0VWkxcYU2qwg6f4HlE4LncQlwoTCvDOCyI9mImeHuA
	9MsAcdzhE1xpTKORMqG2I3uGmOZk2EmYGtmal6wBPVcK5dNM46su9PQMcA==
X-Google-Smtp-Source: AGHT+IHLoKJW9gYTiZmgGvjUX7J0oD6p1n53NaBKNRdc47YE8B3TG4yh1c1muu9i1+QjWvSF/kZqYg==
X-Received: by 2002:a05:6512:313a:b0:51d:9808:6645 with SMTP id 2adb3069b0e04-52966e9aff7mr10239556e87.50.1716898314364;
        Tue, 28 May 2024 05:11:54 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-94-218-116.cust.vodafonedsl.it. [5.94.218.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f69850sm168281625e9.26.2024.05.28.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:11:54 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/2] net: make net.core.{r,w}mem_{default,max} namespaced
Date: Tue, 28 May 2024 14:11:38 +0200
Message-ID: <20240528121139.38035-2-teknoraver@meta.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528121139.38035-1-teknoraver@meta.com>
References: <20240528121139.38035-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following sysctl are global and can't be read from a netns:

net.core.rmem_default
net.core.rmem_max
net.core.wmem_default
net.core.wmem_max

Make the following sysctl parameters available readonly from within a
network namespace, allowing a container to read them.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 net/core/sysctl_net_core.c | 75 +++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index c9fb9ad87485..2079000691e2 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -382,38 +382,6 @@ proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 #endif
 
 static struct ctl_table net_core_table[] = {
-	{
-		.procname	= "wmem_max",
-		.data		= &sysctl_wmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-	},
-	{
-		.procname	= "rmem_max",
-		.data		= &sysctl_rmem_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-	},
-	{
-		.procname	= "wmem_default",
-		.data		= &sysctl_wmem_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_sndbuf,
-	},
-	{
-		.procname	= "rmem_default",
-		.data		= &sysctl_rmem_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_rcvbuf,
-	},
 	{
 		.procname	= "mem_pcpu_rsv",
 		.data		= &net_hotdata.sysctl_mem_pcpu_rsv,
@@ -697,6 +665,41 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	/* sysctl_core_net_init() will set the values after this
+	 * to readonly in network namespaces
+	 */
+	{
+		.procname	= "wmem_max",
+		.data		= &sysctl_wmem_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_sndbuf,
+	},
+	{
+		.procname	= "rmem_max",
+		.data		= &sysctl_rmem_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_rcvbuf,
+	},
+	{
+		.procname	= "wmem_default",
+		.data		= &sysctl_wmem_default,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_sndbuf,
+	},
+	{
+		.procname	= "rmem_default",
+		.data		= &sysctl_rmem_default,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_rcvbuf,
+	},
 };
 
 static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
@@ -724,8 +727,14 @@ static __net_init int sysctl_core_net_init(struct net *net)
 		if (tbl == NULL)
 			goto err_dup;
 
-		for (i = 0; i < table_size; ++i)
+		for (i = 0; i < table_size; ++i) {
+			if (tbl[i].data == &sysctl_wmem_max)
+				break;
+
 			tbl[i].data += (char *)net - (char *)&init_net;
+		}
+		for (; i < table_size; ++i)
+			tbl[i].mode &= ~0222;
 	}
 
 	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
-- 
2.45.1


