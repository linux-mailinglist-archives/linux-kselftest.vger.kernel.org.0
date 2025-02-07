Return-Path: <linux-kselftest+bounces-25988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E1A2C18E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A81D7A19E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E11DEFF7;
	Fri,  7 Feb 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDyo2lpG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89B1DED64;
	Fri,  7 Feb 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927853; cv=none; b=GI34tZ03n3mVgpeucYr4VcLssWfARZ4iYE/8ikZugBc15y6cinIeO4PhnVIRwE1j7e2aH0wazSCUv/AOdRM0o21QfkonjdvMa1tlmNKqfXvDAscGjDarRAhZOIXy4TLlcxh9JuYHVDVB2+v3zzC/QjsizPSn5KyQqldHWQqYKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927853; c=relaxed/simple;
	bh=ZDqjxjD1vbZXisHQ6PT8aGp7m4PMXTOTY09yBdtOHNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PbUi3+2AXt2duLMUwetQugXX5FScLQpceI6IlfHYTr3FdgYfxX8tB7EG9dN4l6tmqQQ+HlAxJqqvDlk39pnibFGRLMqDu3ntGAEsotpCD3+XMVsoz52jRUOZWpLHjTmznNr29PeSIo0c7kCQj8E3GZ1d25/t37sIwPFVUK0+Ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDyo2lpG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6f7d7e128so299699685a.1;
        Fri, 07 Feb 2025 03:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927850; x=1739532650; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPvD7/A4BN9N53O6dBf8b1um0XD4Tez1MGd+tallm/A=;
        b=nDyo2lpGaMhgEdrz/KoJqAzXaQs50TWA0HZZpE3M6iestm9ctzjgT9Hlzo6aqf/a5a
         dBFxMCLc05i3tVGExIvIR+nxVopKCjzFUxOQT8liuUEujRRMRxn5T0g8cauqX3aT2bDX
         7r2VUeXJkX+g5XbqvgSxKKaSiYOOK/CnsS7JY7nPPuGMVyUx5i3vslK82GOALVWiCmIQ
         PxY4YOUhJr3MFtou0Kc6suB7nw2U76nHwqjlE5bvYBNZ5/OWX3aSng+706iZL9d3TMfH
         AoM/jwg1Ryv3W37cwhHdqCjvcPhAkYN0Hf0g9jK0rvmzCBkP1ebJTyXFXT/Zhp/m5O2F
         BC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927850; x=1739532650;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPvD7/A4BN9N53O6dBf8b1um0XD4Tez1MGd+tallm/A=;
        b=hQBWdOahiLRKhwqT9hFPSdItKosARVyXOqKewybHZukMHwY67cWEPJ65G5l+MARpbt
         tzpZNTVhCFj2kKnh63xlhTSOejZnrajLVlV8SwjDEH6ZVeeeA60GbMceZLqDaOkvXWte
         YP8+pWxWDeb1sOh5SFHflEMhJxHE51DlZ2sJWIKEwx3gDuqgpSLYHamFm13BWhrKyI1N
         UwZDmS6R9Hf5o/RVUFYRlVHHsSETSa5bAPnzydscebDAgP5k3pxh+b91d2/xraqnagza
         7r9WJ/vuKTAmbGteamm1ZkhKTLHYYO/pYG8uGCBs1RodQ/8oikMaCOU+6mkpSHIJ9mwF
         jpHw==
X-Forwarded-Encrypted: i=1; AJvYcCURdGQBRKtvfhPSSxiXejeBkzMMNdvX6YWnZs/rCFkzJaNpGM+bK/ZU6Q48B6YZtzoKfJ1DAG6zdAT1rV8aBuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8L9YC8DO2ap/RqbfEQ09zHCIQvnxYAvvJ1erJHeMOeUX8h6P
	BWQwcddQUoHKhobJ9sVY5AR4AcP9LHDQXt9IcQc+dWkC8n/BL3yKYvV+ozo5
X-Gm-Gg: ASbGncvMqb/x6LL0xqknPEcTXLyL53RgnbVVQQ0RbNBuowi4k3FK1adSZw/cKLEJZV4
	vSkiF45L5eClSlrEG9tPgpkpPxTHfSsNDphF1puChrthA01pDS/dAzu1nrsaFBLl7IILv+oEtNh
	+xw46wXJ/TzO2E6v83/mLIdFvaee/yF0NPkbcJehYPGVqpn0eBBB/aIP667ndVrx2ZGwE/OeXtc
	y2M5FTBHd5SFA6U9Z0VVLAH330ez/SieCvr8vFbBO2JEvMSHwAZHzRJl51vuGr+Y9w8eb37bYa1
	8IM+Qefowt6WCixgVJudPz9MzF1nkryEutOU
X-Google-Smtp-Source: AGHT+IHf6a+mVgabTFzkr/tjv9wtYxeBGu4pNA2fRbLrHFgFpSC6gahs9OuNgfjsb/1EnX5IAw9TtQ==
X-Received: by 2002:a05:620a:424b:b0:7b6:d7be:2e4 with SMTP id af79cd13be357-7c0402a1bd2mr867499285a.26.1738927850135;
        Fri, 07 Feb 2025 03:30:50 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded0e7sm178507685a.8.2025.02.07.03.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:30:48 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] printf: convert self-test to KUnit
Date: Fri, 07 Feb 2025 06:30:43 -0500
Message-Id: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPupWcC/22NQQ7CIBBFr9LM2jGA2BhX3sN0gXRoJ1poAImm6
 d3FunX5XvLfXyBRZEpwbhaIVDhx8BXUrgE7Gj8Qcl8ZlFBHIQ8S58g+O7w/PWe0wReKGV2vhVT
 GKLIt1OkcyfFry167yiOnHOJ7eynya39BJfT/YJEokKyTt5Nuje7pMkyGH3sbJujWdf0AoS1UP
 7gAAAA=
X-Change-ID: 20250131-printf-kunit-convert-fd4012aa2ec6
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15-dev

This is one of just 3 remaining "Test Module" kselftests (the others
being bitmap and scanf), the rest having been converted to KUnit.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf

I have also sent out a series converting scanf[0].

Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Incorporate code review from prior work[0] by Arpitha Raghunandan.
- Link to v1: https://lore.kernel.org/r/20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com

Link: https://lore.kernel.org/lkml/20200817043028.76502-1-98.arpi@gmail.com/t/#u [0]

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
 lib/{test_printf.c => printf_kunit.c}     | 400 ++++++++++++------------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 20 files changed, 182 insertions(+), 262 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250131-printf-kunit-convert-fd4012aa2ec6

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


