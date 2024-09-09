Return-Path: <linux-kselftest+bounces-17483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2215970F24
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D631C21F04
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7A1B1431;
	Mon,  9 Sep 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg40RgJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF81B0105;
	Mon,  9 Sep 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865717; cv=none; b=h5dWPr9n0D7lkWXz+HBzcBUCP3dNqNs8QssE+ZNAP2QoI9c7ijAyaoGPiEhIWjCKHWXQe7+sgpQHglvvTaYDS9f09he+rzJ8+kY0Zl/KtrTbyJeytzr5STR+WKFEGKLSIUlag0BJu7VpJ5Au8ISp7MMZk3h/OqntRKaazQ21T5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865717; c=relaxed/simple;
	bh=BARq6CI0sUrpiqbRLZJwneAW1VIp6GJNRMTfyDTLnB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUXMQGYp3Ylsx0Npc/+CLK1pky4O3AqYoJiT0EasOeATChOZirxvQEio94/1XIG4rTNTuYINABpvRTiNjRpQZJiOzJrYbcyIlK+5Wdkw55IKn/uGCp4Ma7hOWT/PQEgRCTZSTvPJ2R53YMhaOTzaPtRCPlWkN3spJLYLQki2YNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg40RgJE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so5837335e9.0;
        Mon, 09 Sep 2024 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865714; x=1726470514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pq3OAvpMN/C/2QwAD8pzV8PNMpLIVHwySHZrZo9G7g=;
        b=jg40RgJEW+c4ehByywsa8twov1RSrSTBNvIayskyx/3vOen6AZvCB7FJQZ8zEac0/t
         2m3icQ9HhPfQNwYnyUX0/NDMxPiGnGHMiDznLiFxql5fAyLQzPRUbZmO8RAx2MJdzRnw
         y9saPUOiNJ3yBFkaCY69xb3ZzsUWdd5RS3lvPziELomEURrUJxzRG4QSVdk7LTxG6YM7
         XISjU+cYqLw/ufsB5wILZWMmfP8EZwSojcPN9NiQKmhoT1d2M4rbiLNGBm0UIIH6/Dql
         OY1mfnYBkMm+2oLfK2PAzWw4h8gk6AFC/h5vxk9tRsrm2AOCwM4ZoC0K8MQHIc6EJV/S
         euiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865714; x=1726470514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pq3OAvpMN/C/2QwAD8pzV8PNMpLIVHwySHZrZo9G7g=;
        b=OUrYktPN5jt3pnuw9M7liALQku3QWUrJbs/mK9x4W/+zeQmYj4eDnYpyTiS+/s01u5
         b9ImAzGM/xMgXRcEQf5OW1tkr6NyPF7doiNhBOlWvV+3vosQaKyPNHB1p+exdv5mPOJR
         HkZZrImoNlIgjcIyhdyMytxiAbNsa+WjPeurreWMFAUUSOGXQbAspDbN+AbAHaV3IgZ9
         lDaSDlnutQYbxeokYf2H4lXMXlG/yENXQ+ArJLdj3wHU7noQDGd5dw7YQTp7bAq1ZN77
         VeWTcYONxKxnxsVOj8JKGgT9NJ4ZdowL/30Us+BObg5IyOrzS2VoeQLDQ9o15lqHa/Rb
         yjgA==
X-Forwarded-Encrypted: i=1; AJvYcCV6sJcizjZr5qz6Wd4zYFmbGMkYkIYbvIYAObHfwa3EKGA1CPK3mopsANL+E1fRJNQfM8PR/qoHAZfHo9pfoQ==@vger.kernel.org, AJvYcCWimhRdFQxIdHKcxeP/zqhTj0ounys1CZ6J4Inuuckbj7oNriXagGahBHUm6ezbRln9NIIXpnjAxvc3Vd8=@vger.kernel.org, AJvYcCWxWMD2bMWO677ZEN4JjdDIrP87HUap6T/XBuTNnnMyJgZffHqS5n5CKOUhkH0icgng0vo=@vger.kernel.org, AJvYcCXOY60ZF6vup4VcqcnkAn9PlTaf9BUCeRXAH+97ZA9nUdCyblMVC/2cwNoc1aAnu91kManxK9EDlgi1F4kuqJ3L@vger.kernel.org, AJvYcCXWVghTnd3PTBpu3ticQmsS79cp+d9rVk6lKbc3tFQTeJupHXSCk26hW8ydq4AlD6F1HaIPUgmo6AeYNHzZ@vger.kernel.org, AJvYcCXpIN7JzLCXkmt8z/4yq367HM6PcU18PZ7MhLVnNesPW5CPVUxyiHXR+aOCemAPn3IEqnt0zbU0pHG1VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YworlZNeWkBmTt9ZTnfXQLb7p/V/I1GYYrY+XR/A4EBzGvc/zjI
	ULA6MOwuV16f9kIleHUlTFem1MpGyNErSOwtvkXozjRfdS28LkXi
X-Google-Smtp-Source: AGHT+IGX2jPMfg9AUfAU2IcCFjSCwUfQ3UDJSxJNlu3hawnJCsbpvG54Tw49u6Zx7j4nUhAvEOwTXQ==
X-Received: by 2002:a05:600c:4446:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42cac9fb8fbmr45303025e9.31.1725865714158;
        Mon, 09 Sep 2024 00:08:34 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:33 -0700 (PDT)
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
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH v2 11/19] kunit: string-stream-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:25 +0200
Message-ID: <20240909070742.75425-12-ubizjak@gmail.com>
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
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/string-stream-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 7511442ea98f..7734e33156f9 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -9,6 +9,7 @@
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/ktime.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-- 
2.46.0


