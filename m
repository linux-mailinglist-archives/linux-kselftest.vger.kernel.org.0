Return-Path: <linux-kselftest+bounces-13626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E092F02F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871C5B2239A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F414C5BF;
	Thu, 11 Jul 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aJauSIxj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75967262BE
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728942; cv=none; b=c8LhUoxPt6K8iKiYUGw3Edqblv124h4EVOUxKsilKBsRi8Sief+qNkAHkRCJp3bMoc2kgDJrAajtpnG2XZBgiPGA1cs8OyYSlOL4RPy2h5/PwXoMhIUmP0hSrnfeJmrSoCL6+YN0WLQnPx2IgK2pbAHbwMIKUWe0D80LeKpGrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728942; c=relaxed/simple;
	bh=mfjOnr1ABuq1jztXpt5wkVey1PqO7a+txFsl1ii3E7c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=qvuviTALvf9XaVt5eYtRmPMYUFdALzMbVeBviR+2EAUQk7LhlUnmTO/sqF4owGMSixhm6R20Up4bP+AaAOTFaLVAVAsA99nuWkFkG8n9vg3kQuW+nZ4Fh6thn3z1auCo4j/1L+A1ALM0V8HKo596kWgqqaS2xZ79GHm7necTyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=aJauSIxj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-704466b19c4so660515a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720728940; x=1721333740; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4M6Upr8kZP4Chg+mXlf1+Pc/Jl8ad2sIHAw8dnRazgI=;
        b=aJauSIxjAqtTjJcUcPWgPVZexo9pba2c+l/P1fh8d/r9WaRyJ9MFEkhK6Sj1DAEYzm
         VuYfzJlfm23z5aWu+9R5h46cm76GLMjnDvo8lehWbNjMF5vnrJ7vrfgTcEiSJ4Db24Nz
         mOAPo2XVji63edJAqr3QvRXSfgakx20wFEAJh7G2DR6CHqRWPjPga8/6WTJ6E4W449hl
         eXfV7A4poFX2KlPfjy4lpDF5aH34FvVMi1bEew2Q+phS+q9usnjY0pys7HscKaIsBfLo
         ik8hIB/FoTzlWJoWY6AVTjrMyV5AWTQPh0+a3GAOgZYqA8KUOmDFc2FlihVMfksW+FME
         YTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720728940; x=1721333740;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M6Upr8kZP4Chg+mXlf1+Pc/Jl8ad2sIHAw8dnRazgI=;
        b=XGHhf1M+5lO9lfPRASWHqAY3l6YzVo6qu+NMjDyQKrPoIXcd+9Aev5UT4OA/EvpuzS
         L5Q8exahL/j8nM48fRLznTy/FBrjJKzbZCILsIlxpERTg0m9Fw+oKiZiZ7t6TFgjEzWo
         tdADC+GEoy7fFhMlxwYrQFpZHKZY/fP3pO+vKrqhWO5cLR3WNtBGdAc39ZzA38UrCwAD
         JQ28RcNg9Cjd5tYtcZYy0hZ74XuEt1ZzbvBeMCRzEl6s8A8OIDn+VgE7kU4dpQm8NLSK
         Zwys2DRDQRTRwmtfK84aoPj54ipOBg/PTXDVuhF+Cwlq/9fHbL4mGwVHY5amCMqm++18
         uQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXW1EH69rCVE+nzCUXNEH6K4VhaG1exPsxJGltjF6TwaWT5FH5uw5n2oKyedAgSwWLXNKdjepcH011Px+PnkpZmoYoKCPjOvtnlzeScSbWP
X-Gm-Message-State: AOJu0YxygjqcMeOdDKR+JcefZ+RlkNEgmSP6dtre8XXlT74o98pvumTi
	oc5oWVkAtss899HOmnowWEN5dzR5kbsLItfXFl5jOECWin8W213XZrDNPkxAnNtSFtX0Z/VjJY1
	K
X-Google-Smtp-Source: AGHT+IFKFEPIMoId/J0BNruznu2dNJEpoS/ss3Bfy55jCAaLsGq7vrLuxCaGDUcZ/392HDJx6peRQw==
X-Received: by 2002:a05:6358:e825:b0:1aa:c6b7:4e2b with SMTP id e5c5f4694b2df-1aade104507mr856337655d.29.1720728940381;
        Thu, 11 Jul 2024 13:15:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5edcdea6sm3971445a12.15.2024.07.11.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 13:15:39 -0700 (PDT)
Message-ID: <66903d6b.650a0220.20751.1d1c@mx.google.com>
Date: Thu, 11 Jul 2024 13:15:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc7-29-gdf09b0bb09ea
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 6 runs,
 2 regressions (v6.10-rc7-29-gdf09b0bb09ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 6 runs, 2 regressions (v6.10-rc7-29-gdf09=
b0bb09ea)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-12   | defconfig=
+kse...4-chromebook | 2          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc7-29-gdf09b0bb09ea/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc7-29-gdf09b0bb09ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      df09b0bb09ea9775b66a5d24dc0fe0f86855efb5 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-12   | defconfig=
+kse...4-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6690308c738dbbb3637e7070

  Results:     105 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc7-29-gd=
f09b0bb09ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-12/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc7-29-gd=
f09b0bb09ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-12/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6690308c738dbbb3637e7072
        new failure (last pass: v6.10-rc1-29-g2b2ea9f19da1) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/6690308c738dbbb3637e7077
        new failure (last pass: v6.10-rc1-29-g2b2ea9f19da1) =

 =20

