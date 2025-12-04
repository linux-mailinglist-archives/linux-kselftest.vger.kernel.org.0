Return-Path: <linux-kselftest+bounces-47030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2BCA4843
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866E83153E69
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE096313551;
	Thu,  4 Dec 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4h3z6VE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CE30F553
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865059; cv=none; b=JU+QWt0LbptirW7zNXN35mKrQ0KsEWvsiiPgMVyhpe/4zf4a9nKCR8mU1vSYXo0vJi0nM+8BG7JEWnVdTHh0/QPGQ0H632V8WrFEDpdqQmpb6YdrIjVJmt587FPo6CJ5gRT5VoyKdIOZQYwKOlELwNh1q3A0fcmM0c51WNmF5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865059; c=relaxed/simple;
	bh=cHyNnZ8pozRIM6qgLhLXjRDWgdbwcNGV7Hft7Uz1QEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xlzhjp5350q0f53eN32MuwEwM9LAXamZn/YCaL00zmetFQrrayuqhrkGZZTyDEZl4boLcIYkrk7NghzT/jVFbs52dTK8DoXsuPvI3/L0zqPSqF4Z1kJ8z5GQeai6i8SqNtruSSVUxN0JR4ab6x4vmj1u5TOROq7f+mg/HZJjWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4h3z6VE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29568d93e87so11798085ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865058; x=1765469858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCNiBdsJRsPUkxld6fkb0mcknawF6lug5Wbao5E0n/E=;
        b=i4h3z6VEd5ahU0ffmehm8MLpVUQu0erDYZo5houI3W2rZG7x1LU4Twa5YgmEPtg0Kp
         FCeLWpL2f7aS2UNWjmdBkNTihxUljqudvbnEFxfNuv/bkAnIFsqnk6O76n31Uk7hCNCL
         UiZj5c8KSkn49qcRh8khR9CQP9HRWT+c49k272E3Dw81fvt5k7rQL6HkNEw14a80GjpK
         brAjfsEE+/Yl+Su0sAROXqkAE4YcYgYcImrv9IZLq0eE9Y+mEZgXSurEcmrpnD+k2rka
         nTnwsr6GuKsHEwJOE1bvzXOFnwkX8wWmQwLNF4FxdLh/3HDtnqTjrZzMyg49DIrTJGy/
         mypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865058; x=1765469858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCNiBdsJRsPUkxld6fkb0mcknawF6lug5Wbao5E0n/E=;
        b=FrFxYp3C2Q+9W1ChdkEh7+RjdHwCC28dS1sFLxZsDWmWmX1DdxmFRQtbgr3jZd1CJn
         q61UKZIIKZizFw45/OUSzhuC7i54HTL9okMxZV44UFaTWgXtrN7KJDPd1J6JS1fWpkw+
         YLb2VM729iNIDJLcVJxh4oHrwk37SjZFwIAF+YJX8L/b8GDXpzY8v926ALALvxIMt606
         9k+bmPBK7TTIk3a6GdaflDJucyGFfmul1fMnHFpr+nNaysYSlhwU5mVegD8q7Dl29tZM
         a/mGzwZrY/j1ZuMA8uCWQxoQN7Kj2HLh1sAPydctHPTAqBLy0IYCHIJH2OsSIblmOPm8
         XJBA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7WX3o5ibnFct4re08iUHPmBDzEGrELp4Dl5Tm1Zv51rqOZULORxOHz0fdtFyFmfIBLGj+dDLPjKUQGvC6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02/I7Xqsc6732Y6dovTHYusXJLKnWAyQXXMly3YwoWW2/Anyj
	tWs3PCtLy9fHCg4oWoPvkoouJV1tXI4kfh5HJ/df0wTCqDf1TuZmW8VA
X-Gm-Gg: ASbGncvQRr0cho/UgpcT4FqYGNQOOCyOOSyqjL0Rh3zAxDFtqwwsTfeWX/HtzRI6P7d
	ZXM/FX4j2koCRTqH0BmUBOR8BX7dUv7f5bJJRLD7CkNZBTSf1zL60MUPeQd/mSTFd2LzhRgUQcy
	3ETUeEOf5Mj1JNDMkfTQ0GnTAkbYdmOI1wUXY4sb1apgaz2Or56tkeGvSaqA5uYd3L8OsQhfU3I
	P+XEzrD5gM3I5A+DHGe62KhmByz5uacG9BhEChVKo2agFT/IgwL8r5jiJcxZ+te4EybPE6RmE38
	NJHmwklXt4RjtXFXaWY1W8ZYyT9pZE4VhgBDKHmpP2MfadChwDBborNzX6MaLha/akI4y/mJ0xh
	wSaycX9st+IBTn1f21GhFYBvPXIaiB5U+p5g6I2ipQ/zeRuI7f2mLB0ElA5llbaErv+1OXtmcpB
	+KSYx57vsM2MUK8h6YWp3rzrc=
X-Google-Smtp-Source: AGHT+IF/JV1VOB9h/rEMuCA0EjCehTUVdpJ/24AVQVMYynuhx2I5E1sWEb56yqefP+YuFLCzMcT4rA==
X-Received: by 2002:a17:902:f543:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-29da1eeb31amr41046105ad.53.1764865057641;
        Thu, 04 Dec 2025 08:17:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf8asm23548875ad.85.2025.12.04.08.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:37 -0800 (PST)
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
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 03/13] selftests/filesystems: fclog: Fix build errors seen with -Werror
Date: Thu,  4 Dec 2025 08:17:17 -0800
Message-ID: <20251204161729.2448052-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

fclog.c:37:21: error: call to undeclared function 'open'
fclog.c:37:47: error: use of undeclared identifier 'O_RDONLY'; did you mean 'MS_RDONLY'?
fclog.c:37:56: error: use of undeclared identifier 'O_CLOEXEC'

by adding the missing include file.

Fixes: df579e471111b ("selftests/filesystems: add basic fscontext log tests")
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/filesystems/fclog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 912a8b755c3b..d7cc3aaa8672 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -6,6 +6,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.43.0


