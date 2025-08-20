Return-Path: <linux-kselftest+bounces-39370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EBB2DD18
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB873A16D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A4308F29;
	Wed, 20 Aug 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiIFpN8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DE2DCF58
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694382; cv=none; b=iPr8OYpoBe8OrDvm4voQKkF8u4wcoQLTfFeffUtJApNulRi01JW3y8AiNJPmx4nk/oAX4+MCPVWFObVIaft/nAaz2Bfy4KBtbdj99CjL0lU01i66wJk9Lmtgra8F2J7q8M5rRCcwvdELiTh8XQ3wteZa/DF5bhj0vi6C/3GSLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694382; c=relaxed/simple;
	bh=GG4x+CutKMR6WqOK8NkY6FdnesLerID/jLDBIE48Uag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RX9N0vdBwAUhF3Qk4+MhNjISYB82pP0WwWc+f9Wa1bsqknfVmdFajY7bNxOYC9BIFgxZwmzjNzFzPFPtNMvvmVXrmC8AYYlJSVd3m5QpQeQ5gSJgOGpueyUGkCz9afWwyfkygxKRvcNLxIp/znAoqcxdK4wdd9C1Hg4rHuM5Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiIFpN8a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267bcee2so6186959a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755694380; x=1756299180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8tQsJtbOtmViZK75zDsxOA6YlL6q69XluwQxXqwuqg=;
        b=qiIFpN8akT00PY8gSH6tRFL/ggIvnzGQWXD9jlJgET0SPWgYxGdwIbgU1SIqNs4qFm
         vOmDdV/iBICKL1sn8QQN+weL3MX1NyvRkTYf/nOL4rmAljkF7lcvPjSzrRm1b8ztiOon
         M6YNR5GS+hl12M97K6ikeuEtErayqIlB5ffcTe5esosT2/wYt/0gHSQ7EYbYQ85YlYNq
         H4koVvjPNY4C8GHR8/YjsK01wnU89YE5vlRO9h05AavC8JvUzpk7CN2UK26Z15YSnWeh
         VCnDwc1jeEyG8Hv33dWbbC4iYd1SSbReqFJyyn9OPOJ9fAf6mj+uATBLWuIjXFBdWUVz
         oJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755694380; x=1756299180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8tQsJtbOtmViZK75zDsxOA6YlL6q69XluwQxXqwuqg=;
        b=eufDMnPiRkwlkFYCcyKBdARwzixe4yFRlXFicJcwYsAP/jZr/vyG3+Puip0hZMWiwM
         nbG2P8cu6lcHzfYrDTIBE97yhNEhekRWC8/1NUEzPT+eva+ZSdOM9fz0X7Cf7Bwgi6As
         qvEZnkQDMiZ1n+QDEtdxav20zWpOnj+Sgip9hRUctmRoPAmBiWs+IeViiV9hTbCW1q96
         kJxE6QbRRZcAa9xypauXiShwtxYLLL2weGUEXlXv5Fsoz/Li3IJePwef5NE8tZJDEUK5
         RsyNHVpH80hGUwtNpv2aUZ/jSOsAWF1bL/qbPDOgvFjbI7Ektdpn3LypJTajTeKHq5Cp
         Z66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3Qe+fVWIi8M9Aab9e32oMN1Tvddl73hNAyHJm6nL2Z0hWu2vPzYshmpI0eJejTDJEBExfx4V6diTYYQI8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+6xz9/rrJ4XnFcE3KAavPL5bBLVf4u6cDhpM8zez46HY0lSD
	0BJxbnCY2ZF9hPzFFa28l3PbMrZG7rTjBSTvSkE0d005IBePOKnI3RLWCtVKQKAt9Y+rCmTccTf
	Q8pdb/w==
X-Google-Smtp-Source: AGHT+IEFE0ZzF3ZW8fsqHa0cuy+ndasKY0AFzvFN3x8x6GXIRGKtUDymw3twpbsRdEmTRMJYxx28v6VS0pM=
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:31e:fe0d:f464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc7:b0:31f:8723:d128
 with SMTP id 98e67ed59e1d1-324e1422c22mr3402153a91.34.1755694380232; Wed, 20
 Aug 2025 05:53:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 05:52:57 -0700
In-Reply-To: <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com> <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
Message-ID: <aKXFKaJuZZTbAbJD@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 20, 2025, Mark Brown wrote:
> On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> > Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> > of the same name defined by linux/overflow.h.  Note, overflow.h's version
> > takes a type as the input, whereas the harness's version takes a variable!
> 
> This patch is in -next and is causing widespread breakage in the
> selftests -next on at least arm and arm64 due to:
> 
> make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> 
> ...
> 
> In file included from test-pcmtest-driver.c:10:
> ../kselftest_harness.h:59:10: fatal error: linux/overflow.h: No such file or directory
>    59 | #include <linux/overflow.h>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.

Argh, many selftests don't add tools/include to their include path.  The least
awful thing I can think of is to go with a minimal fix to avoid the collision.
AFAICT, nothing outside of kselftest_harness.h uses is_signed_type(), so this
shouldn't cause a different flavor of breakage?

--
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Jun 2025 16:19:30 -0700
Subject: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h

Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
of the same name defined by tools' linux/overflow.h.  This fixes warnings
(and presumably potential test failures) in tests that utilize the
selftests harness and happen to (indirectly) include overflow.h.

  In file included from tools/include/linux/bits.h:34,
                   from tools/include/linux/bitops.h:14,
                   from tools/include/linux/hashtable.h:13,
                   from include/kvm_util.h:11,
                   from x86/userspace_msr_exit_test.c:11:
  tools/include/linux/overflow.h:31:9: error: "is_signed_type" redefined [-Werror]
     31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
        |         ^~~~~~~~~~~~~~
  In file included from include/kvm_test_harness.h:11,
                   from x86/userspace_msr_exit_test.c:9:
  ../kselftest_harness.h:754:9: note: this is the location of the previous definition
    754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
        |         ^~~~~~~~~~~~~~

Use a separate definition, at least for now, as many selftests build
without tools/include in their include path.

Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20250624231930.583689-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..8516e8434bc4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -751,7 +751,7 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+#define is_signed_var(var)	(!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
@@ -759,7 +759,7 @@
 	__typeof__(_seen) __seen = (_seen); \
 	if (!(__exp _t __seen)) { \
 		/* Report with actual signedness to avoid weird output. */ \
-		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		switch (is_signed_var(__exp) * 2 + is_signed_var(__seen)) { \
 		case 0: { \
 			uintmax_t __exp_print = (uintmax_t)__exp; \
 			uintmax_t __seen_print = (uintmax_t)__seen; \

base-commit: 923fcb3dbc0246fc5207093c0049af4c56f20e41
--

