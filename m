Return-Path: <linux-kselftest+bounces-47036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F169CA4828
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A2331302B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E434572B;
	Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG4jP9V+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93C342C8E
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865068; cv=none; b=KNfkxly1spOkBbNTrrf6Mhvp2+aSqSFGxhc5QDhsUHN1HfyA5BLAK03hpncGjbv/j3u8DLr15LvQKh607+UTvJinW/YmswqzoKVNobVabpqshz2RNwbmGrU/Y9cxEi3jiH1zpSGkd6kODr3km9XWgs1pxB8OCnefwoOQxrwYoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865068; c=relaxed/simple;
	bh=rC6PkpD7emEtrML1l1CqlyTuhgy05GVPUoqahSfW7eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyW374PeU51aipJQGUvEG/ERDtLfKNEUSVA3TWkLRXCFS+a05Q8opPdlEIn4ZtiBisbl/NWeusvJedFGjYZMEKAYzxtcvgtEoqlrEwsxvC6Eu31Gb+Jo4IIihCQkn3vJ4GkY0eQccT0hbrd9XvvmK8gQeK14uw9crmdCvPtD5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG4jP9V+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1037012b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865066; x=1765469866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkgkxOw4wH/gm8uUTlYYEApf3+4O7rh6ARTRXeD1ZL4=;
        b=eG4jP9V+/8Dl39uuJbvFft2WpoPwRW+aaDCtASqLaZzPQrZTR/IB7I6lvLdqMIHZ6O
         OoPYVLyf+KOJzSARA06C51luvwl0/Uj/t56rfCWXlY8DyKSCLETEY8nwHGGOhsylbbes
         RhbkNczl/H5e/Cu1qyuF0foIY0iFKa8WaqWzAp6eTDlA5FCuOYqiIfnGgSNvzY/2NW/H
         mniMAEwroVoIF/5++AHcVne2iH8uGFLVF4q+ir86PadLxv1IB5gxphfUbnojh1J6bZ5x
         4ylaM5lKF3Eap3E6YnzY4JAqcpWJgY9Frt8BZlAOQUbbJd7iW+W02y1nIzpgyvOGTfqn
         FHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865066; x=1765469866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkgkxOw4wH/gm8uUTlYYEApf3+4O7rh6ARTRXeD1ZL4=;
        b=puoKC6PVcxwxo2uMaKTBB9tOc1/b8iQ6UVMNrAgR4IW/QEpfe3ETHZhx7ekR/nMmMP
         U7LR/KcsYiH76Mla1FwYLnJWlKNalGQbntUkRtDqddB6JdWQ1gS2FL9dcCh86uJMdwqw
         ntMYLA0wyFcKL1CilZxyk+FX5Bs4RNoTnu3juYTiZHddxblhWbC+4lUaHDiWq+qmscMY
         dpwnD7QPRio3d12dG10xT72KOl+RCHj095sTxMfryFoIuW4AJ65ZdWBTfHn7wTMhEdUC
         ZgTm8WSMWzWiQEadIUzYyj5bMEZSH1tkwjYlFnkXYvA4yuOEAdrZHTNlw0X7qj4RDeyO
         SVhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqb3R/siKvPdiXcY6JwxI03IIoOmrY3BcmAj1Uo6+9J3EhQnvPV21yVBIxzNe3WgBaLsvOqfTTQ4UI0K3tU6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21B9hjW9iATVOE8mqAXyrAiNJ5q9dxSx8jlTIUU9mCOrDSKwp
	27/Ul/xqWKiqufThu3ALyDXJr2BGajqJM2P63YF7x9oP8R1ZOZ9Uug+I
X-Gm-Gg: ASbGncsJoMUi6fTYDzYfQx4xoAp1AzoALVckC6E47VAnCWy/7NNzrfLBu5limhECLmq
	BBifKvnHwxO5gSG4kQgwY84W5awG9VM8lUsL5EM35IcMrhAM/YXSP3P0vRdUWab9LEMHHrytK/5
	YU3tmslTU4IW+jthQWoucNZCRrR1zT9YRlc51Hqr1zSICukTTZdDupw+4gAxSG4LP9GEi30ynnG
	B98gBDMaXTZQb/ELztAhJK3iD6V4NXeEcq4E3O4RfiGBu7TFn6UN3ht5Q1Yz7F32sO0D0iNx+OC
	sqaEu1OnKDDh41kOumO3IPbOx/P8jGLzVhORzigYq/cFsZY0mLPaeeEGRy1OotyDuHnzrNC/HFq
	4UuMvm+ILU97albf6uwJDclVpN3uhyFK3VFhOebV0aqJteeyBwUR3WNBqQ5U/r9d2qQNBhSdN6n
	Yv0/sGHWw/6ZfJjOq34pAWo7A=
X-Google-Smtp-Source: AGHT+IF/9euea5Rw23ICGAMIBIpDo3F2tehs2oMFO8F/8uA1LeEDf2vswoBxd4onc0Luva/rqs2D6Q==
X-Received: by 2002:a05:6a00:14c2:b0:7b9:9232:2124 with SMTP id d2e1a72fcca58-7e00ad73ca3mr8702158b3a.14.1764865065736;
        Thu, 04 Dec 2025 08:17:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae6fcc87sm2635111b3a.49.2025.12.04.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:45 -0800 (PST)
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
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/13] selftests/seccomp: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:23 -0800
Message-ID: <20251204161729.2448052-10-linux@roeck-us.net>
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

seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional expression

by type casting the argument to get_uprobe_offset().

Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..2584f4f5c062 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+				   (void *)probed_uretprobe : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.43.0


