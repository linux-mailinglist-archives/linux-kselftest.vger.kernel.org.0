Return-Path: <linux-kselftest+bounces-17509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BE9710F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4ED1C21E42
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB61B81D9;
	Mon,  9 Sep 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm+4dxGY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36941B791E;
	Mon,  9 Sep 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868635; cv=none; b=GMOEJ/fWyaM+ikNRw5wlHDcaULyCXMqZRFGut5z1WcJ9GWDbX2fEjFPGsBFB2YDQFQ2fFeEkKWqGS0reHjyjqT917GXbpsY9vwjhQq7y8XKLR4CNrOpgVhRb7e34W7QBhhB4lig6fP8xQx+6J/IU+UnON42Pc3yQX5xo2JlKYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868635; c=relaxed/simple;
	bh=tUTrUjr+mTDfGr/qeQBEHWMqb3LqyK7HvLda+2w6s/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9L7u0R0xOVRq/N4sjYO8xxvHcTbysz4lhspX/v7Lv5UWJF6/RM4KD/Yu6Hxlq73cRWuzC3peFQjYwFu/Q6E5GGlCcl2FNlc8Gu6sQwXBgPY2VMC3yUCebcOHhtcqyiTBfHdgZ4Flno89ZSdSig3zqxYc//4zXywcfpMdeLKcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm+4dxGY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so3079857f8f.0;
        Mon, 09 Sep 2024 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868632; x=1726473432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3RXsBbJQS/hq9A6ZJhcwQoifydWEQ6ZfpZw1c9736o=;
        b=Tm+4dxGYnnIoXK3l8LLys/F3PfFPK5bO4lXP1aUKmilC7ZJxd+f70VCtkk6YT9WXYf
         hNNmVh3ZmoeMPHuZUhheaO5VVeYMmuJB8/j8vv5d0xPK6Z3+aoUSSqETaki0hoEQoeWM
         Xo0sIvrpQ2Fnd46A5ichMZWfPypBy/u67OCiz5lVTfov+MA9up1wqvYn9Asz0CJzAIRY
         NqNwjje8njcDGZamf1PFQjQGozO5IHsiUg8d+0UlVPG9HypmbElhqIpiehYvXCYh6BeV
         5ce9kwm1/YzjErkUXJC0jkTgNg2jvkmzmQWhgoDVVUeYXzgBDBiss363civUYx4u9NAD
         woDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868632; x=1726473432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3RXsBbJQS/hq9A6ZJhcwQoifydWEQ6ZfpZw1c9736o=;
        b=EMJP+4sqFzJ8FMSGV2OUKlepeueBqDM72n7SheNDFNRuMZNDI60yUak1qNhZLOLB73
         SyjSgwXHLX0/hs3GTaiVIM3TbJwl7wWbudDztAM5aKHl0xw4pBZ9TUVXZQ/CzX8FMeVi
         RhTLu8PSBRPFyfJX+V98M8leThVp49jT1vKuSNavJjBNblbT1leQGnH2R+MDpfX7aRxr
         t6pVPNukprQQQ3u8sk3o4//80bW1RindOUUaaklC31UxTDzxTikUNPYjhZGpsmqTjSx9
         0aMHoPPNjOrMzFKO8mm9/eFR7prh1RscwqwO9ZKp7mr6Xq/OdtpDiPVfZZoh1qLE1spL
         9a5w==
X-Forwarded-Encrypted: i=1; AJvYcCUCXwyu2jdTyX6czTG3IEqkD25ujqk7DJeIFWqFS0okFVa9MjkhsSGq74q3FYsUYry+wFcpITWswcDZ08Ae@vger.kernel.org, AJvYcCUDIbip7jysTYTIjMpVjWucowGi6EaOfbthuitlklQ2HEeayf0zTmrNO150pSRFGZf20oU=@vger.kernel.org, AJvYcCUaJNLaxBynYhBSbZ3mdf83w8Imi4x4HIMRak7ixnz1008nWx0wSHCkH5p4W/QrfnbBUktdDU0jRHzT/w==@vger.kernel.org, AJvYcCWO7AAqYtC2SDqkYDWPqp0eNfXUqP1zzN/4+CE7UTK4iu8AHh9gozNO94eFGm0bozYI+rpuJB7DsETVoHNV@vger.kernel.org, AJvYcCWtM38t83hLtdcja1BgwyNwHzDpV7RFCNy4M9f1Te8Zwh4ibKVShJWCeYIXo4uDDo7ojRGGKirq0o4qCqCVYg==@vger.kernel.org, AJvYcCX76ChS2ZLCPeDC9yc3KPGzMlWY7gjdIs9sIKeHrKjc9cjXds+fudjGzNYOEk7ltkFA+c/Ved0H4GDNoi329U8g@vger.kernel.org, AJvYcCXaIafujlxBIrT9+2cbS/q0tVad/LBl1FmfMurRTTF7RqBN7WtHBhFV+s79up5Qu3ayXn2UqLAGXEK8VFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIqVkY/SElM3/6x+6GX4VuqoUxxZaBqlRPuU+bhwCjjuQdffo
	rNlbkcQ0sbG6KiUoQ35btAX0Pl4Briv0AKGEHWRTgDGVawvRnqe6jYnd+YNxlZg=
X-Google-Smtp-Source: AGHT+IFpmssEVWDSb1D0XQ0h7YT1Yo7NzbQWSyrRT6WdFlX7jchUsWEdPQv+SibupVKFxwfhwpW2yw==
X-Received: by 2002:adf:f104:0:b0:371:8e3c:5c with SMTP id ffacd0b85a97d-3789229bc28mr6033390f8f.7.1725868631939;
        Mon, 09 Sep 2024 00:57:11 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:10 -0700 (PDT)
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
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND v2 16/19] lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:59 +0200
Message-ID: <20240909075641.258968-17-ubizjak@gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_scanf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 7257b1768545..44f8508c9d88 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
-- 
2.46.0


