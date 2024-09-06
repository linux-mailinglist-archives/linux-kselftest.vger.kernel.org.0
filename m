Return-Path: <linux-kselftest+bounces-17418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49896FC28
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383141C21130
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C31B85EA;
	Fri,  6 Sep 2024 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uiEswKOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381A1B85FB
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651055; cv=none; b=Jm3nTElBKerxa39Aw1acmXGZYJ949Q3MIvLRd6/5dr0tgD7l0lfuWtUeAFnCXNNgXMEKyAOj5A5DHJ+y3epDSS8NodrYjRlLfqi5pgXTc5G4Rcw27Hfja91Af83lu8+rFKrGkKIMeqrlGmCoxmxq+YOCXWNrqA55SjiM0k9kymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651055; c=relaxed/simple;
	bh=NwYOzSL+Y/iVs/Yyp7OQi+wiuPzh5AZhJocfP0InTvY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=NaE81H97E20Mbpiy82Vpmwj5+fPgTy8LeyslenFCjcGbjCOiuukWwqSIPvXqbSlwQLlaC0dUXqKw6m3Qqqnd3WxzKuQQaEz7L8CIvZpXMfyR7fEikXk+Z0gV8DXpsj8cHjBiUFUTQj2QpjOGOAiXvg6cMQp7tr3F6I0OB9FGqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uiEswKOb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2059204f448so22102595ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725651052; x=1726255852; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jF6YmQbSPWMeGJHpXG4OTry23IXs4axNIt+IAeQJ4J4=;
        b=uiEswKObcKpWEWJDGj6M2NUWG0vBQR7LBv6F6+ewRoih0vBgj4nbpIc/RWnm07cuNY
         xmFr0HEaED+9idZetqbPlm5Ys3OaM0tiI1gieKlNG5iG7BK3TDWalOweuXlLaCwhdPCd
         3iZINgPlyyac2cQZxMYTKksszYUXUP1ZK8PWaOaGtsGJ8oYXTyiS5gD44D+vGgWQDeYj
         /odvURkdTpnlNx+yEv6goaJILmH32rW06s73DiXX04efttVa2Oi+aoDeR4QsbdWEr/J3
         qCg/iPV11IyZHscEnwet1Gb/wjW3SoJgQDHW54y37kPasbCQ/tlHE8uQd65WpnwqFH6B
         8aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651052; x=1726255852;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF6YmQbSPWMeGJHpXG4OTry23IXs4axNIt+IAeQJ4J4=;
        b=Wm0gGQizBEWz7Ua4EtRVKB0VHBr7j/P52LaYJJFYapOKY0OpjcAZRHh+87w4nVQZI6
         lm8VGDus5sSmY/CaVc0+6+zHaEDJjFd+BCyyhiGkxA8r8zT7LRXkOPAqF/yka0VWkH9G
         dw/qqSt/2l3jzD3jHs0TAkcSSG1srU95n9E32zWUlZgIFZeFLqzskUvHxyCOmEmqBpbk
         PD5hgsRMqTth3ukwSvjHk8y0j+mU3VCBoK09GSjONFczfgcBu6fmJP8DMpz3ZmCuUthx
         pwJ3pT/TW3/U2roSehc5pGIj0fA4GNSLNys3zXObrOqvhELEZqjLOOW/hW4VaDNQoZjJ
         QJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeLLFsS/OpffG0r0iiZkGFpAN0r7ce2cjm8nF5sNicOIrKNotiJwYYBVQH1wP7x352OfFPke75sKx3/QqHlJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7awrvUkXGMq8yphU/Xiqt+mDky8itd3GxK+P4rYZCtEggvM//
	vcyalut9gdvevQMhnEMhOxJSGKXQ1bns1/MLe4jrWepC466dlBW7rhjykDWuYcg=
X-Google-Smtp-Source: AGHT+IFm0FO6b1FEwmKmAdT07XaznKaF/P+T4pA7IAUYb6zN3Pzp0f/k1OWpQxjq9SeSKircPnWXPw==
X-Received: by 2002:a17:902:f549:b0:202:5af:47fc with SMTP id d9443c01a7336-206f0511f66mr47506715ad.13.1725651052326;
        Fri, 06 Sep 2024 12:30:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea76213sm46625825ad.305.2024.09.06.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Message-ID: <66db586b.170a0220.1aa295.45ed@mx.google.com>
Date: Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-19-g7beaf1da074f7
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.11-rc1-19-g7beaf1da074f7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.11-rc1-19-g7beaf1=
da074f7)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-19-g7beaf1da074f7/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-19-g7beaf1da074f7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      7beaf1da074f7ea25454d6c11da142c3892d3c4e =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db55c87f15679370c8685b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66db55c87f1567=
9370c8685c
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

