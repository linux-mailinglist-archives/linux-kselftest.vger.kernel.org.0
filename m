Return-Path: <linux-kselftest+bounces-17429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F996FE42
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D06B22E34
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB515B0F1;
	Fri,  6 Sep 2024 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dWM2Zh8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76D15ADA4
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663576; cv=none; b=QF1qL+Xeaj6mU6xzIraX2Eu6klYJtI+sgglGaCK/zqzLTtJ3Cl1UZWMVrx5b0LjelyE9xVR2f6WkITCmVxmBC58YGx3jmQHWdmm65LDa6J7aJwb8HwFeodkDxlaKVLUCFtERvLMDAAMiThA9nwGs/7hCrsHghvOJlp/fQrywW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663576; c=relaxed/simple;
	bh=tKo6fSYm2u6tS2V2/CLwCOEROXEu669vHSbuAkX1DVQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=HjAabmp/3/Ul6gO2qCKLYKRxWStPQDwPfgaLCWmV7yez+rYGAgcF3PA4xFKbe42QuNuOOOudr18ez0rgT42D6mCpcoIzYA6KxNg9Mp2nc3BlDdqAJXOoEHnx4P49WAWQPYw4wVcHHeLMiCb784iihRwA1mzxKi9Gbj/BJrSxNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dWM2Zh8F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20543fdb7acso20653295ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725663574; x=1726268374; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nFt2wrsHGqarAephU3/+s9xz1g9a93eXKrlzqpklLak=;
        b=dWM2Zh8Fu24aHHIpUqgeSmXj6U+ofoc0gV7cDC6bPfHyaQkNfjSeSD+p8fTG0L1ChH
         /SmjWVf8DBBLHJPqLTaY7UIk4am7nNmuKemx7sLTV+wpjwxcMhOBc7BmD4zSIqtp9Tbl
         wM0kRqz8aEMAUW5lvzDiDIH3kjLfTSfntZos8Lx8J+BdonUUTG7q+le2gUoAL9I3/ehS
         E9zLJ8XO60cazsndswcW6SVIMcSblQXmvp7IEz+h3gAVVZM6eKCNiaOV1WUAgZEXuuq3
         xCxcJm9l0f64ZUo2JD1ZjTiv5bPZoM8olcK6kIA68zgSjBq1vq3rdquHpe1WAfOCCvZM
         OgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725663574; x=1726268374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFt2wrsHGqarAephU3/+s9xz1g9a93eXKrlzqpklLak=;
        b=UMtHMgnKLn9orfT7ONMKFsgjGmhQpV6HSAZF1nDmKPG8OxQCozm1u8Lz0S8lm/cfOw
         CaxXL6463l9RSp08cgf8OyUDyDJoMFyNyJMZDPikKuoHhlBHvYdGfjOIwcVmYdrg07sO
         xLmy/9PHnnTb8JlSPuDRMNNRZ3SLXhhIG4RAS+EL7y9PRumiuIgNsxLN/dnoYTXAdH6P
         kxAe5m4REkMmBKVPjI3bYV2/y2Xod60XwulD09U5OI5JqQx4tIyEsCqLEx6a3Le5aLpm
         iIcm6uCKcwmxfCoHTbQDUIIJE3dJOhxoQ4DjdtYZU039t2NdAhnYeVOTcS1BIuMH8cAs
         6yaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTgcuRYTGOZuNj3E7ZTIhKclR9rliBtMcGY6hXGgdprLTVInzpuWEoX1I1bQ57gd55eFkHa/4aV80ZvZKOe9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BdZIFA34s0sfQXmARpbkRZ/P7kq0YywKQEMJpG23wpfapKm+
	h1QXGtqu2fiWi4J0JoM7s48D4BWmkArBEcunDw0P7rfDNwbNn06zaiS7WQ4sKNI=
X-Google-Smtp-Source: AGHT+IG2Kwdz45k3g5zrVUo1pVPn3c+/rlD7PfWz0IbJ2ubQVnMvTZ/2SzSF6xC0BskxdfzU1VTcfw==
X-Received: by 2002:a17:902:ce11:b0:205:7413:a5 with SMTP id d9443c01a7336-206f053141emr40567355ad.31.1725663574168;
        Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e34f32sm45725ad.109.2024.09.06.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Message-ID: <66db8955.170a0220.937b4.0040@mx.google.com>
Date: Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-20-gaf1ec38c6ccc3
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.11-rc1-20-gaf1ec38c6ccc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.11-rc1-20-gaf1ec3=
8c6ccc3)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-20-gaf1ec38c6ccc3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-20-gaf1ec38c6ccc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      af1ec38c6ccc31ec963ac4bcf8f6a7d8f44d210a =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db812c906848735ec8689d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66db812c906848=
735ec8689e
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

