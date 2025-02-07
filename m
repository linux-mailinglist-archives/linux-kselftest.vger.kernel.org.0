Return-Path: <linux-kselftest+bounces-26048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A76A2CDEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C45E1881F0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB919F420;
	Fri,  7 Feb 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1UvAVJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE419EED2;
	Fri,  7 Feb 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959251; cv=none; b=mWtR5hm2EpxfrJ5jeJWfuyZpwdJyaZaDkCbiWaozFCfN+YrkQgf3Pn4gg0RVavL23aTDHnqAOE+dgL9dord8ZGgpwT1/m3OPksOL7sZXXRBviQORON4LzzCM5aBBlCkVvjuR7WAQiIr02sJh1JeFuKa6gllR4XTdzkvbErmij6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959251; c=relaxed/simple;
	bh=OIee8Zv7FJW8dLrmsyqrHqhnUwTu0qSp/jU2rKhNy7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LKNS7hjcp7UfWL8vY5Gtr45zGRq1wQz1OJY6vTLHsv83ajmW/74OnIzQ1u9KVJX/gb1oj7JioKHETGm9/Q4mFGs3lnJAJLGM/AJbLV1u+DhoOyGGdeyniqv+pjMIE39qQ+XphIFR00G5OvQ6i4WQvcxAykKIX9HOCfiPiE0tnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1UvAVJc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso223741885a.2;
        Fri, 07 Feb 2025 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738959248; x=1739564048; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InMP3iob4ePV8GF0GnOu+F67bMQE3/48J3tUdjgvoYQ=;
        b=J1UvAVJc/6MHO9kpDIv/Cx710TusZkBxDrRAzXkjpLierZAv2hapfQZtnrELB2EtSG
         6vegumqG24+CT4kouY0VgilxnO9OiOS5P2v1zkDHFuPcBXdnZLUcZ6hWcrb0BODSm5MS
         y/X4Ht6BH0qi6gmpB8Jx5rlKPPhvdyGBR58YILZosL6FhjxQhbBmG98ogCkSTTzC1lxu
         iKcPt2jGNrUQbHdbvJexJ/CBcmepFk4IDMNLtKSUbnfFd9g06edl1Ak9dgTKoHzZCcrg
         W4LxVJZZGV8hDfwLctkuM7G+9vBqYts0AyJuObfb/fgoHXjJZtdUpe4RfO/OEnzz/GAr
         jptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738959248; x=1739564048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InMP3iob4ePV8GF0GnOu+F67bMQE3/48J3tUdjgvoYQ=;
        b=csYdzkGoMfnz/wT/Hpgove/ishb438ZdTVHAvrYDFxmdEct9ULXIsbte+YAfLNu0sy
         3qnYr/2l5S1l8SD/ITIvGbdLxfbu878qrckS6/qaPTDG7fbQM/X0Wge7AwtTXUWI5JNb
         DodO4uBlLcuNt6+QZUgaum3HHx4rhE2tQpu7qlKU1kQBlVFO2duXviXwYc1J0d6NcjDB
         jtsqlcBOz9uTRzuDnT/qaJTw3EcL211jmJv3T5G7jq8gvIuYKo9jnvf0178dZIIUq8c0
         en6KdNPLGcpORW2ekEry/BcqGHqnanRwL2QcduF5f0YD2wLS+XIJBdyayzJ3D/r+cwPW
         5l2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd8naiKGq/TRhNxwJ7ngWM8ONmd253wXP7aoyX4OXadtZycs8TJABHxD8ViZ1koMqiH2Oq/eQWAHAPZAu3WgJ+@vger.kernel.org, AJvYcCWD8iWVG88zzAXl2Ctq9L8BHQb9MKTsMraqCaNivJ7GDar6R/J4edjsPPRNETGthjHuBdy59Hgmc0Oth8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGGeou2GaOIQ5/LpIvVagmIagLK0XjtxAKo6hmW1TP6wqu/mz
	H/MGZN6+673xqGfLeF0RJhg+r0HSya3WcKKFp7TWcBfgXl9Yvri6
X-Gm-Gg: ASbGnctO4pIc+xSTvVZvOEJ2POyq32f4+p0YtBO0phc4V4GtGzZPhlp/5rL+Z5K/e7I
	HIYBqS9LkSXL+LTdjib8tZCvabP0wgb6vpfxF/wy3HhSAJPiF7SddwpxnLLa4wL15h2fX3h8aRd
	140ONjyeG79pcMlsPmc5Ls/O1GnFVG81l4hZpH3lHEaq0bx31KqkKOLjkLC4YOpij0BjMTSlLiM
	V+GVXy+r4YU8B+sqSeiiw6IYsB6IxIfFAcYQeLZU44SeC/EwelSBoRz9Wz+cg7phW3uGKHmP8fR
	dFEYt8buZ9p77aGlhD76ynOdUkykBdKJqfshDT6AGtcxTRTqymD/nlhy4JItEWFYxMYmFXIcB7r
	/OP/LQ+x2WKNBZXSUPocTMjYFFHeewRPp2a+CvQ==
X-Google-Smtp-Source: AGHT+IF9/EZlG7CYstG/RAX4Cebsc2v6V7/CwkGisOAz02Bj/HKRkvBl3RnAIQYOfaIOw465jlPEvA==
X-Received: by 2002:a05:620a:40cc:b0:7b6:e9db:3b21 with SMTP id af79cd13be357-7c047bba9afmr576565385a.14.1738959248476;
        Fri, 07 Feb 2025 12:14:08 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e13895sm228851285a.58.2025.02.07.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:14:08 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/3] bitmap: convert self-test to KUnit
