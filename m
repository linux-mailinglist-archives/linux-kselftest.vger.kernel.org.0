Return-Path: <linux-kselftest+bounces-5395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139348622AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D310DB22595
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBB13AD9;
	Sat, 24 Feb 2024 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="F+9mdV5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C704414
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750865; cv=none; b=K8Bed0sFi7RL5cqX63dDgV64M5jqVk0gH3aY078zJqOjMofrFaxbBWGu4s5UV3ObJqonyz0ybFsLcIST5uMSxj4JNRcZjVGwdTl0F/6BNfm06PsNOoaU2Fvka6O4GjMmB7tjRA1WyUukZiD/6meiOdO0ts1MInt/1398YV4HPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750865; c=relaxed/simple;
	bh=/onWvyCTZI8InHeEKXHP0t11tM03YN3TaDFc5nO95vE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=aDNpeo7M4aEai9IY/TkqZ98208Zg+WqisYSWDEye99ud2taHEdsyoaFJws6XoihnaHaBENptWS+5KD+qbCFy6heWKTozKXmQPV5v0ohevcEgLK4+wVBXW9IjYQmAfAeBhQy5T3TieJfdbP4KuxsvFAkAk54agLObOeAE61hTLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=F+9mdV5i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc0e5b223eso12869115ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708750863; x=1709355663; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BQcQzYxTaIsgGN4sKlW7z2g4IHZzX6Wkl0hJofuwt8c=;
        b=F+9mdV5ijh811//TNnytVpsb/Op5ZnnKeLFgdzgh/pcL8DDRHLc6lR2efkyN6LENZh
         rqoCtaOEKjTA5Kl/KiW7caLsCbwRF8uZSo5tVmcJ0X8dbJVH+ZzkiDndx9IojKQzp0cz
         8dkTv4q8LVM2PMRqZtrkdA7fsQK4f5AZjdMcx95FBuZyHOdNRI3xcHaJW0pEBKGUhqD2
         5TJUng+Sx6ZHmLI9IndPzSo/lJ3O329Sd1H3dfrHCuOFPCji/nmoZ+FOV9Q+MRksl0JF
         1O0STM44em7Zg5hR+zVNBIF7nApv7rPo3B8ccgflvqqJEW7+6kMoGEUPTwwf3WzbbyD9
         IgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708750863; x=1709355663;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQcQzYxTaIsgGN4sKlW7z2g4IHZzX6Wkl0hJofuwt8c=;
        b=Z/kouV77BL8LqGMKeQdcANtVdDQ+aALMGN6WIgIwPoJ3uS3ujEiTJvzDHQZ8ykijzd
         7Wg24CubOT5UD1AzvCTCbqiX5PlLWSNXMVc2csias7rztcbqW+oRpzDlR2hJXiYsUKAE
         FB17M0dsZuJfLS8TcloFRj8mPsgj33c0uHMmljQrOxPLf83wv1SVOo08KanJ9DKIamdv
         bV9f7SBlzp3hSj8e40aJxHiRzZqaL26wM/jC4iPOfX/mCSjvtAXepkSwJeSCm+G/rcn1
         bYz5Z9iMPf9ZhooSIGZJCXs3aF0WvfK/B8qpJIRPnO6ZSKcl0epkiLbrL+yhvbJacQiP
         DNgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4bqaryTcNJd4TxqmJ2EAakPNzbz4pw/oJBjed1eCm3InNcVyK9ueYlPwlnNcM/nKPBTfHNuPJ48A3WoXkVVmE4/gHdFYpzM5ODO5qOTyF
X-Gm-Message-State: AOJu0YxlefEXyaOvgp8N6puBD/yRCGOpic4+J5kxsztf7Q8AnVQiYZ0D
	JJlovRPh6Jp4a4EUwUsR55NPBnF6dnMlQi1L41HNLnfNzAjeIVs5DQzYOZYf3AiNL+ETS1xdXII
	XHXw=
X-Google-Smtp-Source: AGHT+IE7laPxuQlqq+OULtCErAYKbVdPT1cquJ/IXJUB3IczVEjnJh29mK0HPIfD0T39rgv7KASXjg==
X-Received: by 2002:a17:902:f645:b0:1db:d66e:cd15 with SMTP id m5-20020a170902f64500b001dbd66ecd15mr2333486plg.59.1708750862668;
        Fri, 23 Feb 2024 21:01:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090328c300b001dba739d15bsm253202plb.76.2024.02.23.21.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:01:02 -0800 (PST)
Message-ID: <65d9780e.170a0220.8a4db.0c2c@mx.google.com>
Date: Fri, 23 Feb 2024 21:01:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-53-gae638551ab64a
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors,
 6 warnings (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors, 6 warnings (v=
6.8-rc1-53-gae638551ab64a)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-53-gae638551ab64a/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-53-gae638551ab64a
Git Commit: ae638551ab64a216364a63c4ee5061f82702fde2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

i386:
    i386_defconfig+kselftest: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig+kselftest (gcc-10): 1 warning
    defconfig+kselftest+arm64-chromebook (gcc-10): 1 warning

arm:
    multi_v7_defconfig+kselftest (gcc-10): 1 warning

i386:
    i386_defconfig+kselftest (gcc-10): 1 error, 1 warning

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 1 error, 1 warning
    x86_64_defconfig+kselftest (clang-16): 1 warning

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cfd6

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 1 warning, 0 section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warn=
ing, 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cfd6

---
For more info write to <info@kernelci.org>

