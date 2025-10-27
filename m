Return-Path: <linux-kselftest+bounces-44085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56737C0C435
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A56919A05A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A624E4BD;
	Mon, 27 Oct 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFk83KaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D619D065
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552831; cv=none; b=EMbg357FDNV9e1XLgy8I+bf7k9hvuqCDqHGaOUUYKaTCdWkTyBycLr7A/KCAljKpmu9C6yT93KiTwsW6FHzWXc9EveQz1tlgFWdVC8gjRiWav2do1f64E44J2yKE8uTuVSffk2KUdgd2qIyew6olirVBRBtBjMYFGgerIOpx8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552831; c=relaxed/simple;
	bh=PDu2+4bsEeyUICfQnH98BoyyFCQbSkXmmrSr8uuh80g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UCDOxOxOYcFTchAx2qMPWwBtkmABX0PiODSLyuKYuQpWZoB+10x280XH/jNCgxyXFapTo+wKG95rPtpxPJtzer/HkFDH4JATdNVvdgA0nU0Gq3/mZB47XBlcGyRzjiHabI2k/nJlKUP7NITer+xWnXmvyhjn9Ypi7gWHTnM+awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFk83KaG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso5448233b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761552829; x=1762157629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Jl1IRJ1KOa3eGEJUzKJJ2c9eSrVA6i/w3yC2J76xMQ=;
        b=pFk83KaGTOJvfg3joWGtHxyTVb1//EvV9IVpqlITDz2QIFuLs6q4BBjC+EhLYkGaYg
         Xkqp6JwsFe1HxaZYAHkhW2QSTARY9H5vlDpw34aigHo0KEM/Kci/krajxBv2ZBxGkaNC
         WhYzLSJ1ftzW0ZmrFTILbwcFpxsEnKeQlUeIhZS9LDXh2p122VEkqOkbibjTeiahojKA
         uqJ4+B5XrgoBSmU2iqgMAP7lpAXIA4Rb2maAa26cAHLH8AfnXCKmZd1g2ISprJiP3ozt
         10k6MqthqbIqSCvbWojq79aiIgLzNw4CK9WirR7S2LppFK83HWfmMg0BlKDGHT1NXDUt
         aVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552829; x=1762157629;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Jl1IRJ1KOa3eGEJUzKJJ2c9eSrVA6i/w3yC2J76xMQ=;
        b=ghfzUUlTaTdIvTN+bsLh/qKXZI4bOhq3BUX28xrNiz+unteKpM4VEcdRbh+XzWdcdJ
         trD7fA9b+EP+yBtGNwMY44yDLtRIj739N9+tII7xcdZ33+ZYa02rskvDkqYCm/Shj3xr
         tzO+RZecEKqBXKhw2nhRvYlKFZJMIHxxmFI63EzRV+5/F9sHCm4ObznCtonoNXRlkN+k
         bfjThI1ImvwqoGsxVyxrYILWq9KWL8UqH6JEHeUZZLeNeer0VC83P0gDM3kkLjgLZbB9
         u4dh4l5AhJVbIKSmAbj2Gi55e9lmXFzPEAaLVUcDLLpKg3ZwwdHZRNA+btgM23eKRjqj
         B40w==
X-Forwarded-Encrypted: i=1; AJvYcCW6mvqeXfk8wWlbH9mXc/Gw6xq3422AEoEIGyAMhQMVO1Igqd6HB6+UkRbdhMIMg4jTy5DSNtxXhJ38x/DKC7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK08Gw6+CltGXgbeQq04EAK5NwgnO9ltwdFPQhUVXNEA64ASSj
	GFsDtLo9CGAY2//mss4fSYIT+f2gNBQaPcRa/CbQh8xRiarussKD5bhPfRA34FYVzcuI6xYOsJt
	YqZ35xhZWsunSFy6csJX5JNrwh0kHr65i/ECwwhe21A==
