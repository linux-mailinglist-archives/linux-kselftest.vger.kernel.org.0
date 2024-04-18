Return-Path: <linux-kselftest+bounces-8305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A448A9657
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 11:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD211F22E42
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB115B0F4;
	Thu, 18 Apr 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhsXI73V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F015ADB7
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433090; cv=none; b=ZBAPIH8JTExWMRtrkXdC3QoQon3a2Xpep2MArC+sWpb1kbfLoLzDr1GY5b1npLGc/2kK85LE3I2R0QLgptbJXlEhrFoGD7XGYf385ZIY+LDy9W16i2+G4ee5Cy5YK7wfl81GRUttf6/oiqkGaelTCgEwY5xLGhvwVjhjJ7IxkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433090; c=relaxed/simple;
	bh=8ShK6BZyhaLHMQr2Rr9oA5Mcbeoqx2IAhm4x1HZZarY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bal7mCiQ82DOGJ7lDvpTQ3sN2OMsfyNgDMSCmWdkA90wWvuSc10XKY5Hr5xOfBmECApjW6e9B1pdgM4XV7t8jSGipiSAroMqM5NkQbNRJnQVzKzA5eDqfAShXuca9+nTKjLlSWNDqx754rRA45ZLzT7EBXtuL+JfW/OjjTIONG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhsXI73V; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dcf9659603so175717e0c.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713433088; x=1714037888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mFeVdDbx/Wm34+9Q/l7q6aDREQ/YSdgqO8vqBbzLk1U=;
        b=mhsXI73VMPWUEUoYwOKdhcm25q6sApNfMi4+JI243+p4o7OZSdviVUSedRHUscUK+k
         j8J7Pnca/Abv2qITf4DQqs7cT9yr0yADQwzcyHvgNf4pIn5ladBM6Oa4O34wNg/gvLBT
         XIqqKQedTV4ghDHUDLogMsCD4XNYVRznbqCIFE8a21PrkmiBZV1FE/jE0jpKONqIB8xO
         PCEBbTybI8o4f2eur37erNZTn0zv3scv3GasA0aZsd9pf9qgVnqg4Aq4a010SPmzYmzb
         xiljnkW8XCEhlZhNWfUTP+TbpfLPdYVfd9eECWZGVby1izJ8sYWEe7AZ/DPlDTrMaJSa
         Ln0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433088; x=1714037888;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFeVdDbx/Wm34+9Q/l7q6aDREQ/YSdgqO8vqBbzLk1U=;
        b=YQxU7B0cFvtdZ1m7V3fYFgQPSGbOFVJrGBb2I6tRI23mAhoBy2r4Ymmt3VDoZxbqmu
         6lxvcoSBgl5A1rdhaLvKamZQUe5Vu40vqJvmatF6Ot0gHUimUuQbZZohPDmCbUA2nTvU
         r/3vltoDEFgif7Vqi2coYMQ7Gxd+VoX8hs0rNUVr5/MuUUKjNxwzfdbNkszA4NfxBszT
         HCr+lFEjSUcLpWcOU+iYbQdgso6cQRA0QyJr9a5Tv7JeV60RUExIqtVg12yWMbYhlKQC
         COYjjH6fHmwj/9/bOvlZO5XX3Y0JKAx/F0d0CCKfuZSvtiWaHsA5akzycyX87K2zxhrn
         JjHw==
X-Forwarded-Encrypted: i=1; AJvYcCWEDt5uVw2wgsf6GZzXSpEB+gzhNGKXwKl4mW61TSo8dX0ORwNe7cefgDAbwRO7G+hwQHKFCWAdizon0T6O1WmbClDyB5yTVEpWsdpcm7wC
X-Gm-Message-State: AOJu0Yy/g4f4IdWVWXBEGIGBlS26uUUFWEX+wkSzndZu7VtF9dtxqL07
	xxb2/WQfcXdR60/bLzH0UpCFViQm0fFq2Adwm0lFO7tsb0L8aR4O94X/2PU5QZoUXTJVZChfIcP
	usuK6HgpKu1uGZRhofb73obhCym4cXYb+bcnK4SrGHE4uuiteXrw=
X-Google-Smtp-Source: AGHT+IEoDIR/L/aazTWb4Qg2+VKVTMbhyKp0gSJZ3qS35wjNaK3q5yTn60lPAs6KLT11MyJ/yXVClp46VBRESQ9PGlA=
X-Received: by 2002:a05:6122:1da5:b0:4d4:17c5:8605 with SMTP id
 gg37-20020a0561221da500b004d417c58605mr2452601vkb.7.1713433088326; Thu, 18
 Apr 2024 02:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 15:07:57 +0530
Message-ID: <CA+G9fYvJ7=rahqJ9g35=XzEvAq9+zAiq8PNhBE-ceb2EED2gnA@mail.gmail.com>
Subject: selftests: resctrl: cat_test.c: In function 'noncont_cat_run_test':
 ../kselftest.h:74:9: error: impossible constraint in 'asm' 74 | __asm__
 __volatile__ ("cpuid\n\t"
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Shuah Khan <shuah@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with gcc-13 found these build warnings
and errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
Path:
selftests/resctrl/resctrl_tests/

In file included from resctrl.h:24,
                 from cat_test.c:11:
cat_test.c: In function 'noncont_cat_run_test':
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
         \
      |         ^~~~~~~
cat_test.c:308:17: note: in expansion of macro '__cpuid_count'
  308 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
         \
      |         ^~~~~~~
cat_test.c:310:17: note: in expansion of macro '__cpuid_count'
  310 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~

Steps to reproduce:
---
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/config
\
  debugkernel dtbs dtbs-legacy headers kernel kselftest modules

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/

--
Linaro LKFT
https://lkft.linaro.org

