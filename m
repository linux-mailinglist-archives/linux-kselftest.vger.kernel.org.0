Return-Path: <linux-kselftest+bounces-41265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CAB53C2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BA1AA3C6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1B2DC794;
	Thu, 11 Sep 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhBTEhlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F101257437
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618341; cv=none; b=MaTnugiuNn8VmkP4fBG1LHwBuGE8rnbSt65GJewdsS8sQ/CBUL2vFDpz3W5hn/yqCWBcKcol6TXsJzEnNDSrazE9IOe0tsFVylSN8WCPZHSIuUqeR6fKKmb+kXYKMyy5qcCEML41ZQjCuuZOuX0bwjOHwwLBJas0YfhWmnSrwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618341; c=relaxed/simple;
	bh=/Ke+Nb1gsfRDyew1MtLRw+g0cKYvwkI9gUaQtMkfHhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AQsfGiVxmXV+QF3a4oimovPlT6oZlrZLTMs9fiNN2MR2uW1tHVKsKvUjA7CGC8+X8ImLH3JO7CMS7VQuJFBz+gIVWa6uxDjP6SdBHQHBL9Obqem6O14dWgiDPu77D8rRkRsXgwDtOX4RghpJ3Rf0LUFg7nz4J16ItqUn9vVzAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhBTEhlo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2570bf6058aso14685765ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757618339; x=1758223139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMzXnLutBDyDe0cFRFFwMkAW7rZFHmfwIn2gFvrd1lk=;
        b=HhBTEhlo91F/z8s/YWhnCFAAItY0ag+FYMpIyS8PKv3K9LbiyiIXXWjpUl1XduZGSt
         eJDaLqXskADYkvkfvTC+kxhWDFbNU6MXAlUBLiAXCvXDF3MbKMdP65S2DWPmZ6pJmt8+
         rsn02XrZ15QdQorR/VFucKhbRrwAfe56jwXDGp/dua3FT1wdrnJLNLSEX6F4r50OTxvg
         pWuHfDBWJ6qHn04Vx3NuOj9F5u2qtUzmguwYErYki1QD6sMxyIVKkeBBsjhdImLHjAJZ
         i5agY+LsJII9QjgCjygXMuORb+JTWSDXUgwILmmVyq3xWIZ8nXl9bA1OdRFQFszhsy+2
         ppEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618339; x=1758223139;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMzXnLutBDyDe0cFRFFwMkAW7rZFHmfwIn2gFvrd1lk=;
        b=IlP/SAlepcOnPl5//eC2MPh9/dk0FTYxqnyYfY3QbBLtoN6ufbPDfyIdQi0aJlYU9p
         caUDuG1bR1YHwxrsIH5udM9QpTwYXK+fvwp7+9qzlxUzkWrxIanmM8KNYtf4w2EawGFd
         AqGyIOK0GSnb58BNU7Qk0QHaxZp/m86quwzwr4QuIT38EpUJECIPnbaeK9PBt0akrbsK
         ZVjAGBzz35aByn9ySOJwrbU3YfBd9C/bcROU+Jy+UrahQi2PuedESKZfvH9f5YnCK4bR
         pOOSiopSnQN7TxRGqEkDxBzW7XUyG0nHIupfzer4uUGiECAYyBDUCNH5/8EjAwRU5emX
         uFhg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOnUEPza1pWrGg9SxF0kTUfU7SejtfO0hiTYEpFbznRAfgLanhDzxN/wdvl6A92Ymydv4HpOg4A73xsoucqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiSLWBjK0jIvfSLs/rXrljpaB/3ETXHzz19Fui3FZ6Q4Pn6Vp
	9L3hT4vyEIDLtgP3NxBvk6hYOwKlfDuKczj3EWlEmR/t6hAJibY8n4gMf+PVeLKnhR80U/IyKmo
	hvEJutrQ32DUbdwAow/F88uP5CKaU6ls2IXTxPaIt/g==
X-Gm-Gg: ASbGncuUj563fjkpUMabykqIdI7WzhghRVHJVK8mlgUKETcMOse1hZRhwmUfYMjKWmQ
	Z2+Xp2MZcKcg4uwUVNZZXaL97UalL+XkJrmzTC+yeVdb5JsgQLteC6X1BBkUoQI9BzpNIZT0pgc
	JMVRFVP2wI2nMoXPKrPEWyOSlTMLZZ8V0Lck5IY1X7gzBgQ8CXNkdSxUTTzxXQO2LMKB2eVz24F
	qo7wKiaH1XoTxq0+u4I/n2z+ko9CiSsPgWZoDSNJPjLKu0WTgDaCwH+0SBRPl/2rD2oyg70ivEv
	j5wx1g==
X-Google-Smtp-Source: AGHT+IFcvNFERCt1pxcRVC0LrxIO5qX9I6ZaHaKu41AXHxq/mmXTSKA/Xpf/xNIANgUEzlw3GdicyiK9s1eIUs3kKeA=
X-Received: by 2002:a17:902:f60c:b0:24c:c8d1:2bec with SMTP id
 d9443c01a7336-25d26a50ba4mr4742195ad.40.1757618339416; Thu, 11 Sep 2025
 12:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 00:48:47 +0530
X-Gm-Features: AS18NWDec12kyfne2e8LlQ-fqp880gCW8MHrmOTo3P_JiNjAs1Vmr9Ipa42F9ss
Message-ID: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
Subject: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use of
 undeclared identifier 'HWCAP_GCS'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on arm64 defconfig
with clang-20 and gcc-13 toolchains on the Linux next-20250909
till next-20250911 tag while building selftests/arm64.

Regression Analysis:
- New regression? Yes
- Reproducibility? yes

First seen on  next-20250909
 Good: next-20250908
 Bad: next-20250909 till next-20250911

Test regression: next-20250909:
selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
identifier 'HWCAP_GCS'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
identifier 'HWCAP_GCS'
  390 |         if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
      |                                     ^
1 error generated.

The suspected commit pointing to,
  kselftest/arm64/gcs: Use nolibc's getauxval()
  a985fe638344492727528e52416211dda1c391d5


## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250911
* Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
* Architectures: arm64
* Toolchains: gcc-13 and clang-20
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29827060/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250909/log-parser-build-clang/clang-compiler-basic-gcs_c-error-use-of-undeclared-identifier-hwcap_gcs/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/config

## Steps to reproduce
 $ tuxmake --runtime podman --target-arch arm64 \
 --toolchain clang-nightly \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/config
\
 LLVM=1 LLVM_IAS=1 debugkernel dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT

