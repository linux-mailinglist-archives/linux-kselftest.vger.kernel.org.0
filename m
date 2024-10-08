Return-Path: <linux-kselftest+bounces-19211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AE994025
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2591C25B26
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18E1EABDB;
	Tue,  8 Oct 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NjPvVRKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA101EABB5
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370525; cv=none; b=lnVf9NKEm480TGn3qQRyInY5tLywnCM2bu3UxLojKIY+bzozuFa5MzrlizkSn9briHdUawtOWD9wwwMmNLQl3J03jsWXf8vyrLnQGlzzaW1AQ0EWZOVgD1pRi5TmYuP8/j25GCJu/L2a/BqSYEsgz4PvTvQi2eEZakoYuQbaqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370525; c=relaxed/simple;
	bh=aMMcGMlIvM+5vysEFQY82Ld7Vd0lkGqNTVfE62GAxgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=od45wVy8AvyE+l1uf696kvm8c5hzlefNvqvokbUQObkFCi3d50x3VmtdOsQuC8FXRRLOB3rUhU63OoE/Szwx/yUGVGBTLICdYUg2tM0W3KixWi8yNlFGHoyMW7In3K2NaYxZSmM6xOMiLv2UdYA1xkoTHCWfzUYDrf/hASW+3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NjPvVRKC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e038f3835so1535470b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370522; x=1728975322; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=NjPvVRKCUMKmtijp5aTQtZxfAxbPT0v+EX5xlri2uVDsgwqFNWrluIKDuoveCu5Kyj
         9FNaVU6NcOx6XN+frNm0RFCd5qbiyujwbKXHg4G5q+0YI0nsRZ2CoerJg8FV9Mg3riC0
         o8gh8xoSdhAP9BLSAksXIhyt9aaIzYKH5J7ysWaj3Kim+iII4HpnZhLiRGf/p+1U0Ycg
         XB/Zf2kqQ7m6GWTqX4OozHr50QV2n0oKEQTyLWeb3flRtJsx3DAOYYn8/dR5Smtm7lJc
         MuCtT+IXMkTWGdVFu3p1+vvVBI208p/qecd/ElYDB/8oqwgx4FcEBfQGv1gNflAcBH5e
         yQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370522; x=1728975322;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uKsejVxLmGPlZDZ2YAoWDts+QfkdC5shkCFnDsQphM=;
        b=HtpTwqUf9zBc4tQ2I8yzkOgLD7GVeQppREQ4gGZpF/YyZOqkQYO84fueJtWAHIdMYJ
         UyZv+YTGzXAyK0dEGSA0MG+xQeRgO998Arrb2ZGN92PX2x3zaIi+I2IZUtucF8M1xb6e
         AHWjmGMFc2hXlQnw3HWQH08YCj8TVgVwooy0Nd18KBqcWPHAtyZqpq+KZ8PiNV3izAQf
         lnSb+sZGDDRuI86ydCHktsytUbr8/plOHYbtsJgOPeRkZmKQ3Nw78YXyJCaz/JC+p/eG
         rKckrvoq6b4K9Rznqp0vujrzKvQdviGDNdEg4lYkpils6sfrJF6hxKqcw1aKvkTfdPrt
         Bf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6z+i0h13Do7Ok41Q0JjVHKrFRsDYggpKMvOUCgodBBHQcwgrJbGxAK/7j/g4gV2sghpEwW9MzMXj4ZXUXzzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBrSNiHcAPzsUqO4TD25PQTOf7yla20QlyOYLAygK4i7EJqf2
	lImPL0MyUv4dQGLIeBRxd/+98c0ig9DtlMApkE6Th55vLQtjNQBm7nTV/46yRrA=
X-Google-Smtp-Source: AGHT+IHpl6coI+ZO3xm7Go5SLIOAf4hTK2yXXSof1uFkX8umSQONLP1U9ZQGcbX4LKYOwCaQ5jp55w==
X-Received: by 2002:a05:6a00:84b:b0:71e:183d:6e74 with SMTP id d2e1a72fcca58-71e183d789bmr246332b3a.4.1728370522610;
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d65246sm5463299b3a.169.2024.10.07.23.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:55:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:28 +0900
Subject: [PATCH RFC v5 08/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-8-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tun.c | 74 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..463dd98f2b80 100644
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
2.46.2


