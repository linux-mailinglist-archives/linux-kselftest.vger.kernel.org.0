Return-Path: <linux-kselftest+bounces-28477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC60A56623
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F5B189941D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053E2153C4;
	Fri,  7 Mar 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="01NiY8mW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F221516E
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345319; cv=none; b=m2gzAIfymAoWvfNy06n1kjnQargn9KoXvSuL+QldONqArD7GYRlgI087Y1KCsaLvtrosNK/3pxeJm5DFRE4bg1qp9e3HGVJwzX4ykx0k1h2HNfIp6kPYTALJ+MEs43iZvRRyzaStPBT6dVmC4fyQOPsMFsrRet4+bwK5IdrPs5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345319; c=relaxed/simple;
	bh=l0j9792/xprRDyqQ5vGaOT0IcUNGmsCkmjGv84fkI2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=JLL43JJLGpN4cFLKpxa6QtFlDLhgB18JG9390WLq+ID9hps7E4IgPhtiS+gaUY6pqArcSbW7ovJpOLX+457jf9/p4mobFPIPcqcGhThcnQJ5oLJAtze4Gh/oJA2i7BbRM28mKNeMbIzYjaZyLUn/zEsGl3CfNA+74eqzt37L4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=01NiY8mW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22401f4d35aso30788815ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345316; x=1741950116; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=01NiY8mWhLS2eGkrQ6ak0pBnnx9IIF8ckybg08PTUGVFM8Hslska7MyzZOHQlj1azp
         2AGtT+yvLeB1WaMeLy+l69hqQ2xX/9QXtDDm4YhCgRuasymHSrPzTUgIDy23NEXv0x7T
         Cd7UhdiWIGNxoX5ozwH18DwlMmPATDrI2VyiRErhkrU12QYisIJDFBjPhbrmqyog1U64
         OExlA/qTkALRtIR/GdrrZDDfNuBr8DnebwhzyzVWE29eH4kX2eNgehq/UJMB+8EIj+b7
         xQjeNBu4cxIJyBM1RC2PVoi62L1sHhJQVFD+nGr5KyWpc1NTzGudONKrbO8/qPD5Q2bZ
         3ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345316; x=1741950116;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gARYsHMNOA21b7LAy/uTvYtGV6sZQsjc9PX6HaN/qGk=;
        b=TbL++eAoZnm2jqBXIDg8VmMBa1ii1WWyEZxszHIaGQtBQRVNsymYf3WUYaejzkDMR3
         kTaWjqq2yHfTsQakJfIGDie1Z3o7AzNcJQqjw5FplMmiUCCmx+xqugpjavwIvXxfY785
         +Au6dmvu48rkn/+FQJw+QaeJQJZCmW5Wu2f1JYHWq9DMZoM93UTVXRNM6QAHxI5yteFg
         /8tZzG2Abu2X4Jd7vGGbtvk8hKTOoh3APG2Yeybi7VdqRcupPaSlUu/uoy2+YQHOa8DU
         PLgsn2tya0ebtEfkrPH2R4Re6ttfeEtFoZAXO+1aFGv/NdRKNMYmt3JD99WEUgRbeB8x
         OZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXJGuGnjTQ2IKjcH2Fubs5Va5RX/xrgjwmNUUcCmRJeOdJy+qHkS5lO92FL7oHTy+/ha7LPiJMJE8dkELUuX1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/zbHY8fTsk62fOQLDIbyfrNDjQmgjP/dI6A+j24U0r5pt0KR
	YC3ddZWuRDs/FOAJ8TifwNCKFGD/guuYdF0D85/Lab3UmifNNCq8QqCuO9wWGTQ=
X-Gm-Gg: ASbGnctw39RAbl93919u11s3AxS0v0LwgyZPkW3wYuiBp5oiq3y7jRMNFpEKyuzNWjX
	4+lzjm6M1pSKz1mS3gneAlKW6rYqZHLhwlirs4JuzJ4Q6pyJ6ney2oqgGJCkZl5TPbsBP/JueuM
	bTgSMZpetZS+YsiHF+HoxozfXVTiIkpeD2u+gI2ShPj247SU0EMfVb5S1MToSpabtVZglY/AD0w
	mWK1+ctQSlM/VKA4EvVF6/AKBpVM6UA8ZWHSfaXBCEVW2o0jlfe93wuD/DOiJdXLpF3PcpGZ9IQ
	fj2yOrbzJoL42FfsP2KO0UVClBQMh6v7F8TaKceI/kOVdDe5
X-Google-Smtp-Source: AGHT+IH6Rro8mN+N9sKA5KMUIdPn0sx3wUoBP7bD6XVcDcfe1R7X1FzMRycZ2IlvjtAva2HNtTHX/A==
X-Received: by 2002:a17:902:cf01:b0:223:5645:8e26 with SMTP id d9443c01a7336-22428887bbdmr46153055ad.20.1741345316095;
        Fri, 07 Mar 2025 03:01:56 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109df225sm27431015ad.47.2025.03.07.03.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:20 +0900
Subject: [PATCH net-next v9 4/6] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-4-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
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


