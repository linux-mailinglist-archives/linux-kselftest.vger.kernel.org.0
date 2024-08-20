Return-Path: <linux-kselftest+bounces-15797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B25959093
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F01F21CAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935AE1C8223;
	Tue, 20 Aug 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IGPayAtx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FC1C7B7D
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193631; cv=none; b=C0PAy5DDNS1fEqMHe5Y79fHLkexQ8IoEEdwsJVIGzZOoWYB6FRkY4Xeyj9FsMoTCDIZ7boAryhRfhbYsIhuh58fkEItpcEzPHBHs7NHtOHh7uNhB+eXMi5OhlTIA1N+7CCoRuhP3eDkrO35sI4j9J7JPdN4Lb4y84Zdp96ZUtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193631; c=relaxed/simple;
	bh=jYubq6biJk9LTyXmr8vEZwm2S6RRd359NOSW9WI3yGA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ZxVXfE/hhqLafWn/pXzoo//EMFCa34qgHNIFCeqt143n3qoaqhzZoHgRel/Oq3g3ONyP7uE+WxYMT1tgUACYltVUaxHbXJooks19inap2fB3yDF3wOo7K3xFAsn5BHr8GNYoGLAsFeRXbt7z7Fy2K7AbJG1XVWDsdQOMynZsArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=IGPayAtx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201ee6b084bso50897335ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724193629; x=1724798429; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v8gunQ0+j/xbWPDm3ohy1cyp3A9FaYyqu/hwHgj4W+w=;
        b=IGPayAtxmSZur8NTRkvwvjnU4nALAIRKwVQudoz7fGm0KdjAvD47XdiDsaZUOcMtE5
         dS5cn8gN/r68I47rQwF70eYDhyaQEIvd0LpFC0mSTw/p3NMKg+ylltinI0x/ilvLyOEf
         Ax9NjLMVB4G0FDh7i2BmEZtkUGjJw9pAxGo/zkl+utFMI8vegB5tAzB//ukZTWUtlseb
         H/bTK5ckfyMKAukeQJf0Eif0xjX25fMtA0znDqz+afOaPI9sD9AkmpvNmMax9poOIjoU
         EgDW1zSR+hMHr23bPgJglcFksrcBnIDyjrWsKFxXwG2M4H0C5wVRMO5w13Qm2zor/TEd
         jsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724193629; x=1724798429;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8gunQ0+j/xbWPDm3ohy1cyp3A9FaYyqu/hwHgj4W+w=;
        b=FKNCAyR9spIzDRcZvnSTQxsYqAWZurxJdoxAEVmnpy9sXCkABaKaGSU5nk7hW4u3F5
         nq0/HdrdT0l/CkA1FWR2WxEy5cjuFN2US4gYyBuL3Lj7TdIjxbw+vrpl69gsj1tvmCOI
         GMJ8yuHKzUd6dHw+1Sqe57lt10vLdrXVy9EnPwW+QtcxqNjxiDs/s3cCHkzGBo2n0i+5
         jvhsnC2yMmGsW2Q4lfvUKA6WmgxxVvi639/dH8ostYcLyAiv87S95urMDL5iCqzLN+vb
         LkoTBAjH8eWKpUXJfFyLe4Ss6oQXtiQ0V/EGNTWuDRRMqVuVeOw97UDVKG5bVFgZ3a2c
         50cg==
X-Forwarded-Encrypted: i=1; AJvYcCXNW6IEtmcYbkBng3UbIrtmPQOXOo7p/QWvNljVJAi51uuk7ytz3KEtYTfG3I/RH7bvf/oBo85RXCtQJcnUo40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34gnXLa3G555s1OaLPgWcTCNH7AQsfAA/OpIUOXTl6o1UVnGm
	dTWAKIttRr+Wqfw9y+gwxH0Q6iCHCuQzP+1lyUmoYnMaNm5a4eVHB0UuibF4yJbkNxRJdtbO7YM
	N
X-Google-Smtp-Source: AGHT+IFVwIecuO+xJf+0qhb5CTXH/IihHI2D8SnmQKfFEO4sRw7LErbRUxJaDAGaroQBR9V8MR8Cfg==
X-Received: by 2002:a17:902:d505:b0:202:4666:f03a with SMTP id d9443c01a7336-20367d362dbmr5374085ad.32.1724193629133;
        Tue, 20 Aug 2024 15:40:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa52sm82957745ad.12.2024.08.20.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Message-ID: <66c51b5c.170a0220.2ef4e1.e1c1@mx.google.com>
Date: Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-13-g41f37c852ac3f
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 1 runs,
 1 regressions (v6.11-rc1-13-g41f37c852ac3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.11-rc1-13-g41f3=
7c852ac3f)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-13-g41f37c852ac3f/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-13-g41f37c852ac3f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      41f37c852ac3fbfd072a00281b60dc7ba056be8c =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66c5157c7ea50df009c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66c5157c7ea5=
0df009c86856
        failing since 21 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

