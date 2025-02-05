Return-Path: <linux-kselftest+bounces-25802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420EA2844A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 07:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45DF3A5A83
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B52288FD;
	Wed,  5 Feb 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QH5FA/9x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76A227B88
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736561; cv=none; b=XfcWJbAh3dHVreWis0TkV5aZTbkjI9Min3dl906TC2lPXRfXLx5WRWijJ6vqXHE7bPCmpSolLRcocv/0TODju0UvV4ig0P0saIEXZOGwAs2E0kjhWRJxAHR4cQfi3GCCUJb4Uua7wvdiZ5/d7+DqLLk2OB+Fxf6GhSRv79fJpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736561; c=relaxed/simple;
	bh=k8AT/7ba0LLNdr42q8vL3zcMMHDDU7sY3oym4vZIyT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyxwjLhNFm2czTjeuHcYmJmkygQncWW9U4c61BjJqBPokYRK56nDU85Ln111LItTh4pY5e0Lo7NxuZAy2s7nqaVkO91X/jHKMnphjT4XC99QGJAhh25v8VfX0qa3/xs8AfcgyLBrvKq4tru4AQqd2vVHHrjNmKnOw+3uZdjDEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QH5FA/9x; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9e415fa42so385379a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736559; x=1739341359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=QH5FA/9xqt072asZe5B9//N3mO6mhAz+QH/YNmvtldGolQMWlwGYejVvjtBamDcLp4
         S6ABuX9ImmCgHuvcGRlduNyYiPZ5Ydnv6kd6W5Xq2yUVlIAWtvQq4XMXWF2cYZKvo3Eh
         uQkU7w1C8VpdJCvld8Kou4rkgUbYgYJyzSFpeAY/X27K75fn9vbOUNeoAUzsny0D10r+
         WRZlVSmQDZy/9RoLIlECHt55nk1Oec1qM4I5MNXLkY53o6IqSX4rCU/evEQaT3gYolQ4
         SiiiPIVmcVpAqx99LvEIWfjK5BM+ZbyGdNS5WxbeS2mtKWsc7Kqone2ve8NCNXQzmyMz
         QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736559; x=1739341359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=tpCQ1aLh4FazEHUEY0DNJzwDAhB0IX5zIN/B48iOg5xVGmJrcxSu1Cep81JjPdowUS
         kkGxmLidK36o/Wy2qCQA4Gqqd9Pm+a8cxp8HgReVMKWjVbAMS4bzRjTNGXly9f8AWSGG
         2hTa9AL4hfm2P3wnmm6wDR5vPFAeDALqNLtbMSMYGyovP/QnwhOSwfSsyXtNquK8VcR+
         VtOEY+rry3eS3f4wUbvm+2mGc+jszilo5Z9LY5I/tRf7Q2xKays/NSM70eA6F/Y19jEo
         Q5XtXMc4UcwbvFMkJuKokT2GkOjwhpZx/l6Z0U+vMisrt0Krz8ROdgbHiqmGDVNynUVk
         SNwg==
X-Forwarded-Encrypted: i=1; AJvYcCUdvpXudftTazENF7YJngZV99h0D0acJqERAfK6JfjGSK/u63PU1vACAyMGO9YdpQhkq6TaOMf81qDolTwUotQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvlYK59p3S7WmHKsQfT4b8o+dr7IeuYZH6fHhmtFHE2uMzlPy
	PHfjHHBVTzO+f7e5KPgBjOvgnH/CLVfEV7a7mhAt3cEHwT9tDWKOWZiKGzOEP8w=
X-Gm-Gg: ASbGncvA2fHMR0HeUbar/0eGHUOop9iI9imQiIXZR/CjeeqNWKCLKFEDTvee4saOpy1
	l+m7MpbPx7l+p0blIF4wKDFLIKsCeDaFmPmGLBl5hYjMDuJYQ+XL8GxtdaQxGCj6yVuXiRhYLw9
	soB1DY/aC2mNUG0vflGzWUZE94HGccieEY3+1FZOforhbuMdoQhrr4uNXvJiaiImRLCamy/68I6
	ZXxUyhUKln9P/r+vZ20J2QfQXN9isk8ZCeD5H2d7W9KCS4HCtiDmYzFtcyCS3/aLbNz1UfJ0wh6
	Tcln2nVphxiZwPkQD6o=
X-Google-Smtp-Source: AGHT+IEkltYiingUuvZ5OPE7k95CCEI+ZGRFDs15kcTYl15oURn0Qzmrf04BT6IAVXnOElwIy1y3oQ==
X-Received: by 2002:a17:90b:3c52:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f9e079b0efmr2575681a91.20.1738736559002;
        Tue, 04 Feb 2025 22:22:39 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de330462bsm106232865ad.204.2025.02.04.22.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:23 +0900
Subject: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
2.48.1


