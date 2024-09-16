Return-Path: <linux-kselftest+bounces-18050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7197A837
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 22:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F5B283EC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E799F15C15C;
	Mon, 16 Sep 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nXzbsIsp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62227168DA
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517995; cv=none; b=Zm/Ms0sheCep49kIuQFS2Q5S50sl59zFxA1mzW4BzJ6H1ARpPwcDJ1MyGTDioRIuisLtSAyzUQtbUsDFAd7SUbd7P8ziJz3ZaSdZJwXGT/TOb8TNVRdvdVlwnN6YkmyxVW/R7A4w5smjshIfZKqulZvy03gWN1aELW7Ppz38QF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517995; c=relaxed/simple;
	bh=I8gnbFwvX1urU1cdl4gJwM3k5H7/wbiqbcHxL5UNoJ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=HdvBVYZEWpy2ETEnhh1Lp2PUmUPptlE29mpGVfkgns9Lomo0zGv+IOnxgObnU1DARtXzypIipPY9bQVViiPaamhlutBGUL7lyykZAwR+rSiKDatNu7oXL45hgXwJbhmvGlKey8oWucA2VxYQGHfT9rD7z5KpsPUYVJdsB+JzONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nXzbsIsp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db54269325so1387351a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1726517994; x=1727122794; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UmYtfIY3SPPYpheoMXrI6Grv0bfpWohClsXjMu1hIg8=;
        b=nXzbsIspEoroIV5tbcj7t1yXaOoHkIgdm3inMFo876+hP/9pJtDrcfgoZiBAGSk2Nv
         KMZHWrPdZajehgoc+MUHRVs0uzGSN+MkEkQzR4Goc5xl5/Ljerw25V0sPmO624cKVAcI
         UUSk9UAKhIwH42pRMu7XNn3BLx+fNqzup+CqiKEjRVfoLWa2hiJNMHFqeR1fhbrK2H4h
         E7f8aYAIn4xm8K5y0Uq7H1TNyqGQxexQHNO0+TxByOuqTW2P0ZjmxCkR84Js2vpj+UwB
         anbCJGNmN1atvSSY23LkhIEoD+UDZVSPlP/qEh0T4w0JrNIq2Hhz2KwYEoZ0+dkhSVQb
         WZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726517994; x=1727122794;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmYtfIY3SPPYpheoMXrI6Grv0bfpWohClsXjMu1hIg8=;
        b=pBTk4F+mCbIgWI/fCNtDPdVrRZ2rPYQ9u5PPzwHGZJ0orcu9liu/gkCgkjPZrP7zJo
         36IhYnBn7+KIir4hShAtipoGT2JUtBvMMF9VDMMRl6P3nhbdd6htmziFFmNMUGN04LD4
         FSYI64K3PkjXuB6WPMoLTTX17QbvCwtBqsAjOjk+jAYTUoDZY37RkcF1PKKCN1eErthM
         TigAczLr8nS3foXXHMivS4o2RR8GPvtvaXosnbf5yQ96YV6fk9V00YnP5iKtdvxeCYDZ
         Lye9QhU4/1ryyq0wkH78yMRYRAcTDvPQ2FswsaEp5lIJcYGO9NcC4Ur1ZUXgnOYgCFBp
         SHww==
X-Forwarded-Encrypted: i=1; AJvYcCVyt7vOwWf/GclMofa70PCCUO5DnR3ErafFKVo3c++0i1lAL3PcRhEsSUQvYd3lov6lsWTWqt8fOOq0OhxSC4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBSbbMInNQ3myr8ecje18HKs/4Hec12qtYk6AdpeK1sLvABxQ
	H7gqKxYGP5L5UIhZ6ujNZvPHDCy/y1RJ5S0/QLKH0+h7ApCgTZa8RxYLH3Il6uQUzaCCTJ8Dbl0
	Y
X-Google-Smtp-Source: AGHT+IHvpRHjj3R7so4yaZ3q6XpxblUPs7xP0d0t4OOCIXq0WQTdJARugd1H+noM1S9KpIcm+USX3Q==
X-Received: by 2002:a05:6a21:2d8b:b0:1cf:1fbd:9299 with SMTP id adf61e73a8af0-1d112eaf55fmr16812128637.49.1726517993537;
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97063sm4120259b3a.33.2024.09.16.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Message-ID: <66e892e9.a70a0220.232236.d5b7@mx.google.com>
Date: Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-21-ga0474b8d5974e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.11-rc1-21-ga0474b8d5974e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.11-rc1-21-ga0474b8d=
5974e)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-21-ga0474b8d5974e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-21-ga0474b8d5974e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a0474b8d5974e142461ac7584c996feea167bcc1 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66e88cdfac06e7d86dc8687f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66e88cdfac06e7d8=
6dc86880
        failing since 48 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

