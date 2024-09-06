Return-Path: <linux-kselftest+bounces-17409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A051696FB3C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9E28E7B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E341B85DA;
	Fri,  6 Sep 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="AtKg6mIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE11B85C7
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647562; cv=none; b=KoGToxwHxGzujyCH04WKElND8YdAY5rKRNcysMHMHrH3Iq4OKNcnw3PdKSdLM0zjeZmYWxg1vwQSaOvFDpn2O3OF9U4alEdOO8yys55uVCnSdsBwWFR3xhx2gJcrlZeCavWBKrZphzEE7nmAQ7s3et4p7JnAQRUMw+XSPm6cLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647562; c=relaxed/simple;
	bh=Jqq4WC6Y4Zg5Ip5Sar+GJ34eU1XGKXghZc8kT9XCKlU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=juXzXm9lTAuY7abGcqxZ1U55WPmMvfsOwX9CwqvTfZ6Nc2hXVfE1apPsRotYAYLa13ZDyXX4xfIty+15/fZnbrsl99qRdrvvR8OvC61RVMYe5phGlPsaKuZKaZ1hLcDpZEYw8jMujd1omgLdck5xnTtKEoi4a4zG2RHxNU9xJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=AtKg6mIp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206b9455460so20250325ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725647559; x=1726252359; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6rP0cDwxTwJ4+25yzcOqP9G6Mr+JmFmJRP0UbzDNaeo=;
        b=AtKg6mIpoubgcnlM0qeb3Vxnbus9kUS4cXlobHb+F73DqTJCzGhnTVfsI0dxEhhHof
         rtGkEka4m3AvC284TdfrdYzQD8KRKT48cnboTIPobxDp1vgJT3olrmDa5HrM6rb/9IHI
         Fepw7zOLA0jQ9otp3ZaZ5oHpH+/SuRrLLcgJbIhsP0mpp8Jd3rWgeIFMrrJwvnAxqnvp
         Prf19cigtlN673xvhyjQUlO5akIRMg5m/mcebrm6U3ciStBAXWZNrbFnhXV2jwtp0WXO
         KI1lMGeLa04PBWPBOMs0TQTrMdeQlz/V5O1bNIGyyV+ff5PLxD7tp1z+3uqy0ljUosil
         Yg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647559; x=1726252359;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rP0cDwxTwJ4+25yzcOqP9G6Mr+JmFmJRP0UbzDNaeo=;
        b=KGGWPPzFCcWrA3Q+eRUPxmy7oP37ji/lsCAJBXvlCQZhgkoa14wbwrgxOtX0Zi+pt3
         jmO5DFEOwa+TFYwertv4jqcJdAH6ih+yd948gU7ZE4V/TgYobrIHb8dlcc8pZd8PUBmJ
         eDS1h2+r7ih0K7rn9tY2l8p9ZyfmdenLqYHjqqpRADf2h7BvUJEyKqJgqPiKyR0BzoOq
         X2LzBDmRslKwK++mgXnQHMkvM9MEdL2TzoE1Jcb+pZ6vcZBCrFZPNKBG6dD/ZwVg/rZO
         hsMKVg+6ZofxpqVc6746jF98/oEUAv3IQvK8UmstFf9V9jvPbHoof20JDpGtXo4wshNm
         Yo7A==
X-Forwarded-Encrypted: i=1; AJvYcCU9K7EgnGgkeTbEJQVwcxP6QMDeN1rFqJ9v/4PJY/UvxPPCavphz2PRWA5OXdMBgoq/KvJiTdpwWqEX/1lk8Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2yjTNU7PK+jCGm+Jmqc2O9ePi8LB4SpnW8Bhhaa1sLJXtBPl
	CFMFG9gMGoa16Ce0Vxa+r9Xr3ZYAUhfPaeApURbwcbf8jZPeiQY5Ydn65dve03Q=
X-Google-Smtp-Source: AGHT+IGkz9GT86uxWBgEngnsLfr38HW+8I7/8diUA/xXc8axZ5CCp5kkX6pYeDIgs3SlbTe52JD8Mw==
X-Received: by 2002:a17:902:c94e:b0:205:59b7:69c2 with SMTP id d9443c01a7336-206ee93964dmr62566025ad.7.1725647558554;
        Fri, 06 Sep 2024 11:32:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b7aabd83sm43211525ad.35.2024.09.06.11.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:32:38 -0700 (PDT)
Message-ID: <66db4ac6.170a0220.2d6670.320e@mx.google.com>
Date: Fri, 06 Sep 2024 11:32:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-19-g7beaf1da074f7
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-19-g7beaf1da074f7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-19=
-g7beaf1da074f7)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-19-g7beaf1da074f7/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-19-g7beaf1da074f7
Git Commit: 7beaf1da074f7ea25454d6c11da142c3892d3c4e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

arm64:
    defconfig+kselftest+arm64-chromebook: (clang-16) FAIL
    defconfig+kselftest+arm64-chromebook: (gcc-12) FAIL

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14ef94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-12) =E2=80=94 FAIL, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 FAIL, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-12) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---
For more info write to <info@kernelci.org>

