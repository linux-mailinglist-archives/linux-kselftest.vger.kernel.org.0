Return-Path: <linux-kselftest+bounces-4614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403C8543A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D001C21F6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0531170A;
	Wed, 14 Feb 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LYsp7wfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285F125B1
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896993; cv=none; b=Aa6IFPlkBRioQUKYhVoMbF9GoMP+fZnek8zLGX9y8gaPhoLLbc4IKIt6Sy5rrxQWwx9xC/bw0X4JfjbY/G/hwBBZnHZJphAKPYq+lcSgNsbW3F15gfcbMjQzo9OQhtCWnudYREVv0P+n/WpVD3B+v6q7eKjgpGNU+mNtzFnbxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896993; c=relaxed/simple;
	bh=ubSl/stIyLSO3tzR8oeAo5HdbaBhRIoQw0M4oPmPp0M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Ia/pcc1drqaFcTwSfR0DAmDtz06zApcTEP1Xm5mzRrZHbwyAt5PnJPJ7Es7Y+2MnVlMFoBbWDaXRXqzOSGnXdcwLb6KZ+vlRRI4D8k12GzoPHQhf8KPGJo5SKnmAS9edTHRkyykt2e2kJb1fKq2h7PjEfIHBlE8M7wfLZ0EVWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=LYsp7wfl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1db640fc901so658865ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707896991; x=1708501791; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NpTUBhdidFPO7yQaSU7PY1BLhze87fEJKko7h1+FI8g=;
        b=LYsp7wfldVyl247nG9bULgFEZiTcJJ4JX/CG5RHJEvvD3ytUrAty1YAVlwzx/cJ3/A
         qQeRpjjrGU2psYqjTF0+Ig7J4z1d8o8Ic2/t9aAtRtqD3/Kl+bmIMSWalR6nNPwWMTvA
         Hn36oSAnIc2vUQJSXl+oTdVWoDlImhPdckKJmm5G7S+FpkU5A8cOChuN+sXRo3qGbEUY
         cIEPlPuCpnsIr1h4NzSQZ4OwteF+wpr3oEjwrpih4a9PGFy7PYpaqmxfxxsIPhTcxLny
         177KB7S+3ZYH+lr9L+mxqYXn/gPcwBbXD5ZP/qj0f5thT/WdzOELWiIObfXGuCqDlaJQ
         e0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896991; x=1708501791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpTUBhdidFPO7yQaSU7PY1BLhze87fEJKko7h1+FI8g=;
        b=Hv4Y1UfktUCRHiEsWZAe3K6Yyzki7DQDYgF1dKVTyraVcCRFTBqaAq6JamdKaCAC2V
         jH562tYdQkryf081KwBt8W1UqVDlTOXglHt/34O5k9I+WFsmKqsxlVm+Pzh31I7o5gve
         PqoBHClnqAVDmULEJSjPz/okzbBZ3G9z3wIBOXm2jkWaJmVRA9Qkl2NnJ87I7CdC8YQF
         822nTfDT42SHf0ND193wOBtD5uWRSw48n0uiv3AxC9xr/1qE1XFhQY10ReHEYO0KQZ1l
         P4LaEwPmyqJ+eXmG9eq6sKByEo9olC5dbCDZbyAGor0YLVOMkiLVQuZc2+gnBtz7Ac62
         vXIg==
X-Forwarded-Encrypted: i=1; AJvYcCVnWTltYEkyT312os3yH3/47dLqzKa8JQ4gE7sQuu8loDW7Cm4M3J3ejDO4W7KIk/oJLev95/3kKv9X/CiIA/7ZS6WVJiwqXj7PBtUCoukM
X-Gm-Message-State: AOJu0YyXUrFP9PFgHmmP5n/vWapUyqIZ/Todk0fuA6VT05TugQIgAnto
	eLhvWPWTmXRDUxdqujPn4HDOsj84zkvgMrEhtp8hjVamB1giIHJNiCdQph+nDlQ=
X-Google-Smtp-Source: AGHT+IEtqBK8LBgTIsXkSSTrMYU1wEgo/3QLyRS0taLOF9hVRImVaGC9ChOwVPyG1sS1wVjmr0QTmg==
X-Received: by 2002:a17:903:183:b0:1d8:ee41:de89 with SMTP id z3-20020a170903018300b001d8ee41de89mr2231252plg.69.1707896990980;
        Tue, 13 Feb 2024 23:49:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGHnwCVa8NS3Sv8Ms9IaXGLoW+KlQwe7TzjOySpH33acF5OnLKqQ4kHArV/+j9Bx7tLqw8wOzu9m+fYVfBqAKHcO7XlF25+TMKmQPWjoh/VAm0PF331Jl/+piYIagLW7c5
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ml5-20020a17090334c500b001d74502d261sm3168658plb.115.2024.02.13.23.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 23:49:49 -0800 (PST)
Message-ID: <65cc709d.170a0220.edfd6.a850@mx.google.com>
Date: Tue, 13 Feb 2024 23:49:49 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-32-g345e8abe4c355
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-32-g345e8abe4c355)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-32-g345=
e8abe4c355)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-32-g345e8abe4c355/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-32-g345e8abe4c355
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      345e8abe4c355bc24bab3f4a5634122e55be8665 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65cc6163387b991438637014

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65cc6163387b991438637016
        new failure (last pass: v6.8-rc1)

    2024-02-14T06:44:10.893373  / # =


    2024-02-14T06:44:10.900024  =


    2024-02-14T06:44:16.051965  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12761214/extract-nfsrootfs-4r6083o6'

    2024-02-14T06:44:16.063460  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12761214/extract-nfsrootfs-4r6083o6'

    2024-02-14T06:44:18.308382  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-14T06:44:18.319349  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-14T06:44:18.438006  / # #

    2024-02-14T06:44:18.445186  #

    2024-02-14T06:44:18.562958  / # export SHELL=3D/bin/bash

    2024-02-14T06:44:18.573046  export SHELL=3D/bin/bash
 =

    ... (47 line(s) more)  =

 =20

