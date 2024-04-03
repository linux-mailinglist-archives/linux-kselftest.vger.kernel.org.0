Return-Path: <linux-kselftest+bounces-7016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D112C896081
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9E6283C1D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8836C;
	Wed,  3 Apr 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ThLe1Mc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4316635
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102948; cv=none; b=grIEte94/Lc5aJKM/d7zn0jiys1/jdJw1q2texJkdeC/0RB/Dbw26G8YwofoMoptWmmtpkvE4wGYBt5AWstuluWbxV0vzkK4Fcv9DO9bVl6iqHULUYgaRtHUAZYKlk38ZLOF1RNL6pQDNX6mWZM1hnmWVy7agKDv5v4GWS/TT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102948; c=relaxed/simple;
	bh=b3/zBHssu+YuvWrMyZ7W46753okESTMkqY2ouGqp7Fs=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=pFkZy4KEs0XBoSkcPSNoUr11b16xJPtskQZqY2cYs4r3nnjuUmn43vjlnCKpEc5p5oJBUryjMBdpDcD4ilSnOVC9pcFQcrDUzFwQZgXe2EjmkpIHKQyTKuKWTas8n9a6u+cm11r9u0V4sR/s/GCZVaZkJQ/WC0Iuu3YvmsQJIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ThLe1Mc1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a49261093cso3300160eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712102946; x=1712707746; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNowzICwSHCBIy9WZnsYUYXcl4Hz0AjkOmlYQwywLXY=;
        b=ThLe1Mc125NMMt/MJuOU5ONmeBdSiS8jE2n0jk4NwZPxw3Req2gGFkPcSoUJnbah8d
         ve07ujmcq1efq4z38mPpRv2EHvpamZstKb7Fgd61HIzhAlY0gDFpiiQEsHxdCsBXQaAj
         DMTPNV3KTzmewYWzLyRXdfgvPzuh79H2aAhAqowyoDX4tawUV8QeYIPrnjA8tBWTk29m
         ZZxjwSbb269mO9W/UGKvR5RqI9GmkKfVIikzYInTCwSrUwUupi+f42zrAGWIW7l3Wa6u
         eJHPOIr0lt8HCLyCPdtrBGj2TLFOiIJ6HzRNJe30V7UMKmmPh2kUqCdD2i7aEhHUUvPd
         v/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712102946; x=1712707746;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNowzICwSHCBIy9WZnsYUYXcl4Hz0AjkOmlYQwywLXY=;
        b=WD2k8Dtun0SA556SAETWXpXEdCbRn7m8WY2SDexc3ErdG3loSPeQWuJVeZVdbeYKzF
         xBE137JkyPgeTLTLfeexAD5GOwYv8Fqfi2Jy8d5m/qj0IEGOHgLIYrfwcHnCpvbVkA11
         RJTDVbbwl+UUxoxfAWJHXsOLc1fChmjy10MeSAhAe7Un1lTMkfj13zb/Wm2y+NZjCTaV
         ADdhPVXh1ADTkleeqrXWXQayH/WKiLDMxPXmcGMTd7RllMdunaoZgVkGvqqa9cuqMkMg
         2vDQ5sR/t4wPoigxjn3/BCtY0fc+VgtMziK2ud7D7NeUIMPR96d1wQV0ECi/pS4IqflX
         rKiA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9xbovO+p15VA2IGLTA+xGAn0cOghChVbEFuPV03m741P9bQRJfPni3dZUwxxyWI54wU/oHDY421k1cA8x23worgnEoqyeGtk2MXomUf8
X-Gm-Message-State: AOJu0Yyk7RStdTHJPsS2XxxVBHgcQXWN+eWOW7P3eguZt6/syw0mWfks
	JEh8fh+0+jj5HR2zrazaMVdRIzvFOnDBYrjfrkLnfgMKVko2rZiE2JTwx+0xlj+TBznBux8wA7n
	P
X-Google-Smtp-Source: AGHT+IEmThi15A4fI//wvRzl672csVux5uAKmi/+IrW4ZVo6rk7/JZfxJJOV/wHS7DkeJqWd6niWuQ==
X-Received: by 2002:a05:6358:5919:b0:183:630a:a88e with SMTP id g25-20020a056358591900b00183630aa88emr1290753rwf.7.1712102945671;
        Tue, 02 Apr 2024 17:09:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g29-20020a63565d000000b005f05b06229dsm10314732pgm.41.2024.04.02.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:09:04 -0700 (PDT)
Message-ID: <660c9e20.630a0220.34a35.bd66@mx.google.com>
Date: Tue, 02 Apr 2024 17:09:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux_kselftest-fixes-6.9-rc2
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 4 builds: 0 failed, 4 passed,
 1 warning (linux_kselftest-fixes-6.9-rc2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 4 builds: 0 failed, 4 passed, 1 warning (linux_kself=
test-fixes-6.9-rc2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.9-rc2/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.9-rc2
Git Commit: 224fe424c356cb5c8f451eca4127f32099a6f764
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149bf9

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149bf9

---
For more info write to <info@kernelci.org>

