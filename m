Return-Path: <linux-kselftest+bounces-24625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774EA134BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49873A03BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102E19F11F;
	Thu, 16 Jan 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="IOwbooti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02A19D082
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014921; cv=none; b=Q5dZuXdtnuH6Pi6Fzktz1ET3ftfZKHYNZWSBSKni757wIOchSFh+Ub+WoaQKxJ2t9Qer4vp3TmLxJ2ZahHIfAVClTtL+kQS/YvMhqKFXLPfE3Rb+m0YAHv89dECa3hkEJxK7+UeSb71CJja4jDL//5yBppbRKePbdt7063WP0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014921; c=relaxed/simple;
	bh=LD3j4cF3ZMXrF9quJO23QS+8dlMHJLISNsvcy2RQu8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=sU80SvXCtKmeYfKJkMqSxaomQmDx3NH6yFrUSV54nFM+MIaLu3GuR1upUfPZZFnWhBF72aIIlcvYMLEFO4VlV9LKlpDogAIoWNMyDRu11XgDRScBiSXW4ZKbF8r2X+0AJuY7PuH0Nq77z6h/6w3KFWyjrWnA8wR1/uRA8y5T1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=IOwbooti; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso9815875ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014919; x=1737619719; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZHCcie3Jz8m8hktWKIHhBfL5Qmb7ZIYIU8qeIL3Flw=;
        b=IOwbootiAoYwW850VVPT8aY1OF8iTAuErzhJvJiWgJ1gOBI9Mpx8HIkEMKXrzh9pAT
         JoMXrRDa1rBbh9r6ejFMALjb5DCYHm0tiglYbb+R7trdij78vAV5eMxYFpvlNGBqpKhZ
         GVYhcqWMh//44RcnhxwfP2pOOuw1HEYhkzs+UccOgSg4kAUal+cGPkkstt9YiT8Q+Rfh
         kr9EbYLw7dIn8/Km7N3Fmz5Fxqy/RR5N15JFVNGVePGeHoTOClkTfdLaSDb3EKegyTbg
         IOuoWkLujizbUPMhc1hw8lcbQEZieqsj8lDGzUhTXi899A9qkbfz0oGfTu1S4XE48m91
         Mhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014919; x=1737619719;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZHCcie3Jz8m8hktWKIHhBfL5Qmb7ZIYIU8qeIL3Flw=;
        b=obhJbG72QWBjC4zT7CjgiYaipvuyAA8EpH8jtQ5EWaP+FXd/f2erM1y1KyEPTsg3Ln
         SvrwJ2cBtO9As8hbzd0TTkYUTty5jsEeDJVRnvT4Px4EFUsgLoyDojLHeY6HvaogooH6
         5J3Nx6n5nA2RNRoFraSbp2E9rMr2M8SGpr252BC9C2FPhyKA3mbENPp28DR3QQIQD1gw
         cYPw+w6G0aqUgq+PcWacp1TDvqTwjMfJt+gl2ALFNuScBdxaJWNlAZoI6oLL2BvKwI6o
         n/SBNmp2MkTMv1eJypUKlkbT0f/PLK+Q4CnutQpDWuy9bBRXKTVdHSk7jKMjxnHk8bVi
         FI6A==
X-Forwarded-Encrypted: i=1; AJvYcCXc8lqxsyMoBzPE1EUwn+HGeBwYPhkDQOUnnOOmTwN85vIHWcH/x0NHduTjWf3tpt8OVIR2FLInyEQGtIXpwn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGljb5vJqQO3FIBYqKJLOgoZoaVk35uR88GLLUsD+2yb6S/cOf
	ArBdkZCTSx1vem7yEEGtphCd8t2YT6LlxjgF+KJo+O8si5GNRr53MI0XHIkbcW8=
X-Gm-Gg: ASbGnct4d9SkX+X5JvdqqPPUxjnrd2fh2LlXXEk3XS9sRVuEw5mkGUqQQUcZAZm9Und
	e7qZ54qo2gpuQawMrv6JrDxHv6xl5WjpSzQoezpC1b+rzN5z5yslRllYAu5glmTPpbuFowGrQ3U
	7lSuejC8LS23iN+Sve9BekH55PKnNob3Xc1LU0yptNdFih9+yzb+vLFMSjoHHbwXLHyFexDdJeu
	psZM71Riq6ZVJZcrWnI2j3GOBFaxiiw72eqaMvHr7AJk6aHRJdJVhbF0V0=
X-Google-Smtp-Source: AGHT+IFh9yQIztGDTXss6u8AScgSJUBFClQpr2gqvX+d26toeWNI7G8UL+nQyJLfVgkmE7FH1vRIjQ==
X-Received: by 2002:a17:903:94d:b0:216:2af7:a2a3 with SMTP id d9443c01a7336-21a83fe48f2mr535916575ad.53.1737014919344;
        Thu, 16 Jan 2025 00:08:39 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f256b4csm93035125ad.215.2025.01.16.00.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:04 +0900
Subject: [PATCH net v3 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f..452fc5104260 100644
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


