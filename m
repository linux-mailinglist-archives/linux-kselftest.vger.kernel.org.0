Return-Path: <linux-kselftest+bounces-21432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB719BC309
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD571F2266D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7AC24B29;
	Tue,  5 Nov 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="q4ZrVLGe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DF1C683
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773003; cv=none; b=SlAyZvZ17CoS3FwEgBlpxKXEUuTxfIHSDATtI27IBmRRJOOdFl5BUr5wquQAs/8GQ31tT5gHKlRyRJz3FkmUOJf6XYgzVaV5tCO1+vu3cI2PckZbppQCQtV+Fgnm7FJG/HSNGd0WiXVojvGreQ4qh6FwvmwTcF+NJy4SjlVscTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773003; c=relaxed/simple;
	bh=JIFtZDjgyVdwfCZlEM9Wiw8HfK2P6u0u3IhpuvxYJOM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LZlkNn1iXjLGHYhHSz2J8uqcDjIdlSeIfGu8A8bWHcNd2VKb2jFN5j75qnAfLlaNskih8jcuCo0zodDCHcAvwTY8u53gc6b8PHTeSNd1o+3vsbEHulr8KsrdDC89/EYxtoTm5NEfiF2QHaMZmPpEjSMuSX8momuH314umZbPuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=q4ZrVLGe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3764518a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730773001; x=1731377801; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OTvAOQmXBnUHnZCryZKSr8qj+0o4aEigoYpntaafTEc=;
        b=q4ZrVLGeI3/EZpxihxZUlHzsRG3y4I3dhiPWDJeyZC2e3g2nBO7ArQFMoBOaNTd1QL
         ThTbrUsp3+A16OHgZ9caQNM272VEux37vh5zOQubq1QM6PKQZ+OapeZXZySW36NuHuhf
         tutB4ucWIvuU57bimnyAcalppk9IV62TUbpNKNhymX8Khdmg6qDNwF0UBvLPCSNTkmwM
         Vde8j9Hp/Il6gQCatGo1EE27xAPEgAkQvsJAMN2q9jYOK+fjyE6WOb7NDfiJFD81jiMK
         DxpLfUf728YJXO8kD3y/6fv1y/vNO5RkTYVRwEz6qTNXsijeY8VzvHY25oFup3UAPjm2
         h0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773001; x=1731377801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTvAOQmXBnUHnZCryZKSr8qj+0o4aEigoYpntaafTEc=;
        b=vXfIeQ6SI0U/nZ0Cqpu6ydavSxqaB+mmVSqXrw98Hph4b6Jjyi1ZZQw4Y1DbyMalJZ
         1SxRQPpnC5FYbTF93ixTn++IZXYNJwlZ/8soMrwRC3o0LTYuwLZMLnPfLtriLPS9+XxX
         xxKJCCfAmOLXCFc5H38t0s4YyYaASg8i38+xT+MHoLTiU5j12K1wrUcw5cWWYbbzqnit
         a3tnTvjyf6fclmGfkapverhsBWr2y+ki+ii3B0CPV5radD1zOZKYEoLGQ4J+9Egk5J+I
         MwEUGL/IfxpE+qZgAp4lqUYAfBwIfuTxkPSEy3fZ+j5CDj3G2pU0Y9vGOUbCzcXZf3sm
         Nj5A==
X-Forwarded-Encrypted: i=1; AJvYcCWTps6QH9/K65AKSiff/LYwI4BEXwpUWdvqu5ti+B6PeQ7KOvccRqfxPnrnpaV7M3L7L5DTBgkJc3qgC8V1hP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCO83bxhSMR2F+ZB6sqzgCGOpkwramSDmk026ywo5duxYMoHd
	EYGiUCpAeufylxMqzNpPRUnqgEENJaiQAzxwOUg0GdvON3xItrB7PF9DocEHkk7ygpBi8jgiS9w
	4
X-Google-Smtp-Source: AGHT+IE4TzYLWK7ci/gVnJjoJLVtIw9kPW+wHr2cVZ/A0Oz1/8h56X2ZpFF+bL9/gr9dx/0zJVv53w==
X-Received: by 2002:a17:90b:344:b0:2db:89f0:99a3 with SMTP id 98e67ed59e1d1-2e8f11bc3a4mr36874839a91.26.1730773001558;
        Mon, 04 Nov 2024 18:16:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa24ad2sm10815194a91.14.2024.11.04.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Message-ID: <67298008.170a0220.181085.2dea@mx.google.com>
Date: Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc3-23-ga44c26d7fa74
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.12-rc3-23-ga44c26d7fa74)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.12-rc3-23-ga44c26=
d7fa74)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc3-23-ga44c26d7fa74/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc3-23-ga44c26d7fa74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a44c26d7fa74a5f4d2795a5c55a2d6ec1ebf1e38 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/67297a56d7f1f585c1c86864

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
kdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
kdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/67297a57d7f1f5=
85c1c86865
        failing since 97 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

