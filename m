Return-Path: <linux-kselftest+bounces-11736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F929904964
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710501C2109F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF2182AF;
	Wed, 12 Jun 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KdEyiqil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DA171C4
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161794; cv=none; b=ItEHQ0fJ0uUWy8sXEMFgLmWsILmIOi0evImQ8Cco14kuulBbm4oSt9VEdamhVX41rYcJkhlg0Zl5SKv5weu8pzNwTaB4PEwE8R0lkx0GJwDqIOIK2RmF8dFG6qb4ajQUax29VT1pjX4kSKu96xjUItoBio+QMOq6agFJJhNqdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161794; c=relaxed/simple;
	bh=NAofOnS+QqXvq7HJVJLKfuzDRsQFCEBM8QOi/Udktys=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=PDhksEdUU/jJqcu2JFsmQ7fixzuMP7kFXzrFz+Mv/Y/KD5aPk990caDFiW2iLebSujYkCjSwEpreE501w8e4F/barDnrRlp9hEF0fOR1AN4W0RB/Uwek4E+Qnsfkk/ugBvWvlBQgEGCPGaEwvNdF7nTfmg61oug4WlI5RR7UvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KdEyiqil; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d23a0a32afso534307b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718161792; x=1718766592; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOrN277c+sFzAZNTHcZ+4cILiA9Y7Wfdm4mn/nfuUsY=;
        b=KdEyiqilEd0Ar6PeMbt/fQPwCJQkcJcqEQf0JC5J09F2fe5lkoN3WuZEaIxx0Zubhj
         6Lvq2qwYZraN3HF/s2hb2dz8v3eQiohtpaR7ZlxnoB1eEDdlly0wqjMZwn+gOqJhzbZL
         WvwvnBKMrTHWgzX+Qg51hax3aTVZtv327nD4/vzXcd72h9szIjE+pAY+576pZnG0Ox3u
         SgpTX2rSwYqWsTCgPmhr58NckkIr27kEDa/Q8aMBt9MOgtXmtyJpWL13zBOPpJ+Uam64
         Gan+6N/KoH+apoJDLj6NIwrb5t80b/QGv6//FYAyDrQmcgEYTB8nSbxp+hWMgvhxMEjz
         6VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161792; x=1718766592;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOrN277c+sFzAZNTHcZ+4cILiA9Y7Wfdm4mn/nfuUsY=;
        b=miJvbvbysmHqrz97YOpDoiODnBuAge+mt4vWOrw+NTwk2huQeAJ1X3Ygwf8+0zKMS+
         fJCdv/9euSSKdhFtt3jL1VBg0c8IFNNcYsr7z8XJLPqy5IVR2zj3yPjTblBVOjlt63Bo
         6SBPjt+V7iuon5/fhCNNuOezxdXgTpZHnArXMpzJEY2RLpNPkXcZOJ4GPVQw7/VJUuuL
         kmdPdFen3V6tQoeq9mjsBemZJEEc8I/RwJiCW36+/MkffVUA3i4vMMQ9byX7FUJUPmLJ
         29AyDV14kgHfmxJlMA3WVvNX0qvGso+MvAmKK6p4l7fzXjxlgKLc+F+UFhniyezU772X
         rD1g==
X-Forwarded-Encrypted: i=1; AJvYcCVIxHiE6FyJk+TGGCJOCaCaKSrc44EnMQdBvjbSLJnSw6N+ABk2UtA6pDqDbnKH14CFm/ZOpYkR8kgY8EBoBFzSTRG6CwkoecnHyhu3OBNX
X-Gm-Message-State: AOJu0YwS450U2Bt7jrz6ZxuY8p42S+PUWMeW+ofe9UheYBwRDMLLsZnp
	Id02QvmneJvHNbXbfVD4mgP6fjVywd4Pa95Zn1YEVWRy3q5HAfjvKOuRl/10a4qW5QbQkk/7wPb
	Im/Q=
X-Google-Smtp-Source: AGHT+IGhZ1q54CTRqyuwzMVn0HLPr0G65OXDY4uVsRqQFpMfAHxDPFgyqwr/mO2iK+gNowI28qELaw==
X-Received: by 2002:a05:6808:1b08:b0:3d2:269a:5e13 with SMTP id 5614622812f47-3d23e0a7919mr631282b6e.45.1718161792305;
        Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7043639b5d3sm5264655b3a.91.2024.06.11.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
Message-ID: <66691180.050a0220.ca773.0629@mx.google.com>
Date: Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 2 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 5 runs, 2 regressions (v6.10-rc1-2-g64f5bc5=
7b24e)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite            | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =

mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite            | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/666901b3232cbea21a7e706e

  Results:     62 PASS, 4 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_VMALLOC_LINEAR_OVERFLOW_sh: https://kernelci.org/=
test/case/id/666901b3232cbea21a7e70a4
        new failure (last pass: v6.10-rc1-1-ga567885b1ecc9) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/666908f1c1df1ae62c7e707b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/666908f1c1df1a=
e62c7e707c
        new failure (last pass: v6.10-rc1) =

 =20

