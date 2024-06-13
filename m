Return-Path: <linux-kselftest+bounces-11857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326F90745F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E1528334C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC37145B1D;
	Thu, 13 Jun 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJPjjbew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C68145323
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286689; cv=none; b=nMPm3efypgAyOpyh6zXN1cXdhgnbsuhVYwmIg35GyGN1slyLvvkiNJZYxa1hwxZBxnC+p6cofr20hbm93Nm4py31wu67hd70z0fn4zkmE6qgoJr4SEAtqdKkbWq9loLywO4dVHmwmCwO+FSfRLrps9lDlA34BvECZtnUVjXiFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286689; c=relaxed/simple;
	bh=7NG6uQtL8OtRJ9iIAYXtet9++FwRd1n+ZGC5Hg85Cjo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qHv0KTSLyqS+NFm7c8YXJHFg7shk77BDyHMAsasobnkFlFxJt7LqNBAK7dXZfVRiKDaRdON8rzS6XSINoVg3pqqet8LYrzzn4bsowCVPbLuNIGzdlbr0vA2rvdVZsAumQQVZ7hmLagvBlHSbzT+s5e49SvTjwAOXpupk+/4KU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJPjjbew; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ed083c2874so343535e0c.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718286687; x=1718891487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qu/FWTV7834QtugMZZVu5W6bYVpF/xbRojpTSuPeXsU=;
        b=XJPjjbewp9Qun13i1ygc648GEnjGVT0jdN2QJVPBf0uu81bqVTZMtJ2D7inZ28R/IA
         iDfTQoDiLpYLv9dUoZ4dobd05bE7O4MX2NlZshr3o3BAhtEuUz7QW4qbzBqdBbQjJtwo
         Vhg70/9cX42KJkmZzgrom7L0s5Ej538YQZohtDWk0L9YFTnXJBrdpvMwdGtHSd9pK4Fe
         EXVSVwuLMyIgL0zuzenjHWzJyXBg4zUQhO6xVArkOFKzYnL5EPYM0N59P60Hfwp7NtSX
         QERFg8sRM4gPItxq21WunlELRc1kkHYUKuUSPywK4LsF1TKrck+P/IRRYaSlD3d6nh1+
         k6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286687; x=1718891487;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qu/FWTV7834QtugMZZVu5W6bYVpF/xbRojpTSuPeXsU=;
        b=XUrYVIJ526c/V7XMe9g2tvblsQeV3NcYWddE2QbMp/h7cN3ycG2Y0M0jvLPV9LJNYg
         FzP88sGxRyk9Ng1ZVJnmuy3SwC0bbMCBmHu3FWqbyU5Zoen/tT6HLf3IrIW+lg6+GvDG
         YmQnZXFT5KSzX/adSdmBIxbfdotsBmTosszo7mxFIOhha8ASOskYRNw47fXP0jNCPJAC
         RI6dW4MIvollKNijJDS1K2Gx/zf//wFguW6uC/3x9nZuvtlkD999sw8J6tYNe7kzjLMJ
         D4Rx5M571F5lSkCvBPoL7QVDTjrBCTbNKlCynb4qxFzDg9W2ChOG78NnqG7W/Qc4UjBl
         CrLw==
X-Forwarded-Encrypted: i=1; AJvYcCU8gsfRNp3bmxrO2f1X95BJifVk6rzDhfPApD1hqjvgWR7WH3TTB8yQSkqT8fp57vrZf/beLVYeLyTtwtZOE8OCYMzUQjmZR5KOyTJsoOVC
X-Gm-Message-State: AOJu0Yz7jt/yDb+7GiGxPPEd0eTnntKuFa/7yOQ63y9vkCDnMyfbpnNY
	z5uxsVG9rC3FugOA6GYk3TQmpKlXhcqku5llfLILeaUUofXQBXqKKPU+/Wc7XSD74smFlPZ9pvw
	XKovCMlvk2l8K5rDKymfbZ2r14zx5ifSpkSSs1A==
X-Google-Smtp-Source: AGHT+IFt1qa9H5XAsUr+NTtJxBrGKdzFxfLI2hYbTpXslmysQ/glm8BiG+LX1EBRuRywvOkWId2XTxCK7ADRK0UzvG8=
X-Received: by 2002:a05:6122:1cc:b0:4ec:fabd:d4ab with SMTP id
 71dfb90a1353d-4ed07b0fc91mr4556612e0c.8.1718286686932; Thu, 13 Jun 2024
 06:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 19:21:15 +0530
Message-ID: <CA+G9fYtobhBTnH1=2oHxesLfyYd2VGK55nJn+iniWPj2vyNCOQ@mail.gmail.com>
Subject: selftests: arm64: fp-stress: KERNEL-1-0/3-0/4-0/6-0 - gcc-13 - Failed
 - clang-pass
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Morse <james.morse@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

The following selftests: arm64 tests failed on FVP-aemva test and kernel
built with gcc-13 but pass with clang.

arm64_fp-stress_KERNEL-1-0/3-0/4-0/6-0 - gcc-13 - Failed
arm64_fp-stress_KERNEL-1-0/3-0/4-0/6-0 - clang-18 - Pass

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---------
# timeout set to 45
# selftests: arm64: fp-stress
[  269.882519] NET: Registered PF_ALG protocol family
# TAP version 13
# 1..96
# # 8 CPUs, 3 SVE VLs, 3 SME VLs, SME2 present
# # Will run for 10s
# # Started FPSIMD-0-0
# # Started KERNEL-0-0
# # Started SVE-VL-64-0
...
# ok 13 FPSIMD-1-0
# # KERNEL-1-0 exited with error code 1
# not ok 14 KERNEL-1-0
# ok 15 SVE-VL-64-1
...
# ok 37 FPSIMD-3-0
# # KERNEL-3-0 exited with error code 1
# not ok 38 KERNEL-3-0
# ok 39 SVE-VL-64-3
...
# ok 49 FPSIMD-4-0
# # KERNEL-4-0 exited with error code 1
# not ok 50 KERNEL-4-0
# ok 51 SVE-VL-64-4
...
# ok 73 FPSIMD-6-0
# # KERNEL-6-0 exited with error code 1
# not ok 74 KERNEL-6-0
# ok 75 SVE-VL-64-6
...
# # Totals: pass:92 fail:4 xfail:0 xpass:0 skip:0 error:0
ok 16 selftests: arm64: fp-stress


metadata:
------
  git_describe: next-20240613
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 6906a84c482f098d31486df8dc98cead21cce2d0
  git_short_log: 6906a84c482f ("Add linux-next specific files for 20240613")
  arch: arm64
  test-environment: fvp-aemva
  toolchain: gcc-13

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240613/testrun/24304165/suite/kselftest-arm64/test/arm64_fp-stress_KERNEL-3-0/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240613/testrun/24304165/suite/kselftest-arm64/tests/

--
Linaro LKFT
https://lkft.linaro.org

