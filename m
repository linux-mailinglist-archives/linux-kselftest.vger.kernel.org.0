Return-Path: <linux-kselftest+bounces-4613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8738543A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 08:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FC1C21E59
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2831119E;
	Wed, 14 Feb 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gIw86Rmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D1125B3
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896992; cv=none; b=qtXgWd8BwmvVYS4J5KtfTLvUv7TAizbutqjbTbyP7WKFJ3j7oqJl1jlVjfrWC2H00hc5LsKC7AlqfEkocY6rYtYOSx3AnsNu3JELgQUWiFB1ckWIcAwLysuWuSs4np7wsbQQER9Btj+SDZs9HLykWZcUtPrc5RXXaqpY8Ytf+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896992; c=relaxed/simple;
	bh=IxLDmTnuJI9vNCN+Htzqjham+55N8c7U7EeT+cVNFn8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=g3nDYJ/eB6EgcO2JSpnjx3Byz0T+oO10gEOU4omi5/cy4/TSxr5QB/PsEXDyGDua5JEs6x2mN9fa5CEIPAVrjj5admsMXstw+vuP83hGH/rg5aARCJlvDwCS0e7rsS3e2Dv5/GPVzHhCwmr9GQHplYBM9dgrJON47veomjSjp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gIw86Rmz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8da50bffaso23409635ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707896990; x=1708501790; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlCPl9df5o4eeoVIGcVA2R3+MyFtupVxBZE6VyzigC0=;
        b=gIw86Rmzp4c2WeyxXYmTg/gWcKrWRqbhb3nk8gH8b69o7NTqt6kd0QI5d8xgse1rA1
         awp8kpCmCQ39f6Lw0DIrWRdyK3IiO/4Kd7sOXO8h4X1Ikr4hhICzjh7OFlo7qq3SnrP3
         DzAm+Y3ROGS3y718vTmly/R9BF+pUAz0r5fxG5RbPqV7qJRmSzHWEfytIlCq4TTBI0kN
         iUn21lxLLz6mlA2CnEot/cGPD2iE28+o3MdDjSgc080mzbjDLhiJI7pwqVLTAu+Gycy5
         6gvYTQ3sQBp9H3mnmA05na5TzU0mVJZX009ZrHF3tLbsGlXzbWMhLdDjBHOWp1bfMtcy
         ArMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896990; x=1708501790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlCPl9df5o4eeoVIGcVA2R3+MyFtupVxBZE6VyzigC0=;
        b=F88gTuUttpsO/tQ61rQw9pVzRu75mA49Pw/L2F3nJ5aDOc6OQD9RL+o+M/nT/yR6Ya
         HLLr1BiEgqnAc6yZsYxW7Tccx2TuGTHmDfpCjtkk/hwVvyIUR7WgcRFakyQtbGRNJOP2
         Yz6rS6Z6tf+XxQmH/b/A6QZNv+yrHrCc1eD6uQ2aP7gpGkhBjc3SqfbLdzQMexxveiVz
         iljZKt5ZNhRErDqww33+9wadeeKO4UeHLRmaifPdhvJyXQIafXFkXKwnouZNT5V3n0Fd
         ogyAQd69gKSYTRUKio9a/CL8xdPnQXHyjlRRLuCSeUT0snCXu8HnshzYj6eulT8gWeMN
         noiw==
X-Forwarded-Encrypted: i=1; AJvYcCVp73x3PAQmAx1LeqsO0TUnWu8sj+14zWd8f0BOfDC6+ZigxGBK3X1noyM0KWhffRpgGYVPJ0iDbLfWkG6VZT16eszF2VarOxY3+1yE8IME
X-Gm-Message-State: AOJu0YzLxH+e6Ey8qVasKLOIWBwe+C0vrsD/0fJXrDDqHBs6vCfyBr21
	iIgYG9VQ/0G3jqcR6hnMgTmcig7a7mq2EPvzwPw4XxjbUYw16lRbrZt8ZfFtPm8VcXxfmFmP9HK
	+gno=
X-Google-Smtp-Source: AGHT+IEld4gcckitLTpcAmzf3i59snSz7tCBvGr+qAd6o4i9aruDggu/LLvoYFsUsY6P4X7hYqOskQ==
X-Received: by 2002:a17:902:6548:b0:1d9:d162:667d with SMTP id d8-20020a170902654800b001d9d162667dmr1854648pln.38.1707896990531;
        Tue, 13 Feb 2024 23:49:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfonrGv6iHZlo1j3t+Rc2hfIa0Q5cnF5Y2HFES284p4t/yObFkTlcDZjyROfZ7YxPWae7B2LO0btuka5HPedBV2VbIwgmVF/PoTrNGxltPRHesJg1boJ/6vYzHc7sSzezw
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170902f94d00b001d8f3b0ba18sm3199470plb.2.2024.02.13.23.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 23:49:49 -0800 (PST)
Message-ID: <65cc709d.170a0220.3fa87.aa1b@mx.google.com>
Date: Tue, 13 Feb 2024 23:49:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-32-g345e8abe4c355
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.8-rc1-32-g345e8abe4c355)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.8-rc1-32-g345e8ab=
e4c355)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-32-g345e8abe4c355/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-32-g345e8abe4c355
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      345e8abe4c355bc24bab3f4a5634122e55be8665 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65cc631d8d16bbc0b2637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65cc631d8d16bb=
c0b2637013
        failing since 440 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

