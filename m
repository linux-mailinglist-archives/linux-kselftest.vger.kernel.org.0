Return-Path: <linux-kselftest+bounces-15798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46858959097
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 00:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D76EB22E6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8AD1C8238;
	Tue, 20 Aug 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ep+VoX3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A01C7B78
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193632; cv=none; b=X47Exb9Q/n9aZmWOcRbKrgbza2x3tZ/8VZdw2NJsjsIrrpmn0PUJAN8qfLDst1HNtxTByL7EZzkUGnIZeu10T3CVzsZaQXH1Pd1fvQI+a3bvFE3x0XXnUx/+dsXk5VPxtpPC2nXd078H8DRuAtcyMLFfLxxtmySx2QBvPqf6JRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193632; c=relaxed/simple;
	bh=XkdYhM8SaKi2CvIOkeFynFvKkjVo7wCxJKoz+2KpYZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=cLuc1hv89AWI5POTxiypx/o7DcjH0frWEf0Ro4pJ2CdzJiUhxuX6uUZi1NWc/kUJnY9jFpgJvsgrBGx9+W75wgLVKgdcVqh6fuIelgs1Ci3ORlj1I4bdoOVRD/aft5HhLEX3GWbuTNJz3o2U0lHZ9UDXdTGHvK+sGmYPbCUI8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ep+VoX3x; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-270420e231aso2128339fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 15:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724193629; x=1724798429; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUmQanDsZDR38xjM+8A0+m9ko22H+vQPlol1wJ6Lxgk=;
        b=ep+VoX3xZm2fCby6ykTziq6vnaY73Rc4Ot6MmrnCJYZR3NiN+Wz1mL6/9VoaHpecU7
         cjN+9QYILtU4sU4JMVNIOJ0MFsOGp0ABOVYaehhrVYUdh6kFvYbwsHaI5ImFbBjKBfe9
         yy4y2BUyScTvFlb6rNe1r8IyifqSlnuaxGLukt4hJ7OjRuqZx+dOIV1iC22/XlMU8fwy
         wXLh63NEN1K06TSdnylqG1emuUnTD+WPBYiLD1ycERoiyAC1H7gCpJzvdyaL+aPu901J
         zqcAGxXC95wnfW6iIw3og7Wj7TbxsyLQzpro8F79DZbhWNupCDHCh1d3mHLMO4vhy1W5
         Tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724193629; x=1724798429;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUmQanDsZDR38xjM+8A0+m9ko22H+vQPlol1wJ6Lxgk=;
        b=XkrRlW+5dULw2o/EWrcr1Oe9AJp0B+PMdZmeoSvnON0fVyQX1U6OBHiN6rNMLz3LiK
         vRrLdd+/7YIAZoYA/WjWNbvSald4DYdBc+mR5IYgtm+0WnxE8PqIelwj+Pept5mm5iph
         iQIA2cejMXdBuaRgWfqXyXR81yEL/W39lZOlVzXr5jfLbPs/mxhaXZk44/kTHqcU4Qvo
         8wgi0kIQ/29uFvpbi1cuT4bRj2fkhdN0sGu91nzmCezMNVprCLpR8jXJydNjeUj+uMf2
         Igk92fBheJ9aQ3xxb08Hvo59/LrhIgBkGrsXWeUFgnZLkvy51321W/8XG3DOMpUxk6b0
         C8gA==
X-Forwarded-Encrypted: i=1; AJvYcCVb5lKR5O2p9O8AXTnAk93qnFwI/qMC7V2z9LCGXreqDdizqFTtbhxWJ5b+jC8ZRodGn++aLzG1x0r2cn4/gkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxHVzOiNWSpaj7SDJVZAuxnrfHmkIteSdel8jgoVrjNxChUhs
	eWvo00JlfeMaWbLhl2PCcNz1b/F6B/jt4dXtcYPOZCwDCHhkTH4xkiixa8WpnCLnbvoqGQ29s7f
	D
X-Google-Smtp-Source: AGHT+IHAlnGeIth6KNqxsTNUOCBZVwVIvly9gvLLwX8M3sbbpHe6pocRfpmQ2ueEckd9/oaxK2qy0w==
X-Received: by 2002:a05:6870:fbac:b0:261:23f6:78d with SMTP id 586e51a60fabf-2738be86139mr345326fac.41.1724193629036;
        Tue, 20 Aug 2024 15:40:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6de9sm9041989b3a.12.2024.08.20.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Message-ID: <66c51b5c.050a0220.29c4a8.06a1@mx.google.com>
Date: Tue, 20 Aug 2024 15:40:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-13-g41f37c852ac3f
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.11-rc1-13-g41f37c852ac3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.11-rc1-13-g41f37c=
852ac3f)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-13-g41f37c852ac3f/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-13-g41f37c852ac3f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      41f37c852ac3fbfd072a00281b60dc7ba056be8c =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66c5128498efe3795cc86925

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-13-g4=
1f37c852ac3f/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66c5128498efe3=
795cc86926
        failing since 21 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

