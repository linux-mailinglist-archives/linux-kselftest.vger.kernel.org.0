Return-Path: <linux-kselftest+bounces-17088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A096ADE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9099E1C210A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59868F47;
	Wed,  4 Sep 2024 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cIOKu/RA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435879DE
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413244; cv=none; b=Z9zu2vjMVJb7WpfLzLksw9akLln403BRRBX64QWay717f1U5fnkrHWXTPzUSaTFkpFb9dMPlOgN084k0DwUeuyAG9AJQjhyRTQO5Hdo/hW89SXkPqA9OKAdZzjDt+F5fk+zG1X8VyUccM0aApLeeEq5CK0FVesXDWd1ot7pMca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413244; c=relaxed/simple;
	bh=rQUeY216BPRHhs5pFUaqFKbxQg9baq3ttTG2zJU6H7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=p4wF3uzdrciojYQyt0IvteExSrnB2yR8WVNBTSmC/5rkMwxK7O2Hg6rlv2S+BnjSx8Oj1MyCMW+3FT9XciXKDNvrc2MvDdvYKl00CaixigErNPk/sYQlChwoD5oVOFbYzFNaCMDtyiLi63xkrFteehLG9+cN2oRAW5KnwW+BB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cIOKu/RA; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5dfad5a9c21so208678eaf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725413242; x=1726018042; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kmwIuVkI/KvZY5xaavAUpX9EToaNr1Q1/O6mPs+vs3s=;
        b=cIOKu/RAsyHk6rlV4jqBj1evNrmQzHn/JMqb1nPh6qgTItLLsMeNcUrynom9TX//Yf
         gQ8zKI04i2NJdgoa3v5nKV5yyklp1en+u9aB1JNSwYH6AWB8Kqb8kTS9RZAClS7zJRBk
         NbpAL6P6uNvtZCQXukTpNMm1ZS2UvTnfP3vPal6RyLnxFSPxU8k0tOSiKfpRS6YKLyRP
         oIgXKdc8DTA3vIg0pp2LY9s2ifZAYL7AfxHFC9BO/iXv3RmPSrWzHlYHT6wKn5MussQ9
         aRICyUEcCZaUd5HrDAicbpyvR0iPIabBRosRyyv8Z1+neD99ohDrPB695/XQYSN4hSmi
         omDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413242; x=1726018042;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmwIuVkI/KvZY5xaavAUpX9EToaNr1Q1/O6mPs+vs3s=;
        b=GQjTIhFB+Q0HszjKfLDJOe3c5XpC0eL7Q/R/gSbG491sJ6zIC4nBdZQ+UI9E5coR4a
         LHJYJeD0oSl5fiKcmE7NJSmkK1bkoDkX0+30IWxDi967w8Q6LORc/Ua+n+FU4PvFBC9s
         W3AGrUGJ6d5bd4armtwHQY4oNgJHHQkLcRxcXOP8Sq8cpiCG6j92KxuRk0rsRYSvBd4v
         wBOwX4K7GOqUVLNZ0xQm95SgCNzDStJVhL1gHQdhtWiGbOeKThe8GKLBL4HXF1cUPohm
         lZRoEh8I0pV6Icm6S60KMtf4az5u0m0n1G/li6Az5Zuvo96W091Sq8x8J6VxJU+ZWnUu
         a9qA==
X-Forwarded-Encrypted: i=1; AJvYcCXcUWwi5Ccln93B3nOJiriIRuzwGJwVD2xnXL+6l7x8I/qXry8mws6EGUdJbaxjxyUb6VRemoy9foC1ISBd0+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs13bnFXnrBaBJV72lLF47hSf2YgsGDCtWtUUbU5ssEkwUE/EE
	Tbu+8phwUK2X/iAJCD4/Wl7/88YUs+v8wjswqdm+xUubu2TSQ8lElxTqVS1eytQ=
X-Google-Smtp-Source: AGHT+IHpz4qumzBmM7wHBcsF+nigLGJ/2yW/xqvLa3hL5PlxXIq19g4sT1kKnnE0LuMDNGUZ/5HOJQ==
X-Received: by 2002:a05:6359:4597:b0:1ad:d28:976e with SMTP id e5c5f4694b2df-1b603ccacdbmr2103262955d.28.1725413242044;
        Tue, 03 Sep 2024 18:27:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd85b0asm514556a12.17.2024.09.03.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 18:27:21 -0700 (PDT)
Message-ID: <66d7b779.630a0220.172ac0.2d05@mx.google.com>
Date: Tue, 03 Sep 2024 18:27:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-17-gb4bcdff7e839
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.11-rc1-17-gb4bcdff7e839)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.11-rc1-17-gb4bcdf=
f7e839)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-17-gb4bcdff7e839/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-17-gb4bcdff7e839
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b4bcdff7e839237d89a2aa15b6042b96b0240ac4 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66d7b2a624bc264505c8685f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-17-gb=
4bcdff7e839/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
kdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-17-gb=
4bcdff7e839/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
kdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66d7b2a624bc26=
4505c86860
        failing since 35 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

