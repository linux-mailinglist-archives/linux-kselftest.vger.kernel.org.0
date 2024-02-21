Return-Path: <linux-kselftest+bounces-5153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597C85D3D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3691C1C2221E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13FE3D3B8;
	Wed, 21 Feb 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vjcYg2ym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DF3D0DB
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508423; cv=none; b=uQjMW8PSos+CPsYDdiAsPtwYBtYlt192PPv64NVl5Xx/NSccX7nYnVdx47+/w7jNOCbMLrRiTgVWajFuVOBU9Ucmi9+Qe8zDS7fMqILseotqx93q201DVa2ig/4DKE1e0gAncwiR/gVKGDC3mW40Ag3cq0uSpln8oegjbs6udTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508423; c=relaxed/simple;
	bh=OlBkC+ZgXcKloOM9CO5Sx3urbFq7uJTBiakKawlyrHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tY+iViY/HK3cMfA7YmAyzImT+bDGJ129cUwlleuyRXez36akBcNmOeTehmt0SJiyu5KmMIGPHL2GKP/NEN+rpddpoxSCeBfW6MSwYXQJ2ujFOJaP9HRVQVAFPWuhpb7uzM5kHjEZarNsdgS/uDIMIrF7FOKH3lg0Is8p0w9t/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=vjcYg2ym; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a01ba2f815so61665eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708508421; x=1709113221; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IKa1XpWEqj/Sfxe1YntD5RxN0L/YBh+T/OxLM64lJbE=;
        b=vjcYg2ymOoWm5ApwLINTED8v8tj+Fviy/lbNaZxQw2xQF4MXmnEAU8hEk5stHVx2GA
         xjiLYMAJrMxT3CR2lIuPu1E50jG0uEJXo5PpVdDdOhHQfFN993xla8PkxSVTEHdmX3s/
         jJTRZZUSylLnUhXim/vdnDawtkHaFpo5YTxKJwBSGkmsEvU6y0Uws9zHf0EqF210TR3b
         /qL4dslzgsK59X/dosxRkqGEmV2e6HZAhFGWzvMja+h8xW/ihu4x1uKTbsBEXaP5FvFX
         NxoppQqmctyEXje7d9akXrMxlUo4shbCUZEtiMG+U+mOCzM/xhoiOUk4Jrm0Gq/Zq6ep
         6KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508421; x=1709113221;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKa1XpWEqj/Sfxe1YntD5RxN0L/YBh+T/OxLM64lJbE=;
        b=whYS+bmML8R0Hhz9L8/nXkVQl4uSt16HsKXYCcMLTVx6cuoyN+8agr1wSKbKDLvNki
         L7Oerngxs05r1UGy6EwSCFjMBI1bLF2mR7yyEBSjJ8GKw0f1KssaofmDhOePUij3P0nH
         EtvWB4XoqMOoSFycmI+6O5o8VxKzyAPPwtaSW6fqFUsn+uYCOIvLhH2FaeXWkKP9EE1g
         YYuU4xIjXQuyNc/zYqN9RMYQr2L60YK8cbyVx9ZWJXKYDANWoWhO/OztdtPyeAJbRbO5
         +xELlCiqNyxdLQ6PpHEcb0rJz0FaiRjXIHYvZ5n6hLF460s7lYbZzrFCqGiNI2Y70Sw2
         k2IA==
X-Forwarded-Encrypted: i=1; AJvYcCVF8O9enYXi5FSlN+66rfa1BxqtPLxNrN+orkIFIxAoM5QEmfjPYGBMNBlNyZj97ajO2brf2UV+ujDYtWhlc/naNYCP8akRGTE9Wn4gBi/B
X-Gm-Message-State: AOJu0Yy/jjWwDrIHzfR9B2SbprGE8JTvh2Kb9+9JQ6otjCdD+0R+PXjo
	kt5qbVMgHp97A4a3Yo5nxAmqEIZ4tnQNlhlBcfycipQXWOeCsgZFkKynHIW+XC8=
X-Google-Smtp-Source: AGHT+IE5XQRYaZ1/YY3EolA1/rIjwTHjMgJymqp3J++HuWFddD+m2pBTMa5wBVGVUgyi+sIi+BdCjw==
X-Received: by 2002:a05:6358:571a:b0:178:b97c:f087 with SMTP id a26-20020a056358571a00b00178b97cf087mr19627995rwf.15.1708508421343;
        Wed, 21 Feb 2024 01:40:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k5-20020a635605000000b005dc85821c80sm7908029pgb.12.2024.02.21.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:40:19 -0800 (PST)
Message-ID: <65d5c503.630a0220.8d6b2.8800@mx.google.com>
Date: Wed, 21 Feb 2024 01:40:19 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-48-g6f1a214d446b2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.8-rc1-48-g6f1a214=
d446b2)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-48-g6f1a214d446b2/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-48-g6f1a214d446b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f1a214d446b2f2f9c8c4b96755a8f0316ba4436 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b6cab08d32e621637085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65d5b6cab08d32=
e621637086
        failing since 447 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