X-Gm-Gg: ASbGncvamXDX/z9H3yZskCF4X3jIh8lPfdr+80E0YIXUKHTMjp/zUt//cPnEZoJxSFe
	3ucZl9lPlKhRnDpo7bfEuN0QQxgF9d/Z7WOl/W8XWPa11fmhw0LNb4vLHI256uNvRf5HC2I9uQS
	TaSN4SJCNfEuSe9/brBJ26BBpZYnKgvX8W5mZWwNtrCyfMwLYZ8Hzt7QjbrjNY8GwbTbjCibP6j
	kNVQYVIFjYxOQ0DfMjFTx1bZceC7k3eK5s3oMue1xmmQSatD7w/bLP/hWBAE2Fb6yegx6eRqA3Y
	wHfQxi1EnL1Ieu6W4tG7yPFHCGxeRzx1FEjJ9hH1Ye0Iexvm+go=
X-Google-Smtp-Source: AGHT+IFpw7Ye8EqgDBoHYXjDVFp96NB4mXnlEykGMm7hHSg9c3xvd1K3cyLgJ0zvPp6p1UEM+WFKSKXcc2UnU9fKjmQ=
X-Received: by 2002:a17:903:11cd:b0:290:8fed:b2a7 with SMTP id
 d9443c01a7336-290cba51064mr438409095ad.57.1761552829221; Mon, 27 Oct 2025
 01:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Oct 2025 13:43:37 +0530
X-Gm-Features: AWmQ_bnuLZFl-Zo9wFQPh5mv4wjIOE1UOzS2nHbBPw0kmkUt1Ft4MkHbj-JLz7k
Message-ID: <CA+G9fYs8fn5URQx2+s2oNxdUgZkSrdLC0P1tNBW_n-6BaBkK2Q@mail.gmail.com>
Subject: next-20251027: backlight.c:59:39: error: implicit declaration of
 function 'of_find_node_by_name'; did you mean 'bus_find_device_by_name'?
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following powerpc ppc6xx_defconfig build regressions noticed on the
Linux next-20251027 tag with gcc-14 and gcc-8.

* powerpc, build
  - gcc-14-ppc6xx_defconfig
  - gcc-8-ppc6xx_defconfig

First seen on next-20251027
Good: next-20251024
Bad: next-20251027

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20251027: backlight.c:59:39: error: implicit
declaration of function 'of_find_node_by_name'; did you mean
'bus_find_device_by_name'?
Build regression: next-20251027: include/linux/math.h:167:43: error:
first argument to '__builtin_choose_expr' not a constant
Build regression: next-20251027: via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
Build regression: next-20251027: minmax.h:71:17: error: first argument
to '__builtin_choose_expr' not a constant
Build regression: next-20251027: compiler.h:168:17: error:
'__UNIQUE_ID_x__286' undeclared (first use in this function); did you
mean '__UNIQUE_ID_y__287'?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
arch/powerpc/platforms/powermac/backlight.c: In function
'pmac_has_backlight_type':
arch/powerpc/platforms/powermac/backlight.c:59:39: error: implicit
declaration of function 'of_find_node_by_name'; did you mean
'bus_find_device_by_name'? [-Wimplicit-function-declaration]
   59 |         struct device_node* bk_node =
of_find_node_by_name(NULL, "backlight");
      |                                       ^~~~~~~~~~~~~~~~~~~~
      |                                       bus_find_device_by_name
arch/powerpc/platforms/powermac/backlight.c:59:39: error:
initialization of 'struct device_node *' from 'int' makes pointer from
integer without a cast [-Wint-conversion]
arch/powerpc/platforms/powermac/backlight.c:60:17: error: implicit
declaration of function 'of_property_match_string'
[-Wimplicit-function-declaration]
   60 |         int i = of_property_match_string(bk_node,
"backlight-control", type);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/powermac/backlight.c:62:9: error: implicit
declaration of function 'of_node_put'
[-Wimplicit-function-declaration]
   62 |         of_node_put(bk_node);
      |         ^~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
   22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |                    ^~~~~~~~~~~~~~~~~~~
