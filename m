Return-Path: <linux-kselftest+bounces-3288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A3835949
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AF1C2134C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFE36F;
	Mon, 22 Jan 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ES10OCC/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC2A29
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889796; cv=none; b=k7lbGq01icoCLjnIYHM8+Bx6PPqLPOYVcV/0sjUgmsUexYgG8bbKD4CuJO1LeGkkzeJeoAjqmdiFtRQfFRo0HxeIoDNOcf8KsvNPx+7s0rZ6Hg/zqOqQJGuXJe3p2C/WXQwgwBHIXuGOZqVQfZJEEDrAfvS8BR4weYOydNsAvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889796; c=relaxed/simple;
	bh=Hm3pToN9f7iWdTuzPmCEIYN2CUGkqg/xRiziufkCdwI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=hoiJHVvjihTYkvhSZHJRFRQuYs0cJcK1v8Csog0sJ/WYKzaIQkM8/31Vglfg8Is4J6EET1crW/FUYiOMHC+m9qOr484qQBgigb0nGDQQEgUJ5iJh3oi1dgwU/0NpCI+69uC3cOF4X6HOgMcvn3HwFVU2bV/8869n21sAhm9CeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ES10OCC/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dbb003be79so2420299b3a.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889794; x=1706494594; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aed9GRqpt+8hUmKl9tI3vZTlQjukdDZIcWfCTLqK768=;
        b=ES10OCC/UAjaxhXyu1kz7OQHSgFZ+9uIldTvi1jRtCAJxX0yVgmvh8WHPHc5+GnYqL
         K0iwP5ITtAP6bmJnJpteAdZ7wyyLDQekYK/11q0MTUIF/c8kw7y7uPN4niEzXfhBN+w1
         1bicJ/dyKCoSEXUjnMlBvAElqjYk23QRXCVQsKbGyro1F3VcTvZh5GPdtdvKCAdbstCa
         IChiHsxpGkc+MPfBBUlbU96/NSlHBOV7dXQZ0cuVHLr4Z2tSVVHH2tOerD3gjDmdopkW
         ynyhr14xRzSl0LPITwZJ37jSaV2tuAR/XRmnOGNWT2EkJYV80CrC7m+v2pPSv8oazo+Q
         Pk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889794; x=1706494594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aed9GRqpt+8hUmKl9tI3vZTlQjukdDZIcWfCTLqK768=;
        b=uAaz2rV7IZO0TRCn/uUQk+ExBdOKqO90QK2bLuVYP0cMH9CA9inf2sFiB8K5eRUgC8
         yLR/riL32eUd9lIhbRUNL4PUiL0nHhpwHrYYMYEMY0hP5IASvpTkz780ona0P8mNQ1RV
         vFOCKgweGBVeU8Afjf/tXB0NrvM6UljQTlFU/by6W+9FoCdbtymrMo1eT2N3L3yA+6jE
         L5UXX/z1k0pevt8gIVMmZw/HORi/gBzb3Ul9q6If9y1bw5Stvh7z1h/0d6MQLFgr6m4x
         NRnXNn+rS1iTbv5S8hbEVLGl7JpJiTMVXoxaVO+/vLcnQjQ41baiGN+s34w9xIDiEWKG
         HFIA==
X-Gm-Message-State: AOJu0YxH7lnyD0i1/mJp0zQhyt9E6H1ARVUn04VNE2cDP8VzW0VbpR1I
	07LKuO+Og07gAWJc0dz2zqGT4eOjyX9+igiqjHbdw8xn549FWi6G3U1bUtYJeTyOxFKBAqptCYA
	M4W8=
X-Google-Smtp-Source: AGHT+IFz/1QfUF6QAus/kvGKqw9+h53hWdve67hawGFTIYfm0VG+Gm+K3dGMBEtioHEWDHaL68YQhQ==
X-Received: by 2002:a05:6a20:9593:b0:19a:520e:e225 with SMTP id iu19-20020a056a20959300b0019a520ee225mr6602340pzb.2.1705889794084;
        Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y16-20020a63fa10000000b0058ee60f8e4dsm7367346pgh.34.2024.01.21.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:33 -0800 (PST)
Message-ID: <65add001.630a0220.b4788.93b1@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 5 runs, 1 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 5 runs, 1 regressions (v6.8-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6613476e225e090cc9aad49be7fa504e290dd33d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc33f0fad8dd25952a402

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-cpufre=
q-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65adc33f0fad=
8dd25952a403
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

