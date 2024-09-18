Return-Path: <linux-kselftest+bounces-18092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666A97B67F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 02:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA81F23B90
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FB3D69;
	Wed, 18 Sep 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp3B7gNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4944C74
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726620468; cv=none; b=if7EhkdriyiV6jVLNqJXfahzBJxA8YmBZP2XlnYwD2E3l0zguX1YMFGpznuhGFujMSjO+kXS8K9q6JLvNvQPTSBi/v3zvnWU5EMjnlEX+qP/eI/x+IOhiAaplRo/wsnaR37ClhaabPSUSA3ZzH/66AEOUCF2DTfNUF/UF63HUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726620468; c=relaxed/simple;
	bh=8ChpFh5J4k5VwqdplSAT7N6qPCDrU9/Q/Mw3nspbKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSEgvcJiP4ERa9Bh7/V0ZA6E+5g7k9Vun5MUUZG7wb2sMFrz9P0iu7xrTEeDa3H70tFf6QJ48DlNgik9la1IzSggpwG3KNfKnPIQkO7AlCXMY7Kz/uD+1Ml6ZmqjbP6Bw322BnJtPAVEeup82tqB/oYDk5pxun7pfypLXwI6L3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp3B7gNJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e11e4186so5929849b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726620466; x=1727225266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XmfhKZipeZYEXwyrzffE2tPQZ0P1qIBiefj4zYSrI4=;
        b=Zp3B7gNJwktjdv/fekr1z5f9VQpGhtW5IPSEdwJpcJsHbpTHAGUmVYksBQeuojq6a0
         9hGPkh2sZP/b7004qwa23d8eDCBZ6w0jUNAiCL60xAkKsX0EaTgs1REW601Udmbey6AF
         mGNHhrzpo9NKghmNpE3/4NngmgnrP8/80UyR11bq6WnTUZ/YUCZoS/8JQy1DBRf/YxcW
         njRvqJXkE2rNVnDv34emgiMuJEhoY+D9XwkIhqEL4sk+/9/zVSVcCOtX5PT3X1FBBZUZ
         8V8os7OCxF0pb5V1BR2DSLvVj17soeO1AsVYMOhomsMD+CqwpKt9fEd8oTVLSCtZOCoh
         5BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726620466; x=1727225266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XmfhKZipeZYEXwyrzffE2tPQZ0P1qIBiefj4zYSrI4=;
        b=gLDu3TINkRtkQeSCEjMcP89eULjfC2mk6WagTmbYlatIyd4HPMMUK3jYM9rjvGE1ak
         1hpwskD9fAsZU0iCov4DW8FU/JPa4J6kUtjMnZlnizHK3PGxxtEB/RhU6NxX/Zc9N+UP
         WthD2eHUcbjwc2u0QkjlfIMId80Eo+hw4CdClgXOPzj+iPWWtjiOZ4kgebABW4Ups58q
         Pnj0asomd8EI1Q1v6GPK1TTSIJnfHqHKZ/vBuPYm28/1n802SFC9QU6ni8aVQFuMP+B1
         P3a/klPt4mNey/Wd35kh5lUZHSHd11HmY87rOmW3IPrHtDRP4gql5+KcCCXgbL+FA2HH
         TbGg==
X-Gm-Message-State: AOJu0Yy15uJgdJ1J5ciku6Q8Zs5VJBF5BIasPLB3DMNkBafBIfYAdDJp
	wSZNZSHw6eZsZVWi53mD+o9pwicxLePkNkLSFh8YBgfHSnfF/1RzdgVZl8oR
X-Google-Smtp-Source: AGHT+IFCNegLK48ZHARRqZnGMAN97zjlfEVjhROT8fLZkttdYjICun/cFySnKY6QJiYWMZktMRRf3Q==
X-Received: by 2002:a05:6a00:2302:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-71926091b7dmr32981375b3a.14.1726620465649;
        Tue, 17 Sep 2024 17:47:45 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::7e81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab9cb1sm5718010b3a.52.2024.09.17.17.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 17:47:45 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>,
	John Stultz <jstultz@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests: timers: Fix clock_adjtime for newer 32-bit arches
Date: Tue, 17 Sep 2024 17:47:31 -0700
Message-ID: <20240918004731.3295870-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer 32-bit architectures e.g. riscv32 are using 64-bit time_t
from get go, they have not wired __NR_clock_adjtime at all
valid-adjtimex testcase fails to compile on such architectures.
if this condition is found then use 64-bit adjtime syscall

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: John Stultz <jstultz@google.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d500884801d8..ff4ff8b1d127 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -39,7 +39,11 @@
 #include <sys/syscall.h>
 int clock_adjtime(clockid_t id, struct timex *tx)
 {
+#if !defined(__NR_clock_adjtime) && defined(__NR_clock_adjtime64)
+	return syscall(__NR_clock_adjtime64, id, tx);
+#else
 	return syscall(__NR_clock_adjtime, id, tx);
+#endif
 }
 
 

