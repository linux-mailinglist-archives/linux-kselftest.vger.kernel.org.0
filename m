Return-Path: <linux-kselftest+bounces-22645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE29DF2A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B9C162FC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0A15687C;
	Sat, 30 Nov 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIrmhwVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505B8468;
	Sat, 30 Nov 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992072; cv=none; b=M8pw7So9J8gXxSmKc2JMB3hhzrZFaeP78sjhIPSnZVjdQ/xi31hZpTJSX6WPg7xcQyH/VifQSTJNXgJGScoCJ84NUVuzvV03VGG4iyJsvyU68B/VllPBCe2r9BZEj1QQ596xRFO6nFQsn3Tf2kiSGoL/VfLXkgjr6HJRDosO7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992072; c=relaxed/simple;
	bh=2xDosrT5uGowFwseze43Q9Aulyq3XFD4u635O8iqu/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqHjK9slrVAqeieMCiUd+haA3YFAgXo+mZ19HOw6mDW4JqCrEt99MrA+fVeDNEBjNDYylY5JNJvLE580Ac9oHxu3Sg6ANmwe5aFl8pC5OkVGcSEM39lU+GEy1cxk9YeIe0AcgfOjL3paKTPYTeNfZWiwJvi3ygYv8naz7mUOHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIrmhwVW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso618885ad.2;
        Sat, 30 Nov 2024 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732992070; x=1733596870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8EbHRN09/niG7ChdXPQaHzfNNZ5HMf4FMNnBO5LFSc=;
        b=EIrmhwVWJpDXBbVkX0Jg/L8T34QVbhpoZrUAZZlcko7X9drjrIGj9gn3mRwW4wv7kt
         hi/otaqeJKpXiaXb1KvshIjB8+1uakt6LW0cXAdypn5WnfnqOkuCsw8F7dZ4NjpaquLI
         h/izjIx5DCbgrS7sZNKy9BVZY3zMgI6G9AxoK1ToCUVGuhacxCbicCJwEBf3T9mj9ezo
         Ew4cYb7QgAeDOsxk6i+1nM49s0D7ZSj86BRoGIAmMoOWfX/dvtPFX0mqJnL7WzXo+cd5
         JtjfdetOXGFtluw49rpq9u/I+hBwLV4M0i2JJ9vgpxfLE5oPl01+YlzQ1nelqturl/rV
         zreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732992070; x=1733596870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8EbHRN09/niG7ChdXPQaHzfNNZ5HMf4FMNnBO5LFSc=;
        b=AavyjlNAVtFyGj4CzSinNJD/K+pQzyUOLcvrM4gcWYfUEsTjufoiAx2KflDLppgrF9
         aUqKMFbB9O8z+eqUe3he3VthV1RqDXh3gE2oW0FbJRnjwQU1NpwnFuHv0EBkLXCfaUb3
         /5cXCUzFfMdZPzkdDCj0UUj8atdHevn5gr26ysqkJ6Ff693Q7cNpqzv1LFxazqZtMv68
         3hWuAVMbvIv4sfDLHKVX3EkyEiy6V4A+1M4s5CRwKvY8QiAf0kg2WSXjAYWrnreVd4RV
         Te7KN3As187AWi/LuWqVCEFPzXxmBC2vpDBrR/UvAsBD3fBKQhouAda9dBsPpcBfa+r6
         lY8g==
X-Forwarded-Encrypted: i=1; AJvYcCVp/pyxH4UmqyQ7CBUWWWwqJcvmpqNMp9hHC+1NBhWVqwFkzP+VUIqkKNnQAll7licn0BC46pRg4azXH0q7iBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GW9Ghc7ooPUhZRa8bHN3ZqqkDIpxgTIElJw8f6mVADbUPtcn
	sc4/PKvwkADpZnN/MMmQJ3nalkbk/cfaBwcfPPivc75RzxemoafK
X-Gm-Gg: ASbGncv0Ru+XbRBYfr289ZRpTHfk5Tt790S11Mjo3bQ3rBiXUmSLlrnq4mC75Jud0Bh
	0Ai2u5vKHFdk9HQ3K2g12c4JHjp3kfiWukPkWnDJTUQMJnuRVA+HP+mUGfSIu9u/UgdlW3nHsMc
	eAHN8zEvUmkYutnjamyUYOmv+hoRAJwfEZWa5C0hNYtrXzEzXAOJPEh60k7GPmM8rMTrVz6/y4v
	Bs2DT00AuaCUQfh2DXygrUbtNjd+IXrwrjPzVC7VUyLY/iZXg==
X-Google-Smtp-Source: AGHT+IH8XCHLtT0T7eeL7LoM0Ndae4RQqlbCqIrYuqpXtUkvy7sp2/rcZKWtBzZ6GWQ4zhfxvNjKVA==
X-Received: by 2002:a17:903:40ce:b0:212:4cfa:ba78 with SMTP id d9443c01a7336-21501e6674fmr205678285ad.52.1732992070092;
        Sat, 30 Nov 2024 10:41:10 -0800 (PST)
Received: from kernel.. ([45.130.167.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152751571bsm46715915ad.222.2024.11.30.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 10:41:08 -0800 (PST)
From: Gautam Somani <gautamsomani@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Gautam Somani <gautamsomani@gmail.com>
Subject: [PATCH] selftests: x86: fix typo in lam.c
Date: Sun,  1 Dec 2024 03:41:02 +0900
Message-ID: <20241130184102.2182-1-gautamsomani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the spelling from metadate -> metadata

Signed-off-by: Gautam Somani <gautamsomani@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..4d4a76532dc9 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -237,7 +237,7 @@ static uint64_t set_metadata(uint64_t src, unsigned long lam)
  * both pointers should point to the same address.
  *
  * @return:
- * 0: value on the pointer with metadate and value on original are same
+ * 0: value on the pointer with metadata and value on original are same
  * 1: not same.
  */
 static int handle_lam_test(void *src, unsigned int lam)
-- 
2.43.0


