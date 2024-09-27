Return-Path: <linux-kselftest+bounces-18516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E072988BF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 23:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFD1F22C4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7628185B64;
	Fri, 27 Sep 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Va08hQUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D21158550
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473559; cv=none; b=Emkhj6hMt853DyQlquA+1IbGAQRW5CeDjRNBh8JnDTAbP+umC9P/SGQGOaSHwdwPr2BGGFtdCYT9vP9hfCjRlJKmEoWPQivT+LW4zQjUgcFvd6+z+x0rJMqnF9fz5EWxWUhJMxnuTHM14shs6Dq8EhpTS0BuNiUFoIPR5RXsi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473559; c=relaxed/simple;
	bh=ZuLsyqXhOWuNep9YNtYo8YqwMjVJCmWuRLGnVZBcSso=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=pFJ08xjGDHzSILRSN2PpUK7X+w2D2/rZQEhoWZ4bRQU5YYLW1W0RNq67DOAR5o2lDvdgyck1eG9kMX/6Zo0uRpmcxwgPyQIQbBUJ7qaXHnA3/5rqvBgj3vrlHezLmORTCdxH37rfIAjxmUsWLVnHzvVwuby9sh5PF8lp6mcVoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Va08hQUz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71c5df16b10so746705b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727473557; x=1728078357; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mBoGRAugePhsBaiZE3nH93tu6sfPw8iO+a+efeAHAQ4=;
        b=Va08hQUzsjFRIZWBVCkcOo2q1n2/CmxrNj+2UOHCTZbMMvMFInnu5A+wyC6LcxYDmR
         TiYcQ1kRTJQSdYbA//FYTPLmgx2sTKNb8N5ZQnnsTC2r9dacGZOaorcg3G5YrHqwrrfB
         kIMYKxsdK1pNHnRLXfXev6l+rsZHVQ98JP5kva3XLpWRfk6KfMG+H5iEi+4ErEe6d0YK
         ew/KyK47qu/pECZpvSXnw7Orvw1maQt+wQDMDoJ0GIDkWPw9pn1pnVmH+VyHQPaSw1kH
         WbpOcoG/fR9o9mShGkQmSVnbcN7o1q6GpSCffhUoLT9jH9c/8T51g7TPhkjvdkSfYAPm
         IujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727473557; x=1728078357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBoGRAugePhsBaiZE3nH93tu6sfPw8iO+a+efeAHAQ4=;
        b=kisDaZxL59STYGaLGvWxOoB/SG6Y6tvdXBupdWyc1CbN4BGUZvCydzbiJ+U4KvpiWu
         BvmmGsTy4YaYTEQxNsWc6zOQ8qBaLArcIQ3xQNAkoRBOr+Ir/+fFv/n9Kr4Of3X79T6d
         wq5IyueMJz8YZudyvvBocm13aFfxrjPkp4r+/duAkdB54oJz/KGwaasuhpmugDXMNjsv
         ffmxGiHTSomXrYcjjdzWhuOBz+KDFHp088NhVRejwOblyYsshomySOZWglJ2gBKdkkVj
         m7cApuRQIRJ4s5ak9gEA+nmMSK2kr6FzHdb2BTfxtOd+azls+0nlBFPcaGzhCvjoeznc
         uAmg==
X-Forwarded-Encrypted: i=1; AJvYcCUK9QqvP8dPRa7HAV4TaxKi3vQMXy9ATfvvqlY7Na+Efr6lG+NtA7vSPgsdUOya+6S2LecfJ3VkIFDoQtj54zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuCU4USudRtSVuZhhtnag6xI6VYHwAGfUQAb7dmeZv8oCFvpe
	G4Q5R6kh1XKkq6KQn94A4WONxemZQM/mNjm3LwQl0nEFwWOXMMTV41OdjR0HSNE=
X-Google-Smtp-Source: AGHT+IEOil9h9+UgPnGCiGpio+nnJNQV++Vr2TCCIR5jz7oS+UgLDcHoCKbEX6cIeRrJ5gXe+CGxUA==
X-Received: by 2002:a05:6a00:2d25:b0:717:8d9f:2dbc with SMTP id d2e1a72fcca58-71b2606c524mr7484198b3a.23.1727473557251;
        Fri, 27 Sep 2024 14:45:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515f04sm2055062b3a.125.2024.09.27.14.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Message-ID: <66f72794.a70a0220.1d18df.ca00@mx.google.com>
Date: Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (linux_kselftest-next-6.12-rc1-1-g4b721fcc094e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (linux_kselftest-next=
-6.12-rc1-1-g4b721fcc094e)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x_kselftest-next-6.12-rc1-1-g4b721fcc094e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4b721fcc094e9eb6dd4702df8d79ab11e120833d =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66f7209fe5e957750ac8686a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66f7209fe5e957=
750ac8686b
        failing since 59 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

