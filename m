Return-Path: <linux-kselftest+bounces-28884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14ADA5EC4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B603BBDE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6ED1FFC69;
	Thu, 13 Mar 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ECdzwPAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74535200BB5
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849305; cv=none; b=eeYVdfHbjzxjOh9E3rbGDeV70wt+z4kFgE0yNL6rykoEcLfcwv6ax7tpDrC0k64UkwdzcJFADPW2nHSODgB2HXWI20/txdXWk7PNNCuOYG3SHgwRlO+/uVa+FE8498UgMArYfJPMStQJtHR7GNFiI1akCciGKl/y7P4BrVT3sWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849305; c=relaxed/simple;
	bh=uj6BiB0IqVm8+xs3f9Zn6aCjK6f7zlPp0hv2djTMvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=OqdR1mbMFJ6D6C6F/A0LRUZ2AZ8ABhzPWubNkyJcE83liqOf1chAB9nD27Nm+mHIF3qwqQ0DzPeOrdnRVbLG4s0b1qcXY3H8AjEolV+8I7HqVG3J0lMcH8haZeHKPWJYi1R7OkTkd30PWz33KXNhb0Rfkqddu/1UxjMIGHtNLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ECdzwPAG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso12411215ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849303; x=1742454103; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=ECdzwPAGAoCSWTXNIPQAxfcp5P5SO/fvBwY8wBAZUecHrDq/oB25D5UMWszSldfTLP
         p5QDz7GxzNr20zvrqcBBLrPOhOkButkAn7HNPGKGn72o66/xWBn69cIc8OwYKzii2YHF
         UTHRdX1A7gEmF0OytmdVJrL9JF5JwU9BzZgP2kXboWM7r1e4HjB68MGU41+fgxzmdpBd
         qSs08DI12hK+QOphesK44Ut/fK55/lQt0/u3Lyr2X3iiy60Wb7Oh5Qehrr+3n0mE/EtG
         +zdg17kGP3uJaj9moQmRyyLwDMfU7aniXslS0xnqhH4oLBRi7FOKo4xuA1+QLLWqO7uf
         X1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849303; x=1742454103;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=n0MfWo1l08DvgffScKZuLYgE63BZEH5gxTDbEpoAaiXdOZs7aUsVXgyXjYXe71FLpp
         VQBCutxSFUJsSCZ3BJplhCqqpXGZmf5aF5A3L963HE46tAsfBzRuIcGpLaZcpVhlHNQ8
         EZi3iVALo0nY+ANOVEfwTTRfCtbOqZK/Gdb3U83q3czowvG1mZGU1CRFa2/XEJ9MbLGy
         UM90DtzAeac2kBJOelDiwxEHT836M0lVylnCtmspNsQy9haYGpDbep8JzE6ok9hFTs77
         mHaQt5mqQcnLwjGZRdSl4etml7xHgmXwT9EpaV/sQ/iEubk8eAtIpmQbTD7WZ+17bWzO
         VSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7RNGEnuqxwMp3lK0MkMx4FZc3+H/lC5E6VMtQu4fXIgOumJQJPWJfFEVvJPxf8JSFxxiojEC6WVN5qT/Tr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0nZa+BNQKZyoAPVdxSTfnZDn/S9gjRQ3+7mI34n8FkCkddht
	y2zTQENAhH6dV+ACW6M2YoVwlAaZ4FGj2qkeEMUd9xxc4Z4OtJ5r76NTFh4rddw=
X-Gm-Gg: ASbGncuASvfu2/ga8ZGHfjPGiVQDfchz+GJ3PQfVM7dGTPBjh+2fQcEmagn0f1fdqBP
	9lmA92Z9dshyM3nl03AIyGso2EdA1668I3CpGJqQcKugaPeGnSdh+HG44u0MM6+AuQB6zLANMCh
	IdRCftLSi7/gDZowV7nGUY/MGSKf8DA2rcI2uMpPl2gX4GSpWyIAlShnsxWMZcee15NVvs6lxy/
	z8xXz5LfXFfudZXOJjbf+pOijGWyTIch3JP0byW4kyXaf8XoqiG5CzwRoPwIc/LXYrF8+kpWyMP
	YIyMHayo5mIIUSpWcJhMgqTyAteQ4CNQTbLqpyMrahRzfMXF
X-Google-Smtp-Source: AGHT+IF41bM6O52nxyqfLS5xcbnmD0BRXYmKkq1aTZiZh+PP5DLgrJ3Gf/DAzNS+0zNbGzXZ+/OHfQ==
X-Received: by 2002:a17:903:189:b0:221:8568:c00f with SMTP id d9443c01a7336-225c64097abmr19829395ad.0.1741849302826;
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbe84esm6495685ad.176.2025.03.13.00.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:06 +0900
Subject: [PATCH net-next v10 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-3-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.48.1


