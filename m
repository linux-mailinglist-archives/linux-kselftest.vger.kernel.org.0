Return-Path: <linux-kselftest+bounces-7321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1B89A62E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2C31F22A40
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA8175558;
	Fri,  5 Apr 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PrmSG8Yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F42175550
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353281; cv=none; b=MgLQm95rZkjtHTA7M5teqHFK1ac3bre0d8TibCpPTcwx+3eo60ljZEvY7Nm+mGxF92BsVUpbc2hbEJaLJIHarQzVHYNFNddg/+CA8OBZRgzV0k3bwkexOLh8S+s+bIQ4PXjlSmUYL1iBbH+8C9e3FUwSnFqfY8tSv17d1HK+TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353281; c=relaxed/simple;
	bh=tjeSjQSaZ5DiJZAqmjXceeNRX6DqLo95Uf/d58RCrFI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=uDiQgSZYe8ruc138wPGuL4WtpRHx6uQZaQh4KtZtTyxegUhvCVqi39YOMLNEFMu7yQJmLZgIoNutwfL3OPt97UK7ctd/d0T8np/vr1osk10uv1cQLBjzasH+9DMWDtXn1UYUJKiEsAW/5mSNua/MdTH4/ef/XCjMdcBM7sRqAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PrmSG8Yr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c7549078so5896355ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712353279; x=1712958079; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJrJjvg0gB5hywiIMY3/EUmTbc2KX97khTv0PlNqlsI=;
        b=PrmSG8YrQg7hlHEkgEZfPmSy0yBO5AF/XVpQShcIGAh0vVb7xL7XvMB7mZ0wVVY0uj
         +/45ELtGm6fNmmqY+aJhKfQu4ZffLoDSCSQ6qNWsXoA234G7i8WIcw/pqHXcYS54XJZn
         XxZQFMuFVpVsqhmynLhXXrVe3NS5VAx08cXYnS/79tngcp0YbB414KRbiWvIqKCXJceO
         w94hY/lbmsy0yWQZsMXZfK3NMtVxxamKrqJ421qSa/XV5pcTQsXSNfvc0DKiiWRS408n
         IIVF+2CCHKOxB5WmjYoxyJA2CRKCL2Yj6RLWwd/tuOvcrd1YC8H4Tvos6iQfR0p6J95X
         5Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353279; x=1712958079;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJrJjvg0gB5hywiIMY3/EUmTbc2KX97khTv0PlNqlsI=;
        b=Doli72Q4Hgns6e0KlSMP4rfIUNyA5WSCgJirs10Eknzzs+5s93oc3ZUJyZQSXzrYcV
         3fSH/Y9NGbMXJyscndWVqOxIeBB+BKQjSDVIUOVelzrGzCpvGdHY2lpX4XtDLLnVVB8g
         gdoDPQFmgzDJ3go0TEZ+BsTNqKMgciAY+vssVSRaEwCUxUEMGVZ/x+/iYMGxVDmfz8Bj
         oT9c8im++s6JHb7UhRMua7YRzIotZ6abTozUCmanp+5ipKYFA1b5h1Zwfx3BmZ0bC9Ge
         Ov+DxwOj2zJNRdqhVahAKrup/GvWOloaX5NdayKQZROpv2kBG95XmZmeU0QKMDNFWwV7
         cOhA==
X-Forwarded-Encrypted: i=1; AJvYcCVBbHoX47KOHswXBOykulGPDtqhKN8bwYq9OswfqaasMewmvdjXYxA9najdYPD6aurq5nUBZ0ZazeuNmVQsRStqhur0o2n0pqNvBZzufStY
X-Gm-Message-State: AOJu0YzhLBrCHeh9vyzeFAPGnYobqfJMGr9SfDCWVfVQkzzcaBCl+Fph
	m3tLzR6cSam8zZ3EGSdPp4PREaUyLx4Kccv3HzdqTFDeDBMtANZNNPEet6XgRBlBezBX7k0j556
	0Llw=
X-Google-Smtp-Source: AGHT+IG9DXWIW/hIOd0xrENlXAVoxy8wr+u0zQJXtMGde7lhvowhq+VnAoKgZjGkiGaj0fyyMuEgGA==
X-Received: by 2002:a17:903:2447:b0:1e0:c88f:654f with SMTP id l7-20020a170903244700b001e0c88f654fmr4928062pls.33.1712353279470;
        Fri, 05 Apr 2024 14:41:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001e29aa855a3sm2075631plg.291.2024.04.05.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
Message-ID: <66106ffe.170a0220.c4487.7341@mx.google.com>
Date: Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc2-16-g3f4d0fa96430
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.9-rc2-16-g3f4d0fa96430)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.9-rc2-16-g3f4d0fa=
96430)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-16-g3f4d0fa96430/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-16-g3f4d0fa96430
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3f4d0fa96430b23553fc9c8c36c2ff9cdb8e9667 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/661062c0486fcd3f114c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-g3f=
4d0fa96430/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-g3f=
4d0fa96430/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/661062c0486fcd=
3f114c42db
        new failure (last pass: v6.9-rc2-14-g4389636db356) =

 =20

