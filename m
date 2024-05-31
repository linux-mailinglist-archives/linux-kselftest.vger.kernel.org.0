Return-Path: <linux-kselftest+bounces-11029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54718D67FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E797B1C24FCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8F171658;
	Fri, 31 May 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QyJjOyCD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7851F95E
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175795; cv=none; b=IypYjws7XkAfvWGbsdFBbXxnPVn03SPr2BVRBHFgwbCR3tofKuikIWCPdK2jW4ZymPWb0Kqj63kD2ux/2mGIhUVYBp5VyFP2tfAVRflOe2csBhyLYbU0jHzEhhjDZTVzrLbPwevO7Kl5Nd98hXgpnlUwwC1LTzG5dy3onsLRPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175795; c=relaxed/simple;
	bh=QJiMfx1VkYzaL3RaAGVpbIAPVNXr6THDFTX9Pbli160=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tT7ik2kkJDBIEZj3U4fvMfxhk1Gd+OGnWssmLko5ZdqR8raMfAv9/Eyjg21GZElhMyqxosrubrsNiLPiJVqljjDI4NIm9aJU34334mX9OMgwimLoREiofdlla9ikSOfczMFtb7X9l7/FHLbue6jHx6KrKd3xg5oOqDwbwIdeTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=QyJjOyCD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so1576184a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717175793; x=1717780593; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yqWRLVLlf8HK65mtYsYWW4orYnhyUm5wUaOWoGjMQVA=;
        b=QyJjOyCDOoLy6KKh3qZ5LcQ/yBltG8Ywx3AOFbofj1tQLBStE+WJhny4X1DAODxJu2
         fM1rQbPbekVqtYdAd8sRAFjGAG1Ess2A6aEeHc+6bMnzXYq/lS2RgCt4Z1GfmndaA06Y
         E6QoCAYpkaBxbOuQOs7G0dWPUcfOuSnzdxrQ/QxGOpe/mlwgsGuYsCOsF2e66I0tLPSV
         9TjMsjDghnSmPpCEoc7lM3celX3i51UxUnqdTFmbeAVafT7tfDS+paUAP5B5LhgX2vLY
         pH3HCgR9hZvsaRoaKEMBljw/S1EnekcBQblHXoltlOiB4xhYPhfQ9kEeQEbeOVqxlBNK
         b2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175793; x=1717780593;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqWRLVLlf8HK65mtYsYWW4orYnhyUm5wUaOWoGjMQVA=;
        b=H6msjH8h5JKGzsxlssGM5JgUAnBeYO2WwnM7TNp1ABfRt9ERfQME+3FpkvLOLTyH2f
         A6e8Q3M6gHpze08Fa81dJ3bpmrGNK0FOb1dE1nfvIEw3Fz0r8/cHLnEHyr32u7+Ke2wS
         cdZ+MWD1OMWA+nmCp9bWnMpFmH8XSOjjZOaUjhBSUPJbc+iW1ny6BuuUyYAjJhgdUfOU
         RXo4Gt3idXEckki0YaiyVPsS1g+FoKSVY3vUucsHqxA1jD6gpI6/xbkICISToz8lUNGj
         ED01rBUSkU7kkGTPS33KbY7oQpyi9cIYoZilIVUMKDZT5SHM1tQ9UOFi8f0nPKq/jgVL
         iT/w==
X-Forwarded-Encrypted: i=1; AJvYcCWIRfbaC1qwIPnpsBrXi4Qm98PXDJm3Ex2EIf2bwxWga9ortlKjnBB6fFpJr4yIn5iLwzW4Wa+/RZ/cne/aVKAQl/mX7amQVGzsrDCsycsK
X-Gm-Message-State: AOJu0YwBfsvsRVstM3qjtHUC02KvMPvU/+3WhkjAPiwFJQD8EVrIaFa9
	yuKNYErhowJxomAb8vEmwyWeY02rpZXPd7FOSmIUK6hGCjtCI2ltZJzEhuc1uRfjLwrpMQmtYiH
	j
X-Google-Smtp-Source: AGHT+IH60GCYaomw/84hHvyEOicsQdv88N7AmlAQSJOpAsq0Of84Nn+7RlO3q+vAPx8IBo9Kf325Fg==
X-Received: by 2002:a17:90a:fe0d:b0:2bd:d6c6:f454 with SMTP id 98e67ed59e1d1-2c1c4453724mr3646813a91.21.1717175792959;
        Fri, 31 May 2024 10:16:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28450d4sm1724542a91.55.2024.05.31.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:16:32 -0700 (PDT)
Message-ID: <665a05f0.170a0220.17f3a2.4aca@mx.google.com>
Date: Fri, 31 May 2024 10:16:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-9-g0f42bdf59b4e4
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 7 runs,
 1 regressions (v6.10-rc1-9-g0f42bdf59b4e4)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 7 runs, 1 regressions (v6.10-rc1-9-g0f42=
bdf59b4e4)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-9-g0f42bdf59b4e4/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-9-g0f42bdf59b4e4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0f42bdf59b4e428485aa922bef871bfa6cc505e0 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6659f888173da7849f7e70ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6659f888173d=
a7849f7e70cf
        new failure (last pass: v6.10-rc1) =

 =20

