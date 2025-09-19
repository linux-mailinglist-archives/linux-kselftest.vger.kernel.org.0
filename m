Return-Path: <linux-kselftest+bounces-41975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DFB8AAA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2D7BEB19
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592431FECD;
	Fri, 19 Sep 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVkxSd11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E7258ED6
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301084; cv=none; b=b6Thbe+/7QF7EbRU5HhGW3ZUcyf3VUuFFmN5PRfdAOCH4PjoSZTogECjw1sqGpxEi3WxzAd8/E9BW/HBh5resVCvZM5quX+gEjySzUSk5qJQJg6/xWjh8HNf3s+Gq0BmqYlEhpMttASCI0iyaF+ndneLYu/m7NnC38ThI2QjuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301084; c=relaxed/simple;
	bh=LkXiNYVmYy45PbtQp4w3oidCzbB9YyGL7WOlczqslRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s1HKHzowPbnNqL6t28jIjZep00elvMm6CcZR9Lw8EeOg+7k/nWQP/OaQ1ghjN0nU5NPMNI+WicFMduDv7BKhwnlOK66izZEYpeORGxfwPXUAmGU4Hptdx1uWgSkK/EbbieNqWRyjiIn4OxcQzo3ml8LZL186AhkO33ILEyUi/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVkxSd11; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de56a042dso15616895e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758301081; x=1758905881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHGlmanb8gaPkMmh9rY2xAoH7nIapmCNS2c1Geon5Qs=;
        b=FVkxSd11McjzefB8Ll8uU1936gI8oS7ah3PJUPFjaJ/xDSp41scvUqinCh9Ys/ZzZ3
         FLcAoZqOqMBblRNqSP/uHvsCWt43SjsnzR+3e2fYlCQenDjXDX9OENgd6F71PDe36SS5
         ztNEKcYZrthA/ILnKBhCCHFL7Jp2RI6MkoPJ3c1UyPgZ9q3vHJQ+R3R7G3WK090Cn+2g
         qSjY/wZUPd5QrZ8u6HIkrEY1Z8c02/sRRO3+N/cn8n40kjtqkUTn5ObHgZM2yBrLedv/
         qKBt+adnAriUM0sQxks2SH+YbZBvJqeCgfhtwHOJG34DaR5KRJIDKLhyTmsAX19tl7eO
         ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301081; x=1758905881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHGlmanb8gaPkMmh9rY2xAoH7nIapmCNS2c1Geon5Qs=;
        b=YXUqjuP5pU6rJKGbQ3jRwUVpg2oZG2ibNHVPHTqEWTJ3DSkIFHrsGw2C4S1a1ci/Ed
         o7TBz0ykb1U4h65YOuZx6WDLjxT4JvDevWusI4M/DBV3jK4kUKAgorYf88i2ljoLGiqT
         iHOd6R9BXEKIuuy8reMJ5JrbJm1IeSVB2DuMgSGpV26K0yP4o2/tBg5H0ZLzkQIlhfF7
         PMUieLF5vl/lLOJovxNcOjVSvnU2fU1Ee85pSr3FgRZS3C5uCb9OzmtqcTYnjEGn/Lt9
         DYS+Mtnqgo3Xj3vG/cK6rfeI7xngtBlyyu9PPTxrEnRzw2RZwlY0A3jj1Y1wPy7yVql4
         gZrw==
X-Forwarded-Encrypted: i=1; AJvYcCVTasAbNNdkPD3dxEA55MK5XNPL+UCI/CLlStdSHcp34pKW5RFSXW+jOQpVjhw0TVcXwQ6SZHcRgihZaW8foGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvHQs0wQVjZi7PwMNKvVwu+YOoV4yyAQ1KGPsjAvac9hD6P5w
	iAgGgG4MnW5fK1Mq0cb3FhWEH8w2IlVLzsDhe9rKVEIPWft3JVFTchA3
X-Gm-Gg: ASbGncsYNiQcc6DmUWlY3US+HI4n8hjbcXk8eb6QDR186Hq3GLt9raqVHYGIiiY0HIb
	AasCsQvWIXaatB/E8lEVc9QpakP8r87hUq9XVsYAyfT/wimIi9B461ruaI4Z0UKy3ioYk5W8D9c
	nj3r8GdNKmkN0VfpZW5HVHXPHNO28JdnKRz2gIKlb2sjMCBF/S5KEoE8kinX1/E/VLM9VArOk0H
	6Fezs//UXzCt6K3vVolVUY9Xwslx5KqEuaj/E8tdDslWpvE9Ddo0VCatC5N59SKLHPerFg1gOoA
	hx+oLCm+M3FowIMFbt8WcuIb2itcaUfBolRtwgVJqjYLP0IBM7Z58yJoOhjMqvCCrMAuWQt21ho
	7u8gFvvGtqiVinAqh2h2spg==
X-Google-Smtp-Source: AGHT+IHRuVYN4oeI6DMvgCDuUp6xTSHvjNQAT0yQq+8tmYwKdcvpMDomyJYfc7kVeI7DWpy6ZIZ2sw==
X-Received: by 2002:a05:600c:1d12:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-467ebacab73mr30669845e9.11.1758301080265;
        Fri, 19 Sep 2025 09:58:00 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f4f6asm8171331f8f.6.2025.09.19.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:57:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftest/futex: Fix spelling mistake "boundarie" -> "boundary"
Date: Fri, 19 Sep 2025 17:57:11 +0100
Message-ID: <20250919165711.557272-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a test message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 722427fe90bf..3a71ab93db72 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -206,7 +206,7 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
 
-	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+	ksft_test_result_pass("futex2 memory boundary tests passed\n");
 
 	/* MPOL test. Does not work as expected */
 #ifdef LIBNUMA_VER_SUFFICIENT
-- 
2.51.0


