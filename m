Return-Path: <linux-kselftest+bounces-24105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF43A06ED2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EC1167A4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4E215169;
	Thu,  9 Jan 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="irZhKMoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4121507A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406878; cv=none; b=uRY9I1Pu3amry9ZHxDEYRTTKB0nlFmIEB3T0LUh7maw4oc9TVzHGe54EPXyFQSnvPXvViecgVWAWFBns6rLZjDLqh8bnszXnJnfixkxY9F2VfxUVdsIJX+s8tp9LQGbU9v7cGCunSoFemAQq3tbvBium7VFJlOejYgpXj7rpDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406878; c=relaxed/simple;
	bh=bKMEvJwhH14xg+cNxuCNztQTA+YdMMHjdpgOof+VPTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rCahOznGGpYkyrx9MncJo7Ip/jS56gRHIoIL2MTNtf0dkvBR4Xsqi/KV9RJoWB4zEAlmgOcvagX0tFWOSNowu1tB/hDNllxWg5JPj9n54dVyNmRwXMUwlIr3u+a8MG5zNBO5gt3B5qOvDFDNKh/kvuBPBxONfvNe9YZ5SAO8Gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=irZhKMoS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso8281195ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 23:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406876; x=1737011676; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5JVItUDqWznN3D/qkeD3NuSCrOvt/lnTEOCr915p28=;
        b=irZhKMoSLwOlQ0gMgeqII8xkMtHk+a07jojdQ9EpG4faS1XznQ/hxKvwlI36RnOpV8
         vmTl14VpYbcRQ+yD8mYZ6yikW2jab/c/0Qk/Apz+8/gYvuOKaIvFk77+EV4cOksYlzi7
         BbrNhs8Bm661+ZPCNLlBPP8EqCjAPns4Np08qEJgWVynrejTIW3tPuQgvfsLXIjCAtvD
         Qc6ttfFJlSU3eFioT4SxcJupzfJgKKcrweecUEu3EQbUxdWHaJ7Zgyp2hp48JhVfPJEx
         cG25jrafBuy3n6ecpA35ojx9cGLOe+510RMP5TliJS4zBMl7TfH6mq2vNidErX64pUU0
         sxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406876; x=1737011676;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5JVItUDqWznN3D/qkeD3NuSCrOvt/lnTEOCr915p28=;
        b=Ar6nEMGa25HLurQTYk+7QEWA+q2wgIp7QE3oEd3LNywCTBD/wfGgSFwxhhUpsqoGQH
         7Y9mx9QquuIKKGi2StQpuhJ6NeZSaCrp6PeqaIUPkcinrjxU4+Ja3scGfYR7Ofqr5Zr5
         xDA6XIvP0RnWONJuZo6zlFAP1393UNpwlBpeOhGqdLdoKs2+YyxgeBbNkzAqtvopMZyM
         O/dddHT3z0AcPHLottEffmoTsgmnmBnpM7JEPiQNdiLhoc+2FJJTc3F5cYLv/yV7Dv9w
         /TA2iU1SPht7lNKV5HsyHoZH+3NV48tNlrOLIkh3vEJ3GqpAxndTQOMwgRm+Jjpe3Gd6
         8uTg==
X-Forwarded-Encrypted: i=1; AJvYcCW9vYzoqj4UHc4U6aThvghEJBdPzgCwAt9aaK4coS4eT0stdRw/OllWy/DTZshaV7/E/LN8um9VoDHhQ6b1ZvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTqZ4eOB4nX5ufesDt6doebhbLs02MoC2XKTXkZwBl5qz9KnI
	8MhndGIvij62gyLJkleVlpGSIf23Jr01jsXcae2fS9fXMpH1SrDKqS8RebSCI+A=
X-Gm-Gg: ASbGncvVpPQhmGCR1HEy6qWumBhRHW8qY9JtOwraYS5KH7vivUq1/sF4GD0s6kyAkN+
	K+JHhb0gFMCv+i9p9PTzWdlfDr3nUXmJIRCLu+6HGAjgx38rCtRPyNpdgldNaCLyohgVOrcRIyU
	Ag9l+Tu1R3E9tRpHRIAUfFfXFWW+/f6slckXyWBMBBWvSJcCPSYXDO/jqi+b/5EZBEJ1PPgWsG5
	5rPCUOu4jTpBIL6Vui79U0DP7xzpT4I56ymCqk/PNYs+T6Gi5A2J5mxVNk=
X-Google-Smtp-Source: AGHT+IGPJuUGyRRURc1qr4TS/2LI/qWJLc1yL6cIE0cCrjfybxEqzid+tHM9XM8b4Qxi4Ej3H+L8mg==
X-Received: by 2002:a05:6a00:1a89:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-72d21fc0b36mr9799011b3a.20.1736406876527;
        Wed, 08 Jan 2025 23:14:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a317a07cce2sm635365a12.4.2025.01.08.23.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:42 +0900
Subject: [PATCH v6 4/6] selftest: tun: Test vnet ioctls without device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-4-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
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
2.47.1


