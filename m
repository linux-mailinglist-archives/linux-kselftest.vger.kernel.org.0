Return-Path: <linux-kselftest+bounces-4615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFEB8543A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A566285768
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242311716;
	Wed, 14 Feb 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XpeTBD9i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6561170F
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896994; cv=none; b=ViHTJiKaNmcMCoebw+4RH4XX2dKy9e+xPxCqL21PZHwQvTOjRH6ZFmpImw+mGPOC6LyU/+KHmmVkbbMAqpurw8JVwkJtoAlv8lzcWR/0Bta03df+7PUt0Gfb9fP+t0LDyFZo8VuvDDynQC3NXlZENgLXUpdvbU4Hq5QupNzWwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896994; c=relaxed/simple;
	bh=CDlXkYHTTjWHi3Kk/dVch4DWuMPi9TzIPbgJaw9MykI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=O0u1NuCrPMZ8fHAq2XLVDoa99ECCYz2+S5CxL0UGqthIXgYjuis+4w0ZT0re7TmCda1q1RkinNrNZnhcU1N4tOc69GBXNXqEt6SV+qdtyoKqscY3mZwQdwbZ0qTApSYnwO2GPAoDTtS1ghuiiLRhzostmCt1Piu4JdgAbtxArmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=XpeTBD9i; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363bdac74c6so14490035ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707896992; x=1708501792; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i9UAFYxsw15q+3SuwXY98QQjvh7qfGoRVousRvAxabU=;
        b=XpeTBD9iHDS5ezArExlY5JRQj1hQNZBz2DCq9Z2yuvJsipUCk7VVH739En48wuHOiM
         DZfwIPSpEJiUqCyH7NyUIGXwbgTwi3jr6bI2xXqlmo7Wp/LunQ3WixllXG2ApQVqwGkd
         gmE5do1Vh07SKQXVGyBk+3v+NAz9QGqSzvjF+AbecYnQnzgX73uoSkYF6heEiu16X+I+
         Pg22CuZwyWGifH8g23HjLOoiBfSgd4FRquR4M1m1ju3qd3zyMe79QDM2H5T0QZl6A4v3
         taZ1OX5YONJF0CoWeCqp6PbO2S8OcTEP+qf01XhBbQJSe1KCiQtKS7PtVRBW08PfXEym
         Z2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896992; x=1708501792;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9UAFYxsw15q+3SuwXY98QQjvh7qfGoRVousRvAxabU=;
        b=Lq+OjkJHm/AMJnkH2jGfM4T1ql2qfkypXGlwt0fJR0rVRW2hUZKxjq7TCtITtnJ5KV
         FGZ5N2FeJVaYow6O8TDdi1ugRq+tum3tV1kbTDNVdrZNPSKr12XQIyYz5qplOR/HJXvK
         9i1Y5Ioo8pQLs/BrTJAdw8Gl3KItecoWtXRfZwd/XzAYXayHZWgX3sgLqq87T3om0kYt
         JsZ3hZJ9cZu9WBVW08nWwG5H0ni0QEE3/HpXId8jtMoyAp7bsl3NO1IBq0r8VpRuQIir
         4titX9RRtolg1ZNDVDfd9o07d8Ry0I1luf4lxr1sjVg7KciJUuQIrf0BmK8Ef6Y4B67B
         iOsg==
X-Forwarded-Encrypted: i=1; AJvYcCVE9cbm/lchUmWSLPNsJpi+fEHgmlPY9dbvmwPwIHs6c5JimdfmWddoUfN1IkC7U27qmJx3IEp1+YHaixx8x7UBstwy2h9d3qScF8u4Nt45
X-Gm-Message-State: AOJu0Yxi0BWlzV3VshzlaS/2XXEyl0uozEfiR8/4Ea8MR1kSpCyWv3Qc
	iO7XPhr7ClkBWnduw1q6y+OCHNvLHI/4aGEbqoPOxnz3ZAxyexwXJi4QJd2Rzx1LEpZfjfb+32w
	6hh0=
X-Google-Smtp-Source: AGHT+IFTx9aKeEmL1ECC44zXrrKCD8M/WT9KTx1+Xo4Db6DABT5gOhos9FnTcsjWvdksTpxHtbtoJg==
X-Received: by 2002:a92:d68b:0:b0:363:c288:f8d1 with SMTP id p11-20020a92d68b000000b00363c288f8d1mr2253367iln.2.1707896992469;
        Tue, 13 Feb 2024 23:49:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyiabwGSPirzLzjIcc/KxsL0APHXSGyQo15+CI3YuEg15WgmqDwrPLyPQsq3rvNE8h3XXqjIuRinbJfF16Pe0ecmpRw5Qurbqp0WUcltPUDwA43plU0QQPXN9yqqLdN3oL
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n5-20020a632705000000b005dc36279d6dsm3612921pgn.73.2024.02.13.23.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 23:49:51 -0800 (PST)
Message-ID: <65cc709f.630a0220.482b9.c6ef@mx.google.com>
Date: Tue, 13 Feb 2024 23:49:51 -0800 (PST)
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
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.8-rc1-32-g345e8abe4c355)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.8-rc1-32-g345e8=
abe4c355)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-32-g345e8abe4c355/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-32-g345e8abe4c355
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      345e8abe4c355bc24bab3f4a5634122e55be8665 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-10   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65cc665746126920c2637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-32-g34=
5e8abe4c355/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65cc66574612=
6920c2637013
        new failure (last pass: v6.8-rc1) =

 =20

