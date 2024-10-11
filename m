Return-Path: <linux-kselftest+bounces-19519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75012999DF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E561C21C3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4257209F5D;
	Fri, 11 Oct 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkPdpoBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0311BFDF7
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631859; cv=none; b=Mq+W2ru6xmnZ3eTwNfGLTTqLVG/xO9a50hTpYWAt+hqFdM/q665ApT4ZOxG1LeWQ0dN1gEEK+h63mO0+wLlLCFB4NYbjhlGUU2spuyIRGEL2X/sx0O8yCRypgZDhR3YIH/jMDU03gCHzwXek4jU3+qexTB3Q7fS7clDo/8nhTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631859; c=relaxed/simple;
	bh=jhMA/QLCieigTnYYROpPY8AL1QJuHIldTPfMchqHtnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ODSsyTLRehpUAeDLc/Pxza1wkmdzWIhblbz8iWvZu78bYuuvS4I2Kxxh7ZtbcYCYRV5viN/8WmryNB995MxQQ5YqNQOUMugHEZErXQmL6WEpntyx2uvL4u1wy5DOVrYWY+8Vx3a1K+fN7wL9xODKPyi+zHhQWGK1pG7/dY+qlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkPdpoBW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e355f1ff4bso1224727b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631856; x=1729236656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ieNIZIvQhGiMx7MBdNBRx3MY2c4Ipc7B769GYKuhAU=;
        b=vkPdpoBWDfo0EmmZ6pzX7HakmjsOjQSQ232mNF1nZfo5BICxvTm/jhD/JI9RTskH/D
         9JiHlWKsWM4w989/mMV8+jDp2t3RvGiJ916t/+kYIpzZfr3V1ucNCgITtLAuLEpnDZKS
         vFmeIfA6h2eECndvD4loPzIe23i2AKVrqdyYhwvzjCIrlTBgwl6NgMm7lIRTAv8MxOKq
         uwnpKFn1ONBlbrovKDEfu0D+Fgn4Gxm2bLfE370Nv3wGu6FDSKfdNfDkK8pDf5EYVgWY
         3abajQ5cog04nRviLYjyPd+Ox89LnaGGwIbMv3jC9CrGXtejstwasiXQcnbpdbJrQb0q
         qBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631856; x=1729236656;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ieNIZIvQhGiMx7MBdNBRx3MY2c4Ipc7B769GYKuhAU=;
        b=KZ7iJAw0U2v+qhP62qagJfMsU45ccEjW40baTiWJb/9+j1MvlOiM1w6lAvV+Plb9Yw
         7JzU2RtpQFwiqYRIUoDxF05e5k8kzLfuA2Fq8dD2znMUEOx1teK3akN+7SCs3x7pCcUk
         FSWwpZJFcU9jjycG6lRH64GOzSSFOsDing25B8//Wgl/5bPua4TcdVKNihXlxHnZ4Vp1
         qlL0JqfulvVuXD+c1uB0exVJ7VooMT3flBDRnFx0M+9q8Fg0ftrYO8Z/6hIUQECLI6dr
         z7jrWHq0vFckjbxyfyfkbpGUftC+7Su8kCta7LPhWfWKDlTtPBJw5Rvh6AGPMPIIVynb
         xS4g==
X-Gm-Message-State: AOJu0Yy94MouWG4twYL7HNQtuKXSb48yYdrSUFKVLUcuooh1CaYfiwlG
	mGeQSEPnGGg1wOwp3MRP1B2jojGAJxO+GR77DDGf/JM92t+N9ClX2YCXQmtKkLqKdFtA3vx1EwW
	e57cMx7pZxg==
X-Google-Smtp-Source: AGHT+IE0ePNXz/vSuw3M1OFtmXAeLRhKk4WtKB9j9MsyYVGcSaA4NCqVZKE0+I9SPYt3TnkQr6jBKJGmNvL3pQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:8049:0:b0:e28:ee55:c3d with SMTP id
 3f1490d57ef6-e2919dc14efmr6193276.1.1728631855960; Fri, 11 Oct 2024 00:30:55
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-2-davidgow@google.com>
Subject: [PATCH 0/6] KUnit test moves / renames
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As discussed in [1], the KUnit test naming scheme has changed to avoid
name conflicts (and tab-completion woes) with the files being tested.
These renames and moves have caused a nasty set of merge conflicts, so
this series collates and rebases them all to be applied via
mm-nonmm-unstable alongside any lib/ changes[2].

Thanks to everyone whose patches appear here, and everyone who reviewed
on the original series. I hope I didn't break them too much during the
rebase!

Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [=
1]
Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=3DE4piSojh3A4_0GjE0fAYbq=
KjtYGbE9beYRQ@mail.gmail.com/ [2]
---

Bruno Sobreira Fran=C3=A7a (1):
  lib/math: Add int_log test suite

Diego Vieira (1):
  lib/tests/kfifo_kunit.c: add tests for the kfifo structure

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

Kees Cook (1):
  lib: Move KUnit tests into tests/ subdirectory