In file included from <command-line>:
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
include/linux/compiler.h:168:17: error: '__UNIQUE_ID_x__286'
undeclared (first use in this function); did you mean
'__UNIQUE_ID_y__287'?
  168 |         __PASTE(__UNIQUE_ID_,                                   \
      |                 ^~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
   45 |                 max = max((int)bl_curve[i], max);
      |                       ^~~
include/linux/minmax.h:71:17: error: first argument to
'__builtin_choose_expr' not a constant
   71 |         (typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL,
1L)))(ux) >= 0)
      |                 ^~~~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:577:23: note: in definition of macro
'__compiletime_assert'
  577 |                 if (!(condition))
         \
      |                       ^~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
   45 |                 max = max((int)bl_curve[i], max);
      |                       ^~~
include/linux/minmax.h:71:17: error: first argument to
'__builtin_choose_expr' not a constant
   71 |         (typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL,
1L)))(ux) >= 0)
      |                 ^~~~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:577:23: note: in definition of macro
'__compiletime_assert'
  577 |                 if (!(condition))
         \
      |                       ^~~~~~~~~
include/linux/minmax.h:112:25: note: in expansion of macro '__careful_cmp'
  112 | #define max(x, y)       __careful_cmp(max, x, y)
      |                         ^~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:45:23: note: in expansion of macro 'max'
   45 |                 max = max((int)bl_curve[i], max);
      |                       ^~~
In file included from include/linux/kernel.h:27,
                 from arch/powerpc/include/asm/page.h:11,
                 from arch/powerpc/include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:60,
                 from arch/powerpc/include/asm/ptrace.h:342,
                 from drivers/macintosh/via-pmu-backlight.c:11:
include/linux/math.h:162:17: error: first argument to
'__builtin_choose_expr' not a constant
  162 |                 __builtin_choose_expr(
         \
      |                 ^~~~~~~~~~~~~~~~~~~~~

drivers/macintosh/via-pmu-backlight.c: In function
'pmu_backlight_get_level_brightness':
drivers/macintosh/via-pmu-backlight.c:63:38: error: 'FB_BACKLIGHT_MAX'
undeclared (first use in this function); did you mean 'BACKLIGHT_RAW'?
   63 |         pmulevel = bl_curve[level] * FB_BACKLIGHT_MAX / MAX_PMU_LEVEL;
      |                                      ^~~~~~~~~~~~~~~~
      |                                      BACKLIGHT_RAW
drivers/macintosh/via-pmu-backlight.c:58:51: warning: parameter
'level' set but not used [-Wunused-but-set-parameter]
   58 | static int pmu_backlight_get_level_brightness(int level)
      |                                               ~~~~^~~~~
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_init':
drivers/macintosh/via-pmu-backlight.c:144:17: error: implicit
declaration of function 'of_machine_is_compatible'
[-Wimplicit-function-declaration]
  144 |                 of_machine_is_compatible("AAPL,3400/2400") ||
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c: At top level:
drivers/macintosh/via-pmu-backlight.c:22:11: warning: 'bl_curve'
defined but not used [-Wunused-variable]
   22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |           ^~~~~~~~
make[5]: *** [scripts/Makefile.build:287:
drivers/macintosh/via-pmu-backlight.o] Error 1
make[5]: Target 'drivers/macintosh/' not remade because of errors.


## Source
* Kernel version: 6.18.0-rc2-next-20251027
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20251027
* Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
* Architectures: powerpc
* Toolchains: gcc-14
* Kconfigs: defconfig

## Build
* Test log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/build.log
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251027/build/gcc-14-ppc6xx_defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrlb77LGOQQSoC8FHCiIEAZK/config

--
Linaro LKFT

