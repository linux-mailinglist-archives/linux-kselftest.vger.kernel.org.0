Return-Path: <linux-kselftest+bounces-33103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16210AB8E0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47435006FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2415A864;
	Thu, 15 May 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z30EYSIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532321361;
	Thu, 15 May 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331142; cv=none; b=RO+c8n3pCysGChR9rF9fgB66YYrWLaSxqvcyurAIHXMHUFrmsi/9sY8R+VZvTAhU/jOabCFGDQQXKaY3afBHCKqhzPQhUtCeFy5vXuBisY/jg9lzQphmd5kxYx7wSpqvoYmauC+Evcd2QeZhHeY0yy7lAPBhD7MUjJ0sFgiBsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331142; c=relaxed/simple;
	bh=HhbqwaC3teDedFQQuJpirihhOgs7jr9RcPgvJ2ZCeZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ne4Sm9wFh+U5GIlFV8Evaxx+Xp6ZVAd6lJsuclOJz0eXGlgc41YJS4nX6gaKtOdV3LkJRWgttOjNcxjlfMgBdkGrEbJJpdOOMGMMDrqaSyzRxHZbklasVSX78O4XK0hZeZ+YHco6KSogjI7zIoNqPNFGzc4cBH+uxAB6MjIAAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z30EYSIr; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1292239241.1;
        Thu, 15 May 2025 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331140; x=1747935940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbywFPq6VA0MtNjEUtTE+V+BYc4S6rw7cxYxlTrw/nk=;
        b=Z30EYSIrJTPahm5FaCsEngHrEXtjlukVSGia9oE/FuDSXYADwxRKP1MiJ1Knznz5OR
         vmLLE6vEojhmfB5hM4PhR0lBprMuEStVyXDGf73EBTQJBdRbuzMCgxxb3ikO3SkZBwhs
         ZYrdoNfd5KohptoY2aIeQQ13BvIUGP39Lh2hRqeenoz2diXK9ZNvDCpIb2hVR1MXOTUm
         5/siRB61lGoA1gDx56QtZfrDQRoIWQ4ODYqM3A5wAAxyJEI4ecz46leA2uuYufJ875ZN
         pDSnb4tNs52W3xyc1L/lAsC5hduVCF350sWaslWsGC37YYU7laVT5+QNcALkcv43eMt7
         k+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331140; x=1747935940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbywFPq6VA0MtNjEUtTE+V+BYc4S6rw7cxYxlTrw/nk=;
        b=UpgZBpQ4FQiXCxCMour+L7+DIvkfebNHoJN1ekNWZ6kCQFHnMgD5TjnP8VTMHfD9WY
         BFij8OJVJGpIKlfHs95tcauP9PCkTNq8Py64jCKAkv0JvNYrGVnYI2s53FiEtOmgignI
         9R0BMdv234+scaLHBiYLiuE9ka5PJNSwHH6v1lZO+eQXwr3u6fBOBHCehb1MZJwlD6j1
         iwXQPMXlxwKGNRtwFc+eTfWGJQu7oiB2+pOLSN8JMfHmu6IVhek7JFf9zhHLgANwGUQy
         kxeIeNjHcXyoZX6sNmQ3EfUxVkpvlhxYc7rJz56+TPZKoLHB1JzY4ODXcdjwrykZEvtd
         zw4g==
X-Forwarded-Encrypted: i=1; AJvYcCV7bbr2nlM1Y6JRyB91Wns7xwywfLTaC/ClZQnvqoQuPRbNN+lVX3Ilfu6GRznUIU4I3i83AzFiNqOBWoeYT78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyoTf5WLpqJa8s20m8bQNIkhqXDrVc0eJC4XFuvSr2qsxGg1f5
	Ha+mPnmi9JCHFzAI2irqSZh78N2FYtzX79HsaAKdxReEUzYOYP3Q86iQ
X-Gm-Gg: ASbGncttxO29ggnTwdrWF2/PsLO4Qj58QzWASI85EbF0CCXLKdQnHEeaP3bS9viA2MT
	WQW+ktPAopP0quXJCJ9jTJy9lMyURe4yoRY+cBDM8lPqvlmzgaMMen6saY/z4jDH0jWFAJpRQqo
	moI383W5PqtuGePVgdM/clu0ZPyDOjS7XG+FG2vFz0y6O8muKYml6sICizLhewvcl8VD//EPAGc
	+FBSeoLraiCPqLj8W98R5k5kjlCGuM4gZTdbC7pGgSWddRX0hgOm9NcLRuXPeiY6SyZJHXP6O9B
	viQdTiGWRCbKcXet0llh7UV1/hfPb67YhWlvYyPM/w29YAIMQYy2RUKQcI3SXTBiG9/ckXVX+ob
	SZka3RcuMZpyP6lJ28EkmCRc6sNt9
X-Google-Smtp-Source: AGHT+IEzslr0e/IE6v7sXTvl6wNgqYOQppP4VhPPsSMOzPFfGpqEd+NZpUe2v48uPrUzmAlLPTYaTg==
X-Received: by 2002:a05:6122:31a1:b0:526:23d2:6ecd with SMTP id 71dfb90a1353d-52dbb602cbamr376633e0c.6.1747331140012;
        Thu, 15 May 2025 10:45:40 -0700 (PDT)
Received: from Ubuntu.. (syn-097-097-020-058.res.spectrum.com. [97.97.20.58])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba910ba8sm278707e0c.7.2025.05.15.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:45:39 -0700 (PDT)
From: Jonathan Velez <jonvelez12345@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jonathan Velez <jonvelez12345@gmail.com>
Subject: [PATCH] selftests/futex: Fix usage() message to clarify timeout value unit
Date: Thu, 15 May 2025 17:45:23 +0000
Message-ID: <20250515174523.349331-1-jonvelez12345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

futex_wait_timeout: Fix usage() message to clarify timeout value unit

Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_wait_timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..737475df9242 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -31,7 +31,7 @@ void usage(char *prog)
 	printf("Usage: %s\n", prog);
 	printf("  -c	Use color\n");
 	printf("  -h	Display this help message\n");
-	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
+	printf("  -t N	Set timeout duration in nanoseconds (default: 100,000 ns = 100 us)\n");
 	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
 }
-- 
2.43.0


