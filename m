Return-Path: <linux-kselftest+bounces-35721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336EAE72FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 01:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8717B04F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743D26A0FD;
	Tue, 24 Jun 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqbWlrV+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6525C70D
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807174; cv=none; b=oc8J8sNjGZ3uM0BuOF+gfZrBZv7cReYlWeXp/7NXvlmH8oFX3IV6FbuJ5yPM9n8YRCZqM5qBAYYabjxy/lIzaCOrCi6okmJ66HjyGeMPogiGGA/umGEzdMdV6jQPBeOQqIfiDbhoRomxw67N6PwcAXNkmPtqrNgQ/5vF6inNhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807174; c=relaxed/simple;
	bh=OxLNyC//bkj0XORJ9A66+tceeOcN6KoRszvC1wPGHZw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=buaPZf7DqEUj8dfxGAI8AZ3yHKc+CoS57OFn9fC3xzQIAeQj5vKRIwxtalxmbI5iUJZUI2cHY4AtROCEHf6+NrCgelmk83425lIeAMQYGwPdldbVM5p6kHN8WY1qgWdnLVfv6DO0jKNs5Ww36kC8VlheKgYuh0UDpWkvhN5DiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqbWlrV+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so440726a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750807172; x=1751411972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1zI7Q0nLPv1eQnNCYffc5pUolE0Wqa7/b4IWfH+ITo=;
        b=fqbWlrV+F0FCcq0/AKTkDqMkBAiv5TfiJ1Qx4xewT5qKZPg6k4KX8XAIp6FQzxEjOA
         pHIctwRSeuy+wo6/FYpsxcCd90jjNII36KLNF/smc56sOqXVqOkIl/KNSQ9sCzpCIGry
         yx4HbuyvI2J1mcKgiCsC5+6xm+PbIIOLmRuKOhfT9b3WN/Cer/1cpKpYlpW7DmW3Lsv0
         dIlv/gNYdx54uWBsyZX2Fk9OqlNTcvOWnVGcMV5HpuwKI83M+2vMuhLpEKaES+Vm//Yj
         o0EJ7qbicXnxo6kD88fEd5WnPT4YChSDSEHQsd2Zovs3EkUTSYhHxvtTqkMmVEDZBGFx
         Ws2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807172; x=1751411972;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1zI7Q0nLPv1eQnNCYffc5pUolE0Wqa7/b4IWfH+ITo=;
        b=Ht9ibsvsHyb8atdbVwiNpq31CkN5CDk2GIrpxFSjxskK9iN0RlxPOJT3IRSNxFRTN/
         WnwowzeiLN9yL7LVYbA+qWI+8dW9l55Bu6Yd8fUKqB+dqBXTRDnUzQ2IBMHUx2sZqf+B
         oKU1UK93cnEjfbd0sZ06LA+DMfG/7mdzFgnkeNgb2zaT6pms/ndR4tS/EN8FbwOVQliy
         1LoIpYTW+0AILsJwHKQWTU2BynrMIU66P/3b9RLWEe96ceVKtVVcRIuKMliHy5YXiNhf
         +ZaafIlZonlIAJH3j/kf9FBhJRYubYDmnZOlnJD/XesrGXrK/yWSGYwqxH73xTU2Yuen
         WpTg==
X-Gm-Message-State: AOJu0YxubwsQep8t+qrI63i9iQLrxq2JoJ7eYelfOQ7i58XnpHsFL/tz
	oqhM7D/AQz98/5qqwkVA8OYbWxluw43ZYXb9cxjZi8lwLkuY9shUFFON0zpjc2IDNtIC/ngzotX
	XGHZ+mA==
X-Google-Smtp-Source: AGHT+IE23nOiBQ3/n1/Gt0pA9demZ4Iii2r83PTmEqXZz+eFfW86Nbh+5GyodHjhmYDzoXwsG8jf3L55akY=
X-Received: from pgcp27.prod.google.com ([2002:a63:741b:0:b0:b2f:64e5:602a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7350:b0:21c:faa4:9ab8
 with SMTP id adf61e73a8af0-2207f1ba673mr1146817637.10.1750807172381; Tue, 24
 Jun 2025 16:19:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Jun 2025 16:19:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624231930.583689-1-seanjc@google.com>
Subject: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
of the same name defined by linux/overflow.h.  Note, overflow.h's version
takes a type as the input, whereas the harness's version takes a variable!

This fixes warnings (and presumably potential test failures) in tests
that utilize the selftests harness and happen to (indirectly) include
overflow.h.

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

Opportunistically use is_signed_type() to implement is_signed_var() so
that the relationship and differences are obvious.

Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

This is probably compile-tested only, I don't think any of the KVM selftests
utilize the harness's EXPECT macros.

 tools/testing/selftests/kselftest_harness.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..f3e7a46345db 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <linux/overflow.h>
 #include <linux/unistd.h>
 #include <poll.h>
 #include <stdbool.h>
@@ -751,7 +752,7 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+#define is_signed_var(var)	is_signed_type(__typeof__(var))
 
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
@@ -759,7 +760,7 @@
 	__typeof__(_seen) __seen = (_seen); \
 	if (!(__exp _t __seen)) { \
 		/* Report with actual signedness to avoid weird output. */ \
-		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		switch (is_signed_var(__exp) * 2 + is_signed_var(__seen)) { \
 		case 0: { \
 			uintmax_t __exp_print = (uintmax_t)__exp; \
 			uintmax_t __seen_print = (uintmax_t)__seen; \

base-commit: 78f4e737a53e1163ded2687a922fce138aee73f5
-- 
2.50.0.714.g196bf9f422-goog


