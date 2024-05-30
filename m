Return-Path: <linux-kselftest+bounces-10886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7478D4290
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 02:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F9282C1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43A8814;
	Thu, 30 May 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UZwkvsXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB5FBEA
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030410; cv=none; b=Tx5sFkvNyWHX7GiLbehSkZrLXKOL5JDogOgnazV9rJ5nt/CSpYukctYbxIz2ukEpxhC//OPTgBUPm7j+pD4kwAGlQ3gzYOwDFFNWGbG4VE9fqtNywBrdNTxYWA0GRrIGKSh2cFA0IIfoeMbyBLNz469UfFYlDYr1lGXqX2GLb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030410; c=relaxed/simple;
	bh=GD05gVdYUKDrl3OummoGgcYaIKKn80OQ9fEzpWObUZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=oEfUATsMwcJRNM/oEdNsNATmvkczIiNyNyUgdXXPmH8GoaYs0hCBOob5nJTgxPuMpEJ1csdmrKYdvcTu4Y6zldjyiJpJ9A8UnXf+fPrXOtbpbT+fHM+5+5FM4Mfy0bzeY9cLphFNRJQHcwUyKVviAKvL73ctlK59pm4EY19lGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UZwkvsXj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4c7b022f8so3506225ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717030408; x=1717635208; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MO2ZKGbJlHAdv7m9dmFV7pxZw7JwvvyiC+eLGFHy/Y0=;
        b=UZwkvsXjYsVJnImI2tY7+dyVLY9mBJHZ0rF8hWp+aYADjkL/nL2EW+PYDLmjNid9Hg
         o20kIJs6KYaoHIxp42S5MzvwyFr6lvwlU3McTikSME1noBfUtKFBj0F78FGqZ3UT09P4
         mz83iijOJhtfeg2Jy6wDvsn6V1vx9xvaIOQeO1UdfQ5FsltMIIPMre8yv15/tCZBCWRO
         QSxQp2zF4xMciVU0hx45SQGdBLLyzWOy1wMnyvyBnV/78y3wTHU6NfZuQOg/TFWHSvLW
         FG1c5VHIh5DWOrNxJmpENDd9r9avP+woNlWO85pZiihHXmHAgq+0SwmIiyHJFXK6a2Uy
         d0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030408; x=1717635208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO2ZKGbJlHAdv7m9dmFV7pxZw7JwvvyiC+eLGFHy/Y0=;
        b=e7l1WWRUKZWsxq5ZoIuCDfFyqvCBbht3vuAE3c5WUSIj1G9yinl01TkAvzfeFWX6Xl
         EwkXFfSs0M5sQV41f00joYEAijZPGPIf1bZJle5bDxgBGTuSptXtS+maBuz3USMY/Kmz
         IhLLMDyUmLOREpyE7375ilG74E3djHjzcm2qGAZzWzRGSAVgHg9JrQvtjA9ks1N1jNqn
         i6eehoqjcoT7k2xsIugNmrMujhsCKqmwm7K/JIFcVGA8scFUtg2voO9TdQa0VIueNmPJ
         Tf0X/7uy0qy+U4yEYnlHJz/cqXoiPgBrwcX+Oz2HbGWHZyvo/iFWykyFrSitKsnRLpza
         vEew==
X-Forwarded-Encrypted: i=1; AJvYcCUGPMocwcaPtk0weRyv1qQMGhzBviEDaUaYSGRsGpIO1W9VJTAGLJVJa0FEUDwWEeLvlq9lrEMAh1nfICW7A3xUolmm6KZmJur5WrMwuNAR
X-Gm-Message-State: AOJu0YwEgkgqV38yyqbB/i6PM8h3F0TkxLbl+lwC3srPfzhOklwUBquA
	vwpkx4AEzczxZi97S0l83k0uN06r5PaQokFoPJjOMculf5spErxANRPYFl/j6cg=
X-Google-Smtp-Source: AGHT+IHTVLTik3cD/uUZGT6gjY+nxeLt+H9OFjyuQfIrpeGhRoMYUAaEnwEe5893SM52L0N4qEWxgw==
X-Received: by 2002:a17:902:c946:b0:1f3:35ff:ad25 with SMTP id d9443c01a7336-1f619b31f8bmr6795995ad.63.1717030407878;
        Wed, 29 May 2024 17:53:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4720a26bdsm84566445ad.218.2024.05.29.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:53:27 -0700 (PDT)
Message-ID: <6657ce07.170a0220.f959f.6ae3@mx.google.com>
Date: Wed, 29 May 2024 17:53:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-7-ge8b8c5264d4e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 6 runs,
 1 regressions (v6.10-rc1-7-ge8b8c5264d4e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 6 runs, 1 regressions (v6.10-rc1-7-ge8b8c5=
264d4e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-7-ge8b8c5264d4e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-7-ge8b8c5264d4e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e8b8c5264d4ebd248f60a5cef077fe615806e7a0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6657be59589fd755537e7084

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6657be59589fd7=
55537e7085
        failing since 1 day (last pass: linux_kselftest-fixes-6.9-rc2-2-g72=
d7cb5c190b, first fail: v6.10-rc1) =

 =20

