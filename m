Return-Path: <linux-kselftest+bounces-25725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A0A27B1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F0B1615CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF128212D83;
	Tue,  4 Feb 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujp7zhFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0F78F40;
	Tue,  4 Feb 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697094; cv=none; b=LJ6SBclSkL091aIGFXHbgU1MYCtD4u/WgAPu2ZpxWRHNgm8WmgKeI0H+ShKSrI0oP1LDrnAaYvANly1e0sf9hwq/0rrIQw2ymJNkx+Rcc7PAOxt9GDNiatH6CZty5lv2QLe/wlKuYMO0Ne/ODjksAzrwsfbuElbRVD6D72jf03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697094; c=relaxed/simple;
	bh=wKhs2aD0ynISzsKTkz1zYz/D+m17iObWon1lOTEZYS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DJNMr60pytsctID8X2A2gy6LayNxaN6DpdJcZBFe7HPdRmRp6/QoangITy1jB4fjsJa7bgKWvyOlP8bgfBgTazIRyUECtDGXcJ7bJzcNjtjATtfVUloTZ/jY57oD0bwUb3Be4O9x4hfnipFkbMw38+G26BOM4W0vKP2+zliPlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujp7zhFS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6eb531e13so334827585a.0;
        Tue, 04 Feb 2025 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697092; x=1739301892; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7SLBjn1DVctu90gMXy4A+sG2WNv/p/T3csymSiwOk0=;
        b=Ujp7zhFSlWxymRf0Vwe2plfKDKet1ISD6k77CHGPsAcy/3Rq4Q36BWLQ31s7VFWpX8
         kTHFK2uOnehaKyv4Z9WImD28TOM4dLibvMucltz36I0ye2gMnB6bT8jfkYRPbCn3xscK
         iUQXSWYAhmb1e2wxIf8hoJ0+oG6qlo/Jny781KYwVhSYoEzQvmHCSBoJige0Kg1uSe9c
         3OQVA9RtijZgj5pKgO4sNIg1OsDIWikQpy1PkQDECHn47aLgZPS9Go+dm6CHM73JoF5c
         hABbca2XYxkBJgE2ZdpNjxKu+YN3RHz/OZm4WGDJZCOkhT2amFWhREnt55GsoC5I66PD
         qn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697092; x=1739301892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7SLBjn1DVctu90gMXy4A+sG2WNv/p/T3csymSiwOk0=;
        b=FHuAqeUW37vr5/Ds4S/nF4D5LSrVK0yQDI+mRH+SclhdWqXYgKrjG2h8WYz+/bq5fk
         xxTnSfSg0JSvo8awvQHdai8s2V3HKIVzBJu2cDgcSOtvBRkns78WrxpOA6brFuTc/RAr
         7WzzTGq9OTlKhjweU6vELpepANNoEBp+Y2qu9iG/mkjtSwFh6/3yP4uG09jWPJ9dc4WJ
         JGw0HeITxq1kya4EAe/6n72zAp17RdmkccZt4huWoI7puBZCew7ZJiq/XAe4S1J9DU8Q
         w01CekKQIaMf4y4F3EZrDRyq2kBo7fsOoNNvnahh2DLSqZ2NOa9JhuxTu+1ebiqc9VRY
         BBuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3vj6r2I73G/eqjI6oNPHt4yKp0Ojrmi5ls9icaJfHH/vCJAEz8ZAFbxeefjgNihWNI8QIGv8ws4XUJMnrMUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6tWLIRKd0JL+A4qRAlaOY7EBQ6/R8vzgqMVjDYimvvAEfG0/
	gQxdpYbucQX4WEfibMXXcczk7ty5Fe5Sk7oH8Y/6/WACEQuuzpO1
X-Gm-Gg: ASbGnctm6SDSAHBCAMreZHDUuJJLqX0HTVhlH0CwG1kxYkN+1YKAiTIpgzsqA5X/1uf
	Hnhwhy6iV+vsZ/euCW0XAz4bhmX0X+SESe0s5xxlg/BkEvhJdqlQvQIiT/W2ZB12ayFFUnbVPqs
	xFBaMWEllk/0xDPi6+pN0Y9tEj0ZKDy9IT1Jc92/mHxBMIRMKQLrqZ3dRIB7fjRnScBMjmg/gm0
	L3wumWJWKERZucy1DM4hMG9AUACijDzZXiWgwZUrA4QLgdKnncujJc4gTCWm35xvO3A7Nz7rY8M
	iYAFdvL40cpOAynD/FTmfDFNQop4/rEacWRsTjOQo10uHAAl4tCAObjYfXuuZL9LmPZarLxu4Ty
	5ntYF+XeyyKxohxU3KW4r82n2
