Return-Path: <linux-kselftest+bounces-33202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62DABA109
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193BF7B6D54
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7631DDC08;
	Fri, 16 May 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6QT4B88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA741760;
	Fri, 16 May 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414153; cv=none; b=GwsPe0E89+ztCx/GClLNbrDQwostrvTGMnYGnWEcjugIKs3bIrLb51t9FjulZv+oWcJ1qfSuW+67vY81iHtuqH1rRuUyS3YfujxeyXKQ7m2CX91ov2zgTQHoMXMNAUj6GBhNZtV84nIF2urKgI5m1tly/oMASOfiV/0nZln/bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414153; c=relaxed/simple;
	bh=/mlq8eQDbKPnb3XOZNN5sgJbyvO/ncRpvHJjF4pxdno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8OVsvv/L15rH/i6X41BWRlnkrFsSVKqF4IkS+1YAZLhSSR6vnDh+YUA0yy8u9ZORztQ2YmGx36sH8BNWPywAvWHdSveQUq37l4sWYilnPxWps0RTbcH0QErr6WQbAhkkA4BTt1mqyxhVdXO43iqd0RxeZqgNWyYU5MQHnpx38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6QT4B88; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2380253b3a.1;
        Fri, 16 May 2025 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747414151; x=1748018951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbhWXOd+OEyb1Eiiffm06MaKsnNTsDGXVTdFbUo7D60=;
        b=U6QT4B88/NFXLfm8ErSoRl7uD6shazAAEg9yjce8uTYzMjAGwvwITd1/91MIZ+t4KW
         bKNa7yi6q5QIM2J16L6dptSwZTi73magy9AfUemolNsDnrNSaKSNXYgMyQtyk4clsutJ
         Vv3IshUVlfHyiJSyjFf4TJ0+pVeMl3hDVclR5G01FqmmLd1PjXfwMGDchCL3Yg1iWS7Z
         XW+yTGtBEfSBh5o5WrQiszad9lJVbU5vQcyUwPtOO79k8XroxDvTi6E/rCni35oRXxVH
         +iBztZS9xqhZ2Axq9YonyIlXxEzkfY9zjllNuTRyPT9asKcOZqaw8Ug1MB3kfm/JoWI7
         yuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747414151; x=1748018951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbhWXOd+OEyb1Eiiffm06MaKsnNTsDGXVTdFbUo7D60=;
        b=LqMQg6FZHA2yQf1huyvHjVbvFxjuVwwBdAlRWgxFKHu3YVNoTh8GPcNuZOztAnRqHL
         K0NN7edSRwiCCfgI8fI3PczSRIpx0xMC2RyywL14oXN5j7NV7bSc1cA67EInoy0JQYGy
         GfAfTO5801LVcAzahuKKOFvtAGFbPH6gApke/nykcncIt57MQZfGVfqEr/kVrmNdXxS6
         O81YNDrdi91i0fAubDd/qndecpJfxvccFgm2aqL/V9XYO/KhPwc1lYRS9KHCsPc1IRaL
         Afagyk8rPJr5uL+v8EME4BWwhEhMn//cTy+n7clAXD3fNs/KtZMVaoTSSwx0aHfuLZXI
         0pxw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1bjCNlHXq+Ebb2GfAFC9b3fwcYfbkoLMH7nD6hCLUfOu4cr7EhbD8sNNFkk6uPnUt2Ri1uFuSjYv9vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeM8lq920J96RfrbDAFrujvjOaPhD4PWsgY+FviraU1QS4vk3W
	ACjY2kOUB56CZQAPWuczhDf6+kZh/y0d9HSn24Pr2PajY6Q3qPnPpG9s
X-Gm-Gg: ASbGncsayC9ku/FisZWT4vtkddYAUPB3EchPhgZRz9q0+zyvPLfBbYE3tKyVhgBV2P+
	lwa1SrmZyapSfYhx17lNnSI4uwdYbc+QZuVbkAhr1Dr50zCxqVIepwokvWfXRR+49AD/h+kIcZg
	IWxJMTkZquszZU8mJIReuQm3Z18gGAB4ThjPD4mnzeLyBTLjd3is3HCCkiF4XqfldrE0itAuY6S
	XGNG24w9GqWjRolQt6SFt8CrhaCNBji9jSdHfvlAKp9rnS33Njv+2M1hWXPiWMlU/sOGidozV32
	Ol978+15aLXvkwxEIZDm5XTwjSdZYKbOaz7ZUUdUB4XJBUxWWaW7gg==
X-Google-Smtp-Source: AGHT+IHgpBkEA5jao8AFZhjUwipXDHq1C0+zdkgS9xg6GlPvl6Hk6Ct9CuoCbeUY4IivC2KsTff4Kg==
X-Received: by 2002:a05:6a00:21c3:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-742a979672dmr5269786b3a.6.1747414150699;
        Fri, 16 May 2025 09:49:10 -0700 (PDT)
Received: from lolcat.. ([2401:4900:1c42:3d25:8f97:4da2:63c3:46c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ad2sm1807443b3a.93.2025.05.16.09.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:49:10 -0700 (PDT)
From: rodgepritesh@gmail.com
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rodgepritesh@gmail.com
Subject: [PATCH]  [PATCH] Change pidns to pid namespace
Date: Fri, 16 May 2025 22:19:02 +0530
Message-ID: <20250516164902.91085-1-rodgepritesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pritesh Rodge <rodgepritesh@gmail.com>

Changed a comment in memfd_test.c , Unabbreviated pidns to pid namespace
for better understanding .

Signed-off-by: Pritesh Rodge <rodgepritesh@gmail.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 5b993924cc3f..4e4c46246a4e 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1359,7 +1359,7 @@ static int sysctl_nested_child(void *arg)
 
 	printf("%s nested sysctl 0\n", memfd_str);
 	sysctl_assert_write("0");
-	/* A further nested pidns works the same. */
+	/* A further nested pid-namespace works the same. */
 	pid = spawn_thread(CLONE_NEWPID, sysctl_simple_child, NULL);
 	join_thread(pid);
 
-- 
2.43.0


