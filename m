Return-Path: <linux-kselftest+bounces-5901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032A8718AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49881F22EAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67A4EB2E;
	Tue,  5 Mar 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p2+/jN/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440D4DA10
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628874; cv=none; b=hm5nqKgONKD3K969i7Ng7hilnQX5/ov804IBKRZTxXU6nme4FqPhvDh0hN5qjKA5Jq+dHjKr5RRroJRFVD00EXvsyo3ZBHM4T84Br+BgTLGRy4JMPHvHxYGaNuAOxxmwlCsvqym51SZ1dELwEuPP7Y5McR9kaa6qgC6YgK7bjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628874; c=relaxed/simple;
	bh=3gsa7dmhhZiuwqDBEHXvgj6AiAc2EP5PhuS9rOIziOg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=XChe+YCZjaotMimkn/ZTF+0DmxR1ixxL/PNvmdB/+L7aTssXWsH6UP3UMZ2W5/AFG5HdPtCNOZ8C/NUysGPWjUlXq5DWUx8IA5ViUzcvdMaUCMbtodqu38hFO0HCa/CDjoRM2+Fw9np31J+mUPEP9GNj5rzkK6x/2ZHPp1RD1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=p2+/jN/H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29a430c3057so3550977a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709628872; x=1710233672; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Zc8ekOwhHhrF9mh2Y411P9ivun1wnkGOEwR+pJoWc=;
        b=p2+/jN/HiHm7Dv562qUQEFBqZt4ztbiv338ooMme/DKHhYBHlAYmERUIbuDK9tdtPJ
         yJQFsWEesP+tMCPRWtRyijJ7JLcjp4XkH/qbYDKRx+RaWYjSaL4ZoKgmX9GSG3Adenx0
         h1CdlFGSzglwAL0NG5s093Ijk6f+uQaABQp3EbPqA1yI1NfxXo+UvMrMY3u3SN8LXsM5
         eyQ+qJqQa/xhaRKRKmXGk5ZVaIhkt57x1i8mMi03qyTi423zUTDB6rcipX9M35tXNi01
         03gmJyYYSPHtbi8sqWM5tmAelh4CQ8FAHlovwU6hKTqqwtJBcB/geXnEiRFNYqM1RBjf
         qFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628872; x=1710233672;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0Zc8ekOwhHhrF9mh2Y411P9ivun1wnkGOEwR+pJoWc=;
        b=ITD5p1e1hQcPCVJO+qtGIns20qzJb/Wrsuam2XUhpfQnzDKyjQkNmvGFmDfdLAnz8E
         P09g7FUVM5vrvhKzUKIaoK9tdZzNlMRO1EkDWBrLzQMQ8W9Q1lQkSWJ5Asjbmd9D9kfx
         32vAEz8wMi3oTvvgehGeCknVSNoYWs81bY3ZIPo0eTq6VhKuQm8/SZxWKgQTIBJwHyTx
         dGrROBmGbcWUptaUDqSC/MgVn4GpFk+ouY4FwBoNr28YyXDPn7M157wDShT7R+MpbFlC
         4d5c4aWEwpopwZbcpx8X9kzwrc+aUNmKqTZJwkuibagWHs7ZC2kv8131qe1Lp+C0kwSF
         D5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUVMBSFbsaAmBg6ypa+pJIET21FDUeptQyxItvpQPYOlqUOHtifEeaAMSIE9a+m4aREOkxO551u/OCEXJd84R5EMLP+9tPQyWWaDYnSgfyT
X-Gm-Message-State: AOJu0YxFmSfDk2O0BqztsT0LV9tFy/gJK5+Oh2kka6RrH4S5oY6wegzR
	EQ4kwLWDlehfP3d6nRRxAlihuGWGId8EROjZwWNKVDIMhfiDJi2gGfEPsj/PDOASOMvgeAgv1e5
	yRrA=
X-Google-Smtp-Source: AGHT+IGDJqnmBLiSRzSKUWf75zZICw1ZY/nIbw3OqmXl3+FlHXLWxRGuNeZc8TwdIvF5RcmbDQcM4g==
X-Received: by 2002:a17:90b:3a8a:b0:29a:e095:25ca with SMTP id om10-20020a17090b3a8a00b0029ae09525camr8534010pjb.6.1709628872210;
        Tue, 05 Mar 2024 00:54:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id il18-20020a17090b165200b0029b6a3e1794sm487885pjb.28.2024.03.05.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:31 -0800 (PST)
Message-ID: <65e6ddc7.170a0220.51cb5.0e7b@mx.google.com>
Date: Tue, 05 Mar 2024 00:54:31 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-57-g5d94da7ff00e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 3 runs,
 1 regressions (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 3 runs, 1 regressions (v6.8-rc1-57-g5d94d=
a7ff00e)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-57-g5d94da7ff00e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-57-g5d94da7ff00e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5d94da7ff00ef45737a64d947e7ff45aca972782 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d29f785c3883f74c4372

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e6d29f785c=
3883f74c4373
        failing since 501 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

