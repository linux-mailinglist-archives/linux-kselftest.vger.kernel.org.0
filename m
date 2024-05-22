Return-Path: <linux-kselftest+bounces-10507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAFE8CB75B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1571C202F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA21474AE;
	Wed, 22 May 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdTClnEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B8146A6C
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339630; cv=none; b=R2uxc7ASUDgcwHNA18leqv8a7TNbGtzMx2jxI4a/kLHtcwz7YAXmJe0DJMizuaOOfY2PTLihR5ZGXvMqEdJ6Tab499rowdigidIei1qEhvrI2n5lj/Zzla/mQd8CETK3iK+JIag6VKwJK8HVaQn/huyq0xOwe4lLb1fMrySJMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339630; c=relaxed/simple;
	bh=Ct0Oc2HtbbTeGYqwAwT54uZjMuIOV6TtzJ5jkv+HoWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k+AJsksVQRVXG8Sy0wxxQnTPywkpsbZdjfUDG4AxgeO+gnn3Xx9lJqnMvFYvM+PGrrSnvdMHCqS6f5GoBPR7vBZ9HbmG2mwqiU1vwTPpU6hTvYC8gxDKCPgpM63trtJZHkJC2UwTkTrknvqlrZC/mrT+bei8Xz9VFmIfp3N95kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdTClnEu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-67631fbc1d5so200132a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339628; x=1716944428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DziTrN+GdHrDDu0b2xCQRkg6aq3Bg4PfuS8x+kzAAOY=;
        b=QdTClnEuyELh6FWkQAfDZZSZCUt2LwbD+85+I46Md6zshsoFN/5Nh11VnXpc1d7abX
         Hhl5n3SngENyFPSVA8Sjcl9p91ZVPiK1PPUN9Gr0p9v2sVyF7OqOGC9Kk0Fm57L9v58M
         3zXRm+6EgCy1gZNR1txWqnVqwAFKo94/FspUA3J+zM5On0o44lZT2FvHiVOf+MzJGZQz
         ZWgffbCTW8tOyWxQDEDc8OBjVXYcxbF58Ib0QV5zzWLoVFBbv4dDd0J4cQpeGo+j6Bx5
         DCSuSHssE7b/zbJLTQldORfYH1tNM+iOw9MKyOcabEPMRfj9qYIkFUsV0MsJcoKvz+ja
         9YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339628; x=1716944428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DziTrN+GdHrDDu0b2xCQRkg6aq3Bg4PfuS8x+kzAAOY=;
        b=Ul+GgS/ehv5HCuQv5GKjGpOwwQYOKXhbUfKFvmVsd9UdrRQimVvjbnM6MAZFe+CRZ2
         GmIn8BtxQbquTajFD3H+kzQ/Os7hMxrprxUAn6cQ6ccWTyzM7Ww3MM7vd0FUoiJgIu1S
         2wlqAy6gvhA8z5yoQQLMi513JXkO8fWChLH5GSx1EehLQ00XslPjUrd4c4yGfXBFuFPz
         b0yBeAjyheIeIJhHh/uiP3gGRA9l/Ddzn2JUoRJOMUKBpaqjBOUOn3sTxSSNwJmm0C1y
         dYrBxnL4QsQDMLu/sy5KsBQ6PMYdXVOk75dKNLJ/9mE8bEkJ3XssCgTpPE6df6RciKN6
         9sVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAp+nFeLuvI7KK9sBRJ2vFgn7Ho7VA3bHf3XAsAq4lpmUuvwkn8NErwTu8I5WV3GL2cIiPPgf/gnDq1xenseXPxn+zmOrhhL7JoiOPWXNX
X-Gm-Message-State: AOJu0Yw/mJjlapW3fQAYtXRbpsYSNJuaWTKFHMYHVxen5WCRNpLaXdhl
	FClYIMMyA39CyrkajsQKB7N9LgkDdWPUxA8nH6+34Kr0OT0rIStaBtauIKmrqyjB8YYQvSKESJb
	Ggw==
X-Google-Smtp-Source: AGHT+IFgwS5SmrnU+8gmUbVy29pAPQw7ZKiyJ7SJwcCOOTLzFKbZfEl6jzxNvPo3fpwYrrE3JFhJVx4/2uM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7250:0:b0:645:571c:52b6 with SMTP id
 41be03b00d2f7-6764eb14050mr1133a12.12.1716339627896; Tue, 21 May 2024
 18:00:27 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:06 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-21-edliaw@google.com>
Subject: [PATCH v5 20/68] selftests/futex: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..8e41f9fe784c 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -16,9 +16,6 @@
  *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
  *
  *****************************************************************************/
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
-- 
2.45.1.288.g0e0cd299f1-goog


