Return-Path: <linux-kselftest+bounces-10051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2B8C2B45
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9FC1C20B9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA846444;
	Fri, 10 May 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI6SwIoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2606FC0B;
	Fri, 10 May 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374012; cv=none; b=geQVrchc+AfvYzzclQOQQ+TErlcBV+Tix/hs6oBTrtt6ocWMwssU/TpM+JEXokX7guMrE0g0RcxuD8S8aCuRXRvgoVZVZxv5cht7pVJnnVmsTiSo10u2nZ/LYr1q951RaRLJq6eA/ZMQ7eHKN4SwXdjT/dMOhKQpuNT8lgDx9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374012; c=relaxed/simple;
	bh=fdvro2SMQFvU7C5zN+OrfigUP0qDunUUywy2/UNF0SA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pNuIvWyJY4Cla8ZWAfvCCrB5XnoNXadkBWS1sGg9j1yxhgVwEVttETVs3ssONoupWe4rK18L+XK3RsyANQS8G7MVsCEhhERNnMMGU5YMzzhYfqW1aLpIJgPpa5/sInOdU9AxYRQNJb2iNLyO5H3286nyDxqvRzRgw3STzxPj5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI6SwIoQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a934ad50so590931866b.1;
        Fri, 10 May 2024 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715374009; x=1715978809; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMEM98RiYUq0hdtm/YdPk4weUn162VqCwHj8usxBrh0=;
        b=RI6SwIoQ9Xd8SElEE0YLXfSxnD6ywvuE2ooSIO2EMIGmUUB0i/vGXS43DhD6AaewDO
         2hDJyBGS8qdC89/DtfK84b0+166Mn+h8IjW8aTVW/bC5Zmp9rTHwM6BqPUil15uVMRCn
         M3ppPam+KC9GFwShtQdJr98XUC5a1Ebigkg+w0I0bAj3O7l9KUZXMd07RtpJJ9f6qls8
         exZQLg/NE+F79UTK15op2D6I4ya5ZusUWe4xOXb3Wum6imwuWPNe3HhgZcx4qL/6FXsE
         fVnND1ONmlS6Xgk82gAZV8iOjlayyqbsUK5BB17wfhnn9UaP6/ZNNiHb001LQVsyath1
         VMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374009; x=1715978809;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMEM98RiYUq0hdtm/YdPk4weUn162VqCwHj8usxBrh0=;
        b=TWvGP0oII2/thL9pgBPv6ZrSB0UujbqrJXopQkVBp6+s2M9c37bd0F/a5BEHLdI7cQ
         1E+dDuOxsH4l6576A5ReD5Iu4nAJdjmY7x9a0val6etYqhA6F9bYcAVS7Uz0lZ59IFI+
         Tr8TNoWsrg4kQ26hHSuxARihLwbhjUgYx/cVRuYc569nOaRn+Z1nitRPUlchCBZjYxuL
         ztuffZRF3eBFWYRGDlwSzLC+4iriv8xJg4CfE6QvMUqweptUJMN3wUmvHBl6BOydhrBR
         TOY7LdEXqBnDBFbPyiRYAi4Zv7gcImUzUfO7uEW1MtfB3w6CtA26W8ZXrNAibZKXvrn+
         o2/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMzCWMzx+n4vv//+EGG85CoDHG14jHljd97psyrqqUGhHGwVV72M/tvB6japZJxX+atEHKGs7iSvXeAlDGF28DQsxTZ/09PsKg/7VRNGiX/esfyex43FKm/P+Q5uw8FkhzVfi+1F8W
X-Gm-Message-State: AOJu0Yy7+/pB/j8xr9NVlnqeboI/YJ5kF8p7nnTemc52jlWeN8CECgve
	/tX+P5t0BsawPjPzi9LiLVLS85uk7D9vfEwJfL5cG4KjRGaPGLZ/s61yRH3L
