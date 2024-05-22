Return-Path: <linux-kselftest+bounces-10527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615848CB7C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163AA2836E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7715278A;
	Wed, 22 May 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpjQbmkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32B152527
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339690; cv=none; b=NSURA2Bq+BCNZ5SDiWeQslSlcNnEOiqOIIGhc9QrcbpqE8jH6SD4UgJ3Y1bFVsI6Sa4yWeXVjFdK+pbPqjaxCEeLqTAizzHUCTnl0VHpPrn4gHJLNw6BzYFpBqS5R8mAvFqh75XXqDWVplziHowPID5vLtTEy/eulQaBF/GScbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339690; c=relaxed/simple;
	bh=MTodUmyJXfHVVr8W8CfAFa090pYkk2toySoZR7GP0Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8As+FJmoILdUCHQtHu/tl7xxWT0D/tVkbWYI9fFm4rk20nQiNrXC8l4bZfvtLDZ6q3wL4u6GgHvl+ksbSkiLcMqgqTzkHW6//5K5snD/A7vbI6ZP66O3o25MKfrwm/nGhwrydY3WH14Mn47SKcu5JjjmVIJFh+4yDV2nRD6sgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpjQbmkT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-657fb8090eeso6651649a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339688; x=1716944488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=bpjQbmkTWaWVeuzCDTW+k0z0Sc/34//f98QywBoVHiEkYGVheUN/9zulbtJzWqHKIk
         8hrEM+42/VU+WOvB+wvvpstpx8eLYardcMhgBz5Bk6LQm+6jnOwiAx6wh+qo9zGU4pRZ
         RSYrVC9SqDNXwurmulO8+j3SgIHEAAtQGZ1lGKSIafgS/RZzr9yk9K4T78vsw+3qiP2T
         wL+KDgOz7KnBA8jc2Oo5jdNNw9awIWiZ2ehAJB73IETttyfMmaO/zcVJts0JR9KCCPTx
         8R5YyuVWPsvDOPikjCBErdaB+1zuz0DhfFnAJk9kO3as/452sz8qaSWKuxPGDYzgq8IN
         fhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339689; x=1716944489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=uJA+g2xTIPwBsCg+WMglDwytUf1y39qqmaIhzri1XyJIuWkmSzRp+LDLY9kDFvvYZa
         AYUiq7Nhtlkk4etR+aq+GA275JzG11ilioo+A0PiN5aOlfsRgNlc3vOuH183QEW2yMNn
         tjxzhOJyfSsmaPI7fxvJyeAiCJ1jgnO1E9sI4dkD8EbpKWJSyOiap2fVMnSAP0KtFW0J
         UPYTkbFDfxARJe/By6vpBD/VQSiDOp788LpOjZ2/HzSxjMd9Y66ipXEd8ltKS/e8rRo0
         QCGLEIE8frtMm40iduUC3wdXEzukzDlYmdTYTwc2O9f6U0QnmKiBZMzalOp14iVlqfWO
         uB3A==
X-Forwarded-Encrypted: i=1; AJvYcCW2MjeHFahmmivbHPbp1iMBYz3b5ipugOBXkH/oV4shpoHOYmTd/4eQh6Dh5Yf/1YjRI7mZMbMmeua39U+Q58puFHoAP9C1XNl02pLVrpp0
X-Gm-Message-State: AOJu0Yy4DeEvgoL9l/hyH4tUVzIEljcz+F8QQANl6uh8jIgu4GhV2iNM
	laBkRWs6EU7vuiWhoczubsK+puMBmnRTX5v+hh4y+2q9b4dNOhnpVdRPFl1P2Q/UqG8Opawg/JA
	MtQ==
X-Google-Smtp-Source: AGHT+IGEcjqj8zufEeTMy6AMcaIsqkRg6a51FGXyadk70W9VXPBiz86Gg8WH59rMqAlu/ildvCYIItBNoi4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:dd53:0:b0:658:956f:9800 with SMTP id
 41be03b00d2f7-6764de8cb6fmr2228a12.7.1716339688506; Tue, 21 May 2024 18:01:28
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:26 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-41-edliaw@google.com>
Subject: [PATCH v5 40/68] selftests/perf_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/perf_events/remove_on_exec.c   | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c  | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..ef4d923f4759 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..14d1a3c8cb5c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..19557bd16e9e 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/perf_event.h>
-- 
2.45.1.288.g0e0cd299f1-goog


