Return-Path: <linux-kselftest+bounces-3415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051383916B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301351C222A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74A3D99E;
	Tue, 23 Jan 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jFNOEe5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EBEEC2
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020365; cv=none; b=SMLQsEduT9TJazATuy4BiKB5Uyh2jFNHL+qVHeLbd1jbSVT3qv2cyE43aOqRsS1QkFbM2s9Ju4i01VAOFem5SnIUNRZ10FwjICvklidDG58CkgJGNEv+axCrtO+DSsZ9k5C0LjALDu1q4t8Z/xi6hqpg7lKd4EyLGcMeNEcgWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020365; c=relaxed/simple;
	bh=5C+qs/sthTysUR88RyuxaEsLes069yIaod/WiCDm1UQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=E2uGpV1Z6HSomEM3bM67LHMDe+LssOad7LYprGAfWAfgTMohaWREYRITRSiFOgeMObkhAq6VCebWMilXlT1M5LzM8X6DKk84EtZC6xj+kRarAG2oWkfXFx9d1GcT3TTfyue1wjYr2n2QpFesc64Iqs0K3AmwWBjuc5qgRGUxTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=jFNOEe5w; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1977406a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706020363; x=1706625163; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8cLbx2kPUTybV19NM445HAAg+Wn5nhoeNTaMdE7pCvg=;
        b=jFNOEe5ww3GMF0suqO3+t5UdshZ/8cVXYtlUuNiVD7c5kTSvhnU09nhr5ZizxgQHCb
         rr/Y27jL6n2ZOZ8k49Vr6vuJ/6xC90I+sy6CIA4dX+ZNulPh0CREnRZ9PniSxVOeHV18
         OXh9KYZLH1gldPyz7a3hHzSP9nh2g//FXLU2V5YZebRBKhcETGn2G9/yv0Al3L3aAsD9
         g1HYl0d3hmqa9zSqYHtdfmpS1fvFtN3Mypzeu+amhWhL4Kygebfz1yc4L6Q+Xe9atCLt
         uoA6XEhoWSZ2PAKIUDk6/wZvbLeK4YZPWeoU21OCXJX7cCv4A42wB+KuJGGibf8L1ve9
         IZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020363; x=1706625163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cLbx2kPUTybV19NM445HAAg+Wn5nhoeNTaMdE7pCvg=;
        b=eFvOam4NxwBDCF1hs4iM1O/XJ5YMEd2WOYcd3KOIB9suuIAnWr2UOeMoJdAU7WMHVj
         kbTUioTwx9nz6uCvfDfCPHrA6IpDpY/3kMY4ExuWXlKGffwI8H83nTFXyD7Z/4mdlzMX
         j0TAWsU4esI1i1yXhUmgpetwwEekirYTir5v7FedYwYKvPZ7nDIEKKXoVGGFc9zYrrsI
         wXDjdehs72eKSzihR3Gh0JdvPTyLDmc1F8b3+ZzhCy3NvvDLjI3KsrOFCxUZJKoP7zrV
         a0Avt1iYlnvaRiWGu9e30OrEQeSpJ5v1rpdhyiN7zcPrQTZtRpCh7hEfMD2e32JIM5kD
         4lOw==
X-Gm-Message-State: AOJu0YxfLMTB++n4UULK1Eqk46U/okbxxNzhdimrPOWyCNbNZc6eubt+
	ZFEMBbcswCbi9XoZ4Csv/4XFefUYeea9aDeGgCnBWsOrHflHcDWAjK9Xj3EiPEYjfnkD15Sahkv
	M2Co=
X-Google-Smtp-Source: AGHT+IG+vVWEp4ahMqONp8osLY0scqo8Iqc7AnAzKUUVjvc4Ekl2YUVZ5TwcOwfX1Ji//MjzvTZP1Q==
X-Received: by 2002:a05:6a20:92a3:b0:19b:435a:a265 with SMTP id q35-20020a056a2092a300b0019b435aa265mr2909324pzg.52.1706020363455;
        Tue, 23 Jan 2024 06:32:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw13-20020a056a00928d00b006dd738e9004sm1544310pfb.172.2024.01.23.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:32:40 -0800 (PST)
Message-ID: <65afce08.050a0220.ce7c1.41e0@mx.google.com>
Date: Tue, 23 Jan 2024 06:32:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1-3-g6c8c9d6e1bce2
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.8-rc1-3-g6c8=
c9d6e1bce2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-3-g6c8c9d6e1bce2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-3-g6c8c9d6e1bce2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6c8c9d6e1bce2871df58a85d2c0c545007c34f5f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbefbdc25cadafe52a403

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/65afbefbdc=
25cadafe52a404
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

