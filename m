Return-Path: <linux-kselftest+bounces-29213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39CA64B7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C7188F777
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8623F38C;
	Mon, 17 Mar 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="glPhiQEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708423ED60
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209135; cv=none; b=HEmnIa8xYP7ClhAN4Eb8vZ2CzkvyB2qZD7k/rQMs0UFIz+3iQ0DAITizTzSkEhv58wl6zpxX5FRUAp35pabuBy8drQ33ygvmQrFVUq5HSERkrB+zCzN6SXKbEdEJEx+0R50ndqX1e3nu3K9xSP++dKfs7RIWXjuOUbB9IRiVSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209135; c=relaxed/simple;
	bh=GneHmk/qL//iBdk3HQU3hkToakkrBvwUGgglHdEvMAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=mKE0ro1ou0ti2QyJo3TvJFLBTLnrsdX1mopDvEKgdUxhybsWbzW8Spd7pTE+XZtUg3aEo5ZEwBkhfNZnTncvXZ3Z1lv8cC8bvvITKYSJuaqrj+Pos8mJKC4FUyuoo8d4QpqklUBnjOF/4sBM3PuKq3yev1XWAV06rE8hWaZzwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=glPhiQEb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225e3002dffso36559295ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209131; x=1742813931; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=glPhiQEbgprPRJIAaiPPvdrEwy1JnHyYY/PfrZ1UIgFW6PYWjiCN+VgwzUkIeZeQo2
         oiBCFqtQ///+RLLqhC7bp6SOd0h+dteZdvIehfwMmI1ZJW5VsTPpPd6AMGFap+XTJEol
         8mrzc9YV88uSmHx5Y3kjCJhtyvS2vqE01jMQx72ZPzxWJuHNA9T2OxU1mB5LdWWkyDRi
         NP28ThgMdDZmaUpB/7DWGV0cRgj4XWXRN5qZGN2ljs6NpyRzq9dAVKSzMjMznNRvy4dD
         xIe3vopWjWCCAW9lPw/h7zqJYQtrpbaEjhJYyA1378KFroxAv/9Km4bFY3vSCeqBdGQg
         VsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209131; x=1742813931;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr9XV/m9Yn0vfZS8el5Q1nXWgm/+NfgkMX4LFmMiC1g=;
        b=RqrNVMzokJs2sAwGRhUK0yQwJvGKgKAa0/aApxsY3lZk95v7EXort8nxuJBhcCBkza
         vrFsGwenD8cJbnxkVMj4pVDLPAMpImeiqpy9Ik8d77AQnd2nTMPJeqFTZAwfTw3NxlJF
         FqQyMC55Xcz+0V+5qqVwuYQM9AP6zjo3S0bB8mG57Hu1Gcx4cA+gscp0KKeeaPmg6IRw
         1qAdFnHrttJC9TmCHlCJvYlWGG+Ktd2FcVFM5QvmKdW7aTDUpqIequk5K0m0MjRpH//1
         yelTR0qbmumYcYG59xRDoy4+KAFPbMmYQtHkBzJzEX52YmMnTIdywwifu19xFe8gbdCP
         39pw==
X-Forwarded-Encrypted: i=1; AJvYcCVuhGAkI8/VHOmzaiLWpLfLP7qAG0DqsCXZH/TqEMW1X3sMwV0YxlJyoKJ7ogQ/FaiMi1H1mhchDWwlpWfOckY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRu25t+EYzvymGIixSRZrg5PfaEM8aT+8uCz8/qS5dtv+DP7h
	zsmZJUBZIBbWt+nMbs5ZZbKAthmx1zvfvL2TxJeTspezwnuwt7DuGfs/dIFnP2Q=
X-Gm-Gg: ASbGncvyqsEWDIX6McEf0lAPL325HI/6pWiUKVtlVs7J9PM5ZH8jMcRjsvqTUc++Mwa
	f7AAr6achRUYq0huOirRhww4aqakguUn8AIy7xq7ng6EGH10uM2svpwxhFIApOfIPzpEgo+NMmn
	3DH40ae7D3g0nKySR2xmYrAgF/wN5t8T2bqVRsAzCZM9x+LqkWQfF1P3J8QrzVtOehisJFhdAVj
	yAH80jyg9HnUbWyvrv0UFE/a8nC7bamiM+2kwrGKR//KVpYCCyWpVKJDqEyMPthmmx5rOfwx37U
	NUIricv+uzD36ZBNSM6GdFmqNI/qqFF1zX/Rs7/AVnYsdxOo
X-Google-Smtp-Source: AGHT+IG+ei/lg8cM5wfrSZJXqZa9osmFd7Sc/z8/9LCogmJrZABRCUzflnBMKqILkfW838r3yRiXfA==
X-Received: by 2002:a05:6a00:2e25:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7372238e7d9mr16744723b3a.8.1742209131380;
        Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7371167dfa2sm7533712b3a.107.2025.03.17.03.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:57 +0900
Subject: [PATCH net-next v11 07/10] selftest: tun: Test vnet ioctls without
 device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-7-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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
X-Mailer: b4 0.15-dev-edae6

Ensure that vnet ioctls result in EBADFD when the underlying device is
deleted.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 tools/testing/selftests/net/tun.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..ad168c15c02d 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -159,4 +159,42 @@ TEST_F(tun, reattach_close_delete) {
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
 TEST_HARNESS_MAIN

-- 
2.48.1


