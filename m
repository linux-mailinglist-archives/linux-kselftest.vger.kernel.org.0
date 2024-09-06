Return-Path: <linux-kselftest+bounces-17417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0896FC27
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5981C21EBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D513C3F2;
	Fri,  6 Sep 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oFvMO/Rv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF81B85C0
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651054; cv=none; b=YgK3Ra3wyCle7mvwdAVCZOrRvmo4hQUmr4Z+2WAO2e2qKXTsFyoxIm+t1Qbpl2sAvH0K5QPHA3RVcNTMffZg/DLGLw1hrmniJFoPApMi+nMA/s3IuDHctxlLcPh1Wt6OkVReKxtStrGcpAyNkO5w8shYGdbtBs9EFMKCtb++CJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651054; c=relaxed/simple;
	bh=tPpSiioknbRn6gVXItvW1AdO3rkQ7che2Ag/aDVEpkc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=e4vNCDqGuujSEJx1DQjSmn5vwRL3giF7faQhYPb5yVPABzKaxoTAcvKFfNZ4PVnS75qeEf+rYB7hGzV88DdqKedqXmdbAJXza+JrkmRhQhQFXwIyqkBduYlK/Pp6AV5a3OfPMEG+LxV8cgNWTbXNxue6nsYWleMannIC/3EjOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=oFvMO/Rv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d985b6bbso909739b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725651052; x=1726255852; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w9yVFp9HIPzYBqa3VA1gjikHIil2s4kVVq3csXFThak=;
        b=oFvMO/Rvlan+8AOH2KRD3K9e5ilEVP1yNL8wqm88W4woi+XAHFTegci59azmIDarKg
         m+0+h6VKF7lZX52LB2em974lTWEDfP7b5LSW3b48L0pyh39Wt6NwAiIJwXhsJ/EJViuj
         vLGbZBJSJeMG8VnMQeLPyTVgDZQ9sXRty698HNIgC/Ksu2Udo95UC0qcVfiIgH1UFMf0
         JDPjZ7KRTGfr2DXPPjqwnZ+rtXpknW1RIZ/DdQuIZI6pFZvSeX6zjtp9brKvIkxO3TV2
         nhhpaF3TwyrKKTd3WWDc6d8jngNEdPEMMg8mUMR89b+DfYEDPXmYP32P6XQqTUMOqgZ5
         2lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651052; x=1726255852;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9yVFp9HIPzYBqa3VA1gjikHIil2s4kVVq3csXFThak=;
        b=ZZrnlb8oyyKAYEbZg64e8O5qO5Ky0Ywn/p7ISMCWbEtTZmaWUj/In8uPFUB9bpcLV1
         gt+HCou3Sfifp1h2gK1CCX9hgPdiyMqg8Jx6p5abhPxQK/QTmUmuT/iI9jv1b6DBOTpR
         yOMdMOvlTTvuyXnjoWH8oSXWheoRsDSK7qvpja2vGBSBqI/5Dh7/RuzBkJuVK5r5fFH0
         P41FMuEttotW7YDfHxS/4wR36E3lrArMOUo32w8fYVm/BpDFLnVFCzixCWQhi50y6kb/
         8SEYqn8ymzv1wbFQGwXPp0N+NqkGm51x0bop35dkKsAm33FmPoUseyusGe7ZLG4SfhEZ
         zxMA==
X-Forwarded-Encrypted: i=1; AJvYcCW2L6n7mG1C2UY6w3jWHNah8ec4AmeHB8e1iu6O7koGPSIYmtOsvBmqSMRrKSfyjYsKdy6DypEOD3aEm11fILg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlsLnUxm9uIypjljjVfswG8EsCEcpzalwzSrtMe7eek9HqAAk
	n9tbh/fGDZtZytA3sLbpft8cgNFQXkQwYeLTJUkBjt1TsT3DIivY+eoIfNCwAa4=
X-Google-Smtp-Source: AGHT+IFjPS7grPbLE8z0wzcImI1YWlaZMeYFDqINLl4dC6/wt8uW1/dmMXx2Wj9K+C1g7l7r0NUMVg==
X-Received: by 2002:a05:6a21:1693:b0:1cf:241d:6024 with SMTP id adf61e73a8af0-1cf241d640amr2520262637.18.1725651051793;
        Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718db64d0fcsm1282687b3a.210.2024.09.06.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Message-ID: <66db586b.050a0220.25386b.72f9@mx.google.com>
Date: Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-19-g7beaf1da074f7
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.11-rc1-19-g7beaf1da074f7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.11-rc1-19-g7beaf1da=
074f7)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-19-g7beaf1da074f7/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-19-g7beaf1da074f7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      7beaf1da074f7ea25454d6c11da142c3892d3c4e =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db4e5b83c6242e5ac86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66db4e5b83c6242e=
5ac86856
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

