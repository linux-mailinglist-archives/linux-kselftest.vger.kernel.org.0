Return-Path: <linux-kselftest+bounces-12195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A290E18D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317CC1F236EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A71EA74;
	Wed, 19 Jun 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NJRotU34"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF38F6D
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763334; cv=none; b=UywH0oj6tGhySNDZPod7mR8kuFonPa7oDHT8pDOCyD2vP7tTYLWXc7caFvUc9duszsz21oMEOZGA58U7hUf4U8e6cJvoefCvmPf6A4ht3cZb8QhMIYjcKQAJgid88Rj8TqU+D8ncfGfv5yib1OaiZFSQOfc+W5wHCrrwHHM2uLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763334; c=relaxed/simple;
	bh=yDXevhT/GKgrWuTv4jr4UCBuNfjT37QYHSdK+LmRSEg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=N9gkBGWzqY/s0Kl18Gj1UeTAYx7iUPaBOIzcwBduSZ2Bq9aafSKDxwAB5NCejCU0GmkK+x49B2/QJ0CP8V7aMEx4iX5YIKg6oHOnRlVmeD8ZXkOMMuHPKyFgiEzi5+nx9og4WkSwA4Lr2qo8bE2ejXwI2BM3MUTYy2TaK427kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=NJRotU34; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5b53bb4bebaso3413747eaf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718763332; x=1719368132; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1TpSC9tERredVi/Tlsjiaipg4Ko2XUOOBp72KPElI+U=;
        b=NJRotU34x7qZJlvYrXB32Sz6t2S9IScdnc0lnhv30Q2egmwEfiicNLJv7EmeiZM7T+
         Y1gS9igyzywo1Rs1HTQYJqb/izsZyL3Ww68SR/xdr1zxG9b3g8ZkoXA5U2jij+bvj1aS
         hxxddzDoLJAgN9LtfwCHd8E1iCNHZ+BgwW885PAnrnoa9HKE1Je2j6uNFVWhjyEr9giw
         9/TmQcHJrbzxu9dvvr4vRvrdkTZ3h9916pvcNwHbFrBOODp5Ezez77hxpZ1620lTuCzz
         Sqllp7WEXyrChxnn5X2zpE7HxMlveaHrJ0jrdHWsOfLj8xfXkpxr7gX7DRqcr7xsmQzZ
         qpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763332; x=1719368132;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TpSC9tERredVi/Tlsjiaipg4Ko2XUOOBp72KPElI+U=;
        b=B2kJ51H79I9N1CsDAYDIeOK+DH7jGnjwXGWT1O6baLeEmBjRFjX3MUuT/SFCDKNtqg
         O/N9/UY9Os9D6KHdn45ddws5z2wx0y6D6jFpFzMZUNY0jTNpksU2ddY3z4+HufvA6QrF
         +kiYlztNIBy3NXBS+656gNGFWCI8gxyS4zLuMVuh9W5vquV6dlpZOXeQyIIQXCQYp3VR
         gJif2WTofdTlK1EayPiJC30SzXZgg8LftmFpMircr2/K2SSBGfLtv/kWzoHC1MaswL/z
         fRFtneAvi0x+vpQXaSDebecvSv12bbD0al1FG93Yx+AjD1hml7J4PllFYfIvHPS9Dui7
         EvFA==
X-Forwarded-Encrypted: i=1; AJvYcCXvZ4uHuh4Up6o8TbRLBmFACFnfqCgZbj2B4tF5D0XSBtOqSUWMzQO2vOXkDSkxfhXDK4pdWthpcgG6tPli4IzKxh8h35bE2nxnHXl9Ufb3
X-Gm-Message-State: AOJu0YysTw35MnBvpf/x1vxmnXKwkoEle6ZzG1WhlEdvQdfcI18AseX+
	t16IHNAprtJSbMVFIBlv15nV+7DpOagt6paYuihT51utvlykzeuVRWzPRWTufko=
X-Google-Smtp-Source: AGHT+IEOfSqM2a37ntZNkJnpzit3XtRP/x5q5vPM3aDobUNWKDvLL7AaMKgqqgoOmmv3xxPCG2WWFA==
X-Received: by 2002:a05:6871:3a29:b0:254:affe:5a06 with SMTP id 586e51a60fabf-25c94d5c601mr1801457fac.54.1718763331748;
        Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc965228sm9555141b3a.49.2024.06.18.19.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Message-ID: <66723f43.620a0220.c2133.ba89@mx.google.com>
Date: Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-19-g15a783a493b02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 6 runs,
 1 regressions (v6.10-rc1-19-g15a783a493b02)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 6 runs, 1 regressions (v6.10-rc1-19-g15a7=
83a493b02)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-19-g15a783a493b02/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-19-g15a783a493b02
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      15a783a493b021975f3dd12bdd95a7080df0e8cf =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/66723559b061db46617e70c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-cpufreq-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-cpufreq-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/66723559b061=
db46617e70ca
        failing since 21 days (last pass: v6.9-8287-g31a59b76b978, first fa=
il: v6.10-rc1) =

 =20

