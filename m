Return-Path: <linux-kselftest+bounces-36190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E03AEFC18
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736FD7A3F08
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE15271A7C;
	Tue,  1 Jul 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViIFP6P7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4051ACEAF
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379837; cv=none; b=JPE0dY8FFisQCyUIt0+MkveF4rrX1z25PwqwtWB/8sTxK8U4mVkF7R69Lwadtww1MP2rqOH85w1BV+ybKu/AOMA+O3YL9JonihBqRY6QPrT4e9p35DqR4b5iea8JI6qjtuD3WuI1gVnYtPd7bmxHoZE2C86wKlZx+ZQiC05BJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379837; c=relaxed/simple;
	bh=+VE4TCzGJURgbHPgDIzyyLaVIBkWuI3nGjmFanUKRSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZACpMIcoma/yOS5tvIvyL9l1reDAhkgTtpx1zJbuvmsCUwOr8FwpuAbL2kr2etryVOYvrYJFJdufFH87Wt7BQalJv0eqd4vn8mYQeWWHbZMN9/1MY5c94e9MtrKTZ77e5LOHOolk+6H3Qn/fFz0lGy6WEdcF86zYKQIGMa0nBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ViIFP6P7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb79177so34300195e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751379834; x=1751984634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=toLt0hf1fAXobiMf5wHPfZnxScTMui7YVm7oyxfvX3I=;
        b=ViIFP6P7m88NBC0xuj1n6ahbaZBfcPHu9Zz5VL9GAmMcAxB3YIed8OqYu285/xG8hR
         9iYYBQr6KRsTVkjHe6gTMb2wwoHTdSbVlc9HWycsfXYc62lhqYWUTxCOqkHm/sL6OnZu
         jNNekPQ1Nwr3ZIqqxdV+Mkd7mlskBtW5KxfPmvscbJxeWwQ3UcWmtgoVb1Upj6yX09wO
         a5nh7+B7sIfqsNWNTyFXMu5a5tarKY2SkXYGcbtTD5Ox3D4eELWzDKAHqYXBGnKoZY74
         vC7OlgShbhskIbCun1Kz7/wDyJ/JI8k621IESa0Tb7qR3x/jqrU7XvLFrM6eDIdZ6gIP
         +Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379834; x=1751984634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toLt0hf1fAXobiMf5wHPfZnxScTMui7YVm7oyxfvX3I=;
        b=RO6GfwCiQb8oHyrzYTpeGZLHlIk+wMthK8Q0i3yXRibXX7ZUY8kX1blZxf+l2cQ3Zo
         7w1fFn5/yN7JJoga/5ND7rrYzkv3cL/lYgJMR8+jg7jZyG9cv66CS8A8AWKS5nVplk8P
         jy1pGc2GetxgFmI4DQ8sDa9zPhdwPtCGXet373ChMaqpu+gwhmWZXyzF/V97nP+Q/b+1
         PCS4H+cXZzjKWg1/wDajMwNNtxIfwZJ68V2VrhgcKJiXqKNIPAkW9sv6BYq+SS++2WEU
         p3z3WTH/XT1DGZIenzkm3zSAI5rTEgtlxA5/UQsY8cCKuRKj72ZB/35TFIQsabwsDtq+
         b61A==
X-Forwarded-Encrypted: i=1; AJvYcCV6ks1pzEZU1XIOFUKXLQA8Sd705qjAamJns1L9mWPl5LjJ2ZmzwwP+BnBXTLGNbL2Izy3EXgdsH9FDJLPAWVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAYL9cb094IHjgzv9R3oX5vE4g34hPqtkHZiVXGvr10/7/w+W
	Te/4IpHYicx76Yc+Yi5DEwcYM5imJhmClVY0rOJ+qfM5KGzVdTD8zJdxTrA41jzI3s0=
X-Gm-Gg: ASbGncusg4lOZsBAcgUCfTixVU0/iAHuxus6GP8bMnZ4ot/Vse7EGx2Kv2uQ8CAc0OX
	wxwy8WiqgBUSswpHlr9Ow/6qZCf7Sk/Ktj+p3l5J3Oyggj1385fdj3aJ/tp1vCBtllO0XWbBfTk
	dDfWILkZdNJfGt9jtpcWCs+428qAkiHKvLlncY0wFK85/GmIU+gRz+/4TlgkVoTih9vXM9iZpqB
	N8vZV65HShnX7t1rN+waeD7OhuzaF27wgbc0tKGq9DenoTKWHvr6WMnnhGgktgY37NpZopd0aH1
	eMjV6QXYcEyaHqG7EzUwEHonXVjjAOVurjYOx823gZwf/0itvJgVsy/TOcXDLINKjjDRjD2uvQ5
	WWmDaxF+FDcR6gbVqvm4rT9Eb0sLFeWeWNmXGfrBaUr9Ui8QFL8aE+uviOrSVHdzWg2oL0JizZR
	ix1CXDOA==
X-Google-Smtp-Source: AGHT+IGTLLbODxjuif7KWW06klmOqjZTL5I9Y50BzMnkjWGM8tznX7/PwBgougIazzrFxhs0+pT6Dw==
X-Received: by 2002:a05:600c:8505:b0:441:b3f0:e5f6 with SMTP id 5b1f17b1804b1-4538ee62345mr143258795e9.25.1751379833739;
        Tue, 01 Jul 2025 07:23:53 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe0efsm165504815e9.24.2025.07.01.07.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:23:53 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>,
	Wei Gao <wegao@suse.com>
Subject: [PATCH v2] selftests/futex: Convert 32bit timespec struct to 64bit version for 32bit compatibility mode
Date: Tue,  1 Jul 2025 15:23:13 +0100
Message-Id: <20250701142313.9880-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Futex_waitv can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall in 32bit compatible mode.

This fix is based off [1]

Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]

Signed-off-by: Wei Gao <wegao@suse.com>
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 .../testing/selftests/futex/include/futex2test.h  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index ea79662405bc..6780e51eb2d6 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -55,6 +55,13 @@ struct futex32_numa {
 	futex_t numa;
 };
 
+#if !defined(__LP64__)
+struct timespec64 {
+	int64_t tv_sec;
+	int64_t tv_nsec;
+};
+#endif
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters
@@ -65,7 +72,15 @@ struct futex32_numa {
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
+#if !defined(__LP64__)
+	struct timespec64 timo64 = {0};
+
+	timo64.tv_sec = timo->tv_sec;
+	timo64.tv_nsec = timo->tv_nsec;
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
+#else
 	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+#endif
 }
 
 /*
-- 
2.39.5


