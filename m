Return-Path: <linux-kselftest+bounces-19490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532459997FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041E4280A11
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA3126C01;
	Fri, 11 Oct 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rjx83H0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BF83CDB
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606786; cv=none; b=Kil4ajy4H97Oqi5mpJur8ldcnC4LbzoVy3U0KP5Wd9OqZSc1UBJSUu7G/cRPHxYwausmg03OxvcuF3rCOnxis1vFapAAHZIa2x0iYhf+2LpVi5xY8zovk+w8DJLGC9LUtEQGhF45gkR9EJhfyC5S8lRv1ObT6ndLiPTG6rTUOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606786; c=relaxed/simple;
	bh=zKOuBam1Z0jLyEo8hlX3oRB6vMjNrjYVOPRJftekPjU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=R2myFMWJuFY1Yuw186m9HoI+4UPp0c6BCstg2Ihyes0YSaLrXaYCvj2mpYHgy4S7wLF7Z88CAjpCGKX9zKpwdq4vKIdz95WpCGIuSVLEzAq4mo4XLc3yKG1YqpA/dG5z1TJTzuLLiMUU89NI3afYDlrfYK9dN5eDi7vI8EueFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=rjx83H0j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b5affde14so8997685ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728606784; x=1729211584; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P5Qbyx20w6W0hUwmut2KxlgJWbbajcAdMEpv1aZ6QKQ=;
        b=rjx83H0jAHS62Uycn5IzELLoMwETMGLyHGPpySqOMNBKx1rUBrUC7OWSNfk+OyHAr1
         L6G8mJENW9sSkKO1QmpR6sfpPmz7MieT7QPCB3GxFzYDxpz4hnofJkH7xvXLGLUdk9l/
         gvmXY5IUzhTtuyJRsAzhIdfFj81l0Sue6q4bXA4NFKCjaqZsKbPYO0bYO8e1tvtCNR+2
         D3PVRJmucDVtmSX/Ia9yEku2S9lk4wjJ5HmuebZf6iilWII2Hv5qLS/FtUY374/6wJ47
         niYZsfnL6FkrilpMXY7tprezE8IGc0iD3frDM9l9F+NegI3/Rb4pNVWYzcVeuDTaAI/B
         UrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606784; x=1729211584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5Qbyx20w6W0hUwmut2KxlgJWbbajcAdMEpv1aZ6QKQ=;
        b=XDrFRj0vxQ/eO/ldbR0G1gcu2gsBihb/erDsJ+CyK2owI4hVTtgABmr+6YktKa1RtO
         +vllb2XRrTu0qhDCYvTHczU9s9qykhHh1aHjDgGNBg9Ac9wJmKAq5uI4e9BeXVlC83Gb
         TjokLoico7zp0MLvzVYzg04i+9alJESuuiIGujaW+uaZnWfgO89pytsleKGszeCsCZBn
         dAzFSO9wEAksIS+0UjQdWoq5X0wdsnQ6UxMUJcEidD8CLohEhybCAdXncEHY75EouKHF
         Fy5WMoJq/afwkTwBwhqetU1MTcyzSzQTQyHM0c7qCJcEEdzq+4quZAAN05EH8VQqnuu3
         kL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWKJfGt6F6AfUNqyOtt7t/FPkKEAHgKvRxj20uTHk9RvdCuCADd1FVDoyoyFe+dftOjqb6UX6PvGhvYET+3MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjQPOkuSpt3aKV9IBAuRHP+EUkiTv0A7xt1fVpZYjQkBe1rDO
	cfLuXNKVeNM3hpxKH/RI+XcuH0WjlEmq/k3iM0Nn+HEDavdONaSr4JLdXn+mj9ZUtVnoWbDME25
	q
X-Google-Smtp-Source: AGHT+IGwZgZZsbEfpGPvbYyJiYFyYa+s6IFcZ6ph/q/dg1CkC+WJ0TylUDeKCR0cl8hP+FdbMF8Uag==
X-Received: by 2002:a17:902:ccca:b0:20c:8f98:5dbe with SMTP id d9443c01a7336-20ca1677b77mr12873075ad.33.1728606783976;
        Thu, 10 Oct 2024 17:33:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1c39fsm14801595ad.92.2024.10.10.17.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:33:03 -0700 (PDT)
Message-ID: <6708723f.170a0220.1544d8.626a@mx.google.com>
Date: Thu, 10 Oct 2024 17:33:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 3 runs,
 2 regressions (linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 3 runs, 2 regressions (linux_kselftest-f=
ixes-6.12-rc2-6-ge26e42b5679ed)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e26e42b5679edf8c1226970325366f962555e58f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6708676e7a41ae1109c86861

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6708676e7a41=
ae1109c86862
        failing since 1 day (last pass: v6.12-rc1-5-g45a8897db67d4, first f=
ail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/67086a1a7942f7bc76c86875

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/67086a1a7942=
f7bc76c86876
        failing since 1 day (last pass: v6.12-rc1-5-g45a8897db67d4, first f=
ail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

