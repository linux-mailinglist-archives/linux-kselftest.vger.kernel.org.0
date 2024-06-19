Return-Path: <linux-kselftest+bounces-12197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC0490E18F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195381C2256F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783A315BA;
	Wed, 19 Jun 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0rLrk4vX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DC208AD
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763335; cv=none; b=mUs/IZ3ngADuJSO4AhAnbFRsrd0ubprtxdn/s4nzv3HDXGvMT+63yzAugYJ/kvgpg4tgU0kIr69Y1AR3eLDsveNPYMQqYuexnjbhvJAfNCfxA35/H9Hx7tgB9b29prwxJOqfovc1kqDGOUCJkBoXNyJX4pFvKULywL1jWTLzxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763335; c=relaxed/simple;
	bh=Z/usW02Fa7jvlE9kha+9hRHNb4cobtrNB8H32qyRp04=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=eJSa4zePgIqKm/sdkSMyCNerlvJgrlSHS8IoxrL/RhzRScD8UkIdtaUPKkqeAQ2kWhMdc3pxq/gdNfu3lkXsc/TJnUrx/EEjncDo5WxZ7aQ9ajamZ2Bp6Vgx5aNC7C9yNs3r0uD+InV+Ab/nCEkh9gn3hxCWwDiVUvjq9PuzdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0rLrk4vX; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70627716174so728869b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718763333; x=1719368133; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CD7HVDZjyxLSMSGkfMKDEVD4RaGNItgTwmjuudrTbeM=;
        b=0rLrk4vX33HxSDLeCtDhXpQpR3c7Z7+WpOywDjdlCF8l+ZSTKM1BguM/OfzJjn0HMj
         rmp7Y3gGeOXE5eeazAKGXMprjvvobZcdu3ieJiAXbtwy9lGX7ypQRe4bJWe+s5WuEexK
         NRDB9OtA3NWR1m0anW+WOQcp2zXEan7G/VJYMmP5AzA1aLn1VrGc0VAQvTWGD9E/Yipg
         i4Cb9CrJjccKXFlO4CIrNnG4e2UzKNQPo4rM/m4X7t0+99ALymKguZQbnkft3Qug04wS
         xKwskII3Klua5o5maPtqQdxKK4QF1PXr3ePY6XIeZQl1B/yWdvfWkUSPbktW24O3cAQh
         tnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763333; x=1719368133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CD7HVDZjyxLSMSGkfMKDEVD4RaGNItgTwmjuudrTbeM=;
        b=unCKw/R7SuwsvUv05VulV0B3jmy0J1GkBNXnB6CN3zjStlncD52u4BCsgExR7XuPBT
         fywgiXYyKOx0IFMc/8ElMzm9s0mUxj38IKkaKrt1VviaNKN5+2Xzj9RWQ7fEisRLrFx9
         RwIgItW8M4sL+N7GZmDEA3q6LDD58uWj3bvTCYQsWOjJ4SdrAplOqinx7AyumoIJSTt4
         HBxrJhK4xvkISXQcJ/d9tClBS51+SPqEfhvQ7S8/b+KM2P919IDGlAvGPjTmWoGC1NZt
         vpm7KocpuSd3fRaKMY9IaVPX01rKrXiw4W9DwJjwxEmrDw1bV+YDoNoT5Rqmg6SYcFAD
         69Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXWreLshjjesCIoUwfYEnWRFEEOmW9jCCGNi8lbOeXpEN8bBm9+CIn1VtaUPsuIISe1Sk7+lalKrspKtGTOd1Wz/FZlLEd5SaEQyFKYTqRI
X-Gm-Message-State: AOJu0YziHpLPCIPTFTu/H9XoioFVx1qGry+pRwOfRhxZNo6QWnO3U2vX
	WIlIm3or1BwCUJCTb7eS/khUnw/x7iYkxib8/R4cGdm93+hPyjZ5ztS1PFNOAXY=
X-Google-Smtp-Source: AGHT+IGLdo/pjdV/98xZekzFkV0ayFoFNj2RgRKJBOL/W4c1oO8ih8cTvfp78g03jTHU+fRB96fegg==
X-Received: by 2002:aa7:8d0f:0:b0:705:dd44:ae8a with SMTP id d2e1a72fcca58-70629c146cdmr1342388b3a.7.1718763333534;
        Tue, 18 Jun 2024 19:15:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ef260437sm5827989b3a.85.2024.06.18.19.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Message-ID: <66723f43.050a0220.9a45a.f107@mx.google.com>
Date: Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-19-g15a783a493b02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 5 runs,
 3 regressions (v6.10-rc1-19-g15a783a493b02)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 5 runs, 3 regressions (v6.10-rc1-19-g15a7=
83a493b02)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 3          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-19-g15a783a493b02/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-19-g15a783a493b02
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      15a783a493b021975f3dd12bdd95a7080df0e8cf =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/6672342d7c55b478d77e706d

  Results:     104 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6672342d7c55b478d77e706f
        new failure (last pass: v6.10-rc1-2-g64f5bc57b24e) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_entry_2_bitmapped: https://=
kernelci.org/test/case/id/6672342d7c55b478d77e7071
        new failure (last pass: v6.10-rc1-2-g64f5bc57b24e) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/6672342d7c55b478d77e7074
        new failure (last pass: v6.10-rc1-2-g64f5bc57b24e) =

 =20

