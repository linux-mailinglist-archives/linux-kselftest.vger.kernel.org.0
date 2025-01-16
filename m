Return-Path: <linux-kselftest+bounces-24631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07258A134ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588901888C7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E01DE3D6;
	Thu, 16 Jan 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BHlcto/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DA1DE3BC
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014968; cv=none; b=bXljMYazYugVFsyR3hI4GwTt5hcDvlD3vC7fMpRlCN4jfGV5/2cdq+DRgPfBeB20MJCSqb+ML+QcFxQKMYlvp42P3CVFIy6R9aMIb0kCyfddcLqgugyEv1T2Wd4r01cr7WZO05ribH3QDwVaWOYv3L2N4lmylw561DADmllI4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014968; c=relaxed/simple;
	bh=jRpYSf9eaW+ho0lzpltGMAxASRyw0CEV/6XfYdKY0IY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ckf5IZ6btnslWko/jTAmP9bXdeUZJtnwlTcJL/NNH8Zkkf0E7Hxo2slnFn1iAt5SYWYSCJgnnEnkR+Pmj2Cp7UluxNEiLRfqwURKlt/bWUuyi6ijO1Rnc/RYnk2Awzo5WaEC2rw2ET9ESigXRyl0tNVlxTvdIsOYOIEm69Y/BKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=BHlcto/g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-218c8aca5f1so14065465ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014966; x=1737619766; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6XeS8X9JmzzO8cEu3bDg1COvcoMcAqw6E54ck6GWVA=;
        b=BHlcto/gWLAIqBZNfkMqUhA+mPI4NKQhTsoJCZMTiOk9VtUeBLCmqL5yB/v9M9oD7Q
         TPeIAH0Befg2dZlnDwB+SSafhD48aEzLLzqgBaT8UU/1IyCLhY9GfiUw+u40HbIINmQm
         pjdb6IIuplEuc97V1WlvFTlizLdCKOsWUvZksbeFsNFOUBCJYbJM6NpXIRWBlG8NOtzz
         FrL7b0Dd94mTumsoh2xRLkISqvdFvyDejqf9fkXkhYZNXqjClh+b6vX5gyyvBL+VVVI8
         /fpoZbkoSHwGO0avrzJgDgA00fHlewUllVjh4poC1LSFQlwAy/O/iofVkBebgwVUyWdG
         KWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014966; x=1737619766;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6XeS8X9JmzzO8cEu3bDg1COvcoMcAqw6E54ck6GWVA=;
        b=lDqYtB5R+0Aa/YsgvHhJXtpiLLlzh0u13OExXGd/gfOqCDZ6pAKtxnZJAeR31kh1M8
         MUBhpNJ6a3/cXi7sdNpEmoYI7eUG4OEBsylzSo4xTri5XBscC5R0RI1QJ/kY2DoQa6HG
         GT3feLq8KDZ6TrzpCE94w4xXCuqKvlMO7zg88bb9YuidzJwDk6MqEF13Ev7IfWA87OOV
         jwJ7zoq5tqvoP4Wp98jUtP+2rr+ogwwkyvPx17PSPiYNMeWAOco55F3y6FeltApLGBBy
         tVjRp8vEz/T8/ocv6P1XMLiYpi5PDKiVTGWr9LdKWo9NOzqiq+f1ib8h8s6sBRGUjr/F
         iLgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZQiwQkQRX3R853DCyO+XYzccd9bKNLRy5NZwSzM7iOQFoe02EW1XzGt1SekQc7R4CroR3KImvdiiIvH7Juos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTyvF96ciOLCFYKMtkqjLJ35vRjFrkzFh/6zfP2dWFjADxu0w
	zrhhEqhW+CKh8x3wtP6m8N99nBgNOvRsuvJClhTY3QExu2d5nRcQfesW0z6U+JE=
X-Gm-Gg: ASbGnctLWj/JahIkPxS0IUmWTmA8OUl4fOyE8Xzn+rp4KKqoyGfpzhdYCayz/MiGeyB
	3NSoXN/S8zxP7E1JSJOg/TWx4YwIVL6DhUhg2F8CZBnnyHyi2os98rbSeKzXKklxgWdjANugXdh
	t5lV2Rkh5B+Bm07tTciMeXYxzP0wUWQVFeX7CSuhsF6VbqsgDO9z5CL1cqcCH/NMJcO8efhIgMr
	ReZ+civGJ0twY7Zsc3vPL59qN9kZiaEAEz/9mr0QwX4andRLO+uPsVBpx4=
X-Google-Smtp-Source: AGHT+IHnr5s5lbwKZ8hVxzCBLTjyfZY+984W/EhLpkGsedZ1ouritoL5gtdrAjRGaaFIzstL0hHTgA==
X-Received: by 2002:a05:6a20:3d86:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e88d18b424mr16255509637.12.1737014965864;
        Thu, 16 Jan 2025 00:09:25 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d406a4dddsm10309766b3a.155.2025.01.16.00.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:10 +0900
Subject: [PATCH net v3 7/9] tap: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-7-c6b2871e97f7@daynix.com>
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

tap_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765..061c2f27dfc8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct sk_buff *skb;
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
-	unsigned long len = total_len;
+	unsigned long len;
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
@@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
 		err = -EINVAL;
-		if (len < vnet_hdr_len)
+		if (iov_iter_count(from) < vnet_hdr_len)
 			goto err;
-		len -= vnet_hdr_len;
 
 		err = -EFAULT;
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
@@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 				 tap16_to_cpu(q, vnet_hdr.csum_start) +
 				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
 		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
+		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
 	}
 
+	len = iov_iter_count(from);
+
 	err = -EINVAL;
 	if (unlikely(len < ETH_HLEN))
 		goto err;

-- 
2.47.1


