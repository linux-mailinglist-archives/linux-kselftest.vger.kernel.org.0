Return-Path: <linux-kselftest+bounces-10801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A348D26EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 23:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D5B1C25DEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72417B414;
	Tue, 28 May 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PnSB5Ubl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE816F90E
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930846; cv=none; b=RZ0RDyofbLSLfwfz4BD5XLoVc/qxMVhMYChxYuHeUrLY76GrafREsUC80/yxYSpa3nNCuuaWBMEzwUzJUy2LW32Ue4wZQdjM5XjVwXBmB58XkMxkWvg7QVLiytfyQPFQFdxz9uC8jmcKkem+ZHILSVPOkblpAvq3QJSqm9x68Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930846; c=relaxed/simple;
	bh=HAZ/qNoNRSZ3tNTBuieMjerkuOBnqjN8563Lyqh4TN8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fLaGvdcHk1dL1S32wjeGTGSCnS3AKOzlNmcQrVuCoSePXdUE4I09s5bkZlD/CwbFvJ5r3KUJJnWQwtlYy6ea9lOW2kUtmJ1EyS08AvUFTvKoPJ+UWD+T0dqH98nVad5brcTdovaJCbPeVGhGKB8zEhARw4mVTGa20MOh+DhDXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PnSB5Ubl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bf5baa2773so1183546a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716930845; x=1717535645; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HP3FfcsBKA8qpmNLECunJvIbl1036COei41rGlv4OAM=;
        b=PnSB5UblOYsiA4IZYZX/GqP4aFL98+ihu7j/qzCz2u3O7QuKLdCQ6qXqhLm/QL+Fi1
         dnLi0HyWZFqE5LEljN6lge+EzEhE0IKjsGsElfLAOMqLgwbia6Xuq7DVYQbQ6Ci5kjsM
         98bV1ljeMzsgCVafh657x8kpCTYH3AsB+k3t37uI9iL68qDeSg4EYytXU5FTsrTPJxuB
         Rb5TODiGHDlMiVIBe5BshfLjU3CGWQRjKItHasDX+rVgEC+HvJx81+8mMKw8BZiFAEN4
         uHpuBeS8pO6zAvWcMCiLQ2nS46VuCMM8NiOXARypy553RuDQYtxKmR9ADxGQlyGKGQmA
         5iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930845; x=1717535645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HP3FfcsBKA8qpmNLECunJvIbl1036COei41rGlv4OAM=;
        b=IayxDBizHuCSKZaz4BJh8q/37qpe3QsMTIBzv14fIT2ytviiBYf4zP4YD8yJGT6hcm
         N5l2HmdikWomOrwoTffFgonZdRd4wM3ERDFkrvWjJUhpnplFq0qwHgR5WG/Zp74CUmKw
         Z17mMyKQB7HkX0PJbc57EAeVFFjeOAZCJyroKo2pCsABwzWE0c0N61BrMVGz6K4ebfyT
         rHYYql+4tdlRj2eROxIw43LlC3dBsb/HJKIHSHs7xOvk0hpm+yN7GQDt8pOsjqszs+bM
         OoBoezc1KB4cF8woWhSWr3gd9YSkiwUczyTEsh+3n/FnqdHjlsCQbZVlqI1zopJ4RxPB
         fNBw==
X-Forwarded-Encrypted: i=1; AJvYcCWJWH6uue+6xsWGhmNdi1mjy3faAAlPEo+3+owrWmxZHKBfhPaEgW3JahEsDf0eLcgJtD+7E1RmM7ZOu6qWqGrpK0K+y8wxKCEaB2Q3Pbky
X-Gm-Message-State: AOJu0Yx79433i9uDZ6UkGCWuYn8ATF75JUkYUpfKKImxW8Et0for9HoI
	ESMkF1/3cnFHYj13WyQggjtiB3CK1YidsgccAc08NQJWJRs0i2uDcS/7PKWVXIQ=
X-Google-Smtp-Source: AGHT+IEKbDko+ZAo2Vw96PZhSsn3PBbotAGHYue6c0VxBxl51KHNdF8l7EUFrhnTJDRqsh1tTtI12A==
X-Received: by 2002:a17:90a:b97:b0:2bd:d42a:f81f with SMTP id 98e67ed59e1d1-2bf5e0ee840mr15990425a91.0.1716930844855;
        Tue, 28 May 2024 14:14:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f3095f5sm8178354a91.8.2024.05.28.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:14:04 -0700 (PDT)
Message-ID: <6656491c.170a0220.2a5f6.55d2@mx.google.com>
Date: Tue, 28 May 2024 14:14:04 -0700 (PDT)
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
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 5 runs, 1 regressions (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 5 runs, 1 regressions (v6.10-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/665638f45eb1a1e0017e70ca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1/arm/=
multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sab=
relite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1/arm/=
multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sab=
relite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/665638f45eb1a1=
e0017e70cb
        new failure (last pass: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c19=
0b) =

 =20

