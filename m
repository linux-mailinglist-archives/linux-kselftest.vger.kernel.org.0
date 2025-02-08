Return-Path: <linux-kselftest+bounces-26101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41EDA2D67E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A48188AD4E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343624816E;
	Sat,  8 Feb 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1omka4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89312475E6;
	Sat,  8 Feb 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023117; cv=none; b=OVVVZ2ImLCNhnrRP7CnvUZzSSCCdyYviNZqo5GHjRpmh6w9+TTkJ+JjPaZ/nFzh4fH6YhLGhoxpJ1Y/x4qf5Ec3bsJJVEBU62HeK/4DXx6D2wDp79ZfP7vaNBo1RdHroyPwoP7AugrS5ZF0KtKJfUgI1xCRTdQ8ra9WbMv1cNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023117; c=relaxed/simple;
	bh=SpWHB4Z5KMf4LSaMFuL5WRBvdcw8Q42qJix1nneUIoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecgnIVEbWSfAMapKCb2TC9QrV1IQ9wit411nezUbGjkGUoE0zddLo4lp0aer9GPqtsSaCt0dshk3wmI+GiqvJDWMXdnXhEGW+ZsEooHcSulDxWhrT2ZKZhcFiQY+zy4HIbieziDTMukaJSS/IShjZVGMMimJApblGVzI7V1M4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1omka4W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6edb82f85so447293085a.3;
        Sat, 08 Feb 2025 05:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739023114; x=1739627914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=m1omka4Wgew8kJXd8+YOpe3hsaTfZMxErr8yr5kRrIQTmtVOIhyZjOrHMW2fVFSwoC
         75qitCJhhpzuZy/6jD/fK3grnjAqUYlQR6PRf0tP33hTqVg+1kGY1TTsXN5tfdHsg8W8
         W9+F6vYEez6U7dfn+FTg/Iztt+VXU5hYQDWcoCTAeSS1HunDGkc9Q/fJkS0Qw7xuZcJa
         Lgrzv5ACnTml78ubmn6vvmSEGJtNaWEnAwuhoRwofM006Ufwjj13NcIJlNaowASiq/fe
         onBpSdYO5VyXF+Z3MrTwp5YMEs4U0H7eRoW3AlbotIcXG/UbBRTTz/3oRE5qZdfIzAKy
         uFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023114; x=1739627914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=la4m/CxXwUjCK3wJXEUEfrXJKpG2qyYnpOkuAP2mp2QqFcxDfBqwS9GLLDhlV2bolM
         wo7Q3sHSg3YeiQbqlv4Lz3Tx0jZEY9W3b1CQlocuUMo8JSeIXGmLH1FuIa48Fb6BKBAE
         McP35GPjnw4doxSI3rYFptIHfiOtm8Vci11CT/zgM4PTaVtgM7iKAMjDeY8ndJeg38wo
         Cov2HIpBPyUWLR92JWeFHWpeFiGIRCfDBaDVpQ0m0PqYRxgLgIxor5ygp4gJlKU8FGx1
         duYqMd95oF3xIrIy+MN/GjtsjkQf2AcJr4Gp9xwelYkPhVXajAe/X8qf9t/3t4P2vQ3f
         bnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7kgVsVLb3l+hTZtMqYoO6xvgaywaYGkBw6uSNPs0ffEPQmINbv2ueGufDtYG90lUZUGU2sJlTA9VTfoIsrdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxgB/BxU8EMnWekS1Dsp0iZtKPMhD9OiyTq78hExLDaMV65+4
	puUgA+LspSbX/udFnSs72DT1Kozef1Haknd1oLpV5et7t3FNdzir
X-Gm-Gg: ASbGncvDK6tvi507cXL242I41jdCHwLGl+eLyi7SM7GZbmhRkxnT+NEksfidFh8SpIS
	NpmXjZqHCVHu3/o7xoiRxJkt8XufYiKG9x515R1ToeOxYSupGbLqFyZFPNKxKKmA+ROqV2nrgS+
	f+xSTkL7bzj9du/MAYtkBReza3g/WeACeEZRePYc+AhwPCSBG6+SpcD6ayZFjJwtp4TeXtUjI+h
	1p/ujBXjxE8pLKG6Exfr68iE4SKKnO+bWHBXKdi9+Qz2xhwu0lBlJ/mN1CTF9N6qPZNSyzojl4R
	KaLMsr39wAvTROYwB8qgFqu9qhUUc51RqUMhmg3WeKhb8VjB0w==
X-Google-Smtp-Source: AGHT+IFaaMeO1Ro9AjbPLasWF7SqUGYq4MhkguP3dsluPLInitAVwJZF19DxV9RZyGSPSzA016idcg==
X-Received: by 2002:a05:620a:4248:b0:7b6:dc74:82a8 with SMTP id af79cd13be357-7c047ba6b0fmr1063979285a.9.1739023114333;
        Sat, 08 Feb 2025 05:58:34 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471810804e9sm3268471cf.80.2025.02.08.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 05:58:33 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 08:58:28 -0500
Subject: [PATCH v2 1/2] lib/math: Hook up tests/Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v2-1-863119447e04@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This Makefile has been dead code since it was added in commit
7fcc9b53216c ("lib/math: Add int_pow test suite"); the tests worked
because of the duplicated rules in the parent directory's Makefile. Wire
up tests/Makefile and remove the duplication.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/math/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 853f023ae537..d390da9a59fe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
\ No newline at end of file
+
+obj-y += tests/

-- 
2.48.1


