Return-Path: <linux-kselftest+bounces-19311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A2995CA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E1285E22
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9FB18EBF;
	Wed,  9 Oct 2024 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nUi7Ho7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E917C61
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435988; cv=none; b=oMgg5H6oNbpPwsEGITRNtQ/xMTBvhhbB+gJRvSlXm3qKP1hgaSatSumKfWuIFPh1eNu/AnEhDbqPLglQdZpKf8dYUAE4SBECJDSV3Szt9U2WJ+NGjmYLiq9pdZ1K7RO3a/PRHGR+Db9tUkc4+WEPMqbhfFhtGtXfxvHzazhokpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435988; c=relaxed/simple;
	bh=FxDq45NMS3Dl7djkxHDJoR5anEyRhJx2z1vXPQYMlDE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=bN4/KEltHTvjPVH37sfuhDJhqELvUp0G9B/h/ZcuuMT0pC9MQoQxSo6AR+Mlzdu4EkhW7obsGM12klH7zHukKpPDWr5/3w4N0yv95nyOIYtUFcCFmDDPv6vbg1+WoSWk/LAIzR4WGsM0BnWIeqnJSi2Rut3NXEmjSLoxKNIHt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nUi7Ho7x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso58541885ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728435987; x=1729040787; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+v555h2IeEQndmI2PilBd4KCVscmBJmGdaBq/fp188=;
        b=nUi7Ho7x+hMXgDi88Uqjm1RSGmlcgJjln5Dru2tovphAQA3OB3hl/N2xxvrUMNeuN+
         NjU4ffkjhs6FxkAndiS2QgraGYgG4YE57jh4uut8YNWRrKCeMKry4NMDmiRrXC1ypkTa
         dj1f2Y/OrKECevugzE7lfaVAAJQ4mbSnNNCCmJbcefullLx+0whPS+4EFjkvrjITj7cH
         iJ3J6IHZVJ6gZdCBJOqhgDoPQtXJCHDd5hqpUr0NNkQmVmBu3jRh5gcwT7XV4XwuCnNw
         CLq3jMfW1TmRN6NG9lmVifnA7uL7ZMq0loFVNJ4vU/rJtRp582MFbm1eejZDl6gi+U10
         paeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435987; x=1729040787;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+v555h2IeEQndmI2PilBd4KCVscmBJmGdaBq/fp188=;
        b=UTPzKbGWe8CZJxH3m10uLzNRlartqzBMJi2zpIg7NGFcvlANyTGYdyycRkLbX6GfJW
         cCmognkbJvUo7Xr2VPXrlL6bKNaYYJeP7SYbcubozi6bPFVmZiGEhKNH0VR9/CfqumNS
         WjAuZuvsTMKPqVoAYjJq1i6hnCu1dwMkDMMX4hg2DKWFAt3C7nQ7yzamXlv4w/ieN+Ll
         sFlQqByLLjC1YcyScPD8EK95OahSIOb0Z7qT/mHSMXmV5j19slV3E4uMVjvb3ezW+AaU
         G3pHhplKkGU/l+ipuvo617bofyuoSd6rhFpbF0f6qn+vLDfYUk0E7OB5qbvF5puFv23c
         545A==
X-Forwarded-Encrypted: i=1; AJvYcCUPX7gay8eR2mWHfCGyN5u5j6g4HBC/2ljAaRqCypUmP87owxxbEglidbbBEqeflDg6o5VvkIx/DSvcmGzyXOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISPf/mkl6SZCIDZHSN8FvCglI38YpQxXdBnr7301P7bYieaBR
	ftmiaYl08+BXpXNwARa/CuDUOiUHn3kQdHHgPx3lEmzrNpW2U7g8NTY5oHQn9mg=
X-Google-Smtp-Source: AGHT+IGn+ZxOefoSsDfMe8/VkboV3fzBT/H2xWSRVLw0cTHqFpM3VjzzJHcXC7cFk5Fa53b02pmlaA==
X-Received: by 2002:a17:902:da8d:b0:20b:c258:2a74 with SMTP id d9443c01a7336-20c6373ce07mr13689605ad.29.1728435986849;
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930e0bsm61113135ad.155.2024.10.08.18.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Message-ID: <6705d712.170a0220.20290e.680b@mx.google.com>
Date: Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 4 runs,
 3 regressions (linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 4 runs, 3 regressions (linux_kselftest-f=
ixes-6.12-rc2-4-g34d5b600172b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-4-g34d5b600172b/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      34d5b600172b846161e507bdce132c98d9cc9701 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6705caba4e0aebd8f2c8685d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6705caba4e0a=
ebd8f2c8685e
        new failure (last pass: v6.12-rc1-5-g45a8897db67d4) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6705cbeeebba5fb735c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6705cbeeebba=
5fb735c86856
        new failure (last pass: v6.12-rc1-5-g45a8897db67d4) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6705c966be664b4cfcc86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-cpufreq-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6705c966be66=
4b4cfcc86856
        new failure (last pass: v6.12-rc1-5-g45a8897db67d4) =

 =20

