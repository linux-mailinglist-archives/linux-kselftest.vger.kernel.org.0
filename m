Return-Path: <linux-kselftest+bounces-48825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBAD166A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5907301DE23
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44F30EF80;
	Tue, 13 Jan 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irPpLPU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FF30E828
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273980; cv=none; b=Oxpyn+DuhYES2HSH34X/cTKHl7W7Ze7ykONlvvpdOdM3MYpfxyef7SXx53JCWS47D//Hflvf/zyyIDg05v4s1SUOOu3b0RPbyvXuU2EeUGBQk9YOoTC4QL1fm9CkZ5GRBZB24rc0egD0hAad2cUBk1pQ7GC8TLGLwU3JwEX2BMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273980; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qamtTZQUUww56htk9GMzh+/tgYzhyyj/EghWyUh4mGHFF9+FPiH1WFJn8G4+mt8xQu1d5rWLHhETbsfvYah3Oc5tHCM2ak4/FyyIS6ZIS1FPVn2RfaFIKYyg0SKqAzdHyoTZJSIlvZxy/K2QKqne+X4eTEa9KrD1bT29GiG60PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irPpLPU2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927b3e5253so20640937b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273978; x=1768878778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=irPpLPU2XzmI+2sVaJdVcskUb/Tttp2FaeL030WnEqu/DYNJPFMCTG7PrKIJL0OCIy
         Pgxz1DBwFphhLICgm19CHrv/fo+K3Q9MMMI70K+wADSmbbeM4o090UvrridrdEGg5ZpZ
         7hOqPkOHz9jZFErUvSC19JrSRL08gNsE3EelM43J3hejO2WbjvO6tHNbmXGQYZG1DPFb
         xgV3doQwigaiGiNnu40vkPsFTVeNCoEkfmDR2H7JuwqCLAbVHA3Dyp/trJkaE6K7wIrX
         Lq4D5m5tB/SndBie0zEwcAHsb4obYWMyHbb9oiXOgyuwzzh3tVhtFnARjTU4jwG374r5
         a9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273978; x=1768878778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=hIrYNnRokxiJ0RJMIafV8Jd1koejf4iQwWuUQBsCAuFgjk5xqYC7AziX37qZpwG6Tt
         v5jzwFFO4tM/FKSr0vix7/fW0kD16fdHkYONAsIE0u6Q5xUopKNP4RtU17CY344Fyq9p
         Rlzpkc5N4AyoaHlhqXpc2ZmiR3MLdRgJaGranSCb9tjyHUeupXZiSvYZG7DLCMvkgUXY
         +hcg1HrBizsOmkEs/9CQ3ahFBOkogdBOI9sWqT2oqbNzSEiMyysF32qIwkY+wPledUnN
         yQMpYpQ7nAN9m7Ks58qWe47sAyWyS1GB1T9DhefNYmZa8z0mNaWz85IQG2KY4WKBZZOB
         tcKg==
X-Forwarded-Encrypted: i=1; AJvYcCXHmc8+FQUlEVJB/dCIHhHLBqpaYRfXk7NSJBVjb/h+M3s+UuwEFnZaZyXguLxhaVdoXvdat7fsCCfi/eBtpdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6vPiPsaZWSq4ZXNtm9ye7cf5A0IeAjtma5cPxZLBP0UBwPog
	WxdMPl5DPxmJ5CKPEJe6lDKY280XAHhHqv9xlpt8UxcI7ResGKwckveY
X-Gm-Gg: AY/fxX7h4J2z45AWIPTM29H0VUCvrF5Cb2nv5VSdhUpHl+/ztsbB8ubAuozFeymWFcJ
	KR8wxJk4JcIjI38/DZwOhuFBkXWAj4MSUhNvkvE0isp29Sj7c0gjmERDUZSSOZsf4uQq8eyW/Ts
	2BIol9s8YGy8Dmqm+ByItwK8LASla/tjD06kev7CSbTYvIq2NFrSBZ9IuPVsALhhQCPGcKyxTD3
	rsabs0XIg8IVOqdiMaX4E29hjV17ZcRCKVBMlPlgGEPTCpXLpwSQN9H79p9Nfuc3YM1s54JtwG9
	kuZM9tFJLyHjLUSFdj8ljV8X4zpGpaA+0bDXJ23IJiTvNdcys78tFcm88wbtCDx+RBE1ErU8vM9
	0oqaVKZAInPcRdHQHrABslAV6J5PbCadT86SVrCRybexaErRZys9luym6rTHiqKLADoltXJw6q1
	tbo4lsw1RlKA==
X-Google-Smtp-Source: AGHT+IHcF7Zmu1veaf8u0eg/Kbb68KxKW7zWjXp5XrByj/JKfJyEyOkbbQZuZ3nalmLjzPkGlfdNOw==
X-Received: by 2002:a05:690c:6285:b0:78c:2473:ae79 with SMTP id 00721157ae682-790b56a66bemr171959117b3.39.1768273977917;
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm75715147b3.25.2026.01.12.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:11 -0800
Subject: [PATCH net-next v14 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-2-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fdb8f5b3fa60..718be9f33274 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


