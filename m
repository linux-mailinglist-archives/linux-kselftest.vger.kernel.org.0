Return-Path: <linux-kselftest+bounces-3767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B1842D70
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD892882E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325971B25;
	Tue, 30 Jan 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ouwfvp2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AE69E1E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644721; cv=none; b=QvwV3PQHP/RU+td1H2UWRJmJN1nPpkSUJTgtkK6r6XJFioKlaoLpnWH8/vyxCgml751gIFm0Sr8KkSgk+hy01CgO6Ir6CeZwdtI775zW88mqfWGLHbzbVg7WB3/S4h1gR+MvGTxOliNdAJrTGBurAVLsTeWmnkjUOiZze+/SN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644721; c=relaxed/simple;
	bh=HM9CXajiCxHQYA6nX7IUkpyUzLvoB4W7rrgtgHdNTEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ojHJANMu5j18kU6544+MMi/uMooKUSLXlBQX9aBbjg1HwmNsOoXShXjCCTctll4FWiM41+jmD2ERdsBxUjzUwyFzMnPyD5GXwUPKAjfeb4bpcjxE0T1orWp7p7HbWtb1qn/ZwuZj2rpoVH7jyoHYvx/Uq/CtIwdZnUeerLK75DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Ouwfvp2K; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2693744a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706644719; x=1707249519; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/6E5EMLguLu+6GiWf0xSiUrZ3OE9u4v6vOzyXtbhog=;
        b=Ouwfvp2KzN8G/+X6lucnl1NG4VygcvcNqxpZmeztvKk8w5Ajgpsa6srq3LgJIOx5e1
         y2rKBIWyoPXggLbWYkCSzvhFVFwNaC7Ai+iAUZ4mLdN2EjvxlYtUs3HPNysQLQoUkcQc
         TFsuVf2WX0n5bqcbouN83lxqmPAYMtMFAHFB7PRolD6RYJUCoSy18ZY80UfAbIh21yhl
         uS+080u5/InBNGDmKHbyI0fYqB/21OHH9dxRAWtUAnsNsn4dKDa/TMnSsNAPICBAJWPE
         CcP/K7jSuTq97RtIm3BmVBA8bNQY4V88Y0HKqG+ElvLmpQEhzaszaR/mJgpxfPvZeb2S
         4ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644719; x=1707249519;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/6E5EMLguLu+6GiWf0xSiUrZ3OE9u4v6vOzyXtbhog=;
        b=YnzTs7nHCkOHvQ3mjmuIuo3U8MWVsxycQqPHQRcSYrSSm5p76Y+YUyYMMsZUyFOLFI
         onHSRvZMbebpjOTM/AH9IyP3U5bNJcHcTX5P2KXywf+MfW/Iist9V66+pTjE8EpMcPsn
         5lBKuHYHozaM/t61UJ6Z7+pdCEAqP3uM0Rinur4NXSfWQ4Zl7b0RDQbeyI5S5+4auCBn
         7+fgG9ULq5fxKk0u5b3Ul+iMDhRL7tTYK59dpdbPnmX+41svvR5qnQfhk7N4m1J7HFqh
         hzrsAnOWhehbZY9sRBvAzfVemtC2/F9NZ6P0oGZrALG2VCu/wIjvlD53eFUntyJnLK4v
         123Q==
X-Gm-Message-State: AOJu0YzZmdn7AmfzLjcf6hkuysYenyy2IPAAzw3n0ZwlWS/8TDMF1J9+
	ubxs0M2hMIJvLlmFmfjOBJhE3I/rnpAfL07f4spqHC/HoTgM2aagiYx77vE0rVQlfocHuF7wPvp
	G
X-Google-Smtp-Source: AGHT+IEn4ZPwYa4xQTGT1uW9u0bPVEpLAaNXj7VfQm5PiT0eJjoZSje9dyRDHkSMYY1rtRZp3KGIog==
X-Received: by 2002:a17:902:64c2:b0:1d8:ca67:2b5f with SMTP id y2-20020a17090264c200b001d8ca672b5fmr5511455pli.77.1706644718831;
        Tue, 30 Jan 2024 11:58:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170903070e00b001d8fdbb34b6sm2401738plb.272.2024.01.30.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:58:37 -0800 (PST)
Message-ID: <65b954ed.170a0220.1ac66.a147@mx.google.com>
Date: Tue, 30 Jan 2024 11:58:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.8-rc1-4-gb54761f6e9773
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 3 runs,
 1 regressions (v6.8-rc1-4-gb54761f6e9773)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 3 runs, 1 regressions (v6.8-rc1-4-gb5476=
1f6e9773)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-4-gb54761f6e9773/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-4-gb54761f6e9773
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b54761f6e9773350c0d1fb8e1e5aacaba7769d0f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65b949fd937c2d11a400a041

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65b949fd937c=
2d11a400a042
        failing since 457 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =20

