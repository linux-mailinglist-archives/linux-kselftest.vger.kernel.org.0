Return-Path: <linux-kselftest+bounces-41421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40BB5573F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424743ADA21
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2835CEBF;
	Fri, 12 Sep 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfp89k+a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17B35A2B3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706858; cv=none; b=GoJQRLyGFbFhnfTgYolU5iBnRBQfmEOwejUOWYfEVQBtmdwTK/BmOok/T0Y/lt02y3YTql1V+kQg6BJX1xscJUfntchPoWvyX2Y2RmjMwQDu1t1a8UfGbE02oXoGu4Ec3kv17RtOrPoY9Eg7wehUBb/UEvtm2Xdydk3qTh9tMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706858; c=relaxed/simple;
	bh=icbkvjvQJUFVCkaCJXhVHTgOSqoKQBetWKx3gQY2/kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ig4kase4jdaTMgLpCaCS/dBY3JmOH6nHlLe9CUw41u0XCmapo5PH4bYNP/77OyCdySKtjmccx+COQwjOEQrdP89ZDTKgZInEXNr4GnXj29e2h6xt81YHlVCP5qgFrgNWUj7gqBjZLNjB42bYBVGWzkbWzvVlhAgBFdJxsEgBsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfp89k+a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de60d39b7so16773645e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706854; x=1758311654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=Nfp89k+az3mXppfv9w5wgN+4jCy1oi6QTALBueEqIjMUhJNjUrajkNJwFZ+uOyKGYi
         C4L0hSz4pPnDNyg/wqofjGGh1SdSEIOZFrgpjTtu2z0pMGliR0lWfb4zCNeKnFw/V+Mo
         PEGR7w+Q7zN54Iw498IuN8UHuY6Go1clnf2PshtIkWHZeUrb8SlXQhLIY2ON5+E6o1p6
         65V+NvUNgj78FCNpgtM2veRU3OKtgPKnSiEafjilUmakXuArzBf/G9Isc1C0T+mEUoLh
         h6FEcKTabTdiWAeVekhMJdzria00VWRuIY8nasVnLcfSdYp/Aw4qRjGKAiXkhkvWI/Lw
         Si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706854; x=1758311654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=cbbu3be+nkGXqmPRSedsxULv4hqy0FrloqeUy6swKaZhqlDqZuv/TCP29Dtid7Ck6I
         eeqvTyXqd4VQKJ3OLzZcCEVBuB16YoiN7MX23EwK1B3cN32CD6b9mkRZJ+oUYsJDdtMp
         kAaVI70Z6uNxI4J9Eaq8UHSvcR9kPpzta56ENpyfgU4CJxCfWoWkIO8tbf8Mz4BgbPRz
         uiIhdoGEGSJFdu+8mP8QPVesJMTfjCrk7yiHS6XeFv2URQ2qv9Tf8TnhxINNqzWARn73
         IEc4dBtvyR0PGYQ4SXDRFcX2NPjDzck5CEa5JTB4ccNoW2QOTwUUPxihb+HOmWIkt4wu
         ilQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUin+17raYy2ab9rez/+ByGrxpYC/bGhAi27R6HxII0NnQOoVqfVPrvizzL1k5eiqARHb06tzyvZDSM+OZahBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pASq+Kt4RLqdxSOuabz5x3ez9atfAGquy69FYbxSTxIp5S/S
	eA5AEoYqAJU1VFtD04ZHNTggxv5vmeqrW3w1iRGptULq0tKlTLTr2hcv
X-Gm-Gg: ASbGnctFGpQZSLFWrURLNtMYPtawjHg8lIa0MozXwlk9Ikpq7pEvgA3+z0mhThyKOEb
	j/MYNL6G3AvsOMVUge95SGEY16XbUfK9FHExtsEKbjiqDboHpCuhij2jxJhBnkeOOGpvZ7Vf33y
	Rb/sRPeSTrlD87AMmX5z4S0o4eg+fUzAvoFj8SzHYoKrrfVJQuYD63rvN+SdmT3Xs+s15YuEA0b
	Xznxxb2d+tiKGYf2vHZ2y2XNullY60KSwPwiyO/x7kCFcbm/jneew3rB0JSGc+zFEAOtuaIjeyE
	dCSdj8FjPtkDvQPRwXeWf7032HKa2zsRwOc76i0HSdIzZQ3po2K2TeCnz4kOjRPiXGaMB/Cs2FN
	gFEpUXkomEdfjSwE3P1TgG6+tkL/vSbpLnOPc2e09HdMjngvNH24sy+pFJ9Otmg==
X-Google-Smtp-Source: AGHT+IGDemjaEgtgOCoyvvb4Rw0Ry/Drus7N9V4sjIQEOXHnP0EXYeoSrzatSrGttoH5W/PqCe+s8g==
X-Received: by 2002:a05:6000:4023:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3e7659f3b84mr3972483f8f.52.1757706854322;
        Fri, 12 Sep 2025 12:54:14 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:13 -0700 (PDT)
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
Subject: [PATCH 6.1 15/15] selftests: net: genetlink: fix expectation for large family resolution
Date: Fri, 12 Sep 2025 22:53:38 +0300
Message-Id: <20250912195339.20635-16-yana2bsh@gmail.com>
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

Correctly expect standard genl_ctrl_resolve() to fail for large families
with many multicast groups. While kernel handles large families correctly,
libnl's resolution fails due to message fragmentation:

- Responses exceed single message size (~32KB)
- Kernel fragments across multiple messages
- genl_ctrl_resolve() only processes first fragment
- Returns ENOMSG instead of family ID

Custom my_genl_ctrl_resolve() handles fragmentation correctly via dump
mechanism. Change EXPECT_TRUE(no_family_id > 0) to EXPECT_TRUE(no_family_id < 0)
to match actual behavior.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index a166f2c474b4..8a394991fe32 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -437,6 +437,7 @@ int validate_cb_ctrl(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	case CTRL_CMD_GETPOLICY:
+		;
 		struct ctrl_policy *exp =
 			&data_ctrl->expected_policy->policy[elem];
 		if (attrs[CTRL_ATTR_FAMILY_ID]) {
@@ -1485,7 +1486,7 @@ TEST(genl_ctrl_policy)
  *
  * Verification:
  * 1. Custom resolver returns valid ID (> 0)
- * 2. Standard resolver either fails or succeeds (platform-dependent)
+ * 2. Standard resolver fails
  */
 
 TEST(resolve_large_family_id)
@@ -1500,7 +1501,7 @@ TEST(resolve_large_family_id)
 	/* Test standard resolver (may fail) */
 	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
 					 LARGE_GENL_FAMILY_NAME);
-	EXPECT_TRUE(no_family_id > 0);
+	EXPECT_TRUE(no_family_id < 0);
 }
 
 /**
-- 
2.34.1


