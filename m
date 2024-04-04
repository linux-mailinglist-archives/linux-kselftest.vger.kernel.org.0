Return-Path: <linux-kselftest+bounces-7233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533A89924D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968D81C224CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5313C695;
	Thu,  4 Apr 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xglouu1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02213C68D
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274649; cv=none; b=dvafTIUfj9QymMIeRpCPnHZcXlE4GuDRg4caXGxZeHF0GCRAChiYbkd3L4zbmPMGBGnYRYSHCyYyPCKey3eXMz8NSCQJVqtYSHn4P3UAZzpqcH0nCh7cMbpwrIvpb4LplhdRY4AbVTlUTcsS4jE9/dDL6AZSz5OHW/2i0dT1ZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274649; c=relaxed/simple;
	bh=EFqTWF38ez1QF9Oq+MEvHf6I0wmBvXoRisI8ukVjm6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=QTpsE4j/z6u6DXpkEwiZLQtigR/wwPzFfjjmtcJwwBO/gt1I+WVlCYDJ5t7J02rkc9+bmEE18sB+QHCPoixRQpn1cVvD0oiNlG5MxZWJg6RnhW1YPTVzzzpH7LxQxtm6/qwWviZJ8uRsGN3ox7I1h1RpdvD8M/vHtawFq85zrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xglouu1u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0f3052145so15108965ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712274647; x=1712879447; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YHO51VRAlwoxCBQc9xbOlnMlelL1CknBRZDkbF6FH3s=;
        b=xglouu1uUjAQdfUbcQjcTt6q6pv/ZA/ckOqPOw9Q15ST3t9nD1MJOQeBpXJeDBMGzc
         a2qLIdrvsgwU/q7f1x4OLS3yga/EfwU0P2wb3mMZQsFHT01cHBOUmTUW06JWVD8youce
         9rcq1fBfjGZUTR8pPEAFSo01HrCbHt8oWbAgMkv5T0hutkYZqIO/E6DjlF8meEgIMLGF
         aLiVRY2GVAJMrcgiY7jg4Lt+cH9KazjOl3y8Cvc7zIpsuhm3Q38Dwn6ymcwX2mGMS3ry
         ziKT/8UnewLRHuyz3m3c7MOLD5CP4C24q6zyvMRNdsUK5SWWf0PWTc+TeNzBEMYWiUOW
         xBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274647; x=1712879447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHO51VRAlwoxCBQc9xbOlnMlelL1CknBRZDkbF6FH3s=;
        b=kdchjemJ42zLnroAyODivpHP/8urR/FomT4LUTTEqYFHNysZhKIggqeqLicngFYUdx
         BBQC1tW7p6cDoG57uu7AZ/J1wvp205J7b57IqXADjXD13c9C1ffK7869/tds3pAagaAj
         hprBx+dPl66pVGq+P+fO6T36Do9XMsNkTUJZrltyN8y8/Tqa4ohKGP3JzOJVWHcL22FQ
         wG4mMlGs43tyaMdWI9Qtzh64Siac7s700sznRbVRrt1+ZlOziTf2aDEm+VZMwPZGk4/d
         Fqva6jsjTdcJxWlvbrlU8rDTroUonOk8FvGDQJ1HL33WWy6uVQfhH5mwhwm+drQuivds
         cAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCLR5T5M89ULK0TTnlVn2T59ejJr7wKCXitbm8bzp7Yv+D/SlIaeTsK6mgC2vBAlCfd8ICC6Ul1xiMFe52NUMYYExddE+vEjb5eTQyBjbd
X-Gm-Message-State: AOJu0YyXW1PNM+OF8SGavb9Yl49jNzs7DbgpBMztpp71Bx8wIelViY54
	rtkjx+AyC7uxTNyAj/ceHGi4oQhbAcHNJaPeJa5/jR6/wCS3WOXUQHR7vE5zBqs=
X-Google-Smtp-Source: AGHT+IEf/8g2U1mTDaY0xazGLnoKes+wUYO2T54myEbw07GRNv++6bOmTRkWmQGdJMk9KRJXHumGhA==
X-Received: by 2002:a17:903:32c7:b0:1e2:6b8d:cdd8 with SMTP id i7-20020a17090332c700b001e26b8dcdd8mr4796956plr.37.1712274647432;
        Thu, 04 Apr 2024 16:50:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001ddc0bc5934sm199591plf.249.2024.04.04.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:50:47 -0700 (PDT)
Message-ID: <660f3cd7.170a0220.c17e5.120a@mx.google.com>
Date: Thu, 04 Apr 2024 16:50:47 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 1 runs,
 1 regressions (linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 1 runs, 1 regressions (linux_kselftest-fix=
es-6.9-rc2-2-g72d7cb5c190b)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      72d7cb5c190befbb095bae7737e71560ec0fcaa6 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f2f2000539701854c42e1

  Results:     62 PASS, 4 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2-2-g72d7cb5c190b/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2-2-g72d7cb5c190b/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_FORTIFY_MEM_OBJECT_sh: https://kernelci.org/test/=
case/id/660f2f2000539701854c42e6
        new failure (last pass: linux_kselftest-fixes-6.9-rc2) =

 =20

