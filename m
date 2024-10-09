Return-Path: <linux-kselftest+bounces-19410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB099794C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634131C20D2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AC1E282B;
	Wed,  9 Oct 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OuYszG2L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27A1922C4
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517767; cv=none; b=oJ+axjCnEMhx6wHYxmmJN7k0OiUGIfzBSpkNkUc3gpl65m7rXqaHzj8YvORatlKmV7Yp40hobFeHXS1TD0EZHukRGqYusnBuce3PkcxwACf13dcWCqQtiXiDs8zIkWP7SF1uIncYNwce25G1IiduKJEwFyyrzf8pl8Nr35hJYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517767; c=relaxed/simple;
	bh=Uk+KRC5F0kakkN6D2c8m9Wr8HS5h4rn6qQ2QUMCfEJI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=KZqfPSC2HVTSIVSmRjvLzO4NIj8zgqHeXloFx/EDiEHhlV0yoWmTbf5QKTY1xW5jgrAF3rE4v1lwerzrs2NqSWzPYhGofFByoiCldIj7nROWGZMahgXuJVaGasNb9d8l7W7F/JXArCRAQQvoUemI3DRWG3sT3S9A0PdGExCPW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=OuYszG2L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bc506347dso2535785ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728517764; x=1729122564; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=990EJRF0yp8eCuit37hQWq4hHEZg4xKFRKCXp1MrZl8=;
        b=OuYszG2LtBacOM+pavaciAl5ZN8pYBsLTbAe+ZmdSD6SPiSUPjhToUKZbWdBtmdQD/
         9yKybbI9qrHlIAg/1KH3bj36uiqZqgUB6zLSNf/povNdSlTarh47hEpHSyPfJmNd/QRc
         cjfcdP9BbCjXpqKiIsKhAln24H6CEq8nU6Q3CduJ1OkvK13+nBrL2cGZ2w7qg1qHz+ro
         vgbtWbuuhM0db7MwPbjLymWnrOTLLaZRSAY1hMqJUc7H355X6w5dFHL9FvYqNho83bk7
         EUEChQZOryTo0qf/aU4zlSI7gRYhnyKM8Oi0UrBGh0HyCrfCoAZSAkCFkV3TaO2TwqBr
         i7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517764; x=1729122564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=990EJRF0yp8eCuit37hQWq4hHEZg4xKFRKCXp1MrZl8=;
        b=IvIgvTJelb8qciX6K+3oU36nFRMfH8du5iCMA31RpM+6DMwZ9M2pUpyHK3MpAF66TZ
         IeJThn2vV1Q4is/2QR0OaCKCjzqOv5C2YLnc9qxa03bTjZPW4bd/wuDxnevMv37liL9T
         OWPqcFqMQaXKjAXjbsr5cqM0llv1HRCydLT2IGNGMzaE6IBPilLwBDzhVkkNmJ8bwUJi
         Xo8FZwyQzMprt1R/9m4FSuS5OAGayNFoyP/v5WQnzAWQJmTr2FyylvXfzZuONPPFqVBj
         3Y6GYXcuNsQ2rnJMZAiEoEpjA6QRl/2ykNb0G1Q6kAli3QOvEpH1VhYWdKEbAj0BbWVb
         qUxg==
X-Forwarded-Encrypted: i=1; AJvYcCVWxQ2u+tkgekHD48PyCFI/xAoq12sTglWqQMikNIYq100NUmF0Ixpy09/J34xBd3URhY2Zjqu2QXke3q1IBV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvalP+dBB6c5HgV9RJIxYJO+1iWbu62DuWR2etSfIHiXSb/fD4
	nvBT9X2TFgjGC5XiN3wTG8TxET0BB9aD2FWOlPaggx63dZIdlwRdWE/HCpDPSP1Jm0WsBQL+8PZ
	Z
X-Google-Smtp-Source: AGHT+IHLB69GxVMwFnMy0jelGw6aj5CcpkPp22Y7cYjJnT+9yf86SoEjNRuabyb5ciGd0+bd4HLnxA==
X-Received: by 2002:a17:903:2349:b0:20b:84cc:592e with SMTP id d9443c01a7336-20c637517bbmr62355585ad.31.1728517764615;
        Wed, 09 Oct 2024 16:49:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d0ef9sm75803385ad.98.2024.10.09.16.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 16:49:24 -0700 (PDT)
Message-ID: <67071684.170a0220.0f58.ca7b@mx.google.com>
Date: Wed, 09 Oct 2024 16:49:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 2 runs, 1 regressions (linux_kselftest-f=
ixes-6.12-rc2-5-gdc7da277516a0)

Regressions Summary
-------------------

platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie | gcc-12   | defconfig+kselfte=
st | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dc7da277516a0f22fcb4ae904c4ce0083ae0b9ff =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie | gcc-12   | defconfig+kselfte=
st | 1          =


  Details:     https://kernelci.org/test/plan/id/670709178965018b0ac868b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-5-gdc7da277516a0/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-5-gdc7da277516a0/arm64/defconfig+kselftest/gcc-12/lab-broo=
nie/kselftest-cpufreq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/670709178965=
018b0ac868b1
        failing since 0 day (last pass: v6.12-rc1-5-g45a8897db67d4, first f=
ail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

