Return-Path: <linux-kselftest+bounces-17498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2C97109C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982A1B21592
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B01B2EE7;
	Mon,  9 Sep 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyF7+HXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA71B2EC1;
	Mon,  9 Sep 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868619; cv=none; b=F7XX0ULAfAUDqfw4pPtLPFS6twUfJWEAxiHlu4zokZxxeaBQV+IhIovDfSzxmYEQRhddCcG4c0Z5iPzZvSRO9IMQpO5HdY0M8N2ak4qATi9WGbQAikEEQLMAkHRb0jFtRZ5AwPVue7r1tBzkd1U/1jFBfV7Q6Gzn6j6E1YkKSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868619; c=relaxed/simple;
	bh=puSvXGRn9f+RyH2i76LYyDVzzhSDb22SzRMEwHOezLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlsL8NOwrUkW+ybQmaavM/n1rVuAykLYEddpk11mDvvRWeaLkSUFkmWL+Qt2uf03EdOsi+iDzzcD5iooRIbCttHs6PjDtbZkvhbcmGnKhPj9tfEnhR0AuSf/MmKLZX8Ep7nnk+jlo8q21mljNgVBCgcXOHJHkKQZqrmg895/n6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyF7+HXj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c5bab490so3083857f8f.1;
        Mon, 09 Sep 2024 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868616; x=1726473416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT07a8fYg2mX8zdZb0NUXYrNfwc3Lxt6djOa1kz4aGg=;
        b=eyF7+HXjs9q1avATN2GWz0LNztyBVWzwDQvVs6z+qjT1qMN0Y5AT2yKjLvbjZhrisN
         oUFG0WGVnPEIfyA2qKEW1hWdFv+SFnTYOjCPk8dGPJfbqyRNJ2dcDHtkp/o7pRWfXyEn
         DNzxix+WbPqj7JsQhRzLyZ6dD7+a/6dyvsBsHFvwaNAVM7EK2zuBkXYzFMj/gawxYnxr
         803WEq2fuv2AYOl1ywEaCKk31pRO+3RuS1lXdLcUGll3ZRCvUN6QPAKXc7gYskueojGz
         TO5DPlptcD2PE4MxN+dKOWGsbP7aE2D7JvlwFwI2exL6jro2v62+arVm+5e64nW/4js8
         ReyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868616; x=1726473416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT07a8fYg2mX8zdZb0NUXYrNfwc3Lxt6djOa1kz4aGg=;
        b=uf56EsmLF8nyuSQ6O7DUqVtZPVATvub9QExCCY4A0J1diDSwi6BIAerFFFcokqABsb
         G7m5FrcIQTdyX64MEZCfvq9wUZb9jQsUMK/qEz2YcIbP13Up7V7cuz+iaIEC3tUTd7ql
         tphIEx/IVk5uYswMshK+ObfHJHZReBakPD5q4+snPYVx0Bwa7J5M+y4vFLVhwfkzsQgs
         vUsD2dKf9xatL3HStH5IqsavL4GopHfR6bbQKk4+8t0Q/+tj+lgAiG0zTFRqCLjnhY70
         At7hOjoEaOH1LS/I+KoiuLajJHFWeJEm2O1Xp6yrU3qmg5+wq9mp7t6dApQQnOFqC5Yr
         ViCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQVm8z9+2hqKhHBfCP59bYc45qF+jCo1FCg27Ag8MaKQMva7F17XouMJpzOT/gDwB1YIvTab7JNmGR1s=@vger.kernel.org, AJvYcCVbQSMirBOQCvdL2/Krj1489Dirpj8faptuu3blRqWfbcmg28Yu9pm+E31uBepLlhv7+Vmr9F/cFy/BE7Ni@vger.kernel.org, AJvYcCVp2Lb7ekPanHE6r9kL+lXVZur+QNvnhFguqhOkQuXlbh6bP3PqfJ7QkKJotQZuhdD/gN+05Nm0QzM8zA==@vger.kernel.org, AJvYcCWcIVGJT+xi0gUeMEw8YuxLnv7DrO1RG2CV9IGOiZ40FNlnGQyjzH3nTwgyaY6oPMK0obPp55WdNIbDhcFmbfWd@vger.kernel.org, AJvYcCWlDKAf3avU7cfD6QeSOsEaaS3LTz3o9ixXJrzTJZnOH+i5Foy99BQ5nDcjCKPj0nrutig=@vger.kernel.org, AJvYcCXLXU4+mR53TkTikdt/AOyJrqmIspNJ1tc0QbDwFBO88ZG4c5FLMh4dd6iRgdxgCADo+i9AjK4ctSaufx2DYQ==@vger.kernel.org, AJvYcCXs/rxCvzDjhCuCuXbeB+LQwkjunSctdVoVQYA/YoxOyjXblSOn+hKxEG2xdQ8KROGw2c4hNZoOVRcNCMZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0dv3knmf33VX/OvhG92RcRBGFt6nP/n1NeMBrfEYtN21N4PS
	JGmdPh9C5Rh3EvIuE/S09qQrwV/xFEb1T3NuExZ1qtDKRrO++reE
X-Google-Smtp-Source: AGHT+IGmZsYZCmG7YYhzHupjmmuJRGqS/FOf75V/9MKd4VXHMgO9wuyXejXAu7fFGUQHBhuwF3txfA==
X-Received: by 2002:a05:6000:a8c:b0:374:d006:ffae with SMTP id ffacd0b85a97d-378885c04ebmr6261181f8f.6.1725868615928;
        Mon, 09 Sep 2024 00:56:55 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:55 -0700 (PDT)
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
Subject: [PATCH RESEND v2 06/19] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:49 +0200
Message-ID: <20240909075641.258968-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
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


