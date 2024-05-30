Return-Path: <linux-kselftest+bounces-10971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C88D563D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665561F265AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B53181CE5;
	Thu, 30 May 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2kjQBsP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFA4D8C3;
	Thu, 30 May 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111665; cv=none; b=H031IuF5sdsDAT2ezHXVGGX0gbOiUhYgNCP6FtjECk0R8SHNCQzwLuXz9oeSv3EekNArS+9a0YuJKhi0CJsfeV9f3DmwfhXQpM3BqflJF8XWw70WdyIJVqnycB63+deMRbZE0XDmYdrYPyE7hdWXnjOuWmtSkQNxwR8E+nATZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111665; c=relaxed/simple;
	bh=x/k6Kpvd3d3Dt3fnD5caMY+otK5hlu1tQbKkTc66ihU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLaqFRTt5o2Z9V7OBUZJXcBs7oeUvyImPu7BB9ZtkpoX3n43SQmWkn7KIIHa80OzycABLI2oLyPtgQE75LHNXa/A0bCTebDI6JDLrLqyTV4HOMviL6drJwLvVG5aRmOLELlPi73eAg8uMwRY627moP1Y4AtbX/WNRT382UJ6pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2kjQBsP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2254573a12.1;
        Thu, 30 May 2024 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717111662; x=1717716462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSLJvHjzEW7OFvjVKUT8WVkEESYqHYJbjaoB4OVbctY=;
        b=D2kjQBsP6WCvcJ9FRhJsipvShiNiLPxCKbi3p1zZooqtdt1aisVHJT+vD4VZMR0U8/
         Wj8r0I9yGMbt+XOdBMLsf0cxTKrm6JcJochiUuZ2KhIkcNhP0uLTF3f7cga7Ikuxd7+u
         BWxxgKphbKED5kDqfil555mETgfPahrLQ7WoQJMRVTH6G6J+5o2pVc2vVbr07eXYvUZN
         7dgSf0D+0bm9Volpd6JBboAoaIeEVlbIh80lUrHjpkNpFRQFgeLOhfTDxKhFcxTAGtkI
         /n6vSu733LTPOOe3+cSmYUsBROswBplf6EhHqZrUePkWJ0H1D9gaN77jDkybFdanRA9G
         b5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111662; x=1717716462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSLJvHjzEW7OFvjVKUT8WVkEESYqHYJbjaoB4OVbctY=;
        b=lmMOhL8o2Wa/C2XpxkKFgLspB/C6Ezc4b+w/lKBXFLAbDdyDXPKJ9r2YxLrv1V6xb5
         3SJA1nKFvafgY43H5xRniE4SQctX6WJzfs9gRGZ7gugD+77AU+mRMGiEN/XJQip+eefR
         d/N89aHd9YbSqjGSCabABdAi44r8xufICw1aP4WX+sEWPfzDWS6EUQ5QrQ7J5AIrJALo
         +Z0b3mjLDaD8Z5v715bTfmTxWpHTpN3mFXVf3AVyOnmCIhqr97wjt3dLpuMuTeMA6yWr
         FkEgz5fzlvHCaXQeGIUX9C8rc16xVhgzjs34tNxDz69rr7GRDmLPIhHa/3zfFisQSg05
         JOBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCsHc8AYyN8mzFeIP75Gr7G2r/tV9rxR7z/l9knY5svpXC8fqau+kC95bw6nipGrv1yDxilh4T6xBTJriSoomGYVT/GvJxZmvk51yyj0ssPcyNPnuatAF/G0frKqhv9gdKBcUSG/713DU7YRde
X-Gm-Message-State: AOJu0Yw2sfNxeh1+Q+IoZNuQzTEri/9TXsjsEUUAsa9FUpnAx5h+cY3j
	dBI24gBJqQFhgftjC+7g3Dz/xSjpq1cNVjez9Y1LI/5x0enMShGIdvV9SA==
X-Google-Smtp-Source: AGHT+IEBAW0TjmtzG+Sjm6uDWd/Li+E2qd5PmPGUZOyyTg49iDQUIvHu+qPLEL14CBstls6nq7rWYg==
X-Received: by 2002:a50:9f61:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57a3644d2b3mr288091a12.16.1717111661820;
        Thu, 30 May 2024 16:27:41 -0700 (PDT)
Received: from lenovo.. (mob-2-43-182-132.net.vodafone.it. [2.43.182.132])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a35e86c36sm197223a12.54.2024.05.30.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:27:41 -0700 (PDT)
From: technoboy85@gmail.com
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH net-next v2 1/2] net: make net.core.{r,w}mem_{default,max} namespaced
Date: Fri, 31 May 2024 01:27:21 +0200
Message-ID: <20240530232722.45255-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530232722.45255-1-technoboy85@gmail.com>
References: <20240530232722.45255-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

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


