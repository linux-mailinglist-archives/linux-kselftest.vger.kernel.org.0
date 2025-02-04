Return-Path: <linux-kselftest+bounces-25733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2EA27B60
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9721884928
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318532046AC;
	Tue,  4 Feb 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ9AFrO4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECB4CB5B;
	Tue,  4 Feb 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697813; cv=none; b=eXip9uk7o+tL44j632OaPFcAlqzMXxpNpU4ok6GsVrDTDGNKpBRG2YuVH8UJVsUhrc1NtkZeEbXEJnj3yTPuhnVF8TMoL3m6IBbeuVhFs2PQgh7AB6L6ILx2B+9NYYOR1YIcW/Xy5D9T7/tqAeFII3wAyGbIiyrSVcZ1819BHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697813; c=relaxed/simple;
	bh=t8Z6qQDWi8blnOHTwdjNJAkt86UhhppahsJOwri0G6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oftbg2YJdP4gVq+SxEVsW0sNbMnJ9UxXYhPWm25OZFWNUA94C2bkjsyxWK9QNlbbfBYvtEHso5CQuE9UVrcpYfigGjxfHMPLBnLomxeW6tu3bV7XKbsRWzVuzCDEzB1rvwiy8KPfRBFB9ulOrLdPCwdIAyvTueahMsAqxYf0EZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ9AFrO4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fee2b9c7aso37246321cf.2;
        Tue, 04 Feb 2025 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697810; x=1739302610; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBI0rcR7vdfS7Op5UL8lWJJ0ZxJ1digGI2TGIINW2kQ=;
        b=RQ9AFrO4Usb8yYjUHTjggJQr2tdnazp1xD8hJ4Rf9NKOcHYqAyax/ZMhmzHfp7SMfb
         tioQYScXmeAXgGl1hVw90WxVJFZYyo/kbkNxZo9FbRh1C1imZqYFW6q4651AmT3v7XUY
         nBF1izmSyaN8OZqAT7OM71Meq9h0KsQuSSRzwfZmky+7f0IUrmefQ1dc3d5npSzaKH8q
         RNO/8HRoZCmf6iECXquL4YOrz80sqQ+3aoob52m7EBKpSpw1b8zwlmmAA8bCvhvA15ln
         kbcctwWiFJ4rbp9gy6zWJ4ZeAftf/fw0ZciXWn+CSgP8RIbZB8p25X7SU9ijrM6GM5VB
         Y0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697810; x=1739302610;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBI0rcR7vdfS7Op5UL8lWJJ0ZxJ1digGI2TGIINW2kQ=;
        b=mfU0hvJa0HG+AUKYlnh5y/yauCjpJB5Z1kQj748UdOmXoXDCv2Tclf9niSfiZcRWB9
         kMnSr7KrKBaYse+vhGPHnn3mUp0KnNeO2yxNp9UHmtf0AHtM8zjXCrch2VDQUxVWurd3
         WiZhBGBuAtBb2ukoJJJEDfkcR9drkm0UVnS/l8FTfK6GdPPbm0ran+HKavOv+xh+1PVk
         UjemuMrU4iXFlve2NF5w3/txjgyaptLN+u4TrtdHh91zlAyBwZA6kcYEmJ2bMoAifmoT
         sBxibyVnsNiPFsvxFWneleML9+xo5JLEwdEE1YGqVwKI6YTiJQP/yKsdE3ZjT4eC71pp
         R1XA==
X-Forwarded-Encrypted: i=1; AJvYcCUe/XOoq/5udeqInOL+ErvvTtN9F9cCNpPp2dGe57fb8KX5cu/4t/uX+UCoGNEr2JyXfZQxcG0fDKNJJLWjat8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31yE45iHJWMcCpL15/vM+wibLhVWZr0tkyNZUHufrm9nSUI4z
	0QtaBpS9tmzpIhIxtszHzdmkEOSuogYzfThHDLrYJhO42ZI4AzEj
X-Gm-Gg: ASbGncs7M67IfX5DPE1lhZg9MjRK1bpgnvinprmNAp+B6ZtlvKLmLumof0G0sBdQX29
	YWm77/7gk6gcqe89OOI1TY7b44YWhjEnq9JSkjTC00W+SNPEFSVMMUNeVA1QzkhhxdThHaVSwC/
	gCa+EyuyhkiICC4FU7kflpvEwQKo9ImDbIEox8D8OIE3A7/y4F4vn6qTObJ5m8VoEq5Fq2Q8/TX
	zfDqTbiOlV8uLzL4T8WcpOQ4IOtkgWjGh2tEckpICyZmZXM3Wt9B4ALnUpjyPB2f3W2N33upYI1
	8x6m70h/IC+VLvEdhyAVWRkHciK1RwrSjvCwAXZe40mIFaX6RkS7karHN5GZpfpkp6n/xZilJXw
	P7SuVKJVG7ByIOTw6WY6RwoSc
X-Google-Smtp-Source: AGHT+IEpR183i5B1IVjrpNaIPTAuOcw4PCmAFmTIi6eOckgv3g9S9n0ukdOtp5KNwHpNcdmmBjBOAQ==
X-Received: by 2002:ac8:5a95:0:b0:466:9a61:273a with SMTP id d75a77b69052e-46fd0bbae27mr443619531cf.52.1738697810277;
        Tue, 04 Feb 2025 11:36:50 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf18a420sm62121031cf.77.2025.02.04.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:36:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] printf: convert self-test to KUnit
Date: Tue, 04 Feb 2025 14:36:36 -0500
Message-Id: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERsomcC/x3MPQqAMAxA4atIZgNt/Rm8ijiUmmoQoqRVBPHuF
 sdveO+BRMqUYKgeULo48S4Ftq4grF4WQp6LwRnXGdtYPJQlR9xO4Yxhl4s0Y5xbY533jkIPJT2
 UIt//dpze9wPB6tvaZgAAAA==
X-Change-ID: 20250131-printf-kunit-convert-fd4012aa2ec6
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and scanf), the rest having been converted to KUnit.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf

I have also sent out a series converting scanf[0].

Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      printf: convert self-test to KUnit
      printf: break kunit into test cases

 Documentation/core-api/printk-formats.rst |   2 +-
 MAINTAINERS                               |   2 +-
 arch/m68k/configs/amiga_defconfig         |   1 -
 arch/m68k/configs/apollo_defconfig        |   1 -
 arch/m68k/configs/atari_defconfig         |   1 -
 arch/m68k/configs/bvme6000_defconfig      |   1 -
 arch/m68k/configs/hp300_defconfig         |   1 -
 arch/m68k/configs/mac_defconfig           |   1 -
 arch/m68k/configs/multi_defconfig         |   1 -
 arch/m68k/configs/mvme147_defconfig       |   1 -
 arch/m68k/configs/mvme16x_defconfig       |   1 -
 arch/m68k/configs/q40_defconfig           |   1 -
 arch/m68k/configs/sun3_defconfig          |   1 -
 arch/m68k/configs/sun3x_defconfig         |   1 -
 arch/powerpc/configs/ppc64_defconfig      |   1 -
 lib/Kconfig.debug                         |  20 +-
 lib/Makefile                              |   2 +-
 lib/printf_kunit.c                        | 757 ++++++++++++++++++++++++++
 lib/test_printf.c                         | 863 ------------------------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 21 files changed, 777 insertions(+), 887 deletions(-)
---
base-commit: a86bf2283d2c9769205407e2b54777c03d012939
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


