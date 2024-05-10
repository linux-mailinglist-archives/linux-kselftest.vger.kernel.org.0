Return-Path: <linux-kselftest+bounces-9993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77A8C2005
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE45A1C21327
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099871607A0;
	Fri, 10 May 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7KdH4hj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198215FD03;
	Fri, 10 May 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330896; cv=none; b=mQe+V81HqvkNyV6zn5xr5CQceW7jxEIZUjFiqWW7H2Blik1ZK1k4v0LRtr4mB6l3n93mobD18AhyBU8x5w+ViD//9IJjYj8m/mEkAiPV1P5U05WbBViq5Vu52L2cmWrIcER5qO7wwvX1V9S/0JsSXv0Mu0g1Mhdwc66NFqi+dDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330896; c=relaxed/simple;
	bh=YwWoSGlLIoFU199bT7cNXYZ8yB+nQBY+wMA4w6hUZu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pr6F3lssa2/yDQ2QQ2e/wUQ882mY5jTiXCRxj8cvyWWontV3I960WUJC5LPIzCqeeu2rC7JK0YsPO0lvEOn1mbBSfePaP+lPnBLYYuVf+7ukM9UzsigAcKyJuGbbL/f9dMf+4DKvakIsoccTKSCfEQJq8lTsvvUM1yqJPrc++Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7KdH4hj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso2721745e9.3;
        Fri, 10 May 2024 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715330894; x=1715935694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VolhuYhozBmZNG1Kf46/MgpdEY1r+F/GHz7XyCKXqc0=;
        b=R7KdH4hjS+jcwpHN4dGOujfKNjKDz/aJ8RkmawaWX24ft+nJ6pnPe2wkvISdrrk4my
         p1ROj6RCED5eL9mzJlxIZ3Qci06Tdh2Lkx/qkU2HtrBfgMk/z5KQJZ1vKLm2gm2y32WU
         u57J4qjvYk9KIsaGVlOGwPvVw336iBauXtndxZ50NY8xz3e+zhEDAFoDTk39kk5nO1y6
         PoLwfPZLnne6L5nAhk1tiC2VhOt126PvO8+HSfQzCQ3tZKGFppdvCBS5fHSFkJcKq1lP
         yzd2KxguARyogtx8EpIVKhSo9YpnU9/2N3G3CTnGM+bheC2NEAb5lW5Kw9RNJYzVnlMZ
         v/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330894; x=1715935694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VolhuYhozBmZNG1Kf46/MgpdEY1r+F/GHz7XyCKXqc0=;
        b=bBd4Gy8Rieoeg2cPbhaNHTpqMFIZfh6pdncVFLdGVFVrobQrfFuZE0lK+sDqCEjID+
         CpVW7B0UEKWOLThIjr+a2//FyUEio0ZUaqJq0sIpeMYm+YwqDf02FG0SznYShgfYN8hQ
         MVN6A1RC9SH5VNMX+56hNfeyo5SZQNTI/9weM0xmkTahue02oyywRJp3G4APcHAZDicv
         8b6ZTgBlAglQjbPoD1Zqe7iOdYsA6oYslLDRJRmuEm3IqFyzaFky3w9JMNc/QepKIa/H
         TxPVuSFKDx0JE2hGO4VUFyhrMiGTh4SD7/UJorA5cQjfRhhaXyn0OoXR+SJcJcev8Ahy
         r7lg==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ5lcx9bBkZ9fwRHEF7dC/U83RwS4NwWdT1hHQxeGQWXQRIsOgW2GgLGL3AYVoGaqAOl8yT5uMH+zV1F0OZF6egl/WFS8L72wPbas7RTPxJf+aeBH7BoZklcFtNy9S/GCVhp5GrkGhlwNJr5gufLHWJsSr5r3SB0LleURk4GsN7xGfbe/
X-Gm-Message-State: AOJu0YwFS8YOFvHZDxKnL82tWfPIcJp6N7pWtlkWsJwITGNyAmbW0sM8
	9ElQquin+EMowzRMYPtxOgBXqY16mmnU0iNnxO6iDSbfI0xDNYzY
X-Google-Smtp-Source: AGHT+IFylAv7LOFuzY145nB/4IYG4/bbhSBLCA1Eg1Scf4HzbayFRvNarWugAMyAu0IKfah1845XwQ==
X-Received: by 2002:a05:600c:3508:b0:41b:f116:8868 with SMTP id 5b1f17b1804b1-41feaa38a79mr21592845e9.12.1715330893439;
        Fri, 10 May 2024 01:48:13 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8e3csm55952055e9.1.2024.05.10.01.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:48:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: epoll_busy_poll: Fix spelling mistake "couldnt" -> "couldn't"
Date: Fri, 10 May 2024 09:48:11 +0100
Message-Id: <20240510084811.3299685-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a TH_LOG message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/net/epoll_busy_poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
index 9dd2830fd67c..16e457c2f877 100644
--- a/tools/testing/selftests/net/epoll_busy_poll.c
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -232,7 +232,7 @@ TEST_F(epoll_busy_poll, test_set_invalid)
 
 	ret = cap_set_flag(self->caps, CAP_EFFECTIVE, 1, net_admin, CAP_CLEAR);
 	EXPECT_EQ(0, ret)
-		TH_LOG("couldnt clear CAP_NET_ADMIN");
+		TH_LOG("couldn't clear CAP_NET_ADMIN");
 
 	ret = cap_set_proc(self->caps);
 	EXPECT_EQ(0, ret)
-- 
2.39.2


