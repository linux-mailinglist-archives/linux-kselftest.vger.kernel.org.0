Return-Path: <linux-kselftest+bounces-47033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93660CA4882
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0A6304E3AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B333DEE2;
	Thu,  4 Dec 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNR+XevY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22D330329
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865063; cv=none; b=DNbmejUpaLVnudnhJ+QOkztlHPWRxao3Tnwq1OQxy8eq8JyBf/jzq3b4KFO3ZxbPgngonkoLgibh7LRE8f+JS5JNgf+ayT9+YPP1OYNfjSBF4Qfg/eF7VgH5A0o+o8kwUYrg7AmhPM5swxW8iciDBzl57LHth35GyuRgPuWXDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865063; c=relaxed/simple;
	bh=B6G0T8NkYhcNuCD7QyN8/7gTOKXjs8C98fVo3MBQSMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKOBtJAxFoQGo4QXfD1dwTf03FezmuATJ0Ik9bIqva46mbcQzABYsjLApQLe3JlzLl9oq2tbhMQYDa2fiCS6QGJIqjiqOLu2Jd0NKO15vkQnoNTiBbHh9JWgDO3L7acftcAgUilOBqP122BWh4GC9ILjz4jjkt7G5DsyGKkLRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNR+XevY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ade456b6abso940626b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865061; x=1765469861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=PNR+XevYIOjkpozR06nB6Au2pT/VG8FvCBkQfpreOrmDVleWwb+VOlCDcdMHvxepBt
         l+s2jt6eOJNDIVPv9Qbi04by3VaPKgWvtDUYgzBbs1UUff7w1tSxGC0ZJkeJdD3/CLRd
         B/tAGTIrjaHGQ2dI5utAtuqDPgkRiWXjoje84fvQ4W8f1/Jz+/mPiuCAlJAPfR1X0ntU
         N4PDDvtm7yVgEkrrwvGwnRah0liNOjtbeZNGQQ634oTNnF5SIh/mfz6KM+4Dgq5BDamW
         dL6TM0LOqmg7WInWnhyvysc2taAu6gfyMpXJq+K6ZWJyStQMzYyjO+A3IhTEVIdYhWIP
         7LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865061; x=1765469861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=LTqq1VvcCJ6mxQu1CmAS3a/e78PqD4F3TglCQFAjjhd+N8+ukpwymloUpeWAW11h1v
         BRgqxOFtdKV9psPg+HFa/DMA47wqX9KHURcghQz6c2IF8F/Kam7HWXyfKm9up+pdTNfT
         z2OKXcbAk5MF45zBIT9ve6IyYW0asWD15aGRd+st5yaaTEuvhMVMAIlUCPB5VjakJ2ZJ
         YQvCkF9Y1bRd/qtTWx8Zqs+A2g/gbdDBImlcuwYea+PzCyzlDZLm1B8/bKkYRS2FvQ0N
         OWPOUnmor+Tbg/+yXhIHwo1GFbKKay8Txslzk1PB5xSViIRHv2fpvwEVVSGzRyKGb9OA
         x2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyL+dkJq+jZyTh8aanP1WIZZVlU59Zdu/iQmWMenpBAxEEgTkhU3rtV+8iuGBs2/M7EmpM+Hj+m4iE/FnRGo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfd6IorgkkbQoKiitLY4nP6Ci1WDm/SQbWoMdYy2s5G1h61yH
	8QMC0NNQUUqc0W5+QsYXGq0K9/0pwio8/jKoY6ohdXdvRBj7ZsoXrSP9
X-Gm-Gg: ASbGncs0th5jpugtw/h07C+RhZUn7kXq4Np/lqpayzUmt7UsvIOqWyJqsxrWfPIVJxn
	mJ5g7RQxx22zuEeG6rRypcuM2CUa19edeY8AysfYrO6uIccbJVcWGoV0OFRiXn4xnhs0qttEJK8
	kx9NbtVM0cnaSiJNAvhdVo/pVvPHudzqbOAJ2VoCb9LWiZce3WVkC/0dJA6OSezzMAnz2ifxcaT
	b+Rz1OScVbidTSAZkIGJkazsVTLNv1XZ9J0GrzUZeoIp8+oWqrJsZLyJ52CHDUiN/mPp4l1DfkV
	W86r3hAeOdmMOlJH2fZYO2ADq0+XMb6DW7R7m6Vqa1fEGtGBfci70WUgJfS6eITJ/LHm+OdL+Hn
	sJy7lcMqD4kqqSXnN4h/vMsCVb+ExEYKRBIAVFHFXUq/LCH/+8iOwNxLb1ybOqCDZ6mktRuDU5M
	tuu7nNbHmW73hcOD6srQy7MOzw1r5w6OHBGQ==
X-Google-Smtp-Source: AGHT+IHDLLCXyd3NnPostz8f7KrgwicqmyuURH58glMvTXVVktyKcW82yJTvvOqpWuC/DUzj2fEA4A==
X-Received: by 2002:a05:6a21:33a0:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-363f5e27630mr8448573637.34.1764865061486;
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e4ec3c32cbsm1541785b3a.46.2025.12.04.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH 06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
Date: Thu,  4 Dec 2025 08:17:20 -0800
Message-ID: <20251204161729.2448052-7-linux@roeck-us.net>
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

Fix:

gcc: error: unrecognized command-line option ‘-Wflex-array-member-not-at-end’

by making the compiler option dependent on its support.

Fixes: 1838731f1072c ("selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.")
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/af_unix/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 528d14c598bb..04e82a8d21db 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
 
 TEST_GEN_PROGS := \
 	diag_uid \
-- 
2.43.0


