Return-Path: <linux-kselftest+bounces-39299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEEB2BC13
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930691B61A96
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B73311592;
	Tue, 19 Aug 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS0bKH9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAD3115A9
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592842; cv=none; b=fpBHIZB02YMSURakWFhLg88ACSGdJBKGt+qk8wYfzrcKqzHJm3C7U+4ev+G+eYvT/+AWvp5SeiW4Sq+Wphyj7CvpAL2IDm4OCubRv1o6w06VYzr8kW6gHYQ+1voIgPFLABhRUJGos955gI1tM2vcibDLSNThLKnUykLjDN5Xzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592842; c=relaxed/simple;
	bh=s4rCdNrJl4PbZFUL3SQdLxne9G64dePB0cGlGicB9/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RAgB5TNgWQQLY75jJ3lzYKxszXFr3VTbraKmb7sGqHhDwPo3/KLVtEx5P6b7SW4LPbw8/y5V8v/G2HREcyzbfV1rl7sFtMIkOeKkENXzCGSkUkI9lA/YH8a7yIPICNtnmwTK6SZ/gQgBrjqtMD/ivczcMr1JEpXCQtqdtNT1804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RS0bKH9J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e8aff06so3935102b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755592840; x=1756197640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fOvEbU0Cnc0FjNAEZg7vmgeVRfzmShXkhUtYM2eUAbM=;
        b=RS0bKH9JwTp4NOYDbvLcuQAXEuro4ovoSLC0dfi/6W2kyEufHBw1EFh83wvL0PAXTS
         tt8KUdOhe6G09a/F+EBJ40jx22AiMiDn14nUmebvCSDugwk1xNlgwFER/gaGJ6E5JgKZ
         WIL2E/4hFeICmZqBx6H4I+0d1NNbd1yarUof7T/Z/9/qo9VIqaoIjlycw1BJ24oDcHzF
         eZ4gOHfyQW6Cs7QJuuDC5TG6YcpWeOCLCaJLEgJQm6q83VFrXm+v+plD1e9QwPen4SV1
         mPLy7kbAIzxqqjJiEC1MLycIY/mjdU/QvyJ4/tAysXwXxJRYH3vhsIwmMtY3u/41kZ4/
         WOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592840; x=1756197640;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOvEbU0Cnc0FjNAEZg7vmgeVRfzmShXkhUtYM2eUAbM=;
        b=ASb789wHatn341lSMAPsNGnErZQZGM/+M1Jm0lZekbqI23iOIvKvZfOHLbGYQftFhn
         faRYAn3o+i3Ys056lgF8gJD4n4vMu6K6UxmpfxNa4JGYARoyVltVn+mii9IqL2nBfBJu
         uSMR2F+7sHE/XHx/jLapOItArKd6m1Yhw3fu/10coOfjSXyxY3PnRHPzgCgBWSLqP3Az
         JYgs/1nq3TDmlfsVn4A4Ak116Cy/BZhtbleunE/iYxtzS/NuEOX9kJlIMNFMJowcKbJ6
         OR7EOR2+wQKqcRdenJfMiUltb5JaTXPNY+2cJ9Bun1fsKMw+aLkKYJ2w/tUyc7OSqOLt
         Xubw==
X-Forwarded-Encrypted: i=1; AJvYcCUYECWzwgRKlb1coj9U+7g1IGSLjyQs1ImxfvmGyrXWlm+h29PdWFhL5LO1hSM8Y09373F0tYmSJBXJoinLhv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVHoX8yYClzGa+/jeCusrTtVUTpf4e3x//kBcJPIo0Wo/kCi4
	87/joZL6nOlB2wwMgjMFeN8s99vI5Gz6Nsb3C4BPB8ZvTtApE0ju3KYeY6evauPXDdCHSny2mqO
	J5oNreOK6Fdul32Wqd4fwNbb0geUz9FwuQw2UHD1p+w==
X-Gm-Gg: ASbGncsMhfXead7YbU/TavOF8ou/4NfWD/8k1NtQF7tebFAFz7hhsA7RwNXzQUQ5jNy
	mI8itWgCIly6/XNehRJJASjhG9AvBaA+Ybt0G0j0PPsfCigGDrbT5eyPJnu6CHiXOyjwmX5V1du
	zekKngF0B8VHI2suIqRNm7nJVjvOcxTAd0vh10Z4YILtrfjjqxbUb56+qcvJsWVc6uWM5XpU95L
	rP05PVvWw0Ljm7JH6JZ50xuwhU3hi0AN99iMzU6iICnJcR6Pg==
X-Google-Smtp-Source: AGHT+IEGGBLrKnJA5rKPO3tG/2IpmKWfgJNSJRlHDGAPjusotj2Hf8o9mNnZTQtC90ugTktRZGVV8VN9rh1Puc8/i0A=
X-Received: by 2002:a17:903:1ce:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-245e02d83f7mr22374655ad.13.1755592839617; Tue, 19 Aug 2025
 01:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 14:10:27 +0530
X-Gm-Features: Ac12FXwQ9ahb2ew69m1KVEd7V2w8TSXSPCLlnKGNCFNH7jf-h193q59E6JrscyY
Message-ID: <CA+G9fYv+gELzgcL4y8rOQbTxv2Y2JQTFhNkgUcLbzPJ_yDTziA@mail.gmail.com>
Subject: next-20250818: rust: `ARCH_KMALLOC_MINALIGN` is defined multiple times
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rust-for-linux@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Build regressions were detected on multiple architectures (arm, arm64,
riscv) with the Linux next-20250818 tag when building with Rust-enabled
configurations (rust-gcc and rust-clang) from selftests/rust/config.

Duplicate definition of ARCH_KMALLOC_MINALIGN in Rust bindings is
causing build failures across affected toolchains.

First seen on next-20250818
Good: next-20250815
Bad: next-20250818 and next-20250819

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* arm, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* arm64, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* riscv, build
  - rustclang-nightly-lkftconfig-kselftest

Boot regression: next-20250818 arm arm64 riscv rust
`ARCH_KMALLOC_MINALIGN` is defined multiple times

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
error[E0428]: the name `ARCH_KMALLOC_MINALIGN` is defined multiple times
      --> /home/tuxbuild/.cache/tuxmake/builds/1/build/rust/bindings/bindings_generated.rs:125708:1
       |
5305   | pub const ARCH_KMALLOC_MINALIGN: u32 = 8;
       | ----------------------------------------- previous definition
of the value `ARCH_KMALLOC_MINALIGN` here
...
125708 | pub const ARCH_KMALLOC_MINALIGN: usize = 8;
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`ARCH_KMALLOC_MINALIGN` redefined here
       |
       = note: `ARCH_KMALLOC_MINALIGN` must be defined only once in
the value namespace of this module

error: aborting due to 1 previous error

Please refer the full build log information in the below links.

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250818
* Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
* Architectures: arm arm64 riscv
* Toolchains: rust-gcc-13, rust-clang-20
* Kconfigs: defconfig+rust

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29578517/log_file/
* Build details 1:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustgcc-lkftconfig-kselftest/
* Build details 2:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustclang-lkftconfig-kselftest/
* Build details 3:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustclang-nightly-lkftconfig-kselftest/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ/config

--
Linaro LKFT
https://lkft.linaro.org

