Return-Path: <linux-kselftest+bounces-26056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89759A2D083
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922A63ACAED
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5D19CD13;
	Fri,  7 Feb 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Cj+1TQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94142502BE;
	Fri,  7 Feb 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967600; cv=none; b=XWEqb/I6FbbGiMOJP4k6uUJM1jj8IOsWOubP6Ei2y2eJSuzqW4NBv3LmYX/EvapmPJKx73167SGYtFtmI944svHnXH6Y2+/XDxS2Y3040ZphMFxXW4fYtkc4a6YxCPNwy//0WBkF3E0KCRdc4FgoUBRGVxsu+IgIOg/8xFxaR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967600; c=relaxed/simple;
	bh=qIMgU1f3eLwSpIXeL1Ho9r+QLXtuhQNNVxwLkZa5DUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SJo36wKIiuLwnq+H7usF3+GVojitKBRQZq0dV/WW3IbiFFaI81V4KYmRuccDUYcVjeCv3cwsIOyTFNMw9XhczrU4CSInRxb7i5MpJG6i0wDlsfkDiFF+CAnW4piWi2wYNYXELGrQSq2tPsEBiK7VgVB608pfyRUwcW942Zkhvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+Cj+1TQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467918c35easo43912311cf.2;
        Fri, 07 Feb 2025 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738967597; x=1739572397; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5zOxWcynUwFJHaEdhB+YgWemcxpqHtXs9MZEF9bkwI=;
        b=R+Cj+1TQVwgL9FFVlcr42T5owb2Es0eFurLDJUPPcbu4a1yiXJEel2n+c4yEtIWjrx
         3Jxn96yIOkHTmUET8GP1iVBDCjmSz3KFWTYlw3S94kpff/6l2lYNtMcpK3+mmK5NzNSw
         dk1Ew/LyWmygrvCThVQ4O3WF7GOVxif7nDfmEgRQk2kTDEC9S96+KrPvLqLviN/R8LTI
         Fyd/QXBu04h6YMQKt/Js0ePQVQDMm383O0D2g1cgwcrR4vDeBdkEYBQmmho51eSZHibS
         8YrHa9gACJzQyXc4zWGPHQTcIOwIbIQ0tg8XWC68D4LKiU9S10qq0PnaFCdc+M7Y1EPF
         lN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738967597; x=1739572397;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5zOxWcynUwFJHaEdhB+YgWemcxpqHtXs9MZEF9bkwI=;
        b=bPh+/8UhQCeD0pcByTX3/NxC4Q9r2OMtv8OEAR4Y7VJEqAoFVNBJ2aiaOmw6lj+9p3
         IANnzHGOjVrXXil4qV/vOPS/qKi1x4ivHdP9iMsFwlPXDKagoMyPRHPNMCpfElEVO5uk
         QopdZAeFTkjsouJ303ouJ9Osq3pK1ex6Jq1hJDup9grLYE5mha9SsWxZSIIo6+rPa6lt
         3b/0rLKB+jMjlSsNd73IU2cmykYfJQJwbURm8qivkSvnDJ0avxkbuP6O1i25up2U4tMH
         c0eJc+LI/J0DM5ODRM4vexAkNqOb9ZhghTDHLP4HwwT59r8tKD9Z+q1+1oXWGFsNHEyN
         QJag==
X-Forwarded-Encrypted: i=1; AJvYcCXolvU/RtDpvRAZz1NH/T/ngV8JvENkajMNYUS3s78tKg4LwB/ZHchP6LEdstLAZRrU1Mbne3X3RANmBFzwh7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTe9tfZG3Ah1kqz9WnQK11weWrzZv0WTEjIZynIn0NFtGgSbhK
	C5bx8Jt8jeo+bB/7V0LQId0SDlxn7ziNyr0gJaOlpReTab0bb+HD
X-Gm-Gg: ASbGncvAA4Dzp0fYqCZ/38Vffmde+XuaUBMCdRTU/lXpPfZuJBwgEFVZyJD1c53yLnk
	weRygcc96eHNB+0it2Mrv3AdWvreta51ecJ2A3+GIJMh2Rf7BM1yIHwKuCWI/HrgN+ojrMJF4Bw
	OK5d0sVA8ayUe1asbj98WqITQ4KmNouhEbOwk0Q7dX8au8YfPdehXwkY1OUPJDgeHHzohju5y6f
	UMAFirNiqaSlDu2OgbztfAucomBW0tjvF+THi1Y+vBr86E08oHXSSQw7vNK1tafzv5sQYqM368Z
	ezUVj13OvoW4HC2XwDsGLY25YfAtc5Q/RZ98b/PlxFVm9NiBfQ==
X-Google-Smtp-Source: AGHT+IHlPIZresTbo2ck+KzMJdQp1oGzBQLwQoWEWpxx6OCKsx5gFHllJTEG8P70iqIAIYOXls4FLg==
X-Received: by 2002:a05:620a:2614:b0:7b6:ce6e:229c with SMTP id af79cd13be357-7c047c4e7afmr872462785a.55.1738967597324;
        Fri, 07 Feb 2025 14:33:17 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f965sm240638085a.86.2025.02.07.14.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:33:16 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] lib/prime_numbers: convert self-test to KUnit
Date: Fri, 07 Feb 2025 17:32:58 -0500
Message-Id: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqKpmcC/x3MUQqDMAwA0KtIvhdo66RsVxlDtI0ahlFSFUF6d
 8s+38+7IJEyJXhXFygdnHiRAvuoIEydjIQci8EZ1xhnPK7KM7Wyzz1pwt8uvGFY5CDd0Nvw6ut
 go41PKMOqNPD53z/fnG+Z6Up/bQAAAA==
X-Change-ID: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a clear example of a unit test.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 math-prime_numbers

; KTAP version 1
; 1..1
;     KTAP version 1
;     # Subtest: math-prime_numbers
;     # module: prime_numbers_kunit
;     1..1
;     # prime_numbers_test: prime_numbers_test(65536) passed, last prime was 65521
;     # prime_numbers_test: primes.{last=61, .sz=64, .primes[]=...x28208a20a08a28ac} = 2-3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61
; 
;     ok 1 prime_numbers_test
; ok 1 math-prime_numbers

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      lib/math: Hook up tests/Makefile
      lib/prime_numbers: convert self-test to KUnit

 lib/Kconfig.debug                            |  14 +++
 lib/math/Makefile                            |   4 +-
 lib/math/prime_numbers.c                     | 151 +--------------------------
 lib/math/prime_numbers_private.h             |  64 ++++++++++++
 lib/math/tests/Makefile                      |   1 +
 lib/math/tests/prime_numbers_kunit.c         |  92 ++++++++++++++++
 tools/testing/selftests/lib/config           |   1 -
 tools/testing/selftests/lib/prime_numbers.sh |   4 -
 8 files changed, 175 insertions(+), 156 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


