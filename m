Return-Path: <linux-kselftest+bounces-10493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B378CB710
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62423287D77
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F77286AD;
	Wed, 22 May 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgJA0PAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E75695
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339594; cv=none; b=YUHR2LJruQGwbWpuNL+AZ0g8yQ3RKT6Il95+U2xWQyfLgnG6Tu4xiujFXDwiQWR8hQ69e7Z18QIVHHKPazvLimC+mKna0L56dzQMhn6j2lwDaIy1PFeBE/DVhy9T2F0Pbz2YbD1lK4gf1NAEvj0qoFlZ2TE6TK/FenVjUghXKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339594; c=relaxed/simple;
	bh=UPf02dbcijpdx0WyYDfzzs7QhNdmsal649qqGjq9w6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C2+2ZAi2lmkXDg+jqJLSX40+dKpq8J9ycNit5qTrQ73mpOx+Uzwje2IRlBWySSSFbkQLttIY3BQ6oMxojVT2/+UFVJA1qBuvacVnbj2qaB3HKgNDjvOkRP1/P4DSFr5TlMeHStFK8Lpdal8SIho1WfsLaT4V4jK6RMjL5RHrAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgJA0PAT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1edcfcaa2a4so128729725ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 17:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339592; x=1716944392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrpFzBzOl35j2xYdfjQDxhIeH3idaCKna/k1DUsQtzA=;
        b=wgJA0PATBK91/wBgCanA7pMOBMe1pSbbs6Q4TdpThd2ivY2qkAG4jYUteDD/7IZRMC
         DzJiy6nbdHsBTDCbxfmscQAn2ghZPHJClUobEzk5qNefj0tDGAm9Cc0awqxtB8bUZ4zs
         CBKbN1jpBPzRSMCo0jAuPVUQpBbwdt4Ujkl/KkDpPn2Jv0L5L9sX2MJJ14pwwQhYhkO2
         cb9m++dN8G1s+bALZvDgQwUuLlZSocpaX6qY5WV+1fJYN3RCz/8MX0Vty19tYUBgHPxU
         aMoi2R0wkjkSu67knCiAG52OEhQO/FyQPgQ7o7BAby83Ll47dPnp60APaGfZsA/r66Sm
         z3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339592; x=1716944392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrpFzBzOl35j2xYdfjQDxhIeH3idaCKna/k1DUsQtzA=;
        b=MUJjdrBVdUAD9KcuTEj2rsCD2pT4RcmNnN1jNv5w6LI0wk34DIvByLo7EKBA56MzkC
         gDIPxrwFfZ5MY1XMkERous7FAS/3Zktzr4x300k7zd+dL4BnYr4DfezOKE+m4/AQwr/q
         W1lh6XdS9I7l5vND/a9HCOldMpIJsHadMFbEcBUYcAajbVyyl5hSb8locO7ECNnP6ONb
         5/mmrcEZveEj8YcLti3u+m5a7KWiAqRHZrtJWy0VNgjscBFjzC8VzbO3vqKIAVC9M7Ux
         eOXlX7//PvYAITbwjQydzlAHm/0KhtT6P1v+zw8/wnXZb/yDXJyE5rLquq5bB+x6TTOx
         gSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxU5Jl39cjnrwCrjKq1TIxBcJMDbbAgBFRz+M9mwEMqXWE9CyuO2je6V+AhqNB8Hwb5xodp99ELs3W1CTZ0VvjFaC0KKKPxJTzQh6a+S5
X-Gm-Message-State: AOJu0Yxvqy219JT1sMTjsL2bgJY22IMS944ergO7vPjDc+1Mjf9sjVIU
	rlF5pk4cpZrHxEn+W9U+fEAGlh6UKI16LweiOaac3Kw0zCYo+jT3CtMhfKB5kXut5LIxpXH6LLO
	W3g==
X-Google-Smtp-Source: AGHT+IEoluKrJmOyFwoaPpDSDecfFtDU30gApMNSHC7b7ZSfhyGyK+abS6RqlmYIGQxtFLFdPmJSYbqqJdc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:192:b0:1f3:35e:7dcf with SMTP id
 d9443c01a7336-1f31c94c59dmr524115ad.3.1716339591969; Tue, 21 May 2024
 17:59:51 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:52 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-7-edliaw@google.com>
Subject: [PATCH v5 06/68] selftests/breakpoints: Drop define _GNU_SOURCE
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
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 3 ---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index e7041816085a..e5a95187ac12 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -7,9 +7,6 @@
  * Code modified by Pratyush Anand <panand@redhat.com>
  * for testing different byte select for each access size.
  */
-
-#define _GNU_SOURCE
-
 #include <asm/ptrace.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..695c10893fa4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -2,9 +2,6 @@
 /*
  * Copyright (C) 2016 Google, Inc.
  */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog


