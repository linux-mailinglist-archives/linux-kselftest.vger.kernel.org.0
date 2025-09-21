Return-Path: <linux-kselftest+bounces-42039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C74B8E7C6
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33F53BA447
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D72D9EFB;
	Sun, 21 Sep 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GruyAGKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAA2D876C
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491786; cv=none; b=gP8apOqn+ov9um3H1A/CZVPpDpOnNc8fAqWjfazRhtOuM/YdSQL5KrbGXorKE84RZ8rhVSvDFyHZ6kJzrYW3Ws3sPn317DfOHvt44SaQjTW/v3ZFPIBKqKkvX+RVF1+zwSafnh5LKrScAax9uE1B7G5POI2/vU5/5fzGGWaH/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491786; c=relaxed/simple;
	bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1z84+6pHKVVBSeo58oEdq5pY1YC/a0oJDlsAj0mZ/pLJ0PEV6PSuHa077gNLEZ5g6xyFjFlp5cPAzwt7Q74IAFRpKUzGpluVJUbbndzQL2GfEpahDmR+iyEg7FpCKjRaIAlQrIjlQa1JkcMIezAhM5GGGTzH7HhtIssNjDAzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GruyAGKO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so1127689f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491782; x=1759096582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=GruyAGKOwZLIpP4Lc160v/7prT9B6kNgcOT4tIIhXx6TFVygu2OwKIu3ZUexPLXQE2
         wnBrv2LSC7d56narxHMSRFXDQbiXNJhuFQRPSIYdhuE649cwYnE3WWiBqC9jeu5fCi5v
         9LAdWS3kwIwpesjX98q4k7XLMfltwC/NFa1qhl17L7aw2mLiA8p4Qo3gbs4O2RTd34Uw
         7H6KmJJey2+WbzA3kcY5IslW6vVEs2wE3k8qQkdUm74zb+TP9z7k1lF5q7iam8yC7Dnb
         Clwln0EVjJMrEwfXYBANadSP7vadMOccdVYSJpbuMVBcBQ344jqdo8QKapUBYjEZu0Kp
         qEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491782; x=1759096582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=MN1NdZiLNWPjOIsgkkBTmzpFt1wWcrLUKrJjpdyLyoDO2gU7E4MV/UVvnEfTW4X7tM
         mNJg8GDHbMLSpwj+52B+MbThIJw6Hpmv4Bwozt1ZIH5z9WBleaKXxlf67mbuUu2S/vds
         AmF9z/AWy2HVivC9Bqji6pR67jCaZ7rComkqdCNWjCLJgz1Lwh/tqgfADMEtlfUw2oUj
         2SxhCsW/BnaGgyz/+PC6c+3FvFxF6zp7zeR3DcKmNr6NH2rcGbViiNH33jZPboaHyFZl
         zv/FTR7AM0DxXEfA9mQzx7Zk97Vp1op4HMtjny714ioMGI3yGq3KVnHHyn9rfuZFgF56
         RmMw==
X-Forwarded-Encrypted: i=1; AJvYcCWnIhRhGIqegg8GNudS+GpPtImbf4R8hdsZfx/SttovE3CpxiNbQe5X931Q7lTQCxRyOu1RQOwiR48nj5S4oeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnFkYe9TCi0NCXH+i+gDpaazv/+3CbrjZK1hKc3pWG46UqfK4
	lxTp0/l5Ex3I18D39+mxMTikKaBbqsNdnzEPvGQ0ZzvHZ0NoBUwSP2BS1kzdNQ4Q
X-Gm-Gg: ASbGnctLysR+MKx5qBicDST7BZ0ruq6F0rp85om5JHxZ8PAYuiGa+M/hR5WdUcEQ21+
	GTXHcJulcuRi/AMkSKJ8JJwaMjBDDftdK7WDN3BahL0LJNoR3+YnHgbt0aUIIs9cMsBW1OMnwOA
	EvtLH2E47vO6Plfxi83gc+2PZ78qr3+mol8KexkW7WRD+muagZ/k2C0wONtnF3qyrXASHgz44Dz
	zRu/V2NEEt05Li4TbwIDDqNk6F61X8vMjt4nqOUDeBl+EXc5B+jcUvoywudySF5QoZLgi3vto14
	lw7L9/mZuRcbUjyutRcK2p94D9QINLn7HBDem4BcpudY7kld5wFTe6+kvGiV1zbiiPdy7jHkqse
	woPur749vxxmEG/yECDDKUhfUfVk=
X-Google-Smtp-Source: AGHT+IHkY8glqJbAdbx/HQxL8P57QDbgpjHvW7djVIuzTEhF8v7QKu+VXWTwdbbHVgsscAGah8UFmQ==
X-Received: by 2002:a05:6000:1acc:b0:3fa:2316:c21 with SMTP id ffacd0b85a97d-3fa2316187bmr2371046f8f.17.1758491782460;
        Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:44 +0100
Subject: [PATCH net-next v2 4/6] netpoll: add wrapper around
 __netpoll_setup with dev reference
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-4-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2309;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
 b=d2nNT4dGAA6498qUFNrx4Kp0pt0EnCm5K+QmHqWERTvkBThp1hPs+jdrh+xminlvQ1/FIh9Nb
 JRvwqeiYmuhAx7pLVrhPxTRorXRAuN2SpVG5juSaJuNj+g9+5QnxmXi
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce __netpoll_setup_hold() which wraps __netpoll_setup() and
on success holds a reference to the device. This helper requires caller
to already hold RNTL and should be paired with netpoll_cleanup to ensure
proper handling of the reference.

This helper is going to be used by netconsole to setup netpoll in
response to a NETDEV_UP event. Since netconsole always perform cleanup
using netpoll_cleanup, this will ensure that reference counting is
correct and handled entirely inside netpoll.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec4660405eaa654eb7746cbfdc89113fe312..345e741126748c0ee8d55dba594d782bced4eeed 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,7 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c2491096f79ea6cf82eeef222c3eac2..bf563c4259f6cb19c31613ff277eb5a0e2165e43 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -608,6 +608,26 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Wrapper around __netpoll_setup that holds a reference to the device.
+ * The caller must pair this with netpoll_cleanup() to release the reference.
+ */
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev)
+{
+	int err;
+
+	ASSERT_RTNL();
+
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		return err;
+
+	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__netpoll_setup_hold);
+
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf

-- 
2.51.0