Luis Felipe Hernandez (1):
  lib: math: Move kunit tests into tests/ subdir

 MAINTAINERS                                   |  19 +-
 arch/m68k/configs/amiga_defconfig             |   2 +-
 arch/m68k/configs/apollo_defconfig            |   2 +-
 arch/m68k/configs/atari_defconfig             |   2 +-
 arch/m68k/configs/bvme6000_defconfig          |   2 +-
 arch/m68k/configs/hp300_defconfig             |   2 +-
 arch/m68k/configs/mac_defconfig               |   2 +-
 arch/m68k/configs/multi_defconfig             |   2 +-
 arch/m68k/configs/mvme147_defconfig           |   2 +-
 arch/m68k/configs/mvme16x_defconfig           |   2 +-
 arch/m68k/configs/q40_defconfig               |   2 +-
 arch/m68k/configs/sun3_defconfig              |   2 +-
 arch/m68k/configs/sun3x_defconfig             |   2 +-
 arch/powerpc/configs/ppc64_defconfig          |   2 +-
 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++------
 fs/unicode/utf8-norm.c                        |   2 +-
 lib/Kconfig.debug                             |  31 ++-
 lib/Makefile                                  |  36 +--
 lib/math/Makefile                             |   5 +-
 lib/math/tests/Makefile                       |   6 +-
 .../{test_div64.c =3D> tests/div64_kunit.c}     |   0
 lib/math/tests/int_log_kunit.c                |  75 ++++++
 .../mul_u64_u64_div_u64_kunit.c}              |   2 +-
 .../rational_kunit.c}                         |   0
 lib/tests/Makefile                            |  39 +++
 lib/{ =3D> tests}/bitfield_kunit.c              |   0
 lib/{ =3D> tests}/checksum_kunit.c              |   0
 lib/{ =3D> tests}/cmdline_kunit.c               |   0
 lib/{ =3D> tests}/cpumask_kunit.c               |   0
 lib/{ =3D> tests}/fortify_kunit.c               |   0
 lib/{ =3D> tests}/hashtable_test.c              |   0
 lib/{ =3D> tests}/is_signed_type_kunit.c        |   0
 lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
 lib/{ =3D> tests}/kunit_iov_iter.c              |   0
 lib/{ =3D> tests}/list-test.c                   |   0
 lib/{ =3D> tests}/memcpy_kunit.c                |   0
 lib/{ =3D> tests}/overflow_kunit.c              |   0
 lib/{ =3D> tests}/siphash_kunit.c               |   0
 lib/{ =3D> tests}/slub_kunit.c                  |   0
 lib/{ =3D> tests}/stackinit_kunit.c             |   0
 lib/{ =3D> tests}/string_helpers_kunit.c        |   0
 lib/{ =3D> tests}/string_kunit.c                |   0
 lib/{ =3D> tests}/test_bits.c                   |   0
 lib/{ =3D> tests}/test_fprobe.c                 |   0
 lib/{ =3D> tests}/test_hash.c                   |   0
 lib/{ =3D> tests}/test_kprobes.c                |   0
 lib/{ =3D> tests}/test_linear_ranges.c          |   0
 lib/{ =3D> tests}/test_list_sort.c              |   0
 lib/{ =3D> tests}/test_sort.c                   |   0
 lib/{ =3D> tests}/usercopy_kunit.c              |   0
 53 files changed, 474 insertions(+), 150 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)
 rename lib/math/{test_div64.c =3D> tests/div64_kunit.c} (100%)
 create mode 100644 lib/math/tests/int_log_kunit.c
 rename lib/math/{test_mul_u64_u64_div_u64.c =3D> tests/mul_u64_u64_div_u64=
_kunit.c} (98%)
 rename lib/math/{rational-test.c =3D> tests/rational_kunit.c} (100%)
 create mode 100644 lib/tests/Makefile
 rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
 rename lib/{ =3D> tests}/checksum_kunit.c (100%)
 rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
 rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
 rename lib/{ =3D> tests}/fortify_kunit.c (100%)
 rename lib/{ =3D> tests}/hashtable_test.c (100%)
 rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
 create mode 100644 lib/tests/kfifo_kunit.c
 rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
 rename lib/{ =3D> tests}/list-test.c (100%)
 rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
 rename lib/{ =3D> tests}/overflow_kunit.c (100%)
 rename lib/{ =3D> tests}/siphash_kunit.c (100%)
 rename lib/{ =3D> tests}/slub_kunit.c (100%)
 rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
 rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
 rename lib/{ =3D> tests}/string_kunit.c (100%)
 rename lib/{ =3D> tests}/test_bits.c (100%)
 rename lib/{ =3D> tests}/test_fprobe.c (100%)
 rename lib/{ =3D> tests}/test_hash.c (100%)
 rename lib/{ =3D> tests}/test_kprobes.c (100%)
 rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
 rename lib/{ =3D> tests}/test_list_sort.c (100%)
 rename lib/{ =3D> tests}/test_sort.c (100%)
 rename lib/{ =3D> tests}/usercopy_kunit.c (100%)

--=20
2.47.0.rc1.288.g06298d1525-goog