X-Google-Smtp-Source: AGHT+IEdoRgVqcTVs95ruV6D74mUnZI1UyKgszD5KL5X4ahLlK5JkYVuQ4kebfo/LFj3lkuKsI5Vww==
X-Received: by 2002:a50:c349:0:b0:56d:faa2:789b with SMTP id 4fb4d7f45d1cf-5734d6df1dcmr2213346a12.40.1715374008474;
        Fri, 10 May 2024 13:46:48 -0700 (PDT)
Received: from [192.168.178.20] (dh207-42-221.xnet.hr. [88.207.42.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb83sm2206598a12.46.2024.05.10.13.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 13:46:48 -0700 (PDT)
Message-ID: <150006c9-18c9-459d-9e38-58e83d6653ae@gmail.com>
Date: Fri, 10 May 2024 22:46:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kselftest@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Shuah Khan <shuah@kernel.org>,
 linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The selftest/sgx/main.c didn't compile with [-Werror=implicit-function-declaration]
[edited]:

make[3]: Entering directory 'tools/testing/selftests/sgx'
gcc -Wall -Werror -g -Itools/testing/selftests/../../../tools/include -fPIC -c main.c \
        -o tools/testing/selftests/sgx/main.o
In file included from main.c:21:
../kselftest_harness.h: In function ‘__run_test’:
../kselftest_harness.h:1169:13: error: implicit declaration of function ‘asprintf’; \
        did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
 1169 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
      |             ^~~~~~~~
      |             vsprintf
cc1: all warnings being treated as errors
make[3]: *** [Makefile:36: tools/testing/selftests/sgx/main.o] Error 1

The cause is in the included <stdio.h> on Ubuntu 22.04 LTS:

 19 /*
 20  *      ISO C99 Standard: 7.19 Input/output     <stdio.h>
 21  */
.
.
.
387 #if __GLIBC_USE (LIB_EXT2)
388 /* Write formatted output to a string dynamically allocated with `malloc'.
389    Store the address of the string in *PTR.  */
390 extern int vasprintf (char **__restrict __ptr, const char *__restrict __f,
391                       __gnuc_va_list __arg)
392      __THROWNL __attribute__ ((__format__ (__printf__, 2, 0))) __wur;
393 extern int __asprintf (char **__restrict __ptr,
394                        const char *__restrict __fmt, ...)
395      __THROWNL __attribute__ ((__format__ (__printf__, 2, 3))) __wur;
396 extern int asprintf (char **__restrict __ptr,
397                      const char *__restrict __fmt, ...)
398      __THROWNL __attribute__ ((__format__ (__printf__, 2, 3))) __wur;
399 #endif

__GLIBC_USE (LIB_EXT2) expands into __GLIBC_USE_LIB_EXT2 as defined here:

/usr/include/features.h:186:#define __GLIBC_USE(F)      __GLIBC_USE_ ## F

Now, what is unobvious is that <stdio.h> includes

/usr/include/x86_64-linux-gnu/bits/libc-header-start.h:
------------------------------------------------------
 35 /* ISO/IEC TR 24731-2:2010 defines the __STDC_WANT_LIB_EXT2__
 36    macro.  */
 37 #undef __GLIBC_USE_LIB_EXT2
 38 #if (defined __USE_GNU                                                  \
 39      || (defined __STDC_WANT_LIB_EXT2__ && __STDC_WANT_LIB_EXT2__ > 0))
 40 # define __GLIBC_USE_LIB_EXT2 1
 41 #else
 42 # define __GLIBC_USE_LIB_EXT2 0
 43 #endif

This makes <stdio.h> exclude line 396 and asprintf() prototype from normal
include file processing.

The fix defines __USE_GNU before including <stdio.h> in case it isn't already
defined. After this intervention the module compiles OK.

Converting snprintf() to asprintf() in selftests/kselftest_harness.h:1169
created this new dependency and the implicit declaration broke the compilation.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Cc: Edward Liaw <edliaw@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorov69@gmail.com>
---
 tools/testing/selftests/sgx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..f5cb426bd797 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -6,6 +6,9 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdbool.h>
+#ifndef __USE_GNU
+#define __USE_GNU
+#endif
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
-- 
2.34.1


