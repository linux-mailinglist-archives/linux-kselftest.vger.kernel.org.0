Return-Path: <linux-kselftest+bounces-31828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6FA9FD91
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678A48002C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A921422F;
	Mon, 28 Apr 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KAFDD7Xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA72135C5
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881845; cv=none; b=kO/HzvjlY2+3cWCRjksntsdPIGYIB1/qoOpLqoIua9A11tiaGrRHLQCaQw7s5QRojj3MFxVEeZD3LWik3SLCWdyqogP8rIsWh4v/MCPxg9EVP5PofRNHzgyBMcee4ouTlTzuMyPvciHx1x6qQ1f7B3g5aU2ORhNZ4DtzYr5/9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881845; c=relaxed/simple;
	bh=zYkzn89KbbQhJnqGGqmLfnKEczTOQpEO0Hl9akuF+ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRqVjEHGqjqVOiLqK3qjFHozYpQk20CiW0zEJHltJi+i9IEiKb6WtWVH34Ie3DkGEw1sUt3LqxRF7Qtk8OKCiWzJ4aYYjknUlK6vOAMemff2wUGozFCESC21eIKQ+6Ss9P3t5ombqI2RfNnqXQ7i0WOQ5nOClk5QLizS5gAGMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KAFDD7Xt; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-85b41281b50so168680039f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881842; x=1746486642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLVSmwzlmchZcREq1TNVrtwTyqSxYv1rpw5fe1B5uZ4=;
        b=KAFDD7Xt5ImCRMzR6PGK8qfzJeEMF2QIY8VCAR1qa2KitrfFrmzCdC7+HF9CfpPi3n
         LXMjsdqfoqkvTvaYx9d558kXs+s7MUEJvkgrW6lcgTS9oVCsEsmPongOnPYKgyKmroUG
         7APnGvOy4pF5YkXiRL6i2rzL52G9AH0M2GgEqvktoR7UonXDTaUOi8U7OZ860BB77DRe
         VWMEKmD7xTCdRVvEBIAgMuPBBnnyB8Z1sLgUzMJAbWE0cH4Rot2Ia+gXEAISemIidij8
         kzJBElacK0bWW13wJklffd6LfSpK3lkhQJLwL0dOD0EAqMVyMRXusel8PCCNId5DzdXx
         HHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881842; x=1746486642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLVSmwzlmchZcREq1TNVrtwTyqSxYv1rpw5fe1B5uZ4=;
        b=SLnrVuXoVmG+a8GCsS12oVPvEBiO7O3p4tmIhB3r3YkR32qnPbhsG3GXNEBFACWPVJ
         UZ7aRZtBqnDZqJuOaJt3RLXUepAH3plcs4kEWrjueCX5JomrJ1E9a4Us1QWn4X++hA+e
         0BOWqegd5wnJWipTcdwJF+EGtyyo/TlpouMNDryngkdPwdhdq0afO61O4apoK/uSwJGI
         E94xriFLt+jh7hSX8Q4gWGbeBQiADTZ0CybqL5vgAuC1rbSx4OJo8TZqSZYEPphoCrKv
         r0tYWogXtt7Isypuoyvm/5Rb7ohzqZsqJp3TFlZsEX6/sG/2KamMt9QRBho6199J8awY
         Bo7A==
X-Forwarded-Encrypted: i=1; AJvYcCV1wEF9gmqrD39LB+vMX74kIFX+C0joIhXQNRWz9nFq7HAcmXS7KL3OBVymnhv1GlB5W5kBXqh4C2MxQVnvDRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRu/y4PRR23n6LSO5Qfeg+0UeXXaaJxNCJ9qUP3Gexl4Qa85m7
	SmRNbqFpXRKfPC3Itqa39c+6kmfpJYKvPPaPT+HxKiGlTRWA4CXuzw++wJxYiBmb/GSI2ejv/S2
	M5tSHs0jiSyLxp/gvu2GaqY9CaChC/pQ4
X-Gm-Gg: ASbGncs6MtIYzRafJ5sN9XE9xiXDriWDDiAbcZei2WA2CU5ufO0XmuRHbo0eEUdE8BD
	5GiWUK6OJzAObfqRiIWAcR6kUQSypkr9VTxMJj/nf3S2ze4WJEWVQNkWcUq0ZHJP5Fhv2oO8Nvi
	ob5WJQ7rAEBiY4KWXmPsNlDeNuAgQq4fS7YOmHVmD/Eg84FCtc2OXhgCtmkAvIwvdUdTRCSiWiG
	teot7uxUYJUD/fyUMwBMyWchSEreNrGXdbZMRKvcgNkuMNg6/75gNqQsJYgi0NHI+A+jR7IO+ka
	cklWaoy3xcV2BpxSp1ZA7+j7fp8TWr2TKr9O8JRljiuUHw==
X-Google-Smtp-Source: AGHT+IHTB/M1Wt//8i1xKmZoN1r7dW8BT4GGJKEo8aSzjqlVaNRWtx208jyBoTwQ70qkd+4ZLvbruF0uUhyE
X-Received: by 2002:a05:6602:720d:b0:85b:41cc:f709 with SMTP id ca18e2360f4ac-864887dc55dmr225565639f.14.1745881842491;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-8648bf866ebsm779239f.17.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 466CD34175E;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 42314E40B9B; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 28 Apr 2025 17:10:22 -0600
Subject: [PATCH 3/3] selftests: ublk: kublk: fix include path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
error message) if kernel headers are not installed in a system-global
location (i.e. somewhere in the compiler's default include search path).
This failure is unnecessary, as make kselftest installs kernel headers
in the build tree - kublk's build just isn't looking for them properly.
There is an include path in kublk's CFLAGS which is probably intended to
find the kernel headers installed in the build tree; fix it so that it
can actually find them.

This introduces some macro redefinition issues between glibc-provided
headers and kernel headers; fix those by eliminating one include in
kublk.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 2 +-
 tools/testing/selftests/ublk/kublk.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 86474cfe8d03b2df3f8c9bc1a5902701a0f72f58..feca641635d706a856898f8e22a630f5f47361b6 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -2,7 +2,7 @@
 
 CONFIG = $(top_srcdir)/include/config/auto.conf
 WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
-CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)/usr/include
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 918db5cd633fc1041e1e0805142f00e7e4f28bf7..4b943e57a890e5f14fa11dd19d67c4c8684c4417 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -19,7 +19,6 @@
 #include <sys/inotify.h>
 #include <sys/wait.h>
 #include <sys/eventfd.h>
-#include <sys/uio.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <linux/io_uring.h>

-- 
2.34.1


