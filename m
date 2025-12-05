Return-Path: <linux-kselftest+bounces-47115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A09CA87EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 197A73004F27
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69703469F1;
	Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5tfFdwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9E3242C2
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954740; cv=none; b=hOXCoew+NopBOFD9dIW7KYBW39s+7qySoaSTkBZK0ls5ANGFNxK5L8Wok3ELaZi0LU5n2YU2qHVFDoSLxIxaVIxoWrMA0l8/FcKrvIe5OzS8mJv90pWuR9IBnEvhguXcoUKOhRLg+i4gntySYM03o4jxm7ylYYKgyUlOw13Vq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954740; c=relaxed/simple;
	bh=PeM3U+qiUJyHEyS4FHxgahZdXga3yLayx7E6kX53b3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InYiVsViPV21cqZRlINVSHI8MX0NCTFIgSn/fk78qJy4JBWNDqPL8etQhoRYte/JT6lVcWtPfguuCDhS9fhTyDjrfMkbQpnmttGUGs6kLcPHzBteAg7SKXorfTuVZXOC/+NNKRVYWB4jB28kTZQ7KmrAn9ImB4A+v+ynWcYST5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5tfFdwR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2727669b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954734; x=1765559534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4zEaQaL7Pv6lx/OIuxHCiaYn+nBOnbMD8B+U7ZMSws=;
        b=i5tfFdwRm59drgmdOJ3B9RXWJ6Pw/QlX2qAuqLzjNhsfLEdszQVDFpSrc64kLViifo
         VMFbclFJ4Hy9lLUfGfTwS/KukdAPDIWJRgWZ+tIlw2ImlPD899PlZzuTqLarWQqs6Mik
         jfGMMQVqPkKOncjy3H7gzLngj77i216yLhQa7/JDnvXxJrvFpUvwgR+7yU64iwAOXJmX
         2mbkulgGb0umKQiaVEEmpErPHVTCpk2YxublgQE1DShQz4MJ3lAXIpph+tvN+i0JVs2K
         81BQaNaZ7v0ls51Ems+5AmLmWqgO3apSOkv3patmVydLiq0VrfFgEEkXP3gYryMYkTBD
         DDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954734; x=1765559534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4zEaQaL7Pv6lx/OIuxHCiaYn+nBOnbMD8B+U7ZMSws=;
        b=tmHLZIb9GpyOZCVBhorgVqX2TXyC5bvYCtdMAKxkPUBFbV7xT94LRdgWP7TyVcSSUM
         Q+efXgOi1IfoeURfMBxTxsXnfFZEZvqXwXe0waXmkeJrUZ6U5iRn050WqXD2jJEFMMSO
         hVr/B2fTmM/kktszSRyfY6DN0pe2SqLVoU6U4esSoIGh8RmPynhpcNqW9LpwVQyrMhNP
         S5oKFLIU4pOLFiLn8rbCRBN3PpwMwUiJpL7Arm/8Ib1STD39QeD52brJ4LutyzC0Vbnc
         8HFHglyovirw45U/1Rqikl0ZvEApGFM0uH4OfcC+/LQ9jbCfk05c5tROI1skp0kXhKKa
         KU5g==
X-Forwarded-Encrypted: i=1; AJvYcCX6Jb991N2pC/r1aAHrGvoTPXnwyvU167OrzjtQy600cTR+pZhn/MoZN+GmR+dLlRy5hOwPAF93SpVCUbRQegw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDq7bRXNjuUA4cfv/EsQJQx24k1CnxolgV/hZFQmfs3zYo5txz
	x31NI7zNZrrKfFuZ7gzQSji4TRG73AO5WRQX30h6Qtn1ZIzkv3+jdZDI
X-Gm-Gg: ASbGncv3lQyXUuotYlUkwLO3N8o639dbY0vfIz2OchMgCAW0TX26Q9UvJd0KDEzhDaX
	FSlCf/0cg0gHR4Hqs5xvcnurEzJKt0qoq1dLhHXf94/KBE84NZ8QrHmA1ouhLId/Y60zN1nyUeC
	kQYV7UdtkGhQV/QLhPUtPvbwe8g3AGxifVSNyS2+MIHsX/3kwCjSrO5U9RLVABjH3O5bwv1YHzk
	jd/vElAvzS59sBJBytMU1MvdSwDfPFLoSspzcxESSFLGZxevW675SXavJh61jipV373ePSfF5sH
	oNAnG2eyKcjD7mgYBEA/LC14BSpo3ph1qZZMwVCDB8WmHARPfadqj9ea+RSapuVU59THxL895lH
	OSfawF6YponWl96Olxf6yZtm/ZJocjnNY1V0wHRmUUIdX8EMkkoX9MgSYGmvCuHfSbKbjTaRlH6
	wKyngeH6RyDj55wDKFbrPdnW8=
X-Google-Smtp-Source: AGHT+IEILnyUDBxkUqKFnFNQ7Nhkhn0QxxXlIHLswHfB2urPR98N+iL6vUBWuopWt/6R6xiEyOLeuA==
X-Received: by 2002:a05:7022:2596:b0:119:e569:f623 with SMTP id a92af1059eb24-11df0c47020mr6816898c88.28.1764954733575;
        Fri, 05 Dec 2025 09:12:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20697818c88.9.2025.12.05.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 03/13] selftests/filesystems: fclog: Fix build warnings and errors
Date: Fri,  5 Dec 2025 09:09:57 -0800
Message-ID: <20251205171010.515236-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

fclog.c:37:21: warning: call to undeclared function 'open'
fclog.c:37:47: error: use of undeclared identifier 'O_RDONLY'; did you mean 'MS_RDONLY'?
fclog.c:37:56: error: use of undeclared identifier 'O_CLOEXEC'

by including fcntl.h.

Fixes: df579e471111b ("selftests/filesystems: add basic fscontext log tests")
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch also fixes
    build warnings.

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
2.45.2


