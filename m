Return-Path: <linux-kselftest+bounces-47039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C5CA471A
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6339308A38E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE983346E6A;
	Thu,  4 Dec 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlHZozYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5E3469E7
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865071; cv=none; b=jeJvg1XnqArHltyaN1L520nZXsF0RLdfgtPyeU2BuihCXQ+FomTWoneO8joaXp0lcxyDy7Zu4b7Jos8TRAK64VlpyI/qSDLzTeNa9C+TDasykCbYzfnIg47SIcWImyl38Go3wjvUQcDIUbY9ZdkVbeHW0DoeWLKJyNOd2PyCaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865071; c=relaxed/simple;
	bh=Hqm19qhEtyyB+awO2JFc4zCVn6kCUyIwQGxa8Cui5Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0cufafYykDYA3uzMJIT1EMNW4CT5jv5Xhi/0tKQewuXS5BF/s0EoGJSjx+5GMW22KGaVWuz8aWSHmaq7N5guDH0ZiYBEGptKyDpQ9yxvu9S1sOmQzfJwENVaq+pSIkrvnyZ+6syQVyfVwH8+ctIkC0W1tJSuROyuVtIKGCZp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlHZozYa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1927914b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865070; x=1765469870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=IlHZozYaQzIXfAT4fe4NAmbMeMxptjewtfv9zT5w5petHD1ZrLYnCDMoqGtYgThCK5
         sx1nBvUEemy6Z6XPw4RZXUiX0lhbIfxb0uQlivuW8AVNmTBNBx4odDMhc98ejrFbDvPp
         eyKqney08aEEVr7CuXV/mjgP9VDrGWw0+XucjH4v5tkraHIMnQRlX2Rc66rTDXxZhNOw
         tyJWk+7A4buA8RuKjVkzYL277tWJIqn3qbx+U03764hhj9bX5WSB+OQASrYR6CBbaXnB
         2Irl/EfviE+ACia9RqQKLVbjsIjehzOWT5hgI7b3DEa+8LzW/dpAG/P5OYGdPWKLYxDD
         Ziig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865070; x=1765469870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=hdFoqUqxMmgsfe27/jW6o0UjFKSKyDaiF9HXSEeNys1hNNnwpkSuCjM9Gdaa05OFtu
         t4DV+Y/REa8jQnwA9mo5z3i+8dyethGcJCWwm0ljUFVSFbgr5YsHNQKV8ivduLrCvjUV
         H/rm/y0jUZStZVYVTNQBRV1BmuSM/cD6ZASVaZUQe+qyro0+kVFI09FSKa2L21EH0WT8
         yWSOkzcZSbLF9MGR8wbkc6buscZOC1cSmniHwX1dLc5PlVBxGCOXS7fRXUku34cqFF2/
         iOWYFehA/xNzetajr6ZQ0K3VdjBHU6WVncjwstkoPeGOecFELwgeX6cOeala6C6PfAq+
         3YSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM8eJdCezMFWouSac5UTgarOiMleiiAoGtAEQhcB7+MsWSTwYqumQcTNM0q4pNFMmtPBN4bNK/qOUr6JD/69A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4+UnPALbrVZDzaGjxNeiKQ33hYI9qsqdMBT2cAulkk5E5rwa
	sk4gCWSgqGETNZR9kKOwKIeqkbifIPKa2iQqMU8X6ufslrvpTu2MxgM4
X-Gm-Gg: ASbGncs3tG7K3JKi54ETszzPyf2P8JljfWKWajuph4aMx09VuSYkpDTgrOqS34YGsrZ
	j/FUFyTZ9d0RJI+LYW3FN+pnGNYzpEP4urOEypZQIMQrYGoZR1+0pPk1o4Mv16AkSo5I/vSJv/F
	BEngUtfCGLJLs0rvkGVHsK7kArgLkhIEc2/TGtI4rgvBkOIvcs2Ry8CsldG7tLxHJKvWJ06YMaq
	4FQJ2/1NVcdDjilHj4wBbneVNo7hF2czY0q/N9k0XYPeZQ+OG7yvFxYkXjui1xwtmLHRhOyB2Io
	IpwTtQXLBr6IUDxIvcC/TKtUezqpb7al+ilxW7owMHP2df6gjJ42CAlLEY27WW+j2myFFgHWU2C
	JhseeIIqaZFezc8ycfZ8bllZf3feNvUFJTotpOFzqnnALYs/NTnFObTT+u0gh3aDSeYuZ2weTFz
	OCcLGej8PgjmrOT9sa7YuFdWwpwC8uxTncvA==
X-Google-Smtp-Source: AGHT+IFWkduyk9szNluelpZfGaJjNW90s6UE/NY8hC2k8APw+laM8wvICtCdvTbCpRk3ULmedtT53Q==
X-Received: by 2002:a05:6a20:939f:b0:35e:1a80:464 with SMTP id adf61e73a8af0-363f5e9dd6bmr8075142637.46.1764865069640;
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681550446sm2310053a12.2.2025.12.04.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 12/13] selftests/fs/mount-notify-ns: Fix build failures seen with -Werror
Date: Thu,  4 Dec 2025 08:17:26 -0800
Message-ID: <20251204161729.2448052-13-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..949c76797f92 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			;
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


