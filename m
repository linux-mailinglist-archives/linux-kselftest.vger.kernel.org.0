Return-Path: <linux-kselftest+bounces-24627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C8A134CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A793D3A6888
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E71DA11B;
	Thu, 16 Jan 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="olchhKeF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4541198A38
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014937; cv=none; b=eECLaiFd/Mwpmy3A6zCbuhhXVIjaZAuS2J7MRe5p3m51jXkk2qTBosaFKQ8HQN7Dtwujntcrglo4xFSHAcCvcGtcmhq0csDJh2Mb6cSwRFpoR5wvc+/ukn+dnuhM4BhhnjHPISs/KAOK6xVXo0CDFO0akGCDP8jcmWaFZmUoXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014937; c=relaxed/simple;
	bh=GaoqUecKAtyQ+qguYmr90B1yeZ/UsTWOKRqkOYcnF54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Fbvy5PxiEzZ/PyMrk2sZvgvw42V+5B2BdmghC6PQkpj9Zb55NBcXu+2yvveBVS7JGzaxQe1fuTk3eN1Y8tYV86mI9PUglJL/w/OK12lrTnnC7O9uuLYwPYWK3+qCvEtTM6aT1ku6NIu822IuAhAOZnf/YAgRtTeXM5964kpQPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=olchhKeF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163bd70069so11058245ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014935; x=1737619735; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=olchhKeF0ORSjOEUrsFJ32BHlvGzk8IdNKAnnPwSI9mH4RctjOvlvmhReG+Qvk+4GL
         p32aODsHZrmIyHNYs0mOl/nkUyochFQyGffR5PRhucz+Zn69wkTEWUf+DvmrIBlu3Fpm
         oq5vvxOa67jtDN2AYHUO4tgxlkipO5/Gsz4Om7nvFOUyEktuSJVy0S65jopX867KJQXO
         lAw2JN+bCxQTuVmF38hLwz6hjLcq2FdRi/K8lvW69XAeXbGdQBTu9gZRFHHYqttYyqhu
         B5MuV3/zZfA7GT9p3PVW19wxDdqG+e9T4uXShI5eSuTH6MOVNioP210u/G9UlcPY6wqx
         1iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014935; x=1737619735;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr3AZgpAWe/4VnOS/hnlHnXvPWA7Ea0pV5fu0VlMHbQ=;
        b=f/cQCXvbwt/JIlE8TXDn4p1iBRwFsPHScOPIZ9120ca3iQW/idZvZtjDEOOIv/derX
         X4f5FhEgFhtukM4UDwpt5lTMztwcryVFNZEUbMS8J3WV++cQiY7G4enXSOQ2STnpU4E5
         yyYuxiIyd2TyKAIRmvpzuxKGk1wDiam3odJsq8CFoAo2F7vyBEvujuGbmlSKc35LUiEz
         CfsaYj6b/Jic93wbdA/Hpq25pBlIb60A7f601KyGkU+6taaELhmsP1nfSL42m1o1AFBD
         zp7NBdyFSuXEwaMaSE8XhCM4prVLdVl9cBM95jC8pV10OGXlrM2w0pudZTyL7xlL8DuH
         CK2g==
X-Forwarded-Encrypted: i=1; AJvYcCWfAsxpY9E/seMH6VB0/ndIqNayskKYzolD1uFOMjwPyJa+tiT5H5V4FtmFiKE0rR/UJoCN70iRc2Mo9L7uQl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZpCc8wJ3NOdvwN/Rs8K2tPr3GASm6sLp6vEAab+fO/UYbD2j
	TnfBBLUqkUF9tTfmDm6chYi7A9RnUzQF4xXvrieLaH+EtpeWdsCsiksA/IiF34Y=
X-Gm-Gg: ASbGncu1b6QElJarVBKrtTB2vaAFu/BC4Rj0JZRVCtagIVQnoxlEWAR9vPd4PvatRAa
	N9ojcdOSDqC7ufUGBZoiU0TRGKa9ShLJOTyM9f12Wi4yK8zIBu5zo6b6Wk+EHOgF1fDiORgdgK4
	X81obTTsX6gao8nzDZKGZzZWqaqDRgHZ4xhr+9Phirx8gIN4BVJWqJniQ9V1DP9kF9fquM2mBC4
	CxuKqivTQENReQTOhiIakoadw3vgz6+tFFcECBUtShIDZWsehpOlCcDONI=
X-Google-Smtp-Source: AGHT+IHS/tQI+KZgiPpOBaU0C7Tuw2h4kHEXmyIHIVzfFUu8R974PCCRg9snVdH9CSEC/VT7pq33OQ==
X-Received: by 2002:a17:903:1c8:b0:215:30d1:36fa with SMTP id d9443c01a7336-21a83ffbe2dmr449801035ad.39.1737014935205;
        Thu, 16 Jan 2025 00:08:55 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f13e9e7sm92600955ad.101.2025.01.16.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:06 +0900
Subject: [PATCH net v3 3/9] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
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

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bd272b4736fb..ec56ac865848 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1776,6 +1777,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
@@ -1783,8 +1785,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1798,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.47.1


