Return-Path: <linux-kselftest+bounces-5900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10F8718AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EF7281E56
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51244EB3F;
	Tue,  5 Mar 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fGW3ZnpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F04EB22
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628873; cv=none; b=r7KkrR4YcHhsZFuKbPg5D2a12q3vCG7stIApWdbdc5zoCpvs/+C/WuNHsvnZPASSlaezRKqbUVERFka+3mgF2qQkGz3dHyfuFV83CdCV+1n1ijGMyCpV7bzGHaps8k9epKPuJvhdELRDyhuAp65TG15xEKzevZxTO7mVv4MZwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628873; c=relaxed/simple;
	bh=VYH7QqZ1dJiuMlpoC+F3xPQH7piAFI2uJyzA5xWDxrU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=DwZmMNmV96+yABT7MAWtk34iKSZp3YXTznOPOYWaIKRtJ4GFUe4GsaAks6HqLmsqscX8hWB7F++NOiCV8s7opbolmx+DnuwGqPu44TVyfpz6BcjuvAA46uKEIQrDnFLElO6fcstPDWMBdeT9oid5t0zFAhXE6AivNotOKDcY0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fGW3ZnpR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc49afb495so50699835ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709628871; x=1710233671; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BqbLsl11+YsOqE6hweQyjdsto57H5H9kJOrJ2/0uC54=;
        b=fGW3ZnpR+JLMBtopBXkbUH2HTgzmGDnooClnmmfGtq6Q4rlnvr4sir5hnLpBDMZJit
         nf+hxAMPp+ukLx75lVf7b68eOwMGdZwbeDNF73TeCkb2gy7nv+rhzCFC/d3URA2AJMaW
         rVJPTF+DTcrC0gb7cMYxTjIWsJbhz7CVSfq2lmDjlR7l397kH1zcn8yTgqz50d6StyZn
         jdhI7tkT4qzMpkiz0ZJ58tnQbvW8mrZZsMZGmsn80FpB2lRsfg2EbuWW2AHfliMfCcfl
         so93GO/4iXeO34hqanA5YZInlyQdWfqBLNY+f1tHYbSslI62svCgveYudm4uY+FXxJnl
         JWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628871; x=1710233671;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqbLsl11+YsOqE6hweQyjdsto57H5H9kJOrJ2/0uC54=;
        b=Yv3o9mspCYkEGx9VrVjdftxMTCpuFC/WZwcPuTQnT9ORIXlPlLbLDt6aAAnAmd/PnY
         ouk2BY69M7/wtvm4RpTukVsHo9eVPOuAbdn8NAHtohpOWLPbLC79x1wrj/Xr62sLFnvf
         eVt8kg0KOkZx/+6dWFolL60HkTuQF/ePkjikCr5Da0EsRf3Za4RCK1VIxqaRB0xw1nqd
         lS58V4Il1hTfSSLFrXAXByG6u4fcSHnnQtBQleTi1YBXRtArYb4+s5M6GMVSGAhTgeJn
         zHgEDxpi1rGGDme+dKMjhHDpXkeI+5pz6QStFK+eEk2h/MHbar8B6bOfEzJ7UrgDswnS
         CipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC15BvoE0k0wqKMI47yhkquPp/1UkafOV3EiR52op7fmNBUU3iSUpf3WWrQq9ShD7S7fm8TX/uQ/H0D0hg7idI+Ot3TC39nDDcuD5q1YTl
X-Gm-Message-State: AOJu0YyEq4z5iMY3DVNJjWrquOSx2cXm/V6kSOZ+MKbJyN+jothVoOpC
	waOVAKZ4sag75566sJLfit7ld3eeUZNRZLMHrKOatVo1l2jPe3E6QoGOGyl9C5k=
X-Google-Smtp-Source: AGHT+IGNTVQVJ9mmfw6lM3BQ8DDj7eZrsnx4DYWvDm0NeZNWEOBZrDVuJ6zQI6p0aKVldeWEw3Y2Qw==
X-Received: by 2002:a17:902:f54a:b0:1dc:d642:aaf0 with SMTP id h10-20020a170902f54a00b001dcd642aaf0mr1621323plf.6.1709628871671;
        Tue, 05 Mar 2024 00:54:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001dcfc6c3116sm5895893plg.65.2024.03.05.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:29 -0800 (PST)
Message-ID: <65e6ddc5.170a0220.22ad2.26bd@mx.google.com>
Date: Tue, 05 Mar 2024 00:54:29 -0800 (PST)
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
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 1 regressions (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 3 runs, 1 regressions (v6.8-rc1-57-g5d94da7=
ff00e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-57-g5d94da7ff00e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-57-g5d94da7ff00e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5d94da7ff00ef45737a64d947e7ff45aca972782 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6cf84f6869ca0e84c42f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65e6cf84f6869c=
a0e84c42f2
        failing since 460 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

