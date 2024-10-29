Return-Path: <linux-kselftest+bounces-20916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798639B456E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B38B20E98
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9A1DED7D;
	Tue, 29 Oct 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Yj/c/kYU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E882F30
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193449; cv=none; b=XVH12k0zgJSLyTOKh4JCD8CrZINRyluvyODZcc1ixtpBMEox1eaQlesON2ZoZq6McNBi79a0TpKN7jcmAnPTPAPAac6p+Zx8O59Y5uboRixQwvqtO7sWZVWD40LuQB85Ii0iPDZhSbSiWlBNYihBpfHSxMqB94MmfJ/9s8gdLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193449; c=relaxed/simple;
	bh=eZYB/KjTfqaD7Cb/THDTP8KwHVmCgf4CNqvWsqYN7lA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=GaGteyaGOPEmUKSQqsuGw6GnLV5/v9sCc9PNxbvVpRcvds9sv96g0EFhqkxyRhndR2HFK0ULgm28DPLTHtcyXLC0x+/8EqG74Hy6LRrZW8Dmplkm7ECXeWjWrGKPUPDyp9ZGrhZlWrGHg8u6pRXu8cHEH6cFBmOt6JlZbtGljE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Yj/c/kYU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so4163116a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730193446; x=1730798246; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt7NrvU4gypd90uBM+aAwQQYS6bnDeL06eQz/2IMQbg=;
        b=Yj/c/kYURY++TMh4ZF4c/JXlMFnw0ah6VKTvOkJ57PK73twcrKHH/7Np1t65xhgzYt
         ah4xRErDoCJTG38IvZXOo6UrOyJYr2xXX0lgmDHU13FZhEqioOB16n9D5tzyegwDJHGd
         yjjEw9nwBIsafvhLHGqZbro6WCHB8PliTtNSJ9CQQvYlm8WrmstUcosEgNqr1nt+zJId
         GgAx2e5N0AOUic6s3vOeKxGhoqd+/7N0DI+ED4CLpJnQmsPXIgU4zPTFDfkhTvKscuxT
         uiqCHTswfNdcEvoqa16laqgMHc7TNenVp344KiCPWn6jWoqy5lY3gwFq4mx5DcwBPy4D
         xj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193446; x=1730798246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt7NrvU4gypd90uBM+aAwQQYS6bnDeL06eQz/2IMQbg=;
        b=komsPHF4ijRsLKzBEKLn4lGbbYUjoS5eAU6K8+Jhi0cx6uEaEtpopIwgolpIxhvuKT
         JlwthYZgO9bJeFYL9FABfmbEiaEuQgxNpZ96d+PNox/Bf1bWamIdYHNQgYtvMZ0BG0YZ
         im6vQHE5UhLIjQZSbnk51h2/abX+CgKaIlzgoSzefXn20ZeAUlvG3fFAsGGqvn+YMY6L
         5Fm7lCssaBcQzmqXlCYSfmqGryf9ffHyusIHkGdWhDYfC7eCKmI3gX8vYXyGJW2F1FJi
         sB/ciHUwTpK0FY0OUep10zHsKsxLflae3V/M4mS6HsV6DFcN5Er2iMuTFuje83RDFjZO
         Y/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUQwRQavudjBWouAR+Go4lemOI/0uhPFI4fCcQedbHYhk5Or11uSdvfGWfxdgyfxNDtJMkBlu8sUVcrqBhPeV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7+QcRwMZHqHWeSXEdfJgYoWTWNadkFQq+xjpwVtLU1XNAn50
	HTBiYLioZ9JmD9ay695QOcsI1aYakFoid8jtApu3VxaGOatb9r2Z/lg2NAvISWk=
X-Google-Smtp-Source: AGHT+IEDQr604l2xFdK2FtalAgwIlg7yZgad5LdrxtgWwsJDpTwUv66F6R2jACMeIUmTNAKjUQnT9A==
X-Received: by 2002:a17:90a:5d11:b0:2e0:b65b:6b4d with SMTP id 98e67ed59e1d1-2e8f12e1370mr11517817a91.41.1730193446429;
        Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3748a56sm8885852a91.40.2024.10.29.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:17:26 -0700 (PDT)
Message-ID: <6720a826.170a0220.c23d1.010c@mx.google.com>
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
Subject: kselftest/next kselftest-lib: 1 runs,
 1 regressions (v6.12-rc3-8-gcecc795329fc)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.12-rc3-8-gcecc79532=
9fc)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc3-8-gcecc795329fc/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/6720a485c2f02871e7c86857

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc3-8-gce=
cc795329fc/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc3-8-gce=
cc795329fc/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6720a485c2f02871=
e7c86858
        failing since 91 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

