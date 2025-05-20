Return-Path: <linux-kselftest+bounces-33425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C60CABE4B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6C5177BB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF327FD4D;
	Tue, 20 May 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHEGuuh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558D2517A0;
	Tue, 20 May 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773049; cv=none; b=CfI0YZkqQXqLebb638mqwybPDU+lEtGxj0T1Rr3waPf0CNZ8x21OerELwaO28zSgfIpMFIxnQSH3LsIY36R70Ymw0uCRW+NW41bQEzIABh8uP+GrV8Q+ni8q8MDrtgUXHeXI7xS5G7JHp8vNNQH3PaUXrBaymgWblJa68sntDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773049; c=relaxed/simple;
	bh=Dv9KHRHIkhlXXihA8tlvzOGYGP+ZrgFKTlpzZ0LcYYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u51l5xda636MOt+ZWwPLyplXdlAMrhy3xAHtlXti4cOJBtCTmwwtIoxdbEFbDVx/hh9j3/uaLIdjROSEOplDnqxLyfbL7u44PVpjLEfPNoPd4EyyFzsPEv8fZ31WPAPck5JiuBY6H74LGGptz5jpbtnrOVlMsja0s6iu7pzcSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHEGuuh4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2327aa24b25so14764525ad.3;
        Tue, 20 May 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773046; x=1748377846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUEqs6dZhNI3ovSU8UcexR0LzNfKYj8EYbPae4zKS+8=;
        b=FHEGuuh47nKDpi42V1E9Z+GnSiE7hqFUn6rlo82yNNj0ZlVFgLpjx5zmwwqvsGvlfC
         kQg9w3F15kVbh++0fkXKZefPIJnXSLQ9rag/lBnXoDC1zF4khj8e/6Ah4lX2UO300xN2
         y9wmtcdDk39QLQz+RlkjlWlCjmNyOqCQMECWrTUlhrkLU0+to+age+R91kx7jXYj19QA
         z2XEOGdLEl35lLorogdwnUAQRkR/b+lSPFJhBMdaXdfcTy9KiGpLz7GYR0VWqJfrav6r
         AOu6DzcBosVc0i5Rews8yUFkrvUa9JP8kNuCgmmfxHwUDdoaDE68jhGhWNZwk1VkRXYB
         JY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773046; x=1748377846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUEqs6dZhNI3ovSU8UcexR0LzNfKYj8EYbPae4zKS+8=;
        b=fGtyp2fyHczWYud/xTkhQ6cUyoCWYv+JkOQSOYRPIo8TYASEyieKfk5hD8lL5KmbcC
         2Yy2vCg1tZFQHi3+StKiVs+lfyzmREzhTlkEH4z7oev8poV9RMA/Ex+f7OBDMb7j1HlE
         Uiz7macju8jY5az5EYyl6TykY433Cb1wgO1RCGtQpY9LPhBOrfwizv5kGCAE3JvxtYiW
         eEa0obUgAAD+8lcnGLYGGB4PysstIpxDIL71TxuH4SauV469e27nPc+KrsdyFk3ImqZo
         7Ie8dAaBDZgnMRQbrvlDZ3Mue6CyJFYRTYrC9jwEDEPB8e/VPuOEOlh5lCNnhdMoRE5v
         vHNA==
X-Forwarded-Encrypted: i=1; AJvYcCW442J1EvMWzdz5t/Bp+PXzQ0cKYJSznixLCLKFMkvcwa1yL9UuoZk9/2Wvc4TTATOofqGN4gyl7yvBj0U=@vger.kernel.org, AJvYcCWlTY5HXX6oQaCuvSlBJp3kPwheEiIe/CtYKY4PNaMe/beEBYkZkbNjlPqoGzlggSviyO8crpncT23FXyiN+DUi@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNyzIYCKQcAmbMHfUBIP2k/LDeIPdrD94itnA2xgMe/7hQiKF
	4VMQdxnJYvfqaFalhyRB49nQLi5MameP0ZngsM+9g6MAx/XYjcA6Q19wfc2K
X-Gm-Gg: ASbGncukvlkvrUewq749Kz98bPm3yKv/voxXX27VPZ5+dk7RJRWqOf3klRiFuWpaLoZ
	4UVke8hRZK6L81ozn9d3qLqAamceCQSxLfDWBIT9vZzwdyQDXjm3fhldKxmiEdNOYZoCGxBNZC1
	k7J6YoRS1zqeL4pHdZ1mqzznaUxtrebkYyURZvUniTLO+Cis+anJ6r1N1feJkFstc9V2SF40q4N
	wENE23xwbizxr41QQuVDDBgz8jZs/NPPRp3twkuMCCPdrm2ooe0DjSvDR/eALRcvyY9mCtHGbNC
	CSiZPI3bPGxpZ/OMPicfVPjjQ2xk55kKz/RG2LNqsm6IHpYry5nfG+gTqevrUUZeBZkiM0JgAL4
	8jIOPrmKYcSxJ
X-Google-Smtp-Source: AGHT+IGT2lNEBwf8awb27u1brE1IBOcEYa4FzAFb6XP3Z7d3y7G/2OawqOjN+NLOvmB7v5Y2PxRwcw==
X-Received: by 2002:a17:903:25ca:b0:231:f5a8:173a with SMTP id d9443c01a7336-231f5a81b85mr161086395ad.51.1747773046246;
        Tue, 20 May 2025 13:30:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231f04e75bdsm70345625ad.216.2025.05.20.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:30:45 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	viro@zeniv.linux.org.uk,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sagi@grimberg.me,
	willemb@google.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	stfomichev@gmail.com,
	jdamato@fastly.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
Date: Tue, 20 May 2025 13:30:42 -0700
Message-ID: <20250520203044.2689904-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
iovs becomes ITER_IOVEC. iter_iov_len does not return correct
value for UBUF, so teach to treat UBUF differently.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 include/linux/uio.h | 8 +++++++-
 net/core/datagram.c | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 49ece9e1888f..393d0622cc28 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const struct iov_iter *iter)
 }
 
 #define iter_iov_addr(iter)	(iter_iov(iter)->iov_base + (iter)->iov_offset)
-#define iter_iov_len(iter)	(iter_iov(iter)->iov_len - (iter)->iov_offset)
+
+static inline size_t iter_iov_len(const struct iov_iter *i)
+{
+	if (i->iter_type == ITER_UBUF)
+		return i->count;
+	return iter_iov(i)->iov_len - i->iov_offset;
+}
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9ef5442536f5..c44f1d2b70a4 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -706,7 +706,8 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
 	 * send from. We do not support other iter types.
 	 */
-	if (iov_iter_type(from) != ITER_IOVEC)
+	if (iov_iter_type(from) != ITER_IOVEC &&
+	    iov_iter_type(from) != ITER_UBUF)
 		return -EFAULT;
 
 	while (length && iov_iter_count(from)) {
-- 
2.49.0


