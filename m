Return-Path: <linux-kselftest+bounces-43697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB1BF94A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7164F5FAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5E2773DD;
	Tue, 21 Oct 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqdj+cUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED0242D83
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090423; cv=none; b=TC7K0ihyvHvD6ZruRPCHrm/2HNZUMyKkwzXkYTEZ12AVlVTG2TFPs4ajxO6QSNOCuIr4o5VX5aWb3GybozIrwWWp3ZGWOAe8gKmoiP18ATpC4zrHYo+5kfi+H7DX/X6dqYKiGN1CBKMsrEoLCOEKJ3FySz2M2ZefQW5iC4xeUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090423; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTeOXHYanjXO+01upWypGtMtNXSz2/PMo6ZrTvJrHeI02B4aKmbAmu/EENpzrEuh7s39wmYwdkfYBUDXTEk2f9975aOCbIyEysfS7LoSI9YO7RE9qwtMFYt0Nn9TlvjjrbXjr8hkESLAPBRFir51Zh4dnL6AdVwntQptSgT67q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqdj+cUa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso5490480a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090420; x=1761695220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=Vqdj+cUaCyzRB2LdHTMt+fj0JxAaquTyxp/ZrCnavf+AB3YESX1HVyy9YKyIhibLvm
         v9vbK2HR8036+s7W2/lSpQV1lLNcvG3u9ham/tkcWXd7h290PF/S+F8TK5qTza5K5LOQ
         mxW+p0SlwMB9qYC0Jvd780awJhLkxdqw7XlsujJ6Ik8QcC1TIQrC7rzVqL6XX9btXDNx
         L3XlnfBgqiDAtjPflEwwLyGyKV+LPw0CAvp0nDUeNVnQIfkF0UgEDSs/faSySvPN2I3B
         ReC4M+pysdIsU0eGyxfWUZBGdemrI/7KtCBmmDkbe2r1NcyxRx4MZgKI14iZ8+bh3YqC
         0CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090420; x=1761695220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=QPLJj7ByxfF+vJPU/h5eivKy9lK3uNo8yW2/0x662mYX5D38kR9req8PSA6ebdWQu6
         aI1VLiu3akKCL6bmwxzg39bEWdz5DE/68gExWVAcFDebJI6acUO5nnbwsNkJ8LIRLmT4
         gC5YG4hA62hd3YUUUKe0Jd7V79cdraueQqaGWZV7n+VVYl0aeyK7jbYELW7fQ/Wvi5Hk
         qyUVKeR92HAXpRua3iSMfrLYXNgv0roNiURbC7PEPJsKW7sBb51Wu2VwZZE4Fpi4ZUZb
         2yqLVxzxpXFhzJ9CnT4Z3on+RP6kJTdvcSj+HpOS0a74HjDCwN5GzrcQswrCaDjT6eYO
         dHZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeFnXKMX8AnXk9hPJSjxiBjTMuXTeB4mXBj9+kkOa+ptNMXOpV+7bwMdhBMDktIlftxjtNBC+SJ7d8FcTa2fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kCFcR51lvKNCxjD2Tin+0Kb3tqhUHkBsT876dt1e23IZb1QZ
	ys0nETu/lF9O54qzfzDfih9OZr2PSKtxTYo5PH7Y3vDnKHQvASxkemEd
X-Gm-Gg: ASbGnctx2gmb5i3lmIsL6AX3sGJGdGQdoDqMZ8mnZ2vKVyrUl2zWP5p+6tX5MFyoRt/
	avSRfFn8RTOp+b/BYbZb9NsC91b3f6ZoGMgkjzX4QBKUv7xnBqqUS9qIbRpHJnUh1W8ruqOD3cr
	SacxOI2+b/GDEMtH/3aZ/C7xFqCOCm/Wuviu0WfIejEUXEWNxZzKjDA6QbCR5v2wetag6xzGpPm
	DdFGX6gH4THP7TtF2m+dX2bFhZ4GXbQyJ+IiFD4+RLq+/knYYBVxQDHkxuyzYFzzfk4JpLzFMes
	Wtvc2+dotY1R2sDXq6NqtY+2tOzvbSOzcwHDZWICodbuDlTlHJe+d9UzTWmAW3ZPMpegJk71NA0
	i1HVhL43Q3eeolQOYLL1seBah/lpXeCCzyOVNRM3jV20Mc+c6oTV4ihdALF1Og4YuBTFGz61ohG
	1fmv2ak9i2q1o14gPZak0=
X-Google-Smtp-Source: AGHT+IENkRWCpby5KoDuBC94CdB6Y+P0mIUVkUr8FgnjZ2JlIaa5Ku2Bjeg3lNWDeg1OBhPgmqH52g==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr24622081a91.24.1761090420572;
        Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm11811785a12.3.2025.10.21.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:45 -0700
Subject: [PATCH net-next v7 02/26] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-2-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..87cf4dcac78a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3


