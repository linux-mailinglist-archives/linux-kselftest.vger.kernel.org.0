Return-Path: <linux-kselftest+bounces-11027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE58D66A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18D6B24A22
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5876158D7A;
	Fri, 31 May 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="o0P9RZGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FC3D57E
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172299; cv=none; b=ZwXV/Ygo1JOCUa9W+m0abGOV7OSbZ1BH/Hk/SZpkroYwf1yIG4stYnN4pFGDDCxl4C8FcM6hDZNCDtqmCAH1MCAlaGM1aZ2ezg68s0cpdE4Wl80BTpBdCvOtxriFumWyWmJtDTRaKUJmpb3fZbgkyMFoxqisttT18kY06BI3elU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172299; c=relaxed/simple;
	bh=mqgheGM7nu9DLGBBTxrSzl2O5xc5CZyvGSNFoquut/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=iYJDTmG4vb22cKVODaDcXlpfnMJRn7HPDKn1o7gfZEkYjHTOAf7uSGMUGuPnblxJzq4u/zznFIHCpNrfAxXA5fR5ts+dVFkJ7c+LpwCPd9SJMT6IviDs7CqLrx4Sa/Q8pyGJ4OgWNrplxwKWrE2yWin8dQ6aD8e34LfMqxfTGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=o0P9RZGM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c1a99b75d8so1658454a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717172297; x=1717777097; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kW96VJlm3TS+RUfwwgb6/V4LYS5TfpLnNCjSZp6ZAL8=;
        b=o0P9RZGM+AAOrf1MMzZ8blZxU4rAzr4pDmeUKDylLb/vGHTSt6HTSHuvSb8p41yo3k
         VEZdqStnhDFRpAW6b31wICsdwiqilwnDgQBDpGze18+3SZ8VHQzR4AJblcm9H6n7jlLy
         qnQwLYyURF412UgAa13PPzmljli/nwSNQLXNX030WxAMpx5NwfKzqp63qRtlo/rZAOTe
         9nkf2syLoVtCBXja2MU8QaI2Qo8yKUHUYoYjVC/0ZfO+xUy509kCH+7VmgrqhQBPV7m1
         ZJ+FYDWNwuBWSML/eBdwuCRr5N3D8yJHXCW5H40+k8sohSh12sjinB5nYfpKcAhCkyEF
         7VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717172297; x=1717777097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW96VJlm3TS+RUfwwgb6/V4LYS5TfpLnNCjSZp6ZAL8=;
        b=gFQRbE26/XW06mONE8itfuoOna6u6eJw1cOZu+Oe9VbNkTzpeDZaTqpQXmLJ6d0GZt
         oJ2Rm40KusGPBwRZRGqVbAy3/cMhAWNUGjU0X3+6W6gCe9w1F6fChNwwToG3YAJ2c69E
         mbLOsBuihVVmD1MlHKfdvTZkY7C8R41l17C7K8Nnyrs97bHfrs/F4qraR/LlF50hddJp
         BlYg8z2XGZiLIVtbJMrjNURRLjudQb7Fe9iCedFInXr6iFpSboUNgoepeIh7PkP64ScO
         cR1f7dyAb7vhpPbEf1pFx+47xSePpvoU03S1icdaNvB5s7UfYSUC9YIKko2PvxjARDDO
         dcaw==
X-Forwarded-Encrypted: i=1; AJvYcCXUV/ZJURmB5ABx9UW43cnJ64I0U+tn9SazdNv73ohQZbOXJY8LhjT9D5UWWnRyepnOjBdUDxLquTmhJAumC299G90OrZomkV1W+E7J4Zfp
X-Gm-Message-State: AOJu0YzVbnH7ks0coUMslhG69U6K2L9+G+lfTgUx+IYwbIIbiWAycMoA
	0NlkuoNp982UL5+QhsG3loRyAQAmebQJ9umrRtw+EpZUM2b6Ks3CX15c+7iGL0U=
X-Google-Smtp-Source: AGHT+IGp/WjLjBiZAM20kgkIHuusLiGfNwThrPTw7ODZoygB6WUmPjQLba4Rb0fKD00TLdLglu9cuA==
X-Received: by 2002:a17:90a:d60e:b0:2bd:fcda:ef2e with SMTP id 98e67ed59e1d1-2c1dc588b8dmr2362368a91.22.1717172297264;
        Fri, 31 May 2024 09:18:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776f526sm3655739a91.13.2024.05.31.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:18:16 -0700 (PDT)
Message-ID: <6659f848.170a0220.2fca0.b209@mx.google.com>
Date: Fri, 31 May 2024 09:18:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-9-g0f42bdf59b4e4
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1-9-g0f42bdf59b4e4)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1-9=
-g0f42bdf59b4e4)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.10-rc1-9-g0f42bdf59b4e4/

Tree: kselftest
Branch: fixes
Git Describe: v6.10-rc1-9-g0f42bdf59b4e4
Git Commit: 0f42bdf59b4e428485aa922bef871bfa6cc505e0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cf94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

