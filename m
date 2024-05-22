Return-Path: <linux-kselftest+bounces-10529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE238CB7D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1451B287E25
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E55153560;
	Wed, 22 May 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8wCK2yF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3B1534EB
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339697; cv=none; b=f7imIM1orOFbbQMR271CoQZiEofKA67vbKNW3kn5L7CSEtaFzT1f2KgiyQmcG9c67KXWZyPPTb+OUkN3XhK5JB6uc6/UqspqH0NB1lvjHVI7yf1NCcRs3hhEkTibE/dBDO2FJD6vj6LRY5lEhxNlD2Nh2/B4BjrMhdd4pdHScQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339697; c=relaxed/simple;
	bh=NAJYxqCPknYhqA3yyvXxPpoo15475nrhk+HBgIL4eTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=re/m8/THXJU34xeHELlJtnApwzGMHX6YICh8HBeN7AzFqOMypYTi4VTgzLHo6leZ50Th5xTRVE49vGoo+jpNsv3Walcyslc4mgkMIY8euAVb5gzLIZ0IbgloV5ei4aq3bHZuIbevepnZDdL3gM3Rtrrq2z+4Z0jr7hDDWiP1HLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8wCK2yF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee4e9a73a8so138153465ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339694; x=1716944494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLnRSS+yUn+MQ4n2AryJR9rl6Su/0Qm7BmHquzszBTA=;
        b=C8wCK2yFHWxzDOwhDdIzshx/CX44D7V5ZUOFYwpjNAa7Z9Aj3kTBT5YYptLlxkjsVD
         KRpA9iy+GVXnxobElm8srNyEkgwXOyi/QGBq99RlLyO85avKFjo+gaumOpoPQMi5HVtp
         EP5g49nN3IWUMgdJ3JvB3m4gmurWWVXwlYCaK5FhBQlgihqyt9FUjABCL1HXHzxBV1NY
         YGogr9PtU0wjaDxFstVj5ECUmqhQMDQDXg6XJxLpEowl5q0fXT8/X2LaSlUzrU056S/0
         XDRRvDXjR27Yo48bPFWtizLVx64ChpKuhAC/6xFK/x8CL5hs0G8h2F3NgSdwsRJSSqGF
         rllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339694; x=1716944494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLnRSS+yUn+MQ4n2AryJR9rl6Su/0Qm7BmHquzszBTA=;
        b=X0tJ3PAFtKGkRlojFDUl4gXyLVzAt8KAkVAld6oxXfv43s1RWhjSG+QikBFFdoACxL
         tb+CPLHaBTR2etekEQQ5YDAIp+80iZ8rfxMIQLoOtcQnRpaYwY049RvywfQjsrjr5K7c
         mtHGQPFxLXhuzqgjlNtKK8Sf86jW8IWnd/mOl3kNGs5Z2GNzEgv5aCZ2NKcBo8gkmZK3
         +agBxWwllTH6LVmrc5Iar30RfuPfOsNGRY/lHYOtdcjrkiRxJWTyWGG2OtKyE5pcBLHI
         4K775BVyPSzKGwblq7pQMEWqM/QIhJHscF4VspGr7K/aQTpD59oHSHl0R/7iI4m0CVy1
         i/hw==
X-Forwarded-Encrypted: i=1; AJvYcCVBa68L1C6HN5PShbpCwfHnqm3n+gRBThahj8HhDhUAEGLdQCLnkYB6L6J3r3+zsbLZRTIw9zPETic+j+X+IS9hLbBwY0uCd27TXAK3ea2X
X-Gm-Message-State: AOJu0Yw62Ej/QzOmBsdIJOI0Q7sf+WUOSDcPdo1D12uboXZractF+ZO2
	PiS4/XoNIFf7tWUht8tF4fKf9koOvfVMHxUKDrbfKeDqWFwbggM+zgHmtsaHD3DjD5IER3/quJq
	g+g==
X-Google-Smtp-Source: AGHT+IG+8e8TBZZn3utok5/p5VNTf5xnorMVZ83TTS8mYS88H3TfUbRMjUB57+emmSy8pkL4qV3IXFBaRV8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f7cd:b0:1eb:829:b6e3 with SMTP id
 d9443c01a7336-1f31c9672a0mr174615ad.4.1716339694571; Tue, 21 May 2024
 18:01:34 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:28 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-43-edliaw@google.com>
Subject: [PATCH v5 42/68] selftests/pidfd: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pidfd/pidfd.h             | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c        | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c        | 2 --
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..e33177b1aa41 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -3,7 +3,6 @@
 #ifndef __PIDFD_H
 #define __PIDFD_H
 
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..84135d75ece7 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..b6a0e9b3d2f5 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..f6735eca1dab 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 55d74a50358f..83af8489c88e 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 47746b0c6acd..518051f0c3a1 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..53cce08a2202 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 0dcb8365ddc3..54beba0983f1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/sched.h>
 #include <linux/types.h>
-- 
2.45.1.288.g0e0cd299f1-goog


