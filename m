Return-Path: <linux-kselftest+bounces-38552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529CB1E73F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42D924E431C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F9275AF9;
	Fri,  8 Aug 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS+PFyCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A5275873;
	Fri,  8 Aug 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652341; cv=none; b=LeELd0HBdw0d3XH+lieB0TAT8ZWD/GvU25ULkLuaKs08peOcK0COUC9VPiUURLX/R6y74lR67G0UugXoFVevovWID2zZUvx+JVv7i2UYkZVdIXiZe2/n3BS+iItfKMrYMWTLNijmguQIsLy+smvx2Sn/3v2+POFNbmeCbhgIfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652341; c=relaxed/simple;
	bh=jmY2d+TVbd58EY/lRBkBim9bE6y5cp6A+e45rmxMhE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLAW/mMkrvPex6cK5OYUlUOFLQh25t+LH/j2Me46tQTdLm2g5uTnyokBTb30GTINQqLq6qOXiu/A4zTfc7SmHHER0l7JDhVleqPBfuyW/+MwjoD3L1t0o/ShWTlEx5k44YGKxknwZGleCD50MAKFfqjx0rnx07ZCLGY8Vqc0Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS+PFyCA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1127037f8f.0;
        Fri, 08 Aug 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754652337; x=1755257137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/uZdIWNOl4/K2KiBu5RjAyid6lvEDY84VsOS2Ck1o4=;
        b=iS+PFyCA2ScJIQMmrC9f1Fz86rROBfXVA+DoJPKTPaAP2qeZ2cCRIDMDLUrvYTa33G
         CUnfYrWuEnmHiZxgT6Pghx3m9GY3qVuSjg+WwjdkbleBycvZgbGOgS0Q9Vp4pb9XcLZx
         R9prGbEKOYU0uG2kGvqwqe0RoVRcb5R3UOrdOlO/4rSh7gV/JbyUEiOLs056ifISAPjm
         g92SBrSH650mUznW5Ql1BJtLzxiutnG5ozNiTj1klXl5uV0BJSUQk1GCM6UQ3u4Jdln5
         FbN7i+HLzD2HaMC+bzHc0AIF/X30F01Gq+NNabG9rande3y2XwCqQpwWAVdYHmK11I44
         RWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652337; x=1755257137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/uZdIWNOl4/K2KiBu5RjAyid6lvEDY84VsOS2Ck1o4=;
        b=IYmFONdTLeKj29XZHsiB+yWNaAPfKiLgv74+fJfiHKIRu9FmVJ17FsXCqS+lgXv8+6
         AodeFa8EnhIDzCFyqgISNq46xlyLsc/rXxJEW/NuFdC05l95jSPcDQc6qkyJiH0Nx5T/
         GukqZhfcGho72dvIzGSJAlWwLhq45ckhOfX9H+CxOKvZKayBIuvkF70pEyaGHd0XaP8n
         0ier56a+Ij4znK2LQjGyBKc8spWWdHI5YObBYhH9yjL2+l+FaL5tMqCi5VfzqfhJLjNw
         PR8xiFAJs4wa4PcHXtN4Hn3gJgRpwTr9ra4RUQCRf88/LO6GWp26SQZnhhZJTqdzJ61t
         et5A==
X-Forwarded-Encrypted: i=1; AJvYcCWyc2f1EDeK898ugS0tiRJVl265UyB3Ot5Vew2cT7s3lIb2T70tQNC64cTu1hbkHsqrVW6YKeH/Yk/LW00=@vger.kernel.org, AJvYcCXmJo39Kx5Z9v1c7f6Y87X84xNnKBCsJNQ+rRR/hJTKf+KROstAZ0CmT2eFmQCaqs/8pdUKD9yFIm2gPg7fGh1S@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpp1BMBYE+ezU4+1ufszeRXCotUC78bhJILoT1hvGRUg25nuj
	hR976c0VvELXZjPqJJPSQMjPZA2C5Ei2lIfMV6AA8gS/ZcLfq9s1+elD
X-Gm-Gg: ASbGncv6NdaPWX/PJzmCbf31ltlp79k0zY0SxqH1Qln/djFxEx5Ac+DgiNR7W22S/PZ
	rc2yAK1GMbD+6K2PBvrfwuNk00WBaWkjlnbu28l8n2UX4XYYlzKb1a/zzUczd9lMpIQseBo6IK5
	J08hoU5D+vMplEI3cmjJGdSofmdnImIiV/uZFvMwni5fR+q/l00O2Em4Qqoaoc/xfdTGnxm47fI
	OIyCY47fXAb3QWZYEJBP+WEKuUdcmUAXEaXv9xZVT6mOw3R3yZIqUFQhsStDJxTd4AxJYJfhc+g
	W0e+jDgxFuI+XqM69QtzVKr9mdyfVeyGhCuQmPkgxZAZ6m8ZZqXRnDkkQCO5phI1zelTpsq5LoD
	H/cSBeh9WefzhMUryzsJR
X-Google-Smtp-Source: AGHT+IERetu6m3PsFoXoBwGgw08hFG2wpn/20tS6HlTFkIlZpCvLwaIGhv4arG8j5wADrJYmK69CbA==
X-Received: by 2002:a05:6000:2006:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b900b37afamr2314380f8f.25.1754652336884;
        Fri, 08 Aug 2025 04:25:36 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5d0b1afsm127832045e9.26.2025.08.08.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:25:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/futex: Fix help test for option -g
Date: Fri,  8 Aug 2025 12:24:58 +0100
Message-ID: <20250808112458.831212-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the help text for the -g option contains a spelling
mistake, a space before a \n and is a little hard to comprehend.
Fix it.

Fixes: cda95faef7bc ("selftests/futex: Add futex_priv_hash")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac4946..93c636d6bf80 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -132,7 +132,7 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
+	printf("  -g    Test global hash instead of private hash\n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
-- 
2.50.1


