Return-Path: <linux-kselftest+bounces-25967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F16A2BB0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A3F3A821F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC392343C9;
	Fri,  7 Feb 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Qzdq5QMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A792343B8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908671; cv=none; b=hjs7RcUXp1EsvhvdNm12FANaztTnLJtV7iqHQBceQInS7xQ14rxTpOkWEpb+nqj5kobWcPC8s02QSTF6q2HHnZjPuhzKQkzXD2oRqvZTmismyxDZCRPFJWPYqd6Bu7pnO0q/m++g6k8ngOsqvntA9WkItA1M7w1Svo5jM2vdW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908671; c=relaxed/simple;
	bh=cdUkce1+zju76xB2ulgsqkhH2BtZWQUF+tczDHuY9Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4OF5zBEz7eMjLgtPf5rGbkbQm0ZFYAurO34plJ3iAHPP54zjg3QNYZA6WyPrdqfm2XjysranSGiOC8sd9pz1tXXOs1xgD+CCYGR27oe2u6AUn2+O+9SbJGFtPzzy3Nq37cXkjKITsoLbplUFAQDnlsbBeHBmlkMf4gyxY0Rans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Qzdq5QMF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so37283835ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 22:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908669; x=1739513469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=Qzdq5QMFTDdclgtr7jpZ1OdQsvw37EwK69Zy1SuCQG+t9cohiUx8Nne7KfQU5/YDBV
         d0kz2bs7JP1y+I1fNGFYIBvhTv0Zo4RQayKiYxSTNHBFDTGKBp2LKi2q5qcmr809QspU
         Mo9+2+0Q+iZgV8qRKLYSUGn+bHWCUckSzEL1HkL1KTAGMZrbw0ZqPoi5ZtqhfW0ewwk4
         GeBuwTr2KO8kY6cMMO0XlAmaeaYRCWLxYBOvBcq+5vbxrc/BBq7FppCE01xFeWLoM+ye
         co3rtAN9iuL5PhTrX0oSltdAlDVpZxUSCkWAOmVO0OhNq3soAzQT6yma3G3WvtRlUVYn
         caxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908669; x=1739513469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=SJ6lRXfi41OS9wSV7Nv8Yjt636Jo2cg0Oj/4RsrjUiVC658cPTMIUHpC8iWlq4ZQtG
         hDfdZ2YryI8gFt27wt8RML8GPmc5c6p3E3sZ64RVU+sJxvMsBIQKSjyprMNRb8zu84oy
         HwT3fjxedIBHqmN2fswSBy1GCKrtQN8Uhi+qnRXwVl8N3Juq2F9qmbH+TdbaQ8bq2GeQ
         tcieU4jYnLFcl0DjviFGEQMnaaxDXdzzYFMNXgR81c4vFS3fdCJAinETYiHgnYUDfKbR
         q3QOhS7LhFkZLIYyz42p9wCB/NtN+u598HZTTr0YI0mc28n249326TyAif3BHbbuITFB
         296A==
X-Forwarded-Encrypted: i=1; AJvYcCVuUTuZ9DUY+LbQYhR78MykFqjyyWxLjN3n8RRNWE21Jyg27iQF3Fd5Wu37DQaIBWTXON4P0AwdWVcQ1G06hR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0mBPvhVRpj0eLukbOJeE5OrkduVwfTMlY4o+rxxNzAB1mZ4F
	QdnKBGLvFwtFK8kaqun3s5CHenaQiaBUVSkCfmz158wDBEG0DDEdtoQ7EBmBLeg=
X-Gm-Gg: ASbGnctunNrYfkYtExHFTFOdaolTHtWVaM+6aNVUabqUSO/hBODQF+kezDwJS/GxC/l
	Um6EOQfv8N6MX/nlRzFeSBX1Z2ffP7ooigBUtWQk4Y7GRLyiy57TlUE6dDEpyJvM012PEC5RbI0
	SO31VE8A7V55iDnAigoiiNAJJrFBiqoIp+NU47a1DL7xIrOUjW3l75YOKyISB/r6iPip5EPCisA
	mJLafXRyYoHzBjBwB3ElJhEumrEhEnm23UYRpoZO0WyKs4f2QJWZ6wvYU2N2zneuaOuzzrI/DvD
	jJWYfL1JYxKzGitBDpA=
X-Google-Smtp-Source: AGHT+IHsiQFjzXezkiITWyryKLHFxWaOkXCA3VROnOenVsONjd60T0L0zqwo9kfDi5iWVlXHr3UF2g==
X-Received: by 2002:a17:903:19cd:b0:216:73f0:ef63 with SMTP id d9443c01a7336-21f4e7ae7cfmr37137465ad.49.1738908668736;
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d729sm22605005ad.124.2025.02.06.22.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:51 +0900
Subject: [PATCH net-next v6 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-1-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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
 drivers/net/tun.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..4b189cbd28e63ec6325073d9a7678f4210bff3e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,17 +298,21 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
+	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		  (tun->flags & TUN_VNET_BE);
+
+	return !be && virtio_legacy_is_little_endian();
 }
 
 static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +323,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +336,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
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


