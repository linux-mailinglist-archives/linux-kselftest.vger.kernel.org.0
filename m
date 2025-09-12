Return-Path: <linux-kselftest+bounces-41419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D304DB55738
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B767B61965
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AC353354;
	Fri, 12 Sep 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv8bvXwn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CF350D69
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706854; cv=none; b=HCiFWYMJKBpd7FWMHDunYT5tP7WO38mzUpWM/7BvaA58RlbsCOlXh6asROLYbq6p0mLJP447CHxUmAdE6VYPIileoDxQIhrBJOFGFb/sXiEGJ2mcjUXKuV97n6RSL6S9L1VnQHi481MT4AbMBU8cCS43dY4UFUFKaRVWaHkz4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706854; c=relaxed/simple;
	bh=wyOfA9Z4qZjfSNCnN1Zoeu2Ob0/D/ATgwmgGwmRhB+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwnGzbaMdiIOC7bFaYDtTIXEAXuDP9ySaxDYmf/eRTKKiKUtXy/z0CkcMOG/f4uX6vJBnzGSYVsTqyadZVJFtYtLA53zNkJpv5Jek0O1GzK20oue8PEF79szjkDIJ/eSKHojnsmlJ0IsYdsZAkK1c35gcaxKaOB57i3kNyUrJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv8bvXwn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so27438145e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706851; x=1758311651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=mv8bvXwnZbyDXMRxWeCJ6EOm6yfmLYsAFxTw1/nSFFIJJOoMOt8QL01FLf0lkQCp/1
         bocDdq1cWziNX3nbLYu8uF41JaasPlg28rnnxI/cT8whJg/dG7RUmheUjpf1XWCXo0+R
         Mwny2WT6MHWWf3hKVbCKj3xpgSpmrKMPuTrYYqEA8BNQKbeIP8KXL5ECZ2k7k9z2PtpM
         BollAa46Kx4aUnkbrJ8Q1l8YNtI0Kwe6xyBmsx7AZrvjmiicXERzpkevFZnhcrXogfYF
         y7mn+7eJxgo2P+71/VkIlW5kZ8TgLHP+ycAKNo6qpAtopJDuVazvReGXQO8xgX4h7Q3E
         e5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706851; x=1758311651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=Xkjiw1PsWJ8qPiqmLlrbvuvYNDgwqGTpvkjD0SSdmp1yQ5ObRbzQW8zVCxN8Oe17Ie
         EsuI6jpaeRBN1l38n7qIoM0um/vV7JxHpIz+2HVyUkBuOfHPSowjsq+9rpnkZRe7knqN
         ltI9idEQn+kRKT0mYUdoQIPy/3m+K0/QWqlCZn4cQdSLOxl1eXDHYAbsC5jYEK5VPStM
         Bq5tqIQYVd008tN1NlR7sbQlXxzP1Vpw0ZDbcHycRKmuAv7184810xecFEcdWIlSoeBl
         h5a5eT/CDp7lYpPCPlHiCcAwol3wCDDXXLjUjtJaxTJvpvdHGm0IrI1YtxrGev6YY9r3
         /RxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbcv2WWYuBZUqBlmHfkgD5EPVNF9rTgdE69emS+fFP9DV9sREFvIT9HHtBZx/rhs5D0uHP9s79Mbs4f2yV9UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xI17/mDR1XVRi198dNf95IA9Ek4wAZs5TfbetbzkAMYAlooD
	ARIlULdJYls3FlVyjIxV21qYDV9Tg0C4lrIU7F50SgWlAf6gjStu6oz2
X-Gm-Gg: ASbGnctN72Tr1Rw9V6PYUmC/r1lvwVb/crD+dtz8fUsfY/e4pqPxxIXcGW/FQTIRyC1
	z7iBtv//YhhLQUK4HrqLd7HKkzAHR5+9yeQEoZrvusJ3lhQ0Dg5utXwhf/F8cN71RuHLJAtWJ8Q
	eVVDpvMJgfsT8wcO+J0oY7LjkVD7GNrKkOSZ6bzGUijFqjSq0BLtgGyh3vFHvlUiuADj/BQV2v9
	LWIuXERClGTHftA011NYDrvB3ZA1AoQpL+LX/ofwIkFZZ7LvN7tpJsKkGq6zQBg57uQLf7y2Lqk
	UJiG6crMk3KXG0j05c+6DVsMXbMK6TVTq38sMQsAUYoJEszZU30OYBzs/0c7lmUFQmqzRRnIXqx
	X+I20gu92td3qlgKVyFshQccn1gxjABhBWNp6v9jhFqYziMQK7JdTKyt4KhvMklq/jrAjLQLk
X-Google-Smtp-Source: AGHT+IHnxAVngHZQRsePAFq7iynBLmIa8Fg7O2Z7VTvuVafjtGYamzNuY+ON6/+Ls16YAqNHgZJRXg==
X-Received: by 2002:a05:600c:350d:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45f211c9c3bmr39664915e9.3.1757706851085;
        Fri, 12 Sep 2025 12:54:11 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:10 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 13/15] selftests: net: genetlink: add large family ID resolution test
Date: Fri, 12 Sep 2025 22:53:36 +0300
Message-Id: <20250912195339.20635-14-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case for resolving family IDs of large Generic Netlink families
(those with 199+ multicast groups):

1. Tests that standard genl_ctrl_resolve() may fail due to:
   - Response size exceeding single message limit
   - Implementation expecting single response

2. Verifies custom my_genl_ctrl_resolve() works by:
   - Using dump mechanism to collect all responses
   - Properly handling multi-message replies
   - Correctly identifying target family

The test validates that large families can be reliably resolved despite
kernel message size limitations.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index 0a05402caa20..361840aae918 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -1142,6 +1142,43 @@ TEST(genl_ctrl_policy)
 	nl_socket_free(ctrl_sock);
 }
 
+/**
+ * TEST(resolve_large_family_id) - Tests resolution of family ID for
+ * LARGE_GENL Generic Netlink family
+ *
+ * Validates special handling required for families with many multicast groups (199+):
+ * 1. Standard genl_ctrl_resolve() fails due to message size limitations
+ * 2. Custom my_genl_ctrl_resolve() succeeds by using dump mechanism
+ *
+ * Background:
+ * - Kernel successfully registers large families
+ * - Standard resolution fails because:
+ *   * Response doesn't fit in single message
+ *   * genl_ctrl_resolve() expects single response
+ * - Custom solution works by:
+ *   * Using dump request to get all messages
+ *   * Searching for target family in callback
+ *
+ * Verification:
+ * 1. Custom resolver returns valid ID (> 0)
+ * 2. Standard resolver either fails or succeeds (platform-dependent)
+ */
+
+TEST(resolve_large_family_id)
+{
+	int family_id;
+	int no_family_id;
+
+	/* Test custom resolver */
+	family_id = my_genl_ctrl_resolve(LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(family_id > 0);
+
+	/* Test standard resolver (may fail) */
+	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
+					 LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(no_family_id > 0);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


