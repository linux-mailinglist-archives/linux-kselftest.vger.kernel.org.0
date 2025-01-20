Return-Path: <linux-kselftest+bounces-24770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76141A16897
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3161636EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510DC1922E8;
	Mon, 20 Jan 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gHz0AYG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2C192589
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363648; cv=none; b=iQJZXdBprjoJ5qbcUU8A9SoizN5zM+/SpAG0C1hDpGnm0f1f9rksKmv0czA6AY/R4rfxgI53C17hzqYYtZl2FvplAXdACYxhH34x9YqxFcjYQKOdNLhCbIq+R+Mg/dDLElUIgjUfIc0hF13/A+ZJzbgXRLYvG84WRHrfLwOdFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363648; c=relaxed/simple;
	bh=LM9iW/m0YgbRl7+h6nWSsqFiOmAXB2xxJK4cNTPhNBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBjdZWxgi36CrXxwtwLP8ciCQs4D6f2ZyhCsvVZzNZj2q0frFbAIi37+jCigC5HPxh+9WPhkxiFV1VcOfrRDeB0osBhioj64aAW+Vwo+qzayH1/qnaMY8UJFChMkoSwkVUcSLd5VlATuly08TZuFs8Kv5HTVCPHj5zXYZ3PT4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gHz0AYG8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so73183535ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363646; x=1737968446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRUixS5CfbfDqt7hn3posZxB5lUwV0PPemsSCTV1gNk=;
        b=gHz0AYG8LWeBNVryG4/GIqNJd33MZxjFXqx8R6VBIpKM8RR6cnm/MBpDPJJqXE3uSg
         mO0MaT+RalV0skJ9XPhDM73FJQR3M0En87H+nojWMLTkc2OB0xeKnCXEtpCznIkkuFyA
         +G6mCLqJ7byNU9GPJo+b+2Bb0j2s2Q88NSouQZ2JM74vRln9+w7r9/TWqbcO44AYD6JA
         oxCcIq5I/jEic7PlWVjtbQhqWAWQc9A/7Eoo6a3e5IyIvQYp3y/Y3hkNs/2Jy6tyHAu8
         butLSezhjU0wSbRXhv81uzPhlE8on/JcxiW6GdOQ4IJ/jManHSMMinC0vMaGqUbkWSU6
         /QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363646; x=1737968446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRUixS5CfbfDqt7hn3posZxB5lUwV0PPemsSCTV1gNk=;
        b=ZYVlrN88GcN0RUfET24h5qmTqZ+wwjKuLFfunVRzx/96Y35jC1/JdY2fe4jefh++/u
         DQZqMvpshoR/WXaV+dDo/paR/z/UqxXZL/UMqM/RsgvPq8O5uG5oZdvOWLg2brECLo2g
         UW3PhK2gJjNHwbP14A0Jl1Urnpn78mNCCzRsAgsEKEyBjfNK/Uc8URZPzHABDrNhoqtX
         teugC7jc5uUPbhJ8m/JSt2ICZ2LK3uNLY1QhGzEkln0llg3aNA00Mrjwi2YImfzGqp7D
         KX7YtVP0Ia2/17l1S5fZT2rZKN08Ra52FCFnMfnpVfLBrXDQvbOzb/DVLAF551J1ZypG
         7Bqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIbe7eF/WmfVR5UVTNVZ2BcJshJLNHcfJdso64ilL4OY2BE7LXqk+As6gVqrpbs81x0ydeYo/xN7FWCiKbgEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLrx/NzXo/Iyu6TozQvt274edKKVJ+MVMt/8ANwNzdRSF1rNd
	xooe45sIafeZlWlr11fcsbtrPzJMB58AFA1QlliZ6lU1y1vaEu59FyTThwm/TjnyfrYBpZF8RLj
	I/PI=
X-Gm-Gg: ASbGncuoeCFR/9BScsOGmkjad16jV7raZyYxq224IyNerETLTr5KcEFM9+oTzdHdIrQ
	MCjUOsw0JJe9o+MLPHyrZCKatxxc/olnHk/XL2GJZY/kaGXWiE1jXL9w2ys/AEr8zThsoL/x6tG
	Caz+vo0qMiuI0h/rKp5PsXqXUDiqMMxKUIzXwFiSRf55nL09uI7jvQQUAmYkF2E7Fc2kgpJD+lg
	fAlbQ2teG7F05+GrIdohTSqRuUAgeEiiWll/3guKGXui/dC0EedaIzgI5PTMDAEcE1PlO+f
X-Google-Smtp-Source: AGHT+IEks6SKihbl6+Qi45ONgGmxvxvz6jOzu1ulUFye+X8vv37vBy4sWvWutLsO9/Ck2HEV+RAlLQ==
X-Received: by 2002:a17:903:234a:b0:215:9eac:1857 with SMTP id d9443c01a7336-21bf029ddf1mr288703675ad.5.1737363645786;
        Mon, 20 Jan 2025 01:00:45 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21c2d3a913csm56890235ad.117.2025.01.20.01.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:00:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:10 +0900
Subject: [PATCH net-next v4 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-1-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		 (tun->flags & TUN_VNET_BE)) &&
 		virtio_legacy_is_little_endian();
 }
 
@@ -309,6 +309,9 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +322,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +335,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
 	return 0;
 }
-#else
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
 
 static inline bool tun_is_little_endian(struct tun_struct *tun)
 {

-- 
2.47.1


