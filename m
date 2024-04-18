Return-Path: <linux-kselftest+bounces-8314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0C8A99EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC59B21699
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217181DDEA;
	Thu, 18 Apr 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcXtCurw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3A182C5
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443686; cv=none; b=nhl2HAGeMgAKFsKnxDYVA3sUI0GEITjottvM0eR58ZLP3oEsdRmWVOz+N9I/XqFNXhDKLt2XrwQIXpL23JOdRg6ls3QL/xVqvGywndYsuUJUGN8TpvB2tD04K+zbHVprIUSqUAxwBLh7y0zBeuz0mIK92ZxYOFHH1MOrmSxtw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443686; c=relaxed/simple;
	bh=B+6GB4/OCyyStGw/ue3Vas1OEHIwT7vYsI2tWaOCaHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qaLOwBFy+fp3D6UBOjY7MZRxQgXBOWnmNEHXboEl7+6GKXe9paHZRJB2g0lgqVIBmI+Hyy4gvlcthDDqeNNTM7pb5ojfdIA+2PB0CjWzknqaAnxbpkcHmbN4TRGJqNv7Yb+RuWC4Az9nJzI1A/nLCwGix6e3NgLl+iFj/9yfbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcXtCurw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4db27d21a22so241181e0c.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713443683; x=1714048483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipPrK9EjD6DeorbTfyjfvzjZb+slj22QZKPXwKOud0E=;
        b=lcXtCurwUF/lilyg0KOLTApWbp1zytjntmFJMxgucBCi5v3vNOEYCkFuyY5fZ2YycA
         oOqDPrAI3FXf/vj9pNyCj0e2VClHniN0yBjIb1T/E1ll8u7xhlU1OVAmL8/H6P5YCH8F
         plgOWEjfBcQy/XfiUJDj7hTFjohWosKT7FvGcoX9dP+4uHKyTdl50ZMNVzFREU1lmsP0
         pKQyGonE0wmP4BO7W62fN89nP6igp4zaD3m0yqlmy6yoOrQgqjlFRUd8LQO8aiflMo2E
         IYASxIlo3heVv0crZTIMkutnqRfzLyhQ7hvKlKeMHFfK9bhL4GKvVqgZGGasgfLGQuXc
         430Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443683; x=1714048483;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipPrK9EjD6DeorbTfyjfvzjZb+slj22QZKPXwKOud0E=;
        b=PT4iz7s8/9CX6a4mhyn+Es5yprh4DYf0Nb3DqbkGQhDnUK/n4evBVBdk3C2OVjqzQT
         zghYUbn8LS9Ym+aFAWV+J/SbQHoURFYcR+Uq1UzHNZaLDuM1vMjW17YMbX6GSCyseq4J
         JSiWtfGAlQkWaw+P708mh2+IJ2D+Ht24icJxWKLSoppIpXhbKV4jHHoD15Y9sEZuPLMa
         o0llJ2qd6D1+lKC1F8LkkvkR1NS1MY5+jH8ZFtCJvcbBhsMXeGqPug93bVgzkxHwnbGH
         stp6k1cc8DEp054AbWrOIRs6hnFzv4Uw2ML5qKmm9Emd0bRXL9rFDo5pPkPxwBvKFZCe
         IF+w==
X-Gm-Message-State: AOJu0YyabqDPnPYjjBjarQrNe3kHTQXEGaFtQk9yLK6fNGHoKrqZLQbe
	gzeS+FtSzKbs5qGIirahSTFdoBn6ugCq6n4F/B/yO1UJTgUlkXatrkIRDhZxVp8gwaLataZgBm+
	0q9pCWYM4xaEXUC+3rwjg0zDmhrZQxJSCg+joUMkK5CtjhhkNLvg=
X-Google-Smtp-Source: AGHT+IE3NKjPZchvxKTF6nxS5pBTq01eu1Q3p1+qrHemeOlAnU1tkm01Opcsjyvz+j9/RhVgmEuttM3ePjf773uDYCE=
X-Received: by 2002:a05:6122:507:b0:4c8:ee1:5a0b with SMTP id
 x7-20020a056122050700b004c80ee15a0bmr3133353vko.15.1713443683124; Thu, 18 Apr
 2024 05:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Apr 2024 18:04:32 +0530
Message-ID: <CA+G9fYtukczdEnnqtD4jeHqDYwf30A2RpfK8knB6jaJSE+mobg@mail.gmail.com>
Subject: selftests: arm64: check_buffer_fill.c:94:93: warning: format '%lx'
 expects argument of type 'long unsigned int', but argument 3 has type 'char
 *' [-Wformat=]
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next building selftests with clang and gcc-13 found these
build warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
PATH:
Reported build warnings noticed on following test files,
selftests/arm64/mte/
 * check_buffer_fill.c
 * mte_common_util.c

check_buffer_fill.c: In function 'check_buffer_underflow_by_byte':
check_buffer_fill.c:94:93: warning: format '%lx' expects argument of
type 'long unsigned int', but argument 3 has type 'char *' [-Wformat=]
   94 |                                 ksft_print_msg("Buffer is not
filled at index:%d of ptr:0x%lx\n",
      |
                           ~~^
      |
                             |
      |
                             long unsigned int
      |
                           %s
   95 |                                                 j, ptr);
      |                                                    ~~~
      |                                                    |
      |                                                    char *

<trim>

mte_common_util.c: In function 'mte_default_handler':
mte_common_util.c:41:101: warning: format '%lx' expects argument of
type 'long unsigned int', but argument 2 has type 'long long unsigned
int' [-Wformat=]
   41 |                                 ksft_print_msg("Got unexpected
SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
      |
                                   ~~^
      |
                                     |
      |
                                     long unsigned int
      |
                                   %llx
   42 |                                                ((ucontext_t
*)uc)->uc_mcontext.pc,
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |
               |
      |
               long long unsigned int
mte_common_util.c:41:48: warning: too many arguments for format
[-Wformat-extra-args]
   41 |                                 ksft_print_msg("Got unexpected
SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

