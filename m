Return-Path: <linux-kselftest+bounces-8313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7978A99E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F15D1F21E54
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BF44C71;
	Thu, 18 Apr 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiNk++DM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3439877
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443526; cv=none; b=Pg331dLpXv/KoN6ImRlNONFxyVoETrYEEIM5ZKVgVHblDm8PL9ip5GksBk5Sk9XpOQq9agP3oWeUfKytYuFu1jLJjQ94V55Gq5BraDPPgFLEfi9GpPhLJAHuEgKfX6T7h37JUjlYS9YJUBDJHfGme+Te7swqfbobbgipfNWDqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443526; c=relaxed/simple;
	bh=YqqjyI4oiP/yXAptquTGZQq4WuZbwYBddBkxs2Tq4zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WXPjOfO2RVHlN5iUxAd9FaK9K/l8vdLA386EOyMZWf555qZploXFbA00gsnm7Fc51YVC1/PhQvJqyb0prZaAQWP8XZeTdzhlEQKEBkOsYtjDTF9vChZvql8yxapZpzXSR9A0ac3OEfsOflRLMQQl1wqcAZvjH+3bD7DQut4Skro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiNk++DM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de47485532cso217493276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713443523; x=1714048323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hBMrt7abAHFg6HP/pUKNzKWG1Ya5Ou5z4dVSJW9qzG8=;
        b=eiNk++DMQvBw5xRdOMGTBeypQrG+B4tp4NgmG1m+Uvd5JXFloHaWnrIdW8nZTUA+4I
         stg8hqHfTkAuFAwluKRLf41fpwBjRNkSwDbY75f0uMYROo5dBSHZ9yI3wtPdIrDi4BUv
         7xF2qQ0Bl/E6frJHlxMVShQpTUYP0gNGCIHXkRwxmC3KfHnBaGPCqpst9F/r9IULt4VP
         bNPLQOqamJllqFKZ1Piew1jBW+2qnRIApo3u/NX3buQjy13iLnvSDMNvk8Se7zbN7SEr
         xJ9tus6KDJsYWquOglJsr3FSi/83G2jKCCVcFnDnTNfRO5uT4ZUv13eJ78UpU5YSYBr2
         8fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443523; x=1714048323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBMrt7abAHFg6HP/pUKNzKWG1Ya5Ou5z4dVSJW9qzG8=;
        b=G5zoueR6uhOMPy4GDMkSzwLV2Q9s6ZhQ2hI5osPu8BJUa89wLIsMI/YHGjFaC63P7P
         7tCODwdITuyVChBB4FewerU+oXXrRLo8x8uKpFYHobpETThskhpIwTGTO/xpbrENxGox
         fPO1+0ssbwsYJumF1sY43GGw3nkYFW/hRgoWpqMW3mJeKJPKf79DXLp2ekiPW2d7wTWO
         hkfa7Aj5UbUNkMpPdP+FXFR/iHjZFZRNiXJ05dmoLy7FU5nFbLrAHjFQEkv/YQNHhWy0
         mS6vTlzkB4CFntym4O9KQ6P6bDI4A+3X0PewZN6fdQZpo0MqhweFZO7lg51EvBRi9gCK
         5lXQ==
X-Gm-Message-State: AOJu0YxWvrHS5WUI8meHNhoc3lFtHNjSpKC2suSk8PdhsczFW76oeCuU
	sqe+KqnnJTAADlIuZG0Dqg2w0xK0GgZAiiuTVbuh/YUCxH5fEQPeN/72EBB6ALagS4g3JyXdtbe
	LwY/PdKocLOOmx6tpd1GXboUUMqztFuquQr8873Gklf/vHFd88ic=
X-Google-Smtp-Source: AGHT+IE8M0WQNPrcBCZmpPscuxyU5gGtU5Y9ThtsKAZHFHZ07Igffy0ScmGH/QLZC38vl1oUYNHXJhm+5CXWUXMI3kc=
X-Received: by 2002:a25:8052:0:b0:dc7:4a05:ca33 with SMTP id
 a18-20020a258052000000b00dc74a05ca33mr2301879ybn.64.1713443523047; Thu, 18
 Apr 2024 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 18:01:52 +0530
Message-ID: <CA+G9fYsMhzDCyqCPoZ68oMUV5tMbMmi5qF7_C+55Ec9h6YfXgw@mail.gmail.com>
Subject: selftests: arm64: sve-ptrace.c:85:40: warning: data argument not used
 by format string [-Wformat-extra-args]
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with clang-17 and gcc-13 found these
build warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
PATH:
selftests/arm64/fp
The reported build warnings noticed on following test files.
  * sve-ptrace.c
  * za-ptrace.c
  * zt-ptrace.c

clang-17 warnings:
-----
sve-ptrace.c:85:40: warning: data argument not used by format string
[-Wformat-extra-args]
   85 |                 ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
      |                                    ~~~~~~~~~~~~~~~~  ^
sve-ptrace.c:88:40: warning: data argument not used by format string
[-Wformat-extra-args]
   88 |                 ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
      |                                    ~~~~~~~~~~~~~~~~  ^
sve-ptrace.c:344:11: warning: format specifies type 'int' but the
argument has type 'size_t' (aka 'unsigned long') [-Wformat]
  343 |                 ksft_test_result_fail("Error allocating %d
byte buffer for %s VL %u\n",
      |                                                         ~~
      |                                                         %zu
  344 |                                       data_size, type->name, vl);
      |                                       ^~~~~~~~~
and more

Gcc-13 warnings:
------
sve-ptrace.c: In function 'do_child':
sve-ptrace.c:85:36: warning: too many arguments for format [-Wformat-extra-args]
   85 |                 ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
      |                                    ^~~~~~~~~~~~~~~~
sve-ptrace.c:88:36: warning: too many arguments for format [-Wformat-extra-args]
   88 |                 ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
      |                                    ^~~~~~~~~~~~~~~~
sve-ptrace.c: In function 'ptrace_set_sve_get_sve_data':
sve-ptrace.c:343:58: warning: format '%d' expects argument of type
'int', but argument 2 has type 'size_t' {aka 'long unsigned int'}
[-Wformat=]
  343 |                 ksft_test_result_fail("Error allocating %d
byte buffer for %s VL %u\n",
      |                                                         ~^
      |                                                          |
      |                                                          int
      |                                                         %ld
  344 |                                       data_size, type->name, vl);
      |                                       ~~~~~~~~~
      |                                       |
      |                                       size_t {aka long unsigned int}
and more

Steps to reproduce:
---
tuxmake --runtime podman --target-arch arm64 --toolchain clang-nightly \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3nAXzFH2GOEle3S3MVC53A9/config
\
  LLVM=1 LLVM_IAS=1 debugkernel dtbs dtbs-legacy headers kernel
kselftest modules


tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/config
\
  debugkernel dtbs dtbs-legacy headers kernel kselftest modules

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3nAXzFH2GOEle3S3MVC53A9/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fDW3wG8BqWxf0afUI5f4wkArPi/

--
Linaro LKFT
https://lkft.linaro.org

