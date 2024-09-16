Return-Path: <linux-kselftest+bounces-18051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBF97A838
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 22:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620801F262F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11015D5D8;
	Mon, 16 Sep 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ktTVQeGn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434613B2A5
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517995; cv=none; b=Sh4hhioH/ShMkrk8f6T+k1V6uGUog1O5h1nKeoLHmiwBGqR/McQj4CMel5Z4vKR6FR73gPIdVGLkLFng9h6Qw6eOvsyGunD11TfsCOe2NR7ts6NBHsF30Lta02lAmWGbfSNF5142zBIfAg5pbd3wnU4VFyVLyDrwdm58n6bem9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517995; c=relaxed/simple;
	bh=suKx0bFizGCDWdk5w48CjuFjmKKTgRzt9ZgCvt4slIs=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=X9+RDNJsD5o6hV8/ki1WWQFogJgWeRBFHj52liXgLFn6M2fDsXxXRCppSV05mqtQwznep4e99+m8fibz1mjWM3dl5dYn8/nyekAwDoK3a91yzcXwS4avVSNBSK9RKjqQs32s5XGOMGjQ681odAsClgZAtxMhK7TuzWJDZZkxsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ktTVQeGn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3982061a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1726517994; x=1727122794; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cUvilYByP6h2N/yTzODamqoARsHnvBSmfTaS252dRtY=;
        b=ktTVQeGnF88ES+2J1wLyEtLuKDW5kMUzXJUDAvbF0O47zA/mtC7nR/l0das2nHDLja
         MbNr4YqvhrNoWuCmun//y17vmOL8xSF8J1b2p13/6FxwWgueFZRZ/RHbQ8v+Memr7cRT
         ZcVp8Rgok14VQ95cUg/SRovjahaR/y9lrcvfV3XZTQAXfp4zy/F6u60Ne8bX4JMqgMtk
         YXmp+0Q3A7jcWA41UsrM69dCUx3Xqp/rz4LfECe0a/Zh+D9BGs80n3MXcpIYlN7GiHmd
         aKx7AR74S6HUXAQ0iiKD/87IImHaT/YoNlaZVxyIX4yAv6Og3epBYx0x8q6nJf3WsJnZ
         Cd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726517994; x=1727122794;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUvilYByP6h2N/yTzODamqoARsHnvBSmfTaS252dRtY=;
        b=hl3SMxJZmIyOzWIpB0cWcdRVSPm4NyIu+ONjtL/YuzhPnGsOGjz4YCT33xa2WspqBb
         oRGlzEffEPOOil0/PLI5LeCCv6bcqgeR9MzBuG22JevxbtSRFWY9ghqVbE8J9UX8mHJJ
         7DLI8hKJDWamNcWDvUnwbiZXj8KyrVSFkqhL2XMUQpxGcxEAIMeV3H4Hieoq1BGruicN
         hJ1kvGsWYKEY7GGwjFM3GjiYA6n6TelCIanVZLWo+iEM7kFxwo1DHKU9Z/xk4cmOwjBL
         qvB1HGjqQrdpdQGTKPea+CciNfnONS4oDkyEPHAKGosUHE78OwgW6VaEfCk3hs6aYhO/
         6Phg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Wp/qThvUMjJWhCQo6fwFiBoBiVGO+1yk7pBBQlYkctiTn6WJa14Mn/bTqQExIn1jlg9C1LAjhYEV2nf8MsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydS5TsHxBSi+nywdYsbImu56g4ZMhdRC5+ZudZJ+qKtfGr4Dur
	oujEdl+sFc3CI9G5eyBaxxcKnvFXXstSQ2TJTqD6Zqw8FTCAz5s1EyVg96Gg7rYHPyrLQ3tFlhx
	Y
X-Google-Smtp-Source: AGHT+IEcDRgybJngw7ZnkuYfz75ItWKGw+ps+K22vi5LM9ZziaPXXHhj7Ztziv+3A27VkIAbW2V1RA==
X-Received: by 2002:a05:6a20:914f:b0:1d1:88bf:dff6 with SMTP id adf61e73a8af0-1d188bfe1ecmr14236989637.15.1726517993810;
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db499a016bsm4704382a12.87.2024.09.16.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Message-ID: <66e892e9.630a0220.a81fb.fb27@mx.google.com>
Date: Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-21-ga0474b8d5974e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.11-rc1-21-ga0474b8d5974e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.11-rc1-21-ga0474b=
8d5974e)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-21-ga0474b8d5974e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-21-ga0474b8d5974e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a0474b8d5974e142461ac7584c996feea167bcc1 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66e889bc13fabff8bec86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66e889bc13fabf=
f8bec86856
        failing since 48 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

