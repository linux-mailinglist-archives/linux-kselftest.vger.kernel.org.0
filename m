Return-Path: <linux-kselftest+bounces-27728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3CA478C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B586167416
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B120C49C;
	Thu, 27 Feb 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQOJVIe3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72493610D;
	Thu, 27 Feb 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647772; cv=none; b=FUjODXw1KwpatDBKK15G5UAmTZtCq65KHb5tnRR612jDodr0mHZH6ND5nfeX2iXUGpIUpxsUJJDpGjJQsvvv/XOd6ghjVsyt1jQSkz4VNzumUiatl+0v81OLPxNyBYj4ISZMJN2u1hBkshIAN5apiq+ok2OzKKDHJN1pS+W5ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647772; c=relaxed/simple;
	bh=yOsfABMZ0sE1ZHQj1FgKQRJ1VKmnNc9RYKwfEyQsWZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UpRVEWRBBCuTA+Gv8JwwS5my/YeUQzlJwo8LRWNUlJrqneMSbScRwDVzZeHRu7cvYWaAI+q7n3n7L7+ji+B87iIXrTsP7zzZFyw94JR6xgL+/ohdPT+3td5tKcBp8hC6SpU9uM5CesJHYjw9A9riI2+hNFkFfWCGmPsC2LL0/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQOJVIe3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so227067f8f.2;
        Thu, 27 Feb 2025 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740647769; x=1741252569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFYMYntfI5RNwyhQrJtu6qewVIVsOL5AS7y8ehMaJFM=;
        b=OQOJVIe3f4KrDcYbdJiGDh4mgWXilGopQ+BiJrJ2/EE81ULQI9QmjaLiOA30TxPCm6
         pUJy0KaCLRN8yX/jAC/7LB/J6iQESoF9Yuqowucpw8udMnUYjtuOCuZ1rkZrMfDHeHav
         JEIr/PIGNz/GjDkOjpvDguSB3g3x0/70QEaShK4CyzJTJWcYgBf+pOB0vWTIdQ9H+eqX
         HEt5xI9sYrZuED8NK1Uxyw4VwgVvi9wJk6vD5Qd3Ble16WwA8Ckw+OQTyJnawRPHIvZV
         uMUEgHxkLswRmBuEQ24zzJAMCynPyfNvyxbiVKa8CmsK3ohgOP0Vc3XxwdAI68JCDKcg
         hOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740647769; x=1741252569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFYMYntfI5RNwyhQrJtu6qewVIVsOL5AS7y8ehMaJFM=;
        b=e8dutXgh8ZyvXV8s/vT6rYvgQOzO6eAQQ6c/BpzEwpXKa5SjLyUYcEK2iksooV3wQ/
         TYLPC8laksmPrCFecyEcUx+HWwaukbHDxViODeVQM0/lEk0THGS6eiMVz5WGVqZ+hIrI
         Ja1TYQpoOhnUGx7EuEPGDHNLodjH5CbMYUkFqcleLOEgjr9bbY2QGa3CxlHiDQ+zEzyw
         lTqxw6lrj+WJrF6Qw3GAkzOfIVc3oo8UKpHXY+gJUplH/8B3uIEu/ugMuT6OeTBJYS4G
         WbOqZ1FZPYj6c3jwASP/bNYoubtSDa8MFJ7k3lbYKHnxEyD498oNvFSJksEi54c6CFoN
         00lg==
X-Forwarded-Encrypted: i=1; AJvYcCWHF0KJasmuWv88M5uT2UsOInhE4/NLFTfOJeEUPGmva6IGZg8PuVAkJRhPMeNjIdzS+sTVrL1/kxcfDuyW74bn@vger.kernel.org, AJvYcCWiwASnSZUoqF2MjjXIN4mEqCfYFnvrCcKpblS5/nUp4wM3BniivXY6b1ThjOgoBMO6IxOCCqEBYUNdA+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEZ5IjhE4QHixBpg5FtwnRIoeCxmpZnDULRSwNKFosfTk75Iy
	CkGbuZuHXRaJ2n59PYmJWbU6UCxo0QTnbjv1CaLiBcQa1OAYmT0e
X-Gm-Gg: ASbGncvhel/1JjCGj6AMDjlmlYDdtDMOb5tUQVjrFg0vq98NBo7GtHwtELO5fuB1ok9
	Zx+NJ/CnNRhecKheod+VQho2qq6Nr4R8wN9/e9n9EBgqxmbLr44pVehUHUJp+gh7g7NzxO1GPIa
	oKsn3BcziWAjRfCzILaTfuxlCcCffLApjLjWGubsGan4GLcPY4Rrx/MkvgtWM+fR+VWjjyb+dPg
	2YqwRLJFeLejcuzQmno6QS2p72Bl85NXkN5qb4IPxEKF+X9NzGWK/HG28N8BMRxjpIZdqMAmUJc
	/OXrSlwWzHZoT+9ingfxA2JpfhI=
X-Google-Smtp-Source: AGHT+IFAPTikd8GhfINysJU7hs90/Y2JHzQmgBsIhed/Xp8RlqinQ5hbzAaTGOM0p/I+9bU3S4ieTg==
X-Received: by 2002:a05:6000:1541:b0:38d:d767:364 with SMTP id ffacd0b85a97d-38f70789915mr18817554f8f.13.1740647768502;
        Thu, 27 Feb 2025 01:16:08 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e4844c0dsm1355881f8f.80.2025.02.27.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:16:08 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/x86/xstate: Fix spelling mistake "hader" -> "header"
Date: Thu, 27 Feb 2025 09:15:33 +0000
Message-ID: <20250227091533.599213-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a sig_print message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/x86/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 875777911d82..23c1d6c964ea 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -391,7 +391,7 @@ static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
 	if (get_xstatebv(xbuf) & xstate.mask)
 		sig_print("[OK]\t'xfeatures' in XSAVE header is valid\n");
 	else
-		sig_print("[FAIL]\t'xfeatures' in XSAVE hader is not valid\n");
+		sig_print("[FAIL]\t'xfeatures' in XSAVE header is not valid\n");
 
 	if (validate_xstate_same(stashed_xbuf, xbuf))
 		sig_print("[OK]\txstate delivery was successful\n");
-- 
2.47.2


