Return-Path: <linux-kselftest+bounces-19488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7149997FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E181C25FFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9484E0A;
	Fri, 11 Oct 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gii039pY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FB839EB
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606786; cv=none; b=TxkxLraG23gNZ22M1TWWfCVtmJcMrviVeh6mGb+4JruCZQpMpOVX3GzWhYSYoa0F+aZabOvtqS6I0odx6KnlsV9nVyiGTBm4I8gSh3qaT+3xoN3ztaq5/bcJ243+Zd6H86tK3NXAEcfTsCJeCjTFIKFWxMT6mlXmEXVz5a133og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606786; c=relaxed/simple;
	bh=MOC8V8vJqaBUM0Y22ajOUVq1bDz8tZ84ji5v2GGWUck=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ufWHb4lBHfVdWKaIfaM114i/ch3aAAaG42AVrbklLy1nFrSz+bDJqSj6D5oGzUXFAs1Yk4uah5G8qKyjnwzp5TSPGkaSaXlXyz4iGrGnKyr/CVDOb4jce1/wTTBc1Kw67bocA8gmCSPuOgNtoTd3oL+dyT9opEQavn+aonkhj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gii039pY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b90ab6c19so14795955ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728606784; x=1729211584; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FkY5WiDujZo3OiwOL+mCALmb/QweOj77JXJiN/o0D+0=;
        b=gii039pYi50+iCGsJqmTadb27VpE7PV46PHrg73oTwuYaxF9gUtVSjH1TkiYP1Yl19
         1O+vojQ3zIjKoxbIHb9172JJCAd6xMDF90rXfx2kvk/pRSHLya9iS2LQO+fwWiOZJQMe
         r80GwiWIYNKe4iK2JlNZMaLwn9oEIO7pz6x12LCFEID8RrSjPB3pJjfDO6C1l6mdJ2p5
         D7RI0WS4TC/8xh3RfartKpnHYWbLsi5F0MK5TbbM6vhOn3Wut80+9fra+GSDbGZ6hx5f
         C/7TZZpNKbl2L7ZKTN4MF/LrpA9+ibx0Ne3/BbPFd7QMjDZwcpvhkIwyVfcCs1DodD0+
         6C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606784; x=1729211584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkY5WiDujZo3OiwOL+mCALmb/QweOj77JXJiN/o0D+0=;
        b=GZ6cFFIo8gWP9Gud17dt2bnboEGzLv8ftPcBrgpPf9zZ0yialKCTvovlGqM1kWnj7b
         vUB0FbXlF0hzZhhO/bf4DIP2jqyadXr4GTDprQqd8DQjbtxT1eCofOhhAivS355/DLHH
         hnysztAp0yjSFe29Mj6UYCX+bAA3VOyTfOfentcrAh0nOPkUhdvT76eKhI9/OfcIY2tA
         kgULPnUrHBPOAYUq7xtju+CVy4xP+Zt6EQrWPcZv31Jn/Vqo9RXzbaq5ZoYS3FOdYTPS
         IV2ug8QSgVug+SFKM6OwW80nOh0tSXct4GY8MKLfTvASJApd0ncA6hmcYUNvdix2bFa7
         xJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFLQQ7LleYuVVHxa/gbAh8zgQq5ZjRhSk+QqkShBAXLbE5MIxECv3wM62bpv2jmV9B9IPM/P3/1zJb/6+ARjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRIMTaTaH/Eu05cb7OVAzNzAPrSElTkjht5srCjGU/MbX4ETr
	gRwkG2Mqwg4ahxUhmxr3iCjQTgZevfaRXj7Ui1ad9Q3T2w3rzQknZoDfAXxveFu/wV2ju/bTv0D
	w
X-Google-Smtp-Source: AGHT+IF+Z9Ix7GWSoYdvR56+n6Wj++iknQTWZnFuLvmuVuOX99jEG6O8TfmyTI0YX5WsCfBc3kw01A==
X-Received: by 2002:a17:902:e5ca:b0:20c:805a:524 with SMTP id d9443c01a7336-20ca16be1b7mr10237525ad.39.1728606784167;
        Thu, 10 Oct 2024 17:33:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212e9csm14803955ad.188.2024.10.10.17.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:33:03 -0700 (PDT)
Message-ID: <6708723f.170a0220.ae39f.6059@mx.google.com>
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
Subject: kselftest/fixes kselftest-lib: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 2 runs, 1 regressions (linux_kselftest-fixes=
-6.12-rc2-6-ge26e42b5679ed)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/670867935b7b683c98c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-6-ge26e42b5679ed/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/670867935b7b683c=
98c86856
        failing since 1 day (last pass: v6.12-rc1-5-g45a8897db67d4, first f=
ail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

