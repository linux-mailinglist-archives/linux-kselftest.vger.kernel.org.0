Return-Path: <linux-kselftest+bounces-17207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30096D03E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2BB2276B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C660193065;
	Thu,  5 Sep 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3t8QCWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42719309E;
	Thu,  5 Sep 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520684; cv=none; b=R2L3qv0qOQr8NqUk3iOsXpbLN6Zqf7LZL2e/Qrt3ZPH06+ZcrsC8LJHYU6ebDSOWGrEG0jJWvPJ1eT/xxV0jBRno+F13L/BB8bwRKQe0zdM1sa9dE9BX12BBtFeloiBVjVchIxPVIosyYVTOdzX/koYpvXU/Bmq5hm5EAialx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520684; c=relaxed/simple;
	bh=e5eurefDLwBpTLCJOcGL3UM1sOupQSYqKp6w3ch8OjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFTY9zJFu066A/S1z1A98bLAC/czBmqpJue014TjZj1mCBCqif4JjY1GVTTsP9ZombTT6jg6UsCD8wFdY4coc9nX0Oz8c9ftSxHjg4DL+EyiVbkiiaPuCAVN5TtoydKdnKwy+cPyRfc/IVhU1pZDjKUIwsPL8lO1ONanXjPAN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3t8QCWZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714226888dfso365181b3a.1;
        Thu, 05 Sep 2024 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520682; x=1726125482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjT0OS+OKNHcBBxpm+XNUrjLujslH+p3LNsUZFLQoW8=;
        b=B3t8QCWZjs8UUZ1H6u91xH9YKXfmZ732m1NFHEegVYlElL2e+dt7K4GYPh2TLWGNyK
         gwn88VwGBBVURhGMktBCXJtJrvaLF3cYoKI3ElBcidJnodNI2oalNgklvlsrnFbT9sBl
         +QbHNjejEYpwElxSBM+FJfgcSBqHL+UTaK6oy40N9g9gF8TKuobvnMknTFIRwEYsaMnk
         ySz8FjkN+eocez+rAX/+Ftn1KyBZxBLEj2HvXm9PCyL32aIsHccDNjV5iBj99ee5AEaU
         ivZ1UgjgIhRSHfol0Yb5RgpGSHeQ6p9tCTdpa8yELYk+gqDgS1KNxnW7Ry850JzITAOx
         BBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520682; x=1726125482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjT0OS+OKNHcBBxpm+XNUrjLujslH+p3LNsUZFLQoW8=;
        b=Nf6W9HFjr8f0mhPsRVDIsCAdfBEHlRyfhTEfOCVBkI8fM7vpmBwmTW3srYbEAsr9vJ
         r5PgaEm80roEmCKPfrr2AkTui4Z+1qOm7JlVTOsJrAPPkCw61DZfYyoONoXKxdf9t+so
         it++9YZdvG1VfKnUZFdpWnTIamz5Qec9daMMXJaujIoeUSMJJRk2Fc0nJ3mmt/N5I/K7
         Clu6t9xLfX7ewCOhKRAWaFhinzJMiH56XR7daQ6nbVe3RSDh1iD8S0H85nK+D8dJ5TN8
         2nb2ANdhx3XwARtkQPq04oNbKFPjOgA3Nsjejjc8uj/+F7raEJHZmoNIcGr/04SsIllN
         7tzw==
X-Forwarded-Encrypted: i=1; AJvYcCW99gWhbNQY2hS83unDyKcmrtHcvux6CpoTOl5101y+J4q3EzPsElfWjqxoidPi6gCQY/wtC9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFI56eqg714YUyzknZaFAZ+y+RBoD4Tm8qE8Cq1N4vKT8zGZA
	CD9BsKlbhb+dlPrfTE6f6bBfO/nmWoAZVgJpBwgPwaz5Bd8TwQ9b
X-Google-Smtp-Source: AGHT+IH2AyA8kWz7CrbTl/ZEYI/tNCmZX+hDCLZw6KsewAB6lN5rO8IFQigMHVIFo+pB214du9i4tg==
X-Received: by 2002:a05:6a21:3a87:b0:1ce:db9e:6ea0 with SMTP id adf61e73a8af0-1cedb9e6f70mr15656388637.19.1725520682108;
        Thu, 05 Sep 2024 00:18:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b19sm22929425ad.61.2024.09.05.00.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:18:01 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/4] net-timestamp: extend SOF_TIMESTAMPING_OPT_RX_FILTER for hardware use
Date: Thu,  5 Sep 2024 15:17:36 +0800
Message-Id: <20240905071738.3725-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240905071738.3725-1-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the previous patch, we found things could happen in the rx software
timestamp. Here, we also noticed that, for rx hardware timestamp case,
it could happen when one process enables the rx hardware timestamp
generating flag first, then another process only setting
SOF_TIMESTAMPING_RAW_HARDWARE report flag can still get the hardware
timestamp.

In this patch, we extend the OPT_RX_FILTER flag to filter out the
above case for hardware use.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Link: https://lore.kernel.org/all/20240903121940.6390b958@kernel.org/
---
 Documentation/networking/timestamping.rst | 15 +++++++++------
 net/core/sock.c                           |  5 +++--
 net/ipv4/tcp.c                            |  3 ++-
 net/socket.c                              |  3 ++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index ac57d9de2f11..55e79ea71f3e 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -268,12 +268,15 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
   each containing just one timestamp.
 
 SOF_TIMESTAMPING_OPT_RX_FILTER:
-  Used in the receive software timestamp. Enabling the flag along with
-  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
-  userspace so that it can filter out the case where one process starts
-  first which turns on netstamp_needed_key through setting generation
-  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
-  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.
+  Used in the receive software/hardware timestamp. Enabling the flag
+  along with SOF_TIMESTAMPING_SOFTWARE/SOF_TIMESTAMPING_RAW_HARDWARE
+  will not report the rx timestamp to the userspace so that it can
+  filter out the cases where 1) one process starts first which turns
+  on netstamp_needed_key through setting generation flags like
+  SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process enables
+  generating the hardware timestamp already, then another one only
+  passing SOF_TIMESTAMPING_SOFTWARE report flag could also get the
+  rx timestamp.
 
   SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
   influenced by others and let the application choose whether to report
diff --git a/net/core/sock.c b/net/core/sock.c
index 6a93344e21cf..dc4a43cfff59 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -908,8 +908,9 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
-	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
-	    val & SOF_TIMESTAMPING_OPT_RX_FILTER)
+	if (val & SOF_TIMESTAMPING_OPT_RX_FILTER &&
+	    (val & SOF_TIMESTAMPING_RX_SOFTWARE ||
+	     val & SOF_TIMESTAMPING_RX_HARDWARE))
 		return -EINVAL;
 
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a0c57c8b77bd..23f0722aa801 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2283,7 +2283,8 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+		    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/socket.c b/net/socket.c
index f8609d649ed3..bfbae2069fbb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -952,7 +952,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+	    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
-- 
2.37.3


