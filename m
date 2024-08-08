Return-Path: <linux-kselftest+bounces-15002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739494B32B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F2A1F21FFD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259A155321;
	Wed,  7 Aug 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PS1GHYCS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916C15380A
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070399; cv=none; b=i/0Ax31YNDXSnyL3oN4xvG/zqJLiOtbC9pqGdL9+YpSSXiZpvgV5rjLpdgW7ygksAVHvwwVq9NgUKMICaT9GWXM7SM3ca/kFJjb7ImarQ2UpcXHPiVMpfthUxyI5Ow/Nm9UzhfveNh9dI8qePIZhGIECQdbtZoIRiLV7+IdQW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070399; c=relaxed/simple;
	bh=R0SrDgf7L16NODV3yYTuPsDAteT3U+k3VaocKclBG0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CuxI6pUO1u/11vw7RsOXSI50lD6IPVkbqFZd1DFlPcT4jUcyao3DM1xED+obALdIYlhj6v2ae8LE7uSJoE6kYL92fXfqcAE4L9tOD/2oIg4ynHX3liuFyvmysBPtHE69RK3dTu4qmx9qgVXB822kJjNGA35KTjpYb3VudC2h6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PS1GHYCS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7104f93a20eso343725b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723070397; x=1723675197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpaMsRHZ95ToRGUxAfb1zMIumId8sRSoShxy8vDFiIM=;
        b=PS1GHYCSsdhNsf2JH9O5SgvWihuGsWagFQAO8BMu/E2y9eG2/I4QGmCWhbIg7XKQ1N
         S3C43ji3Zv6uqXbbcFmipRiCRMLEK+kxjkFRKJJsTiRLOiN1c1vzUnqun3/v+3sFFgZL
         ySJAdHyEIrAhyBwT8R86GeRfqmbFNY9yUgMes1rqGd1i6jE9J6blpnnFkeJoH0mj1eR1
         LKp4UO/gELnqE7QBOOC052U0+Y/BJ0FYYRuE6SgeMiBfGOxUAyzcSpeNZMfm1ju57kwy
         7/KK4R7ihtdklVAU3gxwX8d/9XjjLVU/x0eC8uLz+nZLS0z3X6pbvj+MU7M92TrPy8tQ
         eI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723070397; x=1723675197;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpaMsRHZ95ToRGUxAfb1zMIumId8sRSoShxy8vDFiIM=;
        b=KRQcluEtpsskGSK3krH89O9idggQwVHT6gc+qr9qFBpN4A+DZSCaiEgUJY/Uh/jvg/
         8ZEwpnFh9lWSjuJVHVf5p9E3XoOQXO2QaTh8TukKdAs5Wu+BHLGhcQfXS2dOJfDHebV5
         dPpV6xG6E2XGqvfyixTTrZYJ9qZQ2cCRbRvaxuuBUfFpHG5y3/zZUHo0KVCvi1DZifNM
         D2p+fBOATMdi5qEFxbogWStP5WkG2bPlcD42CV4LhF3/Pc4PHJ/GMk83XXxt/TOpe94X
         9ymXYfF4ldpM7LNZ9ElGZzi/j7nKzY/QKxQ7ySdTssuYKWSN8Cf4hsTmPVGyYgPeyDdE
         PUeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHJUUfJCV2NZA46ZpgHa6QV6uYVaLoHVopYK5dQ4cmLMPpntOF2g7PmkMin39+P6pf+ZtEhuAnP1GqqN9V2IpWUayWUbJmDtaP7ebKiZa
X-Gm-Message-State: AOJu0Yz0zsZSRMsYrBEfCTkVNNOL4lrmS1TEzyshnOP7zMpNIzy5Dcb4
	hLDTbERi8+qlAQe1g5jySlREmrolZbSJK1id2PttXu6qi80VkthSCaOLxiOkP+4=
X-Google-Smtp-Source: AGHT+IESQPvEwbmsSFYakbTK2ll0Tt3rDUIt6IHjj6Copl3/ebwJm0vHuqLsOiAaukYjvG1usCbD8Q==
X-Received: by 2002:a05:6a00:3cc3:b0:706:6b29:9cf0 with SMTP id d2e1a72fcca58-710cae8d2e0mr108951b3a.30.1723070397365;
        Wed, 07 Aug 2024 15:39:57 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2cc9bfsm12167b3a.137.2024.08.07.15.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:39:56 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 38/40] kselftest/arm64: Add a GCS stress test
In-Reply-To: <20240801-arm64-gcs-v10-38-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:05 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-38-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:39:54 -0300
Message-ID: <877ccsdkjp.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:

> Add a stress test which runs one more process than we have CPUs spinning
> through a very recursive function with frequent syscalls immediately prior
> to return and signals being injected every 100ms. The goal is to flag up
> any scheduling related issues, for example failure to ensure that barriers
> are inserted when moving a GCS using task to another CPU. The test runs f=
or
> a configurable amount of time, defaulting to 10 seconds.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/gcs/.gitignore       |   2 +
>  tools/testing/selftests/arm64/gcs/Makefile         |   6 +-
>  tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
>  .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 ++++++++++++
>  tools/testing/selftests/arm64/gcs/gcs-stress.c     | 530 +++++++++++++++=
++++++
>  5 files changed, 848 insertions(+), 1 deletion(-)

Unfortunately, gcs-stress still fails on my FVP setup. I tested on an
arm64 defconfig with and without THP enabled with, the same results:

$ sudo ./run_kselftest.sh -t arm64:gcs-stress -o 600
TAP version 13
1..1
# overriding timeout to 600
# selftests: arm64: gcs-stress
# TAP version 13
# 1..9
# # 8 CPUs, 9 GCS threads
# # Will run for 10s
# # Started Thread-4870
# # Started Thread-4871
# # Started Thread-4872
# # Started Thread-4873
# # Started Thread-4874
# # Started Thread-4875
# # Started Thread-4876
# # Started Thread-4877
# # Started Thread-4878
# # Waiting for 9 children
# # Waiting for 9 children
# # Thread-4870: Failed to enable GCS
# # Thread-4871: Failed to enable GCS
# # Thread-4872: Failed to enable GCS
# # Thread-4873: Failed to enable GCS
# # Thread-4876: Failed to enable GCS
# # Thread-4875: Failed to enable GCS
# # Thread-4874: Failed to enable GCS
# # Thread-4878: Failed to enable GCS
# # Thread-4877: Failed to enable GCS
# # Sending signals, timeout remaining: 10000ms
# # Sending signals, timeout remaining: 9900ms
# # Sending signals, timeout remaining: 9800ms
       =E2=8B=AE
# # Sending signals, timeout remaining: 300ms
# # Sending signals, timeout remaining: 200ms
# # Sending signals, timeout remaining: 100ms
# # Finishing up...
# # Thread-4870 exited with error code 255
# not ok 1 Thread-4870
# # Thread-4871 exited with error code 255
# not ok 2 Thread-4871
# # Thread-4872 exited with error code 255
# not ok 3 Thread-4872
# # Thread-4873 exited with error code 255
# not ok 4 Thread-4873
# # Thread-4874 exited with error code 255
# not ok 5 Thread-4874
# # Thread-4875 exited with error code 255
# not ok 6 Thread-4875
# # Thread-4876 exited with error code 255
# not ok 7 Thread-4876
# # Thread-4877 exited with error code 255
# not ok 8 Thread-4877
# # Thread-4878 exited with error code 255
# not ok 9 Thread-4878
# # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: arm64: gcs-stress
bauermann@armv94:/var/tmp/selftests-arm64-gcs-v10$ echo $?
0

--=20
Thiago

