Return-Path: <linux-kselftest+bounces-17478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA2970F01
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9D9281BB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAFD1AED5C;
	Mon,  9 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/gpKWEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA61AE845;
	Mon,  9 Sep 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865708; cv=none; b=V9gZ+tT52VbneNmwDKVr+AyShcR9NhyrO2SXg5xUdCTaXIIozfjU/iYsg32tM7gvKJrxehnjGYdeu+So15fcHhRvMeXWCwvo708Wx8TsU8jbgXQhKbM8qKaKAmFwTmC8G38dU3tMo85aH70wOG+/WESsE8GgfhbPygfbsOJHtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865708; c=relaxed/simple;
	bh=puSvXGRn9f+RyH2i76LYyDVzzhSDb22SzRMEwHOezLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW5ZnO1lsdbPI3lyb6IsefcGFy5EQrQqYlccU4piBe3ggHOLM8jmkzpyzYoS16X2L8tZZbYbYyxb96dEU7fxoTox9yrJzSuUYUSygWFmKiDKO3GeuCjBtlsIqFzAnqtyUMu0yPXOc0JtCpuxdsZEbtspRC6/KVfl1fjPOHWzh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/gpKWEs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3770320574aso2386972f8f.2;
        Mon, 09 Sep 2024 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865705; x=1726470505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT07a8fYg2mX8zdZb0NUXYrNfwc3Lxt6djOa1kz4aGg=;
        b=l/gpKWEsH2fz7Cov9TcZt+lgC8Fy+uq3uWhvA/nCxWZmI+D/3MND66bEoaxxmwgivI
         f/E3bVRHkNRGo/25kJcFrMnARlDdOK9hgKUzBqYUY2KjlVXPTFPMARZ4XqIGRLHfPCu2
         l4+WhhpED7S54lDuu9vNI7wzi1R/Wwr+I3wGv1oNEIBYDLXTBOm1LarQytideVKdXTar
         TpyFfxp4cl9k/iA5AScv4m8sM2rWzRXUkmd6KBDVLxfR4lOf59BD9QzzhlSHrfrAjHs/
         r0HL0I6aCpb+LlyPwVl3uuA7jhEx7cHpsD0iYbfeWfZn35JWAUkJukuGu6laM9cjnEaJ
         WEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865705; x=1726470505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT07a8fYg2mX8zdZb0NUXYrNfwc3Lxt6djOa1kz4aGg=;
        b=i+0rrY4EqIrAq+0cBDCG3UUoTuE2S8fDuNHWoKiOIZf8q20wi+OLAPzemJ+lEuAEFo
         QSRo1A9ksbLk4Vhivq/H3S1qmoMnwDgjfUteXHSQgZ85sJey3UmqTrL8L8V4RSHD5LAD
         cKxrZjfutA4N8nNhifd5g5ue4sld4XJjjCyUNtKyEPuZmFImOUvPtz68j/MIYcVJPLZ0
         9FqlhydTFMipj6hJ2A6JGGHeGs/kH9tJjJMl+4Y1To4S6FQzsvbl8D01ttuAn/bMOiFq
         KoNwdJHu36/cfgikDgbL/4pyLB8a+37AkpaaF1nE8J/8ocgzMd0QyqD2t6DWmFQz3aub
         PkSg==
X-Forwarded-Encrypted: i=1; AJvYcCU6crBh4AGQA/S2YF30+NvvJPYDxT8arJSoqQqQrdD2RLt60eQoW0LzsijaR/kluqMFE0160RxR+oFDqQbVnQ==@vger.kernel.org, AJvYcCUjqq6+kEhNWi4eWM896FlRZS2s6W6wRLeeB9qQSQOTf+PtYgMyRVxd6E4o8mR6C17g2Ad4JQezEMAhvzY=@vger.kernel.org, AJvYcCV+aShVVeG361hoCxP75va1zS6babqB8hrsOO8XoUmAlJZnkjOjIdXz7SNiAZs8uubmqXUI4JquhVBJLw==@vger.kernel.org, AJvYcCWVhHVez58XHXChUVZgnfhBSMW1bY0OtW46waVrdHkhI7h3V+DA1kkev6+8Dp/BI3R4TKkxNGt//kApZrfV@vger.kernel.org, AJvYcCWn4JLcKGC5+ge+CBxprHQvZcBCprZa8BxF3CJrAyXnOYe85RsqQZ2cpAFIb4pWRJCM14umLWjEKOANOuXlYnnm@vger.kernel.org, AJvYcCXrZwrkYvP9bnB38QtOeDCGxUxeb/ZWw9+squpS1EIkU5p95TxFXWrrRSbeC7+f4ymoVoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmkHgHbLlzTWBpeins0SjC0IT27DtRNDAxkKUA+IdRKuFw6bs
	RkK+y20rQqyDLUpe3Vu/ucTYS3ekcP0agCZHV0rpGsSOlm+6a5b6
X-Google-Smtp-Source: AGHT+IGIhx0PsdDJkaVvZyexO/Bqs/D/rzFr7Dv46t2ZpbAiLjLs7eY7rO6Hc7JCeQzZ4hCsEhbaWg==
X-Received: by 2002:adf:ed0b:0:b0:374:c1c5:859e with SMTP id ffacd0b85a97d-3788967e478mr6891163f8f.42.1725865705078;
        Mon, 09 Sep 2024 00:08:25 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 06/19] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:20 +0200
Message-ID: <20240909070742.75425-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/tests/oobtest.c     | 2 +-
 drivers/mtd/tests/pagetest.c    | 2 +-
 drivers/mtd/tests/subpagetest.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 13fed398937e..e1ee68f8b8f8 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
diff --git a/drivers/mtd/tests/pagetest.c b/drivers/mtd/tests/pagetest.c
index 8eb40b6e6dfa..6878700d2fc0 100644
--- a/drivers/mtd/tests/pagetest.c
+++ b/drivers/mtd/tests/pagetest.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
diff --git a/drivers/mtd/tests/subpagetest.c b/drivers/mtd/tests/subpagetest.c
index 05250a080139..f34bbf033c4d 100644
--- a/drivers/mtd/tests/subpagetest.c
+++ b/drivers/mtd/tests/subpagetest.c
@@ -15,7 +15,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "mtd_test.h"
 
-- 
2.46.0


