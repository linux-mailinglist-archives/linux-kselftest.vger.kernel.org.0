Return-Path: <linux-kselftest+bounces-19309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D044995CA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6874B214B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC27462;
	Wed,  9 Oct 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i4yBQLVn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165053AC
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435988; cv=none; b=kG2X0YIQBytVKFv8b//jFdAJKKAsWJLXLfrwKGnHUt0XPu04eIKmVkO1On3E2CCGWI3nRu0RjxSo5xV+duog412MkkMPK76oCuKtk+HBIBm5jEqiHar3yLS4tLTQCLSOB9qIkDa9ftZibu13VHtXu74AWcwK4zdyiy7eWM31MHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435988; c=relaxed/simple;
	bh=+4Y5IoRY9xOMlca6tbXR7M5tzbrekVZqxZg83UmfIaA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=CkWM9fyIGjjTEA4L3kzjJQnkcVuKpL4LM27j0crU3oz5aBNPyxYm//Z3RUP9VtnWbEkHlH47DQF+MSNHQNbEPN6r4Xtpnfzt+x88pv1pKpb0gkApswKIM9X7GiXflo9BjmwuoDgySO8cWp5JyPCag0lfjo1seqPH2vxeKWaVrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=i4yBQLVn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b64584fd4so60838185ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728435986; x=1729040786; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2d4oH0nB6EcvgKFBbO2X1HuYUszO0nitiII9ahe6BCE=;
        b=i4yBQLVnSaT6jS/HejZnCuHquf7ZicnG3bfzehtcpKi0BE+IrR8fJ07xFWwX/j5J4/
         A6hgF/siPQfBnchX8Ny3WVTpuq3VsteKtfHsXYR9Zz4QteyKBpTNQ94aalcYZys+eUte
         HXShcIue2kkkJQ2JplF+tt5ZkoAaUrm0qk8Dh4OraGfGb9RWfb76ZyQbewL6G5UkL1Yb
         t3WgYrY0u3zmder5ibFGLY0lWzO/YsBPhyZEdGJjmtrSq3n5O/GdNKS7gZ2qG3MUWEvC
         0gezfd9Ohy2mUN6xXT8QrfNQNcMlDMIa0LDcOUdmmFz91bSNPtr3xGdjPdG11gD3qaFf
         XZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435986; x=1729040786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d4oH0nB6EcvgKFBbO2X1HuYUszO0nitiII9ahe6BCE=;
        b=kIp9WdIowgj5VEnBQhUCf9jfUuUtgJi9IPkhYFvASNYaVUMIG+gmo9zu/8md27/llW
         xC1W6vwA+x86cA11JqikiATmJ+rnb357WSBuJlMmoVihuIM2xHOzyJP9+O7wnCgeaY8B
         paGDyWl+Dubso2YihKcan8UHfcFYwUjKrnjQFaQK6s8nIb9FaHJT8c0dzFkUlhfUfCQY
         PQvl/31kGA2Zp3dte1CMpu13vu4AXPlVhTo4OO84yo+2cwe3VBxLwYQzDSARt86vqNG7
         g3nuYIGV3P1fxFAS25AT07MzeEvIJ+mBkaU1E60qk/6a4s9/XLO5U+RS1ajCQZSbaWKr
         mHAw==
X-Forwarded-Encrypted: i=1; AJvYcCX9nM+2P1RycBgDYOk9nqO/N6llDdVfcR7D28a5Amd+H5yWJ63JNoHrROavLRaXVIU4DkwrTaPU/pB8FCG+tJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsQgvTlAtfAqCV8iOBu0bcZEQpYpZcDnkobkmZrVW4Y23kYMr
	0kDFKLu2oCySaRHmAF8ePspiNtgd5j5Dsd8X8JaeCF0roc4/ENaK8Cu8MRvlvrrbS3EwCwmRu+I
	X
X-Google-Smtp-Source: AGHT+IGjTKIxjD8Jmas+rPxiJAL3g5cu4/fOSISdtInIBIe/A/4/HuR18XBXb13IvD/JEKIKNBS3Pw==
X-Received: by 2002:a17:902:c40c:b0:20b:8036:f77f with SMTP id d9443c01a7336-20c637d29d4mr10684165ad.46.1728435986575;
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b0f32sm61303465ad.5.2024.10.08.18.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Message-ID: <6705d712.170a0220.42dc5.66c5@mx.google.com>
Date: Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lib: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 2 runs, 1 regressions (linux_kselftest-fixes=
-6.12-rc2-4-g34d5b600172b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-4-g34d5b600172b/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      34d5b600172b846161e507bdce132c98d9cc9701 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6705ca86b150574743c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6705ca86b1505747=
43c86856
        new failure (last pass: v6.12-rc1-5-g45a8897db67d4) =

 =20

