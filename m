Return-Path: <linux-kselftest+bounces-43946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33FC02EF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA06519A699E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D135D34CFAE;
	Thu, 23 Oct 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZluPI/AT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5D3148B7
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244090; cv=none; b=QVssk9p/qkpuvDsjtaRILLlb507bSuCKhHYRWbqcgHHSfcUFevBIVM+pRvfQUoj9N//nb/+qyRME0N6S0SXbK3QmbmX5wXNZlGE8XLsrJ72GfujizOVoeM7lA05ZlnVcDPsTfVD/S0h0Clx/TxgrceIQdZV7bHfCvGCeox9GezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244090; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQkURispx7K5DXh4j263eNPB98PJUDJI8x4gT/MiJ7wiF6v/jEoJ1MegXZsqfze8t+1aRYaoDLdxtoLh3K8cO3tRjcXHfRP1YsoyCXZ5Tr7YJa5KMYCFYLxaDIoEN9BZ6f8jSm+yYq0OsSP/ETLwTgzl5pvV3Hp2vd5WBdSeWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZluPI/AT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d14e5c9aso14767505ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244086; x=1761848886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=ZluPI/ATyLxWxTZnYtnR1Q+2uqTB8mTBDQVYynXfkdJqsa6A9Txt9/KjUi4mCfhZ/Y
         6XLP/aLF5CVY9ezJucDQCws4m1PpC0+ulGf2zweCjxbvf6bfEKR1MiMTRXJQ0wPXrTTx
         leva9rnWFR43CoZ2ATmAEOtOJrCAkQQ+pfX59nKs1bNb4NWM52FTWeXJLq/gLHHr+wFS
         5whdVdBitUm2RU7sV+qHkbRjyemuJ+TfwBgvHIITwc7W7uIkYNSSmWLUjjTPoQHSguef
         +1s1PKqKYefGRIu/7tV2+Gd61SpbNP06SvCt5aOZgzKxwzM4ARH1o65DylVHpdAR7/tY
         cbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244086; x=1761848886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=md0gQC7VYA846a5MIgBsQzkxzaL74GDGKXOCPXqQ+L8Wx87SqCiyiZXR6NQL7r3mFO
         MZodmk50phamzHdk3faijXbTdwOJFVUDzsXsnniCTs2aRG40aP8aEvBZRdfAi7xAtdq+
         Gz9cMoeAdSxT8hY/ZHyLyhP5S3U72EceZJroroTZ+J4pK6bgXO0Oj1a49Fcf60CJPA7n
         c5Ebt2rJk5MnGpVONkTb+Mh2JvTug/WY191BHQZABc8QcOS1y+V4cxYE6p1ZqPi2sEGG
         OSvkkqyod1l4hUZUE8WHsRrNNQ0h5q0gXudai43hOIqJjy84RdvDXnhtb12XWMXVdBnP
         Ivlg==
X-Forwarded-Encrypted: i=1; AJvYcCWVnLoAIR7fxrLVGbvGwQgIpsftL6qVrBFYmWtONADBXuqSCePcvg97rJaEPo8Zsou01xMpqJz445spWQemwG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ma8TkeiOzm8/uLMopVB4+4dm0qN3UXNBVbhnJDxcs00v0u7t
	tb6wpz69oQjiVq9SsCz73btuSLzzVLVwZyrXwAmbVx8Secsg18dKystR
X-Gm-Gg: ASbGncvMilHt9PB10a9wMkuGkod2IAmSggVRYQCAYB6f50OPZ4SO1x/5EVQCdH7ZEKW
	KmWa7CUlsuCXxR3rx5Kif8geUhAQ8oJo8b4QdqWo7WvK7WQ7pf8LTITQw3xsUzc7lnnXA8L+cS3
	rtwbxiruGwGLsLZhUbo2S8DOiGQ0aTLPen163qTGVUja024kVYQ/7YqlIVv98vUnGVdHKa8Q286
	GHtKud6LNdLa+iT62YYL8dTLSpwY+AnuRrtx2sFTKN5H+uqjxiEceKCCCLbu/mrDouMZSP2FX39
	0mZLfAcgn0Ujh+kGXuFYrWGHT3++m2i8Z635OJjap+Mm04YdGMg60Hbdkll3YZP3KRyE9sY7RDW
	s3HbtUtYxlpysIBk9zD5mG/3hnfVjxAPLv3TIRpZb2YKp4ohdUr8emn15pFFWenwXpxPii39n/U
	aoP6gd44y1zctds8w1GBA=
X-Google-Smtp-Source: AGHT+IHuF0nGiLuYIY7bEPnV/kWChQOzz0OHyllyc5LZQHhWV90GhBaf/if/KbPVYud5pvRswtc0Ww==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr337313795ad.53.1761244085636;
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de152e7sm30294645ad.29.2025.10.23.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:41 -0700
Subject: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
X-Mailer: b4 0.14.3

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