Date: Fri, 07 Feb 2025 15:14:01 -0500
Message-Id: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIlppmcC/x3MQQqEMBAF0atIr6chtoo4VxlmEfWrjRgliSKId
 ze4fIuqiwK8ItA3u8jj0KCrS8g/GXWTdSNY+2QSI5URU3OrcbEbz7vTyN3qDvjIjfRFXtatAKC
 Ubh6Dnu/297/vByCSwpNmAAAA
X-Change-ID: 20250207-bitmap-kunit-convert-92d3147b2eee
To: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, 
 Kees Cook <kees@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being printf and scanf), the rest having been converted to KUnit.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 bitmap.

I've already sent out a conversion series for each of printf[0] and scanf[1].

There was a previous attempt[2] to do this in July 2024. Please bear
with me as I try to understand and address the objections from that
time. I've spoken with Muhammad Usama Anjum, the author of that series,
and received their approval to "take over" this work. Here we go...

On 7/26/24 11:45 PM, John Hubbard wrote:
> 
> This changes the situation from "works for Linus' tab completion
> case", to "causes a tab completion problem"! :)
> 
> I think a tests/ subdir is how we eventually decided to do this [1],
> right?
> 
> So:
> 
>     lib/tests/bitmap_kunit.c
> 
> [1] https://lore.kernel.org/20240724201354.make.730-kees@kernel.org

This is true and unfortunate, but not trivial to fix because new
kallsyms tests were placed in lib/tests in commit 84b4a51fce4c
("selftests: add new kallsyms selftests")  *after* the KUnit filename
best practices were adopted.

I propose that the KUnit maintainers blaze this trail using
`string_kunit.c` which currently still lives in lib/ despite the KUnit
docs giving it as an example at lib/tests/.

On 7/27/24 12:24 AM, Shuah Khan wrote:
> 
> This change will take away the ability to run bitmap tests during
> boot on a non-kunit kernel.
> 
> Nack on this change. I wan to see all tests that are being removed
> from lib because they have been converted - also it doesn't make
> sense to convert some tests like this one that add the ability test
> during boot.

This point was also discussed in another thread[3] in which:

On 7/27/24 12:35 AM, Shuah Khan wrote:
> 
> Please make sure you aren't taking away the ability to run these tests during
> boot. 
>
> It doesn't make sense to convert every single test especially when it
> is intended to be run during boot without dependencies - not as a kunit test
> but a regression test during boot.
> 
> bitmap is one example - pay attention to the config help test - bitmap
> one clearly states it runs regression testing during boot. Any test that
> says that isn't a candidate for conversion.
> 
> I am going to nack any such conversions.

The crux of the argument seems to be that the config help text is taken
to describe the author's intent with the fragment "at boot". I think
this may be a case of confirmation bias: I see at least the following
KUnit tests with "at boot" in their help text:
- CPUMASK_KUNIT_TEST
- BITFIELD_KUNIT
- CHECKSUM_KUNIT
- UTIL_MACROS_KUNIT

It seems to me that the inference being made is that any test that runs
"at boot" is intended to be run by both developers and users, but I find
no evidence that bitmap in particular would ever provide additional
value when run by users.

There's further discussion about KUnit not being "ideal for cases where
people would want to check a subsystem on a running kernel", but I find
no evidence that bitmap in particular is actually testing the running
kernel; it is a unit test of the bitmap functions, which is also stated
in the config help text.

David Gow made many of the same points in his final reply[4], which was
never replied to.

Link: https://lore.kernel.org/all/20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com/T/#u [0]
Link: https://lore.kernel.org/all/20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com/T/#u [1]
Link: https://lore.kernel.org/all/20240726110658.2281070-1-usama.anjum@collabora.com/T/#u [2]
Link: https://lore.kernel.org/all/327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com/T/#u [3]
Link: https://lore.kernel.org/all/CABVgOSmMoPD3JfzVd4VTkzGL2fZCo8LfwzaVSzeFimPrhgLa5w@mail.gmail.com/ [4]

Thanks for your attention.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (3):
      bitmap: remove _check_eq_u32_array
      bitmap: convert self-test to KUnit
      bitmap: break kunit into test cases

 MAINTAINERS                           |   2 +-
 arch/m68k/configs/amiga_defconfig     |   1 -
 arch/m68k/configs/apollo_defconfig    |   1 -
 arch/m68k/configs/atari_defconfig     |   1 -
 arch/m68k/configs/bvme6000_defconfig  |   1 -
 arch/m68k/configs/hp300_defconfig     |   1 -
 arch/m68k/configs/mac_defconfig       |   1 -
 arch/m68k/configs/multi_defconfig     |   1 -
 arch/m68k/configs/mvme147_defconfig   |   1 -
 arch/m68k/configs/mvme16x_defconfig   |   1 -
 arch/m68k/configs/q40_defconfig       |   1 -
 arch/m68k/configs/sun3_defconfig      |   1 -
 arch/m68k/configs/sun3x_defconfig     |   1 -
 arch/powerpc/configs/ppc64_defconfig  |   1 -
 lib/Kconfig.debug                     |  24 +-
 lib/Makefile                          |   2 +-
 lib/{test_bitmap.c => bitmap_kunit.c} | 454 +++++++++++++---------------------
 tools/testing/selftests/lib/bitmap.sh |   3 -
 tools/testing/selftests/lib/config    |   1 -
 19 files changed, 195 insertions(+), 304 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-bitmap-kunit-convert-92d3147b2eee

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