X-Google-Smtp-Source: AGHT+IFYJtAaQp1zK6Mpi8uccv71/bcKZtrFzMxs8Rrz+rxAGiGVBkKDasKX9xF1fWqSBtiCWG5jwQ==
X-Received: by 2002:a05:620a:4608:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7bffcd0e923mr4225388885a.32.1738697091602;
        Tue, 04 Feb 2025 11:24:51 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bbaf5sm671334285a.11.2025.02.04.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:24:51 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/2] EDITME: cover title for scanf-kunit-convert
Date: Tue, 04 Feb 2025 14:24:23 -0500
Message-Id: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdpomcC/33NTQ6CMBCG4auQrq3pD1B05T2Mi1KmMFFa02KjI
 dzdwkYXxuX7JfPMTCIEhEiOxUwCJIzoXQ65K4gZtOuBYpebCCYqxiWn0Whn6fXhcKLGuwRhola
 xzkjZtrI0JF/eA1h8bur5knvAOPnw2p4kvq7/vcQpp+yg6kqUlkGrT/2o8bY3fiSrl8THEEz+N
 kQ2hFK65k3XsBK+jWVZ3prSss36AAAA
X-Change-ID: 20250131-scanf-kunit-convert-f70dc33bb34c
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and printf), the rest having been converted to KUnit. In
addition to the enclosed patch, please consider this an RFC on the
removal of the "Test Module" kselftest machinery.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Reduce diff noise in lib/Makefile. (Petr Mladek)
- Split `scanf_test` into a few test cases. New output:
  : =================== scanf (10 subtests) ====================
  : [PASSED] numbers_simple
  : ====================== numbers_list  =======================
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ================== [PASSED] numbers_list ===================
  : ============ numbers_list_field_width_typemax  =============
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ======== [PASSED] numbers_list_field_width_typemax =========
  : =========== numbers_list_field_width_val_width  ============
  : [PASSED] delim=" "
  : [PASSED] delim=":"
  : [PASSED] delim=","
  : [PASSED] delim="-"
  : [PASSED] delim="/"
  : ======= [PASSED] numbers_list_field_width_val_width ========
  : [PASSED] numbers_slice
  : [PASSED] numbers_prefix_overflow
  : [PASSED] test_simple_strtoull
  : [PASSED] test_simple_strtoll
  : [PASSED] test_simple_strtoul
  : [PASSED] test_simple_strtol
  : ====================== [PASSED] scanf ======================
  : ============================================================
  : Testing complete. Ran 22 tests: passed: 22
  : Elapsed time: 5.517s total, 0.001s configuring, 5.440s building, 0.067s running
- Link to v2: https://lore.kernel.org/r/20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com

Changes in v2:
- Rename lib/{test_scanf.c => scanf_kunit.c}. (Andy Shevchenko)
- Link to v1: https://lore.kernel.org/r/20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com

---
Tamir Duberstein (2):
      scanf: convert self-test to KUnit
      scanf: break kunit into test cases

 MAINTAINERS                          |   2 +-
 arch/m68k/configs/amiga_defconfig    |   1 -
 arch/m68k/configs/apollo_defconfig   |   1 -
 arch/m68k/configs/atari_defconfig    |   1 -
 arch/m68k/configs/bvme6000_defconfig |   1 -
 arch/m68k/configs/hp300_defconfig    |   1 -
 arch/m68k/configs/mac_defconfig      |   1 -
 arch/m68k/configs/multi_defconfig    |   1 -
 arch/m68k/configs/mvme147_defconfig  |   1 -
 arch/m68k/configs/mvme16x_defconfig  |   1 -
 arch/m68k/configs/q40_defconfig      |   1 -
 arch/m68k/configs/sun3_defconfig     |   1 -
 arch/m68k/configs/sun3x_defconfig    |   1 -
 arch/powerpc/configs/ppc64_defconfig |   1 -
 lib/Kconfig.debug                    |  20 +-
 lib/Makefile                         |   2 +-
 lib/scanf_kunit.c                    | 800 ++++++++++++++++++++++++++++++++++
 lib/test_scanf.c                     | 814 -----------------------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 21 files changed, 820 insertions(+), 838 deletions(-)
---
base-commit: a86bf2283d2c9769205407e2b54777c03d012939
change-id: 20250131-scanf-kunit-convert-f70dc33bb34c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


