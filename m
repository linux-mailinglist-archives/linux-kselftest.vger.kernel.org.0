Return-Path: <linux-kselftest+bounces-20917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1D9B456D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C21C2105D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E781DEFFD;
	Tue, 29 Oct 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ll5DFeeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB4C6E
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193449; cv=none; b=cwKE5anmoSwRBsSYWNPLCLp13VK9N89+qnyhZk3aPWfbqwEjm/DMPqAGFH06iCSqUZqVc1VzVF6J+ZTCRlGZUG8UfujxG4KYnp2iDdsX0AEgYuJsCcuBKTugWtHCJ62rfRx3Oxt0O8X/Av+fR7ilFIQ4eYCzyrGT3lvlWaT2h5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193449; c=relaxed/simple;
	bh=DN3zhVVSYtNZdIFUJyS2AvP1pvgozbqO8vrwX+1iohU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=UhRGKsewhom6PeS19uNKLQXCalOxm5cu1YFCDlydToY0+tz+StUiy1KLBiONRjlUsDrjVBdBJ5WqgZf+hzmUiA0QIczsYeQoz7rdLxYvvBOkJdlj5HIAY3HrGx1u0vhbmtqtifdI1TPVSxduh/IFa7Q4KWo18pdbMddOTbfk8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ll5DFeeB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71ec997ad06so3741243b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730193447; x=1730798247; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5+/haa+niblan4ksAxGM4Qi5oCUWhSQgLaMDwtYAmk=;
        b=ll5DFeeBBUQA68OyTK5JIWSb1gMtGExmuC/QwpOlNdadKMO/eP4e/pNpnP9MPou39J
         +I7X0tRvlL9RGfew7rwOVS4RXZMUC39bvWchVlzr4X+S6AkJ4b9P4noOxCP4l+I+whX/
         zaYP5R4J9r4L+0Wp01tXCei4k1lJr2Ud0Vqsr85pdIQJaC++p9mPDej5rErG3k6LAuU/
         NYXqmmmTSdnbMfx+70474oC4da6tB11bIVqEl9JSlshf8gHb+vRkV54EJhGaicf0UceD
         5gu+5AbjcAy8Osfd/8qdQEI4zyCIc93E1RaK41yRGpOaMwX5G5QTLvEY7rGdgcbM4iUn
         oAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193447; x=1730798247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5+/haa+niblan4ksAxGM4Qi5oCUWhSQgLaMDwtYAmk=;
        b=a1Rh3MM2WYcCkiLBg9kF74npGHTutiBboFRK9zjmWLXMcrxm4XOKNNTY2kcuWGi9zN
         QDjd5KN+QxECXCmW1mJyUXOk+YND3Qmd96tkpgu5W2lsUuB03bodka5vtsN529g5wgxN
         Ctq2CyNKkdk2TDCBRx5UOWFW87+ZzCcxfuE0RSJg7EiE5GNGz8rBiwHjs5ThPT6HAAvf
         N1Ji0pXzQwA9wwU9EtOZG2ui4Bu6NqQpth4EdOwOW4kaxTMWKoJprnzgxeb4fw/4Gqo2
         WESwBSEjtuJxDCpRzrhgljwckrPYVUaRFdEzowkj9togE+41ryZbNfRvk1PrnwBupBpO
         Hw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUb/y3QYB77uFE/FeKHsqDPsOT68AhNHVkng39H1DE5eI10NYXbwQCCSqypN1bfITN+CcNXtR0z05pojMDMZpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9f2gMGYSUaKHBY4u+DpZJJJfIqQWEw1jL4cf50ONWtTKLd6H
	dWwNjKDb+z9ZhxG2zC7x41+S0LwXjyt3KQPtaG9mwBA74mOKm9BsJVSNzdebI/E=
X-Google-Smtp-Source: AGHT+IEsC0TpwAbCbEBKTe8NbI3iVaEVUABk6bpjRs0JcMyQK9vchnf7sncCO8eDaz3GOUkjl+hurQ==
X-Received: by 2002:a05:6a00:4f96:b0:71e:3b8f:926 with SMTP id d2e1a72fcca58-7206303df84mr17585656b3a.22.1730193446620;
        Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b65asm7106492b3a.113.2024.10.29.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
Message-ID: <6720a826.050a0220.e10f2.9b07@mx.google.com>
Date: Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc3-8-gcecc795329fc
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.12-rc3-8-gcecc795329fc)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.12-rc3-8-gcecc795=
329fc)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc3-8-gcecc795329fc/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc3-8-gcecc795329fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      cecc795329fc3e0ea2e84567ee57570cc050cf6b =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6720a2196a6ed469cec8688c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc3-8-gce=
cc795329fc/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc3-8-gce=
cc795329fc/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6720a2196a6ed4=
69cec8688d
        failing since 91 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

