Return-Path: <linux-kselftest+bounces-10805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9A8D27B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD54F288708
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2B13DBBC;
	Tue, 28 May 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wQyfMmEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51113DB9C
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933877; cv=none; b=OcpRTWvf4+rUfujMb3Dso03G2HmtP+KniwHuw6KTjpNRJ51d3F3C0U474kruzNenAdzz+gjKtU362p4gRQPzVye2ckDecbzKlzxQb9Exuablbw1Et64MYqgO3TOmaBM/8xJEiC/gX7MztNGs8qZkzEXcvQU4xzR1ppg6kiLLkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933877; c=relaxed/simple;
	bh=yTjlq5hMm50zXK/+SsByajUasARccaOX99Tiiu4tsMc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=e68kSIPErd7CIZ3xZgtYwBw1h2akusyB26o/xSN1rxfqp6s4N0iPad2IRZ8omb4SNUktYzVnbuD7mYMk1dHaHAyKc/sZZHZltADvSV5UG/zxwq4tVSPqwaC2OlfnO8D0QJzD7wSymHHkMAmyfODrGoG+wEccroTHjXzD2+J7oyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wQyfMmEz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8ea2df4b3so1081315b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716933876; x=1717538676; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ6YM08Sv353w9dEMpC4jV5/tN58FDpVd+dAZ/Xnlj0=;
        b=wQyfMmEz3XoJD9lsx+kR1muc1PIUkLYnq+hf/gvOM/FRquFw3QzuVgHgY244zopvxj
         zGmfPXTWXaOeOGzb/iyZsdU5dp/5nGCMQRbCKG5zwxu+wk7JAaO/o+wIxGrptjmzdHiS
         JfFOGw6/l7Ry0d//GLcXVsfGcoSCHgxXiJcgvNLEL4EDTLD3jm9k68bhe7pKgqvDGSnJ
         0db9SZGuV4cw1ECLxOdMHr5+MRWzr6jeAWAIxOwHm7GlUhTbJzt/Y8AQMKbvF17CfxQG
         DAiCdlBQYjmWXbXLDUkmPfRaALxssphtspezSZ7fP5aBr9deHVldHLAglPX/yNs6+pxC
         NFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933876; x=1717538676;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ6YM08Sv353w9dEMpC4jV5/tN58FDpVd+dAZ/Xnlj0=;
        b=XVBcSHZp+Mk+mqc7owTQQ/oZuWgMAN3x8TbajwTWgSWr7clgPLAgBjGkANEHKrlbcJ
         oTVMVhdiTbZdHpQXWbTu0rN8STWgvjvlUBksjJSxe4lzhVcP8UYwv/pCdP/84/8G3qln
         /R8/YnKj7DRJR+4XsNhJF/o1MMIt0uljGggWqxIbPw8PEUpf3flZF0bWya2+Aomkvq4E
         czEHJK7odavmiRq375qWSE++mdGrj1d75x9JIJUfZb6N0f2nhn2t1YoL4RJs5PVwb7Nn
         K/fipDlgDUpqH7ObhA44GkTXVHBH90gupfVX7D/4tagrVuxElg1lNO4NyZ1ZHrTdt6Sc
         NiEg==
X-Forwarded-Encrypted: i=1; AJvYcCW2hRDS/wpXcLXTVu6V7cd+MmdIN65YZXm4puwBohWgVV4sMEpwwDfuwsJS7alUwO9k9Pgfhwl9DadBMJowxcqyjDjterYcGrWuOKu/5HeJ
X-Gm-Message-State: AOJu0YyXk4PIq3lEreHez8pudZW6qIj20ecAAtmsra5JFnsfOLHVenpT
	D1kWaFMV0hoC1qtkhYBZyreRdnBoAfPZzpQvmJyhC6o8gTt9qGr0XGkHi42lj50=
X-Google-Smtp-Source: AGHT+IE5Jr17OWcxJZo83Q6KRxpuAln3NQKvd2VesK86fuem0B4zAwFfuwekH798b96gFXbWjunD3A==
X-Received: by 2002:a05:6a00:e0c:b0:6f4:3b76:ebf7 with SMTP id d2e1a72fcca58-6f8f37060e6mr14110072b3a.20.1716933875652;
        Tue, 28 May 2024 15:04:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822073f073sm8076841a12.1.2024.05.28.15.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:04:35 -0700 (PDT)
Message-ID: <665654f3.630a0220.6aa7b.4f27@mx.google.com>
Date: Tue, 28 May 2024 15:04:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 4 runs, 4 regressions (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 4 runs, 4 regressions (v6.10-rc1)

Regressions Summary
-------------------

platform                    | arch | lab           | compiler | defconfig  =
                  | regressions
----------------------------+------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite             | arm  | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 2          =

stm32mp157a-dhcor-avenger96 | arm  | lab-broonie   | gcc-10   | multi_v7_de=
fconfig+kselftest | 2          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 =



Test Regressions
---------------- =



platform                    | arch | lab           | compiler | defconfig  =
                  | regressions
----------------------------+------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite             | arm  | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/665643e3c509b9b9cd7e70f1

  Results:     100 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sa=
brelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-seccomp-imx6q-sa=
brelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/665643e3c509b9b9cd7e70f3
        new failure (last pass: linux_kselftest-next-6.10-rc1-fixes) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/665643e3c509b9b9cd7e70f8
        new failure (last pass: linux_kselftest-next-6.10-rc1-fixes) =

 =



platform                    | arch | lab           | compiler | defconfig  =
                  | regressions
----------------------------+------+---------------+----------+------------=
------------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie   | gcc-10   | multi_v7_de=
fconfig+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/66564e40564185b4167e708b

  Results:     100 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-stm32mp157=
a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-stm32mp157=
a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/66564e40564185b4167e708d
        new failure (last pass: linux_kselftest-next-6.10-rc1-fixes) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/66564e40564185b4167e7092
        new failure (last pass: linux_kselftest-next-6.10-rc1-fixes) =

 =20

