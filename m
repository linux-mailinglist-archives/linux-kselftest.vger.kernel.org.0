Return-Path: <linux-kselftest+bounces-33151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BFAB93C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 03:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB8B1B64F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091422423E;
	Fri, 16 May 2025 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4tK8LiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002852AD0C;
	Fri, 16 May 2025 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359888; cv=none; b=SfIKoFDNnCLC3ohG8srpX8fTHfH379bRJuFJ6rhYTeHXZ956XEqqRJYlIwkr2L2945pcGlTSqyiCYBPAfSq7kyOfl0IJTAwkpM9pmnGTBZSt3izraNO32pUb+ZWl3+bLALsaT0Sc8hfWUSiZ5ggmG/20u0uo0C17YYkjXDJzI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359888; c=relaxed/simple;
	bh=OLule8vZ6pYFD7KstMmId4kflE7J1eo02CkkvhaIF0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIlSVZ55PcEcJIbERi+YQZgSTWZjHFx180P7N8hgrRsKYsTekCDePaIvCkmC9kkAkDcZ2ux0NnGMYmTYIlVDRRptZl2HGQamHKQAQgi+IoJ4cZ/M5J5MEQl97IFWbB6M5YTY21Q1afkkIP9ejGGdcA85aktyGI+NPhn6ojoNgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4tK8LiB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70a2c0e7fbbso17296007b3.2;
        Thu, 15 May 2025 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747359886; x=1747964686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkvwIib7SJ8VISrZy+6Zl38kwYsQhTVmXH1LNDYr2gI=;
        b=L4tK8LiBVUhvrwI11sIrWgo20cM3ug+IdGFFXTWgFckv5w3zy4iOBoNHZ7yIM48FTC
         Lrr/XkjVylc2/emx9NsDG5t6n57YmOUy4yG2fiXFw49ht0Ebs9GmrqJnvt3zvqX2E4WF
         ohDocencvDaOQeklS2xGZGY/73nZaju3rpQxTJkGPauTJD7VQiuduYpx10Mc8a+zuQHf
         Ysk+BK7l0wcO3rFVpALFPvt8VOtouJfdBHysefdhX8szWa9laDNNIlk2b36kXfkSmLBU
         9riuC3wJwdmx7XWL5O+XEJs8bK6yfI4OjN5gsc1Mk4/34SjXJkTFU0ybKNq+05cSCZh9
         z/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359886; x=1747964686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkvwIib7SJ8VISrZy+6Zl38kwYsQhTVmXH1LNDYr2gI=;
        b=uRzOA2GFvTgR0q0DlFiFILaX/IJfqekgAvtN0Bqw1nfosg1rFQSGHp3zNW9RoxfM3K
         0zgB1vebm8GCbvbTDinep14Vu/YRoCA77naMnc7etXSaEZ/K2UfCPyVTjQbCJuC2KjW1
         5Zi0w05x+X/VWrsk6ZpBjuP6LhVTvwZZP5PUqmjFnTwxyQiZjy69uH/TcwrGBkTnc8P2
         jJG0OsU6XTED7YoAPmyeuPUVlgCl3Exz6nSEDBDLpS29AvjpqMFTa27ZtlEBwY/uNQvR
         Yf6AhZDFBw4u4/GQoYmZKa5e0P6XSHWMXOEaeAH0VIQb7c9W+jQaFhmNQHDqtcGiZtsk
         rY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWEWGCd2egPYiAALplG+BMxAickjikIltOJEtZ3VugHxDppjKOB+yMIpI5ddjQrNyJh+iBeGmtFlpsQCTfUTN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3FCeVPHTL1A1jw7UOVp3Lpuxc6cBgve8/P7K4qNYxmTfqWkE
	KjZuUhPtAYrtR1EwvoVBnwy5p6L4s40/OjnfOenj5ViMDImcpDz4NrkayJamZbHGswR/VtVYmM0
	3/aTUk3jZB4bGZ43SjzR6MmztS+7un5g=
