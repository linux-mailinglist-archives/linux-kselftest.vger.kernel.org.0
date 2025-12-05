Return-Path: <linux-kselftest+bounces-47122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08BCA8A86
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93D33065003
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104033F39C;
	Fri,  5 Dec 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ56iiPV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AC33C52C
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954757; cv=none; b=WkW8noIVS2EaLLGMWYWD3hKRD5TOL4n8QCQqxajuTk9uawCd7hQX7kApwduVAnOowobSF4IKlNUXiAajfq8HrSrJ/dqIrMXZ9VzOy5iCsDfSqxREB8h9Ei2E3za+U/SDvemgkYorD503Nfw+Jc7jv6CDIhaw+EOsV95nQn68+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954757; c=relaxed/simple;
	bh=7b04OUSp5PPbHF012Af7Jd1Z5TcnkOHwaX4bsLzbOSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDqmZdrCyW0itlZmuhs9cFjk/iuMpcFgAGGitrvwIiwAKtpZJ9H9L3IckwhcbO3t69inICTzwRK+Ca29zHCJZFlDucxa/IurXwGB3RmILU6MsiFpWKqJhiKDvYsyxP458/YJ9tUXTr6AYMA2nL6Db/2uUA/eQkl6H7NLyVVkQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ56iiPV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298456bb53aso31678095ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954745; x=1765559545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDia+MA8HLQHzWjV88VwCKaD5C1zT15MPbh82oRmFds=;
        b=RQ56iiPVcENS3HQKjiLkzKx1aYAH3n1Jh6A8PEZ+VjWpPaJqOBps0QEuowfb2p/c/7
         jGLMU7XJrB9o/toV183CCWiNgHPdUXGvS5CEYJJ0dKopLt0ndPC9TB2K5OcjEC07Sl3r
         NaWAtLn/mUnT3wPSl23pzccsZybVtyGNUDAR3lySTz243KjoS5jmN1FEDAMwNB4gN/R8
         Kr1KBlEYYoCIKj6C6U6fxDf5PIHotZqlyF9TSGH2u7+3V03jMK4MwuRjqInTRQt25N3Z
         XMWR9ZSuHyf4ZE4+S4I903x1n/mpAOmN8iHRkLtmJNAgwaB7RlXeQc3PAsmeEcBQdfzc
         r0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954745; x=1765559545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDia+MA8HLQHzWjV88VwCKaD5C1zT15MPbh82oRmFds=;
        b=oBSrQTPiDF901D+AjiUhk8akjfDz85G02gzS3L0507hBIOdA+rRDcqmxuH13jFltV6
         nmZ00SFx29WkEa1Mydwn+cTjmtP48MLrq/tC0mW0znYOWmtvAxF8koo60QM4vck45PsW
         ubq+Ufrdk7MLSx5aqlpkVHEhwwuCBwIsAO4iugHsYIe26bmCtLE2aRS5edN7iq74P0i/
         VeF0QbZTsLbrKI3+ymCW8KDsJoLbb6NoPbIMf+cHQ10L3TcolGgz8VXPmpEOMHhuJ6DX
         hO3zZpsN1fsp+/L2yZah2XlDPvyG2yQcYGjE9kFvmwA3FL1jx+DihDiT1NN3oaPTBMDe
         eJrw==
X-Forwarded-Encrypted: i=1; AJvYcCW0VFQJJ+l50Z/A0NtGIoeWz/qzdrdwWIdonsxBvnGKdRho++P2CxfuxRShkY7d9jBbMf81q/ol6AcwbE2tS7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+rGyi5ClQdSyXs6jCXZ7cZW2NR2HnsMGyOycn0g16iYL6NlG
	+xJd/QyS2cBrVyk/DruRDx6YRX6Dkhvnwt7N+CBQIri8ihdlIcD9F3i1
X-Gm-Gg: ASbGncsoYc40q6l+6L7bjqSwXhnJdVcHj+ksui+Uh8kqktRxhouRDsHLsFkpYW+jKl3
	LRLr1Vi+nth3w0zBdROMLrYRrdUD/ATvkA0U0wvK7EduPXKAT9joE+4Co9JpkJuEJzuWcXNXuJf
	SIGW0y2R3H7w0Ed/5SfAvY7LrKtiaISvMs02hG94rCRVy3m8iWjkR2nTkJJu+YV07SyCAWUdVWn
	RzMev55Ac2vx4ARVYUVfbRDOgkTtR+dPMQ56pbHJhGvR9HdPzEcBKz7dtDM+19Y2SvEIKcgJ4MC
	0KNyMfFSHVawc/eod7u8qyplTRxsTR0Z8Fbd5GYY87KFcTETBTnthJErl24WlWOmz2r4EqzHSlW
	1CtJSAGMpFkip2sNcEA6OgFuq1lW7iOGhFzuTDFF2XmOdRcH5Vwy03ythOtaN2lw5YjL0FrNbiJ
	IVfDyvXtssSZdT0N7Md7FXLtA=
X-Google-Smtp-Source: AGHT+IFpapsnYxxuCMxEK0T30dMrqsmXHdoldVmyDlrGUqkSkZ/3MRNWB7srXi6l4pDtAeoht0dECQ==
X-Received: by 2002:a05:7022:428f:b0:119:e569:f62e with SMTP id a92af1059eb24-11df0c5273fmr9380516c88.39.1764954745007;
        Fri, 05 Dec 2025 09:12:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm22123783c88.10.2025.12.05.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:24 -0800 (PST)
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
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v2 11/13] selftests/fs/mount-notify: Fix build warning
Date: Fri,  5 Dec 2025 09:10:05 -0800
Message-ID: <20251205171010.515236-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:467:17: warning:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking the return value of chdir() and displaying an error message
if an error is reported.

Fixes: e1c24b52adb22 ("selftests: add tests for mount notification")
Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if chdir() returns an error.

 .../selftests/filesystems/mount-notify/mount-notify_test.c     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index e4b7c2b457ee..5c929275e689 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -464,7 +464,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			perror("chdir()");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.45.2


