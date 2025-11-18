Return-Path: <linux-kselftest+bounces-45814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56BC66EB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8B6A429C9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635E328637;
	Tue, 18 Nov 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvGyitWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C4326927
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431239; cv=none; b=hEnGvJ6IcjhBagLY22ATNwUHUKKyX0MqJNjDo5jTEQsOTBJsWEP8XFQaHXVPp0579u/XzPNM5IIt92oIcAE5qSrf41Yx1mHUVwK0fdJNBraRkJOy8qvLB2nJ67k+CcciISuEtrwcZDa1+Rajd1pof9tf24gWL0tGstaUcRU4SbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431239; c=relaxed/simple;
	bh=uOW23oUD888uPdfswggyv7h4B3njoPEFvMHwF6iAAmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGiWzrjUEUw7V0/cdwZdhI9eEHyIcYdqYut/z4AhzX/Jh+hI2UF7VnYVqHbKEJeyTZSS+8EDaLlUEHNmEnyidD5I2pJmMs+wKs8QdsWr4KMy0vxvw3nhRiOyF3ANgLlWIHKGUOmh6oXQ3GE+3UKPd7cufVZtefwfjslIG1r5iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvGyitWm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso4054145a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431235; x=1764036035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=YvGyitWm5HtOLWDkacHtkEzVwBo6bLmw5bjRI5KahdU6vYZpie2LhsE7QRjfFmqpvV
         S1sg5FIzB3hunXYdxg+hCYhSEAgUXsIPtpwJXINmLFPJAPlzURuGMtG+a0TwuueynZtg
         NgPJIs2To4xQ0lc2YFdM5/Q8mC4H3KHf0wcgy5MSkk6oC9EynLVuPp38TwDBx2i1J4ZS
         30Xj+vjwRrDyfDdXluTBYdaZFK6rukvRYbcBdh6aIkVPcAYWOYKrHvrD6XC34IACdZ9d
         Q0kQllovX2O+ohhUwjZj+ldw2jfhzUrMKxBGUwYVoG4jQIeihUvdopAKjJsrsz59WBi7
         izwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431235; x=1764036035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=NMSPqUzOb5OYDtMYEfyz32PprYNsKRGATq+WCTdJt4Zy87zwWAcGbB3LnxkTNDAosA
         0jUCNsW1ZIVypzTw+5L/5zt/CPT1AQdvbmjqm7mHYb2sb10J0mcz6FK8pKWtP3OYR6aW
         gRdx513AJcxCvuwC92uff3YIc7+fj5qoREyGAlq5kSfFhGFJ5CNq8k+d8AxRFMW4umxc
         We5RUxKlc5xqN658TjpIWhf/XLvrIlIIKfHUV60LgQxZskVdNxiEIZ88t8C7byhpYcNg
         YVXI/dYF4FIJoqr1u+k9oO6F//3/knG8OUYMFcCmenCoCIYrnwBHR06C3rkL7QPU0dVM
         l/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa1fNRyamEHaw5ad31bHrQsMWfjt5f7MUn0ViTQkvRWQQnbd947MYenDnEH/FH/0oKxfGTatyUF3ErNHnDPgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXFN0jp8ctTb6BSyOtIAT1ncPu6HdzBCpaQQwD2oL5spNDKPc
	sBaUvhqquvKar3+Meq1AuFNZgnCec4xKuBCTsdIPJsmPoeQ+sE52rJm+
X-Gm-Gg: ASbGncsQNaXL+4rUxRFJaZzsp7XQkq8COgS8ZIS9E4/1xyNo9bAa2s+eJMxZnnAtGrz
	LvnIyDH8v3pvBN8GhrqNmAKGJGDHBWEngA5crRMm/D01A35IszkV9K1EQXNSb5BKtf0WyRzqsb4
	+Ho6Vs6NTs5wtMopVmzFzvpgTmdHONQPpjozKqxvU+0tm7pMVN9kXVWxVUmXLZepRWkVcr0za7S
	6wpZ3qgaeLw1xF437cgKLD5V17Rbz1KTg6kDfhvTBB+v9ONT9xMCPqj50mwNf4q4nlYkDlEhCmj
	YHE42tV1e2dzbgQDTS5UE8HGrF0sgMCVPrIzzBtPmjApJ4o7/c6gl+5X66LhI/rFd44uEzVu9a8
	enHV20kx0xCSuMeLlwjtcFPZh7iAi+b3uVY4uN/Qp6coMLPDc+8JHb0aT73M5t+gu3mu5ijD4m/
	8Kygs86T56Nko0u6hD4RodvIgW381waA==
X-Google-Smtp-Source: AGHT+IHLky6hFd2s4o/LoM/Lst3F8klAMSAkgSuH9Ql0+UHi5g9wFfThPyUZnxKhdSO4j0xQMtxpww==
X-Received: by 2002:a17:90b:2d05:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343fa6326e0mr15954772a91.21.1763431234714;
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm20082011a91.1.2025.11.17.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:28 -0800
Subject: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 168e7517a3f0..5bb498caa19e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
 
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
+
 		/* net or net_mode are not defined here because we pass
 		 * net and net_mode directly to t->send_pkt(), instead of
 		 * relying on virtio_transport_send_pkt_info() to pass them to

-- 
2.47.3


