Return-Path: <linux-kselftest+bounces-9444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B18BB87B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 01:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E763D1F22C2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65268662E;
	Fri,  3 May 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Eya3wlnh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27F84DF7
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779968; cv=none; b=M3/Bx1E5zIATNhg604I1PzVbZXPnRCD33lZRrZhAJBS3dNVD15pCYWKGS/qzYhXqV5R+hWSkQwx1onMSuZJat9OpQRxiQ9tFBtEaTG/bHHVJE7pWgRZlUtsN1gk9UxSE8fXBuhr8Cb5QU3RIYAga1Tm+huGvvuIjR5CbI5SMq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779968; c=relaxed/simple;
	bh=SNWo3EIXHl1jXl4jBRlEireotvRqzMNj1bfUt79mtD8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=PlWSyUw2iu8bgiaNwPyr95EnlZBiPVq8Khueqdd/N1Vurg15e+HKudeNntmjOluf1I73exnHy53D2Gmt02ForbUF/VtfBCb66Bx2uFpAp7RwsMHozXHXJxd588tl+LzkuM4IDZS8OstNm98uevO2kpmJVtSqI8SSOykHmBDAFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Eya3wlnh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f30f69a958so199514b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714779965; x=1715384765; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ad0GTVJC3KCZhfFD6gEbUw3lkTFPaDEbdCEWGVje9A=;
        b=Eya3wlnhOCGpxIRpnyRVAxjDW6Km+c/wRt31hAThIdhPBS0zt/fswHKyztButWZfl8
         ALGjhIMhxb30InxGEVdGdrDhzgtNyO+V551RWMJqHLnoKaSr/WAcIru9vVjJWCXJZenX
         Aw9z5ojsVi07zKpeJoY3eGaIGO8t3eeG1gOug6X/AKTLQRhHOjcFzYHIjRB3hlBDtOr/
         9v448YwjqZKjj8sKDZuf2tCMGMTFsGzYvRJQur8SjOLN8NSEwlpU/OBtbEG1MqdGXDxw
         owhc1CyZjTAgVmPVs87ZCvzmsRh6pqr79v35ftKtPvUkGG1JE39aZAZEDRTdK2R5ayzl
         xrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779965; x=1715384765;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ad0GTVJC3KCZhfFD6gEbUw3lkTFPaDEbdCEWGVje9A=;
        b=Rp+9gcP9jnn3OMPT9fRRbiGRW1jeAYY8iM6PKDL0p4aC0/InA67GCFSyphCmN9x9Xf
         USGJyAXLu6YjTqXxgPQ75ckTBtLP0p7b5bAQQt9Nr2XJd4zx7eHZe12d/VhsIhKBrFDs
         9p/oG/TOXTmRd2L4YlM5sQ4UyYUvmWfwCDQWuiARSKKUufjmSX2ayU6tgzEiiNWm5LZg
         +bVlMKZXgWq2fgBku0iPoWzkRK+JegEzrXPoL/wYTP39/wEWFBB91vnvJvKD1JTwbRBT
         0vCECx4j7zHarMUtInJJHUrZwvqtfbEYooYAHKfBkVMypW4VtyXt3UKBr04c6ZeH3da3
         tdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFIRyLjEOFapMsDrUkYcfWZyZZZ4to1kPm3ESCR0wm+GJen6rJifaDBJdi7rv9vh2modse6sQA8ZTkbnfYxaR3S1OtiWBMK28sjlgMXoX+
X-Gm-Message-State: AOJu0Yw8ZLuKxfbsuwuNa6dQjCWGQYamFA/CiOvKfkIosAykWn8cmNOX
	unepFf+2EZPwgrAHG6h8f0nh1YRMsVBVjhH/PXdY+8QByOK5fHc2ql3Cl/tB85ti7mZj7h7wKvk
	kHVU=
X-Google-Smtp-Source: AGHT+IFmfJl9C1ZnI9jm+QfsEOOx1XonGvn51r/YVdLT1JAiDQxO2nfniNGXQMUOeFcdUPIfKhVKpg==
X-Received: by 2002:a05:6a00:4b4a:b0:6f3:8479:290a with SMTP id kr10-20020a056a004b4a00b006f38479290amr4853276pfb.17.1714779964817;
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b006f42a64f6b8sm3607336pff.158.2024.05.03.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
Message-ID: <6635773c.620a0220.c7253.eead@mx.google.com>
Date: Fri, 03 May 2024 16:46:04 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-36-g70bfefe4252d7
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.9-rc4-36-g70bfefe4252d7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.9-rc4-36-g70bfefe=
4252d7)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-36-g70bfefe4252d7/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-36-g70bfefe4252d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      70bfefe4252d7ab57fb49348ca5b66ad9298e46e =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66356a3dc9262a7ecb4c42de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-36-g70=
bfefe4252d7/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-36-g70=
bfefe4252d7/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66356a3dc9262a=
7ecb4c42df
        failing since 8 days (last pass: v6.9-rc4-19-g00ab560eb0e3, first f=
ail: v6.9-rc4-32-g693fe2f6a9ea) =

 =20

