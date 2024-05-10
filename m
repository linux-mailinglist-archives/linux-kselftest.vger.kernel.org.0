Return-Path: <linux-kselftest+bounces-10050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35D18C2B38
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E032872EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E545BEC;
	Fri, 10 May 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLA2XLuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162314F881;
	Fri, 10 May 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373448; cv=none; b=b9sbWo5jYYPhBqo7OmTtXNiq79Mbxj1cyV8oLxqFS4VMgD3Ibxk6ONtJ0uwpBHpQvp1AWKNME3RxgJDXxvHpm8UW2uKFmJF3NhTrj8Zrrc7bwbLZ1M4CzUr8Thlok7Os1JZpO2fMznlkEGzIkHDYwCpvaPB43DrJwNpsyyioJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373448; c=relaxed/simple;
	bh=fdvro2SMQFvU7C5zN+OrfigUP0qDunUUywy2/UNF0SA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jMKFUcNLVHlyzRdnVxjPJbU+eQy4zfnuyczTwGGBaFY9g/GyeZ0Iv2P0DUvC3DZ8JQgU2Iy9sknrm2dQkQrbVdBQI8v91DyvLuVfRMCOvOUBTEpGcWEh9mAJccM7PxCJtGFaSgh3T3mi5CrNlHwYUc0Y9IZQydmkPE+gARuBjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLA2XLuU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f40b5e059so2729276e87.0;
        Fri, 10 May 2024 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715373445; x=1715978245; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMEM98RiYUq0hdtm/YdPk4weUn162VqCwHj8usxBrh0=;
        b=iLA2XLuUOAj6fiiKkGy8WprNFBZH9xNMj4PzEydY7V3fYYZce+tkMHEfVo+L72VPFI
         obvAZEvRcAvtbnr4Sduew6oanfOBZ18rLgM+gI09vNdeqgruMBX6IUWLm0mYy/NF4bCl
         73uRvwl8DWejhet7F02a37CjMrCCtRTlGQT7ZPGdizeC3j4NiopeRGZXBlyQ3LsjcpH3
         Js8PQjG1/VMH8wph8TjE2oEZvTl+gBYHX/gIEVH/qrcmvoR4Q1xVCPsyG64q5Laq+CP4
         bPlBfpjCkP0cgpWvQzxUCMYTbvYRetG5yIRmJtMq8lmIiOxJP6/jU3PkFna6qdi55QkP
         6ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373445; x=1715978245;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMEM98RiYUq0hdtm/YdPk4weUn162VqCwHj8usxBrh0=;
        b=fjVbU7ROh40fPFeJ2rgun2N9fzKVJbx8adYvueHbkdQwoE2GywqGtIRU5JFSHcKCK2
         WXqrMfYnFDsoFCHgfe7lJsaS6vW0q9S5qwxvQuONklhpXdG0Eb6TkuR5T3dIEtXbO9+P
         Zg5wXF8x5sHTlZM7ByEw6HHgrwWby0luQzB1xJLf2dTvmkhIMPbXpMqU7xPiZ5beVGS0
         hFcNPH+BUwfBeXbJKZlgsPjzwbLYd5DbnqxyFJS3hQud9QHoVP7qQvbt9X5jDqk2Qdmq
         kV43Xa+ERqXe4tblMlfyLKFvcrdYK+itYRExcHZIdp5xOVMXoNIlat42VDjnETobYAok
         1o2g==
X-Forwarded-Encrypted: i=1; AJvYcCU/NWEIVXmf8pyEBjKooOmdSigNotZwjsJcz0mZzA5M52EIZaCdwSeAc28CyiJdGAO+AGWrzDqgt8VoiORN8wSdLuzr06eBwaCnIDkbP5JavHAjXGB3PyMnMRU6d26NTtg2lxn9L/3Z
X-Gm-Message-State: AOJu0YwBjwdq4E+2h+WbEEiCdT41ul3BzQW+Cl3w8fmzUCmOj+xN+V6W
	1i3snY462/osHNlDoLu58xaEOEMweOT5kO3XpYwwmBT7Ied7C/VxFeQepyG6
X-Google-Smtp-Source: AGHT+IFYRfcqAHHZlCT0YBLATYTXOOjY8VcpQZIfQCe9xsqALHHq2pklRgPZUZpo3EGvS0ilrFc1aA==
X-Received: by 2002:a05:6512:2809:b0:51f:5760:dd34 with SMTP id 2adb3069b0e04-5220ff70be8mr2901131e87.55.1715373444614;
        Fri, 10 May 2024 13:37:24 -0700 (PDT)
Received: from [192.168.178.20] (dh207-42-221.xnet.hr. [88.207.42.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d57sm221186466b.73.2024.05.10.13.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 13:37:24 -0700 (PDT)
Message-ID: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
Date: Fri, 10 May 2024 22:37:22 +0200
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
 linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edward Liaw <edliaw@google.com>
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

