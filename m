Return-Path: <linux-kselftest+bounces-12000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1590961C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F96B1C213F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131A101DE;
	Sat, 15 Jun 2024 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cC2A5cUG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCDFBEF
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429029; cv=none; b=R9pI71EoWjb7uimhlpOEppjaQEHS53myirXr+VhMmF9Uhhcm3QNo2QZxPFaxxdfMMFVnJCKphPgDdhnqMR/Gk7d6wgwzMiomgt92bBdAgiymvZU/apqyQq4eYLkdisCZ//OsHcgOCWf+2u8YNatnZKqTlWhfGGlUMIdk5Ds5qmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429029; c=relaxed/simple;
	bh=u2+nYbtAcimfFYtek3xTNjZ/gppp8Y+Edp20/wiRWek=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tg/ESMA/L1Ag0Du3Zfma7h7MT1puXsxFFzXfbnUnqB+NFIF4v6vHe9EDRZeniKwIXrqUo1okVpBytrmYeBdb40enKIn7egRVVSX5XqXJY9Ntn95qGt+DiZQWMRni3kVnYUzIlwxeqbHqLEhrbI+ZGFVC1R91YSrpdn2MPU6+O2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cC2A5cUG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70fdc9644so29595245ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718429027; x=1719033827; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9XyVNfBmsQm4qr7l+PQrf+G+1gezwS0WSjVzhhgQGk0=;
        b=cC2A5cUGDpdqRG1YXzh95waCK+xXG/hhYQEdQuYRDZHBoRV1GxbvCb/LWm0sOpHE4Q
         uDOICfAX0sq3qRFfDH3K+jBycw3FCXmSPGccHisgA4wQ9dCAeU56FdGgQGM3j+iXYNpV
         ahAmkKFIhGUxgMa4zgvVbBknbo3QkZwFj+EgIrQsR9YdRZWiPnC2reQ1vsp/wCMJjB6J
         cS4NXym/iXj9KqeALoDldWVOrMq2RRj2fwQ8v5YFFl8K/CS+6OchKi6w1sVJ47gseZRL
         sopa8bptch0FwMFZX9gZ5oS4jRYApFw0Zt8/HE9lWmmC1iQOyr6n7RG0b+6RY5ReYXFe
         A0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429027; x=1719033827;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XyVNfBmsQm4qr7l+PQrf+G+1gezwS0WSjVzhhgQGk0=;
        b=TMICPeA4K7BocuIjLzsVkxb/dRqUk9O6cpqu/qHRYhmqftLIfsGVqwwokaegnm2Em6
         7S5PMFVtfl+QcLmpFM/CmTvPediTLn6i/mKFmNiWVsx4OCuJY8iZJwfA4oDfk8Bv/jtd
         8pBcpbQSYbA4DmKzuDRLm8f99pcs/czzH4kyBznPphe2jyaQYHt7xLGD4eTKsn1f3owL
         au3cyJ8a0E+WR/PkZPpgl5pQ79iVPWKlMVjqh/07HEMUT40ocs3MR5TEPvC5y1o/qmZb
         mcUf4uK3hdtYAFv4eq3aYrnA6AcGjTWud7/7vHrYqk6r44Owdm9C7t6BXImWWq6T8tmf
         jMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQE6CYW86mwoptKOsvMr656R+rmmjf/iDUpjNWBp/uljSsGwjZfujSBOR3zLGKWE6H4RHoIsKtfZ8ZcvJXWvQusnYnwI5rbGruAxzpdlO8
X-Gm-Message-State: AOJu0Yw9KjlOK5eAE4/QU7+BKzHxH5yALXlmZYSuB67JZN+Biyj3/C++
	0lNE/o8pIyVHQKJS8/EzfH6Bra4nT2BkkLa+Pti7jxJNH/WFDEcEfPS1I9rNCeuymBAtTSppqmd
	X
X-Google-Smtp-Source: AGHT+IHZBhMYdHkP2suwD1t9oJpYvQBvTKbJyVhnin3BRp+MfZJN0eGlobgEtBdmEQiFVTD7G+1MIA==
X-Received: by 2002:a17:902:f68e:b0:1f7:22b4:8240 with SMTP id d9443c01a7336-1f862322e45mr63129295ad.29.1718429027058;
        Fri, 14 Jun 2024 22:23:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1770csm41710155ad.230.2024.06.14.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
Message-ID: <666d2561.170a0220.29a44.d05f@mx.google.com>
Date: Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
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
 1 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v6.10-rc1-2-g64f5bc5=
7b24e)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
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

