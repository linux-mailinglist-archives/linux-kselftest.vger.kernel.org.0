Return-Path: <linux-kselftest+bounces-18598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF3989E13
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A431C21FBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA718871D;
	Mon, 30 Sep 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avxenz4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAA18787A;
	Mon, 30 Sep 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688274; cv=none; b=j1YN4eN/J3GTkqzyRaf5qK0YjKBZ1vkzLxl9NHLkXWqynP2adDbBptQ8oHj/bVEhdZ3hVpgh69xCQuqtOlyDL6wZ/7iR/H92YM41tmM5BAzym+vzcjFugIGS3zZbaTHdzrGQ3+gmYdGpr1UizoEStS7xA2gl9rb4f50KchJ8gmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688274; c=relaxed/simple;
	bh=aSJHnwLd+K9ZGbIiQVFsS+IzqDJ8vjHW7P9NEoFwMjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSbJQeUlsQ7fOgc0bhEEoSY1mkfBXZ0HDIWfweHUJ8YJsSAVg4yQfP4wzTZExYgVaC2m+OxDcbcAD1EKyxY62Kv9wFCGy+81yHr0Jfshuv4NGd0XSQRXlhC3VE8nCbmM1M1Idsm9Mz/BYvy9Svzu3vhG3bCfZ9kzwaKsN6vSszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avxenz4Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b0b2528d8so45073345ad.2;
        Mon, 30 Sep 2024 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688273; x=1728293073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fDnk76YBk2HdHYhifhj06fLiXAtRu69Vl8SRoKtbp8=;
        b=avxenz4Q84lr724/LgWjrzD5sD1nr4MVOEaLUidnRkBYkG4HZMFTSAZ+ZtQbeu76xx
         6tEBsmOrVyRG728cdvFETngsVF8WPaa8qSmJkkwMFqKjQqeHJNGTcZM5eNS0oJQHHk7Q
         R0ttVaUYmT0EMWXxOkgLWn4eAS+PYn3lXkUpss8A+0BVJ+p1bie+Uc6RMhXNvy4H7wK5
         +Gy70iJSFVxmvDsjr9/TNDbwmWHHpiwdooQMbn9SfeR4xqnj9M8sWUdQmepTDqkGPleq
         UlsaKbp2V9Bf2T7ksBPH2MK5snRbRSQdmeTSRRJyUibFgkXoVvG6d8Kep7etri2O887f
         e7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688273; x=1728293073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fDnk76YBk2HdHYhifhj06fLiXAtRu69Vl8SRoKtbp8=;
        b=Kav2/XWtLF2ct11QvOHy5bqGde2MuP2D3PHGHCzTY96M4BtdAsKjxmu9uXi0iyCRPk
         WFIGyKEET8EYCx2QZfT6X51xah89ushcgECwK7kZYhKAmmqS+LT1noGqXVK4A20rMlR8
         fruk8ZDkgKWQFwdmRWumriXdbPLzagXs63wlb5hnrLx/BTl5o7AlJ0q1JW0bKzgc7B/8
         vCfq6A07y/13obS1IUo8S8vm47jo7Nw3/BIdRqz0I89vZFEpH7FwrWo+LLc/qaiHSKbq
         Kqzd4Dyj32BFcjef294kfwNcTMFb/gpm3AI1naHYO0yGoxQwcNespofIS2Ei2Bw3LuET
         vj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS957juFtm6wugslw3UkGr79yiY3C3/p0qdxKqrJzYcHnFze/qMkhND3xiApSX5wyKa36zjCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIn9vAHQRsQyYjqkSYl617wdJg0prAlGBzVEUezlVjCUV7mJ4
	vr7mWTJ2h1Qkj1j+u4Hi2wCPQQCCp9VCfxHDEhoYvM+fWG4DRdBS
X-Google-Smtp-Source: AGHT+IHMrbZyqJTrMJZ6SRpeLdE58LD8fW0VUFM3Bf7iZtloDqpf5652nqmPY4R1PT8rMENLyRiT5w==
X-Received: by 2002:a17:903:2446:b0:20b:6717:f5aa with SMTP id d9443c01a7336-20b6717f88cmr85559825ad.24.1727688272620;
        Mon, 30 Sep 2024 02:24:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5eda4sm51015485ad.48.2024.09.30.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:24:32 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/3] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Mon, 30 Sep 2024 17:24:16 +0800
Message-Id: <20240930092416.80830-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240930092416.80830-1-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Let it be tuned in per netns by admins.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/netns/core.h   |  1 +
 include/net/sock.h         |  2 --
 net/core/net_namespace.c   |  1 +
 net/core/skbuff.c          |  2 +-
 net/core/sysctl_net_core.c | 18 +++++++++---------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 78214f1b43a2..ef8b3105c632 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -23,6 +23,7 @@ struct netns_core {
 #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
 	struct cpumask *rps_default_mask;
 #endif
+	int	sysctl_tstamp_allow_data;
 };
 
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..4f31be0fd671 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2808,8 +2808,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
-extern int sysctl_tstamp_allow_data;
-
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index e39479f1c9a4..e78c01912c64 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -317,6 +317,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	 */
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
+	net->core.sysctl_tstamp_allow_data = 1;
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..ad727d924f73 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5506,7 +5506,7 @@ static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
 	bool ret;
 
-	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
+	if (likely(READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data) || tsonly))
 		return true;
 
 	read_lock_bh(&sk->sk_callback_lock);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 86a2476678c4..83622799eb80 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -491,15 +491,6 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "tstamp_allow_data",
-		.data		= &sysctl_tstamp_allow_data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
 #ifdef CONFIG_RPS
 	{
 		.procname	= "rps_sock_flow_entries",
@@ -665,6 +656,15 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "tstamp_allow_data",
+		.data		= &init_net.core.sysctl_tstamp_allow_data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
-- 
2.37.3


