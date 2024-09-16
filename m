Return-Path: <linux-kselftest+bounces-18045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82197A7AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA37B28A322
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82315855C;
	Mon, 16 Sep 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu8E3QFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5E4C3D0
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514253; cv=none; b=AyoL2MEj3B9muzaGV/fXMsv6u7F46UeqoGixSER3mu0Mq4syZffAEHVCNzYq9QYx7HC+jBFDLLiODLNWAXl63oFdxCDuY8kJwHChOMOS9TCP4NLi70rgX+lUdf6fDIuaROJ0w631+Kk0Jg60VphOEMUUFMXoPiJaxLJjGA1Un4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514253; c=relaxed/simple;
	bh=e0ST16hFS8BD4t8TE1aEuiovt67c4WgIofkhonJHDoY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=clTCsBSTK1NAjej7qK4QAeVSNZymDcFYf0KlFKtC3PoU85gsXfOVsFB4Ih8rNvN2qsWy2Ivho6nILRGYYGMkTTSghIj40OqQ8qn55sDqh70NG5hj9+YtR7eyWxZ8R1oYQXdvw1BSgdsDmAkN4YnwEHbo8yWOvhjLnPFImqCLmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cu8E3QFg; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846cdfbb153so1231259241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726514249; x=1727119049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vqx3usVPpKT0iyvBpApWWwNta7RIraSs6wvkWJ44Agc=;
        b=cu8E3QFgjarVLCsTJS+Su0+l3NIcNuNMDVmy1Kj6YQthEV7OmV/4kE7W3fYjnBEGEa
         YvuF4ej5QOUN9oEGah5oK2MqnxyYhr1j5NX4/d+GMSQhDVD3ajYSOKTysfeMD+Hzojzn
         4y1f/so7MvdbreLZq/Q6nCt1iJPkyh3OmAORRgkoWAFVj43ZXxcaG7vFCVhOI8GDFyzX
         uYKikj0Z8SOpcbvK0YyKreI/WpZY6acG3jXFMRYhkzH7ZBCyzf09Ly5Y1b1ZR03y4oSA
         2z+WjuP1EEdW2+f1wYVUkf0YKjx26hG2QeEQgC4oyjN4A1S7qzTQwGkIe4sr3ZRpkL4s
         hw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514249; x=1727119049;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqx3usVPpKT0iyvBpApWWwNta7RIraSs6wvkWJ44Agc=;
        b=QZyrZT1SK0PY0vtReyyGRP57aTN+L74o5ceEpI2WlclAKqhrM1pmQQu6FWnpQjWlVx
         UfNPsv5doWOw+Yiv7ZxcncAN1bU8MsbX2Yr16SkeHVDpDG4EZAPkJikeiRH4CdoGM6my
         utTnYGRou1fqejWaNiHKei7wQ+rUo61MfsJBDHXegkdFLTd+E8ZmQHNi7qma4ucYxhBk
         H4QlC7ylMvg01CXqGiOX1i0Xq/zyvpKkhsuTsHI6mpVf7qHVBeeIUXxDhvpohaOrabIm
         bdP0yv/WxbqkDxE5wqKFX110b6mibdmDECGLvexmR4Xw+t8+E0qKzMbcMnVh+w63BQYu
         ZbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXig6TfWJfUNtuutZ3/aVYaDVbPnCPOrV7oVNkSzauqGK0yB63fvOPeA8x70ccuTHydj1ICixwJP6VsjmJKduY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTgu7OYYL29m/mP43Rdi75XvRN74aAG1KmyUkwcTNaay59JBv
	SkgRe8g9ESzWWo8UAf/gMM9lQ0GKcpYGeEVry5hpF74tJO1glSdPpLCf4elZKDYf/Xwm2Ysomms
	D4c2YJvfGioQ0m4dTRTO91n40bnKLSjTRJEbeDg==
X-Google-Smtp-Source: AGHT+IFS9//ZCamdnpFlaBqZvxOqDw7qKjCs+is9WBT+P2HGRgdKr849Izo3HFvk8azXHKlcu7vS45+Ic9quvSm42II=
X-Received: by 2002:a67:f41a:0:b0:49d:43d0:9913 with SMTP id
 ada2fe7eead31-49d43d09d07mr9444822137.19.1726514248829; Mon, 16 Sep 2024
 12:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 00:47:17 +0530
Message-ID: <CA+G9fYuaDUCxseqCW8BO0KhLKn6F0VHYaAhu-T9v-MJHzJebcQ@mail.gmail.com>
Subject: rustgcc-kselftest: error: unknown unstable option: `patchable-function-entry`
To: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, aliceryhl@google.com, Shuah Khan <shuah@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The x86 rust gcc builds failed on the Linux next-20240917 due to following build
warnings / errors with rustgcc for selftests rust builds.

First seen on next-20240917
  Good: next-20240913
  BAD:  next-20240917

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
error: unknown unstable option: `patchable-function-entry`

make[3]: *** [rust/Makefile:392: rust/core.o] Error 1

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240916/testrun/25144919/suite/build/test/rustgcc-lkftconfig-kselftest/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240916/testrun/25144919/suite/build/test/rustgcc-lkftconfig-kselftest/history/

metadata:
----
  git describe: next-20240917
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 7083504315d64199a329de322fce989e1e10f4f7
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/
  toolchain: rustgcc
  config-name: rustgcc-lkftconfig-kselftest
  arch: x86

Steps to reproduce:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/tuxmake_reproducer.sh
 - tuxmake --runtime podman \
           --target-arch x86_64 \
           --toolchain rustgcc \
           --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9CHpK6gWVXL2Rjt0R5TdMRwKg/config
\
           TARGETS=rust debugkernel cpupower headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org

