Return-Path: <linux-kselftest+bounces-18629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E116698A2E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118BC1C22A08
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1601922F3;
	Mon, 30 Sep 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWdkt70D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFB191F6B;
	Mon, 30 Sep 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699840; cv=none; b=kwG9nLiEkZnlLSzuLsgYX6fvqCE7cPzszd7/EmEtbdXUBIVohlOCfogPVA97H5k/xUIrhZG+VgQ7PXZCWFqjFwCgiDDn87f2QYRFhvOrWuV87e62UuIyJE0DAkrNy5WAI8Gj/TgnQovBtKxS03sld4wlwajP9JoEL8l1pxxYfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699840; c=relaxed/simple;
	bh=zHx47Ff5tAh1Vtn9s4O1B4HA00IlaG+siCqRs3o4IB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUMXMXaRJGJA2gZPayO8QVbffs8MCRAmQcYVijbfJZCbL5ycjsQHVLt5XUEQV44H3I+hXH8QvyzOdQkfL0WRr4wJet0IMHhx0G6wBC5YZ03TInCUy/aWVKmRBFDubA+f5eibBpQgbf7n7mX1icg5Qh8PwFCCim/NfXwUYKwTtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWdkt70D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cc8782869so39888685e9.2;
        Mon, 30 Sep 2024 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699837; x=1728304637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTtABT1rYfIzK3Apk8cuoRmJAsuypkLox4BN8k8T5lM=;
        b=XWdkt70Dhha/stlNBVPBLvJ2RjcJmOEbXg0tkmuZb6N/iBw9LtpDTh9Epu66AE+ymN
         CdxKAt3KmtfanbNgagvak03rBH/E0Vt6Qu1pwGgsQqnjScUN04jYco3QEe/YJBPF+i2L
         aMvzUzgNJQfynwRbcBLx5rJQRdDLVUkdSGDFN7tpF+1X9HxbEcwB4l9xg9258L7p/tzA
         5WhYk+tulNcs5vNPehdo7FHTUm3e6itadk75PemopMb1FrXQiogR+rkQ5EmvB55FrDvw
         tDbHriQJVQmt8qqlp4DwoM81a8vYO5KMDNnHH/21HGfGRcmNPHsm+LAncjhlBAk3sgeA
         XPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699837; x=1728304637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTtABT1rYfIzK3Apk8cuoRmJAsuypkLox4BN8k8T5lM=;
        b=wPUTcVj/wlPfZzpLOjnw+UiequaH5uAu4VDXlUyTFJIVdC5WSMapehfwXhK/fvuIj4
         mbj1sFI7jgNNJXrDLYBDb4PIyQEwUP4IvTbJri+hBiIVVAPZwG77+mDTmOj78ZKAxc3+
         hldt7d7G8sWjm/4/QxJfXaNy261cYlcEN3H8XpcOZMBv9lbOPbqDwnP6jrQgCMiR+ExK
         vPJe5DHCj4DVGN9H7utQMwmS1nZ9YBqQiKdiibXgYX6aL4YrBTh9MQ77e5enDRToKQc6
         B61It7hwpSEW3iu3zLN9ImIuXl6jeXsLRT+uYwlHWhHxxSrt2IxaDndmYmphT9J5xMLC
         i/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeMf9uaJW3LI/a+nW1I6xwt2di+2Lzc94A2ifKvI2Y046RU/dUYkyF457YxyZRmocFAKTLFeFBdT0dmX25@vger.kernel.org, AJvYcCV1SxW3BlGpSckhplftQ6WqPy+IPuaK9K4RWqv7IrqZn14jW/ZfI+8pEzkYxkKLuHBs+IH18q4QwYaT/Q==@vger.kernel.org, AJvYcCVodsU5ovrVBlb4tGoVPOcgEyRkCJDfOdo+gYb8zmn2/Rk6c/SKM3cucFKaKbcupZ4C+bt5Aa3KhK4jIbESZWN+@vger.kernel.org, AJvYcCVu8utInfpFnxToLtj47itZghWgNTc755Su9fL0Hlsm7msuQiHeMy1tyvbYFSBU2L7EheIwhp9EZAeowqBr@vger.kernel.org, AJvYcCW6xWf1O8Q3HPryo608SIi04TNgGEiFhBpaWPGuOCj1zbcD7StBG53yJP0ucB5dWBiymfaWDmsFbexOOBmpUA==@vger.kernel.org, AJvYcCWBO/ZCD7FK3Y3bsUOhF7cHSJYP8ZLf2oqSkoedCDdG+4/W5jm5dZmT5wwsbxaQ/I/Z+EAfBS1xzl6IaxY=@vger.kernel.org, AJvYcCWF2NHYxrSpqdbqJdwIdOtUxe7OQRTXc10rlHGar1PTbAvV8CAZ6a7z5wJTOh2Ii63rJXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgiLDrOFoO31aGx/3AWV/wGluESMVw26a3PYfJZyfqF7UDurC
	AEXRqsE6n+Yphjob51SZyYFIXIGAPbCFRqlpHBuihr9HW9Vetfgb
X-Google-Smtp-Source: AGHT+IHBiyuHQnT3ULO5RBx3Lp6OpesRYqemaXFPJxpMx4yYeqmrbcmToiuf+tr1+RXNDEzbJ1b58w==
X-Received: by 2002:a05:600c:4f86:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42f58434768mr79576095e9.13.1727699837034;
        Mon, 30 Sep 2024 05:37:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:16 -0700 (PDT)
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
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 06/19] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:17 +0200
Message-ID: <20240930123702.803617-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
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
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
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
2.46.2


