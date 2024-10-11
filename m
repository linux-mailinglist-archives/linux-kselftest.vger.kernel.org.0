Return-Path: <linux-kselftest+bounces-19489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CB9997FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D8B1C25FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEDA85270;
	Fri, 11 Oct 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="c5+n2vw3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBF23BB
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606786; cv=none; b=kNTYrf7XO9yoDU2/AoKjefVIEs6ey8lRdzcwxXGHcDxr4dNZpw4o2Ti2dXrblpJD/fTxlHE+3ulhDIIDLqse8MpIMF/TZvJljN0gLGvH2wo3RY5Vtz9uQSsGw0dsO4sjoE0/2SSnzWAWx0I4HUoDN7JTQjd32fR7c1lF+QZ7G8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606786; c=relaxed/simple;
	bh=QU3lTs0acCFLYQdJ4JM5dOetCUjnayWzP4MITkW3ZgM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=eXd+cYMGgLI9Hpdkvda1WElxsJq1neI24BHP3gjqyujiPm0NLpCKhtgv4dNPS9ikpoD8JNoKW8z5cd4kE+u9d/ZX4fKI85GTFMoQxNS4hhytDcBm7KlZppqbeRM05oGlrsU317Ug9yNwVleS9f/CqaiF0sNYWcDmUU9T2BDtNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=c5+n2vw3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c70abba48so10066825ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728606784; x=1729211584; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6CJhJetr9DkwWacFweOPDQ8CjBWcw3RSEwDPB5gi68=;
        b=c5+n2vw3IrHQj6K1dcCxka1SX1EtxsLdbI8/MfVqIGCWHl44dDaIxuenb78q/B3iqN
         wRqbYFfYl0ypxaNBtZ6zbgVI8hsAi7kGis45iKbJnz1IrJcwxjd0ug8JkOtdlbl1OFfp
         XJoN6b8ja4wnPqa0ueLrZqao2RBhQlNKDhpC1ba6sgeij6UYmAYzFNdZnUlDNshbSRa2
         0KkcV7mFoEfvgAiaRK8ogkCLwQ7XkRkmTb//Kz/NhFmao3grmy7AvFY1vn4DaQHQtYXm
         rVgbIZjq5n/020Ve+77XeIUJYlEhjfSj2CmiY8IRL0lPyU3RIObhoVnz+bqKwJ03eNP1
         enpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606784; x=1729211584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6CJhJetr9DkwWacFweOPDQ8CjBWcw3RSEwDPB5gi68=;
        b=MVJ1GLk2LJVbA0nZOc44AJ3QX8Q5o/mK+85OaB3lIy/jN+xi5iCxZj5qHRcordvO4c
         fDsXzdQ6tNHHBd2TqFi09yX/ditVZXzYH864R7FAinKIm9uXY5t82YQkclhAkYIiCqIZ
         mHhi5TgzBOocnwuGrmmIrykO8DeFpJdTF2TawbImsQgn8dc5Y6jajx8t3uhw6pSX9c5C
         JGmOPwVU7csBF9zW8KB/BHmSEcDQAfCDIgaNOtwi9sdvXWlIFN2L1OORm2NM+j7MlKG0
         BoPpnvkAzxMgUm2oTV0LLtIJVXq6hykepu+c1Z44+sz924f3djt8lVdGyrmWbeDW12gg
         D7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Q+IheRXTaB4kcFZYCa2j52NcjP1aCatS2elNKzaEy58el0vKj0LQbwU0eVu3gtjUfIUyRDhdOBjatLhvsF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Fe/W4PzpSBW4v0LDryLiCMpc0XJzUXojS9i6aggdJd9ZMXcU
	GmJQP6/O2HmViht9bYYJR/A07n9N0RfOawhi2zeIxMy9ZWxtiqujrAy1dyb2QBROmtEt/SaXr1Q
	6
X-Google-Smtp-Source: AGHT+IFjYaScLDA8eAIvrJRNlBLcCf/JE9ndgfpSQvPsGpXAEftFRv8FA3pGEazTQudfe0zY7AMbRg==
X-Received: by 2002:a17:902:c40e:b0:205:4721:19c with SMTP id d9443c01a7336-20ca16bf929mr8573865ad.37.1728606784310;
        Thu, 10 Oct 2024 17:33:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7466sm14780455ad.138.2024.10.10.17.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:33:03 -0700 (PDT)
Message-ID: <6708723f.170a0220.6f16c.5fbb@mx.google.com>
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
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (linux_kselftest-f=
ixes-6.12-rc2-6-ge26e42b5679ed)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/670866b6913f5044d0c86896

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/670866b6913f=
5044d0c86897
        failing since 1 day (last pass: v6.12-rc1-5-g45a8897db67d4, first f=
ail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

