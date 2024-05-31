Return-Path: <linux-kselftest+bounces-11031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547F8D67FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF84287DD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9AD176AAA;
	Fri, 31 May 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1SCJ64U7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525B171E59
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175796; cv=none; b=QbRnrgN3r75sHHafDE+HpRDvdfEA7YrbExmdOq7e4LPByDrSYnZUPHdMoTRQwy5V9Dc0U872zVhL2Zlnhl/LQoLHel+9MI4lUphGATieghpJYdOYOQK4X+1l/Hwl2uMWdHrk3X0M2gznGk9eC0ubgCYLnC0z39Gt7LN2KdJAn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175796; c=relaxed/simple;
	bh=fuAQuuEeC4zhjI5nb7jBOEpvqbDlF+wRpx5+yKlVgEE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=kRuqjNTszXh3/GBMqHER6fPRbD+2efH8HBkrBepbjiVtrpwHgX6auBsPaSIoz0YmIrtY5Lujqa84esKI07SUiD2WxEIavvtH3qgwS59VwdCbiRXXNWdwpT90lTQrfoGFonWePZczEhNxLE4vjOoiPU55wSQ74AHVcsS1izC+Gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1SCJ64U7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2157641b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717175795; x=1717780595; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdlvbgx2b65CcKzPiTvvFsIKpo549Z07BH/3fHbM3fo=;
        b=1SCJ64U7BvCGLZzGzdtQUqUnGXzfnCktTzi6tUDOf7AazQmgOIJG988otmmv3K4ZCk
         W+6zu8Er3CKDXC79GasjuYlzOpEemQ0Nb/jE/dSmUzbtNQwquwQh/kpJ9SHj+Nt2eAnG
         fhUvW3CPVkEX5kmWQLYGa1AS7wTzI0zK3dnnGDPn+AlmJH9LIFuBYNJDQeFw2/UuK8Pb
         tmhQ+x7VnrkWC+I8tKbZGv5RhVBqpbL8Px+3aIYNLxnXNICKhvq1Z5h+9dayKFhDcXLx
         vuueA9xh17aMiUF6khTiwx6kMF5cgKIVQAJhwc33Adk4Gcw1Mflvtq1bSQKMdFvwcdwZ
         DubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175795; x=1717780595;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kdlvbgx2b65CcKzPiTvvFsIKpo549Z07BH/3fHbM3fo=;
        b=bGuuBP4B+hb1eCp8YWgVvZ62v0HlHDXiTY092VHuBtKMAypcXcyBfU05ACxsEiYWJt
         Xe6bQyIRqpzTruAKR20dFMWk3Na137kCCfCmBDcA0/z813HBljxXAtgZPhAkj8V9/Ndp
         9fDBeyxhHGtMzGBQExPv5WWM46W7R0CnnXuUNLEiysTL/wD+wyKzE18pcK7Ql5GDzas7
         AiuvTLtjTo7JbJ4PWhSSgbdOMAXpUj0EGCqCTgF33qrIJ8Q1maojJdSEJy+v5b56YcFH
         LJQ1LbLwyHfuDcAtaNoXJf1seOfYvbHbo7Km+wDw75tGgai9P/vh1gLlzMQpNDzg3SiS
         RaIA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBuQKOR5afD65kdBqExCT3/9YjTJUet++PFxkE22Yh1JCOXAwlSE2U6R/vdtVdKDCH+q/I3yfLzi6eWkmUlWoncmnrZ47bxFhZGYtnMlQ
X-Gm-Message-State: AOJu0YxD5pM+TmXq5oLsqHpDHuicvTwuNd+E55nqZDM4XY8rTIXPSkSb
	GQnc9MiVKRb9hKcbbuntlGwAylxiS2pxD7dQOklrNsQwBbH6FOBqTYkqm7xMp/tCj7/mMLaaAoN
	u
X-Google-Smtp-Source: AGHT+IFsKU9Nej6j8XH+fxV5QY0hEKlAHWsHtg5LwDuwn//yzNP/jbt8pAS5desi4ZdJdaNpFP7uRg==
X-Received: by 2002:a05:6a00:2304:b0:6f0:c214:7974 with SMTP id d2e1a72fcca58-702477e9f8amr2489562b3a.12.1717175794673;
        Fri, 31 May 2024 10:16:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055dcsm1658798b3a.172.2024.05.31.10.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:16:34 -0700 (PDT)
Message-ID: <665a05f2.050a0220.5fe4c.467e@mx.google.com>
Date: Fri, 31 May 2024 10:16:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-9-g0f42bdf59b4e4
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 5 runs,
 4 regressions (v6.10-rc1-9-g0f42bdf59b4e4)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 5 runs, 4 regressions (v6.10-rc1-9-g0f42=
bdf59b4e4)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8173-elm-hana            | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 2          =

mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 2          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-9-g0f42bdf59b4e4/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-9-g0f42bdf59b4e4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0f42bdf59b4e428485aa922bef871bfa6cc505e0 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8173-elm-hana            | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6659f7da3ac2df08547e706f

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6659f7da3ac2df08547e7071
        new failure (last pass: v6.10-rc1-7-ge8b8c5264d4e) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/6659f7da3ac2df08547e7076
        new failure (last pass: v6.10-rc1-7-ge8b8c5264d4e) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6659f7de981c0cffac7e70c8

  Results:     102 PASS, 2 FAIL, 3 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-seccomp-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6659f7de981c0cffac7e70ca
        new failure (last pass: v6.10-rc1-7-ge8b8c5264d4e) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_1_bitmapped_2_bitmapped: ht=
tps://kernelci.org/test/case/id/6659f7de981c0cffac7e70ce
        new failure (last pass: v6.10-rc1-7-ge8b8c5264d4e) =

 =20

