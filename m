Return-Path: <linux-kselftest+bounces-39337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28606B2CF5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 00:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C056B1BA4F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0533054DA;
	Tue, 19 Aug 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mHyKJEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C03054CC
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642592; cv=none; b=M9Hi7kedC3ff1L72vQL9vtdGxIO+GH9uo7fiZ8PpsbBcAMKcfAJAJ6zHOfoL/5SMxxezrdLzAZRiwui0x8WJJ+K1HmpYX1ebPUUACDmYFb+g06YzaX0Aw7AhcpMU62ZFVmnAdjts2IhDBfmferuzQZmzMRBJEdc6Ge4qB7cnieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642592; c=relaxed/simple;
	bh=dxX3neWWzgYZ3JSHle1PX7pHgn7clNpX/nC036Y65qA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XFZOCJHbmUptogrd9caMOM+PEzXL/EYaCP/lNQ16lF17ogCfgxJU1nyMco+bt+LkPvOPixEELdBtd9KVyTLUwcxnaD9T+ToTKobHY/KsNICmiXLvQ8McYvYBItI2widzRioEDVC0Y2XkGzb0xYtpTPTN87daPAOGnLzJFItaXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mHyKJEu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266a1e87so6069857a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755642590; x=1756247390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/yuQF3NDibrCV+Eakek13HGyazhOkoQzXCiSemSH9A=;
        b=4mHyKJEuiTKDBnRLegz7+9wJoU0eTTqpw5vUQfDtsbGxXwrXEourufrcpipbBJYDZK
         5wVvqQkdHp5Wg0LRBQWOjH7gL5b5OuXq4zCE0sGJ5pVs1X7rzME2boiAWlA1xGiYfOQk
         5I4LaKvYjkbcRI13gjgCBqa1tC+Oik1+A3FL9XyvqfJ0VA+Uq6ZL4AnpOasblnpzykQU
         DfAy7p5ZQ5bnWrUx6lhTtz0micYv5C+VLT1FK0qNx56bB3INqi3krpz1PEHiYVCThBER
         QENRsafdj0fhjDPQMJ6bAz6m3JTVPgodA0s4Nt0rvL6a+0WcX08ypXmwjT7KaEaS6U+P
         864A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755642590; x=1756247390;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/yuQF3NDibrCV+Eakek13HGyazhOkoQzXCiSemSH9A=;
        b=mDFOtMkkgEssn+i1eXMsstijXFN80BNSFGftvPW+ol1ZpYz5Ixg14UeFtcXIOH/8xl
         k7ekUti3atf//IsdzTLZ5LbCzsaAdIHtYYaNSImXlIFQL9DasO6j3shxM7RyfkOGuG4Z
         ADI6VsBURnpNLhSPasF8Ld9WkUL/Zifi/VBvVEtzbTM110n1tbhIhCKE2bt97q4e6Bc7
         cwr9Zle3I4xvZXFeeOELC3H+CrybkmGqq3qgCw8HPUfwSVF852e5+jmrfYknblDdLMds
         bx/JZHnPbKB5aIooOr+uY/ou0+xGREZwICZH9SMrErybbjBrZIL4KoV5taps9RnXutr1
         wA6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmNRafzcsfydZb+sYQK6qzBthp3c5IRzlyCGvZ+kAomQVtJlqdzwa36aFnmoI3nCuRWO/9tayx76rsWviEcPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbRokQ3MVLokz2vAVBntiMGRLq4HJ8u0SxOTm+oxzpg57G0xC
	TMTV00Yyrkc+m56JX3BaJkOK45kXpdwQ6xlxM6V+ArznIGBlLOVewyoMa+ZFaKYzSarorciI108
	zZY1GQg==
X-Google-Smtp-Source: AGHT+IHnXiQclQBWqGPkN2h3vJjstq/7V+XZNMXqHx7f/8NepV1MCa5SFMuKI6yxtQydrAuu2kuDLCqcQoA=
X-Received: from pjuw7.prod.google.com ([2002:a17:90a:d607:b0:31f:6ddd:ef5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48d2:b0:311:c939:c851
 with SMTP id 98e67ed59e1d1-324e1291c04mr1027335a91.4.1755642590447; Tue, 19
 Aug 2025 15:29:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Aug 2025 15:29:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819222945.3052711-1-seanjc@google.com>
Subject: [PATCH] rseq/selftests: Use weak symbol reference, not definition, to
 link with glibc
From: Sean Christopherson <seanjc@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add "extern" to the glibc-defined weak rseq symbols to convert the rseq
selftest's usage from weak symbol definitions to weak symbol _references_.
Effectively re-defining the glibc symbols wreaks havoc when building with
-fno-common, e.g. generates segfaults when running multi-threaded programs,
as dynamically linked applications end up with multiple versions of the
symbols.

Building with -fcommon, which until recently has the been the default for
GCC and clang, papers over the bug by allowing the linker to resolve the
weak/tentative definition to glibc's "real" definition.

Note, the symbol itself (or rather its address), not the value of the
symbol, is set to 0/NULL for unresolved weak symbol references, as the
symbol doesn't exist and thus can't have a value.  Check for a NULL rseq
size pointer to handle the scenario where the test is statically linked
against a libc that doesn't support rseq in any capacity.

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Cc: stable@vger.kernel.org
Suggested-by: Florian Weimer <fweimer@redhat.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/87frdoybk4.ffs@tglx
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/rseq/rseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 663a9cef1952..dcac5cbe7933 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -40,9 +40,9 @@
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
  */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+extern __weak ptrdiff_t __rseq_offset;
+extern __weak unsigned int __rseq_size;
+extern __weak unsigned int __rseq_flags;
 
 static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
 static const unsigned int *libc_rseq_size_p = &__rseq_size;
@@ -209,7 +209,7 @@ void rseq_init(void)
 	 * libc not having registered a restartable sequence.  Try to find the
 	 * symbols if that's the case.
 	 */
-	if (!*libc_rseq_size_p) {
+	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
 		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
 		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
 		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");

base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.51.0.rc1.167.g924127e9c0-goog


