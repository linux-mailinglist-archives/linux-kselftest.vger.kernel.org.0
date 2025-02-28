Return-Path: <linux-kselftest+bounces-27837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07CA492C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB497A9B32
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41891DEFD7;
	Fri, 28 Feb 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rCVknn+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9F1DED7D
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729570; cv=none; b=WKujBFLQl+uDjGz9hgaPYv8tNkk+9s5WVmHL2BK2w/vAcOAw2WUKvwOSTr3gr8gnv2q7U3Fnk7O47t8eOEVis3vh6mhn4jWkcGPObxSWYox1ojypDsUAbXLlmCbeAdnY+76ue8FbJlX0Vgbq3E4Z6F+Lz6al+ee03buxQFLQGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729570; c=relaxed/simple;
	bh=nEE2/C77oF+j3LxMBPOVoqrwqXRBAnjdJN3gCt7XvfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=WfLEGgzaoYr4OsbZiSTZA+cJzQtPQ8LHDzLnQHhTe4gNbheJRur73sjy5hPxjx4GEu7dxuIXxbyZtk1hu/qaqRhVqQUUeCZNR3x0NAVfjCHVmZykLLQRGCN/cejwxE5CZVQ+FBliILBSrSEOQv0D2mg1D+MjXKQT8Ax7eSqe7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rCVknn+e; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso2427078a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 23:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729568; x=1741334368; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=rCVknn+e+OkQz9SUULOPDMPYr5DJnJsUbozQMjF0rkG5rVIGlwFbq8tUnyAf+Iw1fg
         2taTxmIDbxWAkvv+2d9GSWMoi85DrNyK6sRQIMCJOY4LPcUac23QR2M7Zg+1ICxMzOQa
         eAZ5YsXwOUU6whCx+MfXO2Yfp+pVHJO/lbrN/y/aS5sD8zwQZLLalpM+3hV47HkSeapa
         axjx0VFMmNS/9A01+gY1vrBE80hF4uIhQ23nEWcoMYODYZy4EsqArgKWcuO9v+YB0PUM
         iVlXAMTzmfbbnyuz80Pqo/y/31RLQiIRfO6b/tTHPxn31grYWHvlH6vwopZj2GAboSlX
         ZEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729568; x=1741334368;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/24Tf2dJCQDhe+eHaFoVGEomrBLp8dkxojt6Qs+7G8=;
        b=uOeDGDcm8HI9kpyGQ9zbME48GRYkBVdJ0CWM224SylWzUwr6vicSKWSyCxdPcHkQkn
         dEGoV1//V320y2SxEg4lRhVqXRKonizhH3JAXNw0sLlPRPqZ4MnzSOyaT4leefHn/VCE
         Liu7cjbH/fcGB1/AMat0EnOGY37ZLjU9mbO7NPuE/64QGWgfkp6gSW9uHX6sBVW2Eplt
         +xvdIBygOxyWcGcyZapduLr0vQLAXBOev7S0hRSKGAPcbj6RAfY1QJp90eU7TsgakuLY
         kIgJlxWpI18D005u/noxg9Z8t4Kx4k67Cbi+kLlFlBl3r1i/dMk2t9XAIwV//nE3mJHH
         MJtw==
X-Forwarded-Encrypted: i=1; AJvYcCVecxKdby4YjcisnomNu0RFH9qtLW6K6J5c8fYV5fsUkxQcKY3iUswJgrho7wYOf0CGibpDNjEBrPljcxsAgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QN/uW+SULdQBELbTMSsqF3Fer1ZzOjiX4EUMf+7GpzjESK7j
	aKhhSjvlavo9fOF82FBot/mwg0eTk2JQ5H0AK0ua2jve0wtXGHClEiQ6wCUhJNM=
X-Gm-Gg: ASbGnct5Ft4fqLDPtT9ZksuTXpFZb1YDXaygk8ZniaTeFRaF+LNtpjl/MfBMstvFgtM
	F5r027aEX0cf7CYvZjNShK7/vr3ByQh4m9EI6BDst1MhCYEzy72aOS/7+bEmU3okKmnv9CYvven
	nhUwhpYj3UbJGzjB3mCdpvndA4mSWCD2aRskTG1zdKPUsrREfX8HQQrtxUSgGN2inrLQ2EJDXcH
	n7tCsW7IzF4Jx808ZV+DmpiKvYV7lIo+MDKPoXBOFT61bkUX0vh91KDd1HdpJaLPoDa4UkCo1uT
	GDkARC2gtLi4qNTE67Ivx4xE3T0D1Q==
X-Google-Smtp-Source: AGHT+IGakArRWPozSXDLt1J/ZIr5ZW8i64CgVAq8BmJe2fBTFkpotPO0s0B4850yKyMXjttbX+FZIQ==
X-Received: by 2002:a17:90b:3845:b0:2ee:c9b6:c267 with SMTP id 98e67ed59e1d1-2febab403a5mr4261783a91.9.1740729568382;
        Thu, 27 Feb 2025 23:59:28 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825a9681sm5223275a91.9.2025.02.27.23.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:50 +0900
Subject: [PATCH net-next v7 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-4-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1be1c93adcd6c2f07654893cf97f8..463dd98f2b80b1bdcb398cee43c834e7dc5cf784 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,78 @@ TEST_F(tun, reattach_close_delete) {
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_deleted)
+{
+	char ifname[IFNAMSIZ];
+	int fd;
+};
+
+FIXTURE_SETUP(tun_deleted)
+{
+	self->ifname[0] = 0;
+	self->fd = tun_alloc(self->ifname);
+	ASSERT_LE(0, self->fd);
+
+	ASSERT_EQ(0, tun_delete(self->ifname))
+		EXPECT_EQ(0, close(self->fd));
+}
+
+FIXTURE_TEARDOWN(tun_deleted)
+{
+	EXPECT_EQ(0, close(self->fd));
+}
+
+TEST_F(tun_deleted, getvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnethdrsz)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHDRSZ));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetle)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETLE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNGETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, setvnetbe)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETBE));
+	EXPECT_EQ(EBADFD, errno);
+}
+
+TEST_F(tun_deleted, getvnethashcap)
+{
+	struct tun_vnet_hash cap;
+	int i = ioctl(self->fd, TUNGETVNETHASHCAP, &cap);
+
+	if (i == -1 && errno == EBADFD)
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+
+	EXPECT_EQ(0, i);
+}
+
+TEST_F(tun_deleted, setvnethash)
+{
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH));
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.48.1


