Return-Path: <linux-kselftest+bounces-49042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D755AD262B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D17FE3009268
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61623BF2EA;
	Thu, 15 Jan 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpSyJ0Nx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBC1A08AF
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497147; cv=none; b=ZsVAlUxqsoGA5957Yd3KPPx6MdHrBR0NpdtAwTxJArLOBDvx93cuTONrbashJRKWqLEaWRxbzJDSnscpfEM7GmeQTW4bPrwFU5M4Hk0NOZ1ucWPcBfYiDRgsnxwbTuiflC9JuviL7XbR9RzU3LZWB9FnMfBNGPrbW9lgiUzR83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497147; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIzhuhtSdRopWETcNydF4DT0Ks1eCAu2i7KVmPVqjoSmtC189Oa4wXjC5fa92C6yYQytVpN8ryiPP/7xOY8/VnkJIWA3JS5N8CLz1d73h5fhzbWwJdZP2ClJzjTXwGeIaLJ27r57CZUvXPn+4RgXzmKLCeLj58NeLT6A2lVPXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpSyJ0Nx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso7862825e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497144; x=1769101944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=BpSyJ0NxtpRPZ6abZNisiXXoEYNXasXggd9O3OKVrGnHSKsViorbq/MWM0H+4+vazG
         wTWa6BJKsVkIsYVo4yw5n1V36rolO6khYXu1on9DSEl6H8AJa8Y7Z4y+Hr7EnSyAbAJL
         DtY/5SZojfLmswHJCdLMrYeVy16h5gtGQFlxzRL2Zfsd2Gh15s7MO/hW57pZ5JtvIdbB
         QsYiSaDzlLIQW0Vbt6yqGYOi1Tutq0LhPaSWhlPyAOp9WghftsjiYCqKgjEsBWG0k6oB
         BbZEJGFMCKC46d5tVENMJ26vXugK9oIXgKOBZgW8fSv6KqwRyAHOkGrBH/EbNo6QQyaj
         5NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497144; x=1769101944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=dPYdMBCFQ2CkdXO1yXMYJ/ggCtDltaDxYfEAaEjBMOJnbuuc/LiLG9CrkDD2AJowW6
         Q14Bp9YevUNsXs7NWC8PFI0cuwNQnUDwhIBZ70J/w8KQEiqTeiZ4N4CgbnerJnON+tDJ
         zQ7no/HuR+nlAYCe+Od1lOk91yDAmLGnAv9JdEErQ4yU4oqDjd0pgo+/Qbap1JyuDYNN
         6iOoCgnYwo/PcIm09P8PUxYZgTZu4Qcd5hHAFEor3JiPQ+hurb/Xbb+vek+N667Rv85b
         TTc3nqeZEQeUKdyPVOgv0btN+8zjT9Nbb977t9z+XFjHlaRb0en082y+3vmJfTm+iqWP
         fkjw==
X-Forwarded-Encrypted: i=1; AJvYcCXkdcuKuePtPZz9FmfAMmHJSUTQrGhswyQIz6PxIMXduLYkNpfDPGS9n65e5bGKN0As8LDpXb8BBCOho/IhrPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2JLZ5ynsEk0BTPyHcdiKLwlmZ8W/JNNunHqVKMl+K3tqs8yd
	r3jVS7qG9BEETA5N/1uLKL5qSkWJmROCvK9KpXXAHgzPqPXN6igfOl0d
X-Gm-Gg: AY/fxX6n1fk83uhuq8qKQHBz9tezFr2uq6rpXby57+yt5+OPYtIbuV1C2nYSx8jH0nY
	gN3TAPEtbq9P4yLmTJaH9W8HH0KTDrpOO9qfcPoGFJJz7PYCbFGVJFx4Bc5Gh4JUa0Xz8q12Sws
	ZBtJepW0fS+imIFpjw+Nzizr3KYGDTZkYK31Q8d8gbrp00xQKMypYABNBBosQJFHQRX3xy+ci5G
	rmRuMJ8waT6tZv/MM35PY41i7N7gGgtGnIM8bQnQgbLsZUXiuOGyuASr39uwMj5DtqglIXO8++h
	fftc+mIgJpzwH71z3COOpePI99owKj1dYEQSlR2gRfpPwOb7YySR3GsT6gfef9Y6R/N/vUqyWwj
	TqkyAR3hf0S5Qe1qHDiKDnVwp1qVbFneILMW6oC7gRCP5AtnWMpnCjwvZAYofKysf7iB63TBIrh
	5jyusao3X3K55YKXRn5TtA+d2jJ41PiB2up2OGC3Ap5EAsxkyRq+5ooDOsTOYQSXhZJeszWCwPk
	GWvNGnPgU6GmTWFmA==
X-Received: by 2002:a05:600d:640f:20b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4801e7d2a3cmr1460515e9.17.1768497144306;
        Thu, 15 Jan 2026 09:12:24 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:23 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 1/9] net: memzero mp params when closing a queue
Date: Thu, 15 Jan 2026 17:11:54 +0000
Message-ID: <7073bb4b696f5593c1f2e0b9451f0120ca624182.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.52.0