X-Gm-Gg: ASbGnctCaOaNz/1UHaozcs2YJKmripMt+s4oHnIQLt4KBqqyX3DtNUscavEe2+k1082
	xh+xrjPmE8zQhJK8DSK1SBer9i8UnifhhpJnWNeGdlODGhIJDkFV5ORQViqGLkFIEoFaUqjvvAZ
	tHsSy1iA3oAo9TXhKEiLu+lLaIMu/iFM6fy74tYxOe8M366iwjT9VvIcHJMTxrmk+Rx+Q=
X-Google-Smtp-Source: AGHT+IHaUQqw1N80C0OWhVA4FjqviBDRh58TKU0yyt8RSMOTTxsx9frZtSeZj+VRFZjfpaa3ZkwPB+opUbCwU3YjrLA=
X-Received: by 2002:a05:690c:6089:b0:709:1d50:897 with SMTP id
 00721157ae682-70cab0dcf41mr12450787b3.33.1747359885769; Thu, 15 May 2025
 18:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG+54DbGpNn-Ps=djpsUy+K-6V+eoNcMbTcJoW8W5upz2OKn+g@mail.gmail.com>
In-Reply-To: <CAG+54DbGpNn-Ps=djpsUy+K-6V+eoNcMbTcJoW8W5upz2OKn+g@mail.gmail.com>
From: rujra <braker.noob.kernel@gmail.com>
Date: Fri, 16 May 2025 07:14:34 +0530
X-Gm-Features: AX0GCFvnDgljjtOzQ3Gs4asEx8d--Lh61FJjSx4zgR_CjQEsgnkL4Zx2u8VeV98
Message-ID: <CAG+54DZ1wDTdWPQSw01G4YgTdihezQ966LGa6ttmBgT2D2gTyg@mail.gmail.com>
Subject: Fwd: [PATCH] selftests : timers : valid-adjtimex.c : Fixed style checks
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

fixed style checks according to Linux Kernel Coding Style standards.


1 : fixed alignment of parenthesis.
LOG : CHECK: Alignment should match open parenthesis
+                       printf("ERROR: out of range value %ld actually set!\n",
+                                       tx.freq);

2 : fixed alignment of parenthesis.
LOG : CHECK: Alignment should match open parenthesis
+                               printf("Error: No failure on invalid
ADJ_FREQUENCY %ld\n",
+                                       invalid_freq[i]);

3 : fixed line length of 106 to 100 and less.
LOG :  CHECK: line length of 106 exceeds 100 columns
+               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
tmx.time.tv_sec, tmx.time.tv_usec);

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c
b/tools/testing/selftests/timers/valid-adjtimex.c
index 6b7801055ad1..5110f9ee285c 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -157,7 +157,7 @@ int validate_freq(void)
                if (tx.freq == outofrange_freq[i]) {
                        printf("[FAIL]\n");
                        printf("ERROR: out of range value %ld actually set!\n",
-                                       tx.freq);
+                              tx.freq);
                        pass = -1;
                        goto out;
                }
@@ -172,7 +172,7 @@ int validate_freq(void)
                        if (ret >= 0) {
                                printf("[FAIL]\n");
                                printf("Error: No failure on invalid
ADJ_FREQUENCY %ld\n",
-                                       invalid_freq[i]);
+                                      invalid_freq[i]);
                                pass = -1;
                                goto out;
                        }
@@ -238,7 +238,8 @@ int set_bad_offset(long sec, long usec, int use_nano)
        tmx.time.tv_usec = usec;
        ret = clock_adjtime(CLOCK_REALTIME, &tmx);
        if (ret >= 0) {
-               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
tmx.time.tv_sec, tmx.time.tv_usec);
+               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
+                      tmx.time.tv_sec, tmx.time.tv_usec);
                printf("[FAIL]\n");
                return -1;
        }
--
2.43.0

